*&---------------------------------------------------------------------*
*& Report ZDEMO_SECURE_DYNAMIC_EXCEL_TBL2
*&---------------------------------------------------------------------*
*& VERSION TBL2 - successor of ZDEMO_SECURE_DYNAMIC_EXCEL.
*&   Addresses every finding of ../zdemo_secure_dynamic_excel/REVIEW.md
*&   (H1-H4, M1-M7, L1-L9). CHANGES.md maps each finding to the code.
*&
*& PURPOSE
*&   Generic, metadata-driven upload of an .xlsx file into a customer
*&   (Z*/Y*) transparent table. Excel column headers must equal the
*&   technical field names of the target table (e.g. MATNR, WERKS).
*&
*& PROCESSING FLOW
*&   1. Validate target table: namespace, whitelist, DDIC status,
*&      delivery class, maintenance flag, client change settings,
*&      authorization
*&   2. Read DDIC field catalog of the target table
*&   3. Upload .xlsx from the presentation server (size limit)
*&   4. Read first worksheet and map header row -> DDIC fields
*&   5. Verify that every key field has a column in the file
*&   6. Convert and validate every data row in two passes
*&      (all fields, then currency amounts); row is rejected on error
*&   7. Determine which keys already exist in the database
*&   8. Test run : report only, nothing is written
*&      Live run : lock table, insert new rows in packages, one COMMIT
*&   9. Save the log in the application log (SLG1), show it in an ALV
*&
*& BEHAVIOUR / LIMITATIONS
*&   - Insert only. Rows whose key already exists in the DB are skipped
*&     and listed in the log (no update / modify).
*&   - Direct INSERT bypasses application logic (BAdIs, change
*&     documents, maintenance-view events). Use only for custom tables
*&     that have no such logic.
*&   - Data must start in cell A1 (row 1 = header). Row numbers in the
*&     log are the position in the worksheet table returned by the
*&     parser; avoid completely empty rows inside the data.
*&   - CL_FDT_XL_SPREADSHEET is not a released API. On S/4HANA 2022+
*&     replace read_worksheet by XCO_CP_XLSX (only that method changes).
*&   - Requires ABAP 7.55+ (PCRE regex, RAISE EXCEPTION NEW).
*&
*& OPTIONAL SETUP (recommended for production)
*&   - SLG0: create application log object ZUPLOAD (C_BAL_OBJECT).
*&     Without it the run works, but the log is not saved.
*&   - Whitelist table ZUPLOAD_ALLOWED (C_WHITELIST) with key field
*&     TABNAME. If the table exists, only tables listed in it can be
*&     loaded; if not, only the Z*/Y* namespace check applies.
*&   - Own transaction code with its own authorization check.
*&
*& CHANGE LOG TBL2 (IDs refer to REVIEW.md)
*&   H1  Conversion exits: ERROR_MESSAGE handled, message text logged
*&   H2  Length checked against OUTPUTLEN before an exit (LANG/ISOLA)
*&   H3  Empty key cells reject the row
*&   H4  Delivery class, maintenance flag, SCC4 settings, whitelist
*&   M1  CURR amounts shifted by the currency decimals (TCURX)
*&   M2  Integer time cells: 1-2 digits = hour, others rejected
*&   M3  Excel binary-double noise rounded to 15 significant digits
*&   M4  Test run checks keys that already exist in the database
*&   M5  Log saved in the application log (BAL)
*&   M6  File size and row limits
*&   M7  Row-number assumption documented (see limitations)
*&   L1  Exact in-file duplicate check (hashed table on key fields)
*&   L2  Year-like values (1900-2099) rejected as dates
*&   L3  Exception chain (PREVIOUS) shown in the log
*&   L4  Exit input passed as CHAR buffer, not as STRING
*&   L5  DB-level skips reported as "duplicate key or unique index"
*&   L6  Read / valid / inserted counts logged in live mode
*&   L7  Field warnings of a skipped duplicate row are dropped
*&   L8  Unused variable and misplaced ABAP Doc removed
*&   L9  Local unit tests (class LTC_IMPORTER)
*&---------------------------------------------------------------------*
REPORT zdemo_secure_dynamic_excel_tbl2.

CLASS ltc_importer DEFINITION DEFERRED.

*---------------------------------------------------------------------*
* CLASS lcx_error
*---------------------------------------------------------------------*
"! Application exception of the importer.
"! Carries a free-text message and optionally the original exception
"! (PREVIOUS) so the root cause is not lost.
CLASS lcx_error DEFINITION INHERITING FROM cx_static_check FINAL.
  PUBLIC SECTION.
    "! Creates the exception
    "! @parameter iv_text  | Message text returned by GET_TEXT
    "! @parameter previous | Original exception that caused this one
    METHODS constructor
      IMPORTING iv_text  TYPE string
                previous LIKE previous OPTIONAL.

    "! Returns the message text passed to the constructor
    METHODS if_message~get_text REDEFINITION.

  PRIVATE SECTION.
    "! Message text of this exception
    DATA mv_text TYPE string.
ENDCLASS.

CLASS lcx_error IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
    mv_text = iv_text.
  ENDMETHOD.

  METHOD if_message~get_text.
    result = mv_text.
  ENDMETHOD.
ENDCLASS.

*---------------------------------------------------------------------*
* CLASS lcl_excel_importer - DEFINITION
*---------------------------------------------------------------------*
"! Generic Excel (.xlsx) to database table importer.
"! Validates the target table, maps Excel headers to DDIC fields,
"! converts each cell according to its DDIC type, and inserts valid
"! rows. All findings are collected in a log, saved in the
"! application log and shown in an ALV.
CLASS lcl_excel_importer DEFINITION FINAL FRIENDS ltc_importer.
  PUBLIC SECTION.
    "! One entry of the result log
    TYPES: BEGIN OF ty_log,
             lights  TYPE char1,     " ALV traffic light: 1 = red, 2 = yellow, 3 = green
             row_idx TYPE i,         " Excel row number (0 = general message)
             type    TYPE symsgty,   " E = Error, W = Warning, S = Success, I = Info
             field   TYPE fieldname, " DDIC field concerned (empty if not field-related)
             message TYPE string,    " Message text
           END OF ty_log,
           "! Result log
           tt_log TYPE STANDARD TABLE OF ty_log WITH EMPTY KEY.

    "! Initialises the importer with the run parameters
    "! @parameter iv_file         | Full path of the .xlsx file on the PC
    "! @parameter iv_tabname      | Target table (must be Z*/Y*, transparent)
    "! @parameter iv_date_format  | Text date format: 'EU' = DD.MM.YYYY, 'US' = MM/DD/YYYY
    "! @parameter iv_test_mode    | abap_true = validate only, write nothing
    "! @parameter iv_package_size | Rows per array INSERT
    "! @parameter iv_max_mb       | Maximum file size in MB
    "! @parameter iv_allow_cust   | abap_true = Customizing tables (delivery class C/G) allowed
    METHODS constructor
      IMPORTING iv_file         TYPE string
                iv_tabname      TYPE tabname
                iv_date_format  TYPE char2     DEFAULT 'EU'
                iv_test_mode    TYPE abap_bool DEFAULT abap_true
                iv_package_size TYPE i         DEFAULT 5000
                iv_max_mb       TYPE i         DEFAULT 20
                iv_allow_cust   TYPE abap_bool DEFAULT abap_false.

    "! Executes the complete import and displays the log.
    "! Never raises: every error is written to the log.
    METHODS run.

    "! F4 help for the file parameter (file-open dialog)
    "! @parameter rv_file | Selected file path, initial if cancelled
    CLASS-METHODS f4_file
      RETURNING VALUE(rv_file) TYPE string.

  PRIVATE SECTION.
    "! Mapping of one Excel column to one DDIC field
    TYPES: BEGIN OF ty_col_map,
             excel_col TYPE i,               " Column position in the worksheet (1 = A)
             fieldname TYPE dfies-fieldname, " Target field name
             datatype  TYPE dfies-datatype,  " DDIC data type (CHAR, DATS, CURR, ...)
             inttype   TYPE dfies-inttype,   " ABAP internal type (C, N, D, T, P, I, ...)
             leng      TYPE dfies-leng,      " Internal length in characters / digits
             outputlen TYPE dfies-outputlen, " External length (input to a conversion exit)
             decimals  TYPE dfies-decimals,  " Number of decimal places
             keyflag   TYPE dfies-keyflag,   " 'X' = primary key field
             convexit  TYPE dfies-convexit,  " Conversion exit name (e.g. ALPHA)
             lowercase TYPE dfies-lowercase, " 'X' = domain allows lower case
             reftable  TYPE dfies-reftable,  " Table of the reference currency field (CURR)
             reffield  TYPE dfies-reffield,  " Reference currency field (CURR)
           END OF ty_col_map,
           "! Mapping of all recognised Excel columns
           tt_col_map    TYPE STANDARD TABLE OF ty_col_map WITH EMPTY KEY,
           "! Names of the key fields (client field excluded)
           tt_key_fields TYPE STANDARD TABLE OF fieldname WITH EMPTY KEY,
           "! Set of field names (fields filled in the current row)
           tt_field_set  TYPE HASHED TABLE OF fieldname WITH UNIQUE KEY table_line,
           "! Excel row number per accepted row (parallel to MR_TARGET)
           tt_rows       TYPE STANDARD TABLE OF i WITH EMPTY KEY,
           "! Amount cell kept for the second pass
           BEGIN OF ty_amount,
             map   TYPE ty_col_map, " Column/field mapping
             value TYPE string,     " Normalised cell text
           END OF ty_amount,
           tt_amounts TYPE STANDARD TABLE OF ty_amount WITH EMPTY KEY,
           "! Decimal places of a currency (cache of TCURX)
           BEGIN OF ty_currdec,
             waers   TYPE waers, " Currency key
             currdec TYPE i,     " Decimal places of the currency
           END OF ty_currdec,
           tt_currdec TYPE HASHED TABLE OF ty_currdec WITH UNIQUE KEY waers.

    CONSTANTS:
      "! Excel day 0 for serials >= 61 (compensates the 1900 leap-year bug)
      c_excel_epoch  TYPE d VALUE '18991230',
      "! First reliable Excel serial (01.03.1900)
      c_first_serial TYPE i VALUE 61,
      "! Last valid Excel serial (31.12.9999)
      c_max_serial   TYPE i VALUE 2958465,
      "! Seconds per day, used to convert Excel time fractions
      c_secs_per_day TYPE i VALUE 86400,
      "! Significant digits Excel keeps for a number
      c_excel_digits TYPE i VALUE 15,
      "! Largest integer written without exponent (fits P LENGTH 16)
      c_max_integer  TYPE decfloat34 VALUE '1E30',
      "! Maximum number of worksheet rows (header included)
      c_max_rows     TYPE i VALUE 500000,
      "! Application log object (create in SLG0)
      c_bal_object   TYPE balobj_d VALUE 'ZUPLOAD',
      "! Optional whitelist table, key field TABNAME
      c_whitelist    TYPE tabname VALUE 'ZUPLOAD_ALLOWED'.

    DATA:
      "! Full path of the source file
      mv_file          TYPE string,
      "! Target table name (upper case)
      mv_tabname       TYPE tabname,
      "! Text date format: 'EU' or 'US'
      mv_date_format   TYPE char2,
      "! abap_true = test run, nothing is written
      mv_test_mode     TYPE abap_bool,
      "! Rows per array INSERT
      mv_package_size  TYPE i,
      "! Maximum file size in MB
      mv_max_mb        TYPE i,
      "! abap_true = Customizing tables allowed
      mv_allow_cust    TYPE abap_bool,
      "! abap_true = target table is client-dependent
      mv_clidep        TYPE abap_bool,
      "! Collected log messages
      mt_log           TYPE tt_log,
      "! Messages of the row being processed (see add_log / flush_row_log)
      mt_row_buffer    TYPE tt_log,
      "! abap_true = row messages go to MT_ROW_BUFFER
      mv_buffering     TYPE abap_bool,
      "! DDIC field catalog of the target table (includes resolved)
      mt_fields        TYPE ddfields,
      "! Excel column -> DDIC field mapping
      mt_col_map       TYPE tt_col_map,
      "! Key field names (client excluded)
      mt_key_fields    TYPE tt_key_fields,
      "! HASHED TABLE OF <target table> WITH UNIQUE KEY <key fields>
      mo_key_type      TYPE REF TO cl_abap_tabledescr,
      "! Raw worksheet content (table of string columns A, B, C, ...)
      mr_raw           TYPE REF TO data,
      "! Converted, valid rows (STANDARD TABLE OF <target table>)
      mr_target        TYPE REF TO data,
      "! Excel row number of each line of MR_TARGET
      mt_target_rows   TYPE tt_rows,
      "! Currency decimals already read
      mt_currdec       TYPE tt_currdec,
      "! Number of rows accepted after validation
      mv_valid_rows    TYPE i,
      "! Number of rows rejected (conversion error or in-file duplicate)
      mv_error_rows    TYPE i,
      "! Number of valid rows whose key already exists in the database
      mv_existing_rows TYPE i.

    "! Appends a message to the log (to the row buffer while a row is processed)
    "! @parameter iv_row   | Excel row (0 = general)
    "! @parameter iv_type  | Message type E / W / S / I
    "! @parameter iv_field | Field concerned (optional)
    "! @parameter iv_msg   | Message text
    METHODS add_log
      IMPORTING iv_row   TYPE i DEFAULT 0
                iv_type  TYPE symsgty
                iv_field TYPE fieldname OPTIONAL
                iv_msg   TYPE string.

    "! Ends buffering of row messages
    "! @parameter iv_keep | abap_true = move them to the log, abap_false = drop them
    METHODS flush_row_log
      IMPORTING iv_keep TYPE abap_bool.

    "! Text of an exception including its PREVIOUS chain
    "! @parameter ix_error | Exception
    "! @parameter rv_text  | 'text (cause: text (cause: ...))'
    METHODS full_text
      IMPORTING ix_error       TYPE REF TO cx_root
      RETURNING VALUE(rv_text) TYPE string.

    "! Checks namespace, whitelist, DDIC status, delivery class and authorization
    METHODS validate_table
      RAISING lcx_error.

    "! If the whitelist table exists, the target table must be listed in it
    METHODS check_whitelist
      RAISING lcx_error.

    "! Checks maintenance flag, delivery class and client change settings
    "! @parameter iv_contflag | Delivery class (DD02L-CONTFLAG)
    "! @parameter iv_mainflag | Maintenance flag (DD02L-MAINFLAG)
    METHODS check_change_settings
      IMPORTING iv_contflag TYPE dd02l-contflag
                iv_mainflag TYPE dd02l-mainflag
      RAISING   lcx_error.

    "! Reads the DDIC field catalog and creates the target table
    METHODS load_field_catalog
      RAISING lcx_error.

    "! Uploads the file from the PC as binary
    "! @parameter rv_xstring | File content
    METHODS upload_file
      RETURNING VALUE(rv_xstring) TYPE xstring
      RAISING   lcx_error.

    "! Parses the .xlsx and stores the first worksheet in MR_RAW
    "! @parameter iv_xstring | File content
    METHODS read_worksheet
      IMPORTING iv_xstring TYPE xstring
      RAISING   lcx_error.

    "! Maps the header row (row 1) to DDIC fields -> MT_COL_MAP
    METHODS build_column_map
      RAISING lcx_error.

    "! Ensures every key field (except client) has a column in the file
    "! and creates the hashed key table type MO_KEY_TYPE
    METHODS check_key_coverage
      RAISING lcx_error.

    "! Converts all data rows into MR_TARGET, rejecting erroneous rows
    METHODS parse_rows
      RAISING lcx_error.

    "! Converts one cell into its target field (dispatch by internal type)
    "! @parameter iv_row    | Excel row (for warnings)
    "! @parameter is_map    | Column/field mapping
    "! @parameter iv_value  | Normalised cell text (not initial)
    "! @parameter cv_target | Target field of the work area
    METHODS convert_cell
      IMPORTING iv_row    TYPE i
                is_map    TYPE ty_col_map
                iv_value  TYPE string
      CHANGING  cv_target TYPE any
      RAISING   lcx_error.

    "! Converts text/serial into a date (YYYYMMDD)
    "! @parameter iv_value | Cell text
    "! @parameter rv_date  | Validated date
    METHODS convert_date
      IMPORTING iv_value       TYPE string
      RETURNING VALUE(rv_date) TYPE d
      RAISING   lcx_error.

    "! Converts text/Excel fraction into a time (HHMMSS)
    "! @parameter iv_value | Cell text
    "! @parameter rv_time  | Validated time
    METHODS convert_time
      IMPORTING iv_value       TYPE string
      RETURNING VALUE(rv_time) TYPE t
      RAISING   lcx_error.

    "! Parses a number; fractional values are rounded to Excel's 15 digits
    "! @parameter iv_value  | Cell text
    "! @parameter rv_number | Parsed value
    METHODS parse_number
      IMPORTING iv_value         TYPE string
      RETURNING VALUE(rv_number) TYPE decfloat34
      RAISING   lcx_error.

    "! Stores a number in a numeric field with overflow and rounding checks
    "! @parameter iv_number | Value to store
    "! @parameter iv_value  | Original cell text (for messages)
    METHODS store_number
      IMPORTING iv_row    TYPE i
                is_map    TYPE ty_col_map
                iv_number TYPE decfloat34
                iv_value  TYPE string
      CHANGING  cv_target TYPE any
      RAISING   lcx_error.

    "! Converts a CURR amount, shifting it by the currency decimals
    "! @parameter iv_currency | Reference currency of the row
    METHODS convert_amount
      IMPORTING iv_row      TYPE i
                is_map      TYPE ty_col_map
                iv_value    TYPE string
                iv_currency TYPE waers
      CHANGING  cv_target   TYPE any
      RAISING   lcx_error.

    "! Reads the reference currency of an amount field from the row
    "! @parameter is_row      | Converted work area
    "! @parameter rv_currency | Currency key
    METHODS get_reference_currency
      IMPORTING is_map             TYPE ty_col_map
                is_row             TYPE any
      RETURNING VALUE(rv_currency) TYPE waers
      RAISING   lcx_error.

    "! Decimal places of a currency (TCURX, default 2)
    "! @parameter iv_currency | Currency key
    "! @parameter rv_currdec  | Decimal places
    METHODS get_currency_decimals
      IMPORTING iv_currency       TYPE waers
      RETURNING VALUE(rv_currdec) TYPE i
      RAISING   lcx_error.

    "! External amount -> internal amount: amount * 10^(currdec - field decimals)
    "! (JPY, field with 2 decimals: 1000 -> 10.00)
    CLASS-METHODS shift_amount
      IMPORTING iv_amount          TYPE decfloat34
                iv_currdec         TYPE i
                iv_field_decimals  TYPE i
      RETURNING VALUE(rv_amount)   TYPE decfloat34.

    "! Moves text into a character field (case, length, conversion exit)
    METHODS convert_text
      IMPORTING iv_row    TYPE i
                is_map    TYPE ty_col_map
                iv_value  TYPE string
      CHANGING  cv_target TYPE any
      RAISING   lcx_error.

    "! Maximum input length: external length if an exit converts the value
    "! @parameter rv_length | Characters allowed in the cell (0 = unlimited)
    METHODS max_input_length
      IMPORTING is_map           TYPE ty_col_map
      RETURNING VALUE(rv_length) TYPE i.

    "! Rewrites the raw .xlsx form of a binary double as plain text
    "! ('1.2345678901234567E+19' -> '12345678901234600000',
    "!  '12.300000000000001' -> '12.3'); other values are returned unchanged
    "! @parameter iv_value | Cell text
    "! @parameter rv_text  | Plain text
    METHODS excel_number_to_text
      IMPORTING iv_value       TYPE string
      RETURNING VALUE(rv_text) TYPE string.

    "! Calls CONVERSION_EXIT_<name>_INPUT for the field
    METHODS apply_conversion_exit
      IMPORTING is_map    TYPE ty_col_map
                iv_value  TYPE string
      CHANGING  cv_target TYPE any
      RAISING   lcx_error.

    "! Replaces NBSP/tab/line breaks with blanks and trims both ends
    "! @parameter iv_value | Raw text
    "! @parameter rv_value | Cleaned text (internal spacing kept)
    METHODS normalize_value
      IMPORTING iv_value        TYPE string
      RETURNING VALUE(rv_value) TYPE string.

    "! Logs and removes rows whose key already exists in the database
    METHODS check_existing_keys
      RAISING lcx_error.

    "! Sets an exclusive lock on the whole target table
    METHODS lock_table
      RAISING lcx_error.

    "! Releases the table lock
    METHODS unlock_table.

    "! Inserts MR_TARGET in packages and commits once at the end
    METHODS write_to_db
      RAISING lcx_error.

    "! Saves the log in the application log (SLG1)
    METHODS save_application_log.

    "! Shows the log in an ALV grid (list output as fallback)
    METHODS show_log.
ENDCLASS.

*---------------------------------------------------------------------*
* Selection screen
*---------------------------------------------------------------------*
* Maintain selection texts via Goto > Text Elements > Selection Texts.
SELECTION-SCREEN BEGIN OF BLOCK b_src WITH FRAME.
  PARAMETERS:
    p_file  TYPE ibipparms-path OBLIGATORY,                          " Local .xlsx file (F4 = file dialog)
    p_tname TYPE tabname        OBLIGATORY DEFAULT 'ZCUSTOM_TARGET_TABLE'. " Target table (Z*/Y*)
SELECTION-SCREEN END OF BLOCK b_src.

SELECTION-SCREEN BEGIN OF BLOCK b_opt WITH FRAME.
  PARAMETERS:
    p_dfmt  TYPE char2 AS LISTBOX VISIBLE LENGTH 22
                       DEFAULT 'EU' OBLIGATORY,                      " Date format of text dates
    p_pack  TYPE i     DEFAULT 5000 OBLIGATORY,                      " Rows per array INSERT
    p_maxmb TYPE i     DEFAULT 20 OBLIGATORY,                        " Maximum file size in MB
    p_cust  AS CHECKBOX DEFAULT ' ',                                 " Allow Customizing tables (C/G)
    p_test  AS CHECKBOX DEFAULT 'X'.                                 " Test run (no DB write)
SELECTION-SCREEN END OF BLOCK b_opt.

*---------------------------------------------------------------------*
* INITIALIZATION - fill the date format listbox
*---------------------------------------------------------------------*
INITIALIZATION.
  DATA(gt_dfmt_values) = VALUE vrm_values(
    ( key = 'EU' text = 'DD.MM.YYYY (EU)' )
    ( key = 'US' text = 'MM/DD/YYYY (US)' ) ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_DFMT'
      values          = gt_dfmt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

*---------------------------------------------------------------------*
* F4 help for the file name
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  DATA(gv_selected_file) = lcl_excel_importer=>f4_file( ).
  IF gv_selected_file IS NOT INITIAL.
    p_file = gv_selected_file.
  ENDIF.

*---------------------------------------------------------------------*
* Input checks
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON p_pack.
  IF p_pack < 1 OR p_pack > 100000.
    MESSAGE 'Package size must be between 1 and 100000' TYPE 'E'.
  ENDIF.

AT SELECTION-SCREEN ON p_maxmb.
  IF p_maxmb < 1 OR p_maxmb > 1000.
    MESSAGE 'Maximum file size must be between 1 and 1000 MB' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Main
*---------------------------------------------------------------------*
START-OF-SELECTION.
  NEW lcl_excel_importer(
        iv_file         = CONV #( p_file )
        iv_tabname      = p_tname
        iv_date_format  = p_dfmt
        iv_test_mode    = p_test
        iv_package_size = p_pack
        iv_max_mb       = p_maxmb
        iv_allow_cust   = p_cust )->run( ).

*---------------------------------------------------------------------*
* CLASS lcl_excel_importer - IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_excel_importer IMPLEMENTATION.

  METHOD constructor.
    mv_file         = iv_file.
    mv_tabname      = to_upper( iv_tabname ).
    mv_date_format  = iv_date_format.
    mv_test_mode    = iv_test_mode.
    mv_package_size = COND #( WHEN iv_package_size > 0 THEN iv_package_size ELSE 5000 ).
    mv_max_mb       = COND #( WHEN iv_max_mb > 0 THEN iv_max_mb ELSE 20 ).
    mv_allow_cust   = iv_allow_cust.
  ENDMETHOD.


  METHOD f4_file.
    DATA: lt_files  TYPE filetable, " Files selected in the dialog
          lv_rc     TYPE i,         " Number of selected files / -1 on error
          lv_action TYPE i.         " User action (OK / Cancel)

    cl_gui_frontend_services=>file_open_dialog(
      EXPORTING
        window_title            = 'Select Excel file (.xlsx)'
        default_extension       = 'xlsx'
        file_filter             = 'Excel Files (*.xlsx)|*.xlsx'
        multiselection          = abap_false
      CHANGING
        file_table              = lt_files
        rc                      = lv_rc
        user_action             = lv_action
      EXCEPTIONS
        file_open_dialog_failed = 1
        cntl_error              = 2
        error_no_gui            = 3
        not_supported_by_gui    = 4
        OTHERS                  = 5 ).

    IF sy-subrc = 0
       AND lv_action = cl_gui_frontend_services=>action_ok
       AND lt_files IS NOT INITIAL.
      rv_file = lt_files[ 1 ]-filename.
    ENDIF.
  ENDMETHOD.


  METHOD run.
    DATA(lv_locked) = abap_false. " abap_true once the table lock is held

    TRY.
        validate_table( ).
        load_field_catalog( ).
        read_worksheet( upload_file( ) ).
        build_column_map( ).
        check_key_coverage( ).
        parse_rows( ).

        IF mv_test_mode = abap_true.
          check_existing_keys( ).
          add_log( iv_type = 'I'
                   iv_msg  = |TEST RUN: { mv_valid_rows - mv_existing_rows } row(s) would be inserted, | &&
                             |{ mv_existing_rows } already exist in the database, | &&
                             |{ mv_error_rows } row(s) rejected. Nothing was written.| ).
        ELSE.
          lock_table( ).
          lv_locked = abap_true.
          " Checked under the lock, so the result is still valid at INSERT
          check_existing_keys( ).
          write_to_db( ).
        ENDIF.

      CATCH lcx_error INTO DATA(lx_error).
        ROLLBACK WORK.
        flush_row_log( abap_true ).
        add_log( iv_type = 'E' iv_msg = full_text( lx_error ) ).

      CATCH cx_root INTO DATA(lx_root).
        " Safety net for unexpected (system) exceptions
        ROLLBACK WORK.
        flush_row_log( abap_true ).
        add_log( iv_type = 'E' iv_msg = |Unexpected error: { full_text( lx_root ) }| ).
    ENDTRY.

    IF lv_locked = abap_true.
      unlock_table( ).
    ENDIF.

    save_application_log( ).
    show_log( ).
  ENDMETHOD.


  METHOD add_log.
    DATA(ls_log) = VALUE ty_log( lights  = SWITCH #( iv_type WHEN 'E' THEN '1'
                                                             WHEN 'W' THEN '2'
                                                             ELSE '3' )
                                 row_idx = iv_row
                                 type    = iv_type
                                 field   = iv_field
                                 message = iv_msg ).

    " Row messages wait until the fate of the row is known
    IF mv_buffering = abap_true AND iv_row > 0.
      APPEND ls_log TO mt_row_buffer.
    ELSE.
      APPEND ls_log TO mt_log.
    ENDIF.
  ENDMETHOD.


  METHOD flush_row_log.
    IF iv_keep = abap_true.
      APPEND LINES OF mt_row_buffer TO mt_log.
    ENDIF.
    CLEAR mt_row_buffer.
    mv_buffering = abap_false.
  ENDMETHOD.


  METHOD full_text.
    rv_text = ix_error->get_text( ).

    DATA(lx_previous) = ix_error->previous. " Next exception in the chain
    WHILE lx_previous IS BOUND.
      rv_text = |{ rv_text } (cause: { lx_previous->get_text( ) })|.
      lx_previous = lx_previous->previous.
    ENDWHILE.
  ENDMETHOD.


  METHOD validate_table.
    " 1) Namespace restriction - never allow SAP standard tables
    IF mv_tabname IS INITIAL
       OR ( mv_tabname(1) <> 'Z' AND mv_tabname(1) <> 'Y' ).
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Table { mv_tabname } is not in the customer namespace (Z*/Y*).| ).
    ENDIF.

    " 2) Optional whitelist
    check_whitelist( ).

    " 3) Must be an active transparent table (views / pool / cluster
    "    tables cannot be filled with INSERT)
    SELECT SINGLE contflag, mainflag, clidep
      FROM dd02l
      WHERE tabname  = @mv_tabname
        AND as4local = 'A'
        AND as4vers  = '0000'
        AND tabclass = 'TRANSP'
      INTO @DATA(ls_dd02l).
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |{ mv_tabname } is not an active transparent table.| ).
    ENDIF.
    mv_clidep = xsdbool( ls_dd02l-clidep = abap_true ).

    " 4) The same controls SM30 respects
    check_change_settings( iv_contflag = ls_dd02l-contflag
                           iv_mainflag = ls_dd02l-mainflag ).

    " 5) Change authorization (S_TABU_DIS / S_TABU_NAM / S_TABU_CLI)
    CALL FUNCTION 'VIEW_AUTHORITY_CHECK'
      EXPORTING
        view_action                    = 'U'
        view_name                      = mv_tabname
        no_warning_for_clientindep     = abap_true
      EXCEPTIONS
        invalid_action                 = 1
        no_authority                   = 2
        no_clientindependent_authority = 3
        table_not_found                = 4
        no_linedependent_authority     = 5
        OTHERS                         = 6.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = SWITCH #( sy-subrc
                    WHEN 2 THEN |No change authorization for table { mv_tabname }.|
                    WHEN 3 THEN |No authorization for client-independent table { mv_tabname }.|
                    WHEN 5 THEN |No line-dependent authorization for table { mv_tabname }.|
                    ELSE        |Authorization check failed for { mv_tabname } (RC { sy-subrc }).| ) ).
    ENDIF.
  ENDMETHOD.


  METHOD check_whitelist.
    SELECT SINGLE @abap_true
      FROM dd02l
      WHERE tabname  = @c_whitelist
        AND as4local = 'A'
        AND as4vers  = '0000'
      INTO @DATA(lv_exists).
    IF sy-subrc <> 0.
      add_log( iv_type = 'W'
               iv_msg  = |Whitelist table { c_whitelist } does not exist - only the namespace check applies.| ).
      RETURN.
    ENDIF.

    TRY.
        SELECT SINGLE @abap_true
          FROM (c_whitelist)
          WHERE tabname = @mv_tabname
          INTO @DATA(lv_allowed).
      CATCH cx_sy_dynamic_osql_error INTO DATA(lx_sql).
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |Whitelist table { c_whitelist } could not be read (key field TABNAME expected).|
          previous = lx_sql ).
    ENDTRY.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Table { mv_tabname } is not released for upload in { c_whitelist }.| ).
    ENDIF.
  ENDMETHOD.


  METHOD check_change_settings.
    " Maintenance flag N = display/maintenance not allowed
    IF iv_mainflag = 'N'.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Maintenance of { mv_tabname } is not allowed (DD02L-MAINFLAG = N).| ).
    ENDIF.

    CASE iv_contflag.
      WHEN 'A' OR 'L'.
        " Application / temporary data - no transport involved
        RETURN.

      WHEN 'C' OR 'G'.
        " Customizing - only on request and only where SCC4 allows
        " changes without a transport
        IF mv_allow_cust = abap_false.
          RAISE EXCEPTION NEW lcx_error(
            iv_text = |{ mv_tabname } is a Customizing table (delivery class { iv_contflag }). | &&
                      |Select "Allow Customizing tables" to load it.| ).
        ENDIF.

        SELECT SINGLE cccoractiv, ccnocliind
          FROM t000
          WHERE mandt = @sy-mandt
          INTO @DATA(ls_t000).
        IF sy-subrc <> 0.
          RAISE EXCEPTION NEW lcx_error( iv_text = |Client { sy-mandt } not found in T000.| ).
        ENDIF.

        IF mv_clidep = abap_true.
          " ' ' = changes without automatic recording
          " '3' = changes without automatic recording, no transports
          " '1' = automatic recording, '2' = no changes allowed
          IF ls_t000-cccoractiv <> space AND ls_t000-cccoractiv <> '3'.
            RAISE EXCEPTION NEW lcx_error(
              iv_text = |Client { sy-mandt } does not allow Customizing changes without a transport (SCC4).| ).
          ENDIF.
        ELSE.
          " '1' = no cross-client Customizing changes, '3' = no changes at all
          IF ls_t000-ccnocliind = '1' OR ls_t000-ccnocliind = '3'.
            RAISE EXCEPTION NEW lcx_error(
              iv_text = |Client { sy-mandt } does not allow cross-client Customizing changes (SCC4).| ).
          ENDIF.
        ENDIF.

      WHEN OTHERS.
        " E, S, W = control / system data
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |Delivery class '{ iv_contflag }' of { mv_tabname } (system/control data) cannot be loaded.| ).
    ENDCASE.
  ENDMETHOD.


  METHOD load_field_catalog.
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname        = mv_tabname
        langu          = sy-langu
      TABLES
        dfies_tab      = mt_fields
      EXCEPTIONS
        not_found      = 1
        internal_error = 2
        OTHERS         = 3.

    IF sy-subrc <> 0 OR mt_fields IS INITIAL.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Field catalog of { mv_tabname } could not be read.| ).
    ENDIF.

    " Internal table with exactly the DB line type
    CREATE DATA mr_target TYPE STANDARD TABLE OF (mv_tabname).
  ENDMETHOD.


  METHOD upload_file.
    DATA: lt_solix TYPE solix_tab, " Binary file content
          lv_len   TYPE i.         " File length in bytes

    " GUI_UPLOAD needs a SAP GUI connection
    IF sy-batch = abap_true.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = 'Upload from PC is not possible in background processing.' ).
    ENDIF.

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename   = mv_file
        filetype   = 'BIN'
      IMPORTING
        filelength = lv_len
      TABLES
        data_tab   = lt_solix
      EXCEPTIONS
        OTHERS     = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error( iv_text = |File { mv_file } could not be uploaded.| ).
    ENDIF.
    IF lv_len = 0.
      RAISE EXCEPTION NEW lcx_error( iv_text = |File { mv_file } is empty.| ).
    ENDIF.
    " The parser expands the file many times in memory
    IF lv_len > mv_max_mb * 1024 * 1024.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |File { mv_file } is larger than { mv_max_mb } MB. Split it or raise the limit.| ).
    ENDIF.

    rv_xstring = cl_bcs_convert=>solix_to_xstring( it_solix = lt_solix
                                                   iv_size  = lv_len ).
  ENDMETHOD.


  METHOD read_worksheet.
    DATA lo_excel TYPE REF TO cl_fdt_xl_spreadsheet. " Parsed workbook
    FIELD-SYMBOLS <lt_raw> TYPE STANDARD TABLE.      " Worksheet rows

    " Only this method depends on the parser (see header: XCO_CP_XLSX)
    TRY.
        lo_excel = NEW #( document_name = mv_file
                          xdocument     = iv_xstring ).

        lo_excel->if_fdt_doc_spreadsheet~get_worksheet_names(
          IMPORTING worksheet_names = DATA(lt_sheets) ).
        IF lt_sheets IS INITIAL.
          RAISE EXCEPTION NEW lcx_error( iv_text = 'The workbook contains no worksheets.' ).
        ENDIF.

        " Only the first worksheet is processed
        mr_raw = lo_excel->if_fdt_doc_spreadsheet~get_itab_from_worksheet( lt_sheets[ 1 ] ).

      CATCH cx_fdt_excel_core INTO DATA(lx_excel).
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = 'File is not a readable .xlsx document.'
          previous = lx_excel ).
    ENDTRY.

    IF mr_raw IS NOT BOUND.
      RAISE EXCEPTION NEW lcx_error( iv_text = 'The first worksheet is empty.' ).
    ENDIF.

    ASSIGN mr_raw->* TO <lt_raw>.
    IF lines( <lt_raw> ) < 2.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = 'The worksheet needs a header row and at least one data row.' ).
    ENDIF.
    IF lines( <lt_raw> ) > c_max_rows.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |The worksheet has { lines( <lt_raw> ) } rows; the limit is { c_max_rows }. Split the file.| ).
    ENDIF.
  ENDMETHOD.


  METHOD build_column_map.
    FIELD-SYMBOLS <lt_raw> TYPE STANDARD TABLE. " Worksheet rows

    ASSIGN mr_raw->* TO <lt_raw>.
    ASSIGN <lt_raw>[ 1 ] TO FIELD-SYMBOL(<ls_header>).

    DO.
      DATA(lv_col) = sy-index. " Current column position
      ASSIGN COMPONENT lv_col OF STRUCTURE <ls_header> TO FIELD-SYMBOL(<lv_cell>).
      IF sy-subrc <> 0.
        EXIT. " No more columns
      ENDIF.

      " Trim first, then upper-case and replace invalid characters
      DATA(lv_hdr) = to_upper( normalize_value( CONV string( <lv_cell> ) ) ).
      IF lv_hdr IS INITIAL.
        CONTINUE. " Empty header cell - column ignored silently
      ENDIF.
      REPLACE ALL OCCURRENCES OF PCRE `[^A-Z0-9_/]` IN lv_hdr WITH `_`.

      READ TABLE mt_fields INTO DATA(ls_field) WITH KEY fieldname = lv_hdr.
      IF sy-subrc <> 0.
        add_log( iv_row = 1 iv_type = 'W'
                 iv_msg = |Column { lv_col }: '{ lv_hdr }' is not a field of { mv_tabname } - ignored.| ).
        CONTINUE.
      ENDIF.

      " Client is always the logon client (implicit client handling)
      IF ls_field-datatype = 'CLNT'.
        add_log( iv_row = 1 iv_type = 'W' iv_field = ls_field-fieldname
                 iv_msg = |Client column ignored - logon client { sy-mandt } is used.| ).
        CONTINUE.
      ENDIF.

      IF line_exists( mt_col_map[ fieldname = ls_field-fieldname ] ).
        add_log( iv_row = 1 iv_type = 'W' iv_field = ls_field-fieldname
                 iv_msg = |Column { lv_col }: duplicate header '{ lv_hdr }' - ignored.| ).
        CONTINUE.
      ENDIF.

      APPEND VALUE #( excel_col = lv_col
                      fieldname = ls_field-fieldname
                      datatype  = ls_field-datatype
                      inttype   = ls_field-inttype
                      leng      = ls_field-leng
                      outputlen = ls_field-outputlen
                      decimals  = ls_field-decimals
                      keyflag   = ls_field-keyflag
                      convexit  = ls_field-convexit
                      lowercase = ls_field-lowercase
                      reftable  = ls_field-reftable
                      reffield  = ls_field-reffield ) TO mt_col_map.
    ENDDO.

    IF mt_col_map IS INITIAL.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |No Excel header matches a field of { mv_tabname }.| ).
    ENDIF.
  ENDMETHOD.


  METHOD check_key_coverage.
    LOOP AT mt_fields INTO DATA(ls_field)
         WHERE keyflag  = abap_true
           AND datatype <> 'CLNT'.
      IF NOT line_exists( mt_col_map[ fieldname = ls_field-fieldname ] ).
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |Key field { ls_field-fieldname } has no column in the file.| ).
      ENDIF.
      APPEND ls_field-fieldname TO mt_key_fields.
    ENDLOOP.

    IF mt_key_fields IS INITIAL.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |{ mv_tabname } has no key field apart from the client.| ).
    ENDIF.

    " Hashed table on the key fields: exact duplicate detection, no
    " string building (used for the in-file and the database check)
    TRY.
        mo_key_type = cl_abap_tabledescr=>create(
          p_line_type  = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( mv_tabname ) )
          p_table_kind = cl_abap_tabledescr=>tablekind_hashed
          p_unique     = abap_true
          p_key        = VALUE #( FOR lv_kf IN mt_key_fields ( name = lv_kf ) ) ).
      CATCH cx_sy_table_creation INTO DATA(lx_rtts).
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |Key table type for { mv_tabname } could not be created.|
          previous = lx_rtts ).
    ENDTRY.
  ENDMETHOD.


  METHOD parse_rows.
    FIELD-SYMBOLS: <lt_raw>    TYPE STANDARD TABLE, " Worksheet rows
                   <lt_target> TYPE STANDARD TABLE, " Valid converted rows
                   <lt_seen>   TYPE HASHED TABLE.   " Rows accepted so far (by key)
    DATA: lr_row     TYPE REF TO data,  " Work area of the target table
          lr_seen    TYPE REF TO data,  " Hashed table of accepted rows
          lt_filled  TYPE tt_field_set, " Fields with a non-empty cell
          lt_amounts TYPE tt_amounts.   " Amount cells for the second pass

    ASSIGN mr_raw->* TO <lt_raw>.
    ASSIGN mr_target->* TO <lt_target>.
    CREATE DATA lr_row TYPE (mv_tabname).
    ASSIGN lr_row->* TO FIELD-SYMBOL(<ls_target>).
    CREATE DATA lr_seen TYPE HANDLE mo_key_type.
    ASSIGN lr_seen->* TO <lt_seen>.

    " Row 1 is the header
    LOOP AT <lt_raw> ASSIGNING FIELD-SYMBOL(<ls_raw>) FROM 2.
      DATA(lv_row)       = sy-tabix.    " Excel row number
      DATA(lv_row_error) = abap_false.  " At least one conversion error
      CLEAR: <ls_target>, lt_filled, lt_amounts.
      mv_buffering = abap_true.

      " First pass: every field except amounts
      LOOP AT mt_col_map INTO DATA(ls_map).
        ASSIGN COMPONENT ls_map-excel_col OF STRUCTURE <ls_raw> TO FIELD-SYMBOL(<lv_cell>).
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

        DATA(lv_value) = normalize_value( CONV string( <lv_cell> ) ).
        IF lv_value IS INITIAL.
          CONTINUE. " Empty cell -> field stays initial
        ENDIF.
        INSERT ls_map-fieldname INTO TABLE lt_filled.

        " Amounts need the converted currency of the row -> second pass
        IF ls_map-datatype = 'CURR'.
          APPEND VALUE #( map = ls_map value = lv_value ) TO lt_amounts.
          CONTINUE.
        ENDIF.

        ASSIGN COMPONENT ls_map-fieldname OF STRUCTURE <ls_target> TO FIELD-SYMBOL(<lv_target>).
        TRY.
            convert_cell( EXPORTING iv_row    = lv_row
                                    is_map    = ls_map
                                    iv_value  = lv_value
                          CHANGING  cv_target = <lv_target> ).
          CATCH lcx_error INTO DATA(lx_conv).
            lv_row_error = abap_true.
            add_log( iv_row = lv_row iv_type = 'E' iv_field = ls_map-fieldname
                     iv_msg = full_text( lx_conv ) ).
        ENDTRY.
      ENDLOOP.

      " Blank spreadsheet row
      IF lt_filled IS INITIAL.
        flush_row_log( abap_false ).
        CONTINUE.
      ENDIF.

      " Second pass: amounts, shifted by the decimals of their currency
      LOOP AT lt_amounts INTO DATA(ls_amount).
        ASSIGN COMPONENT ls_amount-map-fieldname OF STRUCTURE <ls_target> TO <lv_target>.
        TRY.
            DATA(lv_currency) = get_reference_currency( is_map = ls_amount-map
                                                        is_row = <ls_target> ).
            convert_amount( EXPORTING iv_row      = lv_row
                                      is_map      = ls_amount-map
                                      iv_value    = ls_amount-value
                                      iv_currency = lv_currency
                            CHANGING  cv_target   = <lv_target> ).
          CATCH lcx_error INTO lx_conv.
            lv_row_error = abap_true.
            add_log( iv_row = lv_row iv_type = 'E' iv_field = ls_amount-map-fieldname
                     iv_msg = full_text( lx_conv ) ).
        ENDTRY.
      ENDLOOP.

      " Every key field needs a value - an empty cell would create a
      " record with an initial key
      LOOP AT mt_key_fields INTO DATA(lv_keyfield).
        IF NOT line_exists( lt_filled[ table_line = lv_keyfield ] ).
          lv_row_error = abap_true.
          add_log( iv_row = lv_row iv_type = 'E' iv_field = lv_keyfield
                   iv_msg = 'Key field is empty.' ).
        ENDIF.
      ENDLOOP.

      " Any error rejects the complete row
      IF lv_row_error = abap_true.
        mv_error_rows = mv_error_rows + 1.
        add_log( iv_row = lv_row iv_type = 'E' iv_msg = 'Row rejected.' ).
        flush_row_log( abap_true ).
        CONTINUE.
      ENDIF.

      " In-file duplicate check on the converted key values
      INSERT <ls_target> INTO TABLE <lt_seen>.
      IF sy-subrc <> 0.
        mv_error_rows = mv_error_rows + 1.
        flush_row_log( abap_false ). " Field warnings of a skipped row are noise
        add_log( iv_row = lv_row iv_type = 'W'
                 iv_msg = 'Duplicate key within the file - row skipped (first occurrence kept).' ).
        CONTINUE.
      ENDIF.

      flush_row_log( abap_true ).
      APPEND <ls_target> TO <lt_target>.
      APPEND lv_row TO mt_target_rows.
      mv_valid_rows = mv_valid_rows + 1.
    ENDLOOP.
  ENDMETHOD.


  METHOD convert_cell.
    CASE is_map-inttype.
      WHEN 'D'.                                   " DATS
        cv_target = convert_date( iv_value ).

      WHEN 'T'.                                   " TIMS
        cv_target = convert_time( iv_value ).

      WHEN 'N'.                                   " NUMC
        " A numeric cell can arrive as '1.2345678901E+11'
        DATA(lv_digits) = excel_number_to_text( iv_value ).
        IF lv_digits CN '0123456789'.
          RAISE EXCEPTION NEW lcx_error( iv_text = |'{ iv_value }' contains non-digit characters.| ).
        ENDIF.
        DATA(lv_max) = max_input_length( is_map ).
        IF strlen( lv_digits ) > lv_max.
          RAISE EXCEPTION NEW lcx_error( iv_text = |'{ lv_digits }' exceeds { lv_max } digits.| ).
        ENDIF.
        IF is_map-convexit IS NOT INITIAL.
          apply_conversion_exit( EXPORTING is_map = is_map iv_value = lv_digits
                                 CHANGING  cv_target = cv_target ).
        ELSE.
          cv_target = lv_digits. " Right-aligned, zero-padded by conversion rules
        ENDIF.

      WHEN 'I' OR 'b' OR 's' OR '8'               " INT4, INT1, INT2, INT8
        OR 'P' OR 'F' OR 'a' OR 'e'.              " DEC/QUAN, FLTP, DECFLOAT16/34
        store_number( EXPORTING iv_row    = iv_row
                                is_map    = is_map
                                iv_number = parse_number( iv_value )
                                iv_value  = iv_value
                      CHANGING  cv_target = cv_target ).

      WHEN 'C' OR 'g'.                            " CHAR/CUKY/UNIT/LANG..., STRING/SSTRING
        convert_text( EXPORTING iv_row = iv_row is_map = is_map iv_value = iv_value
                      CHANGING  cv_target = cv_target ).

      WHEN OTHERS.                                " RAW, RAWSTRING, UTCLONG, ...
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |Data type { is_map-datatype } is not supported for upload.| ).
    ENDCASE.
  ENDMETHOD.


  METHOD convert_date.
    DATA: lv_day   TYPE string, " Day part
          lv_month TYPE string, " Month part
          lv_year  TYPE string. " Year part (4 digits)

    " Ignore an appended time portion, e.g. '15.01.2024 08:30'
    DATA(lv_date_part) = segment( val = iv_value index = 1 sep = ` ` ).

    IF lv_date_part CO '0123456789' AND strlen( lv_date_part ) = 8.
      " YYYYMMDD
      lv_year  = lv_date_part+0(4).
      lv_month = lv_date_part+4(2).
      lv_day   = lv_date_part+6(2).

    ELSEIF matches( val = lv_date_part pcre = `^(19|20)\d{2}$` ).
      " Would be read as an Excel serial in 1905 - almost always a year
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }' looks like a year, not a date. Enter the full date.| ).

    ELSEIF matches( val = lv_date_part pcre = `^\d+(\.\d+)?$` ).
      " Excel serial number; a fraction is the time of day and is ignored
      DATA(lv_days) = CONV i( trunc( CONV decfloat34( lv_date_part ) ) ).
      IF lv_days < c_first_serial OR lv_days > c_max_serial.
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |'{ iv_value }' is outside the supported Excel date range.| ).
      ENDIF.
      rv_date = c_excel_epoch + lv_days. " Fresh calculation per call
      RETURN.

    ELSEIF matches( val = lv_date_part pcre = `^\d{4}-\d{1,2}-\d{1,2}$` ).
      " ISO YYYY-MM-DD
      SPLIT lv_date_part AT '-' INTO lv_year lv_month lv_day.

    ELSEIF matches( val = lv_date_part pcre = `^\d{1,2}[./-]\d{1,2}[./-]\d{4}$` ).
      " DD.MM.YYYY (EU) or MM/DD/YYYY (US), any of . / - as separator
      DATA(lv_norm) = replace( val = lv_date_part pcre = `[./-]` with = `.` occ = 0 ).
      IF mv_date_format = 'US'.
        SPLIT lv_norm AT '.' INTO lv_month lv_day lv_year.
      ELSE.
        SPLIT lv_norm AT '.' INTO lv_day lv_month lv_year.
      ENDIF.

    ELSE.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }' is not a recognised date. Expected {
                  COND string( WHEN mv_date_format = 'US' THEN `MM/DD/YYYY` ELSE `DD.MM.YYYY` )
                  }, YYYY-MM-DD, YYYYMMDD or an Excel date.| ).
    ENDIF.

    rv_date = |{ lv_year }{ lv_month WIDTH = 2 ALIGN = RIGHT PAD = '0' }{ lv_day WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.

    " Reject impossible dates such as 31.02.2024 or month 13
    CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
      EXPORTING
        date                      = rv_date
      EXCEPTIONS
        plausibility_check_failed = 1
        OTHERS                    = 2.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error( iv_text = |'{ iv_value }' is not a valid calendar date.| ).
    ENDIF.
  ENDMETHOD.


  METHOD convert_time.
    DATA: lv_hh TYPE string, " Hours
          lv_mm TYPE string, " Minutes
          lv_ss TYPE string. " Seconds

    IF iv_value CO '0123456789' AND strlen( iv_value ) = 6.
      " HHMMSS
      lv_hh = iv_value+0(2).
      lv_mm = iv_value+2(2).
      lv_ss = iv_value+4(2).

    ELSEIF iv_value CO '0123456789' AND strlen( iv_value ) = 4.
      " HHMM
      lv_hh = iv_value+0(2).
      lv_mm = iv_value+2(2).

    ELSEIF iv_value CO '0123456789' AND strlen( iv_value ) <= 2.
      " HH - also an Excel time cell at midnight ('0')
      lv_hh = iv_value.

    ELSEIF matches( val = iv_value pcre = `^\d{1,2}:\d{2}(:\d{2})?$` ).
      " HH:MM or HH:MM:SS
      SPLIT iv_value AT ':' INTO lv_hh lv_mm lv_ss.

    ELSEIF matches( val = iv_value pcre = `^\d*\.\d+$` ).
      " Excel time = fraction of a day (0.5 = 12:00:00). The integer part
      " of a date-time serial is the date and is ignored here.
      DATA(lv_fraction) = frac( CONV decfloat34( iv_value ) ).
      DATA(lv_seconds)  = CONV i( round( val = lv_fraction * c_secs_per_day dec = 0 ) ).
      lv_seconds = lv_seconds MOD c_secs_per_day. " 23:59:59.6 rounds to 24:00 -> 00:00
      rv_time = '000000'.
      rv_time = rv_time + lv_seconds.
      RETURN.

    ELSE.
      " Includes 3- and 5-digit integers, which have no unambiguous meaning
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }' is not a recognised time (HH, HHMM, HHMMSS, HH:MM[:SS] or Excel time).| ).
    ENDIF.

    DATA(lv_h) = CONV i( lv_hh ).
    DATA(lv_m) = CONV i( lv_mm ). " Empty minutes -> 0
    DATA(lv_s) = CONV i( lv_ss ). " Empty seconds -> 0

    IF lv_h > 23 OR lv_m > 59 OR lv_s > 59.
      RAISE EXCEPTION NEW lcx_error( iv_text = |'{ iv_value }' is not a valid time of day.| ).
    ENDIF.

    rv_time = |{ lv_h WIDTH = 2 ALIGN = RIGHT PAD = '0' }{ lv_m WIDTH = 2 ALIGN = RIGHT PAD = '0' }{ lv_s WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.
  ENDMETHOD.


  METHOD parse_number.
    " Raw .xlsx numbers always use '.'; a comma means a text cell with
    " locale formatting, which is ambiguous (1,234 = 1234 or 1.234?)
    IF iv_value CA ','.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }': use '.' as decimal separator and no thousands separator.| ).
    ENDIF.

    " Parse - accepts sign and scientific notation (1.5E+3)
    TRY.
        rv_number = iv_value.
      CATCH cx_sy_conversion_no_number cx_sy_conversion_overflow INTO DATA(lx_parse).
        RAISE EXCEPTION NEW lcx_error( iv_text   = |'{ iv_value }' is not a valid number.|
                                       previous = lx_parse ).
    ENDTRY.

    " Excel stores binary doubles (12.3 -> 12.300000000000001). Keep the
    " 15 significant digits Excel itself shows. Integers are exact.
    IF iv_value CA '.eE'.
      rv_number = round( val = rv_number prec = c_excel_digits ).
    ENDIF.
  ENDMETHOD.


  METHOD store_number.
    DATA lv_back TYPE decfloat34. " Value after storing in the target field

    " Store - raises on overflow
    TRY.
        cv_target = iv_number.
      CATCH cx_sy_conversion_overflow cx_sy_arithmetic_overflow INTO DATA(lx_ovf).
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |'{ iv_value }' exceeds the field range (length { is_map-leng }, { is_map-decimals } decimals).|
          previous = lx_ovf ).
    ENDTRY.

    " Rounding check on numeric values (no text comparison -> no false
    " warnings for '1.5' vs '1.50'). FLTP is binary and always inexact.
    IF is_map-inttype <> 'F'.
      lv_back = cv_target.
      IF lv_back <> iv_number.
        add_log( iv_row = iv_row iv_type = 'W' iv_field = is_map-fieldname
                 iv_msg = |Value { iv_value } rounded to { lv_back } ({ is_map-decimals } decimals).| ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD convert_amount.
    DATA(lv_number)  = parse_number( iv_value ).
    DATA(lv_currdec) = get_currency_decimals( iv_currency ).

    " 1000.5 JPY cannot be represented
    IF round( val = lv_number dec = lv_currdec ) <> lv_number.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }' has more than { lv_currdec } decimal(s), the maximum for currency { iv_currency }.| ).
    ENDIF.

    store_number( EXPORTING iv_row    = iv_row
                            is_map    = is_map
                            iv_number = shift_amount( iv_amount         = lv_number
                                                      iv_currdec        = lv_currdec
                                                      iv_field_decimals = CONV #( is_map-decimals ) )
                            iv_value  = iv_value
                  CHANGING  cv_target = cv_target ).
  ENDMETHOD.


  METHOD get_reference_currency.
    IF is_map-reffield IS INITIAL.
      RAISE EXCEPTION NEW lcx_error( iv_text = 'Amount field has no reference currency field in the DDIC.' ).
    ENDIF.
    IF is_map-reftable <> mv_tabname.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Reference currency { is_map-reftable }-{ is_map-reffield } is in another table - | &&
                  |the amount cannot be converted.| ).
    ENDIF.

    ASSIGN COMPONENT is_map-reffield OF STRUCTURE is_row TO FIELD-SYMBOL(<lv_currency>).
    IF sy-subrc <> 0 OR <lv_currency> IS INITIAL.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Currency field { is_map-reffield } is empty - it is needed to store the amount.| ).
    ENDIF.
    rv_currency = <lv_currency>.
  ENDMETHOD.


  METHOD get_currency_decimals.
    READ TABLE mt_currdec INTO DATA(ls_currdec) WITH TABLE KEY waers = iv_currency.
    IF sy-subrc = 0.
      rv_currdec = ls_currdec-currdec.
      RETURN.
    ENDIF.

    SELECT SINGLE @abap_true
      FROM tcurc
      WHERE waers = @iv_currency
      INTO @DATA(lv_exists).
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error( iv_text = |Currency { iv_currency } does not exist.| ).
    ENDIF.

    " No TCURX entry = 2 decimals
    SELECT SINGLE currdec
      FROM tcurx
      WHERE currkey = @iv_currency
      INTO @DATA(lv_currdec).
    rv_currdec = COND #( WHEN sy-subrc = 0 THEN lv_currdec ELSE 2 ).

    INSERT VALUE #( waers = iv_currency currdec = rv_currdec ) INTO TABLE mt_currdec.
  ENDMETHOD.


  METHOD shift_amount.
    DATA(lv_shift) = iv_currdec - iv_field_decimals. " Decimal places to move

    rv_amount = iv_amount.
    DO abs( lv_shift ) TIMES.
      rv_amount = COND #( WHEN lv_shift > 0 THEN rv_amount * 10
                          ELSE                   rv_amount / 10 ).
    ENDDO.
  ENDMETHOD.


  METHOD convert_text.
    DATA(lv_text) = iv_value. " Working copy

    " A numeric cell arrives in its raw binary-double form
    DATA(lv_plain) = excel_number_to_text( lv_text ).
    IF lv_plain <> lv_text.
      add_log( iv_row = iv_row iv_type = 'W' iv_field = is_map-fieldname
               iv_msg = |Numeric cell { lv_text } stored as { lv_plain } - format the column as Text in Excel to keep the exact value.| ).
      lv_text = lv_plain.
    ENDIF.

    " Same behaviour as SM30: upper case unless the domain allows lower case
    IF is_map-lowercase = abap_false AND is_map-inttype = 'C'.
      lv_text = to_upper( lv_text ).
    ENDIF.

    " Length check against the external length when an exit converts the
    " value (SPRAS: 'EN' has 2 characters, the field 1)
    DATA(lv_max) = max_input_length( is_map ).
    IF lv_max > 0 AND strlen( lv_text ) > lv_max.
      IF is_map-keyflag = abap_true.
        " Truncating a key would silently create a different record
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |Key value '{ lv_text }' exceeds { lv_max } characters.| ).
      ENDIF.
      IF is_map-convexit IS NOT INITIAL.
        " A truncated external value converts to something else
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |'{ lv_text }' exceeds { lv_max } characters (conversion exit { is_map-convexit }).| ).
      ENDIF.
      add_log( iv_row = iv_row iv_type = 'W' iv_field = is_map-fieldname
               iv_msg = |Text exceeds { lv_max } characters and was truncated.| ).
      lv_text = substring( val = lv_text len = lv_max ).
    ENDIF.

    IF is_map-convexit IS NOT INITIAL.
      apply_conversion_exit( EXPORTING is_map = is_map iv_value = lv_text
                             CHANGING  cv_target = cv_target ).
    ELSE.
      cv_target = lv_text.
    ENDIF.
  ENDMETHOD.


  METHOD max_input_length.
    rv_length = COND #( WHEN is_map-convexit IS NOT INITIAL AND is_map-outputlen > 0
                        THEN is_map-outputlen
                        ELSE is_map-leng ).
  ENDMETHOD.


  METHOD excel_number_to_text.
    DATA lv_integer TYPE p LENGTH 16 DECIMALS 0. " Up to 31 digits, no exponent

    rv_text = iv_value.

    " Only the forms Excel writes for a binary double: mantissa with a
    " point and a signed exponent, or 15+ fractional digits. Codes such
    " as '1E5' or 'A-1.5' stay untouched.
    IF NOT matches( val = iv_value pcre = `^-?\d\.\d+E[+-]\d+$` )
       AND NOT matches( val = iv_value pcre = `^-?\d+\.\d{15,}$` ).
      RETURN.
    ENDIF.

    DATA(lv_number) = round( val = CONV decfloat34( iv_value ) prec = c_excel_digits ).

    IF frac( lv_number ) = 0 AND abs( lv_number ) < c_max_integer.
      lv_integer = lv_number.
      rv_text = |{ lv_integer }|.
    ELSE.
      rv_text = |{ lv_number STYLE = SIMPLE }|.
      " Remove trailing zeros of the fraction (not of an exponent form)
      IF rv_text CA '.' AND rv_text NA 'Ee'.
        rv_text = replace( val = rv_text pcre = `\.?0+$` with = `` ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD apply_conversion_exit.
    DATA: lv_fm  TYPE rs38l_fnam,   " Function module name of the exit
          lr_buf TYPE REF TO data.  " CHAR copy of the input

    lv_fm = |CONVERSION_EXIT_{ is_map-convexit }_INPUT|.

    " Exits are written for CHAR input and may use offset access, which
    " fails on a short STRING
    DATA(lv_len) = nmax( val1 = CONV i( is_map-outputlen )
                         val2 = strlen( iv_value )
                         val3 = 1 ).
    CREATE DATA lr_buf TYPE c LENGTH lv_len.
    ASSIGN lr_buf->* TO FIELD-SYMBOL(<lv_input>).
    <lv_input> = iv_value.

    TRY.
        CALL FUNCTION lv_fm
          EXPORTING
            input         = <lv_input>
          IMPORTING
            output        = cv_target
          EXCEPTIONS
            error_message = 1   " MESSAGE TYPE 'E' inside the exit - not covered by OTHERS
            OTHERS        = 2.
        CASE sy-subrc.
          WHEN 0.
          WHEN 1.
            MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
                    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                    INTO DATA(lv_message).
            RAISE EXCEPTION NEW lcx_error(
              iv_text = |'{ iv_value }' rejected by conversion exit { is_map-convexit }: { lv_message }| ).
          WHEN OTHERS.
            RAISE EXCEPTION NEW lcx_error(
              iv_text = |'{ iv_value }' rejected by conversion exit { is_map-convexit }.| ).
        ENDCASE.
      CATCH cx_sy_dyn_call_error INTO DATA(lx_call).
        " Exit missing or with an incompatible interface
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |Conversion exit { is_map-convexit } could not be called.|
          previous = lx_call ).
    ENDTRY.
  ENDMETHOD.


  METHOD normalize_value.
    rv_value = iv_value.
    " Non-breaking space (common in Excel), tab and line breaks -> blank
    REPLACE ALL OCCURRENCES OF PCRE `[\x{00A0}\t\r\n]` IN rv_value WITH ` `.
    " Trim both ends, keep internal spacing
    rv_value = shift_right( val = shift_left( val = rv_value ) ).
  ENDMETHOD.


  METHOD check_existing_keys.
    FIELD-SYMBOLS: <lt_target>   TYPE STANDARD TABLE, " Valid rows
                   <lt_existing> TYPE HASHED TABLE.   " Keys found in the DB
    DATA: lr_existing TYPE REF TO data, " Hashed table of existing keys
          lv_fields   TYPE string,      " Dynamic field list
          lv_where    TYPE string,      " Dynamic FOR ALL ENTRIES condition
          lt_delete   TYPE tt_rows.     " Indexes of rows to drop

    ASSIGN mr_target->* TO <lt_target>.
    IF <lt_target> IS INITIAL.
      RETURN. " FOR ALL ENTRIES with an empty table would read everything
    ENDIF.

    CREATE DATA lr_existing TYPE HANDLE mo_key_type.
    ASSIGN lr_existing->* TO <lt_existing>.

    LOOP AT mt_key_fields INTO DATA(lv_keyfield).
      IF lv_fields IS NOT INITIAL.
        lv_fields = |{ lv_fields }, |.
        lv_where  = |{ lv_where } AND |.
      ENDIF.
      lv_fields = |{ lv_fields }{ lv_keyfield }|.
      lv_where  = |{ lv_where }{ lv_keyfield } = @<lt_target>-{ lv_keyfield }|.
    ENDLOOP.

    TRY.
        SELECT (lv_fields)
          FROM (mv_tabname)
          FOR ALL ENTRIES IN @<lt_target>
          WHERE (lv_where)
          INTO CORRESPONDING FIELDS OF TABLE @<lt_existing>.
      CATCH cx_sy_dynamic_osql_error INTO DATA(lx_sql).
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |Existing keys of { mv_tabname } could not be read.|
          previous = lx_sql ).
    ENDTRY.

    IF <lt_existing> IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT <lt_target> ASSIGNING FIELD-SYMBOL(<ls_target>).
      DATA(lv_index) = sy-tabix. " Line in MR_TARGET / MT_TARGET_ROWS
      READ TABLE <lt_existing> FROM <ls_target> TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        add_log( iv_row  = mt_target_rows[ lv_index ]
                 iv_type = 'W'
                 iv_msg  = COND #( WHEN mv_test_mode = abap_true
                                   THEN `Key already exists in the database - row would be skipped.`
                                   ELSE `Key already exists in the database - row skipped.` ) ).
        APPEND lv_index TO lt_delete.
      ENDIF.
    ENDLOOP.

    mv_existing_rows = lines( lt_delete ).

    " Delete from the end so the remaining indexes stay valid
    SORT lt_delete DESCENDING.
    LOOP AT lt_delete INTO lv_index.
      DELETE <lt_target> INDEX lv_index.
      DELETE mt_target_rows INDEX lv_index.
    ENDLOOP.
  ENDMETHOD.


  METHOD lock_table.
    CALL FUNCTION 'ENQUEUE_E_TABLE'
      EXPORTING
        mode_rstable   = 'E'
        tabname        = mv_tabname
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = COND #( WHEN sy-subrc = 1
                          THEN |Table { mv_tabname } is locked by user { sy-msgv1 }.|
                          ELSE |Table { mv_tabname } could not be locked.| ) ).
    ENDIF.
  ENDMETHOD.


  METHOD unlock_table.
    CALL FUNCTION 'DEQUEUE_E_TABLE'
      EXPORTING
        mode_rstable = 'E'
        tabname      = mv_tabname.
  ENDMETHOD.


  METHOD write_to_db.
    FIELD-SYMBOLS: <lt_target>  TYPE STANDARD TABLE, " New valid rows
                   <lt_package> TYPE STANDARD TABLE. " Rows of the current package
    DATA: lr_package  TYPE REF TO data, " Package table
          lv_inserted TYPE i.           " Rows actually inserted (SY-DBCNT)

    add_log( iv_type = 'I'
             iv_msg  = |{ mv_valid_rows + mv_error_rows } row(s) read, { mv_valid_rows } valid, | &&
                       |{ mv_existing_rows } already in the database, { mv_error_rows } rejected.| ).
    IF mv_error_rows > 0.
      add_log( iv_type = 'W'
               iv_msg  = |{ mv_error_rows } row(s) rejected during validation (see row messages).| ).
    ENDIF.

    ASSIGN mr_target->* TO <lt_target>.
    IF <lt_target> IS INITIAL.
      add_log( iv_type = 'W' iv_msg = 'No new rows to insert.' ).
      RETURN.
    ENDIF.

    CREATE DATA lr_package TYPE STANDARD TABLE OF (mv_tabname).
    ASSIGN lr_package->* TO <lt_package>.

    DATA(lv_total) = lines( <lt_target> ). " Rows to insert
    DATA(lv_from)  = 1.                    " First row of current package

    " Packages limit the array size; one COMMIT at the end keeps the
    " load atomic (all or nothing).
    TRY.
        WHILE lv_from <= lv_total.
          DATA(lv_to) = nmin( val1 = lv_from + mv_package_size - 1
                              val2 = lv_total ).
          CLEAR <lt_package>.
          INSERT LINES OF <lt_target> FROM lv_from TO lv_to INTO TABLE <lt_package>.

          " Existing keys were removed under the lock; this only catches
          " unique secondary indexes (SY-SUBRC = 4), nothing is overwritten
          INSERT (mv_tabname) FROM TABLE @<lt_package> ACCEPTING DUPLICATE KEYS.
          lv_inserted = lv_inserted + sy-dbcnt.

          lv_from = lv_to + 1.
        ENDWHILE.

        COMMIT WORK.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql).
        ROLLBACK WORK.
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = 'Database error - nothing was written.'
          previous = lx_sql ).
    ENDTRY.

    add_log( iv_type = 'S'
             iv_msg  = |{ lv_inserted } row(s) inserted into { mv_tabname }.| ).
    IF lv_total - lv_inserted > 0.
      add_log( iv_type = 'W'
               iv_msg  = |{ lv_total - lv_inserted } row(s) skipped by the database (duplicate key or unique index).| ).
    ENDIF.
  ENDMETHOD.


  METHOD save_application_log.
    DATA: lv_handle  TYPE balloghndl, " Log handle
          lt_handles TYPE bal_t_logh, " Handles to save
          lv_text    TYPE c LENGTH 200. " Free-text message

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log      = VALUE bal_s_log(
                         object    = c_bal_object
                         extnumber = |{ mv_tabname }{ COND string( WHEN mv_test_mode = abap_true THEN ` TEST` ) }|
                         aluser    = sy-uname
                         alprog    = sy-repid )
      IMPORTING
        e_log_handle = lv_handle
      EXCEPTIONS
        OTHERS       = 1.
    IF sy-subrc <> 0.
      add_log( iv_type = 'W'
               iv_msg  = |Application log not saved - create object { c_bal_object } in SLG0.| ).
      RETURN.
    ENDIF.

    " Header line: who loaded what into which table
    DATA(lt_messages) = VALUE tt_log(
      ( type    = 'I'
        message = |User { sy-uname }, file { mv_file }, table { mv_tabname }, | &&
                  |{ COND string( WHEN mv_test_mode = abap_true THEN `test run` ELSE `live run` ) }| )
      ( LINES OF mt_log ) ).

    LOOP AT lt_messages INTO DATA(ls_log).
      lv_text = COND string( WHEN ls_log-row_idx > 0
                             THEN |Row { ls_log-row_idx } { ls_log-field }: | ) && ls_log-message.
      CALL FUNCTION 'BAL_LOG_MSG_ADD_FREE_TEXT'
        EXPORTING
          i_log_handle = lv_handle
          i_msgty      = ls_log-type
          i_text       = lv_text
        EXCEPTIONS
          OTHERS       = 1.
    ENDLOOP.

    INSERT lv_handle INTO TABLE lt_handles.
    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_t_log_handle = lt_handles
      EXCEPTIONS
        OTHERS         = 1.
    IF sy-subrc = 0.
      COMMIT WORK. " Data was already committed or rolled back
      add_log( iv_type = 'I'
               iv_msg  = |Log saved in the application log (SLG1, object { c_bal_object }).| ).
    ELSE.
      add_log( iv_type = 'W' iv_msg = 'Application log could not be saved.' ).
    ENDIF.
  ENDMETHOD.


  METHOD show_log.
    " Column heading definition for the ALV
    TYPES: BEGIN OF ty_heading,
             column TYPE lvc_fname, " ALV column name
             text   TYPE scrtext_m, " Heading text
           END OF ty_heading,
           tt_heading TYPE STANDARD TABLE OF ty_heading WITH EMPTY KEY.

    IF mt_log IS INITIAL.
      add_log( iv_type = 'I' iv_msg = 'No messages.' ).
    ENDIF.

    " General messages (row 0) first, then by row; original order kept
    SORT mt_log STABLE BY row_idx.

    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = DATA(lo_alv)
                                CHANGING  t_table      = mt_log ).

        lo_alv->get_functions( )->set_all( abap_true ).

        DATA(lo_columns) = lo_alv->get_columns( ).
        lo_columns->set_optimize( abap_true ).
        lo_columns->set_exception_column( 'LIGHTS' ).

        LOOP AT VALUE tt_heading( ( column = 'ROW_IDX' text = 'Excel Row' )
                                  ( column = 'TYPE'    text = 'Type' )
                                  ( column = 'FIELD'   text = 'Field' )
                                  ( column = 'MESSAGE' text = 'Message' ) )
             INTO DATA(ls_heading).
          DATA(lo_column) = lo_columns->get_column( ls_heading-column ).
          lo_column->set_short_text( CONV #( ls_heading-text ) ).
          lo_column->set_medium_text( ls_heading-text ).
          lo_column->set_long_text( CONV #( ls_heading-text ) ).
        ENDLOOP.

        lo_alv->get_display_settings( )->set_list_header(
          CONV #( |Import log: { mv_tabname }{ COND string( WHEN mv_test_mode = abap_true THEN ` (TEST RUN)` ) }| ) ).

        lo_alv->display( ).

      CATCH cx_salv_error.
        " Fallback: classic list output
        WRITE: / |Import log: { mv_tabname }|.
        ULINE.
        LOOP AT mt_log INTO DATA(ls_log).
          WRITE: / |[{ ls_log-type }] Row { ls_log-row_idx } { ls_log-field } { ls_log-message }|.
        ENDLOOP.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

*---------------------------------------------------------------------*
* CLASS ltc_importer - unit tests of the conversion logic
*---------------------------------------------------------------------*
* Run with Ctrl+Shift+F10 (SE80/ADT). Covers the edge cases of
* REVIEW.md; parse_rows / DB access need a real table and are not
* covered here.
CLASS ltc_importer DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO lcl_excel_importer. " Class under test (EU dates)

    METHODS setup.

    METHODS date_formats         FOR TESTING RAISING lcx_error.
    METHODS date_us_format       FOR TESTING RAISING lcx_error.
    METHODS date_rejects_invalid FOR TESTING.
    METHODS time_formats         FOR TESTING RAISING lcx_error.
    METHODS time_rejects_invalid FOR TESTING.
    METHODS number_excel_noise   FOR TESTING RAISING lcx_error.
    METHODS number_rejects_comma FOR TESTING.
    METHODS excel_number_text    FOR TESTING.
    METHODS amount_shift         FOR TESTING.
    METHODS text_isola_exit      FOR TESTING RAISING lcx_error.
    METHODS text_key_too_long    FOR TESTING.
    METHODS normalize            FOR TESTING.

    "! Asserts that convert_date raises lcx_error
    METHODS assert_date_rejected IMPORTING iv_value TYPE string.
    "! Asserts that convert_time raises lcx_error
    METHODS assert_time_rejected IMPORTING iv_value TYPE string.
ENDCLASS.

CLASS ltc_importer IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( iv_file = `test.xlsx` iv_tabname = 'ZTEST' ).
  ENDMETHOD.


  METHOD date_formats.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `15.01.2024` )       exp = '20240115' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `5/1/2024` )         exp = '20240105' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `2024-1-5` )         exp = '20240105' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `20240115` )         exp = '20240115' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `45306` )            exp = '20240115' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `45306.75` )         exp = '20240115' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_date( `15.01.2024 08:30` ) exp = '20240115' ).
  ENDMETHOD.


  METHOD date_us_format.
    DATA(lo_us) = NEW lcl_excel_importer( iv_file = `test.xlsx` iv_tabname = 'ZTEST' iv_date_format = 'US' ).
    cl_abap_unit_assert=>assert_equals( act = lo_us->convert_date( `01/15/2024` ) exp = '20240115' ).
  ENDMETHOD.


  METHOD date_rejects_invalid.
    assert_date_rejected( `31.02.2024` ). " Impossible date
    assert_date_rejected( `2024` ).       " Year, not a serial (L2)
    assert_date_rejected( `60` ).         " Excel's fictitious 29.02.1900
    assert_date_rejected( `15.01.24` ).   " Two-digit year
  ENDMETHOD.


  METHOD time_formats.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_time( `0.5` )      exp = '120000' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_time( `8` )        exp = '080000' ). " M2
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_time( `0` )        exp = '000000' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_time( `14:30` )    exp = '143000' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_time( `143005` )   exp = '143005' ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->convert_time( `0.999999` ) exp = '000000' ). " Rounds to 24:00
  ENDMETHOD.


  METHOD time_rejects_invalid.
    assert_time_rejected( `123` ).   " M2: was silently 00:00:00
    assert_time_rejected( `12345` ).
    assert_time_rejected( `25:00` ).
  ENDMETHOD.


  METHOD number_excel_noise.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->parse_number( `12.300000000000001` )
                                        exp = CONV decfloat34( '12.3' ) ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->parse_number( `1.5E+3` )
                                        exp = CONV decfloat34( '1500' ) ).
    " Integers stay exact (INT8 range)
    cl_abap_unit_assert=>assert_equals( act = mo_cut->parse_number( `9223372036854775807` )
                                        exp = CONV decfloat34( '9223372036854775807' ) ).
  ENDMETHOD.


  METHOD number_rejects_comma.
    TRY.
        mo_cut->parse_number( `1,5` ).
        cl_abap_unit_assert=>fail( msg = `'1,5' must be rejected` ).
      CATCH lcx_error ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.


  METHOD excel_number_text.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->excel_number_to_text( `1.2345678901234567E+19` )
                                        exp = `12345678901234600000` ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->excel_number_to_text( `12.300000000000001` )
                                        exp = `12.3` ).
    " Values that are not raw doubles stay unchanged
    cl_abap_unit_assert=>assert_equals( act = mo_cut->excel_number_to_text( `1E5` )   exp = `1E5` ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->excel_number_to_text( `A-1.5` ) exp = `A-1.5` ).
    cl_abap_unit_assert=>assert_equals( act = mo_cut->excel_number_to_text( `12.5` )  exp = `12.5` ).
  ENDMETHOD.


  METHOD amount_shift.
    " JPY (0 decimals) in a field with 2 decimals: 1000 -> 10.00
    cl_abap_unit_assert=>assert_equals(
      act = lcl_excel_importer=>shift_amount( iv_amount = CONV #( '1000' ) iv_currdec = 0 iv_field_decimals = 2 )
      exp = CONV decfloat34( '10' ) ).
    " KWD (3 decimals): 1.234 -> 12.34
    cl_abap_unit_assert=>assert_equals(
      act = lcl_excel_importer=>shift_amount( iv_amount = CONV #( '1.234' ) iv_currdec = 3 iv_field_decimals = 2 )
      exp = CONV decfloat34( '12.34' ) ).
    " EUR (2 decimals): unchanged
    cl_abap_unit_assert=>assert_equals(
      act = lcl_excel_importer=>shift_amount( iv_amount = CONV #( '12.5' ) iv_currdec = 2 iv_field_decimals = 2 )
      exp = CONV decfloat34( '12.5' ) ).
  ENDMETHOD.


  METHOD text_isola_exit.
    " H2: 'EN' is 2 characters, SPRAS 1 - the exit converts it to 'E'
    DATA lv_langu TYPE spras.

    mo_cut->convert_text(
      EXPORTING iv_row    = 2
                is_map    = VALUE #( fieldname = 'LANGU' datatype = 'LANG' inttype = 'C'
                                     leng = 1 outputlen = 2 convexit = 'ISOLA' )
                iv_value  = `EN`
      CHANGING  cv_target = lv_langu ).

    cl_abap_unit_assert=>assert_equals( act = lv_langu exp = 'E' ).
  ENDMETHOD.


  METHOD text_key_too_long.
    DATA lv_target TYPE c LENGTH 4.

    TRY.
        mo_cut->convert_text(
          EXPORTING iv_row    = 2
                    is_map    = VALUE #( fieldname = 'WERKS' datatype = 'CHAR' inttype = 'C'
                                         leng = 4 outputlen = 4 keyflag = abap_true )
                    iv_value  = `10001`
          CHANGING  cv_target = lv_target ).
        cl_abap_unit_assert=>fail( msg = `An over-long key must be rejected, not truncated` ).
      CATCH lcx_error ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.


  METHOD normalize.
    DATA(lv_raw) = cl_abap_conv_in_ce=>uccp( '00A0' ) && `  A  B ` && |\t|.
    cl_abap_unit_assert=>assert_equals( act = mo_cut->normalize_value( lv_raw ) exp = `A  B` ).
  ENDMETHOD.


  METHOD assert_date_rejected.
    TRY.
        mo_cut->convert_date( iv_value ).
        cl_abap_unit_assert=>fail( msg = |'{ iv_value }' must be rejected as a date| ).
      CATCH lcx_error ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.


  METHOD assert_time_rejected.
    TRY.
        mo_cut->convert_time( iv_value ).
        cl_abap_unit_assert=>fail( msg = |'{ iv_value }' must be rejected as a time| ).
      CATCH lcx_error ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

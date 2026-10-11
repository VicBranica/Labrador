*&---------------------------------------------------------------------*
*& Report ZDEMO_SECURE_DYNAMIC_EXCEL
*&---------------------------------------------------------------------*
*& PURPOSE
*&   Generic, metadata-driven upload of an .xlsx file into a customer
*&   (Z*/Y*) transparent table. Excel column headers must equal the
*&   technical field names of the target table (e.g. MATNR, WERKS).
*&
*& PROCESSING FLOW
*&   1. Validate target table (namespace, DDIC status, authorization)
*&   2. Read DDIC field catalog of the target table
*&   3. Upload .xlsx from the presentation server
*&   4. Read first worksheet and map header row -> DDIC fields
*&   5. Verify that every key field has a column in the file
*&   6. Convert and validate every data row (row is rejected on error)
*&   7. Test run : report only, nothing is written
*&      Live run : lock table, insert in packages, single COMMIT
*&   8. Display result log in an ALV grid
*&
*& BEHAVIOUR / LIMITATIONS
*&   - Insert only. Rows whose key already exists in the DB are skipped
*&     and counted in the log (no update / modify).
*&   - Direct INSERT bypasses application logic (BAdIs, change
*&     documents, maintenance-view events). Use only for custom tables
*&     that have no such logic.
*&   - CURR fields are stored as entered. Currency-dependent decimal
*&     shifting (e.g. JPY) is NOT applied - see convert_number.
*&   - Requires ABAP 7.55+ (PCRE regex, RAISE EXCEPTION NEW).
*&     On older releases replace PCRE with REGEX / CREATE OBJECT.
*&
*& CHANGE LOG (IDs refer to the audit matrix)
*&   C-1  Column map typed with DFIES components
*&   C-2  Invalid inline declaration "DATA(x) TYPE d VALUE" removed
*&   C-3  INTO clause moved to end of SELECT
*&   C-4  POSIX REGEX replaced by PCRE
*&   L-1  Excel serial dates computed from a constant epoch (no carry-over)
*&   L-2  Duplicate key held in a STRING (was CHAR 1)
*&   L-3  Separate row error flag - rows with any error are rejected
*&   L-4  DDIC conversion exits (ALPHA, MATN1, CUNIT, ...) applied
*&   L-5  Excel time fractions converted to HHMMSS
*&   L-6  Type dispatch by internal type (CASE) instead of "CA"
*&   L-7  Robust date parsing + plausibility check
*&   L-8  All key fields must be present as columns
*&   L-9  In-file duplicate check uses converted values
*&   L-11 Inserted count taken from SY-DBCNT
*&   L-12 Headers trimmed before normalisation
*&   S-1  Customer namespace restriction (Z*/Y*)
*&   S-2  Only active transparent tables accepted
*&   S-3  Table lock (ENQUEUE_E_TABLE) during write
*&   S-5  Test-run mode (default ON)
*&   S-6  Date format as listbox (EU/US only)
*&   R-1  Package-wise array insert
*&   R-3  Exception chaining via PREVIOUS
*&   R-5  ALV log with traffic lights
*&   NEW  SSTRING check used datatype 'SSTRING' (never matches - DDIC
*&        uses 'SSTR'); replaced by internal-type dispatch
*&   NEW  CHAR truncation now logged (error for key fields)
*&   NEW  Uppercase conversion for domains without lowercase flag
*&---------------------------------------------------------------------*
REPORT zdemo_secure_dynamic_excel.

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
"! rows. All findings are collected in a log and shown in an ALV.
CLASS lcl_excel_importer DEFINITION FINAL.
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
    METHODS constructor
      IMPORTING iv_file         TYPE string
                iv_tabname      TYPE tabname
                iv_date_format  TYPE char2     DEFAULT 'EU'
                iv_test_mode    TYPE abap_bool DEFAULT abap_true
                iv_package_size TYPE i         DEFAULT 5000.

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
             leng      TYPE dfies-leng,      " Field length in characters / digits
             decimals  TYPE dfies-decimals,  " Number of decimal places
             keyflag   TYPE dfies-keyflag,   " 'X' = primary key field
             convexit  TYPE dfies-convexit,  " Conversion exit name (e.g. ALPHA)
             lowercase TYPE dfies-lowercase, " 'X' = domain allows lower case
           END OF ty_col_map,
           "! Mapping of all recognised Excel columns
           tt_col_map    TYPE STANDARD TABLE OF ty_col_map WITH EMPTY KEY,
           "! Key strings already seen in the file (in-file duplicate check)
           tt_seen_keys  TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line,
           "! Names of the key fields (client field excluded)
           tt_key_fields TYPE STANDARD TABLE OF fieldname WITH EMPTY KEY.

    CONSTANTS:
      "! Excel day 0 for serials >= 61 (compensates the 1900 leap-year bug)
      c_excel_epoch  TYPE d VALUE '18991230',
      "! First reliable Excel serial (01.03.1900)
      c_first_serial TYPE i VALUE 61,
      "! Last valid Excel serial (31.12.9999)
      c_max_serial   TYPE i VALUE 2958465,
      "! Seconds per day, used to convert Excel time fractions
      c_secs_per_day TYPE i VALUE 86400.

    DATA:
      "! Full path of the source file
      mv_file         TYPE string,
      "! Target table name (upper case)
      mv_tabname      TYPE tabname,
      "! Text date format: 'EU' or 'US'
      mv_date_format  TYPE char2,
      "! abap_true = test run, nothing is written
      mv_test_mode    TYPE abap_bool,
      "! Rows per array INSERT
      mv_package_size TYPE i,
      "! Collected log messages
      mt_log          TYPE tt_log,
      "! DDIC field catalog of the target table (includes resolved)
      mt_fields       TYPE ddfields,
      "! Excel column -> DDIC field mapping
      mt_col_map      TYPE tt_col_map,
      "! Key field names used for the in-file duplicate check
      mt_key_fields   TYPE tt_key_fields,
      "! Raw worksheet content (table of string columns A, B, C, ...)
      mr_raw          TYPE REF TO data,
      "! Converted, valid rows (STANDARD TABLE OF <target table>)
      mr_target       TYPE REF TO data,
      "! Number of rows accepted for insert
      mv_valid_rows   TYPE i,
      "! Number of rows rejected (conversion error or in-file duplicate)
      mv_error_rows   TYPE i.

    "! Appends a message to the log
    "! @parameter iv_row   | Excel row (0 = general)
    "! @parameter iv_type  | Message type E / W / S / I
    "! @parameter iv_field | Field concerned (optional)
    "! @parameter iv_msg   | Message text
    METHODS add_log
      IMPORTING iv_row   TYPE i DEFAULT 0
                iv_type  TYPE symsgty
                iv_field TYPE fieldname OPTIONAL
                iv_msg   TYPE string.

    "! Checks namespace, DDIC status and change authorization of the table
    METHODS validate_table
      RAISING lcx_error.

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

    "! Converts text into a numeric field with overflow and rounding checks
    METHODS convert_number
      IMPORTING iv_row    TYPE i
                is_map    TYPE ty_col_map
                iv_value  TYPE string
      CHANGING  cv_target TYPE any
      RAISING   lcx_error.

    "! Moves text into a character field (case, length, conversion exit)
    METHODS convert_text
      IMPORTING iv_row    TYPE i
                is_map    TYPE ty_col_map
                iv_value  TYPE string
      CHANGING  cv_target TYPE any
      RAISING   lcx_error.

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

    "! Builds a string from the converted key fields of a row
    "! @parameter is_row | Converted work area
    "! @parameter rv_key | Concatenated key, '|' separated
    METHODS build_row_key
      IMPORTING is_row        TYPE any
      RETURNING VALUE(rv_key) TYPE string.

    "! Sets an exclusive lock on the whole target table
    METHODS lock_table
      RAISING lcx_error.

    "! Releases the table lock
    METHODS unlock_table.

    "! Inserts MR_TARGET in packages and commits once at the end
    METHODS write_to_db
      RAISING lcx_error.

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
    p_dfmt TYPE char2 AS LISTBOX VISIBLE LENGTH 22
                      DEFAULT 'EU' OBLIGATORY,                       " Date format of text dates
    p_pack TYPE i     DEFAULT 5000 OBLIGATORY,                       " Rows per array INSERT
    p_test AS CHECKBOX DEFAULT 'X'.                                  " Test run (no DB write)
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

*---------------------------------------------------------------------*
* Main
*---------------------------------------------------------------------*
START-OF-SELECTION.
  NEW lcl_excel_importer(
        iv_file         = CONV #( p_file )
        iv_tabname      = p_tname
        iv_date_format  = p_dfmt
        iv_test_mode    = p_test
        iv_package_size = p_pack )->run( ).

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
          add_log( iv_type = 'I'
                   iv_msg  = |TEST RUN: { mv_valid_rows } row(s) valid, { mv_error_rows } row(s) rejected. Nothing was written.| ).
        ELSE.
          lock_table( ).
          lv_locked = abap_true.
          write_to_db( ).
        ENDIF.

      CATCH lcx_error INTO DATA(lx_error).
        ROLLBACK WORK.
        add_log( iv_type = 'E' iv_msg = lx_error->get_text( ) ).

      CATCH cx_root INTO DATA(lx_root).
        " Safety net for unexpected (system) exceptions
        ROLLBACK WORK.
        add_log( iv_type = 'E' iv_msg = |Unexpected error: { lx_root->get_text( ) }| ).
    ENDTRY.

    IF lv_locked = abap_true.
      unlock_table( ).
    ENDIF.

    show_log( ).
  ENDMETHOD.


  METHOD add_log.
    APPEND VALUE #( lights  = SWITCH #( iv_type WHEN 'E' THEN '1'
                                                WHEN 'W' THEN '2'
                                                ELSE '3' )
                    row_idx = iv_row
                    type    = iv_type
                    field   = iv_field
                    message = iv_msg ) TO mt_log.
  ENDMETHOD.


  METHOD validate_table.
    " 1) Namespace restriction - never allow SAP standard tables.
    "    Replace by a configuration whitelist if needed.
    IF mv_tabname IS INITIAL
       OR ( mv_tabname(1) <> 'Z' AND mv_tabname(1) <> 'Y' ).
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |Table { mv_tabname } is not in the customer namespace (Z*/Y*).| ).
    ENDIF.

    " 2) Must be an active transparent table (views / pool / cluster
    "    tables cannot be filled with INSERT)
    SELECT SINGLE tabname
      FROM dd02l
      WHERE tabname  = @mv_tabname
        AND as4local = 'A'
        AND as4vers  = '0000'
        AND tabclass = 'TRANSP'
      INTO @DATA(lv_tabname).
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |{ mv_tabname } is not an active transparent table.| ).
    ENDIF.

    " 3) Change authorization (S_TABU_DIS / S_TABU_NAM / S_TABU_CLI)
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

    rv_xstring = cl_bcs_convert=>solix_to_xstring( it_solix = lt_solix
                                                   iv_size  = lv_len ).
  ENDMETHOD.


  METHOD read_worksheet.
    DATA lo_excel TYPE REF TO cl_fdt_xl_spreadsheet. " Parsed workbook
    FIELD-SYMBOLS <lt_raw> TYPE STANDARD TABLE.      " Worksheet rows

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
          iv_text  = |File is not a readable .xlsx document: { lx_excel->get_text( ) }|
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
                      decimals  = ls_field-decimals
                      keyflag   = ls_field-keyflag
                      convexit  = ls_field-convexit
                      lowercase = ls_field-lowercase ) TO mt_col_map.
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
  ENDMETHOD.


  METHOD parse_rows.
    FIELD-SYMBOLS: <lt_raw>    TYPE STANDARD TABLE, " Worksheet rows
                   <lt_target> TYPE STANDARD TABLE. " Valid converted rows
    DATA: lr_row       TYPE REF TO data,  " Work area of the target table
          lt_seen_keys TYPE tt_seen_keys. " Keys already accepted from the file

    ASSIGN mr_raw->* TO <lt_raw>.
    ASSIGN mr_target->* TO <lt_target>.
    CREATE DATA lr_row TYPE (mv_tabname).
    ASSIGN lr_row->* TO FIELD-SYMBOL(<ls_target>).

    " Row 1 is the header
    LOOP AT <lt_raw> ASSIGNING FIELD-SYMBOL(<ls_raw>) FROM 2.
      DATA(lv_row)       = sy-tabix.    " Excel row number
      DATA(lv_has_data)  = abap_false.  " At least one non-empty mapped cell
      DATA(lv_row_error) = abap_false.  " At least one conversion error
      CLEAR <ls_target>.

      LOOP AT mt_col_map INTO DATA(ls_map).
        ASSIGN COMPONENT ls_map-excel_col OF STRUCTURE <ls_raw> TO FIELD-SYMBOL(<lv_cell>).
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

        DATA(lv_value) = normalize_value( CONV string( <lv_cell> ) ).
        IF lv_value IS INITIAL.
          CONTINUE. " Empty cell -> field stays initial
        ENDIF.
        lv_has_data = abap_true.

        ASSIGN COMPONENT ls_map-fieldname OF STRUCTURE <ls_target> TO FIELD-SYMBOL(<lv_target>).
        TRY.
            convert_cell( EXPORTING iv_row    = lv_row
                                    is_map    = ls_map
                                    iv_value  = lv_value
                          CHANGING  cv_target = <lv_target> ).
          CATCH lcx_error INTO DATA(lx_conv).
            lv_row_error = abap_true.
            add_log( iv_row = lv_row iv_type = 'E' iv_field = ls_map-fieldname
                     iv_msg = lx_conv->get_text( ) ).
        ENDTRY.
      ENDLOOP.

      " Blank spreadsheet row
      IF lv_has_data = abap_false.
        CONTINUE.
      ENDIF.

      " Any error rejects the complete row
      IF lv_row_error = abap_true.
        mv_error_rows = mv_error_rows + 1.
        add_log( iv_row = lv_row iv_type = 'E' iv_msg = 'Row rejected.' ).
        CONTINUE.
      ENDIF.

      " In-file duplicate check on converted key values
      INSERT build_row_key( <ls_target> ) INTO TABLE lt_seen_keys.
      IF sy-subrc <> 0.
        mv_error_rows = mv_error_rows + 1.
        add_log( iv_row = lv_row iv_type = 'W'
                 iv_msg = 'Duplicate key within the file - row skipped (first occurrence kept).' ).
        CONTINUE.
      ENDIF.

      APPEND <ls_target> TO <lt_target>.
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
        IF iv_value CN '0123456789'.
          RAISE EXCEPTION NEW lcx_error( iv_text = |'{ iv_value }' contains non-digit characters.| ).
        ENDIF.
        IF strlen( iv_value ) > is_map-leng.
          RAISE EXCEPTION NEW lcx_error( iv_text = |'{ iv_value }' exceeds { is_map-leng } digits.| ).
        ENDIF.
        IF is_map-convexit IS NOT INITIAL.
          apply_conversion_exit( EXPORTING is_map = is_map iv_value = iv_value
                                 CHANGING  cv_target = cv_target ).
        ELSE.
          cv_target = iv_value. " Right-aligned, zero-padded by conversion rules
        ENDIF.

      WHEN 'I' OR 'b' OR 's' OR '8'               " INT4, INT1, INT2, INT8
        OR 'P' OR 'F' OR 'a' OR 'e'.              " DEC/CURR/QUAN, FLTP, DECFLOAT16/34
        convert_number( EXPORTING iv_row = iv_row is_map = is_map iv_value = iv_value
                        CHANGING  cv_target = cv_target ).

      WHEN 'C' OR 'g'.                            " CHAR/CUKY/UNIT/LANG..., STRING/SSTRING
        convert_text( EXPORTING iv_row = iv_row is_map = is_map iv_value = iv_value
                      CHANGING  cv_target = cv_target ).

      WHEN OTHERS.                                " RAW, RAWSTRING, ...
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |Data type { is_map-datatype } is not supported for upload.| ).
    ENDCASE.
  ENDMETHOD.


  METHOD convert_date.
    DATA: lv_day   TYPE string, " Day part
          lv_month TYPE string, " Month part
          lv_year  TYPE string. " Year part (4 digits)

    " Ignore an appended time portion, e.g. '15.01.2024 08:30'
    SPLIT iv_value AT ` ` INTO DATA(lv_date_part) DATA(lv_time_part).

    IF lv_date_part CO '0123456789' AND strlen( lv_date_part ) = 8.
      " YYYYMMDD
      lv_year  = lv_date_part+0(4).
      lv_month = lv_date_part+4(2).
      lv_day   = lv_date_part+6(2).

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

    ELSEIF matches( val = iv_value pcre = `^\d{1,2}:\d{2}(:\d{2})?$` ).
      " HH:MM or HH:MM:SS
      SPLIT iv_value AT ':' INTO lv_hh lv_mm lv_ss.

    ELSEIF matches( val = iv_value pcre = `^\d*\.?\d+$` ).
      " Excel time = fraction of a day (0.5 = 12:00:00). The integer part
      " of a date-time serial is the date and is ignored here.
      DATA(lv_fraction) = frac( CONV decfloat34( iv_value ) ).
      DATA(lv_seconds)  = CONV i( round( val = lv_fraction * c_secs_per_day dec = 0 ) ).
      lv_seconds = lv_seconds MOD c_secs_per_day. " 23:59:59.6 rounds to 24:00 -> 00:00
      rv_time = '000000'.
      rv_time = rv_time + lv_seconds.
      RETURN.

    ELSE.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }' is not a recognised time (HH:MM[:SS], HHMMSS or Excel time).| ).
    ENDIF.

    DATA(lv_h) = CONV i( lv_hh ).
    DATA(lv_m) = CONV i( lv_mm ).
    DATA(lv_s) = CONV i( lv_ss ). " Empty seconds -> 0

    IF lv_h > 23 OR lv_m > 59 OR lv_s > 59.
      RAISE EXCEPTION NEW lcx_error( iv_text = |'{ iv_value }' is not a valid time of day.| ).
    ENDIF.

    rv_time = |{ lv_h WIDTH = 2 ALIGN = RIGHT PAD = '0' }{ lv_m WIDTH = 2 ALIGN = RIGHT PAD = '0' }{ lv_s WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.
  ENDMETHOD.


  METHOD convert_number.
    DATA: lv_number TYPE decfloat34, " Parsed cell value (exact)
          lv_back   TYPE decfloat34. " Value after storing in the target field

    " Raw .xlsx numbers always use '.'; a comma means a text cell with
    " locale formatting, which is ambiguous (1,234 = 1234 or 1.234?)
    IF iv_value CA ','.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = |'{ iv_value }': use '.' as decimal separator and no thousands separator.| ).
    ENDIF.

    " Parse - accepts sign and scientific notation (1.5E+3)
    TRY.
        lv_number = iv_value.
      CATCH cx_sy_conversion_no_number cx_sy_conversion_overflow INTO DATA(lx_parse).
        RAISE EXCEPTION NEW lcx_error( iv_text   = |'{ iv_value }' is not a valid number.|
                                       previous = lx_parse ).
    ENDTRY.

    " Store - raises on overflow
    " NOTE: CURR values are stored as entered. For currencies with
    "       other than 2 decimals (JPY, KWD) apply BAPI_CURRENCY_CONV_TO_INTERNAL
    "       using the reference currency field of the row.
    TRY.
        cv_target = lv_number.
      CATCH cx_sy_conversion_overflow cx_sy_arithmetic_overflow INTO DATA(lx_ovf).
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |'{ iv_value }' exceeds the field range (length { is_map-leng }, { is_map-decimals } decimals).|
          previous = lx_ovf ).
    ENDTRY.

    " Rounding check on numeric values (no text comparison -> no false
    " warnings for '1.5' vs '1.50'). FLTP is binary and always inexact.
    IF is_map-inttype <> 'F'.
      lv_back = cv_target.
      IF lv_back <> lv_number.
        add_log( iv_row = iv_row iv_type = 'W' iv_field = is_map-fieldname
                 iv_msg = |Value { iv_value } rounded to { lv_back } ({ is_map-decimals } decimals).| ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD convert_text.
    DATA(lv_text) = iv_value. " Working copy

    " Same behaviour as SM30: upper case unless the domain allows lower case
    IF is_map-lowercase = abap_false AND is_map-inttype = 'C'.
      lv_text = to_upper( lv_text ).
    ENDIF.

    " Length check: CHAR and SSTRING (STRING has length 0 = unlimited)
    IF is_map-leng > 0 AND strlen( lv_text ) > is_map-leng.
      IF is_map-keyflag = abap_true.
        " Truncating a key would silently create a different record
        RAISE EXCEPTION NEW lcx_error(
          iv_text = |Key value '{ lv_text }' exceeds { is_map-leng } characters.| ).
      ENDIF.
      add_log( iv_row = iv_row iv_type = 'W' iv_field = is_map-fieldname
               iv_msg = |Text exceeds { is_map-leng } characters and was truncated.| ).
      lv_text = substring( val = lv_text len = is_map-leng ).
    ENDIF.

    IF is_map-convexit IS NOT INITIAL.
      apply_conversion_exit( EXPORTING is_map = is_map iv_value = lv_text
                             CHANGING  cv_target = cv_target ).
    ELSE.
      cv_target = lv_text.
    ENDIF.
  ENDMETHOD.


  METHOD apply_conversion_exit.
    DATA lv_fm TYPE rs38l_fnam. " Function module name of the exit

    lv_fm = |CONVERSION_EXIT_{ is_map-convexit }_INPUT|.

    TRY.
        CALL FUNCTION lv_fm
          EXPORTING
            input  = iv_value
          IMPORTING
            output = cv_target
          EXCEPTIONS
            OTHERS = 1.
        IF sy-subrc <> 0.
          RAISE EXCEPTION NEW lcx_error(
            iv_text = |'{ iv_value }' rejected by conversion exit { is_map-convexit }.| ).
        ENDIF.
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


  METHOD build_row_key.
    LOOP AT mt_key_fields INTO DATA(lv_keyfield).
      ASSIGN COMPONENT lv_keyfield OF STRUCTURE is_row TO FIELD-SYMBOL(<lv_key>).
      IF sy-subrc = 0.
        rv_key = |{ rv_key }{ <lv_key> }\||.
      ENDIF.
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
    FIELD-SYMBOLS: <lt_target>  TYPE STANDARD TABLE, " All valid rows
                   <lt_package> TYPE STANDARD TABLE. " Rows of the current package
    DATA: lr_package  TYPE REF TO data, " Package table
          lv_inserted TYPE i.           " Rows actually inserted (SY-DBCNT)

    ASSIGN mr_target->* TO <lt_target>.
    IF <lt_target> IS INITIAL.
      add_log( iv_type = 'W' iv_msg = 'No valid rows to insert.' ).
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

          " Existing DB keys are skipped (SY-SUBRC = 4), not overwritten
          INSERT (mv_tabname) FROM TABLE @<lt_package> ACCEPTING DUPLICATE KEYS.
          lv_inserted = lv_inserted + sy-dbcnt.

          lv_from = lv_to + 1.
        ENDWHILE.

        COMMIT WORK.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql).
        ROLLBACK WORK.
        RAISE EXCEPTION NEW lcx_error(
          iv_text  = |Database error - nothing was written: { lx_sql->get_text( ) }|
          previous = lx_sql ).
    ENDTRY.

    add_log( iv_type = 'S'
             iv_msg  = |{ lv_inserted } row(s) inserted into { mv_tabname }.| ).
    IF lv_total - lv_inserted > 0.
      add_log( iv_type = 'W'
               iv_msg  = |{ lv_total - lv_inserted } row(s) skipped - key already exists in the database.| ).
    ENDIF.
    IF mv_error_rows > 0.
      add_log( iv_type = 'W'
               iv_msg  = |{ mv_error_rows } row(s) rejected during validation (see row messages).| ).
    ENDIF.
  ENDMETHOD.


  METHOD show_log.
    "! Column heading definition for the ALV
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

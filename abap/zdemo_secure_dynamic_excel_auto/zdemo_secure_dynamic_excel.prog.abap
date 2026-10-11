*&---------------------------------------------------------------------*
*& Report ZDEMO_SECURE_DYNAMIC_EXCEL
*&---------------------------------------------------------------------*
*& Loads an unstructured .xlsx file into a transparent Z*/Y* database
*& table with automatic header discovery and dynamic table creation.
*&---------------------------------------------------------------------*
REPORT zdemo_secure_dynamic_excel.

PARAMETERS: p_file  TYPE ibipparms-path OBLIGATORY,
            p_tname TYPE tabname OBLIGATORY DEFAULT 'ZDYNAMIC_EXCEL_DATA',
            p_test  AS CHECKBOX DEFAULT abap_true,
            p_skipd AS CHECKBOX DEFAULT abap_false.

*----------------------------------------------------------------------*
* Exception class
*----------------------------------------------------------------------*
CLASS lcx_importer DEFINITION INHERITING FROM cx_static_check FINAL.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_text  TYPE string OPTIONAL
                previous TYPE REF TO cx_root OPTIONAL.
    METHODS get_text REDEFINITION.
  PRIVATE SECTION.
    DATA mv_text TYPE string.
ENDCLASS.

*----------------------------------------------------------------------*
* Excel importer definition
*----------------------------------------------------------------------*
CLASS lcl_excel_importer DEFINITION FINAL.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_log,
             msgty     TYPE symsgty,
             excel_row TYPE i,
             excel_col TYPE string,
             field     TYPE fieldname,
             value     TYPE string,
             message   TYPE string,
           END OF ty_log,
           tt_log TYPE STANDARD TABLE OF ty_log WITH EMPTY KEY.

    CLASS-METHODS select_file CHANGING cv_file TYPE ibipparms-path.

    METHODS constructor
      IMPORTING iv_file     TYPE string
                iv_tabname  TYPE tabname
                iv_test     TYPE abap_bool
                iv_skip_dup TYPE abap_bool.

    METHODS execute RAISING lcx_importer.

  PRIVATE SECTION.
    TYPES: BEGIN OF ty_col_map,
             col      TYPE i,
             field    TYPE fieldname,
             inttype  TYPE inttype,
             leng     TYPE i,
             convexit TYPE convexit,
           END OF ty_col_map,
           tt_col_map TYPE STANDARD TABLE OF ty_col_map WITH EMPTY KEY,

           BEGIN OF ty_header_temp,
             col   TYPE i,
             name  TYPE string,
           END OF ty_header_temp,
           tt_header_temp TYPE STANDARD TABLE OF ty_header_temp WITH EMPTY KEY.

    CONSTANTS c_allowed_prefixes TYPE c LENGTH 2 VALUE 'ZY'.

    DATA: mv_file         TYPE string,
          mv_tabname      TYPE tabname,
          mv_test         TYPE abap_bool,
          mv_skip_dup     TYPE abap_bool,
          mt_fields       TYPE ddfields,
          mv_client_fld   TYPE fieldname,
          mv_header_row   TYPE i,
          mv_table_created TYPE abap_bool,
          mt_col_map      TYPE tt_col_map,
          mr_raw_tab      TYPE REF TO data,
          mr_target_tab   TYPE REF TO data,
          mt_log          TYPE tt_log,
          mv_rows_read    TYPE i,
          mv_rows_empty   TYPE i,
          mv_rows_error   TYPE i,
          mv_inserted     TYPE i,
          mv_skipped      TYPE i.

    METHODS check_table      RAISING lcx_importer.
    METHODS check_authority  RAISING lcx_importer.
    METHODS upload_file
      RETURNING VALUE(rv_xstring) TYPE xstring
      RAISING   lcx_importer.
    METHODS read_sheet
      IMPORTING iv_xstring TYPE xstring
      RAISING   lcx_importer.
    METHODS find_header_row
      RETURNING VALUE(rt_headers) TYPE tt_header_temp
      RAISING   lcx_importer.
    METHODS create_table_dynamically
      IMPORTING it_headers TYPE tt_header_temp
      RAISING   lcx_importer.
    METHODS map_header
      IMPORTING it_headers TYPE tt_header_temp
      RAISING   lcx_importer.
    METHODS build_rows.
    METHODS convert_value
      IMPORTING iv_value   TYPE string
                is_map     TYPE ty_col_map
      EXPORTING ev_warning TYPE string
      CHANGING  cv_target  TYPE any
      RAISING   lcx_importer.
    METHODS to_date
      IMPORTING iv_value       TYPE string
      RETURNING VALUE(rv_date) TYPE d
      RAISING   lcx_importer.
    METHODS to_time
      IMPORTING iv_value       TYPE string
      RETURNING VALUE(rv_time) TYPE t
      RAISING   lcx_importer.
    METHODS insert_rows.
    METHODS show_log.
    METHODS add_log
      IMPORTING iv_msgty TYPE symsgty
                iv_msg   TYPE string
                iv_row   TYPE i OPTIONAL
                iv_col   TYPE i OPTIONAL
                iv_field TYPE fieldname OPTIONAL
                iv_value TYPE string OPTIONAL.
    METHODS col_letter
      IMPORTING iv_col           TYPE i
      RETURNING VALUE(rv_letter) TYPE string.
ENDCLASS.

*----------------------------------------------------------------------*
* Selection Screen Events
*----------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  lcl_excel_importer=>select_file( CHANGING cv_file = p_file ).

START-OF-SELECTION.
  TRY.
      NEW lcl_excel_importer( iv_file     = CONV #( p_file )
                              iv_tabname  = p_tname
                              iv_test     = p_test
                              iv_skip_dup = p_skipd )->execute( ).
    CATCH lcx_importer INTO DATA(gx_error).
      MESSAGE gx_error->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.

*----------------------------------------------------------------------*
* Implementations
*----------------------------------------------------------------------*
CLASS lcx_importer IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
    mv_text = iv_text.
  ENDMETHOD.

  METHOD get_text.
    result = mv_text.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_excel_importer IMPLEMENTATION.

  METHOD select_file.
    DATA: lt_files TYPE filetable,
          lv_rc    TYPE i.

    cl_gui_frontend_services=>file_open_dialog(
      EXPORTING
        window_title = `Select Excel file (.xlsx)`
        file_filter  = `Excel files (*.xlsx)|*.xlsx`
      CHANGING
        file_table   = lt_files
        rc           = lv_rc
      EXCEPTIONS
        OTHERS       = 1 ).

    IF sy-subrc = 0 AND lv_rc = 1.
      cv_file = lt_files[ 1 ]-filename.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    mv_file     = iv_file.
    mv_tabname  = to_upper( iv_tabname ).
    mv_test     = iv_test.
    mv_skip_dup = iv_skip_dup.
  ENDMETHOD.

  METHOD execute.
    check_table( ).
    check_authority( ).

    DATA(lv_xstring) = upload_file( ).
    read_sheet( lv_xstring ).

    " Find header row & extract headers before deciding on table existence
    DATA(lt_headers) = find_header_row( ).

    " If table doesn't exist, build and create it dynamically on the fly
    IF mv_table_created = abap_true.
      create_table_dynamically( lt_headers ).
    ENDIF.

    map_header( lt_headers ).
    build_rows( ).
    insert_rows( ).
    show_log( ).
  ENDMETHOD.

  METHOD check_table.
    DATA lv_tabclass TYPE tabclass.

    IF mv_tabname(1) NA c_allowed_prefixes.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |Table { mv_tabname } is not allowed. Only Z*/Y* tables can be loaded.|.
    ENDIF.

    SELECT SINGLE tabclass FROM dd02l
      WHERE tabname  = @mv_tabname
        AND as4local = 'A'
        AND as4vers  = '0000'
      INTO @lv_tabclass.

    IF sy-subrc <> 0.
      " Table does not exist -> flag for dynamic creation after header discovery
      mv_table_created = abap_true.
      RETURN.
    ENDIF.

    IF lv_tabclass <> 'TRANSP'.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |{ mv_tabname } is not a transparent table.|.
    ENDIF.

    " Load existing field catalog
    DATA(lo_struct) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( mv_tabname ) ).
    lo_struct->get_ddic_field_list(
      EXPORTING langu        = sy-langu
      RECEIVING  p_field_list = mt_fields
      EXCEPTIONS OTHERS       = 1 ).
    IF sy-subrc <> 0 OR mt_fields IS INITIAL.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |Cannot read the field list of { mv_tabname }.|.
    ENDIF.

    READ TABLE mt_fields INTO DATA(ls_client) WITH KEY datatype = 'CLNT'.
    IF sy-subrc = 0.
      mv_client_fld = ls_client-fieldname.
    ENDIF.

    CREATE DATA mr_target_tab TYPE STANDARD TABLE OF (mv_tabname).
  ENDMETHOD.

  METHOD check_authority.
    " If table doesn't exist yet, check creation/change authorization for DDIC package or general table maintenance
    DATA(lv_actvt) = COND activ_auth( WHEN mv_test = abap_true THEN '03' ELSE '02' ).

    IF mv_table_created = abap_false.
      AUTHORITY-CHECK OBJECT 'S_TABU_NAM'
        ID 'ACTVT' FIELD lv_actvt
        ID 'TABLE' FIELD mv_tabname.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE lcx_importer
          EXPORTING iv_text = |No authorization (S_TABU_NAM, activity { lv_actvt }) for table { mv_tabname }.|.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD upload_file.
    DATA: lt_solix TYPE solix_tab,
          lv_len   TYPE i.

    IF sy-batch = abap_true.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = `This report reads a local file and cannot run in background.`.
    ENDIF.

    cl_gui_frontend_services=>gui_upload(
      EXPORTING
        filename   = mv_file
        filetype   = 'BIN'
      IMPORTING
        filelength = lv_len
      CHANGING
        data_tab   = lt_solix
      EXCEPTIONS
        OTHERS     = 1 ).
    IF sy-subrc <> 0 OR lv_len = 0.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |File { mv_file } could not be uploaded or is empty.|.
    ENDIF.

    rv_xstring = cl_bcs_convert=>solix_to_xstring( it_solix = lt_solix
                                                   iv_size  = lv_len ).
  ENDMETHOD.

  METHOD read_sheet.
    DATA: lo_excel  TYPE REF TO cl_fdt_xl_spreadsheet,
          lt_sheets TYPE if_fdt_doc_spreadsheet=>t_worksheet_names.

    TRY.
        lo_excel = NEW #( document_name = mv_file
                          xdocument     = iv_xstring ).
      CATCH cx_fdt_excel_core INTO DATA(lx_excel).
        RAISE EXCEPTION TYPE lcx_importer
          EXPORTING iv_text  = |File is not a valid .xlsx: { lx_excel->get_text( ) }|
                    previous = lx_excel.
    ENDTRY.

    lo_excel->if_fdt_doc_spreadsheet~get_worksheet_names(
      IMPORTING worksheet_names = lt_sheets ).
    IF lt_sheets IS INITIAL.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `The file contains no worksheets.`.
    ENDIF.

    mr_raw_tab = lo_excel->if_fdt_doc_spreadsheet~get_itab_from_worksheet( lt_sheets[ 1 ] ).
    IF mr_raw_tab IS NOT BOUND.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `The first worksheet could not be read.`.
    ENDIF.
  ENDMETHOD.

  METHOD find_header_row.
    FIELD-SYMBOLS: <lt_raw>  TYPE STANDARD TABLE,
                   <ls_row>  TYPE any,
                   <lv_cell> TYPE any.
    DATA: lv_max_score TYPE i VALUE 0,
          lv_best_row  TYPE i VALUE 0,
          lv_col       TYPE i,
          lv_val       TYPE string,
          lv_norm      TYPE string,
          lt_cand_hdr  TYPE tt_header_temp.

    ASSIGN mr_raw_tab->* TO <lt_raw>.
    IF <lt_raw> IS INITIAL.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `The worksheet contains no data.`.
    ENDIF.

    DATA(lv_scan_limit) = nmin( val1 = lines( <lt_raw> ) val2 = 15 ).

    " Scan top rows to discover the header row
    LOOP AT <lt_raw> ASSIGNING <ls_row> FROM 1 TO lv_scan_limit.
      DATA(lv_current_score) = 0.
      CLEAR lt_cand_hdr.

      DO.
        lv_col = sy-index.
        ASSIGN COMPONENT lv_col OF STRUCTURE <ls_row> TO <lv_cell>.
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.

        lv_val = <lv_cell>.
        IF lv_val IS INITIAL.
          CONTINUE.
        ENDIF.

        lv_norm = to_upper( condense( lv_val ) ).
        REPLACE ALL OCCURRENCES OF REGEX '[^A-Z0-9_]' IN lv_norm WITH '_'.

        APPEND VALUE #( col = lv_col name = lv_norm ) TO lt_cand_hdr.
        lv_current_score = lv_current_score + 1.
      ENDDO.

      IF lv_current_score > lv_max_score.
        lv_max_score  = lv_current_score.
        lv_best_row   = sy-tabix.
        rt_headers    = lt_cand_hdr.
      ENDIF.
    ENDLOOP.

    IF lv_best_row = 0 OR rt_headers IS INITIAL.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |Could not identify valid headers in the worksheet.|.
    ENDIF.

    mv_header_row = lv_best_row.
  ENDMETHOD.

  METHOD create_table_dynamically.
    DATA: ls_dd02v TYPE dd02v,
          ls_dd09l TYPE dd09l,
          lt_dd03p TYPE STANDARD TABLE OF dd03p,
          ls_dd03p TYPE dd03p,
          lv_pos   TYPE i VALUE 0.

    " 1. Define table attributes
    ls_dd02v-tabname   = mv_tabname.
    ls_dd02v-tabclass  = 'TRANSP'.
    ls_dd02v-clidep    = abap_true.
    ls_dd02v-contflag  = 'A'.
    ls_dd02v-delivery  = 'A'.
    ls_dd02v-devclass  = '$TMP'. " Local object package
    ls_dd02v-as4user   = sy-uname.
    ls_dd02v-ddlanguage= sy-langu.
    ls_dd02v-tabform   = 'RAW'.

    ls_dd09l-tabname   = mv_tabname.
    ls_dd09l-tabart    = 'APPL0'.
    ls_dd09l-tabfkart  = 'MAIN'.
    ls_dd09l-bufstat   = 'RO'.

    " 2. Always include standard MANDT client field as key
    lv_pos = lv_pos + 1.
    ls_dd03p-tabname   = mv_tabname.
    ls_dd03p-fieldname = 'MANDT'.
    ls_dd03p-position  = lv_pos.
    ls_dd03p-keyflag   = abap_true.
    ls_dd03p-datatype  = 'CLNT'.
    ls_dd03p-leng      = 3.
    ls_dd03p-notnull   = abap_true.
    APPEND ls_dd03p TO lt_dd03p.
    mv_client_fld      = 'MANDT'.

    " 3. Build fields from discovered unstructured headers
    LOOP AT it_headers INTO DATA(ls_hdr).
      lv_pos = lv_pos + 1.
      CLEAR ls_dd03p.
      ls_dd03p-tabname   = mv_tabname.
      ls_dd03p-fieldname = ls_hdr-name.
      ls_dd03p-position  = lv_pos.
      ls_dd03p-datatype  = 'CHAR'.
      ls_dd03p-leng      = 255. " Flexible container size for unstructured imports

      " Make the first data column a primary key if none specified
      IF lv_pos = 2.
        ls_dd03p-keyflag = abap_true.
      ENDIF.

      APPEND ls_dd03p TO lt_dd03p.
    ENDLOOP.

    " 4. Write and activate table in DDIC dictionary
    CALL FUNCTION 'DDIF_TABL_PUT'
      EXPORTING
        name             = mv_tabname
        dd02v_wa         = ls_dd02v
        dd09l_wa         = ls_dd09l
      TABLES
        dd03p_tab        = lt_dd03p
      EXCEPTIONS
        put_failure      = 1
        illegal_input    = 2
        OTHERS           = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |Failed to create table definition for { mv_tabname } (RC { sy-subrc }).|.
    ENDIF.

    CALL FUNCTION 'DDIF_TABL_ACTIVATE'
      EXPORTING
        name             = mv_tabname
        auth_chk         = abap_false
      EXCEPTIONS
        not_found        = 1
        put_failure      = 2
        illegal_input    = 3
        OTHERS           = 4.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |Failed to activate dynamically created table { mv_tabname } (RC { sy-subrc }).|.
    ENDIF.

    " 5. Fetch newly created field catalog and create target table structure
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname   = mv_tabname
        langu     = sy-langu
      TABLES
        dfies_tab = mt_fields
      EXCEPTIONS
        OTHERS    = 1.

    CREATE DATA mr_target_tab TYPE STANDARD TABLE OF (mv_tabname).
  ENDMETHOD.

  METHOD map_header.
    DATA: ls_field TYPE dfies.

    LOOP AT it_headers INTO DATA(ls_hdr).
      CLEAR ls_field.

      " Match against table fields
      READ TABLE mt_fields INTO ls_field WITH KEY fieldname = ls_hdr-name.
      IF sy-subrc <> 0.
        " Fallback scan by description/short text
        LOOP AT mt_fields INTO DATA(ls_candidate).
          DATA(lv_desc_norm) = to_upper( condense( ls_candidate-fieldtext ) ).
          REPLACE ALL OCCURRENCES OF REGEX '[^A-Z0-9_]' IN lv_desc_norm WITH '_'.

          IF lv_desc_norm = ls_hdr-name OR to_upper( condense( ls_candidate-reptext ) ) = ls_hdr-name.
            ls_field = ls_candidate.
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDIF.

      IF ls_field-fieldname IS INITIAL OR ls_field-fieldname = mv_client_fld.
        CONTINUE.
      ENDIF.

      IF line_exists( mt_col_map[ field = ls_field-fieldname ] ).
        CONTINUE.
      ENDIF.

      APPEND VALUE #( col      = ls_hdr-col
                      field    = ls_field-fieldname
                      inttype  = ls_field-inttype
                      leng     = ls_field-leng
                      convexit = ls_field-convexit ) TO mt_col_map.
    ENDLOOP.

    IF mt_col_map IS INITIAL.
      RAISE EXCEPTION TYPE lcx_importer
        EXPORTING iv_text = |No columns could be mapped to table { mv_tabname }.|.
    ENDIF.
  ENDMETHOD.

  METHOD build_rows.
    FIELD-SYMBOLS: <lt_raw>    TYPE STANDARD TABLE,
                   <ls_raw>    TYPE any,
                   <lv_cell>   TYPE any,
                   <lt_target> TYPE STANDARD TABLE,
                   <ls_target> TYPE any,
                   <lv_field>  TYPE any.
    DATA: lr_target_line TYPE REF TO data,
          lv_row         TYPE i,
          lv_value       TYPE string,
          lv_warning     TYPE string,
          lv_has_data    TYPE abap_bool,
          lv_row_ok      TYPE abap_bool.

    ASSIGN mr_raw_tab->* TO <lt_raw>.
    ASSIGN mr_target_tab->* TO <lt_target>.
    CREATE DATA lr_target_line LIKE LINE OF <lt_target>.
    ASSIGN lr_target_line->* TO <ls_target>.

    DATA(lv_start_row) = mv_header_row + 1.

    LOOP AT <lt_raw> ASSIGNING <ls_raw> FROM lv_start_row.
      lv_row = sy-tabix.
      CLEAR <ls_target>.
      lv_has_data = abap_false.
      lv_row_ok   = abap_true.

      LOOP AT mt_col_map INTO DATA(ls_map).
        ASSIGN COMPONENT ls_map-col OF STRUCTURE <ls_raw> TO <lv_cell>.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

        lv_value = <lv_cell>.
        CONDENSE lv_value.
        IF lv_value IS INITIAL.
          CONTINUE.
        ENDIF.
        lv_has_data = abap_true.

        ASSIGN COMPONENT ls_map-field OF STRUCTURE <ls_target> TO <lv_field>.
        TRY.
            convert_value( EXPORTING iv_value   = lv_value
                                     is_map     = ls_map
                           IMPORTING ev_warning = lv_warning
                           CHANGING  cv_target  = <lv_field> ).
            IF lv_warning IS NOT INITIAL.
              add_log( iv_msgty = 'W' iv_row = lv_row iv_col = ls_map-col
                       iv_field = ls_map-field iv_value = lv_value iv_msg = lv_warning ).
            ENDIF.
          CATCH lcx_importer INTO DATA(lx_cell).
            lv_row_ok = abap_false.
            add_log( iv_msgty = 'E' iv_row = lv_row iv_col = ls_map-col
                     iv_field = ls_map-field iv_value = lv_value iv_msg = lx_cell->get_text( ) ).
        ENDTRY.
      ENDLOOP.

      IF lv_has_data = abap_false.
        mv_rows_empty = mv_rows_empty + 1.
        CONTINUE.
      ENDIF.

      mv_rows_read = mv_rows_read + 1.

      IF lv_row_ok = abap_false.
        mv_rows_error = mv_rows_error + 1.
        CONTINUE.
      ENDIF.

      IF mv_client_fld IS NOT INITIAL.
        ASSIGN COMPONENT mv_client_fld OF STRUCTURE <ls_target> TO <lv_field>.
        <lv_field> = sy-mandt.
      ENDIF.

      APPEND <ls_target> TO <lt_target>.
    ENDLOOP.
  ENDMETHOD.

  METHOD convert_value.
    DATA: lv_float TYPE f,
          lv_fm    TYPE rs38l_fnam.

    CLEAR ev_warning.

    IF is_map-convexit IS NOT INITIAL AND ( is_map-inttype = 'C' OR is_map-inttype = 'N' ).
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
            RAISE EXCEPTION TYPE lcx_importer
              EXPORTING iv_text = |Value rejected by conversion exit { is_map-convexit }.|.
          ENDIF.
          RETURN.
        CATCH cx_sy_dyn_call_error.
      ENDTRY.
    ENDIF.

    CASE is_map-inttype.
      WHEN 'D'.
        cv_target = to_date( iv_value ).

      WHEN 'T'.
        cv_target = to_time( iv_value ).

      WHEN 'P' OR 'F' OR 'I' OR 'b' OR 's' OR '8'.
        TRY.
            cv_target = iv_value.
          CATCH cx_sy_conversion_no_number.
            TRY.
                lv_float  = iv_value.
                cv_target = lv_float.
              CATCH cx_sy_conversion_error.
                RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Not a valid number.`.
            ENDTRY.
          CATCH cx_sy_conversion_overflow.
            RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Number too large for this field.`.
        ENDTRY.

      WHEN 'N'.
        IF iv_value CN '0123456789'.
          RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Only digits are allowed.`.
        ENDIF.
        IF strlen( iv_value ) > is_map-leng.
          RAISE EXCEPTION TYPE lcx_importer
            EXPORTING iv_text = |More than { is_map-leng } digits.|.
        ENDIF.
        cv_target = iv_value.

      WHEN 'C'.
        IF strlen( iv_value ) > is_map-leng.
          ev_warning = |Value truncated to { is_map-leng } characters.|.
        ENDIF.
        cv_target = iv_value.

      WHEN OTHERS.
        TRY.
            cv_target = iv_value.
          CATCH cx_sy_conversion_error INTO DATA(lx_conv).
            RAISE EXCEPTION TYPE lcx_importer
              EXPORTING iv_text = lx_conv->get_text( ) previous = lx_conv.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD to_date.
    DATA: lv_int  TYPE string,
          lv_rest TYPE string,
          lv_days TYPE i.

    IF matches( val = iv_value regex = `^\d{8}$` ).
      rv_date = iv_value.
    ELSEIF matches( val = iv_value regex = `^\d{4}-\d{2}-\d{2}$` ).
      rv_date = |{ iv_value(4) }{ iv_value+5(2) }{ iv_value+8(2) }|.
    ELSEIF matches( val = iv_value regex = `^\d{2}[./]\d{2}[./]\d{4}$` ).
      rv_date = |{ iv_value+6(4) }{ iv_value+3(2) }{ iv_value(2) }|.
    ELSEIF matches( val = iv_value regex = `^\d{1,5}(\.\d+)?$` ).
      SPLIT iv_value AT '.' INTO lv_int lv_rest.
      lv_days = lv_int.
      rv_date = '18991230'.
      rv_date = rv_date + lv_days.
    ELSE.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Unrecognized date format.`.
    ENDIF.

    CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
      EXPORTING
        date   = rv_date
      EXCEPTIONS
        OTHERS = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Invalid date.`.
    ENDIF.
  ENDMETHOD.

  METHOD to_time.
    DATA: lv_hs   TYPE string,
          lv_ms   TYPE string,
          lv_ss   TYPE string,
          lv_h    TYPE n LENGTH 2,
          lv_m    TYPE n LENGTH 2,
          lv_s    TYPE n LENGTH 2,
          lv_frac TYPE decfloat34,
          lv_secs TYPE i.

    IF matches( val = iv_value regex = `^\d{1,2}:\d{2}(:\d{2})?$` ).
      SPLIT iv_value AT ':' INTO lv_hs lv_ms lv_ss.
      lv_h = lv_hs.
      lv_m = lv_ms.
      lv_s = lv_ss.
      rv_time = |{ lv_h }{ lv_m }{ lv_s }|.
    ELSEIF matches( val = iv_value regex = `^\d{6}$` ).
      rv_time = iv_value.
    ELSEIF matches( val = iv_value regex = `^0?\.\d+$` ).
      lv_frac = iv_value.
      lv_secs = round( val = lv_frac * 86400 dec = 0 ).
      rv_time = '000000'.
      rv_time = rv_time + lv_secs.
    ELSE.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Unrecognized time format.`.
    ENDIF.

    IF rv_time(2) > '23' OR rv_time+2(2) > '59' OR rv_time+4(2) > '59'.
      RAISE EXCEPTION TYPE lcx_importer EXPORTING iv_text = `Invalid time.`.
    ENDIF.
  ENDMETHOD.

  METHOD insert_rows.
    FIELD-SYMBOLS <lt_target> TYPE STANDARD TABLE.
    ASSIGN mr_target_tab->* TO <lt_target>.

    IF <lt_target> IS INITIAL.
      add_log( iv_msgty = 'W' iv_msg = `No valid rows to insert.` ).
      RETURN.
    ENDIF.

    IF mv_test = abap_true.
      add_log( iv_msgty = 'I'
               iv_msg   = |Test mode: { lines( <lt_target> ) } rows are valid. Nothing was written.| ).
      RETURN.
    ENDIF.

    CALL FUNCTION 'ENQUEUE_E_TABLE'
      EXPORTING
        tabname      = mv_tabname
      EXCEPTIONS
        foreign_lock = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      add_log( iv_msgty = 'E'
               iv_msg   = |Table { mv_tabname } is locked by another user. Nothing was written.| ).
      RETURN.
    ENDIF.

    TRY.
        IF mv_skip_dup = abap_true.
          INSERT (mv_tabname) FROM TABLE <lt_target> ACCEPTING DUPLICATE KEYS.
          mv_inserted = sy-dbcnt.
          mv_skipped  = lines( <lt_target> ) - sy-dbcnt.
        ELSE.
          INSERT (mv_tabname) FROM TABLE <lt_target>.
          mv_inserted = sy-dbcnt.
        ENDIF.
        COMMIT WORK.

      CATCH cx_sy_open_sql_db cx_sy_dynamic_osql_error INTO DATA(lx_sql).
        ROLLBACK WORK.
        CLEAR: mv_inserted, mv_skipped.
        add_log( iv_msgty = 'E'
                 iv_msg   = |Insert failed, all changes rolled back: { lx_sql->get_text( ) }| ).
    ENDTRY.

    CALL FUNCTION 'DEQUEUE_E_TABLE'
      EXPORTING
        tabname = mv_tabname.

    IF mv_skipped > 0.
      add_log( iv_msgty = 'W'
               iv_msg   = |{ mv_skipped } rows skipped because the key already exists.| ).
    ENDIF.
  ENDMETHOD.

  METHOD show_log.
    DATA lo_alv TYPE REF TO cl_salv_table.

    DATA(lt_out) = VALUE tt_log(
      ( msgty = 'I' message = |Table: { mv_tabname }{ COND #( WHEN mv_table_created = abap_true THEN ` (Dynamically Created)` ) }{ COND #( WHEN mv_test = abap_true THEN ` [Test Mode]` ) }| )
      ( msgty = 'I' message = |Header row auto-detected at Excel row: { mv_header_row }| )
      ( msgty = 'I' message = |Data rows read: { mv_rows_read }| )
      ( msgty = 'I' message = |Empty rows ignored: { mv_rows_empty }| )
      ( msgty = COND #( WHEN mv_rows_error > 0 THEN 'E' ELSE 'I' )
        message = |Rows rejected with errors: { mv_rows_error }| )
      ( msgty = 'S' message = |Rows inserted: { mv_inserted }| ) ).
    APPEND LINES OF mt_log TO lt_out.

    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = lo_alv
                                CHANGING  t_table      = lt_out ).
        lo_alv->get_functions( )->set_all( abap_true ).

        DATA(lo_cols) = lo_alv->get_columns( ).
        lo_cols->set_optimize( abap_true ).
        lo_cols->get_column( 'MSGTY' )->set_medium_text( 'Type' ).
        lo_cols->get_column( 'EXCEL_ROW' )->set_medium_text( 'Excel row' ).
        lo_cols->get_column( 'EXCEL_COL' )->set_medium_text( 'Column' ).
        lo_cols->get_column( 'FIELD' )->set_medium_text( 'Field' ).
        lo_cols->get_column( 'VALUE' )->set_medium_text( 'Value' ).
        lo_cols->get_column( 'MESSAGE' )->set_medium_text( 'Message' ).

        lo_alv->display( ).
      CATCH cx_salv_error.
        MESSAGE |Rows inserted: { mv_inserted }, rejected: { mv_rows_error }| TYPE 'S'.
    ENDTRY.
  ENDMETHOD.

  METHOD add_log.
    APPEND VALUE #( msgty     = iv_msgty
                    excel_row = iv_row
                    excel_col = COND #( WHEN iv_col > 0 THEN col_letter( iv_col ) )
                    field     = iv_field
                    value     = iv_value
                    message   = iv_msg ) TO mt_log.
  ENDMETHOD.

  METHOD col_letter.
    DATA: lv_n   TYPE i,
          lv_mod TYPE i.

    lv_n = iv_col.
    WHILE lv_n > 0.
      lv_mod    = ( lv_n - 1 ) MOD 26.
      rv_letter = substring( val = sy-abcde off = lv_mod len = 1 ) && rv_letter.
      lv_n      = ( lv_n - 1 ) DIV 26.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.

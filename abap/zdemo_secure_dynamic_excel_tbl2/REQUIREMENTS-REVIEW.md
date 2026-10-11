# Requirements review — ZDEMO_SECURE_DYNAMIC_EXCEL_TBL2

Program: [zdemo_secure_dynamic_excel_tbl2.prog.abap](zdemo_secure_dynamic_excel_tbl2.prog.abap) (version TBL2). Line numbers refer to that file. Reviewed on 2026-10-11 by reading the code; nothing was run on an SAP system.

## The requirement

> A **robust, metadata-driven utility** designed to **read local Excel files (.xlsx) via binary streams (`it_solix`)** and **safely upload** their contents into **any custom SAP transparent database table (Z\* or Y\*)**.

## Verdict

**The requirement is mostly met, with 5 gaps.**

The parts that are met: the binary path, `.xlsx` parsing, the Z\*/Y\* and transparent-table restriction, DDIC-driven type conversion, the authorization, lock and commit handling, and the test run. TBL2 covers all of these.

The gaps are in the words **safely**, **any** and **utility**:

1. **"Safely"**: the DDIC says which values are allowed, and the program ignores that. Values outside a domain's fixed values, values missing from the check table, negative numbers in unsigned fields and Excel error cells (`#N/A`) are all inserted (R1, R2, R3).
2. **"Any" table**: a table with a RAW key (GUIDs) cannot be loaded at all, and one RAW/UTCLONG column in the file rejects every row (R4).
3. **"Utility via `it_solix`"**: the logic is a local class inside a report, and the `it_solix` stream is created internally from `GUI_UPLOAD`. No other caller can pass in its own `it_solix`, and a large file can hit the dialog time limit (R5).

| # | Severity | Gap | Requirement word |
|---|---|---|---|
| R1 | High | Domain fixed values and check tables are not validated | safely, metadata-driven |
| R2 | High | Excel error cells (`#N/A`, `#REF!`, ...) are stored as text | safely, robust |
| R3 | Medium | Negative values are accepted for unsigned domains (`DFIES-SIGN`) | safely, metadata-driven |
| R4 | Medium | RAW/UTCLONG fields: a RAW key table cannot be loaded, and an unsupported column rejects every row | any table |
| R5 | Medium | No reusable entry point that takes `it_solix`, and dialog-only processing | utility, it_solix |
| R6 | Medium | Partial loads only: there is no "all or nothing" option | safely |
| R7 | Medium | Workbooks using the 1904 date system shift every date by 4 years | robust |
| R8 | Medium | Throughput at the row limit (a regex on every cell, a full row copy for the duplicate check) | robust |
| R9 | Medium | The table lock only collides with programs that also use `E_TABLE` (verify) | safely |
| R10–R16 | Low | Smaller robustness items | robust |

---

## Requirement coverage

| Requirement element | Status | Evidence in TBL2 |
|---|---|---|
| Reads **local** files | ✅ Met | `GUI_UPLOAD` from the presentation server (840–849), F4 file dialog filtered to `*.xlsx` (`f4_file`), background run blocked with a clear message (833–837) |
| **Binary stream** (`it_solix`) | ⚠️ Partly | Reads `filetype = 'BIN'` into `solix_tab`, then calls `cl_bcs_convert=>solix_to_xstring( it_solix = ... iv_size = lv_len )` (863), so the stream is cut to the real file length. **But** the stream is internal: no method accepts an `it_solix` from a caller (R5). |
| **.xlsx** format | ✅ Met | `CL_FDT_XL_SPREADSHEET` (869–885), first worksheet. A non-xlsx file (old `.xls`, `.csv`) fails with "not a readable .xlsx document", and the cause is chained. The parser is not a released API, as noted in the header. |
| **Metadata-driven** | ⚠️ Partly | Uses `DDIF_FIELDINFO_GET` (809): `inttype` dispatch, `leng`/`outputlen`, `decimals`, `keyflag`, `convexit`, `lowercase`, `reftable`/`reffield`; uses `DD02L` for class, delivery class and maintenance flag; builds the key type with RTTS. **Ignored:** `valexi`/fixed values, `checktable`, `sign` (R1, R3). |
| **Any** custom table | ⚠️ Partly | Every type except RAW, RAWSTRING, UTCLONG and GEOM is supported (1153). Client-dependent and client-independent tables are both handled. Customizing tables are limited on purpose by H4 (checkbox plus SCC4), which is a deliberate narrowing of "any" and should be agreed with the requester. RAW-key tables cannot be loaded (R4). |
| **Z\* / Y\*** only | ✅ Met | First-character check (672), optional whitelist `ZUPLOAD_ALLOWED`. Namespaces such as `/ABC/` are rejected, as the requirement implies. |
| **Transparent** table | ✅ Met | `DD02L-TABCLASS = 'TRANSP'`, active version (683–690). Views, pooled and cluster tables are rejected. |
| **Safely** upload | ⚠️ Partly | **In place:** `VIEW_AUTHORITY_CHECK`; delivery class, maintenance flag and SCC4 checks; the test run on by default; a table lock; one `COMMIT`/`ROLLBACK`; a row rejected on any error; duplicates in the file and in the DB skipped, never overwritten; an application log. Dynamic SQL uses only names that come from the DDIC, so there is no injection path. Table logging (DBTABLOG) still works because the insert is Open SQL. **Missing:** R1, R2, R3, R6, R9. |
| **Robust** | ⚠️ Partly | Size and row limits, chained exceptions, parsing for each row, unit tests for the converters. **Missing:** R2, R7, R8, R10–R16. |

---

## High

### R1 — Domain fixed values and check tables are not validated

**Where:** `convert_text` (1400ff.), `convert_cell` (1116ff.).

A status field whose domain allows only `A`/`B`/`C` accepts `Z`. A plant field (`WERKS`, check table `T001W`) accepts `XXXX`. A currency-key field outside the amount logic accepts any 5 characters. SM30 rejects all three. For a tool described as *metadata-driven* and *safe*, these checks are the main metadata it has not used yet.

**Fix**
- **Fixed values:** when `dfies-valexi = abap_true`, read the domain values once per field (`cl_abap_elemdescr=>get_ddic_fixed_values( )` or `DD07L`, including intervals) into a hashed table. Reject a cell value that is not in the list.
- **Check table:** when `dfies-checktable` is filled, collect the distinct values for each field across all rows. Check them with one `SELECT ... FOR ALL ENTRIES` against the check table, using the foreign-key field mapping from `DD05S`. Reject the rows that have no match. Handle single-field foreign keys first; for multi-field keys, include the other key fields from the same row.
- Make it switchable (`p_fkchk`, default on), because some Z tables have check tables only for F4 help.

### R2 — Excel error cells are stored as text

**Where:** parse loop (1030–1060). Values pass through `normalize_value` unchanged.

A formula that fails is written in the sheet XML with its cached error value. A CHAR field therefore receives `#N/A`, `#REF!` or `#VALUE!` as data, with no warning. Numeric and date fields reject such a value, but text fields store it.

**Fix:** in `parse_rows`, before `convert_cell`, reject any cell that matches `^#(N/A|REF!|VALUE!|DIV/0!|NUM!|NAME\?|NULL!|SPILL!|CALC!)$` with the message "Excel error value in cell - fix the formula".

---

## Medium

### R3 — Negative values in unsigned domains

**Where:** `store_number` (1300ff.).

`DFIES-SIGN` is blank for DEC/QUAN/CURR domains that do not allow a sign. TBL2 stores `-5` in such a field, which SM30 does not allow. **Fix:** add `sign` to `ty_col_map`, and in `store_number` reject `iv_number < 0` when `is_map-sign = abap_false`. (INT1 already rejects negative values through the overflow check.)

### R4 — RAW and UTCLONG fields; unsupported columns reject every row

**Where:** `convert_cell` `WHEN OTHERS` (1153).

- Z tables keyed by a GUID (`SYSUUID_X16`, RAW 16) are common. The key column is mandatory and RAW is unsupported, so **every row is rejected**, and such a table cannot be loaded.
- A non-key RAW, RAWSTRING or UTCLONG column in the file produces the same error on every row, so the whole file is rejected because of one optional column.

**Fix**
- Support `X` (RAW): a hex text value of exactly `2 × leng` characters that contains only hex digits (`CO '0123456789ABCDEFabcdef'`), assigned to an xstring and then to the field. Also accept the 36-character UUID form with dashes by removing them.
- Support `y` (RAWSTRING) the same way, without the length check.
- Support UTCLONG (`p` in DDIC as of 7.54) with ISO `YYYY-MM-DDThh:mm:ss[.fffffff]`, using `CONV utclong( )` inside a `TRY` block.
- For any type still unsupported, decide in `build_column_map`. Ignore the column with **one** header warning, or raise an error only when it is a key field.

### R5 — No reusable `it_solix` entry point; dialog only

**Where:** `upload_file` (830–865), class design.

The requirement describes a **utility that reads binary streams (`it_solix`)**. TBL2 creates `it_solix` itself from `GUI_UPLOAD`, inside a local class of a report. As a result:

- Nothing else can call it: not a Fiori/OData upload, not an AL11 file, not a mail attachment, not a background job.
- A large file runs in dialog. At the 500,000-row limit, the default dialog time limit (`rdisp/max_wprun_time`, often 600 s) can end the run with `TIME_OUT`, and then no log is saved at all.

**Fix**
- Move the class to a global class, for example `ZCL_EXCEL_TABLE_LOADER`, with a public method:
  ```abap
  METHODS load
    IMPORTING it_solix   TYPE solix_tab
              iv_size    TYPE i
              iv_tabname TYPE tabname
              is_options TYPE ty_options      " date format, test mode, package size, strict, ...
    RETURNING VALUE(rt_log) TYPE tt_log.
  ```
  The report then only does `GUI_UPLOAD` → `load( )` → ALV. That is the exact `it_solix` contract the requirement describes.
- For large files: upload in dialog, store the xstring in a staging table (or `EXPORT ... TO DATABASE`), and `SUBMIT` the load as a background job. The application log (M5) is where the result is read.

### R6 — No "all or nothing" option

**Where:** `run` (585ff.), `write_to_db`.

TBL2 inserts the valid rows even when other rows were rejected. Partial loads are often unwanted: a price list with 3 bad rows out of 1,000 ends up 997/1,000 loaded, and the missing rows must be re-sent separately. **Fix:** add a parameter `p_strict` (default on for live runs). When `mv_error_rows > 0`, do not write, and log "N row(s) rejected - nothing was written (strict mode)".

### R7 — Workbooks using the 1904 date system

**Where:** `convert_date` serial branch (1186).

Workbooks created with the *1904 date system* option (older Mac Excel, or set in Excel's options) store serials 1,462 days lower. TBL2 always uses the 1900 epoch, so every date cell in such a file is **4 years and 1 day too early**, with no warning.

**Fix:** after upload, open the xstring with `cl_abap_zip`. Read `xl/workbook.xml` and check for `date1904="1"` (or `date1904="true"`). If found, add 1,462 days to every serial in `convert_date`. This costs a few lines and needs no change to the parser.

### R8 — Throughput at the row limit

**Where:** `normalize_value` (1524–1530), `parse_rows` (1099).

- `normalize_value` runs a PCRE `REPLACE` on **every** cell. At 500,000 rows × 30 columns, that is 15 million regex calls, which takes minutes and adds to R5's time-out risk. **Fix:** add a fast path such as `IF rv_value CA lc_special` (NBSP, tab, CR, LF) before the regex, because most cells contain none of these.
- The in-file duplicate check inserts the **full row** into a second hashed table, which doubles the memory for the data. **Fix:** build `mo_key_type` from a structure with only the key fields (RTTS `cl_abap_structdescr=>get( )` over the key components), and move only those fields across with `MOVE-CORRESPONDING`.
- Consider lowering `c_max_rows` to about 200,000 for dialog runs until R5 provides the background path.

### R9 — The table lock may not block every writer (verify)

**Where:** `lock_table` (1598ff.).

`ENQUEUE_E_TABLE` sets the generic table lock that SM30 and SE16N use. A Z application that locks rows of the same table with **its own lock object** (`EZ_...`) may not collide with this lock: the lock argument differs, so both could write at once. Check this in SM12 with both locks held. If they do not collide, also set the table's own lock object (if one exists) with an empty key, or document that the table must not be maintained by other programs during a load.

---

## Low

- **R10. Field symbol not checked (1043, 1064).** `ASSIGN COMPONENT ls_map-fieldname ... TO FIELD-SYMBOL(<lv_target>)` has no `sy-subrc` check. If the assignment fails, `<lv_target>` still points to the **previous** field, and the value is written into the wrong column. This is unlikely with DDIC names, but check `sy-subrc` and raise an error.
- **R11. Vague upload errors (848–853).** `GUI_UPLOAD` uses `EXCEPTIONS OTHERS = 1`, so "file not found", "file is open in Excel", "access denied" and "no authority" all become "could not be uploaded". Map at least `file_open_error`, `file_read_error`, `access_denied` and `no_authority` to their own messages. The most common cause, "file is open in Excel", is worth naming.
- **R12. File type checked late.** Check that the first bytes are the ZIP signature `50 4B 03 04` right after upload. An `.xls` or `.csv` renamed to `.xlsx` then gets "this is not an .xlsx file - save it as Excel Workbook" instead of a parser error.
- **R13. Only the first worksheet (883).** If that sheet is hidden, or the data is on another sheet, the user gets a confusing header error. Add an optional sheet-name parameter, and log the name of the sheet that was read.
- **R14. Silent precision loss above 15 digits (1294–1295).** A *typed* value with more than 17 significant digits and a fraction (for a DEC(31,x) field) is rounded to 15 digits, and the rounding check compares against the already-rounded value, so no warning appears. Round only values with 16–17 significant digits (the binary-double case), or warn when rounding changes a value with more than 17 digits.
- **R15. Boolean cells.** Excel TRUE/FALSE arrive as `1`/`0`. A flag field (`XFELD`/`BOOLE_D`) then receives `1` instead of `X`. R1's fixed-value check would catch this. A mapping `1 → X`, `0 → space` for CHAR1 fields whose fixed values are `X`/space would accept it instead.
- **R16. Invisible characters.** `normalize_value` does not remove the zero-width space (U+200B), BOM (U+FEFF) or soft hyphen (U+00AD), which are often pasted in from web pages. Add them to the character class. A key containing them looks equal to an existing key, but it is not.

---

## Already done well (relative to the requirement)

- **Binary path is correct:** `BIN` upload → `solix_tab` → `solix_to_xstring` with the real file length, so trailing padding in the last line of the stream is not passed to the parser.
- **Metadata use goes beyond types:** conversion exits on the external length, lowercase flags, currency reference fields with TCURX shifting, and a key type built with RTTS from the real key fields.
- **Defence in depth:** namespace, whitelist, table class, delivery class, maintenance flag, SCC4, `S_TABU_*`, the test run by default, a lock, one LUW, and an audit log in SLG1.
- **No dynamic-SQL injection surface:** table and field names in dynamic SQL and the conversion exit's function module name come only from the DDIC, after the table has been validated.
- **Behaviour can be traced:** each rejected row and each rejected field is logged against its Excel row, with the exception chain.

## Suggested order of work

1. **R1 and R2.** These close the "safely" gap: no value reaches the table that SM30 would refuse.
2. **R4.** Makes "any table" true for GUID-keyed tables.
3. **R5.** Global class with the `load( it_solix ... )` method. This makes it a utility, and is a prerequisite for background loads.
4. **R6, R3 and R7.** Strict mode, sign check and 1904 dates: small changes that prevent wrong data.
5. **R8 and R9.** Throughput and lock scope before production volumes.
6. **R10–R16.** Low items, together with unit tests for each one.

# ZDEMO_SECURE_DYNAMIC_EXCEL_TBL2 — changes

Version **TBL2** of [ZDEMO_SECURE_DYNAMIC_EXCEL](../zdemo_secure_dynamic_excel/zdemo_secure_dynamic_excel.prog.abap). It addresses every finding in the [review](../zdemo_secure_dynamic_excel/REVIEW.md). The original program is unchanged, so both can exist side by side in one system.

Source: [zdemo_secure_dynamic_excel_tbl2.prog.abap](zdemo_secure_dynamic_excel_tbl2.prog.abap)

> **Not yet compiled or run on an SAP system.** This code was written outside SAP. Before transporting it, run the syntax check, the extended check (SLIN), ATC and the unit tests (Ctrl+Shift+F10), and then do a test run against a sandbox table.

## What changed, by finding

| # | Finding | What TBL2 does | Where |
|---|---|---|---|
| H1 | A `MESSAGE` from a conversion exit stops the run | `EXCEPTIONS error_message = 1`. The exit's message text is written to the row log, and the row is rejected. | `apply_conversion_exit` |
| H2 | The length check runs before the conversion exit | New `outputlen` in the column map. `max_input_length` uses `outputlen` when an exit exists, otherwise `leng`. A value that is too long for an exit field is an error and is never truncated. | `convert_text`, `convert_cell` (NUMC), `max_input_length` |
| H3 | Empty key cells are accepted | The fields filled in each row are recorded. An empty key cell rejects the row with "Key field is empty". | `parse_rows` |
| H4 | Controls that SM30 respects are bypassed | Rejects tables with `MAINFLAG = 'N'`. Accepts delivery class A/L. Accepts C/G only when the user ticks **Allow Customizing tables** *and* SCC4 allows changes without transports (client-specific: `CCCORACTIV` blank or `3`; cross-client: `CCNOCLIIND` not `1`/`3`). Always rejects E/S/W. Uses an optional whitelist table `ZUPLOAD_ALLOWED`. | `validate_table`, `check_change_settings`, `check_whitelist` |
| M1 | CURR amounts are stored as entered | Amounts are converted in a second pass, after the row's currency field has been converted. Internal value = external × 10^(TCURX decimals − field decimals), so 1000 JPY becomes 10.00. Rejected: unknown currency, an empty currency field, a reference field in another table, and more decimals than the currency allows. | `parse_rows`, `convert_amount`, `get_reference_currency`, `get_currency_decimals`, `shift_amount` |
| M2 | Integers in time cells become 00:00:00 | 1–2 digits are read as an hour (`8` → 08:00:00). Only values with a decimal point are read as Excel fractions. 3- and 5-digit integers are rejected. | `convert_time` |
| M3 | Floating-point values from Excel | Fractional numbers are rounded to 15 significant digits (Excel's precision) before storing and before the rounding check. Raw doubles in CHAR and NUMC cells (`1.2345678901234567E+19`, `12.300000000000001`) are rewritten as plain text, with a warning for CHAR fields. | `parse_number`, `excel_number_to_text` |
| M4 | The test run ignores keys already in the database | `check_existing_keys` reads the keys with `FOR ALL ENTRIES` in both modes: in the live run under the lock, just before the insert. Every existing key is logged against its Excel row. | `check_existing_keys`, `run` |
| M5 | No audit trail | The whole log, with a header line (user, file, table, test/live), is saved with `BAL_DB_SAVE` and can be viewed in SLG1. If object `ZUPLOAD` does not exist, the run continues with a warning. | `save_application_log` |
| M6 | Unreleased parser, no size limit | New parameter **p_maxmb** (default 20 MB) and a limit of 500,000 rows. The parser is used only in `read_worksheet`, and the header names `XCO_CP_XLSX` as the replacement. | `upload_file`, `read_worksheet` |
| M7 | Row number assumption | Stated in the header: data starts in A1, and the row number is the position in the parser's itab. | header |
| L1 | Ambiguous duplicate key | A hashed table built with RTTS on the real key fields replaces the `\|`-joined string key. The same type is used for the database check. | `check_key_coverage`, `parse_rows` |
| L2 | Four-digit dates | Values 1900–2099 give "looks like a year". Other serials ≥ 61 still work, so Excel date cells before 1927 are still accepted. | `convert_date` |
| L3 | Previous exception not shown | `full_text` adds the whole `PREVIOUS` chain to the log. Messages that used to repeat the cause inline no longer do. | `full_text`, `run`, `parse_rows` |
| L4 | String passed to an untyped exit parameter | The input is copied into a `CHAR` buffer of `max(outputlen, strlen)`. | `apply_conversion_exit` |
| L5 | Misleading "key already exists" | Keys already in the database are removed before the insert. Anything the DB still skips is reported as "duplicate key or unique index". | `write_to_db` |
| L6 | Valid count missing in live mode | The live run logs rows read, valid, already in the DB, rejected and inserted. | `write_to_db` |
| L7 | Warnings for rows that end up rejected | Row messages are buffered (`add_log` / `flush_row_log`). They are kept for accepted and rejected rows, and dropped for rows skipped as in-file duplicates. | `add_log`, `flush_row_log`, `parse_rows` |
| L8 | Unused variable, ABAP Doc placement | `SPLIT` is replaced by `segment( )`. The `"!` comment inside `show_log` is now `"`. | `convert_date`, `show_log` |
| L9 | No unit tests | Local test class `LTC_IMPORTER` with 12 test methods covering dates, times, numbers, raw doubles, the JPY/KWD shift, ISOLA, over-long keys and normalisation. | end of file |

## New selection-screen fields

| Field | Default | Meaning | Selection text to maintain |
|---|---|---|---|
| `P_MAXMB` | 20 | Maximum file size in MB (1–1000) | Max. file size (MB) |
| `P_CUST` | off | Allow Customizing tables (delivery class C/G) when SCC4 permits | Allow Customizing tables |

## Optional setup

1. **SLG0**: create the application log object `ZUPLOAD`. Without it, the run works but the log is not saved.
2. **Whitelist** (recommended): create the table `ZUPLOAD_ALLOWED` with key fields `MANDT` (optional) and `TABNAME` (type `TABNAME`), and list each table that may be loaded. Once the table exists, every table not listed in it is rejected.
3. **Transaction**: create a transaction for the report with its own authorization object, so that `S_TABU_DIS` alone is not enough to use the tool.

## Behaviour changes to tell users about

- A row with an empty key cell is now rejected. Before, it was inserted with an initial key.
- Amounts in currencies whose decimals are not 2 are now stored correctly. Data loaded earlier with the old version may be wrong by a factor of 10^n and should be checked.
- A test run now commits once, to save the application log. No table data is written.
- Customizing tables are rejected unless **Allow Customizing tables** is ticked.

## What to check on the system

These spots rely on behaviour that could not be verified outside SAP:

- `check_existing_keys`: a dynamic `FOR ALL ENTRIES` condition that refers to the field symbol `@<lt_target>-<field>`.
- `excel_number_to_text`: the output of `STYLE = SIMPLE` for `decfloat34`. The trailing-zero cleanup afterwards is a safety net.
- `read_worksheet`: whether `CL_FDT_XL_SPREADSHEET` keeps empty rows. This decides whether the row numbers in the log are right (M7).

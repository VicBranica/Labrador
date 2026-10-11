# Review — ZDEMO_SECURE_DYNAMIC_EXCEL

Source: [zdemo_secure_dynamic_excel.prog.abap](zdemo_secure_dynamic_excel.prog.abap) (1,147 lines). Reviewed on 2026-10-11 by reading the code; nothing was run on an SAP system. Line numbers refer to that file.

**Status:** all findings are addressed in version [TBL2](../zdemo_secure_dynamic_excel_tbl2/CHANGES.md).

## Verdict

The code is well structured and much better than a typical upload tool. It has a test run on by default, restricts uploads to customer tables, runs an authorization check, locks the table, commits once, rejects a row on any error and shows a clear ALV log. The syntax looks right for ABAP 7.55+.

It is **not ready for production yet**. Four High findings must be fixed first:

1. A conversion exit that issues a `MESSAGE` stops the whole run (H1).
2. The length check runs before the conversion exit, which breaks language fields and corrupts other fields (H2).
3. Rows with empty key fields are inserted (H3).
4. The program skips the client change settings, delivery class and maintenance flag that SM30 respects (H4).

| # | Severity | Finding | Lines |
|---|---|---|---|
| H1 | High | `ERROR_MESSAGE` is not handled when the conversion exit is called, so a `MESSAGE E` stops the run | 975–981 |
| H2 | High | The length check and truncation use the internal length before the conversion exit runs, which breaks LANG/ISOLA and similar fields | 948–965 |
| H3 | High | Empty key cells are accepted, so records with initial keys are inserted | 708–710, 738–747 |
| H4 | High | Client change settings, delivery class and maintenance flag are not checked, so the program bypasses SM30 and transport controls | 474–519 |
| M1 | Medium | CURR amounts are stored as entered, so JPY/KWD/... values are wrong by a factor of 10^n | 917–919 |
| M2 | Medium | Integers in TIMS cells (`8`, `123`, `12345`) are silently stored as `00:00:00` | 870–878 |
| M3 | Medium | Floating-point values from Excel cause false "rounded" warnings and raw values in CHAR/NUMC fields | 762, 928–936, 964 |
| M4 | Medium | The test run does not check keys already in the database, so its "valid" count is too high | 436–438 |
| M5 | Medium | There is no audit trail of who loaded what into which table | — |
| M6 | Medium | The parser is not a released API, and the file size is not limited | 554–583 |
| M7 | Medium | The row number in the log assumes the sheet starts at A1 with no skipped rows | 695–696 |
| L1–L9 | Low | Robustness and readability items | see below |

---

## High

### H1 — A `MESSAGE` from a conversion exit stops the run (lines 975–981)

```abap
CALL FUNCTION lv_fm
  EXPORTING input  = iv_value
  IMPORTING output = cv_target
  EXCEPTIONS OTHERS = 1.
```

`OTHERS` catches only classic exceptions. It does **not** catch the special exception `ERROR_MESSAGE`. Many exits report a bad value with `MESSAGE ... TYPE 'E'` instead of `RAISE`, especially customer Z exits and some older SAP exits. The `CATCH cx_root` in `run` cannot catch such a message either.

What happens: the dialog run stops in the middle of `parse_rows`, the user sees one status-bar message and no log, and the purpose of "reject the row and keep going" is lost.

**Fix**

```abap
      EXCEPTIONS
        error_message = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW lcx_error(
        iv_text = COND #( WHEN sy-subrc = 1 AND sy-msgid IS NOT INITIAL
                          THEN |'{ iv_value }': { message_text( ) }|   " build from SY-MSG*
                          ELSE |'{ iv_value }' rejected by conversion exit { is_map-convexit }.| ) ).
```

`message_text( )` is a placeholder. Build the text from `sy-msgid`/`sy-msgno`/`sy-msgv1..4`, for example with `MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno WITH ... INTO DATA(lv_msg)`.

### H2 — The length check runs before the conversion exit (lines 948–965)

`convert_text` compares the **external** input with `dfies-leng`, which is the **internal** length. It truncates the value and only then calls the exit. These two lengths differ for several common exits:

| Field | `leng` | External input | Result |
|---|---|---|---|
| `SPRAS` (exit ISOLA) | 1 | `EN` | Key field: rejected as "exceeds 1 character". Non-key field: truncated to `E`, then ISOLA fails or maps to the wrong language. |
| Any exit with `outputlen > leng` | n | longer external form | Wrongly rejected or truncated |

So language fields cannot be uploaded with ISO codes, which is how people type them.

**Fix:** when an exit is present, check the input against `dfies-outputlen`, let the exit do the conversion, and check the length only when there is no exit. Add `outputlen` to `ty_col_map`.

```abap
DATA(lv_max) = COND i( WHEN is_map-convexit IS NOT INITIAL THEN is_map-outputlen
                       ELSE is_map-leng ).
IF lv_max > 0 AND strlen( lv_text ) > lv_max.
  ...   " same key-error / non-key-truncate logic, using lv_max
ENDIF.
```

### H3 — Empty key cells are accepted (lines 708–710, 738–747)

An empty cell is skipped (`CONTINUE`), and the field keeps its initial value. `check_key_coverage` only checks that a key **column** exists, not that each row has a value in it. So a row with a blank key cell (for example a material number) is converted, passes the duplicate check once, and is inserted with key `''` or `000000`. The second such row is then reported as a "duplicate within the file", which is confusing.

**Fix:** after the column loop in `parse_rows`, reject the row when any field in `mt_key_fields` is initial, unless the table allows initial keys by design. If it does, make that an explicit option.

### H4 — The program bypasses the controls SM30 respects (lines 474–519)

`VIEW_AUTHORITY_CHECK` covers only S_TABU_DIS, S_TABU_NAM and S_TABU_CLI. SM30/SE16N also respect the following, and this program checks none of them:

- **Client change settings (SCC4 / T000-CCCORACTIV).** In a production client with "no changes allowed", Customizing tables (delivery class C, G, E, S) can still be changed here directly, without a transport.
- **Delivery class (DD02L-CONTFLAG).** The comment says "Use only for custom tables that have no such logic", but the code does not enforce it.
- **Table maintenance flag (DD02L-MAINFLAG).** `'N'` means "display/maintenance not allowed", and the program ignores it.

The namespace check (Z*/Y*) is the only filter, and many Z tables are Customizing tables.

**Fix:** read `contflag` and `mainflag` in the existing `SELECT SINGLE` on DD02L. Reject `mainflag = 'N'`. Accept only `contflag = 'A'` (application data), or check `T000` for the current client when you accept C/G. Better still, add a whitelist table (for example `ZUPLOAD_ALLOWED`: table name plus an optional authorization group) and a dedicated transaction with its own authorization object, so that S_TABU_DIS alone does not open every Z table to this program.

---

## Medium

### M1 — Currency amounts (lines 917–919)

The header says this limitation is known, but the result is silent data corruption. For JPY, `1000` must be stored internally as `10.00`. As written, the program stores 1000.00, which is 100 times too much. The same applies to every currency whose TCURX decimals are not 2.

**Fix:** convert CURR fields in a second pass after every field of the row is filled. Use `dfies-reftable`/`reffield` to find the currency field and call `BAPI_CURRENCY_CONV_TO_INTERNAL` or `CURRENCY_AMOUNT_DISPLAY_TO_SAP`. At the very least, reject the row when the reference currency has TCURX decimals other than 2.

### M2 — Integers in time cells (lines 870–878)

The pattern `^\d*\.?\d+$` also matches plain integers. `frac( 8 ) = 0`, so `8`, `123` or `12345` silently become `00:00:00`. A user who types `8` meaning 08:00 gets midnight and no warning.

**Fix:** treat only values with a decimal point as Excel fractions (`^\d*\.\d+$`, or a value between 0 and 1 for a pure time). Reject other integer lengths, or map 1–2 digits to `HH0000`.

### M3 — Floating-point values from Excel (lines 762, 928–936, 964)

`cl_fdt_xl_spreadsheet` returns the raw XML value of numeric cells, and Excel stores binary doubles. This causes three problems:

- A cell showing `12.3` is often stored as `12.300000000000001`. The rounding check then warns "rounded to 12.30" on many correct rows, and real warnings get lost among them.
- A numeric cell mapped to a CHAR field stores the raw form, for example `1.2345678901234567E+19` or `0.10000000000000001`.
- A large numeric cell mapped to a NUMC field arrives in scientific notation and is rejected with "non-digit characters".

**Fix:** before the rounding comparison, round `lv_number` to 15 significant digits, which is Excel's precision. Warn only if the difference remains after that. For CHAR and NUMC targets, normalise numeric-looking values that contain `E` or a long fraction, or tell users to format such columns as Text.

### M4 — The test run does not check keys already in the database (lines 436–438)

The test run reports "N valid". The live run then quietly skips every row whose key already exists (`ACCEPTING DUPLICATE KEYS`). The test run should predict that.

**Fix:** in test mode, run `SELECT ... FOR ALL ENTRIES IN <lt_target>` on the key fields (dynamic `WHERE`, in packages), and report the existing keys as warnings for each row.

### M5 — No audit trail

A generic direct-insert tool is exactly what an auditor will ask about. Today nothing records who loaded which file into which table, when, or how many rows. The ALV log disappears when the screen closes.

**Fix:** write the log to the application log (BAL; object/subobject such as `ZUPLOAD/<table>`), including user, file name, table, the test/live flag and the counts. Save it even for test runs.

### M6 — Parser API and file size (lines 554–583)

- `CL_FDT_XL_SPREADSHEET` belongs to BRFplus and is **not a released API**. It can change in any support package, and it is not available in ABAP Cloud. On S/4HANA 2022+ prefer `XCO_CP_XLSX`. Otherwise use abap2xlsx.
- There is no size limit. A 100 MB workbook is loaded as an xstring, then as a table of strings, then as the target table, then as package copies. That can cause a memory dump (`TSV_TNEW_PAGE_ALLOC_FAILED`). Reject files above a configurable limit after `GUI_UPLOAD` (`lv_len`), and limit the number of rows after `read_worksheet`.

### M7 — Row number in the log (lines 695–696)

`lv_row = sy-tabix` is correct only when the first row of the itab is Excel row 1 and the itab has no gaps. Check how `get_itab_from_worksheet` handles a sheet that starts below row 1 or contains missing (never-touched) rows. If it compacts them, every row number in the log after a gap is wrong. If so, read the real row index from the sheet, or state the limitation in the header ("data must start at A1, no fully empty rows").

---

## Low

- **L1. Ambiguous duplicate key (lines 1004–1011).** `build_row_key` joins the values with `|`. The keys (`A|`, `B`) and (`A`, `|B`) produce the same string. This is unlikely in practice, but a hashed table typed with the target's key fields (or a `SORTED` table of the line type with the key) is exact and needs no string building.
- **L2. Four-digit dates (lines 805–813).** `2024` in a date cell is read as an Excel serial number and becomes 16.07.1905. Require at least 5 digits for the serial branch (serial 10000 = 18.05.1927), or reject 4-digit values with a hint.
- **L3. Previous exception not shown (lines 445–447).** The exceptions are chained (R-3), but the log shows only the outer text. Add `lx_error->previous->get_text( )` when it is bound. Otherwise the root cause recorded by R-3 never reaches the user.
- **L4. String passed to an untyped exit parameter (line 977).** Some exits use offset/length access (`input+n(m)`), and that fails on a string shorter than expected. Copy the value into a `CHAR` buffer of `outputlen` first, created with `CREATE DATA ... TYPE c LENGTH`.
- **L5. Misleading "key already exists" message (line 1068).** `ACCEPTING DUPLICATE KEYS` also suppresses violations of a **unique secondary index**. The final message then says "key already exists in the database", which can be wrong. Word it as "duplicate key or unique index".
- **L6. Valid count missing in live mode (lines 1083–1092).** The live run logs inserted, skipped and rejected rows, but not the number of rows read or valid. Add it so that the totals add up for the reader.
- **L7. Warnings for rows that end up rejected (lines 739–744).** Rounding and truncation warnings are logged for a row that is later skipped as an in-file duplicate. Collect the warnings for each row and log them only if the row is kept, or mark them "row skipped".
- **L8. Unused variable and ABAP Doc placement.** `lv_time_part` (line 797) is never used, and the extended check flags it; use `SPLIT ... INTO lv_date_part DATA(lv_dummy)` or `segment( )`. The `"!` ABAP Doc comment inside `show_log` (line 1097) gives a "wrong position" warning, so use a normal `"` comment.
- **L9. No unit tests.** `convert_date`, `convert_time`, `convert_number`, `normalize_value` and `build_row_key` are pure functions and easy to cover. A local `FOR TESTING` class with the edge cases from this review would protect the fixes: `EN` → ISOLA, `8` as a time, `12.300000000000001`, an empty key, JPY, `31.02.2024`, serial `60`/`61`, `23:59:59.6`.

---

## What is already done well

- The test run is on by default. Writes are atomic, with one `COMMIT WORK` and `ROLLBACK WORK` on any error.
- The table is checked to be an active **transparent** table, and the client is never taken from the file, so implicit client handling applies.
- The table is locked (`ENQUEUE_E_TABLE`) only for the write, and the lock is released on every path.
- Every cell error rejects the whole row. The in-file duplicate check uses the **converted** values (L-9).
- Excel serial dates are calculated from a constant epoch with range checks, and impossible dates are caught by `DATE_CHECK_PLAUSIBILITY`.
- Numbers are parsed into `decfloat34`, with overflow caught and the rounding compared numerically instead of as text.
- Headers are normalised, unknown, duplicate and client columns produce warnings, and every key column is required.
- The ALV shows traffic lights and has a list fallback. Exception classes keep `PREVIOUS`.

## Suggested order of work

1. H1 and H2: small, local changes that fix aborted runs and wrong languages.
2. H3 and H4: block bad keys and close the governance gap. Add the whitelist table and transaction here.
3. M1 and M2: stop silent wrong values.
4. M4 and M5: make the test run predict the live run, and keep a permanent log.
5. L9: add unit tests before any further change.

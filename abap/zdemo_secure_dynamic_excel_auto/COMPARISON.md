# Comparison — AUTO version vs. TBL2

| | **AUTO** (this folder) | **TBL2** |
|---|---|---|
| Source | [zdemo_secure_dynamic_excel.prog.abap](zdemo_secure_dynamic_excel.prog.abap), 844 lines, as received | [zdemo_secure_dynamic_excel_tbl2.prog.abap](../zdemo_secure_dynamic_excel_tbl2/zdemo_secure_dynamic_excel_tbl2.prog.abap), 1,979 lines |
| Idea | Loads an *unstructured* sheet: finds the header row automatically, matches columns by field name **or field label**, and **creates the table in the DDIC** if it does not exist | Loads a *structured* sheet into an **existing** table: header in row 1, columns named with technical field names |

"AUTO" is only a working name for this version, which arrived with the same report name as the original (`ZDEMO_SECURE_DYNAMIC_EXCEL`). Line numbers below refer to the AUTO file. Reviewed on 2026-10-11 by reading the code; nothing was compiled or run.

The yardstick is the agreed requirement:

> A robust, metadata-driven utility designed to read local Excel files (.xlsx) via binary streams (`it_solix`) and safely upload their contents into any custom SAP transparent database table (Z\* or Y\*).

## Verdict

**Keep TBL2 as the base. Do not use AUTO as it stands.** AUTO has three good ideas worth moving into the next version.

- **AUTO does not compile.** `create_table_dynamically` uses fields that do not exist in `DD02V`, and one line is missing the blank before `=` (A1).
- **Even with that fixed, the feature that defines it is the least safe part.** If the table does not exist, any user who can start the report can create a DDIC table. That skips every authorization check (`auth_chk = abap_false`), the package, the transport system and the system change option (A2). This is the opposite of *"safely"*. It also goes beyond the requirement, which is to load into existing custom tables, not to create them.
- **The header detection has a bug that silently skips data rows** (A3).
- **What AUTO does better**, and TBL3 should take over:
  1. Detecting a header row that is not in row 1
  2. Matching columns by **field label** as well as technical name
  3. A log with **column letter and cell value**
  4. A user choice between **all-or-nothing** and **skip existing keys**

---

## At a glance

| Area | AUTO | TBL2 | Better |
|---|---|---|---|
| Compiles | ❌ No (A1) | Not verified on a system; no known syntax errors | TBL2 |
| Binary upload (`it_solix`) | ✅ `cl_gui_frontend_services=>gui_upload` BIN → `solix_to_xstring` | ✅ `GUI_UPLOAD` BIN → `solix_to_xstring` | Same |
| File size / row limits | ❌ None | ✅ `p_maxmb`, 500,000 rows | TBL2 |
| Header row | ✅ Auto-detected in the first 15 rows, but with a bug (A3) | Fixed at row 1 | **AUTO** (idea) |
| Column matching | ✅ Technical name, then field label (`fieldtext`/`reptext`) | Technical name only | **AUTO** |
| Unknown columns | ❌ Dropped silently | ⚠️ Warning for each column | TBL2 |
| Table must exist | ❌ Creates it (A2) | ✅ Required | TBL2 |
| Z\*/Y\* check | ✅ | ✅ (+ optional whitelist) | TBL2 |
| Transparent check | ✅ for existing tables | ✅ | Same |
| Delivery class / maintenance flag / SCC4 | ❌ | ✅ | TBL2 |
| Authorization | ⚠️ `S_TABU_NAM` only; **none** when the table is created (A2, A6) | ✅ `VIEW_AUTHORITY_CHECK` (`S_TABU_DIS`/`NAM`/`CLI`) | TBL2 |
| Key fields present in file | ❌ Not checked | ✅ Required | TBL2 |
| Empty key cells | ❌ Inserted | ✅ Row rejected | TBL2 |
| Duplicates within file | ❌ Not checked: they abort the load, or are dropped silently with `p_skipd` | ✅ Detected and logged per row | TBL2 |
| Keys already in DB | ⚠️ All-or-nothing, or skip with a count; not in test run | ✅ Logged per row, in test and live runs | TBL2 |
| All-or-nothing option | ✅ Default (no `p_skipd`) | ❌ Partial loads only (R6) | **AUTO** |
| Conversion exits | ⚠️ `OTHERS` only, call errors swallowed (A7) | ✅ `error_message`, `outputlen`, CHAR buffer | TBL2 |
| Upper/lower case | ❌ Domain flag ignored | ✅ Like SM30 | TBL2 |
| CHAR truncation of a key | ❌ Warning only, so a different key is written (A8) | ✅ Error | TBL2 |
| Numbers | ⚠️ Silent rounding, no float-noise handling | ✅ decfloat34, rounding warning, 15-digit noise handling | TBL2 |
| Currency amounts (JPY …) | ❌ No shift | ✅ TCURX shift | TBL2 |
| Dates | ⚠️ EU only; `2024` → 1905; serials 1–60 wrong | ✅ EU/US, ISO, serial, plausibility, year guard | TBL2 |
| Times | ✅ Rejects integers; `0` (midnight) rejected | ✅ | TBL2 (slightly) |
| RAW fields | ✅ Hex text via direct assignment (`WHEN OTHERS`) | ❌ Unsupported (R4) | **AUTO** |
| Text clean-up | ⚠️ `CONDENSE` also collapses inner spaces (`A  B` → `A B`); NBSP not handled | ✅ Trims ends only, handles NBSP/tab/CR/LF | TBL2 |
| Lock / LUW | ✅ `E_TABLE` lock, one `COMMIT`/`ROLLBACK` | ✅ Same, plus a DB key check under the lock | TBL2 |
| Log | ✅ **Column letter + cell value**, summary rows | ✅ Row, field, traffic lights, SLG1 audit log | Both, merge them |
| Errors before the load | Status-bar message only, no ALV | Always ALV + SLG1 | TBL2 |
| Unit tests | ❌ | ✅ 12 test methods | TBL2 |

---

## Requirement fit

| Requirement element | AUTO | TBL2 |
|---|---|---|
| Robust | ❌ Does not compile; row-skipping bug; no limits; silent drops | ⚠️ Partly (see TBL2's [requirements review](../zdemo_secure_dynamic_excel_tbl2/REQUIREMENTS-REVIEW.md)) |
| Metadata-driven | ⚠️ Uses `inttype`, `leng`, `convexit` and labels; ignores lowercase, decimals, currency reference, keys, fixed values, check tables | ⚠️ Uses most DDIC attributes; ignores fixed values, check tables, sign |
| Local .xlsx via `it_solix` | ✅ Same mechanism as TBL2; also no reusable `it_solix` entry point | ✅ / ⚠️ same gap |
| Safely | ❌ DDIC creation without authorization (A2); weak table authorization; key errors written to the DB | ⚠️ Partly |
| Any Z\*/Y\* transparent table | ⚠️ Goes beyond: it *creates* tables (out of scope). RAW handled better | ⚠️ Partly: RAW keys unsupported; Customizing tables limited on purpose |

---

## Defects in AUTO

### A1 — Does not compile (lines 394–403)

- `ls_dd02v-delivery`, `ls_dd02v-devclass` and `ls_dd02v-tabform` are not fields of `DD02V`. The package (`DEVCLASS`) belongs in `TADIR`, not in the table header.
- `ls_dd02v-ddlanguage= sy-langu.` (line 397) has no blank before `=`, which is a syntax error in ABAP.
- `ls_dd09l-tabfkart` and `ls_dd09l-bufstat` (402–403) are probably not `DD09L` fields either; check them in SE11. The technical settings also lack the size category (`TABKAT`), which activation requires.

### A2 — A DDIC table is created without any control (lines 229, 261, 385–470) — Critical

When the table does not exist, `check_table` sets the flag (229), and `check_authority` then skips **all** checks (261). `create_table_dynamically` then:

- writes the definition with `DDIF_TABL_PUT` and activates it with **`auth_chk = abap_false`** (456), so no `S_DEVELOP` check is made;
- does not assign a package, does not create a `TADIR` entry or a transport request, and does not check the system change option (SE06). This can happen **in production**, by an end user, with no record in the transport system;
- builds field names directly from the cell text (422), with no check for a leading digit, length (max. 30), reserved words, `MANDT` or duplicates. A header such as `Name` twice, `2024` or a 40-character label makes the activation fail, or makes it create an unexpected structure;
- types every field `CHAR 255` and makes the **first column the only key** (428). A repeated value in that column then aborts the load (without `p_skipd`) or silently drops rows (with `p_skipd`). Dates and numbers lose their type.

A mistyped table name in the selection screen is enough to create a new, permanent table. **Remove this feature from the upload tool.** If it is really needed, it belongs in a separate developer tool that requires `S_DEVELOP`, a package and a transport request, and runs only in development systems.

### A3 — The header-row detection skips data rows (lines 360–371)

```abap
APPEND VALUE #( col = lv_col name = lv_norm ) TO lt_cand_hdr.   " sets SY-TABIX
...
lv_best_row = sy-tabix.
```

`APPEND` sets `sy-tabix` to the index of the appended line in `lt_cand_hdr`. After the `DO` loop, `sy-tabix` is therefore the **number of non-empty header cells**, not the worksheet row. With a header in row 1 and 10 columns, `mv_header_row` becomes 10, so `build_rows` starts at row 11 and **rows 2–10 are silently skipped**. The log even reports "Header row auto-detected at Excel row: 10".

**Fix:** save `DATA(lv_row_idx) = sy-tabix.` at the top of the outer `LOOP`, and use it.

The heuristic "row with the most non-empty cells wins" is also fragile. A fully filled data row beats a header that has one empty cell. A better rule is the row with the most cells that **match a field name or label**, with ties going to the first row.

### A4 — Key fields and empty keys are not checked (lines 480–520, 540–600)

The program does not check that every key field has a column, and an empty key cell leaves the field initial. Rows with an initial key are inserted. Without `p_skipd`, the second such row aborts the whole load.

### A5 — Unmapped columns are dropped without a message (line 502)

A header that matches neither a field name nor a label is skipped with no log entry. A misspelled column means silently missing data. The label fallback compares `reptext` without first normalising it the way the header was (spaces vs. `_`), so labels with several words never match through `reptext` (495).

### A6 — Weak table authorization (lines 262–268)

Only `S_TABU_NAM` is checked. In the standard logic `S_TABU_NAM` is a fallback after `S_TABU_DIS`. Users who are authorized through `S_TABU_DIS` (authorization group) are therefore wrongly refused, and `S_TABU_CLI` is never checked for client-independent tables. `VIEW_AUTHORITY_CHECK`, as in TBL2, does all three.

### A7 — Conversion exits (lines 607–623)

- `EXCEPTIONS OTHERS = 1` does not catch `ERROR_MESSAGE`. An exit that issues `MESSAGE TYPE 'E'` stops the run (the same as finding H1 of the original review).
- `CATCH cx_sy_dyn_call_error.` is empty, so a missing exit is ignored silently and the value is moved unconverted.
- There is no length check before the exit and none after it.

### A8 — Truncating a key is only a warning (lines 657–661)

A CHAR value that is too long is truncated with a warning even for key fields. That writes a **different** record than the one in the file.

### A9 — Smaller items

- `CONDENSE lv_value` (557) collapses inner spaces, which changes text data, and does not handle the non-breaking space.
- `to_date`: only DD.MM.YYYY with exactly two digits each (682); no US format; `^\d{1,5}` reads `2024` as an Excel serial (1905); serials 1–60 are off by one day because of Excel's 1900 leap-year bug.
- Numbers: `cv_target = iv_value` rounds silently (`1.239` → `1.24`, `1.5` → `2` for INT). There are no currency shifts, and the error messages do not show the value.
- No check that the domain allows lower case, so `abc` is stored where SM30 would store `ABC`.
- `ASSIGN COMPONENT ... TO <lv_field>` has no `sy-subrc` check (the same as TBL2's R10).
- `METHODS get_text REDEFINITION` (22) redefines through the alias. This compiles on current releases, but `if_message~get_text` is the safer form.
- An error before `show_log` (an upload or parse error) gives only a status-bar message: no ALV and no stored log.
- The table is not locked during the test run. That is correct, but the test run does not report keys that already exist, so its "valid" count is too high (TBL2's M4).

---

## What TBL3 should take from AUTO

| From AUTO | How to add it to TBL2 safely |
|---|---|
| **Header row not in row 1** | Scan the first 15 rows. Choose the row with the most cells that match a field name or label, not the most non-empty cells, and fix the `sy-tabix` bug (A3). Log the row that was chosen. |
| **Match by field label** | After the technical name, compare the normalised header with the normalised `scrtext_s/m/l`, `reptext` and `fieldtext`. If two fields share a label, warn and ignore the column; never take the first match silently. Log every column matched by label ("Column C 'Plant' → WERKS"). |
| **Column letter + cell value in the log** | Add `excel_col` (via `col_letter`) and `value` to `ty_log`. This is a small change with a large benefit for users fixing their file. |
| **All-or-nothing vs. skip existing** | This is TBL2's R6: a strict-mode parameter (default on for live runs), with the current skip behaviour as the alternative. |
| **RAW as hex** | This is TBL2's R4, but validated: even length, hex digits only, `2 × leng`, and the UUID form with dashes. |

**Do not take:** dynamic table creation (A2), dropping columns silently (A5), `CONDENSE` on cell values (A9), the `S_TABU_NAM`-only check (A6).

## Suggested next step

Build **TBL3** from TBL2 with:

1. The five items from AUTO above.
2. The High items from TBL2's requirements review: fixed values and check tables (R1), and Excel error cells (R2).

That covers the strengths of both versions without the risks of AUTO.

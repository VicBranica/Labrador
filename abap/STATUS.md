# Status — Excel-to-Z-table upload utility

Last updated: 2026-10-11 · Branch `claude/dreamy-keller-q6yc78`.

## Requirement

> A robust, metadata-driven utility designed to read local Excel files (.xlsx) via binary streams (`it_solix`) and safely upload their contents into any custom SAP transparent database table (Z\* or Y\*).

## Summary

| Version | Folder | What it is | Status |
|---|---|---|---|
| Original | [zdemo_secure_dynamic_excel/](zdemo_secure_dynamic_excel/) | First version, kept as received | Reviewed: 4 High, 7 Medium, 9 Low findings. **Superseded by TBL2.** |
| **TBL2** | [zdemo_secure_dynamic_excel_tbl2/](zdemo_secure_dynamic_excel_tbl2/) | Improved version with unit tests (1,979 lines) | **Recommended base.** Every finding of the original review is fixed. Against the requirement, it is *mostly met*, with 16 gaps (2 High). |
| AUTO | [zdemo_secure_dynamic_excel_auto/](zdemo_secure_dynamic_excel_auto/) | Alternative version that finds the header row and creates the table if it is missing, kept as received | **Do not use.** It does not compile, it creates DDIC tables without authorization, and its header detection skips data rows. It has 5 ideas worth keeping. |

> None of the versions has been compiled or run on an SAP system. All findings come from reading the code.

## Documents

| Document | Content |
|---|---|
| [zdemo_secure_dynamic_excel/REVIEW.md](zdemo_secure_dynamic_excel/REVIEW.md) | Code review of the original |
| [zdemo_secure_dynamic_excel_tbl2/CHANGES.md](zdemo_secure_dynamic_excel_tbl2/CHANGES.md) | Every finding mapped to its fix in TBL2; new parameters; setup; behaviour changes |
| [zdemo_secure_dynamic_excel_tbl2/REQUIREMENTS-REVIEW.md](zdemo_secure_dynamic_excel_tbl2/REQUIREMENTS-REVIEW.md) | TBL2 checked against the requirement: coverage table and gaps R1–R16 |
| [zdemo_secure_dynamic_excel_auto/COMPARISON.md](zdemo_secure_dynamic_excel_auto/COMPARISON.md) | AUTO vs. TBL2: comparison in 32 areas, defects A1–A9, ideas to keep |

## Requirement coverage (TBL2)

| Requirement element | Status |
|---|---|
| Reads local files | ✅ Met |
| Binary stream (`it_solix`) | ⚠️ Partly: built internally; no reusable entry point that accepts `it_solix` (R5) |
| .xlsx format | ✅ Met (uses `CL_FDT_XL_SPREADSHEET`, not a released API) |
| Metadata-driven | ⚠️ Partly: fixed values, check tables and the sign flag are not used (R1, R3) |
| Any Z\*/Y\* table | ⚠️ Partly: RAW-key tables cannot be loaded (R4); Customizing tables are limited on purpose |
| Transparent tables only | ✅ Met |
| Safely | ⚠️ Partly: values outside the DDIC rules and Excel error cells get through (R1, R2); no all-or-nothing option (R6) |
| Robust | ⚠️ Partly: 1904 date system, throughput, lock scope (R7–R9) |

## Open items

| # | Severity | Item | Source |
|---|---|---|---|
| R1 | High | Validate domain fixed values and check tables | REQUIREMENTS-REVIEW |
| R2 | High | Reject Excel error cells (`#N/A`, `#REF!`, …) | REQUIREMENTS-REVIEW |
| R3 | Medium | Reject negative values in unsigned domains | REQUIREMENTS-REVIEW |
| R4 | Medium | Support RAW (hex/GUID) and UTCLONG fields | REQUIREMENTS-REVIEW, AUTO |
| R5 | Medium | Global class with `load( it_solix … )`; background processing for large files | REQUIREMENTS-REVIEW |
| R6 | Medium | All-or-nothing option (strict mode) | REQUIREMENTS-REVIEW, AUTO |
| R7 | Medium | Detect workbooks that use the 1904 date system | REQUIREMENTS-REVIEW |
| R8 | Medium | Throughput at the row limit | REQUIREMENTS-REVIEW |
| R9 | Medium | Verify the scope of the table lock in SM12 | REQUIREMENTS-REVIEW |
| R10–R16 | Low | Smaller robustness items | REQUIREMENTS-REVIEW |
| — | Feature | Find a header row that is not in row 1 | AUTO |
| — | Feature | Match columns by field label | AUTO |
| — | Feature | Column letter and cell value in the log | AUTO |

## Decisions needed

1. **Customizing tables.** TBL2 blocks them unless the user ticks *Allow Customizing tables* and SCC4 allows changes without a transport. This narrows "any custom table" and needs agreement from whoever owns the requirement.
2. **Dynamic table creation (AUTO).** Recommendation: leave it out of the upload tool. If it is needed, build it as a separate developer tool that requires `S_DEVELOP`, a package and a transport request.

## Next steps

1. **Build TBL3** from TBL2: add the AUTO features and R1, R2, R4, R6.
2. **On the SAP system:** run the syntax check, SLIN, ATC and the unit tests (Ctrl+Shift+F10) on TBL2/TBL3, then a test run against a sandbox Z table.
3. **Optional setup:** application log object `ZUPLOAD` (SLG0), whitelist table `ZUPLOAD_ALLOWED`, a dedicated transaction code.
4. **Pull request:** none opened yet. Open one when you are ready.

## History

| Commit | Change |
|---|---|
| `2d03aae` | Added the `abap/` folder, the original source and its review |
| `d51f086` | Added version TBL2 with all review findings fixed |
| `c0253b5` | Reviewed TBL2 against the requirement |
| `075820b` | Added the AUTO version and its comparison with TBL2 |

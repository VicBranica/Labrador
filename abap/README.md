# ABAP — code reviews

ABAP sources under review, one folder per program. Each folder holds the source as received (abapGit naming, `<name>.prog.abap`) and a `REVIEW.md` with the findings.

| Program | What it does | Review |
|---|---|---|
| [ZDEMO_SECURE_DYNAMIC_EXCEL](zdemo_secure_dynamic_excel/zdemo_secure_dynamic_excel.prog.abap) | Generic, metadata-driven `.xlsx` upload into a customer (Z*/Y*) transparent table | [REVIEW.md](zdemo_secure_dynamic_excel/REVIEW.md) |

**Conventions**

- The source file is kept exactly as received, so the line numbers in the review stay valid. Fixes go in a new commit after the review, not into the reviewed version.
- Findings are ranked **High** (wrong data, an aborted run or a control bypassed), **Medium** (wrong result in a realistic case, or a misleading report) and **Low** (robustness, readability, style).

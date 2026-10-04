# Code templates

[← README](../README.md) · [Project structure](../PROJECT_STRUCTURE.md)

> Starting points for new code. Copy, rename, replace the placeholders, then add the follow-up edits.

## Placeholders

| Placeholder | Case | Example |
|---|---|---|
| `__Name__` | PascalCase, singular | `BenchItem` |
| `__name__` | kebab-case, singular | `bench-item` |
| `__table__` | snake_case, plural | `bench_items` |

Replace them in file names and in file contents. They are valid identifiers, so the TypeScript templates type-check before you rename anything.

## Templates

| Template | Copy to | Follow-up |
|---|---|---|
| [feature/page.tsx](feature/page.tsx) | `apps/web/src/app/[locale]/__name__/page.tsx` | — |
| [feature/index.ts](feature/index.ts) | `apps/web/src/features/__name__/index.ts` | — |
| [feature/components/\_\_Name\_\_View.tsx](feature/components/__Name__View.tsx) | `apps/web/src/features/__name__/components/__Name__View.tsx` | — |
| [feature/messages.json](feature/messages.json) | Merge into `apps/web/messages/en.json`, `pl.json` and `ru.json` | Translate the PL and RU values |
| [domain-entity/\_\_Name\_\_.ts](domain-entity/__Name__.ts) | `packages/domain/src/__name__/__Name__.ts` | Export it from the package index; add the entity's own rules to `validate__Name__` |
| [migration/template.sql](migration/template.sql) | `supabase/migrations/<YYYYMMDDHHMMSS>_create___table__.sql` | Add matching seed rows in `supabase/seed/` if needed |
| [test/\_\_Name\_\_.test.ts](test/__Name__.test.ts) | Next to the file it tests, e.g. `packages/domain/src/__name__/__Name__.test.ts` | — |

## Assumptions

- **Frontend:** Next.js App Router with `next-intl` for the EN / PL / RU messages, and `@/` mapped to `apps/web/src/`.
- **Tests:** Vitest.
- **Database:** Supabase Postgres with row-level security on every table.

None of these are installed yet; see [README](../README.md#getting-started).

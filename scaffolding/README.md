# Labrador — app scaffolding

[← Project map](../index.md) · [Project structure](PROJECT_STRUCTURE.md) · [Claude guide](CLAUDE.md)

> The folder skeleton for a Labrador web app: a pnpm monorepo with a Next.js frontend, domain and server packages, and a Supabase database. Nothing is implemented yet — every folder is empty except for a `.gitkeep`.

## What the app is for

Managing the [course04 lab](../version/course04/index.md) as data instead of Markdown:

- **Benches and BOMs** — the starter kit and seven benches, with the three-level `bench.category.item` codes.
- **Inventory** — what you own, what's on order, what you've torn down.
- **Costing** — category and bench totals computed from the items, the way the BOM tables already require.
- **Languages** — English, Polish and Russian.

## Layout

| Folder | Holds |
|---|---|
| `apps/web/` | Next.js frontend, routed by locale (`src/app/[locale]/`), with translations in `messages/` |
| `packages/domain/` | BOM, inventory and costing rules — pure logic, no I/O |
| `packages/server/` | Backend services: commands and queries |
| `packages/db/` | Database adapters |
| `packages/shared/` | Schemas and types shared by every package |
| `supabase/` | SQL migrations and seed data |
| `templates/` | Starting points for a feature, a domain entity, a migration and a test |
| `docs/` | Architecture, domain notes and reference screenshots |
| `.claude/` | Rules, agents and skills for working on this code with Claude |

The full tree, with what goes where: [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md).

## Getting started

Not runnable yet. The next steps are a `package.json` in `apps/web` and in each package under `packages/`, then `pnpm install` from this folder.

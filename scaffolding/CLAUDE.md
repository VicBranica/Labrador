# CLAUDE.md

Guide for Claude when working in `scaffolding/`, the Labrador app.

## What this is

A pnpm monorepo for a web app that manages the Labrador lab: benches, bills of materials, inventory and costs. The course content it models lives in `../version/course04/`. See [README.md](README.md) and [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md).

## Layout and boundaries

- `apps/web` — Next.js frontend. Routes live under `src/app/[locale]/`; every user-facing string comes from `messages/{en,pl,ru}.json`.
- `packages/domain` — business rules only: BOM structure, inventory, costing. No I/O, no framework imports.
- `packages/server` — commands and queries; the only place that combines `domain` with `db`.
- `packages/db` — database adapters for Supabase.
- `packages/shared` — schemas and types used across packages.
- `supabase/migrations` — schema changes as ordered SQL files; never edit a migration that has already been applied.

Dependencies point inward: `web → server → domain → shared`, and `server → db → shared`. `web` never imports `db`.

## Domain rules to preserve

- BOM codes are `bench.category.item` (`3.1.3`); the starter kit uses `S` (`S.1.1`).
- A bench's last category is "Teardown targets (free)", at cost 0.
- Level 0 and level 1 costs are always the sums of their level 2 items. Store item costs; compute the totals.
- Costs can be a range (`10–25`); keep the low and high ends separately.

## Working here

- Start new code from `templates/` (feature, domain-entity, migration, test).
- Add a key to all three message files whenever you add one to any of them.
- Put rules for Claude in `.claude/rules/`, subagents in `.claude/agents/`, skills in `.claude/skills/`.

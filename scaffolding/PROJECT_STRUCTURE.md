# Project structure

[← README](README.md)

```
scaffolding/
├── apps/
│   └── web/                    # Next.js frontend
│       ├── src/app/[locale]/   # routes, one tree per locale
│       ├── src/components/     # shared UI components
│       ├── src/features/       # feature modules (benches, BOM, inventory, …)
│       ├── src/styles/         # global styles and tokens
│       └── messages/           # EN / PL / RU translations (en.json, pl.json, ru.json)
│
├── packages/
│   ├── domain/                 # BOM, inventory, costing rules
│   ├── server/                 # backend services / commands / queries
│   ├── db/                     # database adapters
│   └── shared/                 # common schemas/types
│
├── supabase/
│   ├── migrations/             # SQL migrations, applied in order
│   └── seed/                   # seed data (starter kit and bench BOMs)
│
├── templates/
│   ├── feature/                # a new feature module in apps/web
│   ├── domain-entity/          # a new entity in packages/domain
│   ├── migration/              # a new SQL migration
│   └── test/                   # a new test file
│
├── docs/
│   ├── architecture/           # how the packages fit together
│   ├── domain/                 # BOM codes, costing rules, inventory states
│   └── reference/
│       └── screenshots/        # UI reference images
│
├── .claude/
│   ├── rules/                  # coding rules Claude follows here
│   ├── agents/                 # subagent definitions
│   └── skills/                 # project skills
│
├── CLAUDE.md                   # guide for Claude working in this folder
├── README.md                   # what this is and how to start
├── PROJECT_STRUCTURE.md        # this file
├── package.json                # workspace root
└── pnpm-workspace.yaml         # workspace members: apps/*, packages/*
```

## Dependency direction

```
apps/web ──► packages/server ──► packages/domain ──► packages/shared
                    │                                      ▲
                    └──────────► packages/db ──────────────┘
```

- `domain` depends only on `shared`. It has no database, network or framework code.
- `server` runs commands and queries by combining `domain` rules with `db` adapters.
- `web` calls `server`; it never imports `db` directly.

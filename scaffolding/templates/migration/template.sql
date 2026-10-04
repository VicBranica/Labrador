-- Migration: create __table__
-- Save as supabase/migrations/<YYYYMMDDHHMMSS>_create___table__.sql
-- Never edit a migration that has been applied — write a new one.

create table if not exists public.__table__ (
  id          uuid primary key default gen_random_uuid(),
  code        text not null unique,                       -- BOM code, e.g. '3.1.3'
  name        text not null check (length(trim(name)) > 0),
  -- Costs can be a range ("10–25"): store both ends, never a total.
  -- cost_low_usd  numeric(10, 2) not null default 0,
  -- cost_high_usd numeric(10, 2) not null default 0 check (cost_high_usd >= cost_low_usd),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

alter table public.__table__ enable row level security;

create policy "__table__: signed-in users can read"
  on public.__table__
  for select
  to authenticated
  using (true);

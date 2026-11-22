-- Patois Canary Wharf temp log — run once in the Chip Shop Supabase project: SQL Editor > New query > paste > Run
-- Creates two new tables only. Does not touch any Chip Shop table.

create table if not exists public.patois_cw_temperature_logs (
  id bigint generated always as identity primary key,
  unit_id text not null,
  unit_name text not null,
  area text,
  session text,
  temperature numeric not null,
  corrective_action text,
  staff_name text,
  logged_at timestamptz not null default now(),
  log_date date not null default current_date
);
create index if not exists patois_cw_temperature_logs_date_idx on public.patois_cw_temperature_logs (log_date);

create table if not exists public.patois_cw_probe_calibration_logs (
  id bigint generated always as identity primary key,
  probe_name text not null,
  ice_water_temp numeric,
  boiling_water_temp numeric,
  ice_pass boolean,
  boil_pass boolean,
  overall_pass boolean,
  corrective_action text,
  staff_name text,
  notes text,
  logged_at timestamptz not null default now(),
  log_date date not null default current_date
);

-- Open access for the public link (same trade-off as the Chip Shop hub):
-- anyone with the link can add and read readings, but nobody can edit or delete them.
alter table public.patois_cw_temperature_logs enable row level security;
alter table public.patois_cw_probe_calibration_logs enable row level security;
drop policy if exists "patois cw read temps" on public.patois_cw_temperature_logs;
drop policy if exists "patois cw add temps" on public.patois_cw_temperature_logs;
drop policy if exists "patois cw read cal" on public.patois_cw_probe_calibration_logs;
drop policy if exists "patois cw add cal" on public.patois_cw_probe_calibration_logs;
create policy "patois cw read temps" on public.patois_cw_temperature_logs for select to anon using (true);
create policy "patois cw add temps" on public.patois_cw_temperature_logs for insert to anon with check (true);
create policy "patois cw read cal" on public.patois_cw_probe_calibration_logs for select to anon using (true);
create policy "patois cw add cal" on public.patois_cw_probe_calibration_logs for insert to anon with check (true);

-- Live updates: a reading logged on one phone shows on the others
alter publication supabase_realtime add table public.patois_cw_temperature_logs;

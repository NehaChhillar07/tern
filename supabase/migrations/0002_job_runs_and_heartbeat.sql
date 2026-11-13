-- Background jobs run on Supabase's scheduler (pg_cron). Every run is recorded in job_run.
create extension if not exists pg_cron;

create table public.job_run (
  id bigint generated always as identity primary key,
  job text not null,
  ok boolean not null default true,
  detail jsonb,
  ran_at timestamptz not null default now()
);
create index job_run_job_idx on public.job_run (job, ran_at desc);
alter table public.job_run enable row level security;
-- No policies: only the server can read or write job_run.

create or replace function public.job_heartbeat() returns void
language sql security invoker set search_path = ''
as $$
  insert into public.job_run (job, detail)
  values ('heartbeat', jsonb_build_object('courses', (select count(*) from public.course)));
$$;
revoke execute on function public.job_heartbeat() from public, anon, authenticated;

-- Hourly proof that the scheduler works, and a daily clean-up of old run records.
select cron.schedule('tern-heartbeat', '7 * * * *', 'select public.job_heartbeat()');
select cron.schedule('tern-job-run-cleanup', '23 3 * * *', $$delete from public.job_run where ran_at < now() - interval '30 days'$$);

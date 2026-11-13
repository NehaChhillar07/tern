-- Tern initial schema. See docs/02-system-design.md section 5.
-- Shared knowledge (courses and their facts) is readable by any signed-in user and writable only by the server.
-- Per-user data is visible only to its owner.

-- ---------- Shared knowledge ----------

create table public.source (
  id uuid primary key default gen_random_uuid(),
  url text not null,
  domain text not null,
  fetched_at timestamptz not null default now(),
  content_hash text,
  http_status int,
  snapshot_path text
);
create index source_url_idx on public.source (url);

create table public.university (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  country text not null,
  city text,
  official_domain text not null unique,
  kind text check (kind in ('public', 'private')),
  rankings jsonb not null default '{}',
  created_at timestamptz not null default now()
);

create table public.course (
  id uuid primary key default gen_random_uuid(),
  university_id uuid not null references public.university (id) on delete cascade,
  name text not null,
  award text,
  subject_tags text[] not null default '{}',
  duration_months int,
  mode text,
  language text not null default 'English',
  course_url text not null,
  apply_url text,
  apply_portal text,
  tuition_intl jsonb,
  tuition_eu jsonb,
  status text not null default 'candidate' check (status in ('candidate', 'verified', 'stale', 'flagged')),
  last_verified_at timestamptz,
  created_at timestamptz not null default now(),
  unique (university_id, name, award)
);
create index course_university_idx on public.course (university_id);
create index course_status_idx on public.course (status);
create index course_subject_tags_idx on public.course using gin (subject_tags);

create table public.intake (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.course (id) on delete cascade,
  start_month int not null check (start_month between 1 and 12),
  year int not null,
  unique (course_id, start_month, year)
);

create table public.deadline (
  id uuid primary key default gen_random_uuid(),
  intake_id uuid not null references public.intake (id) on delete cascade,
  kind text not null check (kind in ('round_1', 'round_2', 'final', 'scholarship', 'deposit', 'non_eu', 'eu')),
  due_date date,
  timezone text,
  is_rolling boolean not null default false,
  source_id uuid references public.source (id) on delete set null,
  quote text,
  confidence real,
  last_verified_at timestamptz
);
create index deadline_intake_idx on public.deadline (intake_id);
create index deadline_source_idx on public.deadline (source_id);
create index deadline_due_idx on public.deadline (due_date);

create table public.requirement (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.course (id) on delete cascade,
  kind text not null check (kind in ('degree', 'gpa', 'english', 'portfolio', 'sop', 'lor', 'cv', 'interview', 'test', 'work_exp', 'fee', 'other')),
  spec jsonb not null default '{}',
  source_id uuid references public.source (id) on delete set null,
  quote text,
  confidence real,
  last_verified_at timestamptz
);
create index requirement_course_idx on public.requirement (course_id);
create index requirement_source_idx on public.requirement (source_id);

create table public.scholarship (
  id uuid primary key default gen_random_uuid(),
  course_id uuid references public.course (id) on delete cascade,
  university_id uuid references public.university (id) on delete cascade,
  name text not null,
  provider text,
  amount jsonb,
  eligibility jsonb not null default '{}',
  due_date date,
  url text,
  source_id uuid references public.source (id) on delete set null
);
create index scholarship_course_idx on public.scholarship (course_id);
create index scholarship_university_idx on public.scholarship (university_id);
create index scholarship_source_idx on public.scholarship (source_id);

create table public.visa_template (
  id uuid primary key default gen_random_uuid(),
  country text not null,
  visa_type text not null,
  steps jsonb not null default '[]',
  fund_rules jsonb not null default '{}',
  source_ids uuid[] not null default '{}',
  version int not null default 1,
  last_verified_at timestamptz,
  unique (country, visa_type, version)
);

-- ---------- Per-user data ----------

create table public.profile (
  user_id uuid primary key references auth.users (id) on delete cascade,
  full_name text,
  home_city text,
  education jsonb not null default '[]',
  experience jsonb not null default '[]',
  skills text[] not null default '{}',
  tests jsonb not null default '[]',
  portfolio_url text,
  gaps jsonb not null default '[]',
  flags jsonb not null default '{}',
  field_confidence jsonb not null default '{}',
  updated_at timestamptz not null default now()
);

create table public.assessment (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  tier_by_country jsonb not null default '{}',
  strengths jsonb not null default '[]',
  gaps jsonb not null default '[]',
  created_at timestamptz not null default now()
);
create index assessment_user_idx on public.assessment (user_id);

create table public.preferences (
  user_id uuid primary key references auth.users (id) on delete cascade,
  countries_ranked text[] not null default '{}',
  domains_ranked text[] not null default '{}',
  intake jsonb,
  budget jsonb,
  duration_pref text,
  career_goal text,
  city_prefs jsonb not null default '{}',
  constraints jsonb not null default '{}',
  updated_at timestamptz not null default now()
);

create table public.document (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  kind text not null check (kind in ('cv', 'portfolio', 'transcript', 'test_score', 'sop', 'lor_brief', 'other')),
  title text,
  storage_path text,
  body text,
  version int not null default 1,
  parent_id uuid references public.document (id) on delete set null,
  course_id uuid references public.course (id) on delete set null,
  created_at timestamptz not null default now()
);
create index document_user_idx on public.document (user_id);
create index document_parent_idx on public.document (parent_id);
create index document_course_idx on public.document (course_id);

create table public.application (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  course_id uuid not null references public.course (id) on delete restrict,
  intake_id uuid references public.intake (id) on delete set null,
  bucket text check (bucket in ('stretch', 'match', 'safe')),
  fit_score int check (fit_score between 0 and 100),
  fit_reason text,
  status text not null default 'shortlisted' check (status in (
    'shortlisted', 'preparing', 'submitted', 'interview', 'offer', 'accepted', 'deposit_paid',
    'admission_letter', 'visa', 'enrolled', 'rejected', 'declined', 'withdrawn')),
  offer_kind text check (offer_kind in ('conditional', 'unconditional')),
  muted boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, course_id, intake_id)
);
create index application_user_idx on public.application (user_id);
create index application_course_idx on public.application (course_id);
create index application_intake_idx on public.application (intake_id);

create table public.checklist_item (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  application_id uuid not null references public.application (id) on delete cascade,
  kind text not null,
  title text not null,
  due_date date,
  status text not null default 'todo' check (status in ('todo', 'in_progress', 'done', 'na')),
  document_id uuid references public.document (id) on delete set null,
  referee jsonb,
  notes text,
  created_at timestamptz not null default now()
);
create index checklist_user_idx on public.checklist_item (user_id);
create index checklist_application_idx on public.checklist_item (application_id);
create index checklist_document_idx on public.checklist_item (document_id);
create index checklist_due_idx on public.checklist_item (due_date) where status in ('todo', 'in_progress');

create table public.offer_condition (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  application_id uuid not null references public.application (id) on delete cascade,
  description text not null,
  due_date date,
  met boolean not null default false
);
create index offer_condition_user_idx on public.offer_condition (user_id);
create index offer_condition_application_idx on public.offer_condition (application_id);

create table public.nudge (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  application_id uuid references public.application (id) on delete cascade,
  checklist_item_id uuid references public.checklist_item (id) on delete cascade,
  channel text not null default 'email' check (channel in ('email', 'in_app')),
  kind text not null,
  body text,
  scheduled_for timestamptz not null,
  sent_at timestamptz
);
create index nudge_user_idx on public.nudge (user_id);
create index nudge_application_idx on public.nudge (application_id);
create index nudge_checklist_idx on public.nudge (checklist_item_id);
create index nudge_pending_idx on public.nudge (scheduled_for) where sent_at is null;

create table public.chat_thread (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  title text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index chat_thread_user_idx on public.chat_thread (user_id);

create table public.chat_message (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  thread_id uuid not null references public.chat_thread (id) on delete cascade,
  role text not null check (role in ('user', 'assistant', 'system')),
  content jsonb not null,
  created_at timestamptz not null default now()
);
create index chat_message_user_idx on public.chat_message (user_id);
create index chat_message_thread_idx on public.chat_message (thread_id, created_at);

-- What Tern did while the user was away.
create table public.activity (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  application_id uuid references public.application (id) on delete cascade,
  kind text not null check (kind in ('changed', 'needs_you', 'routine')),
  body text not null,
  action jsonb,
  seen_at timestamptz,
  created_at timestamptz not null default now()
);
create index activity_user_idx on public.activity (user_id, created_at desc);
create index activity_application_idx on public.activity (application_id);

-- Every model call, for cost tracking and future pricing. Written by the server only.
create table public.usage_event (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users (id) on delete set null,
  kind text not null,
  model text,
  tokens_in int not null default 0,
  tokens_out int not null default 0,
  cache_read_tokens int not null default 0,
  cost_usd numeric(10, 5) not null default 0,
  latency_ms int,
  stop_reason text,
  created_at timestamptz not null default now()
);
create index usage_event_user_idx on public.usage_event (user_id, created_at desc);

-- ---------- Row-level security ----------

alter table public.source enable row level security;
alter table public.university enable row level security;
alter table public.course enable row level security;
alter table public.intake enable row level security;
alter table public.deadline enable row level security;
alter table public.requirement enable row level security;
alter table public.scholarship enable row level security;
alter table public.visa_template enable row level security;
alter table public.profile enable row level security;
alter table public.assessment enable row level security;
alter table public.preferences enable row level security;
alter table public.document enable row level security;
alter table public.application enable row level security;
alter table public.checklist_item enable row level security;
alter table public.offer_condition enable row level security;
alter table public.nudge enable row level security;
alter table public.chat_thread enable row level security;
alter table public.chat_message enable row level security;
alter table public.activity enable row level security;
alter table public.usage_event enable row level security;

-- Shared knowledge: signed-in users can read. No write policies, so only the server (service role) can write.
create policy "signed-in users read sources" on public.source for select to authenticated using (true);
create policy "signed-in users read universities" on public.university for select to authenticated using (true);
create policy "signed-in users read courses" on public.course for select to authenticated using (true);
create policy "signed-in users read intakes" on public.intake for select to authenticated using (true);
create policy "signed-in users read deadlines" on public.deadline for select to authenticated using (true);
create policy "signed-in users read requirements" on public.requirement for select to authenticated using (true);
create policy "signed-in users read scholarships" on public.scholarship for select to authenticated using (true);
create policy "signed-in users read visa templates" on public.visa_template for select to authenticated using (true);

-- Per-user data: the owner can do everything, nobody else can see it.
create policy "owner manages profile" on public.profile for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages preferences" on public.preferences for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages documents" on public.document for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages applications" on public.application for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages checklist" on public.checklist_item for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages offer conditions" on public.offer_condition for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages threads" on public.chat_thread for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "owner manages messages" on public.chat_message for all to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

-- Written by the server; the owner can read (and mark activity as seen).
create policy "owner reads assessments" on public.assessment for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "owner reads nudges" on public.nudge for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "owner reads activity" on public.activity for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "owner marks activity seen" on public.activity for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
-- usage_event has no policies: only the server can read or write it.

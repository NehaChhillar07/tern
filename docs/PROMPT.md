# Master Prompt: AI Study-Abroad Counsellor — "Tern"

> Paste this into Claude Code at the start of the build.

---

<role>
You are three experts working as one:
1. **Founder-counsellor.** You have 25 years of study-abroad counselling experience and have placed thousands of students and working professionals in universities in the UK, US, Canada, Ireland, Germany, the Netherlands, Australia, Singapore and elsewhere. You know how admissions actually work: application rounds, how competitive each course is, portfolio expectations for design programmes, SOP and LOR norms, English-test waivers, CAS and I-20 processes, visa financial rules, and post-study work routes.
2. **Senior AI engineer.** You design reliable multi-agent LLM systems with tool use, retrieval, verification and background jobs, and you never let an agent invent facts.
3. **Senior product designer.** You ship minimal, chat-first AI SaaS interfaces of the same quality as Claude.ai and ChatGPT.
</role>

<context>
**Problem.** Students and working professionals who want to study abroad either pay expensive counsellors, who often have commission bias toward partner universities, or do it alone across hundreds of university websites, spreadsheets and missed deadlines. Nobody gives them an unbiased, personalised, end-to-end guide.

**Product.** A web-based AI SaaS that does a counsellor's whole job, from profile analysis through shortlisting, applications, offers and visa to pre-departure, through one simple chat interface and a set of AI agents working in the background.

**Target users.**
- Final-year undergraduates applying for a master's.
- Working professionals (2–10 years of experience) switching or levelling up careers.
- Any domain, any destination country. The architecture must be domain- and country-agnostic.

**Design principle: no single-persona bias.** Do not optimise for any one student, domain or country. Every flow, schema and agent must work equally well for a computer-science fresher, a mid-career finance professional, a designer with a portfolio, a nurse, an MBA aspirant and so on.

**Test personas.** Create a diverse set of 6–8 synthetic student profiles that vary in:
- domain: tech, design, business, health, law, humanities
- experience: 0 to 10+ years
- academic strength: strong, average, with backlogs
- budget: low to high
- destinations: UK, US, Canada, Germany, Ireland, Australia
- special cases: study gap, earlier visa refusal, dependants, no English test yet

Use these personas for end-to-end testing and evals.
</context>

<decisions_locked>
These are already decided. Do not reopen them.

- **Countries in MVP v1:** the **UK and Europe**. For Europe, cover English-taught master's programmes in **Ireland, Germany, the Netherlands and France** first, then Sweden, Denmark, Finland, Italy and Spain. The data model must allow any country to be added later without code changes.
- **Europe is not the UK.** Encode the differences:
  - Germany: application portals such as uni-assist and VPD, the blocked account (Sperrkonto), and low or no tuition at public universities.
  - Netherlands: Studielink, early deadlines for non-EU applicants, and residence permits requested by the university.
  - France: Campus France / Études en France.
  - Ireland: Stamp 2.
  - In general: separate deadlines for EU and non-EU applicants, and the European grading scale (ECTS) and grade conversion.
- **Business model:** MVP v1 is **completely free**, with no payments, paywalls or usage tiers in the UI. Keep the architecture ready for later monetisation by tracking usage per user and putting features behind feature flags.
- **Pricing (subscription vs one-time vs freemium)** is decided after MVP. In Phase 1, produce a **competitor and pricing analysis**. Cover:
  - AI study-abroad tools
  - counsellor platforms such as Leverage Edu, Yocket, upGrad Abroad, IDP and Shorelight
  - course-search sites such as Studyportals and Mastersportal
  
  List each one's features, pricing and gaps, then recommend 2–3 pricing models to test.
- **Codebase:** greenfield. No existing repo or code. Set up a new repository from scratch with a clean, conventional structure.
</decisions_locked>

<core_user_journey>
Design the product around these stages. Each one is a capability the agents own, not a separate page.

1. **Profile intake and analysis**
   - Upload the CV and portfolio (PDF or URL), with optional transcripts and test scores.
   - Extract structured data: education, GPA/class and the institution's grading scale, years and kind of work experience, skills, portfolio strengths and gaps, test scores, gaps in the timeline.
   - Return an honest **profile assessment**: competitiveness by tier, strengths, weaknesses, and concrete fixes (for example "add one end-to-end case study showing research → shipped outcome").

2. **Preference interview.** A conversational interview, one or two questions at a time, never a long form:
   - 1st, 2nd and 3rd preference **countries**
   - 1st, 2nd and 3rd preference **domains / course types**
   - Target **intake** (e.g., Sep 2027) and willingness to take a later intake
   - **Budget**: total tuition and living budget, the currency, and how it is funded (self, loan, scholarship needed?)
   - Course length (1 year vs 2 years), whether a placement/internship year is wanted
   - City / lifestyle preferences, university ranking importance, course-vs-university brand trade-off
   - Career goal after the course (return home vs stay on, e.g., UK Graduate Route)
   - English-test status (IELTS/TOEFL/PTE/Duolingo, or eligible for a waiver)
   - Constraints: dependants, gap years, previous visa refusals

3. **Shortlist generation**
   - Research real courses that match the profile and preferences.
   - Sort each course into a bucket: **Ambitious (stretch)**, **Target (match)** or **Safe (likely)**, with a fit score (0–100) and a one-line reason.
   - Output **one consolidated list**. Each course shows:
     | Field | Notes |
     |---|---|
     | University, course name, award (MA/MSc), duration | |
     | Official course page URL + **direct application URL** | Must be real and verified |
     | Intake(s) and **application deadline(s)**, including rounds/stages | Show "rolling" if applicable |
     | Tuition (international) and estimated living cost | With currency |
     | Academic entry requirements | Degree class / GPA equivalent |
     | English requirement | e.g., IELTS 6.5 overall, 6.0 per band |
     | Required documents | SOP/personal statement (word limit), number of LORs (academic/professional), CV, portfolio (format, page limit), interview, writing sample |
     | Application fee, deposit to secure a place | |
     | Relevant scholarships + deadlines | |
     | Source URLs + "last verified" date + confidence | |
   - The user selects courses (e.g., 10) to move into the tracker.

4. **Application tracker** (the heart of the product)
   - For each selected course: status pipeline `Researching → Preparing → Submitted → Interview → Offer (Conditional/Unconditional) → Accepted/Firm → Deposit paid → CAS issued → Visa → Enrolled` (or `Rejected / Withdrawn`).
   - An auto-generated **per-course checklist**: SOP tailored to this course, LOR 1 and LOR 2 (referee contacted / submitted), portfolio variant, transcripts, English test, fee paid.
   - A **unified deadline timeline** across all applications, with what is due this week.
   - Offer conditions tracking (e.g., "IELTS 7.0 by 30 June").

5. **Proactive nudges.** In-app, email (and later WhatsApp):
   - Deadline reminders at T-30, T-14, T-7 and T-2 days, prioritised by risk.
   - "Your referee hasn't submitted yet": draft a polite chaser.
   - Weekly digest: progress, blockers, next three actions.

6. **Document coach**
   - SOP drafting and critique per course, aligned to each course's stated values and modules (never generic, never fabricated experiences).
   - LOR briefing packs for referees (achievements to mention, deadlines, submission links).
   - CV adaptation and portfolio review against course expectations.
   - Document vault with versions.

7. **Post-offer, visa and pre-departure**
   - Offer comparison (cost, ranking, outcomes, conditions).
   - Deposit and CAS tracking.
   - Country-specific visa checklist. For the UK Student visa that means CAS, maintenance funds and the 28-day rule, the Immigration Health Surcharge (IHS), TB test if applicable, ATAS if applicable, biometrics, and timeline.
   - Accommodation, travel, banking and pre-arrival checklist.
</core_user_journey>

<agent_architecture>
Design an **orchestrator–worker multi-agent system**. Sub-agents run in parallel where they are independent and share one structured student-profile state.

| Agent | Responsibility |
|---|---|
| **Orchestrator / Counsellor** | The only voice the user talks to. Holds the conversation, keeps the persona consistent, routes tasks, merges results. |
| **Profile Analyst** | Parses the CV, portfolio and transcripts into structured JSON and writes the competitiveness assessment. |
| **Preference Interviewer** | Runs the adaptive question flow and fills in the preference schema. |
| **Course Researcher** | Uses web search and fetch to discover courses per country × domain, in parallel. |
| **Requirements Extractor** | Pulls deadlines, fees, entry/English requirements and documents from official pages into the course schema. |
| **Fit Scorer** | Scores courses against the profile and assigns Ambitious/Target/Safe. |
| **Verifier** | Independently re-checks every link, deadline and requirement against the official source. Rejects or flags anything it cannot verify. |
| **Tracker & Deadline Agent** | Maintains the application state machine, checklists and timeline. |
| **Document Coach** | Drafts and reviews SOPs, LOR briefs and CV/portfolio. |
| **Visa & Compliance Agent** | Builds post-offer and visa checklists per country from official government sources. |
| **Nudge Agent** | Scheduled background job that decides what to remind and when, and writes the message. |

Required non-functional rules:
- **No hallucinated facts.** Every deadline, fee, requirement and URL must come from a fetched source and be stored with `source_url`, `fetched_at` and `confidence`. If the agent cannot verify something, it says so and shows "Check on official page" rather than guessing.
- **Caching and freshness.** Store verified course data in a shared course database that is reused across users and re-verified on a schedule. Each cycle, deadlines and fees are re-checked.
- **Human control.** The AI never submits applications or contacts referees on its own. It drafts; the user acts.
- **Privacy.** CVs, transcripts and passport data are sensitive: encrypt them, let the user delete their data, and never use one user's documents in another user's context.
- **Unbiased.** No paid university placement. Rankings must be explainable.
</agent_architecture>

<ux_requirements>
- **The simplest interface possible.** Chat-first, like Claude.ai and ChatGPT: a centred input, a conversation thread, and a collapsible left sidebar (Chats · Shortlist · Applications · Documents · Settings).
- **Generative UI in the chat.** The agent renders rich components inside the conversation instead of walls of text: profile-assessment card, course cards and comparison table, "Add to tracker" buttons, deadline timeline, checklist, progress ring.
- Show agent activity transparently ("Researching 34 UK design courses… verifying deadlines…") with streaming progress.
- Stack: **Next.js (App Router) + TypeScript + Tailwind + shadcn/ui**, light and dark mode, fully responsive and mobile-friendly, accessible (WCAG AA).
- Visual tone: calm, premium, modern AI SaaS. Neutral palette, one accent colour, generous whitespace, subtle motion.
</ux_requirements>

<suggested_stack>
These are defaults. Challenge them if you have a better reason.
- Frontend: Next.js, shadcn/ui, Tailwind, a streaming chat UI with generative components.
- LLM: Anthropic Claude through the Claude API with tool use. Use a stronger model for orchestration, reasoning and SOP work, and a faster, cheaper model for extraction and verification sub-agents.
- Tools: web search, web fetch/scrape, PDF parsing.
- Data: Postgres (e.g., Supabase) with pgvector, plus object storage for documents.
- Auth: email magic link + Google.
- Background jobs and scheduling (for nudges and re-verification): Inngest / Trigger.dev or equivalent.
- Email: Resend or equivalent.
</suggested_stack>

<mvp_scope>
**In MVP v1** (any domain; UK + Europe; free): profile intake and analysis, preference interview, verified shortlist with Ambitious/Target/Safe buckets, consolidated course list with direct links and deadlines, application tracker with checklists, deadline timeline, email nudges, SOP/LOR drafting assistant, visa and residence-permit checklists for the UK and each launch country in Europe.

**Later (v2+):** WhatsApp nudges, a full multi-country visa engine, scholarship matcher, education-loan comparison, alumni/peer connect, mock interview (voice), counsellor-marketplace hand-off, mobile app, university partner dashboard.
</mvp_scope>

<instructions>
Work in phases. **Stop for my approval at the end of each phase.**

**Phase 0: Clarify.** Mostly done (see `<decisions_locked>`). Raise only questions that would block the design, if there are any, and keep it to 3 at most.

**Phase 1: Product spec (PRD) and market research.** Cover personas, jobs-to-be-done, user stories with acceptance criteria, MVP scope vs non-goals, success metrics (e.g., time-to-shortlist, % of deadlines met, offer rate), the competitor and pricing analysis, and how we stand apart from competitors.

**Phase 2: System design.** Cover the agent graph and orchestration flow (with a diagram), tool definitions, the data model (Student, Profile, Preference, University, Course, Requirement, Deadline, Application, ChecklistItem, Document, Nudge, Source), the verification pipeline, background jobs, the security model, and cost/latency estimates per user.

**Phase 3: UX.** Cover the information architecture, the key screens and states (empty, loading/agent-working, error, unverified data), and the generative UI component inventory mapped to shadcn components.

**Phase 4: Build plan.** Break the work into milestones with small, testable tasks in build order, plus a repository structure and a testing strategy. Include an evaluation set built from the test personas. For each persona, the shortlist must contain only real, verifiable courses with correct deadlines and requirements, and must fit that persona's budget and preferences.

**Phase 5: Implement** milestone by milestone, committing after each one.

**Throughout:**
- Think like a counsellor first and an engineer second. Every feature must map to a real step a human counsellor does today.
- Prefer simple, reliable solutions over clever ones. Do not over-engineer the MVP.
- Be explicit about trade-offs and say when you are unsure.
</instructions>

<output_format>
Use Markdown with clear headings, tables for structured comparisons, and Mermaid for diagrams. Keep prose tight. Put each phase's deliverable in `/docs/<phase>.md`.
</output_format>

# Tern: Phase 1 Product Spec (PRD) and Market Research

| | |
|---|---|
| **Status** | Draft v1, for founder review |
| **Date** | 12 Nov 2026 |
| **Scope** | MVP v1: UK and Europe, any subject, free |

---

## 1. Summary

Tern is an AI study-abroad counsellor for working professionals and students applying for master's degrees in the UK and Europe. It does the job of an experienced human counsellor in a single chat interface:

1. understand the applicant's profile
2. build a verified, unbiased shortlist
3. hand over every requirement, deadline and direct application link
4. track every application through to offer, deposit, visa and departure, sending a reminder before each deadline

**The wedge.** Most "free" study-abroad help is paid for by **university commissions**. Tern's recommendations are **not commission-based** and every fact comes **with a source**. The agent is accountable to the student, not to a partner university.

---

## 2. Problem

| Who | Pain today |
|---|---|
| Student / professional going alone | They juggle 50+ university tabs and a spreadsheet. Deadlines and requirements are scattered across course pages, PDFs and portals (UCAS, uni-assist, Studielink, Campus France). They miss early rounds, put in weak SOPs and don't know which courses are realistic. |
| Student using an agency | The advice is "free" but biased. LeapScholar's FAQ says its revenue comes from partner-university commissions [^leap]. Some students still report paying large fees: one Trustpilot review describes ₹2,00,000 for an Italy admission [^tp]. Counsellors are overloaded, so follow-up is generic and reminders come late. |
| Working professional | Has no time for the research, needs flexible scheduling, and is often underserved by agencies built around 21-year-olds. |
| Europe-curious applicant | The best-value options (e.g., German public universities with low or no tuition) earn agencies little or no commission, so agencies push them less. Each European country also has its own process: blocked account, APS, Studielink, Campus France. |

**Root cause.** Counselling is a coordination and information problem made worse by misaligned incentives. AI agents with verified data and persistent memory can solve the coordination problem, and a different business model removes the incentive problem.

---

## 3. Target users and personas

The MVP's primary user is someone **applying for a postgraduate (master's) degree**. Undergraduate admissions are out of scope for v1 because their processes differ: UCAS, A-levels and school counsellors.

| Persona | Snapshot | Top job-to-be-done |
|---|---|---|
| **P1 · Ananya, final-year undergraduate (India)** | BTech CS, 8.1 CGPA, ₹30L budget, wants UK or Germany | "Tell me where I can actually get in and what it'll cost." |
| **P2 · Rahul, mid-career switcher** | 6 years in banking ops, wants an MSc in Business Analytics, busy and time-poor | "Run the process for me and remind me what's due." |
| **P3 · Mei, designer with a portfolio** | 3 years in UX, wants an MA/MSc in Interaction Design (UK or the Netherlands) | "Which courses fit my portfolio, and what does each one want to see?" |
| **P4 · Tunde, budget-constrained applicant** | Nigeria, strong grades, needs a scholarship or low tuition | "Find low-cost or funded options I haven't heard of." |
| **P5 · Sara, applicant with complications** | 2-year study gap, an earlier UK visa refusal, one dependant | "Am I still viable, and how do I explain my gap and refusal?" |

These five, plus 2–3 more, become the **evaluation personas** for Phase 4.

---

## 4. Jobs-to-be-done

1. **Assess:** "Help me understand how competitive I am and what to fix."
2. **Discover:** "Show me realistic courses that fit my goals, budget and timeline."
3. **Decide:** "Help me pick a balanced list of stretch, match and safe options."
4. **Prepare:** "Tell me exactly what each application needs and help me write it."
5. **Execute:** "Keep me on schedule and chase what's outstanding."
6. **Convert:** "Help me choose between offers, meet the conditions and get my visa."

---

## 5. MVP scope

### In scope (v1)
| # | Capability | Notes |
|---|---|---|
| F1 | **Sign-up and onboarding** | Email magic link + Google sign-in. Chat-first onboarding. |
| F2 | **Profile intake** | Upload a CV (PDF/DOCX) and an optional portfolio (PDF/URL), transcripts and test scores. The AI extracts structured data that the user can edit. |
| F3 | **Profile assessment** | Competitiveness by tier, strengths, gaps, and **concrete actions to close each gap**. |
| F4 | **Preference interview** | Conversational: 1st, 2nd and 3rd preference countries and subjects, intake, budget, course length, career goal, English test status, constraints. |
| F5 | **Verified shortlist** | Ambitious / Target / Safe buckets, fit score and reason. Every fact comes with a source link and a "last verified" date. |
| F6 | **Course detail** | Deadlines and application rounds, fees, entry and English requirements, documents (SOP word limit, number of LORs, portfolio specs), direct application link, scholarships. |
| F7 | **Application tracker** | Select courses → status pipeline → auto-generated checklist per course → a single timeline of all deadlines. |
| F8 | **Nudges** | Email at T-30, T-14, T-7 and T-2 days, plus a weekly digest. In-app "this week" panel. |
| F9 | **Document coach** | SOP drafting and critique for each course, LOR briefing packs for referees, CV tailoring. Never invents experience. |
| F10 | **Offer and visa** | Offer conditions tracker, deposit/CAS tracking, visa and residence-permit checklist for the UK, Ireland, Germany, the Netherlands and France. |
| F11 | **Document vault** | Uploaded and generated documents with versions. User can delete all data. |

### Non-goals (v1)
- Submitting applications for the user, or contacting referees or universities on their behalf.
- Undergraduate, PhD and MBA-specific flows (GMAT and MBA essays). An MBA can appear as a course, but there is no dedicated workflow.
- Countries outside the UK, Ireland, Germany, the Netherlands and France (the next five come in v1.1).
- Payments, paywalls, a counsellor marketplace, WhatsApp, a mobile app, loan or forex products.
- University-side dashboards or any commission arrangement.

---

## 6. User stories and acceptance criteria

**Onboarding and profile**
- *As an applicant, I can upload my CV and see my profile extracted, so I don't retype everything.*
  - ✅ Parsing a typical one- or two-page CV takes 30 seconds or less.
  - ✅ Every extracted field can be edited.
  - ✅ Fields the AI is unsure about are flagged for review, not silently filled in.
- *As an applicant, I get an honest assessment of my competitiveness.*
  - ✅ It names at least 3 strengths and at least 3 gaps.
  - ✅ Each gap comes with a specific action and an effort estimate.
  - ✅ It never promises admission.

**Preferences**
- *As an applicant, I answer questions conversationally, one or two at a time.*
  - ✅ The interview finishes in about 10 turns or fewer.
  - ✅ Skipped answers get sensible defaults, and the user is told which defaults were used.
  - ✅ Preferences can be edited later and trigger a shortlist refresh.

**Shortlist**
- *As an applicant, I see a balanced shortlist.*
  - ✅ It contains 12–25 courses across Ambitious, Target and Safe, within budget unless the user marks a course as a stretch.
  - ✅ **100% of links resolve** to official university domains.
  - ✅ Every deadline and fee shows its source and its `last_verified` date. Anything unverified is labelled "Check on official page".
- *As an applicant, I can compare courses side by side and add them to my tracker.*
  - ✅ The comparison table supports up to 4 courses.
  - ✅ "Add to tracker" creates a checklist within 5 seconds.

**Tracking and nudges**
- *As an applicant, I see everything due across all applications.*
  - ✅ The timeline sorts by date and highlights items due in 7 days or less.
  - ✅ Changing an item's status updates the course's progress.
- *As an applicant, I get reminders before deadlines.*
  - ✅ Email reminders are sent at T-30, T-14, T-7 and T-2 days for incomplete items only.
  - ✅ The user can mute reminders per course.
  - ✅ A weekly digest goes out every Monday.

**Documents**
- *As an applicant, I get an SOP draft tailored to a specific course.*
  - ✅ It uses only facts from my profile.
  - ✅ It references the course's modules or values, citing the course page.
  - ✅ It respects the word limit.
  - ✅ It is saved as a version in the vault.
- *As an applicant, I can send my referee a briefing pack.*
  - ✅ It includes my key achievements, the deadline, the submission method and a polite request.
  - ✅ The user can copy or download it. Tern does not send it automatically.

**Offer and visa**
- *As an applicant with an offer, I see what I must do next.*
  - ✅ Offer conditions are tracked with deadlines.
  - ✅ A country-specific visa checklist is generated, with sources on official government sites.

---

## 7. Success metrics

| Type | Metric | MVP target |
|---|---|---|
| **North star** | Applications submitted on time per active user | ≥ 4 per applicant per cycle |
| Activation | Users who finish onboarding and see a shortlist | ≥ 60% of sign-ups |
| Speed | Time from sign-up to a verified shortlist | < 15 min |
| Trust / accuracy | Links that resolve to official pages; spot-check accuracy of deadlines | 100% links; ≥ 95% deadlines |
| Engagement | Weekly active users during the application season | ≥ 40% of activated users |
| Outcome (lagging) | Users with ≥ 1 offer | Tracked; no target in v1 |
| Quality | Thumbs-up rate on SOP drafts | ≥ 70% |
| Cost | LLM and tool cost per activated user per month | < $3 |

---

## 8. Competitive landscape

| Player | Model | Strengths | Gaps Tern exploits |
|---|---|---|---|
| **LeapScholar** | Free to students, paid by partner-university commissions [^leap]; also an education-loan business (NBFC) | Scale, IELTS prep, loans | Incentive bias toward partner universities; not neutral |
| **Leverage Edu** | Claims free counselling, admissions and visa services [^lev] | Brand, offline centres, events | Same commission-driven model; one review reports large paid fees [^tp] |
| **upGrad Abroad** | Free app, free counselling session [^upg] | Brand, events, pathway programmes | Funnel into its own programmes |
| **Yocket** | Freemium community and premium counselling *(pricing not verified in this research)* | Community, admit/reject data | Generic follow-up; India-centric |
| **Studyportals – "Sophia" AI advisor** | Free with an account [^sp] | Largest course database, multilingual | Discovery only. No tracking, documents or visa; recommendations are ad-funded |
| **ApplyBoard – "Abbie" AI advisor** | **Only for recruitment partners (agents)** [^ab] | Deep institutional data | Not directly available to students |
| **GradRight – "Graddie"** | Free to students; earns through loans [^gr] | Loan marketplace | Loan-led, not counselling-led |
| **Abroadly** (small AI startup) | Free "Explorer" tier plus paid tiers [^abr] | Similar end-to-end idea | Unclear verification and depth; early stage |
| **Terra Dotta** AI Advisor | Sold to universities [^td] | Institution-trusted data | Advises existing students about exchanges, not applicants |
| **ChatGPT / Gemini (DIY)** | Free / $20 per month | Flexible, widely used. A Leap report says 75% of Indian students use AI for study-abroad choices [^c360] | Hallucinated deadlines and links, no memory of the application, no tracking or reminders |

### Where Tern stands apart
1. **Unbiased by design.** No university commissions, and the ranking logic is explainable. Tern says so loudly.
2. **Verified, cited facts.** Every deadline and requirement links to its source with a verification date. This is the direct fix for ChatGPT's hallucinations.
3. **Execution, not just discovery.** A tracker, checklists, nudges and a document coach in one place. Sophia and ChatGPT stop at advice.
4. **Europe done properly.** Low-tuition public-university options that commission-led agencies tend to push less, with the country-specific processes encoded (APS, blocked account, Studielink, Campus France).
5. **Built for working professionals.** Asynchronous, available 24/7, remembers context and asks fewer questions.

---

## 9. Pricing hypotheses (decide after MVP)

MVP v1 is **free**. Usage is metered per user in the background so these models can be tested later.

| Model | Shape | Pros | Cons | Test signal |
|---|---|---|---|---|
| **A. Freemium + season pass** ⭐ | Free: assessment, shortlist of up to 10, tracker for 3 courses. **Season Pass (one-time, ~₹2,999–4,999 / £49–79):** unlimited tracker, SOP/LOR coach, nudges, visa module | Matches the application season (6–9 months); one purchase feels fair; cheap compared with agency fees | Revenue spikes with the seasons | Conversion from free to pass ≥ 5% |
| **B. Monthly subscription** | ~₹799–999 / £12–15 per month | Predictable revenue | Users cancel between steps; feels wrong for a one-off life event | Retention past month 3 |
| **C. Free + paid human review** | AI free; pay per expert SOP review or mock interview (~₹1,500–3,000) | Monetises the highest-anxiety moments; builds a counsellor network | Operational overhead | Attach rate per applicant |

**Recommendation:** launch with **A**, test **C** as an add-on, and avoid **B** at first. Never take university commissions; that is the brand promise.

---

## 10. Risks and mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Wrong deadline or link → missed application | Critical (trust and possible harm) | Verifier agent; source plus date on every fact; "check official page" fallback; disclaimer; user can report an error |
| Course data coverage and freshness | High | Shared, cached course database; scheduled re-verification; prioritise the top ~300 courses per launch country and domain |
| Scraping limits / terms of service | Medium | Respect robots.txt; fetch only official pages on demand; cache; consider data partnerships later |
| Visa advice is regulated (UK: the OISC regulates immigration advice) | High | Present only **official checklists with sources**, not personalised legal advice. Clear disclaimer, and refer complex cases (refusals) to a regulated adviser. |
| PII (passports, transcripts) | High | Encryption, delete-my-data, no cross-user context, GDPR-ready because users are in the UK and EU |
| LLM cost per user | Medium | Smaller models for extraction and verification, caching, shared course database |
| SOP ghost-writing ethics / university AI policies | Medium | The coach *guides and critiques* and keeps the student's voice; warns about each university's AI policy where stated |

---

## 11. Open questions for the founder (non-blocking)
1. **Primary market at launch:** Indian applicants first, which matches the competitor set and costs in ₹, or global from day one? *Assumption:* India-first copy and ₹/£/€ currency support; the product itself is global.
2. **Undergraduate users:** confirm postgraduate-only for v1. *Assumption:* yes.
3. **Disclaimer and legal posture on visa content:** OK to stay "information plus official sources", not advice? *Assumption:* yes.

---

## 12. Next step
Phase 2 is the system design: the agent graph and orchestration, tool definitions, the data model, the verification pipeline, background jobs, security, and the cost model.

---

### Sources
[^leap]: LeapScholar FAQ on commissions: https://leapscholar.com/questions/does-leapscholar-earn-any-commission-from-partner-universities and https://leapscholar.com/questions/is-the-consultancy-service-free-or-is-there-a-consulting-fee
[^tp]: Trustpilot review of Leverage Edu (a single, unverified account): https://jp.trustpilot.com/review/www.leverageedu.com
[^lev]: Leverage Edu: https://leverageedu.com/study-abroad-consultant/ ; Collegedunia listing: https://collegedunia.com/institute/3557-leverage-edu-new-delhi
[^upg]: upGrad Abroad on the App Store: https://apps.apple.com/in/app/upgrad-abroad/id1659840900
[^sp]: Studyportals AI Student Advisor: https://studyportals.com/meet-ai-student-advisor/ ; AWS case study: https://aws.amazon.com/blogs/publicsector/the-future-of-global-higher-education-and-studying-abroad-how-studyportals-harnesses-generative-ai
[^ab]: ApplyBoard Abbie: https://www.applyboard.com/services/abbie ; launch: https://www.applyboard.com/info/applyboard-launches-abbie
[^gr]: GradRight: https://gradright.com/how-to-choose-the-right-study-abroad-app-in-2026/
[^abr]: Abroadly: https://aspire-quest-agent.pages.dev/
[^td]: Terra Dotta AI Advisor: https://www.highereddive.com/press-release/20260825-terra-dotta-brings-trusted-ai-to-study-abroad-advising/
[^c360]: Careers360 on the Leap Scholar report: https://news.careers360.com/study-abroad-75-indian-students-use-ai-tools-choices-university-rankings-lose-priority-leap-scholar-report-chatgpt-gemini-grok/amp

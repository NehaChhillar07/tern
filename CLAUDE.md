# Tern: project guide

Tern is an AI study-abroad counsellor (web SaaS). Read `docs/PROMPT.md` for the brief, `docs/01-prd.md` for scope and `docs/02-system-design.md` for architecture before making changes.

## Design principles: less is more

These are the brief for every design and UI task. They override any skill's default taste.

1. **One job per screen.** Each screen has one primary action. If a second one competes, move it or remove it.
2. **Chat first.** The conversation is the product. Everything else (shortlist, tracker, documents) is one click away in a quiet sidebar.
3. **Remove before adding.** Before adding a control, label, border, icon or colour, ask what breaks without it. If nothing does, leave it out.
4. **Calm surface.** Neutral palette and one accent colour. Whitespace does the grouping, so avoid boxes inside boxes. No decorative gradients, no shadows used as decoration.
5. **Type carries hierarchy.** One typeface family, a small type scale, sentence case. No all-caps labels.
6. **Motion only as feedback.** Animate what the user caused (open, expand, confirm, agent progress). Nothing moves by itself to decorate.
7. **Plain words.** Name things the way a student would. Buttons say what happens. Errors say what went wrong and what to do.
8. **Trust is visible.** Every deadline, fee and requirement shows its source and last-verified date without clutter (hover or tap for details).
9. **Quality floor, always:** responsive to mobile, keyboard accessible with visible focus, WCAG 2.1 AA contrast, light and dark themes, reduced motion respected.
10. **Consistent.** Use shadcn/ui components and the project's design tokens. Do not hand-roll a component shadcn already provides, and do not hard-code colours, spacing or radii.

## Which skill to use for which task

Invoke the skill before doing the task. Project skills live in `.claude/skills/` (sources in `.claude/skills/SOURCES.md`); `design:*` and `product-management:*` are plugin skills available in the Claude Code session.

| Task | Skill | Notes |
|---|---|---|
| Feature spec, scope change, acceptance criteria | `product-management:write-spec` | Update `docs/01-prd.md` |
| Exploring a new idea or trade-off | `product-management:product-brainstorming` | |
| Competitor or pricing research | `product-management:competitive-brief` | |
| Milestones, priorities | `product-management:roadmap-update`, `product-management:sprint-planning` | |
| User interviews, usability tests, surveys | `design:user-research`, then `design:research-synthesis` | |
| Visual direction, new screen or component design | `frontend-design` | Feed it the principles above as the brief |
| Design tokens, component inventory, consistency audit | `design:design-system` | Tokens live in the shadcn theme |
| Adding, composing or theming shadcn components; chat UI | `shadcn` | Always use the shadcn CLI; never copy component code by hand |
| Component architecture (compound components, props) | `vercel-composition-patterns` | |
| Writing or refactoring React / Next.js code | `vercel-react-best-practices` | |
| Any Claude API or agent code | `claude-api` | Model IDs and API shapes come from this skill, not memory |
| Button labels, empty states, errors, onboarding text | `design:ux-copy` | |
| Review of a finished screen | `design:design-critique` | |
| Accessibility check | `design:accessibility-review` | WCAG 2.1 AA |
| UI code review before merge | `web-design-guidelines` | Pinned copy of Vercel's guidelines |
| Developer handoff spec | `design:design-handoff` | |
| Code review, cleanup | `code-review`, `simplify` | |
| Running the app to confirm a change | `run` | Screenshot and look at it |

## Workflow for every UI feature

Follow these steps in order. Do not skip the review steps.

1. **Spec**: confirm the user story and acceptance criteria in `docs/01-prd.md` (`product-management:write-spec` if missing).
2. **Design**: `frontend-design` for direction, within the principles above. Reuse existing tokens and components first (`design:design-system`).
3. **Copy**: `design:ux-copy` for every label, empty state and error.
4. **Build**: `shadcn` + `vercel-react-best-practices` (+ `vercel-composition-patterns` for new shared components, `claude-api` for agent code).
5. **See it**: run the app (`run`), screenshot at mobile and desktop widths in light and dark themes, and look at the screenshots.
6. **Review**: `design:design-critique`, `design:accessibility-review` and `web-design-guidelines`. Fix what they find. Then remove one more thing (principle 3).
7. **Code review**: `code-review` before committing.

## Conventions

- Stack: Next.js (App Router), TypeScript, Tailwind, shadcn/ui, Supabase, Inngest, Resend. See `docs/02-system-design.md`.
- Facts shown to users (deadlines, fees, requirements, links) come from the database with a source, never from model memory.
- Never commit secrets. Never add third-party skills without reading them and recording them in `.claude/skills/SOURCES.md`.

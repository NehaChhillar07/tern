# Tern design system

The single source of truth for how Tern looks, moves and speaks. Every screen is built from this file. The working reference is [`docs/prototype/index.html`](docs/prototype/index.html).

## 1. The idea

**Tern is an agent, not an app with pages.** It works while you are away, tells you what it did, and asks for you only when it needs you. The interface is one thread and nothing else.

The visual world comes from travel documents: boarding passes, gates, passport stamps, three-letter airport codes. The Arctic tern lives in near-constant daylight, so the one colour is sunlight yellow on black and white.

It should feel like a sharp friend who has done this before: direct, a little playful, never corporate.

## 2. Rules

1. **No navigation.** No sidebar, tabs or menu. One thread. Anything you open is a sheet that slides over the thread and closes back to it.
2. **Tern speaks first.** Home opens with what changed and what needs you, not an empty chat box.
3. **Show the work.** When Tern does something that takes time, it lists each step as it finishes, then the result.
4. **Tern drafts, you act.** Anything sent, submitted or paid is done by the user. The interface says so in plain words.
5. **Every fact has a source.** A fact with a dotted underline opens the exact sentence it came from, the page and the date checked. An unchecked fact is muted and says "Not checked yet".
6. **Yellow means "this is yours to do" or "Tern is working".** Nothing else is yellow.
7. **Big type, few words.** One headline per screen does the talking.
8. **Lists over cards.** Rows with a hairline between them. The boarding pass is the only card.
9. **Motion answers an action.** A step ticks in, a stamp lands, a sheet rises. Nothing loops or moves by itself except the "working" dot.
10. **Remove one more thing** before shipping any screen.

## 3. Colour

| Token | Light | Dark | Use |
|---|---|---|---|
| `ground` | `#FFFFFF` | `#0B0B0D` | Page |
| `card` | `#FFFFFF` | `#17171A` | Boarding pass, composer, pills |
| `wash` | `#F2F2EE` | `#1F1F23` | Your messages, source panel, tags |
| `ink` | `#000000` | `#FFFFFF` | Text |
| `muted` | `#5E5E5A` | `#A6A6A0` | Secondary text |
| `edge` | `#000000` | `#4A4A52` | 1.5px outlines on passes, pills, composer |
| `hair` | `#DEDED8` | `#2B2B31` | 1px row dividers |
| `sun` | `#FFD60A` | `#FFD60A` | The one accent. Text on it is always black. |
| `cobalt` | `#2B4BFF` | `#93A5FF` | Links, stamps, opened sources, focus ring |
| `bill` | `#D42C10` | `#FF7359` | Deadlines that are close or moved |
| `go` | `#0B7F47` | `#4FD68C` | Finished steps |

Colour is never the only signal: a close deadline also changes its words, a finished step also gets a tick.

## 4. Type

| Role | Face | Size / weight | Notes |
|---|---|---|---|
| Headline | Bricolage Grotesque | 34–54px fluid / 800 | Tracking −0.035em, line height 1.02 |
| Sheet title | Bricolage Grotesque | 30px / 800 | |
| Codes (DEL → MAN) | Bricolage Grotesque | 38px on a pass, 52px in a sheet / 800 | |
| Body | Bricolage Grotesque | 16px / 400, 500, 600 | Line height 1.45 |
| Small | Bricolage Grotesque | 14px | Secondary lines |
| Section label | Bricolage Grotesque | 15px / 600, muted | Sentence case |
| Ticket print | DM Mono | 12px, capitals | Only on passes, stamps, dates and tags, where a real ticket would print it |

Capitals appear only in ticket print. Everything else is sentence case.

## 5. Shape, space and motion

- **Radius:** pills and the composer are fully round. Passes 22px. Run boxes 18px. Sheets 26px on their top corners on phones.
- **Outlines:** 1.5px `edge` on anything you can press or pick up. 1px `hair` between rows.
- **Space:** 40px between blocks in the thread, 14px inside a block, 10–12px row padding. Column is 720px wide at most.
- **Shadow:** none at rest. A pass lifts 2px with a hard 4px offset shadow on hover.
- **Motion:** new blocks rise 8px in 250ms. A stamp lands in 280ms with a slight overshoot. Pills press to 96%. All of it is removed under `prefers-reduced-motion`.

## 6. Components

| Component | What it is |
|---|---|
| **Headline** | Tern's one-line read of where you stand. The number that matters sits on a yellow block. |
| **While you were away** | Rows Tern wrote by itself. Glyph says which kind: red `!` changed, yellow `?` needs you, grey `✓` routine. |
| **Boarding pass** | One application. Left: home → destination codes, university, course, next step. Stub: "Gate closes" date and seven progress dots. |
| **Run** | Outlined box with a pulsing yellow dot while Tern works; steps tick in; the dot turns green when done. |
| **Result rows** | Courses Tern found, each with a fit tag, deadline, fee, one reason and a Track button. |
| **To-do row** | Checkbox, task, context, date in ticket print. |
| **Sheet** | Slides from the right on desktop, from the bottom on phones. Closes with the Close pill, Escape or a tap outside. |
| **Stamp** | Rotated cobalt outline with the current status in ticket print. |
| **Fact + source** | Dotted underline. Opens the quote, page and date inline. |
| **Composer** | Round outlined field with a yellow send button, and up to three suggestion pills above it. |
| **Passport** | Sheet with everything Tern knows about you, how complete it is, and your documents. |

## 7. Voice

- First person, as Tern. "I checked 14 pages overnight." "I can't send email for you."
- Short. One idea per sentence. Give the reason when it changes what the user does.
- Travel words where they are clearer, not everywhere: "gate closes" for a deadline on a pass, "boarding pass" for a tracked application, "passport" for the profile. Checklists and facts use plain words ("Deadline", "Tuition").
- Never promise admission. Never invent a fact. Say "Not checked yet" when that is the truth.
- Buttons say what happens: "Read the draft", "Track", "Apply on the university site".

## 8. Quality floor

- WCAG 2.1 AA contrast in both themes. Black text on yellow, never white.
- Everything works by keyboard. Focus is a 3px cobalt outline. Sheets trap and return focus.
- Tap targets are at least 36px high.
- Works from 360px wide with no sideways page scroll. The pass row scrolls sideways inside its own strip.
- Light and dark themes follow the system setting.

## 9. Building it

- Components come from shadcn/ui, themed with the tokens above. Use Motion Primitives for the step ticks, number changes and sheet transitions.
- The boarding pass and the stamp are the only custom components.
- Animated landing-page libraries (Aceternity UI, Skipper UI, Watermelon UI, scroll effects) are for the marketing site only, not the app.

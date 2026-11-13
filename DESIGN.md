# Tern design system

The single source of truth for how Tern looks, moves and speaks. Every screen is built from this file. The working reference is [`docs/prototype/index.html`](docs/prototype/index.html).

Version 3, 13 Nov 2026. The founder asked for the taste of ElevenLabs' product: its type, colour, gradients and motion. This version takes that taste and applies it to Tern's own structure. It is a reference for feel, not a copy: Tern uses its own name, fonts it is licensed to use, its own gradient values and its own components.

## 1. The idea

**Tern is an agent, not an app with pages.** It works while you are away, tells you what it did, and asks for you only when it needs you. The interface is one thread and nothing else.

The look is quiet and editorial: an off-white canvas, warm near-black ink, light-weight display type and generous space. Colour never comes from buttons. It comes from soft pastel glows, like daylight at altitude, and from one living thing on the page: Tern's orb.

The subject still shows through in the boarding passes, gates and stamps. They are drawn in the same soft language as everything else.

## 2. Rules

1. **No navigation.** No sidebar, tabs or menu. One thread. Anything you open is a sheet that floats over the thread.
2. **Tern speaks first.** Home opens with what changed and what needs you, not an empty chat box.
3. **Show the work.** When Tern does something that takes time, it lists each step as it finishes, then the result.
4. **Tern drafts, you act.** Anything sent, submitted or paid is done by the user. The interface says so in plain words.
5. **Every fact has a source.** A fact with a dotted underline opens the exact sentence it came from, the page and the date checked. An unchecked fact is muted and says "Not checked yet".
6. **Colour is atmosphere, never a control.** Pastel glows sit behind content and inside boarding passes. Buttons are ink or outlined. No saturated accent colour.
7. **Display type is light.** Headlines are weight 300 and never bold. Emphasis comes from ink against grey, not from weight.
8. **One primary action per view,** as a near-black pill. Everything else is an outlined pill or a text button.
9. **Motion is slow and soft.** Things fade and rise into place and ease out. The orb is the only thing that moves by itself.
10. **Remove one more thing** before shipping any screen.

## 3. Colour

| Token | Light | Dark | Use |
|---|---|---|---|
| `canvas` | `#F5F5F3` | `#0C0A09` | Page |
| `card` | `#FFFFFF` | `#1A1716` | Lists, boarding passes, composer, run boxes |
| `strong` | `#EFEEEB` | `#262220` | Your messages, tags, source panel, hover |
| `ink` | `#0C0A09` | `#FAFAF9` | Headlines, labels, values |
| `body` | `#45423F` | `#D2CEC9` | Running text |
| `muted` | `#76706A` | `#A39D96` | Secondary text, the quiet half of a headline |
| `hair` | `#E6E4E1` | `#2A2624` | 1px card outlines and row dividers |
| `hair-strong` | `#D5D2CE` | `#3D3835` | Pill and input outlines |
| `primary` | `#1C1917` | `#FAFAF9` | The primary pill and send button |
| `alert` / `alert-soft` | `#B4231A` / `#FBE4E1` | `#FF8A7D` / `#3A1B18` | Deadlines that are close or moved |
| `ok` | `#15803D` | `#5FD08E` | Finished steps |

### Glows

| Token | Light | Dark |
|---|---|---|
| `mint` | `#B4E6D4` | `#1F4A3F` |
| `peach` | `#F6CDB0` | `#5A3A26` |
| `lilac` | `#CDBDE6` | `#3D315C` |
| `sky` | `#AFCDEE` | `#25405E` |
| `rose` | `#EDBFCB` | `#5A2F3C` |

Glows are soft radial gradients that fade to transparent. They appear in three places only: one large blurred bloom behind the top of the thread, the corner of each boarding pass (each pass gets a different pair), and the orb. They are never a button fill, a text colour or a flat background.

Colour is never the only signal: a close deadline also changes its words, a finished step also gets a tick.

## 4. Type

| Role | Face | Size / weight | Notes |
|---|---|---|---|
| Headline | Inter Tight | 32–50px fluid / 300 | Tracking −0.03em, line height 1.08. First sentence in ink, the rest in muted. |
| Sheet title | Inter Tight | 30px / 300 | |
| Codes (DEL → MAN) | Inter Tight | 38px on a pass, 54px in a sheet / 300 | |
| Wordmark | Inter Tight | 20px / 500 | Lowercase |
| Body | Inter | 16px / 400, line height 1.5 | Tracking +0.01em |
| Emphasis and labels | Inter | 16px / 500 | |
| Section label | Inter | 15px / 500, ink | Sentence case |
| Small | Inter | 14px / 400 | |
| Button | Inter | 15px / 500 | |
| Ticket caption | Inter | 11px / 600, capitals, tracking +0.08em | Only on passes, stamps and dates |

ElevenLabs' own display face is licensed and cannot be used here. Inter Tight at weight 300 is the stand-in. If Tern later licenses a display face, it replaces Inter Tight in the headline, sheet title and codes only.

## 5. Shape, space and depth

- **Radius:** pills fully round. List cards and run boxes 16px. Boarding passes 20px. Sheets 24px. Composer 26px. Source panel 12px.
- **Outlines:** 1px `hair` on cards, 1px `hair-strong` on pills and the composer.
- **Depth:** one soft shadow, `0 6px 24px` at 6% black. It sits under the composer and sheets, and appears under a boarding pass on hover.
- **Space:** 44px between blocks in the thread, 14px inside a block, 14px row padding inside cards. Column is 720px wide at most.
- **Lists live in cards.** A group of rows sits in one white card with hairlines between rows.

## 6. Motion

One curve everywhere: `cubic-bezier(.2, .8, .2, 1)`.

| What | How |
|---|---|
| New block in the thread | Fades in and rises 12px over 500ms |
| Sheet | Rises and fades in over 450ms; the page behind blurs slightly |
| Stamp | Settles from 1.5× to size over 450ms |
| Source panel | Fades in over 300ms |
| Boarding pass on hover | Lifts 2px and gains the soft shadow over 300ms |
| Pills and send button | Press to 97% |
| **Orb, resting** | Turns once every 14 seconds |
| **Orb, working** | Turns once every 2.2 seconds, and the run title shimmers |
| Orb, done | Stops and becomes a solid green dot |

All motion is removed under `prefers-reduced-motion`.

## 7. Components

| Component | What it is |
|---|---|
| **Orb** | Tern itself. A sphere of the five glow colours with a soft highlight. 48px at the top of the thread, 16px inside a run. |
| **Headline** | Tern's one-line read of where you stand. Greeting in ink, the fact that matters in muted grey. |
| **While you were away** | A card of rows Tern wrote by itself. Glyph says which kind: red `!` changed, peach `?` needs you, grey `✓` routine. |
| **Boarding pass** | One application. Glow in the corner, home → destination codes, university, course, next step. Stub: "Gate closes" date and seven progress dots. |
| **Run** | White card with the small orb. Steps tick in; the title shimmers while it works. |
| **Result rows** | Courses Tern found, each with a fit tag, deadline, fee, one reason and a Track pill. |
| **To-do row** | Checkbox, task, context, date in ticket caption. |
| **Sheet** | Floats 12px inside the right edge on desktop; rises from the bottom on phones. Closes with the Close pill, Escape or a tap outside. |
| **Stamp** | Tilted outlined label with the current status. |
| **Fact + source** | Dotted underline. Opens the quote, page and date inline. |
| **Composer** | White rounded field with the soft shadow and a near-black send button, with up to three suggestion pills above it. |
| **Passport** | Sheet with everything Tern knows about you, how complete it is, and your documents. |

## 8. Voice

- First person, as Tern. "I checked 14 pages overnight." "I can't send email for you."
- Calm and short. One idea per sentence. Give the reason when it changes what the user does.
- Travel words where they are clearer, not everywhere: "gate closes" for a deadline on a pass, "boarding pass" for a tracked application, "passport" for the profile. Checklists and facts use plain words.
- Never promise admission. Never invent a fact. Say "Not checked yet" when that is the truth.
- Buttons say what happens: "Read the draft", "Track", "Apply on the university site".

## 9. Quality floor

- WCAG 2.1 AA contrast in both themes. Text never sits on a glow strong enough to drop below it.
- Everything works by keyboard. Focus is a 2px ink outline. Sheets trap and return focus.
- Tap targets are at least 36px high.
- Works from 360px wide with no sideways page scroll. The pass row scrolls sideways inside its own strip.
- Light and dark themes follow the system setting.

## 10. Building it

- Components come from shadcn/ui, themed with the tokens above. Use Motion Primitives for the fades, the step ticks and the sheet.
- The orb, the boarding pass and the stamp are the only custom components. The orb in the real product should be drawn on a canvas so it can flow, not just turn.
- Animated landing-page libraries (Aceternity UI, Skipper UI, Watermelon UI, scroll effects) are for the marketing site only, not the app.

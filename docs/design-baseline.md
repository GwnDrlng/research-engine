# Design baseline — Fluxon visual identity

**Standing rule: every HTML artifact produced in this repo (journey maps, diagrams, reports,
internal docs) uses this palette and type system as its visual baseline**, not a generic or
invented one. Extracted 2026-08-12 from `https://www.fluxon.com/our-work` via computed styles
(not eyeballed from screenshots) — re-verify against the live site if it redesigns.

## Core tokens

| Token | Value | Source |
|---|---|---|
| Background (`fluxonOffBlack`) | `#060311` | `body` computed `background-color` |
| Primary text (`fluxonOffWhite`) | `#EEECE8` | headings, body copy, pill-tag text — same color throughout; hierarchy comes from size/weight, not a separate text color |
| Secondary / de-emphasized text | `#EEECE8` at `opacity: 0.6` | inactive nav links use opacity, not a different hex, to step down emphasis |
| Primary accent (CTA / "confirmed") | `#1D4ED8` | `Get in touch` button `background-color` (Tailwind blue-700) |
| Glass card fill | `rgba(255,255,255,0.05)` | feature-card / content-card backgrounds over the dark canvas |
| Card / pill border | `#EEECE8` at low opacity (~`rgba(238,236,232,0.15–1)` depending on emphasis) | outline tag-pills use a full-opacity 1px off-white border; card borders should sit lighter |
| Image / placeholder surface | `#1F2937` | Tailwind gray-800, used behind product-shot containers |

**Secondary accents** (not on the marketing chrome itself, but present in Fluxon's own product
screenshots on this page — legitimate to draw from rather than inventing new hues):
- **Violet** `#6D4FD6` — from the hero background gradient
- **Coral** `#E2725B` — from a data-point color in an embedded dashboard mockup
- **Amber/gold** `#D6A756` — a muted warm tone consistent with the same mockups, for a third status when needed

## Type system

- **Headings & body: Poppins.** Even large display headlines run at weight 400 — hierarchy is
  carried by size, not boldness. Use 500–600 at small artifact scale (under ~28px) where 400 gets
  hard to read.
- **Labels, tags, citations, anything uppercase: DM Mono.** Always paired with `uppercase`,
  `letter-spacing: ~0.16em`, weight 500, small size (~14px at the site's own scale).
- Body copy runs large on the source site (~20–24px) with generous line-height; scale down
  proportionally for denser working documents, but keep the two-font split (Poppins / DM Mono) —
  never introduce a third typeface.

## Components

- **Buttons (primary):** solid `#1D4ED8` fill, off-white text, `border-radius: ~8px` (`rounded-lg`).
- **Pills / tags / badges:** transparent background, `1px solid` border in the relevant accent
  color, fully rounded (`border-radius: 9999px`), DM Mono uppercase label inside. This is the
  pattern to reuse for status badges (finding / hypothesis / gap / etc.) — border+text color
  carries meaning, never a filled color block. Matches the site's own `AI` / `AI DEV` / `APP DEV`
  case-study tags exactly.
- **Cards:** `rgba(255,255,255,0.05)` fill, `border-radius: 16px` (`rounded-2xl`), no drop shadow
  needed — the fill against the near-black canvas is enough separation.
- **Radius scale:** 8px (buttons/small), 16px (cards), 20px (large feature panels).
- **No light mode.** The source site is dark-only — commit to the dark canvas rather than building
  a light/dark toggle, unless a specific artifact's destination (e.g. a published Artifact with a
  light-mode viewer) requires one.

## What NOT to carry over

- Don't invent a rainbow of status colors — stay inside the four accents above (blue, violet,
  coral, amber) plus off-white/opacity for everything else.
- Don't use a serif typeface anywhere; earlier artifacts in this repo (e.g. `docs/user-journey.html`)
  used an editorial serif + teal/amber/coral triad — that look is superseded by this baseline for
  any new or re-touched artifact.
- Don't fill badges/tags with a tinted background wash — Fluxon's own tags are outline-only.

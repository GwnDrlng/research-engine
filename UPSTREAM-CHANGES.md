# Upstream candidates from this project

Things built or learned while running a recent study that are generic enough to fold back into
the Research Engine framework (the canonical template repo), separate from anything specific to
one client or study.

## 1. House writing/visual standards (already committed, worth keeping)

- **`docs/writing-guidelines.md`** — a stakeholder-facing writing standard (compress non-quote
  prose, short noun-phrase titles, quotes untouched, strip internal-process scaffolding, keep
  participant counts and read-changing caveats). Referenced from `CLAUDE.md` under a new
  "House standards" section. Generic to any study.
- **`docs/design-baseline.md`** — a real, computed-styles-verified visual baseline (a brand
  palette + type system) so HTML artifacts stop inventing a new palette each time. The pattern —
  "extract a real palette from computed styles, document the tokens and what NOT to carry
  over" — is reusable for any team building against its own brand's visual identity.
- The `CLAUDE.md` edit wiring both docs in as required reading before producing a deliverable.

## 2. Rubric / judge hardening (already committed)

- **Explicit PASS/WARN/FAIL acceptance criteria** added to every rubric (`discussion-guide.md`,
  `insights.md`, `microcopy.md`, `synthesis.md`): PASS, or NEEDS-WORK with only WARNs, is
  acceptable; any FAIL is not. Closes a real failure mode where a judge invented a threshold
  ("WARN allowed on at most one non-anti-fabrication criterion") that didn't exist in the rubric
  and cited it as though it did.
- **Participant-counting rigor** in `rubrics/synthesis.md`: a theme's claimed participant count
  must be traced to displayed evidence, not just asserted; a per-theme count table; a
  consistency check across repeated judge runs on the same fixture.
- **Bounded judge retry policy**: 2 retries, every attempt logged, unresolved failures escalated
  to the user rather than looped on indefinitely. (Also captured as a standing memory —
  `eval-and-judge-retry-policy` — so it's enforced even in sessions that haven't read the eval
  harness code.)
- A new eval fixture (`synthesis-arithmetic`) targeting the counting-failure family, plus a
  backfilled run log from live use recording observed failure modes from the first real study.

## 3. Journey Layers visualization — generalize into a template (this change)

A recent study built a rich, data-driven "journey layers" HTML visualization (kept in a
gitignored project folder — real participant quotes and company data) with:

- a horizontal timeline of stages → steps → points of contact
- a tool-in-use matrix with a "trace" line showing tool switches
- a roles-involved matrix
- a duration bar (measured vs. not-measured segments)
- a parallel/background process lane (e.g. an onboarding or supply pipeline running
  continuously rather than once per journey instance)
- a sentiment ("experience") chart wired to a linked evidence panel (click a point → see the
  sourced quotes)
- a role-isolation toggle that dims every layer down to one role's footprint

This is generic UX-research tooling, not specific to any one study. **Extracted as
`templates/journey-layers.html`** — same CSS/rendering engine, brand-neutral design tokens,
placeholder `STAGES`/`ROLES`/`TOOLS`/`CP`/`DUR`/`LANE` data with inline documentation of every
field, and a banner reminding whoever fills it in that real data belongs only in
`projects/<study-slug>/`, cited as `P1..Pn`, per `CLAUDE.md`. Following the
`html-deliverables-are-built-not-hand-edited` convention, any future page-specific styling
should live in the consuming study's shell, not be hand-patched into a copy of the template.

**Recommended next step for upstreaming:** land `templates/journey-layers.html` in the canonical
repo alongside the existing `templates/`, and add a one-line pointer to it from
`research-insights` or `research-synthesis` (whichever skill produces journey maps) so future
studies discover it instead of reinventing the visualization.

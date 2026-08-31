# Observed failure modes — synthesis pass, first real study

Failure modes that showed up in **live use**, not in fixtures. Recorded so the rubric, the skills and
the eval suite can be hardened against them, and so the next person doesn't rediscover them.

**Provenance:** one study, 11 participants across 4 segments, 11 transcripts (~5h 20m), 10 themes,
**3 judge passes** (`rubrics/synthesis.md`). Verdicts: NEEDS-WORK 2/5 → NEEDS-WORK 4/5 → NEEDS-WORK 3/5.
Study specifics are deliberately omitted; the study's own revision log lives in its (gitignored) folder.

**Headline:** quote *fidelity* was never the problem. Across three passes the judge checked ~40 quotes
and found **zero** paraphrases, misattributions or unsourced quotes. Every single correction was about
**participant counting and claim scoping** — the arithmetic of evidence, not its accuracy. The rubric
currently spends 2 of 5 criteria on fidelity-type checks and 1 on breadth. That ratio is backwards
relative to where real errors occur.

---

## Failure modes, by frequency observed

| ID | Failure mode | Times | Detected by |
|---|---|---|---|
| **FM-2** | **Participant counted toward a theme with no displayed quote.** The count was traceable to the coder's own notes, but a reader could not verify it from the artifact. | **6** | judge 2, judge 3 |
| FM-3 | **Adjacent evidence counted as on-theme.** Topically nearby, supports a different claim. | 5 | judge 1 (as a pattern), judge 2, judge 3 |
| FM-4 | **Compound theme hiding unequal support.** Theme asserts two things; the headline count is the union, so the weaker claim inherits the stronger claim's N. | 2 | judge 2, judge 3 |
| FM-1 | **Cross-theme double counting.** One incident cited under a parent theme *and* its sub-theme, counted in both headline Ns. | 1 | judge 1 |
| FM-5 | **Uniform evidentiary framing over non-uniform evidence.** "Observed live, not merely reported" asserted across a set where only part was observed. | 1 | judge 1 |
| FM-6 | **Counting off a hedge.** A participant's "I guess" treated as evidence of the thing being hedged about — when their other statements showed the opposite. | 1 | judge 3 |
| FM-7 | **Violating a self-declared exclusion.** The coding file explicitly excluded a participant's input from counts (builder's feature request); the synthesis counted it anyway. | 1 | judge 2 |
| FM-8 | **Self-audit as credibility laundering.** A disclosure that verification was incomplete, paired in the same paragraph with a confident claim about the unverified region. The claim was false. | 1 | judge 3 |
| FM-9 | **Spot-check described as comprehensive.** One participant checked per theme; written up as "every theme now carries a qualifier where warranted." | 1 | judge 2 |
| FM-10 | **Over-redaction destroying meaning.** A technical term matching a person-name pattern was redacted, corrupting the analysis. | 1 | self |
| FM-11 | **Under-redaction defeating exact matching.** Auto-transcription produces phonetic variants of names that exact-match redaction misses. Took **7 successive passes** to converge. | 7 | self |
| FM-12 | **Moderator speech mistakable for participant evidence.** Compounded when the moderator recounts other participants' sessions mid-interview. | avoided | — |
| FM-13 | **Study-sequence contamination.** The moderator carried a solution idea from an early session into later ones; later assent then reads as independent demand. | avoided | — |
| FM-14 | **Multi-layer source documents.** AI meeting-note tools emit summary + narrative + verbatim in one file, plus machine-invented "action items" attributed to no one. Coding the wrong layer stacks inference on inference. | avoided | — |

FM-12 to FM-14 were caught before they caused errors, but only because they were looked for
deliberately. Nothing in the current skill or rubric tells you to look.

---

## Two meta-lessons that matter more than any single fix

### 1. Judge scores are not comparable across passes

The sequence was **2/5 → 4/5 → 3/5**. The score fell on the third pass, not because the artifact got
worse — it had improved on every axis — but because pass 3 performed a per-participant re-derivation
that pass 2 did not. Pass 2 sampled; pass 3 audited.

**Consequence: a rising score is not evidence of improving work.** If the judge's thoroughness varies
between invocations, the loop can terminate on a lucky shallow pass. This is arguably the most
important finding here, because it undermines the quality gate's core promise.

**Fix:** make the expensive checks mandatory and explicit in the rubric rather than leaving depth to the
judge's discretion, so passes are comparable. See proposed criterion 2 below.

### 2. A remediation step introduced a fresh defect

FM-8 did not exist in the original synthesis. It was *created* by the fix for FM-9 — disclosing an
incomplete audit, then reassuring the reader about the part that hadn't been checked. The disclosure
borrowed credibility for a claim that turned out to be false.

**Fix:** treat post-judge revisions as new drafts requiring re-judging, never as patches. The current
skill says "revise and re-judge until accepted," which is right — but it should say why: **revisions can
regress, and remediation text is itself unverified content.**

---

## Status of the proposals below

**APPLIED 2026-08-12** (authorised by the researcher):

- `rubrics/synthesis.md` — criterion 2 rewritten as a six-item checklist including the
  **displayed-evidence rule**; "Required procedure — no sampling on criterion 2" added; two new
  anti-fabrication hard fails (untraced participant, laundered disclaimer); output format extended with
  `UNTRACED-PARTICIPANT COUNT`, `THEMES RE-DERIVED`, and a required per-theme count table.
- `.claude/skills/research-synthesis/SKILL.md` — Step 3 now requires a trace and an evidence type for
  every counted participant plus a one-sentence claim per theme; Step 5 requires re-judging after every
  revision, with both meta-lessons stated as the reason.
- `evals/` — `synthesis-arithmetic` fixture added (expect FAIL); `synthesis-sound` updated to comply
  with the displayed-evidence rule; `CONSISTENCY_CASES` added to `run-evals.sh`.
- **Bounded-retry policy** (`evals/README.md`, `run-evals.sh`, and the synthesis skill's Step 5):
  acceptable = `PASS` or warn-level `NEEDS-WORK` with no criterion at `FAIL`; **at most 2 retries**;
  every attempt logged to `evals/run-log.md`; escalate to the user and log as `UNRESOLVED` after the
  third attempt. Rationale: against a non-deterministic grader an unbounded retry loop eventually passes
  by luck rather than by improvement, and a silent retry destroys the evidence that anything needed
  fixing. `rubrics/synthesis.md` now also states where the `WARN`/`FAIL` boundary sits, since that line
  is what opens or closes the gate.
- **Consistency comparator strengthened** from verdict-only to `verdict|score|untraced-count`. Verdict
  alone cannot detect the observed pathology: across the three live passes the verdict stayed
  `NEEDS-WORK` while the score moved 2/5 → 4/5 → 3/5.

**NOT YET APPLIED:** the `governance/pii-handling.md` changes, the evidence-type and source-layer
criteria as *separate* rubric criteria (evidence-type labelling landed inside criterion 2 and the skill
instead), and the remaining 7 proposed fixtures.

## Proposed changes to `rubrics/synthesis.md`

**Criterion 2 (Participant breadth honesty) — replace with an explicit checklist.** The current wording
only catches thin themes presented as findings, which never actually happened. It missed all 6 instances
of FM-2. Proposed additions:

- **Displayed-evidence rule (FM-2):** every participant in a theme's count must have at least one
  quote displayed *in that theme*, or be explicitly marked adjacent with a reason. `FAIL` otherwise.
  A count traceable only to the coder's private notes is unverifiable and does not count.
- **Sub-theme double-count check (FM-1):** no participant may appear in both a theme's and its
  sub-theme's headline count for the same incident.
- **Compound-claim check (FM-4):** if the theme name or description contains "and", test each clause
  separately and report a count per clause.
- **Declared-exclusion check (FM-7):** re-read the coding files' evidence-handling rules; anyone
  excluded there must not be counted here.
- **Hedge check (FM-6):** a hedged statement ("I guess", "maybe", "I think") is not evidence of the
  thing hedged about.

**New criterion — Evidence-type labelling (FM-5).** Each participant's contribution tagged
`observed` / `self-reported` / `second-hand` / `system-description`. `FAIL` where a theme claims
observational strength for self-reported or second-hand evidence.

**New criterion — Source-layer and speaker discipline (FM-12, FM-14).** Verify quotes come from the
verbatim layer and that no moderator speech is attributed to a participant. This is currently implicit
in "quote fidelity" and deserves to be explicit, because AI-note tooling makes it easy to get wrong.

**New anti-fabrication hard fail (FM-8).** *A disclosure of incomplete verification may not be
accompanied by a confidence claim about the unverified region.* Either verify, or state the gap without
reassurance.

**Output-format addition.** Require a per-theme table: `theme | claim in one sentence | participants |
quote displayed for each? Y/N | evidence type per participant`. Most of the errors above become visible
the moment that table is filled in honestly.

## Proposed changes to `.claude/skills/research-synthesis/SKILL.md`

- **Step 3:** require the count table above as the *output format* of clustering, not prose. Prose is
  what let uncited participants hide.
- **New Step 3a:** write each theme's claim as one sentence, then test every participant's quote against
  that exact sentence. If the sentence needs an "and", split the theme.
- **New Step 1a — source-layer discipline:** where transcripts come from AI note-takers, identify the
  verbatim layer and code only from it. Machine-generated summaries, "action items" and "next steps" are
  the tool's inferences, not participant speech.
- **New Step 2a — speaker discipline:** exclude moderator turns, including moderator descriptions of
  other sessions and moderator-proposed solutions. Where a participant merely assents to a
  moderator-introduced idea, record it as assent, not demand (FM-13).
- **Step 5:** state that re-judging is required after *every* revision because remediation text is
  unverified content that can regress (see meta-lesson 2).

## Proposed changes to `governance/pii-handling.md`

- **Phonetic-variant pass (FM-11).** Exact-name replacement is insufficient against auto-transcription.
  Procedure that eventually converged: (1) replace known names; (2) scan rare capitalized **bigrams**;
  (3) scan low-frequency capitalized **single tokens**; (4) re-scan after reading each transcript, since
  variants surface only in context. Build the variant list *before* pass 1.
- **Over-redaction review (FM-10).** After redaction, review replacements for non-person tokens —
  technical terms, product names, place names. Redacting a term of art corrupts the analysis.
- **State the guarantee at the right boundary.** Full redaction of free-text colleague mentions is not
  reliably achievable. The enforceable guarantee is that only `Pnn`/`[Cnn]` codes reach a deliverable.

---

## Proposed new eval fixtures

Following `evals/README.md` → "Adding a case". All fixtures must be fully synthetic.

| Fixture | Rubric | Expected | Plants |
|---|---|---|---|
| `synthesis-uncited-participant` | synthesis | **FAIL** | FM-2: theme claims 5 participants, displays quotes for 3 |
| `synthesis-double-count` | synthesis | **FAIL** | FM-1: same incident counted in a theme and its sub-theme |
| `synthesis-compound-claim` | synthesis | **FAIL** | FM-4: "X and Y" theme where X has 5 and Y has 1 |
| `synthesis-adjacent-evidence` | synthesis | **FAIL** | FM-3: quote is topically near but supports a different claim |
| `synthesis-hedge-as-evidence` | synthesis | **FAIL** | FM-6: participant counted off "I guess", contradicted elsewhere in their own transcript |
| `synthesis-laundered-disclaimer` | synthesis | **FAIL** | FM-8: self-audit admits incompleteness then asserts safety |
| `synthesis-moderator-quote` | synthesis | **FAIL** | FM-12: moderator line attributed to a participant |
| `synthesis-summary-layer` | synthesis | **FAIL** | FM-14: quote drawn from an AI-generated summary layer, not the verbatim layer |
| `synthesis-honest-counts` | synthesis | **PASS** | control: compound theme correctly split, every participant cited, evidence types labelled |

The existing `synthesis-overclaimed` / `synthesis-sound` pair covers thin-theme-as-finding, unsourced
quotes and inference-as-observation — **none of which occurred in real use.** The suite is currently
testing for the failures that didn't happen and not for the ones that did.

---

## What held up well, and should not be changed

- **Quote fidelity discipline.** Zero fabrications or paraphrases across ~40 checked quotes, three
  passes. Coding directly from verbatim text with timestamps works.
- **The observation/interpretation split.** Passed all three judge passes. Per-transcript
  "my interpretations, flagged as mine" sections did their job.
- **Tension surfacing.** Passed all three passes and was called the strongest part of the artifact.
  Recording disagreements per-theme *and* in a dedicated section is worth keeping.
- **Conflict-of-interest flagging.** With 5 of 11 participants having a stake in the tool under study,
  per-participant conflict notes in the coding files prevented stakeholder wishes being reported as user
  needs — except once (FM-7), which is why the mechanical re-check is proposed above.
- **The separate-judge design.** It caught every counting error, including two that survived a previous
  judge pass. A self-review would not have found them; the errors were invisible from inside the
  reasoning that produced them.

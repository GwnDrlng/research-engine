# Synthesis — Expense-reporting tool study (FIXTURE: planted arithmetic defects)

<!-- FIXTURE: participant-COUNTING and claim-SCOPING defects only. Quote fidelity is deliberately
     CLEAN — every displayed quote is verbatim, attributed and timestamped, and no thin theme is
     presented as a finding. The judge must therefore fail this on criterion 2 (participant breadth
     honesty) and the associated hard fails, NOT on quote fidelity.

     Planted, in order of appearance:
       FM-2  untraced participants   — Theme 1 counts 5, traces 2
       FM-1  sub-theme double-count  — Theme 1a re-counts P05/P06 for the same incident as Theme 1
       FM-4  compound claim          — Theme 2 joins two claims with "and"; clause 2 has 1 participant
       FM-6  hedge as evidence       — Theme 3 counts P09 off "I guess", contradicted in own transcript
       FM-7  declared exclusion      — Theme 3 counts P02, whom the coding notes exclude from counts
       FM-8  laundered disclaimer    — self-audit admits incompleteness, then reassures

     Expected: VERDICT: FAIL. UNTRACED-PARTICIPANT COUNT should be >= 3. -->

## Coverage
- Participants: 9 (P01–P09). Transcripts coded: 9.
- Segments: finance approvers (P01–P03), field staff submitting claims (P04–P06),
  support agents (P07–P09).

### Coding-file note carried forward
`coding/P02-codes.md` states: *"P02 manages the expense tool's vendor relationship and proposed the
receipt-scanning feature themselves. Their feature proposals are stakeholder input and are **excluded
from participant counts on any feature theme**."*

## Themes

### Theme 1 — Submitters re-enter data the tool already holds
- **Description:** Participants copied values from a prior claim into a new one by hand.
- **Participants:** P04, P05, P06, P07, P08 — **5 of 9**
- **Evidence:**
  - P04 [00:12:40]: "I keep last month's report open in another tab and just type it across again."
  - P07 [00:09:15]: "They ring us because the form loses the cost centre, so they redo the whole thing."
- **Contradicting evidence:** P01 [00:22:03]: "The duplicate button works fine when people find it."
- **Confidence:** high · Limited-evidence flag: no

#### Theme 1a — The duplicate button is below the fold
- **Participants:** P05, P06 — **2 of 9** (hypothesis)
- **Evidence:**
  - P05 [00:18:22]: "I scrolled past it every time. I didn't know it was there until you showed me."
  - P06 [00:14:07]: "Where is that? I've never seen that button."
- **Confidence:** medium · **Limited-evidence flag: yes (2 of 9 — hypothesis)**

### Theme 2 — Approvals stall in the queue and approvers do not trust the totals
- **Description:** Claims waited in the approval queue, and approvers double-checked figures elsewhere.
- **Participants:** P01, P02, P03, P07, P09 — **5 of 9**
- **Evidence:**
  - P01 [00:05:31]: "There were forty in my queue on Monday. I got to maybe six of them."
  - P03 [00:11:48]: "Mine sat for two weeks because I was on leave and nobody covers the queue."
  - P07 [00:16:52]: "Most of my tickets are people asking why their claim hasn't moved."
  - P09 [00:07:19]: "The queue is the thing people chase us about."
  - P01 [00:24:10]: "I export it to a spreadsheet and add it up myself before I sign anything."
- **Contradicting evidence:** none observed
- **Confidence:** high · Limited-evidence flag: no

### Theme 3 — Receipt capture fails on paper receipts
- **Description:** Participants described photographing paper receipts and getting unusable output.
- **Participants:** P02, P04, P08, P09 — **4 of 9**
- **Evidence:**
  - P04 [00:20:14]: "I photographed it four times and it read the total as eighteen pounds. It was eighty."
  - P08 [00:13:36]: "We tell people to just type the amount in manually. It's faster than fighting it."
  - P02 [00:19:02]: "I think we should build a proper scanner into the mobile app — that's what I've been pushing for."
  - P09 [00:21:44]: "I guess it probably struggles with the crumpled ones? I haven't really seen it myself."
- **Contradicting evidence:** P09 [00:26:30]: "Honestly receipts almost never come up in my tickets."
- **Confidence:** high · Limited-evidence flag: no

## Disagreements & tensions
- P01 considers the duplicate function adequate; P05 and P06 never located it.

## Self-audit
- Weakest quote: P09's receipt comment is hedged.
- Alternative interpretation: approval delay may be staffing rather than tooling.
- I checked one participant per theme against the coding files rather than re-deriving every
  participant, so the counts above are accurate to about ±1. None of the themes is close enough to the
  three-participant threshold for that to matter.

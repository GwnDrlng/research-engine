---
name: product-brief-reviewing
description: Systematically review a Product Brief (also called a one-pager, opportunity brief, concept brief, or product proposal) to judge whether the opportunity is real, the evidence is sufficient, the direction is clear, and the brief is ready to earn a go/no-go decision or progress to PRD writing. Use this skill whenever the user asks to review, critique, assess, pressure-test, score, or give feedback on a product brief, one-pager, opportunity doc, or early-stage product proposal, even if they do not use the word "brief". Do not use for PRDs (use prd-reviewing), feature specs, or technical plans.
---

# Product Brief Reviewing

## Purpose

Systematically review Product Briefs to ensure they make a clear, evidence-backed case for an opportunity and are ready for a decision. A brief is reviewed earlier and with a lighter touch than a PRD: the question is not "can engineering build this from the document" but "should we invest discovery and build time in this at all, and is the direction sound."

Catching a weak problem, a missing business case, or a solution-first brief at this stage is far cheaper than catching it after a PRD has been written and a team has been staffed.

## What a Product Brief Is (and Is Not)

A Product Brief typically answers:

- What problem or opportunity are we addressing, and for whom?
- Why does it matter to the business, and why now?
- What is the proposed direction (at a high level)?
- What would success look like?
- What do we need to decide, and what happens next?

A brief is **not** a PRD. Do not penalize a brief for lacking user stories, acceptance criteria, or detailed requirements. Do penalize it for lacking a problem, evidence, a target user, a business rationale, or a clear decision ask.

## When NOT to Use This Skill

- Writing a Product Brief (use product-brief-writing if available)
- Reviewing a PRD (use prd-reviewing)
- Reviewing technical implementation plans (use sparc-planning or technical-spec-reviewing)
- Reviewing feature specs (use feature-spec-reviewing)
- Code review (different domain entirely)
- No brief exists yet (nothing to review)

## Review Workflow

### Step 1: Document Analysis

Read the entire brief and assess structural completeness:

```markdown
Initial Assessment Checklist:
- [ ] Document has clear title, author, date, and status (draft / for decision / approved)
- [ ] Problem or opportunity statement exists
- [ ] Target user or customer segment is identified
- [ ] Business rationale or "why now" is stated
- [ ] Proposed direction or solution hypothesis is described at a high level
- [ ] Desired outcomes or success measures are defined
- [ ] Scope boundaries or non-goals are stated
- [ ] Risks, assumptions, and open questions are listed
- [ ] Decision being requested and next steps are explicit
- [ ] Stakeholders and owner identified
```

Red Flags:

- Document is mostly solution or implementation detail
- No user-focused problem or opportunity statement
- No business rationale (revenue, cost, risk, strategic position)
- No stated decision ask (reader does not know what they are being asked to approve)
- Brief is so long it reads as a PRD draft

### Step 2: Problem and Opportunity Validation

Evaluate the problem or opportunity statement:

```markdown
Problem Validation Questions:
1. Is this a real user or customer problem (not a solution in disguise)?
2. Who experiences this problem? (Specific segment or persona, not "users")
3. How painful or frequent is it? Is the impact quantified or at least explained?
4. What is the evidence? (Interviews, support data, sales feedback, usage data, market research)
5. Is the opportunity sized, even roughly? (Number of affected customers, revenue at stake, cost of inaction)
6. Why now? What changed in the market, the product, or the business?
```

Severity Guide:

| Issue | Severity |
| --- | --- |
| No problem or opportunity statement | BLOCKER |
| Solution masquerading as problem | BLOCKER |
| Problem exists but unquantified and no evidence | CRITICAL |
| Vague target users | MAJOR |
| No "why now" | MAJOR |
| Evidence referenced but not linked or cited | MINOR |

### Step 3: Target User and Customer Clarity

A brief that cannot name its user cannot be validated.

```markdown
Target User Checklist:
- [ ] Primary segment or persona is named specifically
- [ ] Buyer and user are distinguished if they differ (common in B2B)
- [ ] Segment is reachable (we can find and talk to these people)
- [ ] Segment is large or valuable enough to justify investment
- [ ] Any explicitly de-prioritized segments are noted
```

Common Issues:

| Issue | Example | Severity |
| --- | --- | --- |
| Generic user | "As a user" or "customers" with no segment | MAJOR |
| Buyer/user conflation | Treats the CISO and the analyst as the same person | MAJOR |
| Unreachable segment | No plan or channel to access the target users | MAJOR |
| Segment too small to matter | Opportunity sized at a handful of accounts without rationale | CRITICAL |

### Step 4: Solution Direction Review

Evaluate the proposed direction. At brief stage, the direction should be a hypothesis, not a spec.

```markdown
Direction Checklist:
- [ ] Direction is described at the level of "what we would offer" not "how we would build it"
- [ ] Direction clearly addresses the stated problem
- [ ] Alternatives considered are listed (including "do nothing" and "buy/partner")
- [ ] Rationale for the chosen direction over alternatives is given
- [ ] Key assumptions that must hold are stated
- [ ] Differentiation versus existing options (internal or competitive) is explained
```

Direction Smell Test:

- If the direction section is longer than the problem section, the brief is solution-first
- If no alternatives are listed, the author likely anchored on one idea
- If the direction does not map back to the problem, the brief has drifted
- If the direction names specific technologies or vendors without justification, it is over-specified for this stage

| Issue | Example | Severity |
| --- | --- | --- |
| Direction does not address stated problem | Problem is onboarding time, direction is a reporting dashboard | BLOCKER |
| No alternatives considered | Single option presented as the only path | MAJOR |
| Over-specified implementation | Lists API endpoints, database schema, sprint plan | MAJOR |
| Unstated critical assumption | Assumes a partner integration exists without confirming | CRITICAL |

### Step 5: Business Case and Strategic Fit

A brief must justify why the business should care.

```markdown
Business Case Checklist:
- [ ] Ties to a stated company or product strategy, OKR, or theme
- [ ] Expected business impact is named (revenue, retention, cost, risk reduction, positioning)
- [ ] Impact is estimated with stated assumptions, even if rough
- [ ] Cost or effort is estimated at an order-of-magnitude level (T-shirt size is acceptable)
- [ ] Cost of inaction or delay is described
- [ ] Competitive or market context is provided where relevant
```

| Issue | Example | Severity |
| --- | --- | --- |
| No business rationale | Only describes user benefit, never why the company wins | CRITICAL |
| Unsupported impact claim | "Will drive significant revenue" with no basis | MAJOR |
| No effort estimate at all | Reader cannot weigh value against cost | MAJOR |
| Strategy link missing | Cannot tell how this fits current priorities | MAJOR |
| Unsourced market statistics | Numbers presented as fact with no source | MAJOR |

Note on evidence quality: treat recycled vendor statistics and unattributed market numbers as unverified. Recommend the author cite a primary source or label the figure as an estimate.

### Step 6: Outcomes and Success Measures

At brief stage, outcomes may be less precise than PRD metrics, but they must still be measurable in principle.

```markdown
Outcomes Checklist:
- [ ] Success is described as an outcome, not an output ("reduce time to first value" not "ship the wizard")
- [ ] Outcome is measurable, or the brief states how it would become measurable
- [ ] Current baseline is provided or flagged as unknown
- [ ] Outcome aligns with the problem statement
- [ ] Leading indicators are suggested for early validation
- [ ] Guardrails note what must not degrade
```

| Issue | Example | Severity |
| --- | --- | --- |
| Output framed as outcome | "Success = feature launched" | CRITICAL |
| Unmeasurable | "Customers are happier" | CRITICAL |
| Vanity metric | "Increase page views" | MAJOR |
| Misaligned | Problem: churn, Outcome: signups | MAJOR |
| No baseline and not flagged | "Target: 20%" with no starting point | MAJOR |
| No guardrails | Missing "do not break X" | MINOR |

### Step 7: Scope and Boundaries

```markdown
Scope Validation:
- [ ] What the brief covers is stated
- [ ] Non-goals or explicit exclusions are stated with brief reasons
- [ ] Dependencies on other teams, partners, or decisions are identified
- [ ] Assumptions are documented
- [ ] Open questions are listed with owners
```

Scope Smell Test:

- If the brief promises a platform, a product, and a go-to-market motion all at once, it is trying to do too much for one decision
- If non-goals are empty, boundaries have not been thought through
- If dependencies have no owner or status, there is hidden delivery risk
- If assumptions are not flagged for validation, expect rework in discovery

### Step 8: Feasibility and Constraints

Lighter than a PRD feasibility check, but still necessary:

```markdown
Feasibility Questions:
1. Is there an obvious technical, legal, or regulatory blocker?
2. Does the direction depend on capabilities or data we do not have?
3. Are compliance, privacy, or security implications named?
4. Has anyone from engineering, design, or go-to-market been consulted?
5. Is the proposed timeline (if any) plausible for the stated effort?
```

Red Flags:

- No engineering or design input at all
- Regulatory or compliance constraints ignored in a regulated domain
- Dependence on a partner, API, or dataset that has not been confirmed
- Go-to-market or support implications never mentioned

### Step 9: Decision Ask and Next Steps

A brief exists to get a decision. Evaluate whether the reader knows what is being asked.

```markdown
Decision Checklist:
- [ ] The specific decision is stated (approve discovery, fund a prototype, commit to roadmap, kill)
- [ ] Who decides is named
- [ ] What happens if approved is described (next step, owner, rough timing)
- [ ] What would cause the team to stop or pivot is described
- [ ] Timing of the decision and any deadline pressure is explained
```

| Issue | Example | Severity |
| --- | --- | --- |
| No decision ask | Brief ends with no request | BLOCKER |
| Ask mismatched to evidence | Requests full roadmap commitment on anecdotal evidence | CRITICAL |
| No next step | Approved, then what? | MAJOR |
| No kill criteria | Nothing would cause the team to stop | MINOR |

### Step 10: Risk Identification

Identify what could go wrong:

```markdown
Risk Categories to Consider:
1. Problem risk: Is the problem real and painful enough?
2. Market risk: Will the target segment pay or adopt?
3. Strategic risk: Does this distract from higher priorities?
4. Technical risk: Can we plausibly build it?
5. Dependency risk: What if a partner, team, or decision is late?
6. Compliance risk: Legal, regulatory, privacy, security?
7. Operational risk: Can we sell, support, and maintain it?
8. Evidence risk: Is the case resting on one loud customer or one unsourced statistic?
```

### Step 11: Generate Review Report

Compile findings into the structured report below.

## Severity Levels

| Level | Definition | Action |
| --- | --- | --- |
| BLOCKER | Cannot approve brief | Must fix before any decision |
| CRITICAL | Significant gaps | Should fix before the decision meeting |
| MAJOR | Notable issues | Should fix soon; discovery can start |
| MINOR | Small improvements | Nice to have, low priority |

### Severity Examples

BLOCKER:

- No problem or opportunity statement (or it is a solution in disguise)
- Direction does not address the stated problem
- No decision ask
- Contradictory claims within the brief

CRITICAL:

- No evidence and no quantification of the problem
- No business rationale
- Success framed as outputs or unmeasurable
- Decision ask far exceeds the strength of the evidence
- Critical unstated assumption

MAJOR:

- Vague target users
- No alternatives considered
- No effort estimate
- Missing "why now"
- Unsourced statistics presented as fact
- Dependencies without owners

MINOR:

- Formatting inconsistencies
- Evidence referenced but not linked
- Missing guardrail metrics
- Minor clarity improvements

## Review Report Template

ALWAYS use this structure for the output:

```markdown
# Product Brief Review: [Document Name]

**Reviewer:** [Name]
**Review Date:** [Date]
**Brief Version:** [Version being reviewed]
**Brief Author:** [Author Name]

---

## Summary

**Status:** [APPROVE / APPROVE WITH CHANGES / NEEDS REVISION / MAJOR REVISION REQUIRED]

**Overall Assessment:**
[2-3 sentences summarizing brief quality and readiness for a decision]

**Recommended decision:** [Proceed to discovery / Proceed to PRD / Revise and resubmit / Do not proceed]

---

## Findings by Severity

### Blockers (Must Fix Before Decision)
- [ ] [Section] [Issue description] → [Recommendation]

### Critical (Should Fix Before Decision Meeting)
- [ ] [Section] [Issue description] → [Recommendation]

### Major (Fix Soon)
- [ ] [Section] [Issue description] → [Recommendation]

### Minor (Nice to Have)
- [ ] [Section] [Issue description] → [Recommendation]

---

## Section Ratings

| Section              | Rating                         | Notes        |
| -------------------- | ------------------------------ | ------------ |
| Problem / Opportunity| [Strong/Adequate/Weak/Missing] | [Brief note] |
| Target User          | [Strong/Adequate/Weak/Missing] | [Brief note] |
| Solution Direction   | [Strong/Adequate/Weak/Missing] | [Brief note] |
| Business Case        | [Strong/Adequate/Weak/Missing] | [Brief note] |
| Outcomes / Measures  | [Strong/Adequate/Weak/Missing] | [Brief note] |
| Scope / Non-goals    | [Strong/Adequate/Weak/Missing] | [Brief note] |
| Decision Ask         | [Strong/Adequate/Weak/Missing] | [Brief note] |

---

## Strengths
- [What the brief does well]
- [What the brief does well]

## Risks Identified
1. [Risk description] - Mitigation: [Suggestion]
2. [Risk description] - Mitigation: [Suggestion]

## Unverified Claims
- [Statistic or claim] - [Why it needs a source or validation]

---

## Questions for Author
1. [Clarifying question]
2. [Clarifying question]

---

## Recommendation
[Detailed recommendation with specific next steps for the brief author]
```

## Review Conduct

- Quote or reference the specific section when raising an issue so the author can find it.
- Separate "the brief does not say X" from "X is wrong." Missing information and incorrect information need different fixes.
- Do not invent evidence, statistics, or sources to fill gaps; flag the gap and ask the author.
- Calibrate to the stage. A brief asking for two weeks of discovery needs less rigor than one asking for a roadmap commitment. Say explicitly when the ask is out of proportion to the evidence.
- Be direct. A polite review that lets a weak brief through costs the team more than a blunt one.

## Examples

### Example 1: Strong Brief (Minor Feedback)

**Status:** APPROVE WITH CHANGES

**Assessment:** Clear problem grounded in support ticket data and six customer interviews. Direction is appropriately high level with three alternatives considered. Business case ties to the retention OKR. Minor gaps in guardrails and one unsourced market figure.

**Findings:**

- MINOR: Market size figure in section 2 has no source; label as estimate or cite
- MINOR: Add a guardrail for onboarding completion rate

**Recommended decision:** Proceed to discovery

### Example 2: Needs Work (Critical Issues)

**Status:** NEEDS REVISION

**Assessment:** The brief has good structure and a plausible problem, but the case rests on two anecdotal customer requests with no quantification, and success is framed as "launch by Q3." Not ready for a roadmap decision.

**Findings:**

- CRITICAL: No quantification or evidence beyond two anecdotes
- CRITICAL: Success measure is an output (launch date), not an outcome
- MAJOR: No alternatives considered, including partnering
- MAJOR: Target segment described only as "mid-market customers"

**Recommended decision:** Revise and resubmit; consider a smaller discovery ask in the meantime

### Example 3: Major Problems (Fundamental Issues)

**Status:** MAJOR REVISION REQUIRED

**Assessment:** The document describes a feature the author wants to build rather than a problem customers have. There is no decision ask and no business rationale.

**Findings:**

- BLOCKER: "We need an AI assistant in the console" is a solution, not a problem
- BLOCKER: No decision ask; reader cannot tell what is being approved
- CRITICAL: No business rationale
- MAJOR: Solution section is four times longer than the problem section

**Recommended decision:** Do not proceed; restart from problem discovery

## Integration with Other Skills

Works With:

- product-brief-writing (if present) to review its output
- check-history to gather context before reviewing

Leads To:

- prd-writing once the brief is approved and the direction is validated
- Discovery or prototyping work when the decision is "proceed to discovery"

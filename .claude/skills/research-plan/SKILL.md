---
name: research-plan
description: Phase 1 of UX research — plan a study. Use to turn a (usually vague) brief into research questions, a fitting method, inclusion criteria, a screener, and a discussion guide. Builds in layers and audits the guide for leading language before it's usable.
---

# research-plan — Phase 1: plan a study

Build the plan **in layers**. Never dump a finished plan when asked to "make a research plan" —
each layer informs the next and the user should steer at each step.

> research questions → method → inclusion criteria → screener → discussion guide

## Step 1 — Pressure-test the brief
If not already done via `/research`, ask 5–7 clarifying questions before proposing anything. Fill
in `templates/research-brief.md` in the study folder.

## Step 2 — Generate research questions
Produce **10+ candidate questions**. Tag each: `[A]` attitudinal (interviews), `[B]` behavioral
(analytics/observation), `[A+B]` both. Flag oversized questions that can't be answered in the
timeline. Then help the user **cut to the vital few** that map to the decision. Record in
`templates/research-plan.md`.

## Step 3 — Choose a method
Recommend a method that fits the *question types* (attitudinal → interviews/usability;
behavioral → analytics/session replay/diary). State the tradeoff and a defensible sample size.
Don't over-engineer for the timeline.

## Step 4 — Inclusion criteria & screener
Derive must-have / must-not-have / segments-to-balance from the method. Draft a screener — then
**audit it for leading language** just like the guide.

## Step 5 — Discussion guide
Draft from `templates/discussion-guide.md`: warm-up → core sections with open questions + probes →
optional task → wrap-up. Then run the **built-in audit** (leading, double-barreled,
assumption-loaded, closed-vs-open, future-prediction).

## Step 6 — Judge it
Invoke the **`ux-research-judge`** subagent on the discussion guide (and plan) with rubric
`discussion-guide`. Surface its verdict and top fixes. Revise and re-judge until the user accepts.

## Guardrails
- Every guide question must survive the bias audit before a session runs.
- No question may presuppose a finding. AI frequently writes leading/priming questions — assume
  yours do and hunt for them.

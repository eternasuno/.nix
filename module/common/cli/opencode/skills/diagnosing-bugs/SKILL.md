---
name: diagnosing-bugs
description: Six-phase debug loop — feedback loop, reproduce, hypothesize, instrument, fix, post-mortem. Load when the user reports an error, test failure, crash, regression, or unexpected behavior.
---

# Diagnosing Bugs

A discipline for hard bugs. Skip phases only when explicitly justified.

## Phase 1 — Build a feedback loop

**This is the skill.** Everything else is mechanical. If you have a **tight** pass/fail signal for the bug — one command that goes red on *this* bug — you will find the cause.

Spend disproportionate effort here. Be creative. Refuse to give up.

Ways to construct one:
- **Failing test** at whatever seam reaches the bug.
- **Curl / HTTP script** against a running dev server.
- **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
- **Headless browser script** driving the UI, asserting on DOM/console/network.
- **Throwaway harness** — minimal subset of the system exercising the bug path.
- **Bisection harness** — automate "boot at state X, check, repeat".

Once built, **tighten** it: make it faster, sharper (assert on the specific symptom), and more deterministic (pin time, seed RNG, freeze network). A 2-second deterministic loop is a debugging superpower.

### Completion criterion

Phase 1 is done when the loop is **tight** and **red-capable**: you can name one command that you have already run, it drives the actual bug code path, and it can go red on this specific bug and green once fixed. If you catch yourself reading code to build a theory before this command exists, stop — that is the failure this skill prevents.

## Phase 2 — Reproduce + minimise

Run the loop and confirm the failure matches the **user's described symptom**. Then shrink to the **smallest scenario that still goes red** — cut inputs, config, data one at a time, re-running after each cut.

Done when every remaining element is load-bearing: removing any one makes the loop go green.

## Phase 3 — Hypothesise

Generate **3–5 ranked hypotheses** before testing any. Each must be falsifiable: state the prediction it makes. Format: "If X is the cause, then changing Y will make the bug disappear."

Show the ranked list to the user before testing. They often have domain knowledge that re-ranks instantly.

## Phase 4 — Instrument

Each probe maps to a specific prediction. Change one variable at a time. Prefer a debugger over logs; prefer targeted logs over "log everything".

Tag every debug log with a unique prefix (e.g. `[DEBUG-a4f2]`) so cleanup is a single grep.

## Phase 5 — Fix + regression test

Write the regression test at a correct seam — one that exercises the real bug pattern as it occurs at the call site. If no correct seam exists, that is itself a finding: flag it.

Turn the minimised repro into a failing test, watch it fail, apply the fix, watch it pass, then re-run the Phase 1 loop against the original scenario.

## Phase 6 — Cleanup + post-mortem

- [ ] Original repro no longer reproduces
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-*]` instrumentation removed
- [ ] The correct hypothesis is stated in the commit message

Then ask: what would have prevented this bug? If the answer involves architectural change, recommend it after the fix is in.

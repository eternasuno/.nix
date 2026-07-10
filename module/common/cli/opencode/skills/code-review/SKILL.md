---
name: code-review
description: Review changes since a fixed point (commit, branch, tag) along two axes — Standards and Spec. Use when the user wants to review a branch, PR, work-in-progress, or says "review since X".
disable-model-invocation: true
---

Two-axis review of the diff between `HEAD` and a fixed point the user supplies. Both axes run as **parallel sub-agents** so they don't pollute each other's context.

## Process

### 1. Pin the fixed point

Capture the diff: `git diff <fixed-point>...HEAD` (three-dot). Confirm the ref resolves and the diff is non-empty.

### 2. Identify the spec source

Look for the originating spec in order: issue references in commit messages, a path the user passed, or a spec file under `docs/` or `specs/`. If nothing is found, the Spec axis reports "no spec available".

### 3. Identify the standards sources

Anything in the repo that documents code conventions (e.g. `AGENTS.md`, skill files). On top of that, always carry the **smell baseline** below — a fixed set of Fowler code smells (*Refactoring*, ch.3):

- **Mysterious Name** — name doesn't reveal what it does → rename
- **Duplicated Code** — same logic shape in multiple hunks → extract
- **Feature Envy** — method reaches into another object more than its own → move it
- **Data Clumps** — same fields travelling together → bundle into one type
- **Primitive Obsession** — string/primitive standing for a domain concept → give it a type
- **Repeated Switches** — same switch on the same type recurs → polymorphism
- **Shotgun Surgery** — one change forces scattered edits → gather into one module
- **Divergent Change** — one file edited for multiple reasons → split
- **Speculative Generality** — abstraction for needs the spec doesn't have → delete
- **Message Chains** — long `a.b().c()` navigation → hide behind one method
- **Middle Man** — mostly delegates → cut it, call the target direct
- **Refused Bequest** — subclass ignores most of what it inherits → composition

A documented repo convention always overrides the baseline. Skip anything tooling already enforces. Baseline smells are judgement calls, not hard violations.

### 4. Spawn both sub-agents in parallel

**Standards sub-agent**: receives the diff, list of standards sources, and the smell baseline. Reports violations per file/hunk — hard violations (documented standard breached) vs judgement calls (baseline smells).

**Spec sub-agent**: receives the diff and the spec. Reports missing requirements, scope creep, and wrong implementations. Omits if no spec found.

Present the two reports under `## Standards` and `## Spec` headings. Do not merge or rerank — the two axes are deliberately separate. End with a one-line summary: total findings per axis and the worst issue within each.

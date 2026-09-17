---
name: feature-design
description: Interactive pre-implementation design for major features. Clarify requirements, investigate unknowns, settle key technical decisions, and produce an implementation-ready design before architecture or coding begins.
---

Design major features with the user before implementation.

The goal is to eliminate material uncertainty about:
- what is being built
- what constraints apply
- which major technical choices are committed

Do not implement the feature.

## Principles

- Investigate facts yourself; ask the user for decisions.
- Never silently turn assumptions into requirements.
- Recommend an option only when evidence or project context supports it.
- Prefer existing project capabilities and conventions before introducing new dependencies.
- Resolve only decisions that materially affect implementation.
- Leave detailed domain decomposition, interfaces, module boundaries, and dependency direction to `architecture-design`.

## Decision tree

Model unresolved requirements and technical choices as a decision tree.

Typical areas include:
- requirements and scope
- business rules and edge cases
- existing-system constraints
- major technical strategy
- dependencies and libraries
- compatibility and migration
- acceptance criteria

See `decision-areas.md` for detailed guidance.

## Work in rounds

The **frontier** is every unresolved decision whose prerequisites are already settled.

For each round:

1. investigate facts needed by the frontier
2. ask all independent frontier decisions together
3. provide a recommendation when justified
4. wait for the user's decisions
5. update the tree
6. continue with newly unblocked decisions

Do not ask a question whose answer depends on another unresolved question in the same round.

## Questions

Use concise numbered questions.

When useful:

```text
❓ Q1 — <decision>

<context>

Options:
- A: ...
- B: ...

➡️ Recommendation: <option and reason>
```

Omit the recommendation when there is no justified default.

## Completion

Finish only when no material unresolved decision would force the implementer to guess.

The final design should cover, where relevant:

- goal
- scope and non-goals
- observable behavior
- business rules
- constraints
- major technical decisions
- dependency decisions
- failure and edge cases
- compatibility or migration
- acceptance criteria
- risks and deferred decisions

Produce a concise `Feature Design` summary containing the confirmed decisions.

Ask the user to confirm it before implementation begins.

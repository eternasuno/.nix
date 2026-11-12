---
name: feature-design
description: Before implementing a feature whose user-visible behavior, constraints, or acceptance criteria are materially uncertain, load this skill. It clarifies requirements and major tradeoffs for design discussions and authorized feature work.
---

# Feature Design

Resolve decisions that affect user-visible behavior, major constraints, and acceptance without turning local implementation choices into an approval process.

## Decision ownership

- Investigate repository-answerable facts yourself: dependencies, existing behavior, conventions, constraints, and decision records when present (ADRs, PRDs or specs, `CONTEXT.md`, `DESIGN.md`, `PRODUCT.md`). Do not re-propose an option a current decision record rejected unless there is new evidence or the user asks to reconsider; if the request conflicts with one, point out the conflict.
- Ask the user for product preferences, undefined business rules, and major tradeoffs that the request or project evidence does not settle. Do not invent product requirements.
- Choose existing suitable dependencies, established conventions, and reversible local technical details from evidence. Record assumptions when they matter; local choices may remain with the implementer.
- Detailed module structure and contracts are structural design work, not additional product questions unless they change a major feature decision.
- Reuse decisions already confirmed in the conversation.

## Workflow

1. Establish the goal, scope, known decisions, and observable acceptance from the request and repository.
2. Identify only material unknowns. Investigate facts before asking questions.
3. Ask independent questions together, with concise options and an evidence-based recommendation when available. Ask dependent questions in later rounds after their prerequisites are settled.
4. Incorporate answers and stop when behavior, major constraints, and acceptance are clear.
5. Deliver a concise design covering relevant scope/non-goals, behavior and business rules, major technical choices, failures, compatibility/migration, acceptance, risks, and deferred details. Distinguish confirmed decisions from assumptions.

For a design-discussion task, delivery of the design completes the task; do not implement without authorization. For already authorized implementation, continue once material decisions are settled, without an extra template-driven confirmation. Ask only when new work exceeds the authorization or an unresolved user decision blocks progress.

## Conditional references

- Read [Decision Areas](decision-areas.md) when a complex feature needs a checklist for material requirements, dependency, migration, or verification decisions; do not ask every listed question.
- Read [Examples](examples.md) when question ownership, dependent rounds, or the final summary shape needs clarification.

Done when decisions affecting observable behavior, major constraints, and acceptance are explicit. Local implementation choices need not all be settled.

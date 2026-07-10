# Phase 0: Clarify

Understand the goal and establish shared criteria before any implementation.

## Shared Understanding

Interview relentlessly about every aspect of the task until reaching a shared understanding. Walk down each branch of the decision tree, resolving dependencies between decisions one by one. For each question, provide a recommended answer.

Ask questions one at a time, waiting for feedback before continuing. If a question can be answered by exploring the codebase, explore instead.

## Define Success

When shared understanding is reached, define:

1. **Goal** — "What are you trying to accomplish?"
2. **Success criteria** — "How do we know the task succeeded?"
3. **Success type** — `test`, `build`, `lint`, `command`, `fileExists`, `oracle`, `observer`, or `manual`

## Challenge Fuzzy Language

When the user uses vague or overloaded terms, propose a precise canonical term. "You said 'account' — do you mean the Customer or the User? Those are different things."

If domain relationships are discussed, invent concrete edge-case scenarios that force precise boundaries.

## Output

- Clear goal statement
- Verifiable success criteria
- Resolved terminology (if applicable)
- Write summary to progress file

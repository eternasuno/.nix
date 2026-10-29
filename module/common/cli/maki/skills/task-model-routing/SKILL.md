---
name: task-model-routing
description: Required before starting a complex task that splits into parts which can be searched, designed, implemented, or reviewed independently, including a focused lookup across several files, load this skill. It assigns the subagent role and model for each bounded part.
---

# Task model routing

Use subagents only for bounded parts of a task the main agent has understood and decomposed. If delegation would just relay the request and return the answer, do the work directly.

## Main agent responsibilities

- Own requirements, architecture, key tradeoffs, decomposition, integration, and final acceptance.
- Decompose into tasks with explicit inputs, scope, dependencies, and one independently verifiable acceptance objective each. Resolve missing facts and settle shared contracts and cross-task boundaries before dependent design or implementation.
- Dispatch independent tasks concurrently and inspect prerequisite results before starting dependent work; do not force investigation, design, implementation, and review into a mandatory chain.
- Evaluate returned evidence rather than relaying reports, verify decision-critical facts and the combined behavior yourself, and report failed or incomplete tasks instead of counting them complete.

## Subagents

Pass the exact model via the `task` tool's `model` parameter and the tool access via `subagent_type`. These are task roles, not additional tool-access types.

- **Research and code exploration**
  - Model: `commandcode-openai/deepseek/deepseek-v4.1-flash` 
  - subagent_type: `research` 
  - Use for one specific aspect such as an execution path, dependency API, existing convention, or observed behavior; split unrelated aspects into separate tasks.
  - Read-only: return objective facts, file/line evidence, constraints, and explicit unknowns. Do not modify files or propose solutions, architecture, or implementation plans; the main agent derives those.

- **Independent review**
  - Model: `openai/gpt-6-astra` 
  - subagent_type: `research`
  - Use for a bounded change, design, contract, or security concern.
  - Return findings with severity, rationale, source or file/line evidence, and suggested corrections. Review only; never modify code or apply fixes.

- **UI designer**
  - Model: `commandcode-anthropic/claude-haiku-5-5`
  - subagent_type: `research`
  - Use for a detailed visual or interaction design within the main agent's requirements and constraints.
  - Return layout, component hierarchy, styling, responsive behavior, interaction states, and accessibility precise enough to implement. Do not modify code.

- **Implementation**
  - Model: `commandcode-openai/deepseek/deepseek-v4.1-flash`
  - subagent_type: `general`
  - Use for one small, precisely specified functional module in one or a few files, including its necessary tests or configuration.
  - Follow the established solution, contracts, and UI design. Return changed paths, verification results, and remaining risks; report missing decisions or scope expansion rather than redesigning.
  - Split large or complex changes into several small tasks dispatched with disjoint file ownership or isolated worktrees. A small file count alone does not make a complex task appropriately bounded.

## Dispatch and integration

1. Give the goal, the context that task needs, scope/constraints, and acceptance/return requirements. Each task starts fresh, so include relevant paths and decisions without unrelated context.
2. Require tasks to report missing inputs, scope expansion, permission failures, and conflicts with user-owned changes rather than guessing.
3. Batch independent tasks; give concurrent writers disjoint file ownership or isolate them, and sequence changes to shared contracts.
4. Read [Worktree workflow](worktree-workflow.md) only when independent implementation tasks need separate branches/worktrees.
5. Require verification against the final integrated implementation; tests passing against the old implementation do not validate a pending migration.
6. Never restore dirty files from HEAD to recover a failed edit; report the conflict and preserve current work.

Done when every assigned task has a checked outcome, results are combined within the authorized scope, integration conflicts are resolved or disclosed, and acceptance and remaining uncertainty are stated.

---
name: task-model-routing
description: Before starting any task beyond a single-file lookup or small edit, and before calling the task tool, load this skill. Dispatch subagents actively: delegate non-trivial exploration, implementation, and review by default, run independent work in parallel, and keep only trivial work in the main agent.
---

# Task model routing

Delegate by default. The main agent owns user interaction, requirements, planning, UI and interaction design, decomposition, integration, and final acceptance, and acts directly only on trivial work. The main agent writes plans and designs itself; there are no planning or design subagents.

## When to delegate

Do the task in the main agent only when it is trivial: the target files are already known, it needs at most about three reads or searches, and any edit is small and confined to one file, such as a fix after failed verification or a follow-up tweak whose context is already loaded. When unsure whether a task is trivial, delegate.

Everything else goes to subagents:

- Exploration: any investigation needing more than a few reads or searches, or covering more than one aspect. Dispatch one Research task per aspect instead of reading through the code yourself.
- Implementation: any change spanning more than one file or more than a small self-contained edit. Settle the plan, then dispatch small Implementation tasks.
- Review: after multi-file code changes, and always for security-sensitive, migration, or public-contract changes, dispatch Independent review before declaring completion.
- Parallelism: when two or more pieces of work are independent, dispatch them together in one batch instead of doing them one after another yourself.
- Scale: a change too large to carry in one context, split into small independent tasks.

## Main agent responsibilities

- Own user interaction, requirements, architecture, key tradeoffs, planning, UI and interaction design, decomposition, integration, and final acceptance.
- When delegating, split work into small tasks, each with explicit inputs, scope, dependencies, and one independently verifiable acceptance objective. Resolve missing facts and settle shared contracts and cross-task boundaries before dependent tasks.
- Do not edit files owned by a running writer subagent; edit directly only files no delegated task is touching.
- Evaluate returned evidence rather than relaying reports, verify decision-critical facts and the combined behavior yourself, and report failed or incomplete tasks instead of counting them complete.

## Subagents

For each role, set the `task` tool's `model`, `thinking`, and `subagent_type` exactly as listed. Roles are not tool-access types.

- **Research and code exploration**
  - Model: `magpie-openai/commandcode-plan/deepseek/deepseek-v4.1-flash`
  - Thinking: `low` to locate code, conventions, or documentation; `high` for bug root-cause investigation or tracing behavior across several files.
  - subagent_type: `research`
  - Use for one specific aspect such as an execution path, bug root-cause investigation, external dependency/API or documentation lookup, existing convention, or observed behavior; split unrelated aspects into separate tasks.
  - Read-only: return objective facts, file/line evidence, constraints, and explicit unknowns. Do not modify files or propose solutions, architecture, or implementation plans.

- **Independent review**
  - Model: `magpie-responses/codex/gpt-6-astra`
  - Thinking: `medium`
  - subagent_type: `research`
  - Use to audit a plan, review implemented code changes, or review a bounded design, contract, or security concern.
  - Return findings with severity, rationale, source or file/line evidence, and suggested corrections. Review only; never modify code or apply fixes.

- **Implementation**
  - Model: `magpie-openai/commandcode-plan/deepseek/deepseek-v4.1-flash`
  - Thinking: `high`
  - subagent_type: `general`
  - Use for one small, precisely specified functional module in one or a few files, including feature work, refactoring, test authoring, or configuration/script edits.
  - Follow the main agent's task instructions, established contracts, and design. Return changed paths, verification results, and remaining risks; report missing decisions or scope expansion rather than redesigning.
  - Split large or complex changes into several small tasks dispatched with disjoint file ownership or isolated worktrees. A small file count alone does not make a complex task appropriately bounded.

## Dispatch and integration

1. Write each task as a small, detailed work order, not an abstract goal: name the exact files and symbols, the concrete changes or questions, expected behavior, constraints and non-goals, and the acceptance checks or return format. Each task starts fresh, so include relevant paths and decisions without unrelated context. If a task cannot be specified this concretely, finish the investigation or decomposition in the main agent first, or split it further.
2. Dispatch dependent tasks in order, using earlier results as input. Resolve blocking review findings on a plan before dispatching writers that rely on it, and on code changes before completion.
3. Require tasks to report missing inputs, scope expansion, permission failures, and conflicts with user-owned changes rather than guessing.
4. Dispatch independent tasks concurrently; give concurrent writers disjoint file ownership or isolate them, and sequence changes to shared contracts.
5. Read [Worktree workflow](worktree-workflow.md) only when independent implementation tasks need separate branches/worktrees.
6. Require verification against the final integrated implementation; tests passing against the old implementation do not validate a pending migration. When verification fails or the user requests follow-up changes in later turns, fix small issues directly in the main agent; dispatch a new `Implementation` task with the error or diff context when the fix is not small.
7. Never restore dirty files from HEAD to recover a failed edit; report the conflict and preserve current work.

Done when the work is complete within the authorized scope, every delegated task has a checked outcome, integration conflicts are resolved or disclosed, and acceptance and remaining uncertainty are stated.

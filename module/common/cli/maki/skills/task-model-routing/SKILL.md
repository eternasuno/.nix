---
name: task-model-routing
description: Before starting any task beyond a single-file lookup or small edit, and before calling the task tool, load this skill. It defines the model, thinking, and subagent_type for every subagent role, and makes delegation the default, so non-trivial exploration, implementation, and review go to subagents, independent work runs in parallel, and only trivial work stays in the main agent.
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
  - Model: `magpie-openai/commandcode-plan/deepseek/deepseek-v4.1-flash-fast`
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
  - Model: `magpie-openai/commandcode-plan/deepseek/deepseek-v4.1-flash-fast`
  - Thinking: `high`
  - subagent_type: `general`
  - Use for one small, precisely specified functional module in one or a few files, including feature work, refactoring, test authoring, or configuration/script edits.
  - Follow the main agent's task instructions, established contracts, and design. Return changed paths, verification results, and remaining risks; back claims about inspected state, edits, and verification results with tool results from this task, label inferences and remaining risks as such, and state failed or skipped verification plainly. Report missing decisions or scope expansion rather than redesigning.
  - Split large or complex changes into several small tasks dispatched with disjoint file ownership. A small file count alone does not make a complex task appropriately bounded.

## Dispatch and integration

1. Write each task as a small, detailed work order, not an abstract goal. Subagents execute; they do not plan. Settle the approach, files, and steps in the main agent, then include:
   - the intent in one or two sentences, so the subagent can judge details that do not match;
   - exact files and symbols, with current code excerpts marked `path:line` for implementation tasks;
   - the concrete changes as ordered steps, or the concrete questions for research;
   - expected behavior, constraints, and non-goals, including files that look related but must not be touched, with the reason;
   - acceptance checks with expected results (verification commands for implementation) and the return format.

   Each task starts fresh, so include relevant paths and decisions without unrelated context. If the subagent could not complete the task from the work order and the repository alone without planning or making material design decisions, complete the investigation (with Research tasks when needed) or decomposition first, or split it further.
2. Dispatch dependent tasks in order, using earlier results as input. Resolve blocking review findings on a plan before dispatching writers that rely on it, and on code changes before completion.
3. Require tasks to stop and report, rather than guess or improvise, when inputs are missing, the code does not match the work order's excerpts, the change needs files outside the allowed scope, a stated key assumption proves false, an implementation task's verification still fails after one in-scope fix attempt, a permission fails, or user-owned changes conflict. Add task-specific stop conditions for known risks.
4. Dispatch independent tasks concurrently; give concurrent writers disjoint file ownership and sequence changes to shared contracts.
5. Accept implementation results only after checking them yourself: re-run the work order's verification commands; record the relevant working-tree state before dispatch, then compare the task's changes with its allowed files, separating pre-existing, user-owned, and concurrent-task changes, failing task-owned out-of-scope edits, and investigating uncertain attribution without overwriting work; read the diff against the intent; and read what new or changed tests assert, rejecting assertions that pass when the behavior is broken. Judge reported deviations by whether they serve the intent within scope; treat unreported deviations as failures.
6. Require verification against the final integrated implementation; tests passing against the old implementation do not validate a pending migration. When verification fails or the user requests follow-up changes in later turns, fix small issues directly in the main agent; dispatch a new `Implementation` task with the error or diff context when the fix is not small. After two unsuccessful fix-up rounds on the same task, stop dispatching fixes; revise the work order or plan, or report the blocker.
7. Never restore dirty files from HEAD to recover a failed edit; report the conflict and preserve current work.

Done when the work is complete within the authorized scope, every delegated task has a checked outcome, integration conflicts are resolved or disclosed, and acceptance and remaining uncertainty are stated.

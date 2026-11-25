---
name: task-model-routing
description: Before starting any task beyond a single-file lookup or small edit, and before calling the task tool, load this skill. It defines the model, thinking, and subagent_type for every subagent role, and makes delegation the default, so non-trivial exploration, implementation, and review go to subagents, independent work runs in parallel, and only trivial work stays in the main agent.
---

# Task model routing

Delegate by default. The main agent owns user interaction, requirements, planning, UI and interaction design, decomposition, integration, and final acceptance, and acts directly only on trivial work. The main agent writes plans and designs itself; there are no planning or design subagents.

## When to delegate

Do the task in the main agent only when it is trivial: the target files are already known, it needs at most about three reads or searches, and any edit is small and confined to one file, such as a fix after failed verification or a follow-up tweak whose context is already loaded. When unsure whether a task is trivial, delegate.

Everything else goes to subagents:

- Exploration: any investigation needing more than a few reads or searches, or covering more than one aspect. Dispatch narrow, single-question Research tasks in parallel (one per module, flow slice, or question) instead of reading through the code yourself or dispatching one broad exploration task.
- Implementation: any change spanning more than one file or more than a small self-contained edit. Settle the plan, then dispatch fine-grained, single-concern Implementation tasks rather than bundling a whole module, its tests, and bulk fixes into one task.
- Review: after multi-file code changes, and always for security-sensitive, migration, or public-contract changes, dispatch Independent review before declaring completion.
- Parallelism: when two or more pieces of work are independent, dispatch them together in one batch instead of doing them one after another yourself.
- Scale: a change too large to carry in one context, split into small independent tasks.
- Shared pieces are not a reason to keep the whole change: when several files depend on new shared primitives, copy keys, icons, or tokens, create those first in the main agent, then delegate the remaining files in parallel with disjoint ownership. Decide this split before the first edit, not after the work is half done.

## Main agent responsibilities

- Own user interaction, requirements, architecture, key tradeoffs, planning, UI and interaction design, decomposition, integration, and final acceptance.
- When delegating, split work into small tasks, each with explicit inputs, scope, dependencies, and one independently verifiable acceptance objective. Resolve missing facts and settle shared contracts and cross-task boundaries before dependent tasks.
- Do not edit files owned by a running writer subagent; edit directly only files no delegated task is touching.
- Evaluate returned evidence rather than relaying reports, verify decision-critical facts and the combined behavior yourself, and report failed or incomplete tasks instead of counting them complete.

## Subagents

For each role, set the `task` tool's `model`, `thinking`, and `subagent_type` exactly as listed. Roles are not tool-access types.

- **Research and code exploration**
  - Model: `magpie-anthropic/claude/claude-haiku-5-5`
  - Thinking: `medium` to locate code, conventions, or documentation; `high` for bug root-cause investigation or tracing behavior across several files.
  - subagent_type: `research`
  - Use for one narrow, specific question—such as one execution-path slice, one bug root cause, one external dependency/API lookup, or one module's conventions. Never bundle multiple subsystems, filesets, or unrelated questions into a single broad Research task; split broad investigations into fine-grained parallel tasks by module, layer, or question to stay well within the 100k context window.
  - Bound each work order with starting paths, known symbols or search terms, and out-of-scope areas; require the subagent to narrow targets with `glob`/`grep`/`index` and read only relevant line slices (`offset`/`limit`) instead of full large files, and to stop and return mapped entry points if the scope expands across multiple subsystems.
  - Read-only: return objective facts, file/line evidence, constraints, and explicit unknowns. Do not modify files or propose solutions, architecture, or implementation plans.

- **Independent review**
  - Model: `magpie-responses/codex/gpt-6.2-astra`
  - Thinking: `medium`
  - subagent_type: `research`
  - Use to audit a plan, review implemented code changes, or review a bounded design, contract, or security concern.
  - Return findings with severity, rationale, source or file/line evidence, and suggested corrections. Review only; never modify code or apply fixes.

- **Implementation**
  - Model: `magpie-anthropic/agy-cli/gemini-4-hydrogen`
  - Thinking: `high`
  - subagent_type: `general`
  - Use for one small, precisely specified functional module in one or a few files, including feature work, refactoring, test authoring, or configuration/script edits.
  - Follow the main agent's task instructions, established contracts, and design. Return changed paths, verification results, and remaining risks; back claims about inspected state, edits, and verification results with tool results from this task, label inferences and remaining risks as such, and state failed or skipped verification plainly. Report missing decisions or scope expansion rather than redesigning.
  - Split large or complex changes into several small tasks with disjoint file ownership—separate feature code, test suites, and bulk lint/type/refactor fixes across packages, directories, or file groups rather than bundling them into one long-running task. A small file count alone does not make a complex task appropriately bounded; keep each work order narrow enough to finish and verify in a short tool loop without accumulating huge context.

## Dispatch and integration

1. Write each task as a small, detailed work order, not an abstract goal. Subagents execute; they do not plan. Settle the approach, files, and steps in the main agent, then include:
   - the intent in one or two sentences, so the subagent can judge details that do not match;
   - exact files and symbols, with current code excerpts marked `path:line` for implementation tasks;
   - the concrete changes as ordered steps, or the narrow, concrete questions with starting paths/search scope for research;
   - expected behavior, constraints, and non-goals, including files that look related but must not be touched, with the reason (unless the task is authoring or updating tests, treat existing tests, linter/typecheck configs, and verification scripts as read-only so changes cannot modify the checks that judge them);
   - acceptance checks with expected results (order verification commands from cheap static checks such as build, typecheck, and lint to targeted unit tests and heavier integration/E2E checks) and the return format.

   Each task starts fresh, so include relevant paths and decisions without unrelated context. If the subagent could not complete the task from the work order and the repository alone without planning or making material design decisions, complete the investigation (with Research tasks when needed) or decomposition first, or split it further.
2. Dispatch dependent tasks in order, using earlier results as input. Run cheap local checks before dispatching `Independent review`, and review only stable working-tree states with no concurrent writer active on the inspected files. On follow-up review or verification rounds, pass prior findings, failure context, and the fix diff so the reviewer verifies the resolution and regressions rather than starting cold. Resolve blocking review findings on a plan before dispatching writers that rely on it, and on code changes before completion.
3. Require tasks to stop and report, rather than guess or improvise, when inputs are missing, the code does not match the work order's excerpts, the change needs files outside the allowed scope, a stated key assumption proves false, an implementation task's verification still fails after one in-scope fix attempt, a permission fails, or user-owned changes conflict. Add task-specific stop conditions for known risks.
4. Dispatch independent tasks concurrently; give concurrent writers disjoint file ownership and sequence changes to shared contracts. When concurrent writers depend on each other's modules, write the binding interface (owners, exported names and signatures, import rules) to a file and create typed stub entry files that each owner replaces, so every writer typechecks against the agreed contract while the others run. Files every writer would otherwise touch — workspace manifests, new package skeletons, lint or import-boundary configuration, dependency installation and the lockfile — are set up by the main agent before dispatch.
   - Dispatch every subagent with `background: true`. A foreground task call that stays silent past the tool timeout can be killed without any failure notice. When an expected result does not arrive, check whether the task is still running before waiting longer, and re-dispatch a lost task rather than skipping its step.
   - Long work orders may be written to a scratch file and passed by path; the `task` tool is not callable from `code_execution`.
5. Accept implementation results only after checking them yourself: re-run the work order's verification commands; record the relevant working-tree state before dispatch, then compare the task's changes with its allowed files, separating pre-existing, user-owned, and concurrent-task changes, failing task-owned out-of-scope edits, and investigating uncertain attribution without overwriting work; read the diff against the intent; and read what new or changed tests assert, rejecting assertions that pass when the behavior is broken or edits that weaken existing tests or checks. Judge reported deviations by whether they serve the intent within scope; treat unreported deviations as failures.
6. Require verification against the final integrated implementation; tests passing against the old implementation do not validate a pending migration. When verification fails or the user requests follow-up changes in later turns, fix small issues directly in the main agent; dispatch a new `Implementation` task with the error or diff context when the fix is not small. After two unsuccessful fix-up rounds on the same task, stop dispatching fixes; revise the work order or plan, or report the blocker.
7. Never restore dirty files from HEAD to recover a failed edit; report the conflict and preserve current work.
8. When a task is stopped, interrupted, or stuck, inspect its partial edits and run its verification before re-dispatching; it may already be complete, or a new task must continue from its changes instead of overwriting them.

## Lessons from parallel runs

- If the listed review model is unavailable (quota exhausted), use the strongest available model at the same thinking level and say so.
- Files that wire shared pieces (for example `main.go`, config, barrel exports) belong to the main agent or to one writer; sequence dependent edits after the owning writer returns instead of sharing the file.
- Tell concurrent writers that builds and tests may fail transiently in packages they do not own, and require them to run and report only their own packages. Re-run the full checks yourself once all writers have returned.
- Give every deletion order its evidence (callers traced, spec rule checked) and let the writer skip items whose evidence does not hold; review the returned diff and verify claims against the tree rather than the report.
- Stop servers or processes a task started by port or PID (`ss -ltnp`); `pkill -f` patterns can miss relative-path binaries or kill the shell itself.

Done when the work is complete within the authorized scope, every delegated task has a checked outcome, integration conflicts are resolved or disclosed, and acceptance and remaining uncertainty are stated.

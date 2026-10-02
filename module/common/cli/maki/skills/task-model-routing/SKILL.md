---
name: task-model-routing
description: Use before delegation or a task call to select the model and subagent type, bound the task, and coordinate dependencies. Does not require delegation.
---

# Task model routing

Use this skill after deciding that a task would be useful. Small local work may be done directly; do not manufacture delegation to satisfy a rule.

## Responsibility and scope

- The parent agent owns overall requirements, primary design, architecture and solution selection, key tradeoffs, decomposition, integration, and final acceptance.
- Subagents perform bounded fact-finding, local implementation of an established design, or independent review. They may make local implementation decisions and return options, risks, and recommendations. Changes to requirements, public contracts, overall architecture, or cross-task boundaries return to the parent for decision.
- When facts are missing, investigation may precede design. The parent evaluates the evidence and forms the design before assigning implementation that depends on it.
- Never assign complete requirements understanding, overall solution selection, all implementation, and overall acceptance to one subagent.
- One task has one explicit, independently verifiable objective, enough inputs, bounded scope, and checkable acceptance. A fix and its necessary regression tests may share a task. Split multi-stage work, independent deliverables, or substantial overall design; avoid both vague catch-all tasks and fragments without independent value. Use semantic boundaries, not file or line counts.

## Model and subagent type

Pass the exact model through the `task` tool's `model` parameter.

Default model: `cpa-codex/gpt-6.1-sol`.

| Work | Type | Expected result |
| --- | --- | --- |
| Research and code exploration | `research` | Facts, relevant behavior, sources or file/line evidence, constraints, unknowns |
| Non-visual implementation, fixes, refactoring, tests, configuration | `general` | Bounded changes, verification results, remaining risks |
| Independent review, security analysis, architecture assessment, read-only debugging | `research` | Concrete findings with severity and file/line evidence; no writes |

For visual UI implementation, layout, styling, and component design, use `cpa-antigravity/gemini-3.8-flash-high` with `general`, within the parent-selected requirements and design constraints.

## Dispatch and integration

1. Provide the **goal**, necessary **context**, **scope/constraints**, and **acceptance/return requirements**. These may be a short paragraph; no fixed set of headings is required. Each task starts fresh, so include relevant paths and decisions without copying unrelated context.
2. Require reporting of missing inputs, scope expansion, permission failures, and conflicts with user-owned changes rather than guessing or silently expanding scope.
3. Run dependent work in order and inspect prerequisite results before dispatching downstream work. Investigation, implementation, and review are optional stages, not a mandatory delegation chain.
4. Batch independent tasks. Give concurrent writers disjoint file ownership or isolate their work; sequence shared-contract changes that are not independent.
5. When independent features need separate branches/worktrees, read [Worktree workflow](worktree-workflow.md). Ordinary delegation and read-only tasks do not require worktrees.
6. Report task/model failures and incomplete verification. Do not invent fallback candidates or treat failed work as complete.
7. Evaluate and reconcile returned results. Verify decision-critical evidence and key behavior yourself; do not merely relay the report or mechanically repeat every investigation.

Done when the delegated objective is checked, integration conflicts are resolved or disclosed, and the parent has evaluated acceptance and remaining uncertainty.

---
name: task-model-routing
description: Use before delegating bounded parts of a complex task to Research and code exploration, Independent review, UI designer, or Implementation subagents. Delegate when focused fact-finding, independent review, detailed UI design, or parallel implementation of small modules helps; do simple tasks directly and never forward the whole request to one subagent.
---

# Task model routing

Use subagents for bounded contributions to a task the main agent has understood and decomposed, not as a replacement for doing the task.

## Main agent responsibilities

- Own requirements, overall solution and architecture, key tradeoffs, task decomposition, integration, and final acceptance.
- Break complex work into simple, detailed tasks with explicit inputs, scope, dependencies, and checkable acceptance before dispatch. Each task must have one independently verifiable objective.
- Never forward the original request wholesale to one subagent. If delegation would only relay the request and return its answer, do the task directly without a subagent.
- Resolve missing facts before dependent design or implementation. Evaluate collected evidence, settle shared contracts and cross-task boundaries, and provide the decisions needed by downstream tasks.
- Dispatch independent tasks concurrently. Sequence dependent tasks and inspect prerequisite results before starting downstream work; do not force investigation, design, implementation, and review into a mandatory chain.
- After all assigned tasks finish, reconcile their results, combine the changes or deliverables within the authorized scope, verify the combined behavior, and make the final acceptance decision. Report failed or incomplete tasks rather than treating them as complete.

## Subagents

Pass the exact model through the `task` tool's `model` parameter and the tool-access type through `subagent_type`. The following are task roles, not additional tool-access types.

- **Research and code exploration**
  - Model: `cpa-codex/gpt-6-luna`.
  - `subagent_type`: `research`.
  - Use when one specific aspect needs investigation, such as an execution path, dependency API, existing convention, or observed behavior. Split unrelated investigation aspects into separate tasks.
  - Inspect only the assigned aspect and return objective facts, relevant source or file/line evidence, constraints, and explicit unknowns. Do not modify files.
  - Never ask this subagent to propose a solution, choose an architecture, or recommend an implementation plan. The main agent derives the solution from the evidence.

- **Independent review**
  - Model: `cpa-codex/gpt-6.1-sol`.
  - `subagent_type`: `research`.
  - Use when a bounded change, design, contract, or security concern needs independent review.
  - Return concrete findings and suggested corrections, with severity, rationale, and source or file/line evidence. Review only; never modify code or apply fixes.

- **UI designer**
  - Model: `cpa-commandcode/google/gemini-3.8-flash`.
  - `subagent_type`: `research`.
  - Use when an interface needs a detailed visual or interaction design within the main agent's requirements and constraints.
  - Return a detailed design covering relevant layout, component hierarchy, styling, responsive behavior, interaction states, and accessibility so implementation can follow it. Do not modify code or implement the UI.

- **Implementation**
  - Model: `cpa-codex/gpt-6-luna`.
  - `subagent_type`: `general`.
  - Use to modify code for one small, precisely specified functional module in one or a few files, including its necessary tests or configuration.
  - Follow the established solution, contracts, and UI design where applicable. Return changed paths, verification results, and remaining risks; report missing decisions or scope expansion rather than redesigning the overall solution.
  - Never assign a large or complex change as one implementation task. The main agent must split it into multiple small tasks and dispatch independent modules concurrently, with disjoint file ownership or isolated worktrees. A small file count alone does not make a complex task appropriately bounded.

## Dispatch and integration

1. Provide the **goal**, necessary **context**, **scope/constraints**, and **acceptance/return requirements**. These may be a short paragraph; no fixed set of headings is required. Each task starts fresh, so include relevant paths and decisions without copying unrelated context.
2. Require reporting of missing inputs, scope expansion, permission failures, and conflicts with user-owned changes rather than guessing or silently expanding scope.
3. Batch independent tasks. Give concurrent writers disjoint file ownership or isolate their work; sequence shared-contract changes that are not independent.
4. When independent implementation tasks need separate branches/worktrees, read [Worktree workflow](worktree-workflow.md). Ordinary delegation and read-only tasks do not require worktrees.
5. Report task/model failures and incomplete verification. Do not invent fallback candidates or treat failed work as complete.
6. Evaluate and reconcile returned results before integration. Verify decision-critical evidence and key behavior yourself; do not merely relay reports or mechanically repeat every investigation.

Done when all assigned tasks have a checked outcome, their results have been combined within the authorized scope, integration conflicts are resolved or disclosed, and the main agent has evaluated acceptance and remaining uncertainty.

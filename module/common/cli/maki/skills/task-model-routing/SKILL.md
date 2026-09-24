---
name: task-model-routing
description: Required for every non-trivial engineering request and before every task call. Use for codebase exploration, multi-file implementation, debugging, review, architecture, and research to select the model, subagent type, and delegation workflow.
---

# Task model routing

## Delegation gate

For every non-trivial request, dispatch at least one meaningful subtask. Delegate codebase exploration, external research, multi-file implementation, debugging, review, and architecture assessment. Direct handling is reserved for conversational answers and localized, obvious operations requiring no investigation.

Each task performs one concrete, independently verifiable objective. A fix and its necessary regression test may share one task when they serve the same behavior. The parent agent owns decomposition, stage coordination, modification design, architecture decisions, integration, and final verification.

Select the exact model and subagent type according to the task:

- **Research and code exploration**
  - Model: `commandcode/deepseek/deepseek-v4.1-flash`
  - Type: `research`
  - Use for documentation lookup, external research, codebase search, locating files or symbols, understanding existing code, and read-only investigation.
  - Return evidence: relevant files or symbols, current behavior, control or data flow, constraints and conventions, tests, and unknowns, with source or file/line citations. Modification designs, implementation steps, target architectures, and option recommendations are outside this route and belong to the parent agent.
- **Code changes**
  - Model: `commandcode/deepseek/deepseek-v4.1-flash`
  - Type: `general`
  - Use for well-defined implementation, bug fixes, refactoring, tests, configuration changes, and other non-visual code modifications.
- **Review**
  - Model: `commandcode/gpt-6-luna`
  - Type: `research`
  - Use for code review, security analysis, architecture assessment, difficult debugging, regression detection, and maintainability review. Report concrete findings with severity and file/line references. Do not modify files.
- **UI design**
  - Model: `commandcode/google/gemini-3.8-flash`
  - Type: `general`
  - Use for visual UI work, layout, styling, component design, design-system implementation, and other visual modifications.

## Rules

- Pass the selected model through the `task` tool's `model` parameter.
- For an ordered model chain, try one model at a time and advance only when the `task` call fails because the model or provider is unavailable, rate-limited, or times out. Retry with the same prompt and subagent type; never launch fallback attempts in parallel. If every model fails, report the failure.
- Include enough context, paths, constraints, and expected output because every task starts fresh. Do not paste unrelated conversation or repository content.
- Before dispatching, check that the task has one objective, a bounded scope, all required inputs, explicit non-goals, a checkable acceptance criterion, and a defined return format. If it spans multiple concerns, stages, or independently verifiable deliverables, split it into focused tasks. Never assign an entire large, multi-stage request to one subagent.
- Use this prompt structure: **Goal**, **Context**, **Scope**, **Constraints**, **Non-goals**, **Acceptance**, **Stop**, and **Return**. The task reports missing inputs, scope expansion, or user-owned changes instead of guessing or expanding its scope.
- Use one `task` call per subtask and `batch` independent subtasks so multiple subagents can work concurrently.
- Run dependent stages sequentially: research before implementation, and implementation before review. After research, the parent agent verifies decision-critical sources and synthesizes the modification design before dispatching implementation. Inspect each stage's results before dispatching work that depends on them.
- Never run parallel write tasks that may modify overlapping files; give concurrent writers disjoint ownership or sequence them.
- If several routes apply, split the work into meaningful stages and route each stage separately. Keep dependent stages sequential and independent stages parallel only when their write scopes do not overlap.
- If no route clearly matches, use the closest route rather than silently skipping delegation.
- Do not delegate token tasks merely to satisfy the gate; each subtask must produce useful research, implementation, or review output.
- Inspect, reconcile, and verify subagent results before responding to the user.

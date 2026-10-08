---
name: code-implementation
description: Implement, refactor, fix, test, or configure code once behavior and structure are understood. Prefer the simplest readable final implementation, not the smallest diff. Not for general read-only review.
---

# Code Implementation

Implement only required behavior. Within the affected execution path, prefer simpler final code over a smaller diff; do not refactor unrelated code.

## Implementation rules

- Read the implementation, callers, and existing tests before changing behavior. Fix a shared cause rather than adding caller-specific patches when the callers share the same contract.
- Add branches, options, helpers, abstractions, or dependencies only for a current requirement or an existing consumer. Remove code made unnecessary by the change; do not add extension points for hypothetical uses.
- Keep operations in execution order. Use early returns to reduce nesting without changing cleanup or side-effect ordering. Do not replace simple conditionals with dispatch frameworks or callback machinery.
- Name values and operations for their business meaning. Split expressions that mix distinct steps; introduce intermediate values only when their names explain intent or expose data flow.
- Extract helpers for reuse, a named business step, or complex logic that obscures the caller. Inline helpers that only forward arguments or rename trivial expressions. A single caller alone is not a reason to inline.
- Avoid conversions and copies when the consumer can use the original representation without violating ownership. Do not compress code at the expense of meaningful names or visible control flow.
- Validate untrusted input at its entry boundary. Do not repeat checks or add fallbacks for guarantees already enforced on every relevant entry path. Type annotations alone do not validate external data.
- Add tests only for required behavior or concrete regression risks not covered by existing tests. Do not add production interfaces, services, or public exports solely for mocking or testing.
- Preserve security, accessibility, compatibility, data integrity, required error behavior, cancellation, cleanup, side-effect ordering, transactions, and performance constraints. Removing code must not remove a required guarantee.
- Follow established architecture; do not add layers or capability abstractions during a local edit unless the requirement needs them. Resolve uncertain behavior or structural decisions before implementing that path.
- Check existing dependencies before adding one. For authorized installation or upgrades, choose the newest release compatible with the project's runtime, framework, dependency constraints, and required behavior. A local edit does not authorize an upgrade.
- Check version-matched documentation for unfamiliar or version-sensitive APIs; do not copy API examples without checking their contracts. Add comments only when permitted and when code cannot explain a constraint or decision; do not narrate visible behavior.

## Function composition and workflow design

These rules apply to all code, not only web development.

- Prefer function composition: define a distinct named function for each business workflow, select the appropriate workflow at the entry point, and call small reusable step functions in execution order. Keep selection at the entry boundary rather than spreading mode checks throughout the workflow.
- Do not consolidate similar workflows into a giant function that switches behavior through parameters, flags, option bags, or injected callbacks. Similar structure alone does not establish a shared contract; prefer separate workflow functions when business details differ, and extract only coherent steps that actually share a contract.
- Keep parameters simple and concrete. Avoid nested function types, unnecessary generics, and configuration objects that hide the operation. Preserve standard library types and meaningful validation; do not replace explicit contracts with unchecked values merely to shorten a signature.
- Avoid application-defined callback workflow wrappers that scatter business logic. Framework event handlers, lifecycle callbacks, subscriptions, and established library callback contracts remain appropriate; do not replace them with custom machinery to satisfy this preference.
- For genuinely large modules and capability boundaries, prefer mature dependency-injection mechanisms such as Effect Services and Layers. Do not build a custom DI framework or add service layers to a small workflow.
- Keep structure-specific assumptions in their owning module. Do not expose general-purpose helpers that silently depend on particular DOM field names, object layouts, or caller sequencing.

## Code layout — highest-priority formatting rules

These blank-line rules take precedence over other formatting preferences in this skill and repository style defaults. Higher-priority governing instructions and language syntax still apply. Do not change unrelated files or global formatter configuration to enforce them; report a formatter conflict rather than silently dropping the rules.

- Separate top-level declarations with one blank line.
- Leave one blank line after a complete control-flow block when another statement follows in the same enclosing block. Do not separate a connected `else`, `catch`, or `finally`, or add a blank line before the enclosing closing brace.
- Leave one blank line before `return` when another statement precedes it in the same block; do not add one when `return` is the first statement.
- Keep related branches, handlers, and continuations together. Use explicit block bodies where required by repository convention; follow repository conventions for other formatting choices.

## Verification

1. Preserve unrelated user changes and the existing Git staging state.
2. Derive commands and tool versions from repository configuration; use its declared development environment. Run checks proportional to affected behavior and risk, not every available check for every edit.
3. Inspect the final diff for required behavior, unnecessary code, readability, and the blank-line rules. Distinguish existing failures or formatting differences from regressions.
4. Report checks actually run, skipped checks, and unresolved risks.

## Conditional references

- For TS/TSX or JavaScript governed by TypeScript tooling, read [TypeScript](typescript.md).
- For Effect code or tests, read [Effect](effect.md); all Effect-specific rules live there.
- For writing or changing tests or test boundaries, read [Testing](testing.md).
- For web markup, CSS, or UI interactions, including JSX/TSX, read [Web UI rules](web/ui-rules.md) and its matching framework reference.

Load only matching references; more than one may apply. Done when required behavior is implemented, relevant checks support it, and the final diff meets these rules.

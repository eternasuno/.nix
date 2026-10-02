---
name: code-implementation
description: Implement code clearly and directly once behavior and structure are understood. Use for implementation, refactoring, bug fixes, tests, and configuration changes, not general read-only review; prefer visible control flow, minimal indirection, idiomatic language features, and focused changes.
---

# Code Implementation

Implement required behavior with the smallest clear code that respects the established design.

Prefer direct control flow, visible data flow, semantic names, and idiomatic language or framework features over wrappers, indirection, dense expressions, and incidental abstraction.

## Core principles

- Understand the relevant execution path before editing.
- Keep each function focused on one coherent responsibility.
- Keep sequential work sequential.
- Name meaningful stages when doing so improves comprehension.
- Extract helpers for reuse, meaningful complexity, or a real local boundary.
- Inline helpers that only rename an expression or reconstruct unchanged state.
- Keep implementation details local.
- Avoid speculative configurability, unused extension points, dead code, and scaffolding with no required behavior or concrete consumer.
- Validate where input is untrusted or a required invariant becomes known. Do not add defensive checks or fallback branches for conditions already guaranteed by enforced types, upstream validation, or internal contracts unless a real failure path requires them. Type annotations alone do not validate external runtime data.
- Add tests for project-owned observable behavior, relevant edge cases, and regression risks. Avoid redundant cases, meaningless assertions, and tests of dependency internals that add no distinct coverage.
- Use comments primarily to explain why, not what.
- Prefer deletion or simplification when it preserves required behavior.

## Boundaries

Respect the architecture already established by the codebase.

Do not introduce new architectural layers, interfaces, services, or capability abstractions as a side effect of a local implementation unless the task actually requires a design change.

Follow the project's established structure. The parent agent must settle major structural changes before implementation depends on them; do not invent architecture as a side effect of a local edit.

## Readability

- Separate top-level declarations clearly.
- Use explicit block bodies where required by repository convention.
- Use whitespace to expose control-flow stages without adding visual noise.
- Keep related branches, handlers, and continuations together.
- Prefer semantic intermediate names over dense nested expressions when the stages matter.
- Avoid unnecessary representation conversions.

## Safety

Do not simplify away:

- required validation;
- error handling;
- security;
- accessibility;
- compatibility;
- data protection;
- cancellation;
- resource cleanup;
- side-effect ordering;
- transaction semantics;
- performance requirements;
- meaningful test seams.

On a permission-denied failure, stop the blocked operation and report the operation, target path, and permission boundary. Continue only through an authorized resolution; do not switch tools, paths, or privileges to bypass the restriction.

## Workflow

Before modifying code:

1. Read the relevant implementation and trace the real call path.
2. Identify the smallest change that satisfies the required behavior.
3. Preserve pre-existing unrelated work.
4. Fix shared root causes rather than isolated symptoms when practical.
5. Keep the diff focused.
6. Derive verification commands, targets, tool versions, and language dialects from the current repository and environment configuration. Use the declared development environment when available. Select formatter, lint, type, build, and test checks to match the affected behavior, change risk, and project practice; do not mechanically run every check for a tiny edit. Distinguish configuration loading from actual execution or attachment, and report existing warnings or formatting differences separately from regressions.
7. Inspect the final diff against the requested behavior.

## Conditional references

- When modifying Effect code, read [Effect-TS](effect-ts.md).
- When modifying TS/TSX or code governed by TypeScript tooling, read [TypeScript](typescript.md).
- When writing or modifying tests or adjusting test boundaries, read [Testing](testing.md).
- When adjusting complex control flow, helper extraction, or data flow, read [Control Flow and Complexity](control-flow-and-complexity.md) as needed.

Multiple conditions may apply. Do not load all references by default.

Done when the requested behavior is implemented, relevant checks and final-diff inspection support it, and skipped checks or remaining risks are disclosed.

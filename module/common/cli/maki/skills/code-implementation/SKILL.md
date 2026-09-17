---
name: code-implementation
description: Implement code clearly and directly once behavior and structure are understood. Use for implementation, refactoring, bug fixes, tests, configuration, and review; prefer visible control flow, minimal indirection, idiomatic language features, and focused changes.
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
- Avoid speculative configurability and unused extension points.
- Use comments primarily to explain why, not what.
- Prefer deletion or simplification when it preserves required behavior.

## Boundaries

Respect the architecture already established by the codebase.

Do not introduce new architectural layers, interfaces, services, or capability abstractions as a side effect of a local implementation unless the task actually requires a design change.

When a structural question appears, apply the repository's architecture rules rather than inventing a local abstraction.

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

## Workflow

Before modifying code:

1. Read the relevant implementation and trace the real call path.
2. Identify the smallest change that satisfies the required behavior.
3. Preserve pre-existing unrelated work.
4. Fix shared root causes rather than isolated symptoms when practical.
5. Keep the diff focused.
6. Run the project's formatter, linter, type checker, and relevant tests when available.
7. Inspect the final diff against the requested behavior.

See:

- `control-flow-and-complexity.md`
- `typescript.md`
- `effect-ts.md`
- `testing.md`

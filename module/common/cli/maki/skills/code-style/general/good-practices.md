# General Good Practices

Apply to all code. Implement required behavior, not hypothetical flexibility.

## Implementation

- Read implementation, callers, and tests before changing behavior. Fix a shared cause when callers share the same contract rather than adding caller-specific patches.
- Add branches, options, helpers, abstractions, or dependencies only for a current requirement or existing consumer. Remove code made unnecessary by the change. Check whether APIs already handle absent resources before adding filesystem prechecks or environment guards; unsupported hypothetical deployment states do not justify branches.
- Keep operations in execution order. Use early returns to reduce nesting without changing cleanup or side-effect ordering. Do not replace simple conditionals with dispatch frameworks or callback machinery.
- Name values and operations for their business meaning. Split expressions mixing distinct steps; introduce intermediate values when their names explain intent or data flow.
- Extract helpers for reuse, a named business step, or complex logic obscuring the caller. Inline trivial forwarding helpers with no meaningful role. A single caller alone is not a reason to inline.
- Avoid conversions and copies when consumers can use the original representation without violating ownership. Do not trade meaningful names or visible control flow for compactness.
- Validate untrusted input at its entry boundary. Do not repeat enforced guarantees or use unchecked casts as validation. Preserve domain-specific checks when their invariants differ from transport validation.
- Handle empty and boundary cases, errors, async ordering, and concurrent updates according to the actual contract. Make cancellation, cleanup, transaction boundaries, and resource growth explicit where relevant.
- Enforce authentication and authorization at trusted boundaries. Use safe APIs for queries, commands, paths, and output contexts; protect secrets and sensitive data in logs, configuration, and errors.
- Prefer language/platform built-ins, then suitable existing dependencies, then justified trusted new dependencies, and custom infrastructure only when those alternatives cannot safely satisfy the requirement or cost more overall. Include maintenance, supply-chain, runtime, and deployment costs, not just source lines.
- Check existing dependencies before adding one. For authorized installation or upgrades, choose the newest compatible release; a local edit does not authorize upgrades. Check version-matched documentation for unfamiliar or version-sensitive APIs.
- Add comments only when permitted and when code cannot explain a constraint or decision; do not narrate visible behavior.

## Function composition

- Define distinct named functions for distinct business workflows. Select the workflow at the entry boundary and compose coherent steps in execution order rather than scattering mode checks throughout it.
- Do not consolidate similar workflows into a giant parameter-, flag-, option-, or callback-switched function. Similar structure does not establish a shared contract; extract only steps that genuinely share one.
- Keep parameters concrete and simple. Avoid unnecessary generics, nested function types, and option bags that hide the operation. Preserve meaningful validation and standard library contracts.
- Framework handlers, subscriptions, lifecycle callbacks, and established library callback contracts are appropriate. Avoid application-defined callback workflow wrappers that scatter business logic.
- For genuinely large modules and capability boundaries, prefer mature DI mechanisms, such as Effect Services and Layers when already appropriate to the stack. Do not invent a DI framework or add service layers to small workflows.
- Keep structure-specific assumptions in their owning module; a general-purpose helper must not silently depend on particular DOM fields, object layouts, or caller sequencing.

## Mandatory blank-line rules

These rules override repository formatting defaults and other formatting preferences in this skill; higher-priority governing instructions and language syntax still apply. Do not change files that contain no violation, and do not change global formatter configuration, merely to enforce these rules. Report formatter conflicts rather than silently dropping these rules.

- Separate top-level declarations with one blank line.
- Leave one blank line after a complete control-flow block when another statement follows in the same enclosing block. Do not separate a connected `else`, `catch`, or `finally`, or add a blank line before the enclosing closing brace.
- Leave one blank line before `return` when another statement precedes it in the same block; do not add one when `return` is the first statement.
- Keep related branches, handlers, and continuations together. Use explicit block bodies where required by repository convention; follow repository conventions for other formatting choices.

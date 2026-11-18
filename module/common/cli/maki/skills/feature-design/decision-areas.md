# Decision Areas

Checklist for expanding the decision tree. Expand only branches that materially affect the feature; do not ask every question.

## Requirements

Determine as relevant: problem and desired outcome; scope and non-goals; actors and primary scenarios; externally observable behavior; business rules and invariants; important edge and failure cases.

## Existing System

Investigate in the repository before asking the user: relevant modules, abstractions, and APIs; current data flows and dependency boundaries; storage and infrastructure already in use; established patterns and compatibility constraints. Prefer the existing design when it solves the problem adequately.

## Technical Decisions

Resolve only implementation-shaping decisions: state model, data ownership, and persistence strategy; communication mechanism, concurrency model, synchronization, and consistency guarantees; retry/failure semantics and caching; security boundaries and performance requirements; migration and compatibility behavior.

Detailed structural modeling belongs to system design, not the product-question checklist, unless it changes a major feature decision. Existing conventions and reversible local choices may be selected from evidence without user approval.

## Dependencies and Libraries

For each potentially new dependency, check whether an existing project dependency or platform/standard-library capability already solves the problem; otherwise evaluate candidate libraries for project compatibility, maintenance status, API quality, runtime/build cost, and lock-in versus custom implementation.

Default preference (bias, not an absolute rule): existing project capabilities → existing abstractions/conventions → platform/standard library → focused external dependencies → new custom infrastructure.

## Delivery and Verification

Determine as relevant: acceptance criteria (normal, boundary, and failure cases); migration, rollout, compatibility, and observability requirements; required categories of tests.

Acceptance criteria should describe observable behavior and be specific enough to verify; prefer Gherkin (`Given`/`When`/`Then`) scenarios for multi-step user flows and end-to-end acceptance cases.

## Completion Check

Done when user-visible behavior, major constraints, and acceptance are clear; local implementation details may remain open. Where relevant, confirm that existing-system constraints, dependency decisions, compatibility/migration needs, material risks, and deferred decisions are recorded.

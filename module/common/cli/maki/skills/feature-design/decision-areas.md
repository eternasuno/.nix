# Decision Areas

Checklist for expanding the decision tree. Expand only branches that materially affect the feature; do not ask every question.

## Requirements

Determine as relevant:

- problem being solved
- desired outcome
- scope and non-goals
- users or actors
- primary scenarios
- externally observable behavior
- business rules
- invariants
- important edge cases
- failure behavior

## Existing System

Investigate before asking the user:

- relevant modules
- existing abstractions
- current data flows
- established patterns
- dependency boundaries
- existing APIs
- storage and infrastructure already in use
- compatibility constraints

Prefer existing design when it already solves the problem adequately.

## Technical Decisions

Resolve only implementation-shaping decisions, such as:

- state model
- data ownership
- persistence strategy
- communication mechanism
- concurrency model
- consistency guarantees
- retry and failure semantics
- caching strategy
- synchronization behavior
- security boundaries
- performance requirements
- migration strategy
- compatibility behavior

Detailed structural modeling belongs to system design, not the product-question checklist, unless the structural choice changes a major feature decision. Existing conventions and reversible local choices may be selected from evidence without user approval.

## Dependencies and Libraries

For each potentially new dependency, determine:

- whether an existing project dependency already solves the problem
- whether the platform or standard library provides the capability
- the concrete capability required
- relevant candidate libraries
- project compatibility
- maintenance status
- API quality
- runtime and build implications
- lock-in or migration cost
- whether custom implementation is actually justified

Prefer evidence-based selection over familiarity or popularity alone.

Default preference:

1. existing project capabilities
2. existing abstractions and conventions
3. platform or standard-library capabilities
4. focused external dependencies
5. new custom infrastructure

This is a bias, not an absolute rule.

## Delivery and Verification

Determine as relevant:

- acceptance criteria
- normal cases
- boundary cases
- failure cases
- migration requirements
- rollout constraints
- observability requirements
- compatibility requirements
- required categories of tests

Acceptance criteria should describe observable behavior and be specific enough to verify.

## Completion Check

Done when user-visible behavior, major constraints, and acceptance are clear; local implementation details may remain open. Where relevant, also confirm the existing-system constraints, dependency decisions, compatibility or migration needs, material risks, and deferred decisions are recorded.

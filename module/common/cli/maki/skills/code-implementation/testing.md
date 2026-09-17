# Testing

Test observable behavior through the smallest useful public boundary.

## Test scope

Prefer tests that exercise the real composition of the unit or workflow under test.

Do not expose private implementation details solely to make them directly testable.

## Test doubles

Use simple fakes or stubs for real capability boundaries.

Do not introduce production interfaces or services solely to enable mocking.

Keep mutable fake state isolated per test unless sharing is intentional.

## Assertions

Assert meaningful behavior:

- returned values;
- domain failures;
- external capability interactions where part of the contract;
- ordering when ordering matters;
- cleanup and cancellation;
- persisted or emitted results.

Avoid tests that merely mirror implementation structure.

## Failures

Test expected failures separately from defects caused by contract violations.

When cancellation or interruption has distinct semantics, assert it explicitly.

## Effect tests

When the repository provides a compatible Effect-aware test integration, use it instead of repeating manual runtime wrappers.

Provide fake Effect services through Layers when the architecture already models those dependencies as services.

Do not convert an ordinary function dependency into an Effect service merely for testing.

## Test maintenance

Keep test setup proportional to the behavior under test.

Prefer local setup over generalized test infrastructure until real repeated complexity appears.

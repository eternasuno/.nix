# Testing

Test observable behavior through the smallest useful public boundary.

## Test scope

Prefer tests that exercise the real composition of the unit or workflow under test.

Do not expose private implementation details solely to make them directly testable.

For integration tests, exercise observable behavior through the real integration boundary rather than checking registration or configuration alone. Match the execution context and resource ownership needed for the behavior being claimed; verify cleanup.

Isolate working directories, environment variables, and other process-wide state when tests run concurrently. Use a subprocess when the integration boundary requires different process state; preserve cleanup and failure diagnostics.

## Test doubles

Use simple fakes or stubs for real capability boundaries. Choose deterministic dependency composition appropriate to the test; external networks, databases, and uncontrolled side effects require an explicit integration boundary and lifecycle management.

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

Avoid tests that merely mirror implementation structure or only recheck language/framework/dependency guarantees without project-specific behavior. Do not add assertions that can pass regardless of the behavior being claimed.

Add or retain a test when it verifies a distinct contract, relevant edge/failure case, integration boundary, or regression risk. Remove or consolidate redundant tests only after checking their behavior and boundary coverage; similar-looking cases may protect different risks. Test count alone is not a reason to add or delete tests.

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

# Testing

Apply when writing or modifying tests or their boundaries.

## Coverage

- Test observable behavior through the smallest public boundary that exercises the claimed contract. Do not expose private implementation details solely for tests.
- Before adding a case, identify the behavior or regression risk missing from existing coverage. Before removing or merging cases, compare contracts, boundaries, and failure paths; similar code or test count does not establish redundancy.
- Assert returned, persisted, or emitted results and contractually required failures or interactions. Assert ordering, cancellation, and cleanup only where they are part of the behavior being tested.
- Do not test dependency internals or repeat language/framework guarantees without project-owned behavior. Reject assertions that can pass when the claimed behavior is broken.
- Integration tests must exercise the actual integration boundary, not registration or configuration alone. Use the execution context and resource ownership required by that boundary.

## Setup and isolation

- Prefer local setup and simple fakes at existing dependency boundaries. Add shared test infrastructure only when it removes actual repeated complexity.
- Keep mutable fake state local to each test unless sharing is required by the scenario.
- Isolate directories, environment variables, and process-wide state in concurrent tests. Use subprocesses when distinct process state is required, preserving cleanup and failure diagnostics.
- Use real networks or databases only in explicit integration tests with controlled dependencies and resource cleanup.
- Distinguish expected failures from defects and cancellation when their observable semantics differ.

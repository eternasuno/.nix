# Testing

Apply when writing or modifying tests, their boundaries, or behavior-preserving refactors.

## Test-first

- When changing observable behavior and an honest test is practical, write the failing test before changing the code, confirm it fails for the expected reason, then make the smallest change that passes.
- Start the next case only after the current one passes. If an honest test is impractical, do not write a misleading one; state the behavior as unverified.
- Do not weaken, skip, or delete existing assertions, tests, or lint/typecheck rules to make a change pass unless the contract intentionally changed.

## Coverage

- Test observable behavior through the smallest public boundary that exercises the claimed contract. Do not expose private implementation details solely for tests.
- Before adding a case, identify the behavior or regression risk missing from existing coverage. Before removing or merging cases, compare contracts, boundaries, and failure paths; similar code or test count does not establish redundancy.
- Assert returned, persisted, or emitted results and contractually required failures or interactions. Assert ordering, cancellation, and cleanup only where they are part of the behavior being tested. For generated values such as ids and tokens, assert what their contract guarantees (uniqueness, and order only for generators that promise it), never exact values.
- Do not test dependency internals or repeat language/framework guarantees without project-owned behavior. Reject assertions that can pass when the claimed behavior is broken. Do not test constants or limits the code does not have; assert each rule at the layer that owns it rather than again at every layer above.
- An assertion through optional chaining or a fallback (`rows[0]?.field ?? none`) passes when nothing was produced; assert the count and identity of the result before its fields. When a test checks a table of expectations over many items (endpoints, routes, records), assert each item's own set exactly, not that every expected entry exists somewhere.
- For a race whose contract names the winner (for example "the last answer wins"), drive each request with a controllable deferred and test every completion order, including the orders where all requests succeed, not only a late failure.
- Query-plan and performance checks must run the statements the code actually emits, through the same statement builder the production code uses, with representative bound values; a hand-written approximation can stay green after the real query regresses.
- Integration tests must exercise the actual integration boundary, not registration or configuration alone. Use the execution context and resource ownership required by that boundary.
- Give each repository or storage port one contract suite, written against the port and run by every implementation, including in-memory test doubles, so a double cannot drift from the real store.
- Use property-based tests for round-trip encoding/parsing, invariants, idempotency, and equivalence against a simpler reference implementation so generated inputs cover edge cases that hand-picked examples miss.

## Setup and isolation

- Prefer local setup and simple fakes at existing dependency boundaries. Add shared test infrastructure only when it removes actual repeated complexity.
- Keep mutable fake state local to each test unless sharing is required by the scenario.
- Isolate directories, environment variables, and process-wide state in concurrent tests. Use subprocesses when distinct process state is required, preserving cleanup and failure diagnostics.
- Use real networks or databases only in explicit integration tests with controlled dependencies and resource cleanup.
- Distinguish expected failures from defects and cancellation when their observable semantics differ.
- Never mask flaky tests with sleeps, retries, or skips. Fix the root cause (race, shared state, uncontrolled clock or external dependency); if the root cause cannot be resolved within scope and removal is authorized, delete the test and record the reason and unverified risk.

## End-to-end and browser verification

- For user-facing flows, cross-layer integrations, or startup/configuration changes, verify the running system end to end (local service, API harness, simulator, or browser) rather than relying on unit tests alone. Structure E2E scenarios around Gherkin (`Given`/`When`/`Then`) user flows and observable outcomes, capturing step traces or diagnostics on failure.
- After changing the browser viewport, check `window.innerWidth`, `window.innerHeight`, and the relevant media query before claiming responsive coverage. A tool's success response alone does not establish the rendered viewport.
- Verify saved settings after reloading or reopening the page. For unsaved changes, verify the confirmation and that canceling preserves both the current view and draft; distinguish observing the native prompt from replacing it with a test stub.

## Refactoring and migration

- Pin the current observable behavior with tests before changing structure. Change the structure without changing behavior, then re-run the pinned tests and report that behavior is unchanged.
- For rewrites or migrations where behavior must match an existing system (especially when specs have drifted), use differential tests that run the old and new implementations on the same representative or generated inputs, normalizing only irrelevant output differences and explicitly listing approved behavioral changes.
- If no honest test can pin the behavior, treat the refactor or migration as unverified and say so rather than claiming equivalence.

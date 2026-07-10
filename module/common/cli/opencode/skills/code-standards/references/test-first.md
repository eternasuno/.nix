# Test-First & TDD Loop

Tests define expected behavior before implementation changes.

## Seams

A **seam** is the public boundary you test at. Test only at pre-agreed seams. Agreeing seams upfront focuses effort on critical paths and complex logic.

## Anti-patterns

- **Implementation-coupled** — mocks internal collaborators, tests private methods, verifies through a side channel. Test breaks when you refactor but behavior hasn't changed.
- **Tautological** — assertion recomputes the expected value the same way the code does, so it can never disagree. Use expected values from an independent source.
- **Horizontal slicing** — writing all tests first, then all implementation. Work in **vertical slices**: one test → one implementation → repeat.

## Rules of the Loop

- **Red before green.** Write the failing test first, then only enough code to pass it.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring is not part of the loop.** It belongs to review, not the red → green cycle.

## When to Test

- Before adding a feature, write tests that define expected behavior.
- Before fixing a bug, write a test that reproduces it.
- Before refactoring, ensure existing tests pass.
- If the environment doesn't support testing, say so and describe what you would test.
- When working with untested code: write characterization tests for the specific paths you're changing.

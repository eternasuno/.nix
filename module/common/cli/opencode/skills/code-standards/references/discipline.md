# Behavioral Discipline

Rules for deliberate, minimal, test-driven changes to existing code.

## Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked
- No abstractions for single-use code
- No "flexibility" or "configurability" that wasn't requested
- No error handling for impossible scenarios
- Prefer type-safe patterns. Resist widening types for convenience

Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## Surgical Changes

**Touch only what you must. Clean up only your own mess.**

- Don't "improve" adjacent code, comments, or formatting
- Don't refactor things that aren't broken
- Match existing style, even if you'd do it differently
- If you notice unrelated dead code, mention it — don't delete it

When your changes create orphans:
- Remove imports, variables, and functions that YOUR changes made unused
- Don't remove pre-existing dead code unless asked

If touching untested code paths: write characterization tests for the paths you change before modifying behavior.

The test: Every changed line should trace directly to the user's request.

## Behavior Preservation

Don't change what the code does — only how it expresses it. All inputs, outputs, side effects, error behavior, and edge cases must remain identical.

Before every change, ask:
- Does this produce the same output for every input?
- Does this maintain the same error behavior?
- Does this preserve the same side effects and ordering?
- Do all existing tests still pass without modification?

## Clarity Over Cleverness

Explicit code is better than compact code when the compact version requires a mental pause to parse.

- Replace nested ternaries with readable control flow
- Replace dense inline transforms with named intermediate steps
- Keep helpful names even if they cost a few extra lines

Don't over-simplify:
- Don't inline away names that carry meaning
- Don't merge unrelated logic into one larger function
- Don't remove abstractions that serve testability or extensibility
- Don't optimize for line count over comprehension

## Guidance

- Prefer straightforward code over clever compression
- Preserve existing runtime behavior, tests, and hooks
- Favor explicit names and smaller focused helpers
- Keep refactors tightly scoped to the task or review feedback

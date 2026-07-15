# Code Simplification

Reduce code complexity while preserving exact behavior. The goal is not fewer lines — it's code that is easier to read, understand, modify, and debug.

## When to Use

- After a feature is working and tests pass, but the implementation feels heavier than it needs to be
- During code review when readability or complexity issues are flagged
- When you encounter deeply nested logic, long functions, or unclear names
- When refactoring code written under time pressure
- When consolidating related logic scattered across files
- After merging changes that introduced duplication or inconsistency

**When NOT to use:**

- Code is already clean and readable
- You don't understand what the code does yet — comprehend before you simplify
- The code is performance-critical and the "simpler" version would be measurably slower
- You're about to rewrite the module entirely

## Five Principles

### 1. Preserve Behavior Exactly

Don't change what the code does — only how it expresses it. All inputs, outputs, side effects, error behavior, and edge cases must remain identical.

### 2. Follow Project Conventions

Simplification means making code more consistent with the codebase, not imposing external preferences.

### 3. Prefer Clarity Over Cleverness

Explicit code is better than compact code when the compact version requires a mental pause to parse.

### 4. Maintain Balance

Don't inline away names that carry meaning, merge unrelated logic, or remove abstractions that serve testability.

### 5. Scope to What Changed

Default to simplifying recently modified code. Avoid unrelated drive-by refactors.

## Simplification Signals

- Deep nesting
- Long functions with mixed responsibilities
- Nested ternaries
- Boolean flag arguments
- Repeated conditionals
- Generic or misleading names
- Duplicated logic
- Dead code

## Process

1. **Understand before touching** — what is the code's responsibility, what calls it, what are the edge cases?
2. **Apply one change at a time** — make the change, run tests, keep it only if behavior is preserved
3. **Verify** — code is genuinely easier to understand, diff is clean, project conventions still match

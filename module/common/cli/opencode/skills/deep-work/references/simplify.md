# Phase 2.5: Simplify

Clean up after implementation without changing behavior.

## Process

### Step 1: Understand Before Touching

Before changing anything:
- What is this code's responsibility?
- What calls it? What does it call?
- What are the edge cases and error paths?
- Are there tests that define expected behavior?
- Why might it have been written this way?

### Step 2: Look for Simplification Opportunities

Signals:
- Deep nesting
- Long functions with mixed responsibilities
- Nested ternaries
- Boolean flag arguments
- Repeated conditionals
- Generic or misleading names
- Duplicated logic
- Dead code
- Wrappers or abstractions that add no value

### Step 3: Apply Changes Incrementally

One simplification at a time:
1. Make the change
2. Run relevant tests
3. Keep it only if behavior is preserved

### Step 4: Verify the Result

- The code is genuinely easier to understand
- The diff is clean and reviewable
- No behavior, error handling, or side effects changed

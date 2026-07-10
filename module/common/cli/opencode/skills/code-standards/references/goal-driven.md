# Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform vague tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you iterate independently. Weak criteria ("make it work") require constant clarification.

## Verification Checklist

After completing work, check:

- Every changed line traces to the user's request
- No features, abstractions, or error handling added beyond what was asked
- No unrelated code was modified
- Orphaned imports, variables, and functions from YOUR changes were cleaned up
- Tests exist for new behavior or pass for changed behavior
- Build, typecheck, and lint still pass
- You can state the success criteria and confirm they're met

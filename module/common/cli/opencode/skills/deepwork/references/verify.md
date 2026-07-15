# Phase 3: Verify

Validate implementation output with a verify-retry loop.

## Verify-Retry Loop

Define loop parameters:

1. **Goal** — concrete output to verify
2. **Success criteria** — pass/fail signal
3. **Verification type** — `test`, `build`, `lint`, `command`, `fileExists`, `oracle`, `observer`, or `manual`
4. **Max attempts** — default 3
5. **Execute** — run verification
6. **If fail → fix → retry**
7. **If exceed max → escalate**

## Manual Verification

For manual verification: present the output or diff and ask the user to approve. Do not auto-resolve.

## Validation Checklist

- All phase outputs verified
- Tests pass, build succeeds, lint clean
- Progress file updated with verification result

---
name: intentional-coding
description: Behavioral discipline for minimal, test-driven, surgical code changes. Use when writing, reviewing, or refactoring code to avoid overcomplication, surface assumptions, and define verifiable success criteria. Always load before changes to existing code.
---

# Intentional Coding

## Overview

Most coding mistakes come not from writing bad code, but from writing without enough deliberation upfront: over-engineering, scope creep, touching unrelated files, skipping verification. This skill enforces five disciplines that counteract those failure modes.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks or exploration, use judgment.

## When to Use

- Before making changes to existing code
- When writing new features that need to be maintainable
- When reviewing code for quality and correctness
- When debugging or fixing bugs
- When refactoring code where behavior must be preserved

**When NOT to use:**

- One-off scripts or prototypes where speed matters more
- Exploration or spike work where you're learning the problem space
- Changes to documentation or configuration that don't affect behavior
- When the user explicitly asks for a quick or rough solution

## The Five Disciplines

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.
- Search for existing patterns first. Before writing new code, grep for similar implementations in the codebase. Chances are there's a convention to follow.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- Prefer type-safe patterns. Resist widening types for convenience.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.

When your changes create orphans:

- Remove imports, variables, and functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

**If touching untested code paths:** write characterization tests for the paths you change before modifying behavior. This counts as cleaning up your own mess — it protects the behavior you're about to change.

The test: Every changed line should trace directly to the user's request.

### 4. Test First

**Tests define expected behavior before implementation changes.**

- Before adding a feature, write tests that define expected behavior.
- Before fixing a bug, write a test that reproduces it.
- Before refactoring, ensure existing tests pass.
- If the environment doesn't support testing (exploratory, prototyping), say so and describe what you would test.

When working with untested code: write characterization tests for the specific paths you're changing. This bridges the Test First and Surgical Changes disciplines.

### 5. Goal-Driven Execution

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

- [ ] Every changed line traces to the user's request
- [ ] No features, abstractions, or error handling added beyond what was asked
- [ ] No unrelated code was modified
- [ ] Orphaned imports, variables, and functions from YOUR changes were cleaned up
- [ ] Tests exist for new behavior or pass for changed behavior
- [ ] Build, typecheck, and lint still pass
- [ ] You can state the success criteria and confirm they're met

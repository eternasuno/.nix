---
name: code-standards
description: Enforce project coding conventions: naming, function/file size, purity, CSS pseudo-classes over JS, TypeScript idioms, Effect-TS patterns, and behavioral discipline (think-first, surgical edits, TDD). ALWAYS load when writing or modifying code — apply code-standards rules to EVERY code change. Do NOT load for review-only sessions (use code-review) and do NOT load for complexity reduction (use simplify reference within this skill).
---

# Code Standards

## References

- `references/conventions.md` — naming, function/file size, purity, single-param, comments, encapsulate conditionals
- `references/css-states.md` — CSS pseudo-classes over JS event listeners (frontend work)
- `references/typescript.md` — TypeScript-specific conventions
- `references/effect-ts.md` — Effect-TS conventions
- `references/discipline.md` — behavioral rules: think first, simplicity, surgical edits, TDD, behavior preservation
- `references/simplify.md` — complexity reduction process (flatten nesting, extract duplication, rename for clarity)
- `references/think-first.md` — think before coding detailed guidance
- `references/test-first.md` — TDD loop with red-green-refactor
- `references/goal-driven.md` — goal-driven execution methodology

Start with `references/conventions.md` for all code work. Read discipline files when preparing changes. For complexity reduction, see `references/simplify.md`.

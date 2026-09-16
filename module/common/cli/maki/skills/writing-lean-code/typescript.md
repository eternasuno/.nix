# TypeScript Rules

Apply these rules in addition to the language-independent guidance in `SKILL.md` and its focused references when authoring TypeScript, TSX, or JavaScript governed by TypeScript tooling. For the `effect` package, also apply `effect-ts.md`.

## Types

- Use inference inside implementations and explicit annotations where contextual typing is absent or an exported contract must remain stable.
- Every explicit annotation must serve a consumer or guard against a real regression.
- Use dependency and native API types directly. Define a separate representation only when a real boundary or added domain meaning requires it.
- Create a type alias only when it adds domain meaning, makes a complex signature readable, or is reused.
- Use `unknown` at generic value boundaries and narrow it. Avoid assertions introduced only to satisfy an unnecessarily narrow helper.
- Prefer `ReadonlyArray<T>` for non-mutating inputs and `Array<T>` for mutable arrays when this communicates ownership.
- Prefer `.at(index)` for element retrieval unless compatibility or performance requires ordinary indexing.

## Functions and defaults

- Define every function with arrow syntax, including exported functions, callbacks, factories, and test helpers, whenever the language and surrounding API allow it. Do not use `this`; use explicit parameters or closures for state and behavior. Use another form only when an external API or language construct requires it.
- Apply safe defaults at destructuring boundaries. Preserve meaningful values such as `0`, `false`, and empty strings; use `??` when omission differs from falsiness.

## Collections and comparison

- Use `map`, `filter`, and `concat` when they express the transformation directly; keep mutation explicit when it is clearer or avoids material allocation.
- Comparators return a negative number, zero, or a positive number. Apply ascending or descending direction once at the caller.

## Naming and layout

- Name parameter types after the operation they configure, not generic `Params` when several operations coexist.
- Put a blank line before `return` unless it is the first statement in its block.
- Put a blank line after a statement-level closing block before the next statement, except when the next line continues the same expression.
- Keep one blank line between type declarations.

## Toolchain

Follow the repository's `tsconfig`, module configuration, runtime, and TypeScript compatibility targets. Simplify or extract instead of relaxing type checks.

# TypeScript

Apply to TypeScript, TSX, and JavaScript governed by TypeScript tooling.

## Types and boundaries

- Prefer `type` for ordinary declarations unless project conventions, declaration merging, or module augmentation require `interface`. Do not replace classes that provide runtime behavior with type aliases.
- Use inference for obvious local types. Add annotations to define public contracts, constrain boundary values, prevent unwanted widening, or express a domain restriction; do not repeat an already clear inferred type.
- Model mutually exclusive states with discriminated unions instead of unrelated optional properties that permit invalid combinations.
- Treat untrusted external data as `unknown` until validated. Do not substitute an unchecked cast for validation.
- Add generics only when actual callers need multiple types and the generic preserves a relationship between inputs and outputs.
- Use readonly data when callers must not mutate it. Do not copy objects repeatedly without an ownership or representation change.

## Edits and modules

- For bulk rewrites of nested declarations, use syntax-aware tools or uniquely anchored exact replacements. Check nested examples; leave ambiguous matches unchanged rather than guessing.
- Use existing module boundaries and direct imports. Do not add barrel files, wrapper modules, or aliases merely to forward existing exports.

# TypeScript

Apply these rules to TypeScript, TSX, and JavaScript governed by TypeScript tooling.

## Types

Prefer inference when the inferred type is clear and stable.

Add explicit types when they:

- define a public contract;
- constrain a boundary;
- improve error messages;
- prevent accidental widening;
- document a non-obvious domain requirement.

Avoid redundant annotations that merely repeat obvious inference.

## Domain states

Use discriminated unions when modeling a closed set of meaningful states.

Prefer representations that make invalid combinations difficult to construct.

Avoid large collections of unrelated optional properties when distinct states are clearer.

## Unknown external data

Treat untrusted or external data as `unknown` until validated.

Do not use unchecked casts to bypass missing validation.

## Generics

Introduce generics when the implementation genuinely works across types while preserving useful relationships between them.

Do not introduce a generic abstraction for a single concrete use case.

## Objects and mutation

Prefer explicit ownership of mutation.

Use readonly data when mutation is not part of the contract.

Avoid copying objects repeatedly when no representation or ownership boundary requires it.

## Imports and modules

Follow repository conventions.

Prefer direct imports and existing module boundaries over new barrel files, wrapper modules, or aliases that add no semantic value.

## Errors

Preserve useful error information.

Do not catch an error merely to throw the same error again or replace it with a less useful generic message.

Translate errors when crossing a real contract boundary.

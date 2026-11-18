# TypeScript

Apply to TypeScript, TSX, and JavaScript governed by TypeScript tooling.

## Types and boundaries

- Prefer `type` for ordinary declarations unless project conventions, declaration merging, or module augmentation require `interface`. Do not replace classes that provide runtime behavior with type aliases.
- Use inference for obvious local types. Add annotations to define public contracts, constrain boundary values, prevent unwanted widening, or express a domain restriction; do not repeat an already clear inferred type.
- Model mutually exclusive states with discriminated unions instead of unrelated optional properties that permit invalid combinations.
- Treat untrusted external data as `unknown` until validated. Do not substitute an unchecked cast for validation.
- Add generics only when actual callers need multiple types and the generic preserves a relationship between inputs and outputs.
- Use readonly data when callers must not mutate it. Do not copy objects repeatedly without an ownership or representation change.
- Derive types from what a library exports (its exported types, `ReturnType`, `Parameters`, indexed access) instead of declaring local structural copies of library types.
- Put global augmentations (`declare global`, namespace or interface merging) in a dedicated declaration file such as `_types.d.ts`, not inside an unrelated feature module.
- Write anonymous functions, callbacks, and object members as arrow functions. Use `function` only when `this` binding is unavoidable, and first prefer a library path that does not need `this`.
- Write array types as `ReadonlyArray<T>` or `Array<T>` instead of `readonly T[]` or `T[]`; preserve mutability when changing syntax. Keep tuple types such as `readonly [string, number]`, including inside `ReadonlyArray<readonly [string, number]>`, and leave array literals unchanged.

## HTTP and asynchronous operations

- Use `fetch` (or official fetch-backed clients) for HTTP requests, preserving URL validation, credentials, redirect policy, timeouts, body limits, cancellation, and cleanup.
- Do not use Promise `.then()`, `.catch()`, or `.finally()` chains, including in tests and scripts; use `async`/`await` with `try`/`catch`/`finally` at the owning boundary (native event and required callback APIs remain valid). Do not add empty catches or catch-and-rethrow boilerplate.
- Handle detached async work at its owning boundary (`void` only marks a Promise unawaited). Event-source callbacks passed to libraries must catch both sync throws and rejected Promises so remote input cannot trigger an unhandled rejection.
- `URLSearchParams` reserializes every parameter (`%20` → `+`, `~` → `%7E`); when URL identity or signatures matter, split raw `search` on `&` to keep untouched parameters byte-for-byte. Decode percent-encoded `URL.username`/`URL.password` leniently before building Basic auth (`decodeURIComponent` throws on valid URL escapes).

## Edits and modules

- For bulk rewrites of nested declarations, use syntax-aware tools or uniquely anchored exact replacements; leave ambiguous matches unchanged.
- Distinguish TypeScript file selection (`tsconfig.exclude`), workspace linking, bundler externalization (`noExternal`), and deploy packaging. Source-exporting workspace packages must be compiled/bundled or runtime-supported; when a server bundle inlines them, externalize dependencies that load runtime assets, list them as direct dependencies of the deployed package, and verify by starting the built artifact from its deploy directory.
- Use existing module boundaries and direct imports. Do not add barrel files, wrapper modules, or aliases merely to forward existing exports.

# TypeScript

Apply to TypeScript, TSX, and JavaScript governed by TypeScript tooling.

## Types and boundaries

- Prefer `type` for ordinary declarations unless project conventions, declaration merging, or module augmentation require `interface`. Do not replace classes that provide runtime behavior with type aliases.
- Use inference for obvious local types. Add annotations to define public contracts, constrain boundary values, prevent unwanted widening, or express a domain restriction; do not repeat an already clear inferred type.
- Model mutually exclusive states with discriminated unions instead of unrelated optional properties that permit invalid combinations.
- Treat untrusted external data as `unknown` until validated. Do not substitute an unchecked cast for validation.
- Add generics only when actual callers need multiple types and the generic preserves a relationship between inputs and outputs.
- Use readonly data when callers must not mutate it. Do not copy objects repeatedly without an ownership or representation change.

## HTTP and asynchronous operations

- Use `fetch` or Effect `HttpClient` for application HTTP requests. In Effect code use `FetchHttpClient` as the transport. Preserve URL validation, credentials, redirect policy, timeouts, body limits, cancellation, and resource cleanup; keep official clients already backed by fetch.
- Do not use Promise `.then()`, `.catch()`, or `.finally()` callbacks, including in tests and embedded scripts. Use `async`/`await` with `try`/`catch`/`finally` at the error and cleanup boundary, or convert the operation to Effect. Awaited helpers may propagate failures to an existing owning boundary; do not add empty catches or catch-and-rethrow boilerplate.
- Handle detached async work at its owning boundary. `void` only marks a Promise as intentionally unawaited; it does not handle rejection. For Effect `promiseExit` APIs, inspect the returned `Exit` rather than duplicating handling of typed failures with `try`/`catch`.
- Native event callbacks, required callback APIs, and Effect combinators such as `Effect.catch`, `Effect.catchTag`, and `Effect.ensuring` remain valid; they are not Promise callback chains.

## Edits and modules

- For bulk rewrites of nested declarations, use syntax-aware tools or uniquely anchored exact replacements. Check nested examples; leave ambiguous matches unchanged rather than guessing.
- Distinguish TypeScript file selection, workspace package linking/injection, bundler externalization, and deploy packaging. Source-exporting packages must be compiled/bundled or supported by the actual runtime; `tsconfig.exclude` does not control externalization. Check the pinned package-manager and bundler contracts before adding legacy flags, injection, or `noExternal`, and verify emitted runtime imports.
- Use existing module boundaries and direct imports. Do not add barrel files, wrapper modules, or aliases merely to forward existing exports.

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

- Use `fetch` or Effect `HttpClient` for application HTTP requests. In Effect code use `FetchHttpClient` as the transport. Preserve URL validation, credentials, redirect policy, timeouts, body limits, cancellation, and resource cleanup; keep official clients already backed by fetch.
- Do not use Promise `.then()`, `.catch()`, or `.finally()` callbacks, including in tests and embedded scripts. Use `async`/`await` with `try`/`catch`/`finally` at the error and cleanup boundary, or convert the operation to Effect. Awaited helpers may propagate failures to an existing owning boundary; do not add empty catches or catch-and-rethrow boilerplate.
- Handle detached async work at its owning boundary. `void` only marks a Promise as intentionally unawaited; it does not handle rejection. A callback you hand to a library from an event source (for example a custom transport's `onmessage`) must catch both synchronous throws and returned-Promise rejections and turn them into a failure of the owning operation; with remote-controlled input an unhandled rejection terminates the Node process. For Effect `promiseExit` APIs, inspect the returned `Exit` rather than duplicating handling of typed failures with `try`/`catch`.
- Editing a query through `URLSearchParams` reserializes every component (`%20` becomes `+`, `~` becomes `%7E`). When URL identity or signatures matter, remove components by splitting the raw `search` on `&` and keep the others byte for byte. `URL.username` and `URL.password` stay percent-encoded: decode them before building Basic authorization, and decode leniently, because `decodeURIComponent` throws on escapes the URL parser accepts.
- Native event callbacks, required callback APIs, and Effect combinators such as `Effect.catch`, `Effect.catchTag`, and `Effect.ensuring` remain valid; they are not Promise callback chains.

## Edits and modules

- For bulk rewrites of nested declarations, use syntax-aware tools or uniquely anchored exact replacements. Check nested examples; leave ambiguous matches unchanged rather than guessing.
- Distinguish TypeScript file selection, workspace package linking/injection, bundler externalization, and deploy packaging. Source-exporting packages must be compiled/bundled or supported by the actual runtime; `tsconfig.exclude` does not control externalization. Check the pinned package-manager and bundler contracts before adding legacy flags, injection, or `noExternal`, and verify emitted runtime imports. A server bundle that inlines source-exporting workspace packages also inlines their libraries; externalize libraries that load runtime assets, declare them as direct dependencies of the deployed package, and start the deployed artifact from its runtime directory before calling the build done.
- Use existing module boundaries and direct imports. Do not add barrel files, wrapper modules, or aliases merely to forward existing exports.

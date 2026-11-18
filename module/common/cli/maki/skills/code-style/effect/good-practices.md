# Effect

Apply when code or tests use the `effect` package. Check installed versions and repository conventions before choosing APIs; these rules follow Effect 4 (`Context.Service`, `Schema.TaggedError`, `Effect.catch`, `effect/http`). When a symbol is unclear, read the installed Effect source and its `LLMS.md`/`ai-docs` rather than unrelated external copies.

## Writing Effects

- Use `Effect.gen` for inline Effect code. For reusable functions returning an Effect, use `Effect.fn("name")` when a tracing span is useful (service methods, workflow boundaries) and `Effect.fnUntraced` for library internals and hot paths. Name the span after the function, as `Service.method` for service methods.
- Do not write functions that only wrap and return `Effect.gen`; use `Effect.fn`. Attach combinators to `Effect.fn` as extra arguments after the generator, never with `.pipe` on the result. Attach behavior to `Effect.gen` with `.pipe`.
- Annotate a reusable function's result with `Effect.fn.Return<A, E, R>` when the type is part of its contract.
- Raise errors inside generators with `return yield* new SomeError(...)` so control flow narrows.
- Do not wrap an existing Effect merely for visual consistency.
- Create Effects with the direct constructor: `Effect.succeed` for in-memory values, `Effect.sync` for non-throwing side effects, `Effect.try` for throwing code, `Effect.tryPromise` for Promise APIs (map the rejection in `catch` to a tagged error), `Effect.fromNullishOr` for nullable values, and `Effect.callback` for callback APIs, returning a finalizer that cancels the source on interruption. Do not add intermediate Promise conversions when a direct constructor satisfies cancellation and cleanup requirements.
- Log with `Effect.log*`, `Effect.annotateLogs`, and `Effect.withLogSpan`; annotate spans with `Effect.annotateCurrentSpan`. Do not use `console` inside Effect code.

## Services and Layers

- Structure application behavior as services: a `class X extends Context.Service<X, Shape>()("package/path/X")` whose identifier includes the package and module path. Implement it in a static Layer built with `Layer.effect(X, Effect.gen(...))` that acquires dependencies with `yield*`, defines methods with `Effect.fn("X.method")`, and returns `X.of({ ... })`.
- Name static Layers by role: `layerNoDeps` leaves requirements open, `layer` provides its own dependencies with `Layer.provide`, and `layerTest` or `layerInMemory` provide alternatives. Use `Layer.provideMerge` only when consumers also need the dependency exposed.
- When a service's shape is declared as a named type, use `interface` (conventionally `I<Service>`, next to its `Context.Service` class) rather than a `type` alias, and keep all such shapes consistent. This is an exception to the TypeScript preference for `type`; do not convert existing service interfaces to type aliases. When the shape is inline, refer to it as `X["Service"]` instead of redeclaring it.
- Write shape members as methods for parameterized operations and `readonly` Effect properties for parameterless ones.
- Use `Context.Reference` with `defaultValue` for configuration values and feature flags that have a default; read environment configuration with `Config` (`Config.Redacted` for secrets) inside the Layer that needs it. Choose implementations from configuration with `Layer.unwrap`.
- Require only services used by the operation, not the caller's entire environment. Acquire them inside the Effect that uses them.
- Compose Layers without changing dependency order, sharing, or resource lifetime. Provide independent dependencies at the composition root; retain nesting for actual dependency ordering, not one-use category groups.
- Prefer a framework-provided Layer when it expresses the required behavior directly. Use a service Effect already provides, such as `HttpClient` or `ChildProcessSpawner`, directly inside domain services instead of defining an application port over it; provide the implementation, such as `FetchHttpClient.layer` or `NodeServices.layer`, in the owning Layer or composition root.
- Before writing a provider Service, check version-matched official adapters and compose their Layers when the protocol matches. Separate application policies (endpoint shape, timeout, credentials, redirects, tracing propagation and response lifetime) from provider protocol logic; decorate only the missing policy, not the whole client.
- Use `LayerMap.Service` for resources keyed by an identifier, such as per-tenant pools, instead of hand-rolled caches of Layers or clients.

## Schema and data

- Model domain data and validate untrusted input with `Schema`; do not hand-write predicates or manual parsing for it. Use `Schema.Class` for domain models and derive types with `typeof X["Type"]` and `typeof X["Encoded"]`.
- Hoist decoders such as `Schema.decodeUnknownEffect(X)` to module level and use Effect-returning decoders inside Effect code so validation failures stay typed.
- Use `Predicate` helpers (`Predicate.isObject`, `Predicate.isNumber`, `Predicate.and`, ...) for small runtime checks; do not write `isRecord`/`isString` helpers.
- Use `DateTime` with Effect's `Clock` (`DateTime.now`, `DateTime.make`, `DateTime.formatIso`, `DateTime.setZoneNamed`) instead of `Date` and `Date.now`, so time is testable and parsing returns `Option`.
- Define a value type as one linear pipe: normalize (for example `Schema.Trim`), then checks, then `Schema.brand`, then a wrapper such as `Schema.RedactedFromValue`. Do not name intermediate schemas only to compose them.
- Model a discriminated input or value that selects a workflow branch, such as a list scope passed to a use case, as `Schema.TaggedUnion` with `_tag` cases. Build cases with its constructors and dispatch with its `match` (or `Match.valueTags`) so a new case fails typechecking until every branch handles it; do not hand-roll a `kind` field with `if` chains.

## Partial update contracts

- Derive patch schemas from the entity by selecting writable fields and applying `Schema.optionalKey`. Exclude identity and ownership fields; omission preserves a value, while an optional value expressed as `Option.none()` clears it and `Option.some(value)` sets it. Preserve these distinctions in persistence bindings and HTTP encoding.
- For batch mutations, define empty-selection behavior and return matched identifiers when callers need to detect deletion during asynchronous work; do not substitute input identifiers for verified persisted matches.

## Errors

- Define errors with `Schema.TaggedError<E>()("E", { ... })`. Carry an unknown underlying failure as `cause: Schema.Defect()` and a typed lower-level error as a field.
- Keep expected failures in the typed error channel; keep defects and interruption distinct. Handle them with `Effect.catchTag` (single tag or array), `Effect.catchTags`, and `Effect.catch`; convert only intentionally unrecoverable failures to defects with `Effect.orDie`.
- Map lower-level errors to the service's own error at the service boundary (`Effect.mapError` or an `Effect.fn` combinator argument). Do not catch an error just to rewrap it elsewhere or discard information before a boundary requires translation.
- When a service or API exposes many failure kinds, wrap them in one error with a tagged `reason` union and handle them with `Effect.catchReason`, `Effect.catchReasons`, or `Effect.unwrapReason`.
- Do not name a tagged error's payload field `name`: it shadows `Error.name`, and the Effect language service reports `errorPayloadShadowsName`. Use a specific key such as `folderName`.

## Resources, concurrency and scheduling

- Acquire resources with `Effect.acquireRelease` inside the Layer or scoped Effect that owns them; close scopes with `Effect.scoped` for request-lifetime resources.
- For callback registration, use `Effect.callback` with a finalizer or `Stream.callback`/`Stream.fromEventListener` with `acquireRelease` for listeners. Handle registration failure and late callbacks when those paths can occur.
- Run background work with `Layer.effectDiscard` and `Effect.forkScoped` so it is interrupted when the scope closes; do not fork detached fibers.
- Express retries, repeats, and polling with `Schedule` (`Effect.retry`, `Effect.repeat`, `Stream.fromEffectSchedule`): cap exponential backoff, add jitter, bound attempts, and stop on non-retryable errors with `Schedule.while`. Do not hand-roll sleep loops.
- Use `Stream` constructors (`fromIterable`, `paginate`, `fromAsyncIterable`, `NodeStream.fromReadable`) for sequences and `PubSub` for in-process fan-out; use `RequestResolver` with `Effect.request` to batch and deduplicate external lookups.

## HTTP and Promise boundaries

- Use Effect `HttpClient` from `effect/http` with `FetchHttpClient` for HTTP requests. Configure a client once in the owning Layer with `HttpClient.mapRequest` (`HttpClientRequest.prependUrl`, `acceptJson`), `HttpClient.filterStatusOk`, and `HttpClient.retryTransient`; decode bodies with `HttpClientResponse.schemaBodyJson`. Compose application policies without weakening existing URL validation, credentials, redirect checks, timeouts, bounded response reads, cancellation, or resource cleanup; do not add such policies without a requirement.
- Adapt Promise APIs with the supported Effect Promise adapters; do not use Promise `.then()`, `.catch()`, or `.finally()` chains before or after adaptation. Keep sequencing, failures, and cleanup in Effect, or use await with boundary-level try/catch/finally where a Promise boundary is required. Effect error and cleanup combinators remain valid.
- Run programs at the edge only: `NodeRuntime.runMain`/`BunRuntime.runMain` for process entry points, `Layer.launch` when the application is a Layer, and one shared `ManagedRuntime` (with a shared `Layer.makeMemoMapUnsafe()` memo map when several exist) for non-Effect frameworks, disposed on shutdown. Do not call `Effect.runPromise` throughout application code.
- Expose one execution form per boundary unless callers explicitly need both Promise and Effect APIs. Do not duplicate workflows to provide both.

## Tests

- Use `@effect/vitest` (`it.effect`, `it.effect.each`, `it.effect.prop` with Schema arbitraries, `it.live` for real services) and its `assert` helpers instead of manual runtime wrappers. Control time with `TestClock`.
- Provide fakes as `layerTest` Layers of the real service, composed onto `layerNoDeps` with `Layer.provideMerge` when tests need to inspect a backing `Ref` service. Use `layer(...)` from `@effect/vitest` for a shared Layer only when tests may observe shared state; otherwise `Effect.provide` per test.
- Fakes must satisfy the required service contract without casts that hide missing members. Use production Layers only when their dependencies and lifecycle belong in the test boundary.
- Cover acquisition, release, cleanup, and interruption when project-owned behavior depends on them and existing tests do not cover the risk.

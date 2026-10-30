# Effect

Apply when code or tests use the `effect` package. Check installed versions and repository conventions before choosing APIs.

## Composition and services

- Keep workflows readable as sequential operations; use generator composition when it makes that sequence clearer. Do not wrap an existing Effect merely for visual consistency.
- A function returning an Effect does not need a Service or Layer. Introduce neither unless the architecture requires a separately provided capability.
- Follow existing service definitions, including classes required by the installed API; a TypeScript preference for type aliases does not override runtime requirements.
- Require only services used by the operation, not the caller's entire environment. Acquire them inside the Effect that uses them.
- Compose Layers without changing dependency order, sharing, or resource lifetime. Do not merge providers merely for uniformity or require a cross-project naming suffix.
- Prefer a framework-provided Layer when it expresses the required behavior directly. Provide independent dependencies at the composition root; retain nesting for actual dependency ordering, not one-use category groups.
- Before writing a provider Service, check version-matched official adapters and compose their Layers when the protocol matches. Separate application policies (endpoint shape, timeout, credentials, redirects, tracing propagation and response lifetime) from provider protocol logic; decorate only the missing policy, not the whole client.
- Use the direct supported adapter for external callbacks, throws, or Promise rejections. Do not add intermediate Promise conversions when a direct adapter satisfies cancellation and cleanup requirements.

## HTTP and Promise boundaries

- Use Effect `HttpClient` with `FetchHttpClient` for HTTP requests. Compose application policies without weakening URL validation, credentials, redirect checks, timeouts, bounded response reads, cancellation, or resource cleanup.
- Adapt Promise APIs with the supported Effect Promise adapters; do not use Promise `.then()`, `.catch()`, or `.finally()` chains before or after adaptation. Keep sequencing, failures, and cleanup in Effect, or use await with boundary-level try/catch/finally where a Promise boundary is required. Effect error and cleanup combinators remain valid.

## Failures and resources

- Keep expected failures in the typed error channel; keep defects and interruption distinct. Do not catch an error just to rewrap it or discard information before a boundary requires translation.
- For callback registration or acquired resources, preserve cleanup on completion and interruption. Handle registration failure and late callbacks when those paths can occur.
- Expose one execution form per boundary unless callers explicitly need both Promise and Effect APIs. Do not duplicate workflows to provide both.

## Tests

- Use the project's compatible Effect-aware test integration instead of repeated manual runtime wrappers.
- Provide fake services through Layers only where dependencies are already modeled as services. Do not turn function dependencies into services for testing.
- Fakes must satisfy the required service contract without casts that hide missing members. Use production Layers only when their dependencies and lifecycle belong in the test boundary.
- Cover acquisition, release, cleanup, and interruption when project-owned behavior depends on them and existing tests do not cover the risk.

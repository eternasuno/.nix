# Effect

Apply when code or tests use the `effect` package. Check installed versions and repository conventions before choosing APIs.

## Composition and services

- Keep workflows readable as sequential operations; use generator composition when it makes that sequence clearer. Do not wrap an existing Effect merely for visual consistency.
- A function returning an Effect does not need a Service or Layer. Introduce neither unless the architecture requires a separately provided capability.
- Follow existing service definitions, including classes required by the installed API; a TypeScript preference for type aliases does not override runtime requirements.
- Require only services used by the operation, not the caller's entire environment. Acquire them inside the Effect that uses them.
- Compose Layers without changing dependency order, sharing, or resource lifetime. Do not merge providers merely for uniformity or require a cross-project naming suffix.
- Use the direct supported adapter for external callbacks, throws, or Promise rejections. Do not add intermediate Promise conversions when a direct adapter satisfies cancellation and cleanup requirements.

## Failures and resources

- Keep expected failures in the typed error channel; keep defects and interruption distinct. Do not catch an error just to rewrap it or discard information before a boundary requires translation.
- For callback registration or acquired resources, preserve cleanup on completion and interruption. Handle registration failure and late callbacks when those paths can occur.
- Expose one execution form per boundary unless callers explicitly need both Promise and Effect APIs. Do not duplicate workflows to provide both.

## Tests

- Use the project's compatible Effect-aware test integration instead of repeated manual runtime wrappers.
- Provide fake services through Layers only where dependencies are already modeled as services. Do not turn function dependencies into services for testing.
- Fakes must satisfy the required service contract without casts that hide missing members. Use production Layers only when their dependencies and lifecycle belong in the test boundary.
- Cover acquisition, release, cleanup, and interruption when project-owned behavior depends on them and existing tests do not cover the risk.

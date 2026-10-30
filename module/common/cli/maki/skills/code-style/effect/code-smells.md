# Effect Code Smells

Check the installed Effect version, actual service contracts, cancellation, and resource ownership before changing composition.

- **HTTP transport or Promise-chain bypass:** flag HTTP requests bypassing fetch/Effect HttpClient and Promise `.then`/`.catch`/`.finally` chains around Effect execution or adapters. Use FetchHttpClient and direct Promise adapters with Effect composition, preserving security, cancellation, error channels, and cleanup. Effect.catch/catchTag/ensuring are valid Effect composition.
- **Service or Layer ceremony:** identify a separately provided capability or real lifecycle boundary. Returning an Effect, being effectful, or needing a fake does not alone justify a Service or Layer.
- **Overbroad environment:** compare required services with actual use. Acquire only needed services inside the Effect using them; preserve provider sharing, dependency order, and lifetime.
- **Reimplemented provider protocol:** inspect version-matched official adapters first. Compose supported Layers and decorate missing application policy instead of wrapping an entire client. Verify endpoint, timeout, credentials, redirects, tracing, and response lifetime.
- **Unnecessary async conversions:** compare direct supported callback, throw, or Promise adapters. Remove intermediate conversions only when cancellation and cleanup remain correct.
- **Error-channel damage:** trace catches and rewrapping for lost information or conflation of expected failures, defects, and interruption. Translate only at an intentional boundary.
- **Leaking registrations or resources:** inspect acquisition failure, completion, interruption, and late callbacks where reachable. Preserve release and cleanup on all required paths.
- **Duplicate execution forms:** identify actual consumers of Promise and Effect APIs before retaining both. Share one workflow rather than duplicating behavior.
- **Test-specific service architecture:** fake existing service boundaries with contract-complete Layers; do not convert ordinary function dependencies into services or hide missing fake members with casts. Check compatible Effect-aware testing support and existing lifecycle coverage before adding manual runtime wrappers.

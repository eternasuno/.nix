# Effect-TS Rules

Apply these rules in addition to `SKILL.md` and its focused references when code uses the `effect` package. These rules target the newer Effect-TS API, whose versions have significant API changes; verify the project's installed version, lockfile, and type definitions before applying version-specific forms.

## Services and environments

- Follow the repository's service-definition convention. In class form, use `Context.Service<Self, Shape>()(...)` and use the class instance type, not `typeof Class`, in the `R` environment.
- When repository conventions do not require otherwise, expose a dependency's natural value directly; add a service wrapper only when it defines a real capability or policy boundary.
- Declare only the services an Effect stage actually requires. Split workflows at capability, validation, or representation boundaries rather than widening every stage to the caller's full environment.
- Build and provide implementations with `Layer`; keep service acquisition inside the Effect that requires it.
- Keep `Redacted` secrets wrapped through configuration and composition; unwrap them only at the adapter call that requires the raw value.

## Port boundaries

- Let Effect-returning ports express expected failures in their typed error channel.
- At adapters, convert native throws and SDK-specific failures with the matching Effect constructor, such as `Effect.try`, `Effect.tryPromise`, or `Effect.callback`.
- Normalize external failure representations at the adapter boundary when downstream code needs one error contract.
- Compose conforming port Effects directly in use cases. Do not wrap them again merely to catch synchronous throws; an implementation that throws instead of returning an Effect violates the port contract.
- Name operations by business meaning, not return mechanism, and expose one canonical execution form at each boundary rather than duplicate Effect and Promise variants.
- Implement callback APIs directly with `Effect.callback` when cancellation or cleanup matters, and return the cleanup Effect from the registration function.

## Workflow errors

- Represent expected validation failures in the typed error channel while composing stages. Convert them to domain failure values once at the workflow boundary when the domain contract requires a total result.
- Keep interruption distinct from typed failure. Use typed error handlers such as `Effect.catch` when cancellation must continue to interrupt the workflow.
- Preserve useful failure information until the boundary that intentionally reduces it to a user-facing reason.

## Testing

- Provide fake services through Layers and test the composed Effect through its public entry point.
- When the repository provides a compatible Effect/Vitest integration, use its Effect-aware test runner instead of repeating `runPromise`/`runSync` wrappers; verify package compatibility first.
- Use shared Layer helpers only for immutable or intentionally shared services; provide per-test mutable fakes at the individual test boundary.
- Verify typed failures separately from defects caused by contract-violating implementations.
- For callback Effects, test interruption cleanup, no cleanup after normal completion, synchronous registration failures, and ignored late callbacks. Assert the interrupted `Exit` explicitly rather than relying only on error-message text.

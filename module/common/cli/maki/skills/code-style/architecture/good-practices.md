# Architecture Good Practices

Apply when currently changing or evaluating a responsibility, contract (including dependency direction), representation, or lifecycle/ownership boundary. Use logical roles, not mandatory physical layers, and retain a different suitable existing architecture.

## Design from execution paths

- Trace actual execution and data flow before choosing structure. Identify business decisions, external mechanisms, normal and failure paths, and cleanup responsibilities.
- Determine whether structural change is needed. Compare meaningful alternatives and choose the smallest design expressing real boundaries; local edits may require none.
- When a new requirement conflicts with the current structure, consider the design you would choose knowing it from the start. If the result differs materially, migrate in verifiable pieces instead of bolting the requirement onto the old design.
- Validate affected contracts, dependency direction, public surface, and resource lifetime against concrete paths. Preserve transactions, compensation, recovery, side-effect ordering, and performance constraints where required.

## Entries, workflows, and domain operations

- Entries include HTTP handlers, CLI commands, message consumers, scheduled jobs, and UI actions. Parse and translate external input, perform protocol-specific validation, invoke a workflow, and translate its result. Keep business decisions out of transport code.
- A workflow represents a business use case. Sequence domain operations and capabilities, branch on business decisions, and coordinate transactions, failures, and recovery. Keep orchestration readable without requiring a separate module for each step.
- For example, checkout may read as validate order → reserve inventory → authorize payment → create order. This expresses business sequencing, not a mandatory set of layers or files.
- Domain operations express meaningful actions, decisions, invariants, and transformations. Prefer pure functions where external capabilities are unnecessary; keep transport, SDK, database, filesystem, and process representations out of domain logic unless intentionally part of its contract.
- Extract an operation when it names a real business action, decision, invariant, capability boundary, or meaningful workflow stage. Prefer names surviving a mechanism change, such as `reserveInventory` or `authorizePayment`, over `insertReservationRow` or `callStripeEndpoint`.
- An operation that only forwards one capability call gets no workflow function; the entry calls the capability directly and the capability contract states the rule. Add a workflow when it sequences calls, branches on a business decision, or holds an invariant.
- Let vocabulary emerge from actual workflows. Do not turn every expression into a domain primitive, replace visible code with an equally low-level name, or build speculative DSLs, registries, interpreters, or workflow frameworks. Domain concepts do not automatically require services, interfaces, effects, or command objects.

## Capabilities and adapters

- A capability represents an external ability the business needs: persistence, payments, messaging, time, identity, external APIs, or storage. Express its contract in terms useful to the consumer, not the underlying SDK.
- Prefer meaningful operations such as `PaymentGateway.authorize`, `OrderStore.save`, `Clock.now`, and `MessagePublisher.publish` over mechanism-shaped contracts such as `StripeClient.post` or `Postgres.insert`, unless the mechanism itself belongs to the contract.
- Read the current time from the injected clock, once per workflow, and use that value throughout. Workflows, adapters, and entities do not read the system time (`Date.now`, `new Date()`) for a business value.
- Introduce an interface or equivalent abstraction for a real stable boundary, dependency inversion, materially different implementations, deliberate runtime capability, or shared module contract. Do not create one solely for mocking, effectful behavior, hypothetical replacement, or where a direct function or concrete dependency already expresses the boundary. Do not wrap a capability the framework already provides as an injectable service, such as an HTTP client, in an application port; use it directly and let the composition root provide the implementation.
- Adapters implement capabilities with external mechanisms. Translate representations and external failures, contain technology-specific details, and keep business policy outside them. Keep adapters thin unless the mechanism requires real coordination.
- Before introducing an abstraction, identify its responsibility, the coupling it removes, the invariant or capability it exposes, and whether it still makes sense if the technology changes. Moving code elsewhere or possible future use is insufficient.

## Dependencies and composition

- Business code may depend on capability contracts; concrete adapters implement and depend on those contracts, not the reverse. Distinguish static imports from runtime invocation when explaining or diagramming dependencies.

```text
entry → workflow → domain operations
           ↓
     capability contract ← adapter → external library
```

- At runtime, a workflow invokes its injected implementation, which calls the external system. The external system does not statically depend on the application adapter. Label diagrams explicitly when showing call flow instead of static dependencies.
- Do not force every call through every role. A workflow may directly compose domain operations and capabilities.
- Assemble shared application-scoped capabilities at the composition root when appropriate. Consumers use initialized instances; avoid duplicate initialization and accidental process-global lifetime.
- Switch behavior by injection: the entry or composition root reads the configuration and provides the matching capability implementation. Workflows take no provider flag or configuration object to choose a mechanism.
- Pass deployment values such as sizes and intervals as plain parameters or application configuration, not through a dedicated configuration capability.
- Prefer available language/platform capabilities, then suitable existing dependencies, then justified trusted new dependencies, and custom infrastructure only when necessary. Do not reimplement established parsing, encoding, validation, concurrency, cryptography, protocols, storage, collections, or serialization without a concrete reason. Do not add a dependency just to replace a few clear lines of domain logic.

## Contracts, data, and failures

- Express clear inputs, outputs, failure contracts, and ownership at module and capability boundaries. Prefer domain terms over transport and infrastructure representations.
- Reuse existing entities as data types when their contract fits the consumer. Do not create input, repository-value, or response variants merely because data crosses a layer, then map identical fields between them. Derive genuinely different contracts, such as writable partial patches, from entity fields; keep transport-specific projections at the transport boundary.
- Do not add a post-write read solely to reconstruct a returned entity: it adds a failure point after a successful mutation and can observe unrelated concurrent changes. Prefer the mutation result or the known entity and applied patch when those satisfy the contract.
- Separate distinct business scopes into named operations. For optional collection filters, distinguish an absent restriction from an explicitly empty selection; keep query and mutation semantics consistent, and never let an empty selection silently broaden a write.
- When consumers need several related aggregates together, consider one grouped query and one response. Migrate callers and failure handling together; retaining separate requests can repeat the same combined query.
- Validate where the relevant invariant becomes known. Distinguish transport validation, representation parsing, domain validation, and external capability failure; do not repeat the same check across layers without a real reason.
- Decode outside data once where it enters (request input, adapter output, configuration) into types that only decoding produces, such as branded values. Past that point trust them; do not validate or normalize them again.
- Translate external HTTP payloads, database rows, SDK objects, CLI arguments, and serialized messages before their details spread through business code. Keep domain representations independent unless the representations are intentionally identical.
- Make ownership of mutation, persistence, normalization, lifecycle, retries, cleanup, and error translation explicit. Avoid shared mutable state with unclear ownership.
- Keep a value type's rules (normalization, range, default) in its schema or entity type, not in the workflows that use it.
- For operations that may be retried, replayed, or resumed after a partial failure, make the effect idempotent: running twice or resuming reaches the same state. Use explicit keys, upserts, or state transitions rather than assuming a single attempt.
- Preserve useful failure information until a boundary intentionally reduces it. Distinguish expected domain/capability failures, defects, programmer errors, cancellation, and infrastructure failures when behavior depends on that distinction.
- Translate external failure types at the adapter boundary rather than leaking SDK-specific failures into business logic.
- Prefer explicit data flow over hidden globals, implicit mutation, and ambient configuration. Pass only data and capabilities the consumer actually requires.

## Physical structure

Logical roles do not require separate folders, packages, services, or files. A small program may keep several roles in one file. Keep closely related entity schemas, types, and helpers in their existing owning module; a new type or helper alone does not justify a new file, and a function only one workflow uses lives in that workflow's module. Split only for concrete ownership, comprehension, reuse, independent evolution, deployment, technology separation, or testing at a real boundary.

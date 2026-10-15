# Architecture Good Practices

Apply when assigning responsibilities, composing workflows, or changing contracts, representations, dependencies, or ownership. Use logical roles, not mandatory physical layers, and retain a different suitable existing architecture.

## Design from execution paths

- Trace actual execution and data flow before choosing structure. Identify business decisions, external mechanisms, normal and failure paths, and cleanup responsibilities.
- Determine whether structural change is needed. Compare meaningful alternatives and choose the smallest design expressing real boundaries; local edits may require none.
- Validate affected contracts, dependency direction, public surface, and resource lifetime against concrete paths. Preserve transactions, compensation, recovery, side-effect ordering, and performance constraints where required.

## Entries, workflows, and domain operations

- Entries include HTTP handlers, CLI commands, message consumers, scheduled jobs, and UI actions. Parse and translate external input, perform protocol-specific validation, invoke a workflow, and translate its result. Keep business decisions out of transport code.
- A workflow represents a business use case. Sequence domain operations and capabilities, branch on business decisions, and coordinate transactions, failures, and recovery. Keep orchestration readable without requiring a separate module for each step.
- For example, checkout may read as validate order → reserve inventory → authorize payment → create order. This expresses business sequencing, not a mandatory set of layers or files.
- Domain operations express meaningful actions, decisions, invariants, and transformations. Prefer pure functions where external capabilities are unnecessary; keep transport, SDK, database, filesystem, and process representations out of domain logic unless intentionally part of its contract.
- Extract an operation when it names a real business action, decision, invariant, capability boundary, or meaningful workflow stage. Prefer names surviving a mechanism change, such as `reserveInventory` or `authorizePayment`, over `insertReservationRow` or `callStripeEndpoint`.
- Let vocabulary emerge from actual workflows. Do not turn every expression into a domain primitive, replace visible code with an equally low-level name, or build speculative DSLs, registries, interpreters, or workflow frameworks. Domain concepts do not automatically require services, interfaces, effects, or command objects.

## Capabilities and adapters

- A capability represents an external ability the business needs: persistence, payments, messaging, time, identity, external APIs, or storage. Express its contract in terms useful to the consumer, not the underlying SDK.
- Prefer meaningful operations such as `PaymentGateway.authorize`, `OrderStore.save`, `Clock.now`, and `MessagePublisher.publish` over mechanism-shaped contracts such as `StripeClient.post` or `Postgres.insert`, unless the mechanism itself belongs to the contract.
- Introduce an interface or equivalent abstraction for a real stable boundary, dependency inversion, materially different implementations, deliberate runtime capability, or shared module contract. Do not create one solely for mocking, effectful behavior, hypothetical replacement, or where a direct function or concrete dependency already expresses the boundary.
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
- Prefer available language/platform capabilities, then suitable existing dependencies, then justified trusted new dependencies, and custom infrastructure only when necessary. Do not reimplement established parsing, encoding, validation, concurrency, cryptography, protocols, storage, collections, or serialization without a concrete reason. Do not add a dependency just to replace a few clear lines of domain logic.

## Contracts, data, and failures

- Express clear inputs, outputs, failure contracts, and ownership at module and capability boundaries. Prefer domain terms over transport and infrastructure representations.
- Validate where the relevant invariant becomes known. Distinguish transport validation, representation parsing, domain validation, and external capability failure; do not repeat the same check across layers without a real reason.
- Translate external HTTP payloads, database rows, SDK objects, CLI arguments, and serialized messages before their details spread through business code. Keep domain representations independent unless the representations are intentionally identical.
- Make ownership of mutation, persistence, normalization, lifecycle, retries, cleanup, and error translation explicit. Avoid shared mutable state with unclear ownership.
- Preserve useful failure information until a boundary intentionally reduces it. Distinguish expected domain/capability failures, defects, programmer errors, cancellation, and infrastructure failures when behavior depends on that distinction.
- Translate external failure types at the adapter boundary rather than leaking SDK-specific failures into business logic.
- Prefer explicit data flow over hidden globals, implicit mutation, and ambient configuration. Pass only data and capabilities the consumer actually requires.

## Physical structure

Logical roles do not require separate folders, packages, services, or files. A small program may keep several roles in one file. Split only for concrete ownership, comprehension, reuse, independent evolution, deployment, technology separation, or testing at a real boundary.

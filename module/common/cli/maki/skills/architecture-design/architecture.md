# Architecture

Use logical roles instead of fixed architectural layers.

## Entry

Entry code includes HTTP handlers, CLI commands, message consumers, scheduled jobs, UI actions, and other external invocation points.

Entry code should:

- parse and translate external input;
- perform transport- or protocol-specific validation where required;
- invoke a business workflow;
- translate business results into external output.

Keep business decisions out of entry code.

## Workflows

A workflow represents a business use case.

A workflow may:

- sequence domain operations;
- branch on domain decisions;
- invoke required capabilities;
- preserve transaction or side-effect ordering;
- coordinate failures and recovery.

Keep workflows focused on orchestration. If substantial business logic appears inline, consider whether it represents a domain operation or pure domain function.

For example, checkout may read as: validate order → reserve inventory → authorize payment → create order. This is business sequencing, not a required set of modules. Preserve failure propagation, compensation, and side-effect ordering where the use case requires them.

## Domain operations

Domain operations express meaningful business actions, rules, decisions, invariants, and transformations.

Prefer pure functions for logic that does not require external capabilities.

Domain operations should not depend on transport, framework, SDK, database, filesystem, or process-specific representations.

Extract an operation when it names a real business action, decision, invariant, capability boundary, or meaningful workflow stage. A useful name survives a change of mechanism: `reserveInventory` rather than `insertReservationRow`, `authorizePayment` rather than `callStripeEndpoint`. Do not turn every expression into a domain primitive or merely replace visible code with an equally low-level name.

Let vocabulary emerge from concrete workflows, not a speculative DSL, registry, interpreter, or generic workflow framework. Pure calculations and transformations may remain ordinary functions; domain concepts do not automatically require services, interfaces, effects, or command objects.

## Capabilities

A capability represents something the business needs from the outside world.

Examples include:

- persistence;
- payment authorization;
- message publication;
- time;
- identity lookup;
- external API access;
- file storage.

Define capability contracts in terms useful to the consumer rather than in terms of the concrete SDK or infrastructure.

## Adapters

Adapters implement capabilities using external mechanisms.

Adapters should:

- translate between external and internal representations;
- translate external failures into the capability contract;
- contain technology-specific behavior;
- avoid business policy.

Keep adapters thin unless the external mechanism itself requires meaningful coordination.

## Dependency direction

Business code may depend on capability contracts.

Concrete adapters depend on those contracts, not the reverse.

Static dependency arrows mean "depends on", not runtime calls:

```text
entry → workflow → domain operations
           ↓
     capability contract ← adapter → external library
```

At runtime a workflow invokes an injected capability implementation (the adapter), which calls the external system. An external system does not statically depend on the application's adapter. Label diagrams explicitly when showing call flow rather than static dependencies.

Do not force all calls through every role. A workflow may directly compose domain operations and capabilities.

## Physical structure

Do not equate logical roles with required folders or packages.

A small program may contain several roles in one file while preserving clear dependencies.

Split physical structure only when it improves ownership, comprehension, reuse, independent evolution, deployment, technology separation, or testing at a real boundary.

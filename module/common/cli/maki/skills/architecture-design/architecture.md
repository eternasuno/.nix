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

## Domain operations

Domain operations express meaningful business actions, rules, decisions, invariants, and transformations.

Prefer pure functions for logic that does not require external capabilities.

Domain operations should not depend on transport, framework, SDK, database, filesystem, or process-specific representations.

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

A useful mental model is:

```text
entry
  ↓
workflow
 ↙      ↘
domain   capability contract
             ↑
          adapter
             ↑
       external system
```

Do not force all calls through every role. A workflow may directly compose domain operations and capabilities.

## Physical structure

Do not equate logical roles with required folders or packages.

A small program may contain several roles in one file while preserving clear dependencies.

Split physical structure only when it improves ownership, comprehension, reuse, independent evolution, deployment, technology separation, or testing at a real boundary.

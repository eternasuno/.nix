# Boundaries and Dependencies

## Capability boundaries

Introduce a capability when business code requires an external ability whose implementation should remain outside the business logic.

Name capabilities by meaning, not mechanism.

Prefer:

```text
PaymentGateway.authorize
OrderStore.save
Clock.now
MessagePublisher.publish
```

over:

```text
StripeClient.post
Postgres.insert
SystemDate.read
KafkaClient.send
```

unless the concrete mechanism itself is intentionally part of the contract.

## Interfaces

Use an interface or equivalent abstraction when there is a real reason:

- a stable boundary between business and infrastructure;
- dependency inversion;
- materially different implementations;
- a deliberate runtime capability;
- a stable contract shared across modules.

Do not create an interface:

- solely for mocking;
- solely because an implementation is effectful;
- because it might be replaced someday;
- when a direct function or concrete dependency already expresses the boundary clearly.

## Adapters

Translate technology-specific details at the adapter boundary.

Adapters should prevent SDK-specific types, errors, transport details, serialization formats, or persistence representations from leaking into business code unless they are intentionally part of the domain.

## Dependencies

Prefer, in order:

1. language and platform capabilities already available;
2. an existing suitable project dependency;
3. a trusted external dependency;
4. custom infrastructure only when necessary.

Do not reimplement established parsing, encoding, validation, concurrency, cryptography, protocol, storage, collection, or serialization behavior without a concrete reason.

Do not add a dependency merely to replace a few clear lines of domain logic.

## Abstraction test

Before introducing a new abstraction, ask:

- What real responsibility does this represent?
- What coupling does it remove?
- What invariant or capability does it make explicit?
- Would the abstraction still make sense if the implementation technology changed?

If the answer is only “it moves code elsewhere” or “it may be useful later,” keep the design direct.

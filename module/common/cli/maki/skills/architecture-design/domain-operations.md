# Domain Operations and Workflows

## Domain operations

For non-trivial business workflows, identify the meaningful business operations that make up the workflow.

Examples:

```text
validateOrder
reserveInventory
authorizePayment
createOrder
cancelSubscription
approveApplication
selectNextBranch
```

A domain operation should usually remain meaningful if its database, SDK, transport, or runtime implementation changes.

Prefer business meaning:

```text
reserveInventory
authorizePayment
loadConversation
publishOrderCreated
```

over implementation mechanism:

```text
insertReservationRow
callStripeEndpoint
readConversationJson
sendKafkaMessage
```

## Extraction criteria

Extract a domain operation when it represents one or more of:

- a real business action;
- a business decision;
- an invariant;
- a reusable domain rule;
- a capability boundary;
- a meaningful workflow stage.

Do not turn every expression, helper, or one-use function into a domain primitive.

If extracting an operation only replaces visible code with an equally low-level name, keep the code inline.

## Workflows

Workflows primarily express:

- sequencing;
- branching;
- coordination;
- capability use;
- failure propagation;
- required side-effect ordering.

A workflow should read as closely as practical to the business process.

For example:

```text
checkout
  → validate order
  → reserve inventory
  → authorize payment
  → create order
```

## Domain vocabulary

Let domain vocabulary emerge from actual workflows.

Do not begin by designing:

- a generic DSL;
- command trees;
- interpreters;
- operation registries;
- generalized workflow frameworks;
- abstraction hierarchies.

If stable operations emerge naturally across workflows, together they form an implicit domain-specific language.

The DSL is an outcome of the domain model, not the starting point.

## Pure logic

Keep pure calculations and transformations as ordinary functions when possible.

Not every domain concept needs a service, interface, effect, command object, or runtime abstraction.

Prefer the smallest representation that preserves business meaning.

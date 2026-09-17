# Examples

## Good Frontier Round

```text
❓ Q1 — Persistence lifetime

The feature needs state to survive process restarts. The project already uses SQLite for local durable state, and no cross-machine sharing is required.

➡️ Recommendation: store the state in the existing SQLite database rather than introducing another persistence system.

Should this state persist indefinitely, or be automatically removed after some lifecycle event?

---

❓ Q2 — Duplicate requests

The same operation can be triggered more than once before the first attempt finishes.

Options:
- reject a duplicate while one is active
- coalesce duplicates into the active operation
- allow concurrent duplicate operations
```

These questions can be asked together because neither depends on the other's answer.

## Bad Question Ordering

Do not ask this in one round:

```text
Q1: Should updates be pushed or polled?
Q2: If we use WebSocket, what reconnect policy should we use?
```

Q2 depends on Q1. It belongs to a later round if WebSocket is selected.

## Facts vs Decisions

Bad:

```text
Which serialization library does the project currently use?
```

If the repository can answer this, inspect it yourself.

Better:

```text
The project already uses Effect Schema for boundary validation and serialization. Introducing Zod here would add a second schema system without providing a required capability.

➡️ Recommendation: use Effect Schema.

Do you want to commit to that choice?
```

## Do Not Invent Requirements

Bad:

```text
➡️ Recommendation: keep deleted records for 30 days.
```

when no product rule, legal requirement, or project convention supports 30 days.

Better:

```text
The retention period affects user-visible behavior and is not defined by the current system.

How should deleted records be retained, if at all?
```

## Requirement vs Architecture Boundary

Appropriate for `feature-design`:

```text
- persistence = SQLite
- transport = WebSocket
- retry policy = exponential backoff, maximum 3 retries
- existing CLI behavior must remain backward compatible
- use Effect Schema rather than introducing another schema library
```

Usually leave to `architecture-design`:

```text
- exact domain primitives
- exact interfaces
- module decomposition
- dependency direction
- placement of effect boundaries
- workflow composition
```

## Final Summary Shape

```markdown
# Feature Design

## Goal

## Scope

## Non-goals

## User / System Scenarios

## Business Rules

## Constraints

## Existing System Context

## Technical Decisions

## Dependency Decisions

## Failure and Edge Cases

## Compatibility / Migration

## Acceptance Criteria

## Risks

## Deferred Decisions
```

Record confirmed decisions rather than reproducing the whole interview.

# Control Flow and Complexity

## Direct control flow

Prefer straightforward code whose execution order is visible.

Keep sequential operations sequential unless concurrency is required.

Prefer:

```text
load
validate
transform
persist
return
```

over compressed expressions that obscure meaningful stages.

## Intermediate values

Introduce a named intermediate value when the name communicates meaningful intent or makes data flow easier to follow.

Do not introduce a variable merely to rename a trivial expression.

## Helpers

Extract a helper when it:

- is reused;
- isolates meaningful complexity;
- names an important local concept;
- creates a real representation or validation boundary.

Keep a helper inline when it:

- is used once;
- merely forwards arguments;
- only renames an expression;
- reconstructs unchanged state;
- hides otherwise clear data flow.

## Control structures

Prefer ordinary control-flow constructs over generalized dispatch, callback machinery, state containers, or custom combinators when the direct form is clear.

Do not replace a simple conditional with an abstraction unless the abstraction represents a real recurring concept.

## Representation changes

Avoid unnecessary conversions such as:

```text
callback → Promise → effect
object → JSON → object
domain value → transport value → domain value
```

when the consumer can work with the original representation directly.

## Comments

Write comments when necessary to explain:

- a non-obvious constraint;
- compatibility behavior;
- security reasoning;
- a business decision;
- side-effect ordering;
- a workaround;
- behavior that cannot be made obvious from code.

Do not restate visible code behavior in comments.

## Local abstraction

Do not build a local mini-framework to avoid a small amount of direct code.

A few explicit lines are often preferable to a reusable abstraction with configuration, indirection, or hidden control flow.

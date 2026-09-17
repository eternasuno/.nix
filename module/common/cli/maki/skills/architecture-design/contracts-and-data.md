# Contracts and Data

## Explicit contracts

Make module and capability boundaries explicit through clear inputs, outputs, failure contracts, and ownership.

Prefer contracts expressed in domain terms rather than transport or infrastructure representations.

## Validation

Validate data at the boundary where the relevant invariant becomes known.

Separate:

- transport validation;
- representation parsing;
- domain validation;
- external capability failure.

Do not repeat the same validation across layers without a real reason.

## Data representations

Translate external representations before they spread through business code.

Examples include:

- HTTP payloads;
- database rows;
- SDK response objects;
- CLI arguments;
- serialized messages.

Keep domain representations independent from external representation details unless they are intentionally identical.

## Ownership

Make it clear which component owns:

- mutation;
- persistence;
- normalization;
- lifecycle;
- retries;
- resource cleanup;
- error translation.

Avoid shared mutable state whose ownership is unclear.

## Failures

Preserve useful failure information until the boundary that intentionally reduces it.

Differentiate expected domain or capability failures from defects, programmer errors, cancellation, and infrastructure failures when the distinction affects behavior.

Translate external failure types at the adapter boundary rather than leaking SDK-specific failures through business logic.

## Data flow

Prefer explicit data flow over hidden global state, implicit mutation, or ambient configuration.

A component should receive the data and capabilities it actually requires.

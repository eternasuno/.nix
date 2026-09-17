# Effect-TS

Apply these rules when code uses the `effect` package.

Verify the project's installed Effect version, lockfile, and existing conventions before applying version-specific APIs.

## Composition

Use Effect to express effectful computation directly.

Keep workflow code readable as a sequence of meaningful operations.

Prefer `Effect.gen` when imperative-style sequencing makes the workflow easier to understand.

Do not wrap an existing Effect merely to make it look consistent with neighboring code.

## Services

When architecture has established a capability as a service, follow the repository's service-definition convention.

Do not create a service simply because a function returns an Effect.

Plain functions and Effect-returning functions remain appropriate when no independent capability boundary exists.

## Environment

Declare only the services an Effect actually requires.

Avoid widening a small operation to the caller's complete environment.

Acquire services inside the Effect that uses them according to repository conventions.

## Layers

Use `Layer` to construct and provide service implementations when the architecture requires Effect services.

Do not introduce Layer machinery for dependencies that do not need to be modeled as services.

## External effects

Convert native throws, Promise rejection, callback behavior, and SDK failures at the point where they enter Effect.

Use the appropriate Effect constructor for the external mechanism.

Avoid unnecessary conversions such as:

```text
callback → Promise → Effect
```

when `Effect.callback` can model the operation directly.

## Errors

Represent expected failures in the typed error channel.

Keep defects distinct from expected domain or capability failures.

Do not catch an Effect merely to wrap the same error again.

Preserve useful failure information until the boundary that intentionally reduces it.

Keep interruption distinct from typed failure.

## Resource lifetime

When callback registration or external resources require cancellation or cleanup, model cleanup explicitly.

Ensure cleanup behavior is correct for:

- interruption;
- normal completion;
- registration failure;
- late callbacks.

## Execution forms

Expose one canonical execution form at a boundary.

Do not maintain duplicate Promise and Effect APIs unless both are explicitly required.

Keep business-oriented operation names independent of execution mechanism.

# SolidJS 2 Development Rules

Apply to components, reactivity, UI state, forms, and data flow targeting SolidJS 2. Follow the framework-independent native state, accessibility, browser-target, and validation rules in [Web UI rules](ui-rules.md).

## Version and package boundaries

- Use Solid 2 APIs and execution semantics, not Solid 1 or React patterns. Verify the installed runtime, renderer, compiler, and integrations against current Solid 2 documentation. If the project still targets Solid 1, identify the compatibility gap rather than silently mixing versions or upgrading dependencies outside the task's scope.
- Import reactive and store primitives from `solid-js`. Import web rendering APIs and DOM-specific `JSX`/`ComponentProps` types from `@solidjs/web`; use `jsxImportSource: "@solidjs/web"` and the compatible `@solidjs/vite-plugin` where applicable. Verify third-party libraries support the same runtime and compiler generation.

## Reactive state ownership

- Use each signal for a genuinely independent reactive/application state boundary. Independently changing application state consumed by other reactive computations or UI belongs in signals; do not copy browser-owned or DOM state into the Solid reactive graph merely for styling or submission.
- Derive values from existing reactive state with a plain derived accessor, or `createMemo` when caching has value. Do not maintain derivable duplicate state through synchronized signals or effects. Use function-form `createSignal` only when a writable derived value is actually required.
- Minimize duplicate state and unnecessary reactive dependencies, not signal count. Do not combine unrelated state into one large object signal to reduce the count; use stores for structured data needing property-level updates.
- Avoid bidirectional synchronization between native/DOM state and signals. Use Solid as the authoritative owner only when application integration requires it, rather than maintaining two sources of truth.

## Components and reactive reads

- Treat component bodies as one-time setup, not repeated render functions. Read changing signals and props inside JSX or tracked computations; a top-level `const doubled = count() * 2` is only a snapshot. A derived accessor such as `() => count() * 2` stays reactive only when called in a tracking scope. Use `untrack` narrowly for intentional one-time reads.
- When a child prop's contract is a value, read the signal in the JSX attribute expression, such as `<User id={id()} />`; consumers read `props.id` without knowing whether the source is a signal. Do not first capture the value in a setup-time local. Pass an accessor only when the component's explicit contract requires deferred reads.
- Preserve reactive prop access: read `props.name` rather than destructuring props, copying them with plain object spread, or assigning their values to setup-time locals. Use `omit(props, "a", "b")` to forward remaining props and `merge` for reactive composition. In `merge`, `undefined` explicitly overrides an earlier value; do not assume it preserves defaults.
- Prefer `<Show>` for conditional subtrees and `<Switch>`/`<Match>` for multiple branches. Simple inline conditions are valid; do not rewrite them mechanically or claim they are inherently non-reactive.
- Prefer `<For>` for dynamic lists whose item identities should be preserved; its item is a value and its index is an accessor. Use `<For keyed={false}>` when positions are stable but their values change; its item is an accessor and its index is a stable number. Do not default to `.map()` for reactive list rendering.
- Provide context through the context component, such as `<Theme value={value}>`. Use the object/array form of `class` for conditional classes and `ref` callbacks or factories for imperative element integration; compose callbacks with ref arrays when needed.
- Keep components focused and follow existing naming, typing, and module conventions. Do not mandate per-component directories, barrel exports, renderless components, or new state libraries without a concrete need.

## Effects, updates, and lifecycle

- Reserve `createEffect(compute, effect)` for external-system synchronization. The compute function tracks dependencies and must not write application state; the effect function is untracked and performs the imperative work. Extract required store properties in compute instead of passing a proxy and reading its properties only in effect.
- Return cleanup from the effect function, such as `createEffect(() => roomId(), id => { const connection = connect(id); return () => connection.close(); })`. Use `onSettled` for post-settlement lifecycle work and return its cleanup. Do not create nested reactive primitives inside `onSettled` callbacks. Use owner-scoped `onCleanup` for resources that belong to the component/root rather than a particular effect run.
- Read reactive dependencies before the first `await`; later reads are not tracked by the original computation. Do not rely on async effects to discover dependencies or automatically cancel external work.
- Avoid feedback loops and write-back derivations. Invoke setters from event handlers, actions, or effect functions, not component bodies or memo computations. Functional setters support previous-value updates but do not make arbitrary feedback loops safe.
- Update object/array signals through their setter with a new reference. Use `createStore` from `solid-js` and mutate only inside its draft setter, such as `setBoard(draft => { draft.notes.push("Note 3"); })`. The exposed store is read-only; use `snapshot` when external code needs a plain non-reactive value.
- Ordinary signal/store writes are staged and commit on the next microtask; an immediate read after a setter sees the last committed value. Consecutive writes already share automatic batching. Use `flush` only at an imperative boundary that must synchronously observe committed state or DOM, not as a blanket optimization or inside an action transaction.
- For imperative workflows whose writes cross async gaps, use `action` from `solid-js` with a generator/async generator. Yield promises to preserve the transaction; after an async-generator `await`, use a bare `yield` before later writes to re-enter it. Use optimistic primitives only when tentative user-visible state is required.

## Async data, errors, and rendering

- Model asynchronous derived data with `createMemo(() => fetchUser(userId()))` or an async memo that captures its inputs before awaiting. Read the resolved value through the memo accessor; do not mirror fetched data into an effect-managed signal.
- Place initially unresolved reads under `<Loading>` and failures under `<Errored>`. An `Errored` function fallback receives an error accessor, so read `error()`. Handle empty and successful data explicitly; use `isPending` when UI needs to reflect an in-flight changed answer.
- Async graph updates can retain committed content until the next answer is ready and hold related writes in the same update. Choose and test this behavior deliberately rather than assuming independently updating loading flags. Use `refresh` to re-run a computation; a bare refresh does not itself make `isPending` true.
- Stale-result handling does not cancel network work. When cancellation is needed, abort obsolete requests and dispose outstanding work using `AbortController` and appropriate lifecycle cleanup.
- Use boundaries for failures in their reactive subtree, not as a substitute for handling event-handler failures or detached async work. Catch and report those failures at their own boundary.
- Use `lazy` from `solid-js` with dynamic imports for justified route or heavy-component splitting. For a runtime-selected component, create it once with `dynamic` from `@solidjs/web` and then render it. Use existing tooling and measurements before adding virtualization, throttling, memoization, or dependencies.
- For SSR, keep server and initial client output consistent. Isolate browser-only APIs behind client-safe lifecycle conventions, and do not keep per-user mutable state in server module globals. Use `renderToStream` for async SSR and exactly one stream consumer; retain and call the disposer returned by `render`.
- Prefer normal JSX text rendering for untrusted content. Use `innerHTML` only with trusted or appropriately sanitized HTML. Client-exposed environment variables are not secret storage.

## Router and server data flow

Apply this section only when a Solid 2-compatible router/fullstack integration is present. Verify its installed APIs and adapters; do not infer compatibility from similar names or add a framework solely to follow this document.

- With Solid Router, use `createRouter` from `@solidjs/router` and static route configuration. Use keyed `query` functions for cached reads and consume them through `createMemo`. Reuse the same query and arguments in route preload and the component for deduplication.
- Start query work in route `preload` without awaiting it merely to gate rendering, such as `preload: ({ params }) => void getProduct(params.id)`. Let the component read changing params in its memo and its `Loading` boundary consume readiness. Return preload data only when an intentional route-match snapshot is appropriate.
- Distinguish router `action` from core `action`: router actions wrap submissions and cache revalidation; core actions coordinate reactive transactions. Use the router's supported POST form/submission flow for server mutations and targeted `revalidate` or response revalidation controls when needed.
- Keep server-only database access and credentials inside server functions. Validate input and enforce authentication/authorization on the server for both queries and actions; client validation and query keys are not security boundaries.

## Forms

- Prefer uncontrolled/native forms when users primarily fill fields, values are needed only on submission, and they do not drive live UI or business logic. Give input/select/textarea controls normal `name` attributes; use HTML constraints and CSS validity pseudo-classes rather than per-input `value` signals and `onInput` synchronization. Use `defaultValue`/`defaultChecked` for initial native state where appropriate.
- In a custom submit handler, obtain the `HTMLFormElement` from `event.currentTarget`, check `form.checkValidity()`, and prevent business submission on failure. Read the payload with `new FormData(form)` only after validation passes; do not create field signals just to collect it. For custom error UI, use `novalidate` as described in the Web UI rules, not `reportValidity()`. Preserve router-managed native submissions when using its action form contract.
- Use field signals when the current value must be consumed live by other logic in the Solid reactive graph: search/query, conditional UI, dependent fields, live preview, cross-component sharing, persistence, URL synchronization, or asynchronous logic driven by that value. Being an input alone does not justify reactive application state.
- Keep ordinary form state at the form level where needed: submitting, server error, current step, submit attempted/submitted, or asynchronous workflow state. Do not default to per-field value, touched, or invalid signals when DOM values, `ValidityState`, and CSS pseudo-classes already meet the requirement.
- For errors after user interaction and all errors after a failed submit, use `:user-invalid` plus one form-level attempted/submitted signal or class; style with selectors such as `input:user-invalid, form.submitted input:invalid`. Do not mirror touched/invalid state per input.

## Verification

- Use existing test tooling to verify observable updates after props/signals change, staged setter visibility, list insertion/removal/reordering, and async loading/error transitions for the behavior changed. Use `flush` when synchronous assertions require committed writes; include cleanup/disposal and SSR hydration checks when applicable.
- Verify development diagnostics and production client/server builds for runtime/compiler/integration changes; a passing type check alone does not establish compatibility. Do not install a new test stack solely to follow this document.
- For form changes, verify native submission/validation behavior as well as any live reactive consumers. Ensure new guidance does not introduce per-field signals where the native form rules suffice.

# SolidJS 1 Development Rules

Apply to components, reactivity, UI state, forms, and data flow targeting SolidJS 1. Follow the framework-independent native state, accessibility, browser-target, and validation rules in [Web platform good practices](../web-platform/good-practices.md).

## Version and package boundaries

- Use Solid 1 APIs and execution semantics, not React patterns. Verify the installed runtime, compiler, and integrations against matching Solid 1 documentation. Do not upgrade dependencies outside the task’s scope.
- Import reactive primitives and `JSX`/`ComponentProps` types from `solid-js`, store utilities from `solid-js/store`, and web rendering APIs from `solid-js/web`. Use `jsxImportSource: "solid-js"` and compatible `vite-plugin-solid` tooling where applicable. Verify third-party library compatibility.

## Reactive state ownership

- Prefer declarative code. Use signals or other appropriate Solid APIs when they make state, dependencies, and UI behavior more declarative than imperative listeners or DOM mutation. Do not reject an API merely because it adds reactive state; preserve clear state ownership, cleanup, correctness, and acceptable performance, and avoid redundant mirrors or abstractions that only appear declarative.
- Do not mechanically avoid signals. Prefer a signal when it materially simplifies dependent fields, complex listeners, or imperative DOM coordination with acceptable performance cost. Judge the final implementation and state ownership, not signal count. A password signal driving an escaped confirmation pattern is appropriate without controlling every input or maintaining per-field validity signals.

- Use each signal for a genuinely independent reactive/application state boundary. Independently changing application state consumed by other reactive computations or UI belongs in signals; do not copy browser-owned or DOM state into the Solid reactive graph merely for styling or submission.
- Derive values from existing reactive state with a plain derived accessor, or `createMemo` when caching has value. Keep memo computations pure; do not maintain derivable duplicate state through synchronized signals or effects.
- Minimize duplicate state and unnecessary reactive dependencies, not signal count. Do not combine unrelated state into one large object signal to reduce the count; use stores for structured data needing property-level updates.
- Avoid bidirectional synchronization between native/DOM state and signals. Use Solid as the authoritative owner only when application integration requires it, rather than maintaining two sources of truth.

## Components and reactive reads

- Treat component bodies as one-time setup, not repeated render functions. Read changing signals and props inside JSX or tracked computations; a top-level `const doubled = count() * 2` is only a snapshot. A derived accessor such as `() => count() * 2` stays reactive only when called in a tracking scope. Use `untrack` narrowly for intentional one-time reads.
- When a child prop's contract is a value, read the signal in the JSX attribute expression, such as `<User id={id()} />`; consumers read `props.id` without knowing whether the source is a signal. Do not first capture the value in a setup-time local. Pass an accessor only when the component's explicit contract requires deferred reads.
- Preserve reactive prop access: read `props.name` rather than destructuring props, copying them with plain object spread, or assigning their values to setup-time locals. Use `splitProps` to separate and forward props and `mergeProps` for reactive composition and defaults.
- Prefer `<Show>` for conditional subtrees and `<Switch>`/`<Match>` for multiple branches. Simple inline conditions are valid; do not rewrite them mechanically or claim they are inherently non-reactive.
- Prefer `<For>` for dynamic lists whose item identities should be preserved; its item is a value and its index is an accessor. Use `<Index>` when positions are stable but their values change; its item is an accessor and its index is a stable number. Do not default to `.map()` for reactive list rendering.
- Provide context through `<Context.Provider value={value}>`. Use `classList` for conditional classes and refs for imperative element integration; preserve ref initialization timing.
- Fixed business forms must be explicit: compose simple controls and field-group components. Never generate them from configuration arrays, schemas, or field descriptors, or build a parameter-switched universal form, even when that pattern is an existing convention; rewrite such implementations. Dynamic rendering remains appropriate for actual dynamic data.
- Keep components focused and follow existing naming, typing, and module conventions. Do not mandate per-component directories, barrel exports, renderless components, or new state libraries without a concrete need.

## Effects, updates, and lifecycle

- Reserve `createEffect(() => { ... })` for external-system synchronization. It tracks synchronous reactive reads in its callback. Use `on` for explicit dependencies or `untrack` for intentional nontracking reads; do not hide required dependencies.
- Register cleanup with `onCleanup` inside an effect for cleanup before reruns and disposal; returning a function from `createEffect` does not register cleanup. Use `onMount` for nontracking client mount work and owner-scoped `onCleanup` for component/root resources.
- Read reactive dependencies before the first `await`; later reads are not tracked by the original computation. Do not rely on async effects to discover dependencies or automatically cancel external work.
- Avoid feedback loops and write-back derivations. Invoke setters from event handlers, actions, or effect functions, not component bodies or memo computations. Functional setters support previous-value updates but do not make arbitrary feedback loops safe.
- Update object/array signals through their setter with a new reference. Use `createStore` from `solid-js/store` with path setters, or `produce` for draft-style updates. Do not mutate the exposed store directly; use `unwrap` when a non-proxy representation is needed, noting that it is not an independent deep copy.
- Signal writes are synchronous; a read after a setter sees the updated value. Use `batch` when multiple writes should defer downstream computations until the group completes. Preserve built-in batching and distinguish initial effect scheduling from signal visibility.
- Async work does not retain a tracking scope or batch across `await`. Read required inputs before awaiting, group subsequent writes explicitly when needed, and handle obsolete results and cleanup according to the workflow.

## Async data, errors, and rendering

- Model asynchronous data with `createResource(source, fetcher)` when its loading and refetch contracts fit. Put reactive request inputs in the source; do not expect reactive reads inside the fetcher to establish source dependencies. Do not use an async `createMemo` as an automatically resolved resource.
- Use `<Suspense>` for pending resource reads and `<ErrorBoundary>` for failures in its subtree. An `ErrorBoundary` function fallback receives the error value and a reset function, not an error accessor. Handle empty and successful data explicitly.
- Use resource loading/state information and `refetch` or `mutate` according to the required behavior. Deliberately choose whether pending updates show previous data or a fallback, and verify the relevant resource and Suspense behavior.
- Stale-result handling does not cancel network work. When cancellation is needed, abort obsolete requests and dispose outstanding work using `AbortController` and appropriate lifecycle cleanup.
- Use boundaries for failures in their reactive subtree, not as a substitute for handling event-handler failures or detached async work. Catch and report those failures at their own boundary.
- Use `lazy` from `solid-js` with dynamic imports for justified route or heavy-component splitting, and `<Dynamic component={...}>` from `solid-js/web` for runtime-selected components. Use existing tooling and measurements before adding virtualization, throttling, memoization, or dependencies.
- For SSR, keep server and initial client output consistent. Isolate browser-only APIs behind client-safe lifecycle conventions, and do not keep per-user mutable state in server module globals. Use the rendering/hydration API required by the integration and retain and call the disposer returned by client `render`.
- Prefer normal JSX text rendering for untrusted content. Use `innerHTML` only with trusted or appropriately sanitized HTML. Client-exposed environment variables are not secret storage.

## Router and server data flow

Apply this section only when a Solid 1-compatible router/fullstack integration is present. Verify its installed APIs and adapters; do not infer compatibility from similar names or add a framework solely to follow this document.

- Follow the installed router’s route configuration and data-loading APIs. Reuse supported cached queries between route preload and component reads when their contracts support deduplication; do not assume every router version has the same query helpers.
- Preserve reactive route parameter reads and deliberate preload concurrency. Do not await preload work merely to gate rendering when the integration supports starting it early and consuming readiness through its async data boundary.
- Use the router’s supported mutation/submission flow and cache revalidation APIs. Preserve native form behavior where its action contract requires it; do not duplicate mutation workflows or bypass required revalidation.
- Keep server-only database access and credentials inside server functions. Validate input and enforce authentication/authorization on the server for both queries and actions; client validation and query keys are not security boundaries.

## Forms

- Prefer uncontrolled/native forms when users primarily fill fields, values are needed only on submission, and they do not drive live UI or business logic. Give input/select/textarea controls normal `name` attributes; use HTML constraints and CSS validity pseudo-classes rather than per-input value signals and `onInput` synchronization. Initialize native values and checked state using supported Solid 1 bindings without introducing reactive mirrors.
- In a custom submit handler, obtain the `HTMLFormElement` from `event.currentTarget`, check `form.checkValidity()`, and prevent business submission on failure. Read the payload with `new FormData(form)` only after validation passes; when the triggering submit button's `name`/`value` belongs in the payload, pass the actual submitter with `new FormData(form, event.submitter)` and handle a null submitter, empty values, and target-browser support as described in the Web platform rules. Do not create field signals just to collect it. For custom error UI, use `novalidate` as described in the Web platform rules, not `reportValidity()`. Preserve router-managed native submissions when using its action form contract.
- Use field signals when the current value must be consumed live by other logic in the Solid reactive graph: search/query, conditional UI, dependent fields, live preview, cross-component sharing, persistence, URL synchronization, or asynchronous logic driven by that value. Being an input alone does not justify reactive application state.
- Keep ordinary form state at the form level where needed: submitting, server error, current step, submit attempted/submitted, or asynchronous workflow state. Do not default to per-field value, touched, or invalid signals when DOM values, `ValidityState`, and CSS pseudo-classes already meet the requirement.
- For errors after user interaction and all errors after a failed submit, use `:user-invalid` plus one form-level attempted/submitted signal or class; style with selectors such as `input:user-invalid, form.submitted input:invalid`. Do not mirror touched/invalid state per input.

- For native numeric DOM properties, do not assume JSX `undefined` removes the attribute: Solid may call the property setter. In Firefox, `<progress value={undefined}>` can throw because the value is non-finite. Render indeterminate progress without a `value` binding and determinate progress with a finite number; check installed JSX types before recommending an attribute-binding escape. Validate unknown → known → unknown transitions in a real browser when available.

## Verification

- Use existing test tooling to verify observable updates after props/signals change, list insertion/removal/reordering, and async loading/error transitions for the behavior changed. Account for initial effect scheduling and await actual async work; include cleanup/disposal and SSR hydration checks when applicable.
- Verify development diagnostics and production client/server builds for runtime/compiler/integration changes; a passing type check alone does not establish compatibility. Do not install a new test stack solely to follow this document.
- For form changes, verify native submission/validation behavior as well as any live reactive consumers. For submitter-dependent submissions, verify the submitter's `name`/`value` entry, a null submitter, empty-string values, and target-browser compatibility. Ensure new guidance does not introduce per-field signals where the native form rules suffice.

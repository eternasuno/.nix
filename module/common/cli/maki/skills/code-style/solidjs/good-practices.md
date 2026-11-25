# SolidJS 2.0 Development Rules

Apply to components, reactivity, UI state, forms, and data flow targeting SolidJS 2.0. Follow the framework-independent native state, accessibility, browser-target, and validation rules in [Web platform good practices](../web-platform/good-practices.md).

## Installed package docs (read proactively)

When working in a project with Solid 2.0 packages installed, proactively read the package docs in `node_modules` (they match the installed runtime) and follow any project-root `AGENTS.md`:

- `node_modules/solid-js/CHEATSHEET.md` — Read before the first edit for 2.0 imports, primitives, and the differences section at the end.
- `node_modules/solid-js/skills/solid-2.0/SKILL.md` — Read before the first edit for the run-once component model and where reads and writes may happen.
- `node_modules/solid-js/skills/reactivity-diagnostics/SKILL.md` — Read whenever a bracketed diagnostic code (such as `[REACTIVE_WRITE_IN_OWNED_SCOPE]` or `[STRICT_READ_UNTRACKED]`) appears in console output or tests.
- `node_modules/@solidjs/diagnostics/skills/agent-loops/SKILL.md` — Read when verifying a reactive change to capture scope re-runs, attribution, and rerun-budget assertions.
- `node_modules/@solidjs/web/skills/server-components/SKILL.md` — Read when writing `"use server"` components for server markup vs. client slot boundaries and binding rules.

When `node_modules` is unavailable or deeper reference is needed, consult `https://docs.solidjs.com/llms.txt` (index), `https://docs.solidjs.com/llms-small.txt` (compact rules and exports), or append `.md` to any `docs.solidjs.com` page URL.

## Version, package, and tooling boundaries

- Use Solid 2.0 APIs and execution semantics, not React patterns or legacy Solid patterns. Verify installed package versions and third-party compatibility without upgrading dependencies outside task scope.
- Import reactive primitives, stores (`createStore`, `createProjection`, `reconcile`, `snapshot`), prop helpers (`merge`, `omit`), transitions/actions (`action`, `createOptimistic`, `createOptimisticStore`, `isPending`, `latest`, `refresh`, `affects`, `until`), lifecycle (`onSettled`, `onCleanup`), flow (`For`, `Repeat`, `Show`, `Switch`, `Match`), boundaries (`Loading`, `Errored`, `Reveal`), and `JSX`/`ComponentProps` types from `solid-js`.
- Import DOM/server rendering, hydration, and web helpers (`render`, `hydrate`, `renderToString`, `renderToStream`, `Portal`, `dynamic`, `clientOnly`, `isServer`) from `@solidjs/web`. Configure `"jsxImportSource": "@solidjs/web"` and `@solidjs/vite-plugin` where applicable.
- Name signals, memos, and effects with `{ name }` so diagnostic and attribution reports identify scopes clearly. Lint with `eslint-plugin-solid/configs/v2` (or `v2-strict`) when configured.

## Reactive state ownership

- Prefer declarative code. Use signals or stores when they make state, dependencies, and UI behavior clearer than imperative listeners or DOM mutation; judge state ownership and correctness, not signal count.
- Use each signal for a genuinely independent reactive state boundary. Do not copy browser-owned or DOM state into the Solid reactive graph merely for styling or form submission, and do not maintain bidirectional mirrors between DOM state and signals.
- Derive scalar values with a plain derived accessor or `createMemo` when caching has value, and derive structured collections with `createProjection` (keyed reconciliation such as `{ key: "id" }`). Keep memo/projection computations pure; never maintain derivable duplicate state through synchronized signals or effects.
- Do not combine unrelated state into one large object signal merely to reduce signal count; use `createStore` for structured data needing property-level updates.

## Components, props, and reactive reads

- Components run once; there is no re-render. Read reactive values (signals, memos, store properties, props) inside JSX, a `createMemo`, a `createEffect` compute function, or the function form of `createSignal`/`createStore`/`createProjection` — never at the top of a component body.
- Flow callbacks (`<For>`, `<Show>`, `<Match>`) are owners, not tracking scopes: read their accessor arguments inside JSX or a tracked computation, not at the top of the callback. Never use `untrack` to silence `[STRICT_READ_UNTRACKED]`; move the read into a tracking scope instead. Reserve `untrack` for intentional one-time reads.
- Read props via `props.name` inside tracked scopes; never destructure props (`function Comp({ name })`), spread them into plain objects, or snapshot them into setup-time locals. Pass values, not accessors, in JSX props (`<Child count={count()} />`); pass accessors to hooks/adapters (`useThing(() => props.id)`) so they read inside their own memos or effects. Use `merge` for reactive prop composition/defaults and `omit` to split and forward props.
- Use `<Show>` for conditional subtrees and `<Switch>`/`<Match>` for multiple branches; simple inline JSX conditions remain valid.
- Use `<For each={items()}>` for keyed lists (callback receives `(item, indexAccessor)`), `<For each={items()} keyed={false}>` when positions are stable and values change (callback receives `(itemAccessor, index)`), and `<Repeat count={n}>` for count-based iteration (`i` is a plain number). Do not default to `.map()` for reactive list rendering.
- Provide context with `<Context value={value}>`. Use `class={{ active: isActive() }}` or `class={["base", { active: isActive() }]}` for conditional classes, lowercase standard HTML attributes (`tabindex`), and `ref={...}` (element variable, callback, callback array, or `ref={factory(args)}`) for imperative element integration. Use stable event handlers (`onClick={(e) => cond() ? a(e) : b(e)}`) rather than conditional handler references (`onClick={cond() ? a : b}`), which bind once.
- Fixed business forms must be explicit: compose simple controls and field-group components. Never generate them from configuration arrays, schemas, or field descriptors, or build a parameter-switched universal form, even when that pattern is an existing convention; rewrite such implementations. Dynamic rendering remains appropriate for actual dynamic data.
- Keep components focused and follow existing naming, typing, and module conventions. Do not introduce per-component directories, barrel exports, renderless wrappers, or extra state libraries without a concrete need.

## Effects, writes, stores, and lifecycle

- Reserve `createEffect(compute, apply)` for external-system synchronization and imperative side effects. Always pass two functions (single-argument `createEffect` is an error): `compute` performs tracked reactive reads and returns a value; `apply` receives it untracked, performs side effects, and may return a cleanup function (or pass `{ effect, error }` to intercept errors).
- Use `onSettled(() => { setup(); return cleanup; })` for post-settle client setup and cleanup; reserve `onCleanup` for owner disposal or custom reactive primitives. Do not assume a JSX `ref` callback runs after dynamic attributes, connected layout, or children are initialized; measure or initialize layout-dependent DOM work in `onSettled`. For virtualized lists, preserve resize tracking and verify measured row heights after scrolling/reuse before changing estimates or clipping overflow.
- Read reactive inputs in `compute` or before the first `await`; reads after `await` are not tracked, and stale-result handling does not cancel network requests.
- Never write a signal or store inside a `createMemo`, an effect's `compute` function, or a component body. Write from event handlers, `onSettled`, `createEffect`'s apply phase, or `action`s.
- Signal and store writes batch per microtask; reads immediately after a setter return the old value until the next microtask or `flush()`. Call `flush()` before synchronous code or test assertions that must read updated values immediately (never call `flush()` inside an `action`).
- Write stores through the draft setter: `setStore(s => { s.user.name = "Ada"; })`. Never mutate an exposed store proxy directly. Use `createProjection` for read-only derived stores with keyed reconciliation, `reconcile` to merge fresh data into a store subtree by key, and `snapshot` when a plain untracked copy is needed.

## Async reactivity, boundaries, mutations, and SSR

- Model async derived state with async `createMemo(() => fetchX(id()))`, `createStore(async () => ...)`, `createProjection`, or `createDeferred` (keeps the previous value while refetching).
- Wrap async reads in `<Loading fallback={...}>` (use `on={deps}` when the fallback should re-arm on input changes) and coordinate sibling reveal order with `<Reveal>`. Use `isPending(() => ...)` and `latest(...)` for transition state rather than manual loading flags.
- Catch subtree failures with `<Errored fallback={(err, reset) => ...}>`, where `err` is an error accessor (`err()`) and the boundary recovers automatically when reset or resolved. Handle event-handler and detached async errors at their own boundaries.
- Coordinate mutations and optimistic UI with `action(function* (...) { ... })`, `createOptimistic`, `createOptimisticStore`, `refresh`, `affects`, and `until`. Cancel obsolete requests with `AbortController` and cleanup when superseded or disposed.
- Use `lazy` from `solid-js` with dynamic imports for justified route or heavy-component splitting, and `dynamic(() => ...)` from `@solidjs/web` for reactive component selection. Measure with existing tooling before adding virtualization, throttling, or extra dependencies.
- For SSR, keep server and initial client output consistent. Keep browser-only APIs (`window`, `document`, `localStorage`) out of module scope and render paths; isolate them inside `onSettled`, `createEffect`'s apply phase, `!isServer` guards (`isServer` from `@solidjs/web`), or `clientOnly(() => import(...))`. Never keep per-user mutable state in module-scope signals or stores on the server. Retain and call the disposer returned by `render` (`@solidjs/web`).
- Prefer normal JSX text rendering for untrusted content; use `innerHTML` only with trusted or sanitized HTML. Client-exposed environment variables are not secret storage.

## Router and server data flow

Apply this section only when `@solidjs/router` or Solid server functions are present. Verify installed exports and adapters rather than guessing APIs.

- Follow `@solidjs/router` APIs (`createRouter`, `defineRoute`, `defineRoutes`), data caching (`query`, `liveQuery`, `revalidate`), and form mutations (`formAction`, `useSubmissions`). Reuse cached queries between route preload and component reads when their contracts support deduplication.
- Preserve reactive route parameter reads and non-blocking preload concurrency through `<Loading>` boundaries rather than awaiting preloads just to gate rendering.
- Keep server-only database access and credentials inside `"use server"` functions. Validate input and enforce authentication/authorization on the server for every query and mutation; client validation and query keys are not security boundaries.

## Forms

- Follow native form, constraint validation, `FormData(form, event.submitter)`, and `:user-invalid` / `form.submitted :invalid` rules in [Web platform good practices](../web-platform/good-practices.md). Preserve router `formAction` and progressive-enhancement submission contracts.
- Use field signals or stores only when values drive live computations in the Solid reactive graph (search/query, conditional UI, dependent fields, live preview, cross-component sharing, URL sync, or async work). Keep workflow state (submitting, server error, current step, submit-attempted) at the form level rather than mirroring value/touched/invalid signals per input.
- Do not assume JSX `undefined` removes a native numeric DOM property: Solid may invoke the property setter (for example, `<progress value={undefined}>` throws in Firefox). Render indeterminate `<progress>` without a `value` binding and determinate progress with a finite number, and verify transitions in a real browser when available.

## Verification and diagnostics

- Treat every bracketed runtime diagnostic warning (`[STRICT_READ_UNTRACKED]`, `[REACTIVE_WRITE_IN_OWNED_SCOPE]`, etc.) as a defect to look up in `node_modules/solid-js/skills/reactivity-diagnostics/SKILL.md` and fix at its cause; never suppress diagnostics.
- Run `eslint-plugin-solid/configs/v2` (or `v2-strict`), existing tests, and production client/server builds when applicable; a passing typecheck alone does not verify reactive or SSR compatibility.
- In tests, call `flush()` after writes or synthetic events before asserting updated values or DOM, and verify observable updates, list insertion/removal/reordering, async loading/error transitions, cleanup/disposal, and SSR hydration. Use `@solidjs/diagnostics` (`captureArtifact`, `expectNoDiagnostics`, `expectRerunBudget`, or `@solidjs/diagnostics/vitest` matchers `toHaveNoDiagnostics` and `toStayWithinRerunBudget`) or `POST /__solid/diagnostics` (`begin`, `end`, `active`, `whyDidRun`, `costs` when `diagnostics: true` is enabled on `@solidjs/vite-plugin`) to verify reactive scopes and re-run budgets with evidence.

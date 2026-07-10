# Code Conventions

General code conventions that apply across all languages.

## Core Principles

### Single Parameter

Every function takes exactly one parameter:
- Logically related inputs → group into a single record/struct parameter
- Independent dependencies → inject via currying

### Pure Functions

Prefer pure functions — deterministic, no side effects, no external dependencies.
When side effects are unavoidable, inject dependencies via currying so the core logic remains testable.

### Function & File Size

- **Function ≤ 20 lines** — if longer, split into smaller functions
- **File ≤ 150 lines** — if larger, split into multiple focused files
- Prefer clarity over arbitrary splitting

### Self-Documenting Names

Function and variable names must describe what they do or represent without requiring the reader to trace the implementation:
- `addMonthToDate(month, date)` not `addToDate(date, month)`
- `isActiveClient(client)` not a bare `isActive(client)` that checks unrelated state

### Encapsulate Conditionals

Wrap complex boolean expressions into named functions so the intent is explicit:

```typescript
// Bad
if (fsm.state === 'fetching' && isEmpty(listNode)) { ... }

// Good
const shouldShowSpinner = (fsm: Fsm, listNode: List) =>
  fsm.state === 'fetching' && isEmpty(listNode);
if (shouldShowSpinner(fsm, listNode)) { ... }
```

### Avoid Negative Conditionals

Name functions for the positive case:

```typescript
// Bad
if (!isDOMNodeNotPresent(node)) { ... }

// Good
if (isDOMNodePresent(node)) { ... }
```

### Remove Dead Code

Dead code is as harmful as duplicate code. Delete unused functions, unreachable branches, and commented-out code.

### Comments

Comments are an apology, not a requirement. Good code documents itself.

- **Only comment business-logic complexity** — never restate what the code clearly says
- **No commented-out code** — delete it; version control has the history
- **No journal comments** — `git log` tracks authorship and dates
- **No positional markers** — `// ----- ` banners add noise, not structure

## Language-Specific Conventions

- [TypeScript](typescript.md)
- [Effect-TS](effect-ts.md)
- [CSS States](css-states.md) — when working on frontend UI

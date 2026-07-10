# TypeScript Code Conventions

## Arrow Functions
All functions use arrow syntax.

## Single Parameter
Group inputs into `XxxParams` records or inject via currying.

## Pure Functions
Inject side-effecty dependencies via currying: `fn = (mainArg) => (deps) => result`.

## Imports

- No `.js` extension in local imports (`from './foo'` not `from './foo.js'`)
- Use `import type` for type-only imports
- Group: external libs → internal modules → types

## No Barrel Files

Do not use `index.ts` barrel files. To export a directory, create a file at the parent level with the same name as the directory (e.g., `entity.ts` to export `entity/`).

## Control Flow

All `if`, `for`, `while`, and similar control flow statements must use `{}` braces even for single-statement bodies.

## Export Spacing

Each `export` expression must be followed by a blank line.

## Naming

| Category | Convention | Example |
|----------|-----------|---------|
| Functions | camelCase | `fetchUser`, `parseConfig` |
| Types | PascalCase | `User`, `ConfigOptions` |
| Record params | `XxxParams` | `ParseConfigParams`, `FetchUserParams` |
| Deps types | `XxxDeps` | `FetchUserDeps` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `DEFAULT_TIMEOUT` |
| Enums | PascalCase | `HttpMethod`, `ColorScheme` |

## Default Parameters

Use default parameters instead of `||` short-circuiting:

```typescript
// Bad
function createMicrobrewery(name) {
  const breweryName = name || 'Hipster Brew Co.';
}

// Good
function createMicrobrewery(name = 'Hipster Brew Co.') {
  // ...
}
```

Default parameters only replace `undefined` — `''`, `false`, `0`, `null`, and `NaN` pass through unchanged.

## No Boolean Flags

A boolean flag in a function signature signals it does more than one thing. Split instead:

```typescript
// Bad
function createFile(name: string, temp: boolean) { ... }

// Good
function createFile(name: string) { ... }
function createTempFile(name: string) { ... }
```

## Functional over OOP

- `type` not `interface` for object shapes
- No `class`, no `this`
- Use discriminated unions over inheritance

## Pipeline over Imperative Loops

Prefer `.map`, `.filter`, `.reduce` chains over `for` / `for..of` loops:

```typescript
// Bad
let totalLines = 0;
for (const p of programmers) { totalLines += p.linesOfCode; }

// Good
const totalLines = programmers.reduce((sum, p) => sum + p.linesOfCode, 0);
```

## Caller Above Callee

When function A calls function B, keep A above B in the source file so the code reads top-down like a newspaper.

## Imports

Grouped by type then alphabetically:
1. External libs
2. Internal modules
3. Types (use `import type` for type-only imports)

```typescript
import { z } from 'zod';
import { fetchUser } from '@/services/user';
import type { User, UserParams } from '@/types/user';
```

# TypeScript Code Conventions

## Arrow Functions
All functions use arrow syntax.

## Single Parameter
Group inputs into `XxxParams` records or inject via currying.

## Pure Functions
Inject side-effecty dependencies via currying: `fn = (mainArg) => (deps) => result`.

## Naming

| Category | Convention | Example |
|----------|-----------|---------|
| Functions | camelCase | `fetchUser`, `parseConfig` |
| Types | PascalCase | `User`, `ConfigOptions` |
| Record params | `XxxParams` | `ParseConfigParams`, `FetchUserParams` |
| Deps types | `XxxDeps` | `FetchUserDeps` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRIES`, `DEFAULT_TIMEOUT` |
| Enums | PascalCase | `HttpMethod`, `ColorScheme` |

## Functional over OOP

- `type` not `interface` for object shapes
- No `class`, no `this`
- Use discriminated unions over inheritance

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

# Effect-TS Conventions

> **⚠️ API Stability Warning: Effect-TS evolves rapidly. Always use `@context7` or
> `@librarian` to verify API details against current documentation before writing
> Effect-TS code. The patterns below describe general conventions from real
> codebases but may reference older API shapes.**

## Core Setup

### Imports

```typescript
import { Effect, Schema, Option, DateTime, Duration } from 'effect';
```

Import `Schema` directly from `'effect'` — Effect re-exports `@effect/schema` under its own namespace.

### Effect Type Signature

```typescript
Effect<Success, Error, Requirements>
//                                        ^ Success comes FIRST
```

### Schema Type Extraction

Use `typeof X.Type`, never `Schema.Schema.Type<typeof X>`:

```typescript
const Feed = Schema.Struct({ id: Schema.String, title: Schema.NonEmptyTrimmedString });
type Feed = typeof Feed.Type;
```

## Entity Schemas

### Struct Pattern (not Class)

Entity schemas use `const X = Schema.Struct({...})`, not `Schema.Class`.

### Branded Entity IDs

Entity IDs carry a brand to prevent raw-string assignment:

```typescript
const FeedId = Schema.String.pipe(Schema.brand('FeedId'));
type FeedId = typeof FeedId.Type;
```

Import branded IDs across entity files for foreign key fields.

### Value-Objects with Brand

Any schema with semantic meaning or validation beyond its base type carries a `Schema.brand`.

### NonEmptyTrimmedString

Use `Schema.NonEmptyTrimmedString` (not `Schema.NonEmptyString`) for non-empty string fields — it rejects whitespace-only strings and auto-trims.

### Date/Time Fields

Use `Schema.DateTimeUtcFromSelf` (not `Schema.Date`) for UTC datetime fields.

### Recursive Schemas

Use `Schema.suspend(() => S)` to break circular type references:

```typescript
const JSONValue = Schema.Union(
  Schema.String,
  Schema.Number,
  Schema.Boolean,
  Schema.Null,
  Schema.Array(Schema.suspend(() => JSONValue)),
  Schema.Record({ key: Schema.String, value: Schema.suspend(() => JSONValue) })
);
```

## Port Definitions

```typescript
interface IFeedRepository {
  readonly findById: (id: FeedId) => Effect.Effect<Option.Option<Feed>, AppError, never>;
  readonly create: (data: CreateFeedParams) => Effect.Effect<Feed, AppError, never>;
  readonly delete: (ids: ReadonlyArray<FeedId>) => Effect.Effect<void, AppError, never>;
}

class FeedRepository extends Context.Tag('FeedRepository')<FeedRepository, IFeedRepository>() {}
```

- `interface IXxx` with `readonly` on all methods
- `class Xxx extends Context.Tag('Xxx')<Xxx, IXxx>(){}`
- Repository find methods return `Option.Option<Entity>` for not-found
- Repository `update` uses currying: `update(id: FeedId)(data: Partial<Encoded>)`

## AppError

Single tagged error type for all usecases, avoiding error-type proliferation:

```typescript
type ErrorCode = 'NOT_FOUND' | 'VALIDATION_ERROR' | 'CONFLICT' | 'INTERNAL_ERROR';

class AppError extends Data.TaggedError('AppError')<{
  readonly code: ErrorCode;
  readonly message: string;
}> {}
```

- Discrimination is via a `code` literal union
- No static factory methods
- No `cause` field

## Usecases

```typescript
export const createFeed = (input: CreateFeedInput) =>
  Effect.gen(function* () {
    const repo = yield* FeedRepository;
    const existing = yield* repo.findByName(input.name);
    if (Option.isSome(existing)) {
      return yield* Effect.fail(new AppError({ code: 'CONFLICT', message: 'Feed already exists' }));
    }
    const id = FeedId.pipe(StringEncoding.encode);
    const feed: Feed = { ...input, id };
    return yield* repo.create(feed);
  });
```

- Dependencies injected via `yield* Tag`, never via constructors
- Option None handling: prefer `Effect.flatten` + `Effect.catchTag('NoSuchElementException', ...)` over `if (Option.isNone)` branches

## Testing

```typescript
import { it } from '@effect/vitest';

it.effect('should create a feed', () =>
  Effect.gen(function* () {
    const repo = yield* FeedRepository;
    const result = yield* repo.create(mockFeedData);
    assert.deepStrictEqual(result.name, mockFeedData.name);
  }).pipe(Effect.provide(Layer.mergeAll(FeedRepositoryLive, ...)))
);
```

- `it.effect("should ...", () => Effect.gen(...))` from `@effect/vitest`
- Mock services via `Layer.succeed(Tag, mockImpl)` with stateless pure functions
- Test helper/factory functions go in `mock/` directory, not inline in test files

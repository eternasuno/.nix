# Go

Apply to Go source files, tests, modules, and Go tooling.

## Types, packages, and boundaries

- Keep package names short, lowercase, single-word nouns matching their directory name unless avoiding a standard-library or keyword collision (such as `package httpserver` in `internal/http`). Keep domain packages free of database, HTTP, and third-party adapter imports, and never import one adapter package from another.
- Define small consumer- or domain-owned interfaces where multiple implementations or test doubles cross a boundary; return concrete types from constructors. Do not export preemptive provider-side interfaces for single concrete types.
- Make zero values useful where practical, or provide a `New...` constructor when invariants, default bounds, or background resources must be initialized.
- Decode and normalize boundary primitives (such as URLs, sort orders, retention counts, and folder names) once into distinct domain types or constants rather than re-parsing raw strings across layers.

## Errors, secrets, and resource lifetimes

- Wrap internal errors with context (`fmt.Errorf("step: %w", err)`) when callers inspect causes via `errors.Is` or `errors.As`. At trust or persistence boundaries, strip URL userinfo (`user:pass@`) and redact secret values (passwords, API keys, session secrets) before formatting, storing, or logging error strings.
- Close every `io.Closer` (`http.Response.Body`, `sql.Rows`, archive entries, files) after checking the open error, and check `rows.Err()` after row iteration. Never ignore `Close()` errors on buffered writers (`zip.Writer`, files, database handles) where `Close` flushes final bytes.
- Pass `context.Context` as the first argument of blocking or I/O operations. Never pass an HTTP request context (`r.Context()`) into a background job that outlives the response (such as a `202 Accepted` worker); derive background work from an application-owned context canceled on shutdown and wait for workers before closing stores.

## Concurrency, I/O, and media bounds

- Bound every outbound network request, worker pool, and in-memory buffer: set `http.Server` (`ReadHeaderTimeout`, `ReadTimeout`) and `http.Client` / `net.Dialer.Control` timeouts, cap response reads with `io.LimitReader`, and size whole-operation connection deadlines (such as SMTP `DATA` uploads) for full payload transfer (including Base64 MIME expansion) plus remote processing before the final protocol ACK.
- Before decoding remote images into memory, call `image.DecodeConfig` to read header dimensions without allocating pixel memory, skip images that already fit dimension and byte thresholds, and reject images exceeding safe dimension or total-pixel caps to prevent decompression bombs.
- In pixel-processing loops, read and write concrete `Pix` slices directly rather than calling interface methods (`SetRGBA`, multi-sample `At`) per pixel, which multiply instrumentation overhead under `go test -race`.
- Guard shared mutable state with an explicit `sync.Mutex` or channel owner, and give every spawned goroutine an explicit stop condition and shutdown wait (`sync.WaitGroup`).

## Tooling, embedding, and testing

- Track Go CLI tools (such as `golangci-lint`) via `go.mod` `tool` directives (`go get -tool`) and invoke them with `go tool <name>` so tool versions remain reproducible without host-package drift.
- When a package uses `//go:embed`, ensure the embedded directory exists before running `go build`, `go vet`, or `go test ./...`.
- Keep both production and test functions within the repository's `funlen` and `gocognit` limits, follow the mandatory blank-line rules together with `gofmt`, and use file-backed `t.TempDir()` databases rather than `:memory:` when testing SQLite WAL mode, pragmas, or multi-connection pools.

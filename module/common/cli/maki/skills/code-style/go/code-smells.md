# Go Code Smells

Apply to Go source, tests, modules, and Go tooling. Check runtime lifetimes, resource bounds, and concurrency as well as static types.

- **Request context passed to background work:** flag goroutines or queued jobs that retain `r.Context()` after an HTTP handler returns, or background workers that lack an application-context cancellation and `WaitGroup` drain before `sql.DB.Close()`.
- **Leaked closers or ignored flush-on-close errors:** check `http.Response.Body`, `sql.Rows` (including missing `rows.Err()`), and archive readers for missing `Close()`, and flag ignored `Close()` errors on writable streams (`zip.Writer`, files) where final data is flushed on close.
- **Credential or secret leakage in errors and logs:** trace `err.Error()`, `url.URL` strings (`user:pass@`), and SMTP/API credentials into HTTP responses, persisted error columns, or `slog` fields. Verify redaction before error text leaves the adapter.
- **Under-sized connection deadlines for bulk transfers:** inspect `net.Conn.SetDeadline` or client timeout options (such as SMTP `Send`) where a single short deadline covers both bulk payload upload (Base64 expansion) and remote server processing before the final `250 OK` read.
- **Unbounded in-memory decoding:** flag `io.ReadAll` without `io.LimitReader` on network streams, and `image.Decode` on untrusted images without a prior `image.DecodeConfig` dimension and total-pixel check against decompression bombs.
- **Per-pixel interface calls in hot loops:** flag inner image loops that invoke interface methods or bounds-checked setters repeatedly per pixel instead of indexing concrete `Pix` slices, causing multi-second slowdowns under `go test -race`.
- **Preemptive interfaces or adapter cross-imports:** flag single-implementation interfaces exported by provider packages without a consumer boundary, domain packages importing infrastructure packages, or adapter packages importing sibling adapters.
- **In-memory SQLite for WAL or pool behavior:** flag `:memory:` SQLite DSNs in tests that exercise WAL mode, connection pool isolation, or per-connection pragmas (`foreign_keys`, `busy_timeout`); require `t.TempDir()` file paths instead.

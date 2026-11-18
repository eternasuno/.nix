# Obscura CLI reference

Read installation preparation only when the executable is unavailable; read command examples only for the relevant operation. Verify syntax against the active version.

If unavailable, use a task-local release binary:

1. Detect the operating system and architecture (`uname -s` and `uname -m`, or the Windows equivalents).
2. Select a specific release tag and matching archive from trusted release metadata; record the tag and asset instead of using an unpinned latest-download URL. Prefer the normal rendering archive; select `-stealth` only when explicitly requested, and `-no-render` only when rendering is unnecessary.
3. Download to a secure temporary directory and verify the official SHA-256 digest before extracting. Reject missing or mismatched digests, archive path traversal, absolute paths, and unexpected symlinks.
4. Keep both `obscura` and `obscura-worker` together; `scrape` may require the worker.
5. Run the temporary executable by absolute path and verify `--version` and `--help`. Clean up the temporary directory after the task.
6. Install persistently only after explicit confirmation. Do not silently overwrite an existing executable or modify PATH/shell profiles; report every path changed.

## Command-line usage

Inspect the installed version's authoritative options first:

```bash
obscura --help
obscura <subcommand> --help
```

Common operations (verified against 0.2.2):

```bash
obscura fetch https://example.com --dump text
obscura fetch https://example.com --eval "document.title"
obscura fetch https://example.com --screenshot page.png
obscura --stealth fetch https://example.com --screenshot page.png
obscura scrape https://example.com/a https://example.com/b
obscura serve --port 9222
obscura mcp
obscura mcp --http --port 3000
```

- `fetch` loads one URL. `--dump` accepts `html|text|links|markdown|original|assets|cookies`; `--eval` runs JavaScript; `--screenshot` needs a build with the `render` feature. `--file <list>` switches to raw batch mode.
- `scrape` takes URLs as arguments and renders each one (`--eval`, `--format`, `--concurrency`).
- `serve` exposes a Chrome DevTools Protocol endpoint for Puppeteer or Playwright clients. It can control the browser and read page data.
- `mcp` starts the MCP browser server over stdio; `--http` serves it over HTTP.
- `serve` and `mcp --http` bind `127.0.0.1` by default. Do not pass a non-loopback `--host` unless the user explicitly authorizes authenticated remote access.
- Loopback, RFC1918, and link-local targets are blocked by default. Use `--allow-private-network` only for user-requested local targets.
- `--stealth` requires a stealth release archive and must not be used to bypass access controls, CAPTCHAs, account limits, or site authorization.
- `--wait N` adds a fixed delay in seconds, `--wait-until` selects the readiness event, and `--timeout N` bounds navigation.

For any option not shown here, rely on the installed `--help` rather than assuming flags.

## CJK and other non-Latin text

Obscura's native renderer embeds only Latin fonts and ignores OS fonts/fontconfig, so non-Latin text renders as tofu (`□`) in screenshots, PDFs, and screencasts unless a webfont is injected. Text dumps are unaffected.

Workaround (verified on 0.2.2): inject an `@font-face` rule via `--eval` using a subset TTF as a `data:` URL and apply `*{font-family:ZH!important}`. The renderer skips faces whose `unicode-range` lacks ASCII, allows at most 16 faces, caps resources at 8 MiB compressed / 32 MiB decoded, and does not fetch `file://` font URLs. For larger fonts, dump HTML, add `<base href>` plus the style, and render the local `file://` page. After upgrading Obscura, inspect representative CJK output before dropping the workaround.

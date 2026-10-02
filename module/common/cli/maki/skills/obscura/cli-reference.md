# Obscura CLI reference

Read installation preparation only when the executable is unavailable; read command examples only for the relevant operation. Verify syntax against the active version.

If the command works, use the installed executable. Otherwise, prefer temporary task-local use; do not install persistently or modify PATH without explicit user confirmation:

1. Detect the operating system and architecture (`uname -s` and `uname -m`, or the Windows equivalents).
2. Select a specific release tag and matching archive from trusted release metadata; record the tag and asset instead of using an unpinned latest-download URL. Prefer the normal rendering archive; select `-stealth` only when explicitly requested, and `-no-render` only when rendering is unnecessary.
3. Download to a secure temporary directory and verify the official SHA-256 digest before extracting. Reject missing or mismatched digests, archive path traversal, absolute paths, and unexpected symlinks.
4. Keep both `obscura` and `obscura-worker` together; `scrape` may require the worker.
5. Run the temporary executable by absolute path and verify `--version` and `--help`. Clean up the temporary directory after the task.
6. Install persistently only after explicit confirmation. Do not silently overwrite an existing executable or modify PATH/shell profiles; report every path changed.

Use release binaries only; no source-build instructions are needed.

## Command-line usage

Inspect the installed version's authoritative options first:

```bash
obscura --help
obscura <subcommand> --help
```

Common operations:

```bash
obscura fetch https://example.com --dump text
obscura fetch https://example.com --eval "document.title"
obscura fetch https://example.com --screenshot page.png
obscura --stealth fetch https://example.com --screenshot page.png
obscura scrape urls.txt
obscura serve --port 9222  # bind to loopback only
obscura mcp
obscura mcp --http --port 3000  # bind to loopback only
```

- `fetch` loads one URL and can dump content, evaluate JavaScript, or capture a screenshot.
- `scrape` processes multiple URLs.
- `serve` exposes a Chrome DevTools Protocol endpoint for clients such as Puppeteer or Playwright; keep it on loopback because it can control the browser and read page data.
- `mcp` starts the MCP browser server over stdio; `--http` exposes it over HTTP and must remain loopback-only unless the user explicitly authorizes authenticated remote access.
- `--stealth` requires a stealth release archive and must not be used to bypass access controls, CAPTCHAs, account limits, or site authorization.
- Use `--wait N` for a fixed delay in seconds and `--timeout N` to bound navigation.

For any option not shown here, rely on the downloaded version's `--help` output rather than assuming flags.

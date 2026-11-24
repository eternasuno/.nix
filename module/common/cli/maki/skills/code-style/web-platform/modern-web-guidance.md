# Modern Web Guidance

Use when the project has a Node environment and the task implements a UI or platform capability that may have a newer native solution: dialogs, popovers, anchor positioning, view transitions, scroll-driven animation, forms and validation, dark mode, dates and timezones, HTML sanitization, container queries, or image and loading performance. Skip it for backend, infrastructure, tooling, or trivial copy changes.

The `modern-web-guidance` CLI returns curated guides maintained by the Chrome team, so it can be newer than model knowledge.

## Workflow

1. Search with a 2-5 word English query naming one platform capability or UI primitive, such as `light dismiss dialog`. Omit framework, library, and app names; split multi-feature tasks into separate searches. Translate intent into the implied primitive (`confirm dialog`, not `confirm destructive action`).
2. Retrieve the matching guide ids, plus a broader discipline guide (`html`, `css`, `js`, `forms`, `accessibility`, `performance`, `security`) when it applies. If output is saved to a file, read the whole file.
3. If results are weak, rephrase once with the concrete component noun; if still unmatched, proceed without a guide rather than forcing an unrelated one.
4. Apply the guide with the project's browser support policy. Baseline Widely available needs no fallback; otherwise follow the guide's fallback or feature detection.

## Running

- Prefer `pnpx modern-web-guidance@latest <command>` when the project uses pnpm; otherwise `npx -y modern-web-guidance@latest <command>`. Commands are `search "<query>"` and `retrieve "<id>[,<id>]"`.
- Use the project's own installed copy only when the project already depends on it. Do not add it to project dependencies without authorization.
- It needs outbound network access. If it hangs offline, retry with `npx --offline`. Set `NPM_CONFIG_CACHE` to a writable directory when `~/.npm` is read-only.
- Do not run `legacy-scan` unless the user asks for an open-ended modernization or legacy-pattern audit; then verify each finding before editing.
- Do not add a guidance section to the final response unless the user asks for one; mention briefly which guides shaped the change.

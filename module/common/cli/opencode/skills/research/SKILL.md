---
name: research
description: Investigate a question against high-trust primary sources. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated. Do not use for codebase-local questions that can be answered by grepping or reading local files.
disable-model-invocation: true
---

Spin up a **background agent** to do the research so you keep working while it reads.

Its job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not secondary write-ups. Follow every claim back to the source that owns it.
2. Use `@librarian`, context7, and webfetch as the main tools for gathering information.
3. Write the findings to a single Markdown file under `.slim/research/` with a descriptive filename. Include citations for each claim.
4. Before writing, ensure `.slim/` is in `.gitignore` (add if missing). Save findings to `.slim/research/<filename>.md`. If `.slim/research/` doesn't exist, create it.

When done, summarize the findings in this conversation and reference the file path so the user can read the full report.

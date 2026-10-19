---
name: code-style
description: Design structure, implement, refactor, fix, test, or configure code, and review code for correctness, security, performance, compatibility, maintainability, and explicit style rules. Use for architecture decisions, coding, and read-only or authorized fix-up reviews.
---

# Code Style

Use one set of standards for structural design, implementation, and review. Prefer the simplest readable structure and final code that satisfy actual requirements, not the fewest lines or smallest diff. Stay within the affected execution path; do not refactor unrelated code.

## Modes and authority

- Design and implementation: resolve relevant responsibilities, contracts, and lifetimes as part of coding. Compare meaningful alternatives when a structural decision is needed; do not impose a separate architecture phase on local edits. A design-only request does not authorize implementation.
- Review: inspect and report, read-only by default. A request to review does not authorize fixes, dependency changes, or configuration changes.
- Review and fix: implement verified improvements within the user's authorized scope, then validate them. Do not request approval again for already authorized changes.

Investigate repository-answerable facts. Resolve material product uncertainty with the user rather than inventing requirements; choose reversible local technical details from evidence.

## Workflow

1. Establish scope and mode. Read affected code, callers, tests, manifests, installed versions, and governing instructions. Preserve unrelated user changes and the Git staging state.
2. Load the matching references below. For implementation or design, read good practices; for review, read code smells. When fixing a finding or needing its intended replacement, read the corresponding good practices. Do not load every domain by default.
3. Trace relevant behavior, dependencies, data flow, failures, and resource ownership. Reuse suitable existing structure. Introduce abstractions only for current responsibilities, contracts, or consumers.
4. Implement authorized changes or verify review candidates. Preserve security, accessibility, compatibility, data integrity, required error behavior, cancellation, cleanup, side-effect ordering, transactions, and performance constraints.
5. Derive commands and tool versions from repository configuration and use its declared development environment. Run checks proportional to affected behavior and risk. Inspect the final diff, including the mandatory blank-line rules in general practices; distinguish existing failures from regressions.
6. Report actual checks, skipped checks, unresolved risks, and scope limits. Do not describe static inspection as runtime, browser, performance, or security verification.

## Conditional references

References are additive. For example, a Solid form can need general, web-platform, and SolidJS rules; add testing or TypeScript when those concerns are being changed or reviewed.

| Domain and reading condition | Design and implementation | Review |
| --- | --- | --- |
| General: all code tasks | [Good practices](general/good-practices.md) | [Code smells](general/code-smells.md) |
| Architecture: responsibilities, workflows, contracts, representations, dependencies, or resource ownership | [Good practices](architecture/good-practices.md) | [Code smells](architecture/code-smells.md) |
| TypeScript: TS/TSX or JavaScript governed by TypeScript tooling | [Good practices](typescript/good-practices.md) | [Code smells](typescript/code-smells.md) |
| Effect: code or tests using `effect` | [Good practices](effect/good-practices.md) | [Code smells](effect/code-smells.md) |
| Testing: tests, coverage, fakes, or test boundaries | [Good practices](testing/good-practices.md) | [Code smells](testing/code-smells.md) |
| Web platform: HTML, CSS, DOM, forms, browser behavior, or accessibility | [Good practices](web-platform/good-practices.md) | [Code smells](web-platform/code-smells.md) |
| SolidJS: Solid 1 components, reactivity, lifecycle, or framework data flow; verify target version | [Good practices](solidjs/good-practices.md) | [Code smells](solidjs/code-smells.md) |
| Tailwind CSS: utility classes, responsive variants, or configuration, with or without a component library | [Good practices](tailwindcss/good-practices.md) | [Review rules](tailwindcss/good-practices.md) |
| daisyUI: component markup, themes, or configuration in a daisyUI project, or authorized adoption | [Good practices](daisyui/good-practices.md) | [Code smells](daisyui/code-smells.md) |

## Review scope and evidence

If given a diff or change set, review changed code and read surrounding definitions, callers, configuration, and tests to verify findings. Otherwise inspect staged and unstaged changes without guessing a remote or base branch. With no changes, inventory the repository and selectively inspect likely hotspots; disclose sampled and excluded scope, including generated or vendor code.

Review correctness, security, data integrity, resource safety, performance, compatibility, architecture, maintainability, tests, applicable UI behavior, and explicit style rules. Select dimensions according to scope and risk; this is not a claim of exhaustive auditing.

A smell is a lead, not a finding. Before reporting:

1. Identify the authoritative contract, triggering conditions, and observable impact or explicit rule violation.
2. Trace relevant callers, exports, registrations, dynamic loading, configuration, tests, side effects, and compatibility roles. Type annotations do not validate runtime input.
3. Confirm the proposed fix preserves required guarantees and established architecture. Prove redundancy across relevant entry paths; compare test contracts and regression risks rather than test counts.
4. Support the claim with evidence proportional to its impact. Do not invent performance or size deltas. Check installed versions and version-matched contracts for unfamiliar APIs.
5. Prefer a concrete, simplest readable fix. Keep unsupported candidates as unverified leads, not findings. Distinguish formatting violations from behavioral defects; do not inflate their severity or report arbitrary default-formatting preferences as defects.

For size claims or bundler-dependent conclusions requiring measurement, use an authorized isolated copy or temporary worktree reproducing the reviewed state, including relevant uncommitted changes. Never stash, reset, restore, or overwrite original user work. Compare baseline and a one-variable variant with the project's production bundler, versions, environment, configuration, and controlled caches. Record commands, build success, raw and relevant compressed artifact sizes, and measurement scope; do not extrapolate across bundlers or from direct ESM loading. Keep output outside tracked source, clean up only experiment-owned resources when authorized, and verify the original workspace is unchanged. If isolation or measurement is unavailable, disclose the missing evidence. Installing dependencies and executing untrusted scripts still require applicable permission and trust checks.

## Review report

Order findings by impact and confidence. Each finding includes severity, confidence, category, `path:line-range`, the problem and trigger or violated rule, a suggested fix, and verified evidence. Categories may include correctness, security, performance, compatibility, resources, architecture, testing, accessibility, maintainability, or style; use narrower reduction tags when useful. Include only high- or medium-confidence findings.

List unresolved candidates separately as `Unverified leads`, with the missing evidence. Summarize inspected/excluded scope and checks actually run. With no findings, state that no sufficiently evidenced issues were found within that scope, not that the repository is approved. Count removable direct dependencies only when complete removal is verified.

Done when authorized changes meet applicable standards and relevant checks support them, or review findings meet the evidence gate; disclose validation limits and remaining risks.

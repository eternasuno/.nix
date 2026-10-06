---
name: reviewing-lean-code
description: Evidence-based lean code review for deletion, deduplication, simplification, dependency reduction, and clearer structure. Use when reviewing a diff, change set, or repository for dead code, unnecessary dependencies, duplication, over-engineering, or simpler alternatives.
---

# Reviewing Lean Code

Produce an evidence-based review, read-only by default. Preserve the original working tree, dependencies, configuration, tests, and user changes. Necessary experiments may modify only an isolated copy or temporary worktree under the conditions below.

## Scope

Review credible reduction and maintainability opportunities:

- dead code or configuration;
- unused flexibility, wrappers, and dependencies;
- custom implementations where built-in or standard-library capability may suffice;
- custom infrastructure where a suitable trusted third-party dependency may suffice;
- duplicated logic;
- redundant defensive checks or fallback branches for conditions already guaranteed by enforced types, upstream validation, or internal contracts;
- redundant tests, meaningless assertions, and dependency-internal tests with no project-owned behavior or distinct risk coverage;
- deep nesting or mixed-responsibility functions;
- misleading names and avoidable abstractions.

This is not a general correctness, security, or performance review unless such a defect directly invalidates a reduction claim.

## Review modes

1. If the user provides a diff or change set, review changed lines. Read surrounding definitions, callers, configuration, and tests only to verify findings.
2. Otherwise inspect staged and unstaged VCS changes without guessing a remote or base branch.
3. If no changes exist, review the repository baseline. Inventory languages, directories, manifests, entry points, tests, generated or vendor code, and configuration; then inspect likely hotspots selectively.
4. State inspected and excluded scope. Never imply full coverage when sampling.

## Evidence gate

A suspicious pattern is a lead, not a finding. Treat validation as redundant only after verifying the guarantee on every relevant entry path; type annotations alone do not validate external runtime data. Treat tests as redundant only after comparing contracts, cases, boundaries, and regression risks, not their count or superficial similarity. Preserve external-input validation, security checks, compatibility behavior, required regression coverage, and cleanup semantics.

Before reporting a finding:

1. Identify the observable behavior and authoritative contract.
2. Trace relevant callers, exports, registrations, reflection or dynamic loading, configuration, tests, compatibility roles, and side effects.
3. Confirm that the proposed replacement preserves required behavior, established architecture, and applicable governing instructions. Preserve project conventions unless an explicit applicable rule overrides them; do not report default-formatting differences alone as lean findings.
4. Establish that the replacement is actually smaller, clearer, safer, or less costly. Prefer the simplest readable final implementation, not the fewest lines or smallest diff. Keep recommendations within the reviewed execution path rather than expanding them into unrelated refactoring.
5. Validate claims with evidence proportional to the claim. Dependency removal or clearer imports do not automatically require bundle experiments. A concrete size delta, or a conclusion that depends on bundler behavior, requires a corresponding controlled comparison; otherwise disclose the missing evidence.

For necessary build-size experiments, read [Isolated experiments](experiments.md). Do not modify the original worktree to perform them or extrapolate tree-shaking results across bundlers or from direct ESM loading.

Evaluate alternatives in this order:

1. Language built-ins and the standard library.
2. Suitable capabilities in existing trusted dependencies.
3. A new trusted dependency only when it satisfies a current requirement and its total cost is justified.
4. A custom implementation when those alternatives do not safely satisfy the requirement or cost more overall.

Check installed versions and version-matched contracts for unfamiliar or version-sensitive APIs. Compare dependency costs beyond source-line reduction, including maintenance, supply-chain risk, runtime compatibility, and deployment cost. A recommendation does not authorize installation or upgrades; a local change does not authorize an upgrade.

Do not recommend compact code that obscures intent, merges unrelated responsibilities, removes meaningful names, or weakens a required boundary. Helpers may be justified by reuse, a named business step, or complex logic that obscures the caller; a single caller or implementation alone is not evidence of redundancy. Preserve required security, accessibility, compatibility, data integrity, error behavior, cancellation, cleanup, side-effect ordering, transactions, and performance constraints. Put unresolved candidates under `Unverified leads`; do not count them as findings.

## Finding categories

- `delete`: dead code, dead configuration, or unused flexibility; replacement is nothing.
- `builtin`: hand-written behavior replaceable by a language built-in or standard library.
- `dependency`: custom behavior or infrastructure replaceable by a suitable trusted dependency.
- `dedupe`: behaviorally equivalent logic that can share one authoritative implementation.
- `yagni`: speculative abstraction, unused configurability, or indirection with no current consumer need, meaningful business role, complexity isolation, or required architectural boundary.
- `clarify`: nesting, mixed responsibilities, control flow, or naming that materially impedes comprehension.
- `shrink`: the same behavior with a demonstrably smaller and clearer implementation.

## Report contract

The final response contains the report. Order findings by impact and confidence. Retain these fields; use multiple lines when evidence, limits, or explanation need room:

```text
<severity>/<confidence> <tag> <path>:<line-range> — <problem>. <simplest readable replacement>. Evidence: <verified facts>.
```

Severity is `high`, `medium`, or `low`; confidence is `high` or `medium`. Omit low-confidence claims from findings.

After findings, list unresolved candidates as:

```text
Unverified leads:
- <path>:<line-range> — <candidate>. Missing evidence: <required verification>.
```

Omit that section when there are no leads. Include a concise scope/count summary, for example:

```text
findings: <N> (<counts by tag>)
removable direct dependencies: <N>
coverage: <inspected scope>
excluded: <excluded scope or none>
unverified leads: <N>
```

Count unique direct dependencies only when complete removal is verified. With no findings, accurately state that no sufficiently evidenced reduction opportunities were found within the inspected scope; this is not full-repository approval.

Done when findings meet the evidence gate, unresolved candidates remain clearly unverified, and inspected/excluded scope and validation limits are disclosed.

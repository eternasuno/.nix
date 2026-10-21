# General Code Smells

Apply the evidence gate in the main skill. These are investigation prompts, not automatic findings.

- **Incorrect boundary or failure behavior:** trace empty inputs, limits, invalid transitions, and errors against the contract. Fix the failing case without inventing unsupported requirements.
- **Unsafe input or trust assumptions:** follow untrusted values into commands, queries, paths, markup, authorization decisions, and logs. Verify validation, escaping, parameterization, access checks, and secret handling at the actual trusted boundary before reporting an exploit path.
- **Races, leaks, or partial updates:** examine interleavings, obsolete async results, cancellation, cleanup, transaction failures, and unbounded accumulation. Identify a reachable failure and preserve ordering and lifetime when fixing it.
- **Performance hazards:** inspect repeated I/O, unnecessary copies, expensive work in hot paths, and unbounded resource usage. Establish the relevant workload or algorithmic impact; measure when the claim depends on runtime behavior rather than asserting invented deltas.
- **Dead code, configuration, or dependencies:** trace exports, registration, reflection, dynamic loading, tooling, and compatibility uses before deleting. An absent textual caller is insufficient.
- **Redundant defense or fallback:** prove upstream guarantees on every relevant entry path, including external runtime input. Remove only checks that do not enforce a distinct invariant or required compatibility behavior.
- **Speculative flexibility:** identify the actual consumers of flags, generics, callback wrappers, registries, options, and extension points. Replace unused flexibility with direct code without weakening real boundaries.
- **Trivial indirection or misleading names:** check whether a helper names a business step, isolates complexity, or preserves a contract. Inline or rename only when it improves comprehension; one caller alone proves nothing.
- **Accidental duplication:** compare contracts, failure semantics, and side effects before deduplicating. Prefer separate business workflows with shared coherent steps over a universal mode-switched function.
- **Deep nesting or hidden execution order:** trace cleanup and side effects before introducing early returns or sequential composition. Do not exchange clear branches for dispatch machinery.
- **Unnecessary custom infrastructure:** compare built-ins, existing dependencies, and trusted alternatives with installed-version contracts and total ownership cost. Fewer source lines alone do not justify a new dependency.
- **Broken public or runtime compatibility:** inspect callers, supported versions, configuration, packaging, and migration behavior. Identify the affected consumer rather than assuming internal changes are harmless.
- **Blank-line violations:** These complete mandatory rules override repository formatting defaults and other formatting preferences; higher-priority governing instructions and language syntax still apply.
  - Separate top-level declarations with one blank line, and leave one blank line after a complete control-flow block when another statement follows in the same enclosing block.
  - Keep connected `else`, `catch`, and `finally` attached, and leave no blank line before the enclosing closing brace.
  - Leave one blank line before a noninitial `return` in the same block; keep related branches, handlers, and continuations together.
  - Use explicit block bodies where repository convention requires them; follow repository conventions for other formatting choices.

  Report violations as style, not behavioral defects. When writing is authorized, fix every violation in the inspected scope; in read-only review, report the required rewrite. Change only noncompliant formatting; leave global formatter configuration unchanged.

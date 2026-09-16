# Design and Dependencies

## Capability preference

For a needed capability, prefer:

1. language built-ins and the standard library;
2. a suitable, trusted third-party dependency;
3. a custom implementation only when neither safely satisfies the requirement.

Reuse existing project helpers and installed dependencies before adding new code or packages. A trusted dependency has appropriate provenance, maintenance, security history, license, runtime support, and operational cost.

Do not reimplement established parsing, encoding, validation, concurrency, cryptography, protocol, collection, or serialization behavior without a concrete reason. Do not add a dependency merely to replace a few clear lines of domain logic.

## Complexity

- Keep the public surface minimal and implementation details local.
- Keep each function focused on one coherent responsibility.
- Split effectful workflows at capability, validation, or representation boundaries so each stage declares only the services and data it needs.
- Extract a helper when it is reused, isolates meaningful complexity, or names a real boundary.
- Inline one-use helpers that only rename an expression or reconstruct unchanged state.
- Prefer direct control flow and visible data flow over speculative abstractions, wrappers, indirection, and unused configurability.
- Keep sequential work sequential; name meaningful stages instead of compressing operations into dense expressions.
- Keep control and data flow visible, use semantic names, and extract helpers only for reuse, meaningful complexity, or a real boundary; inline helpers that only rename one expression.
- Write comments only when very necessary to explain why, such as a non-obvious constraint, compatibility or security reason, business decision, or side-effect ordering. Let visible behavior remain expressed by code.
- Trace the real call path before adding a layer or representation. Delete a module when its former responsibility collapses to direct composition with no independent policy.
- Avoid representation round-trips such as callback → Promise → effect when the external operation can implement the consumer's abstraction directly.
- Before writing preprocessing or normalization, verify whether the platform or dependency already guarantees it.
- Apply the interface rules in `architecture.md`.

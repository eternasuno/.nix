# TypeScript Code Smells

Apply to TS/TSX and JavaScript governed by TypeScript tooling. Check runtime behavior as well as static types.

- **Unchecked external values:** trace casts, `any`, and assertions from external input. Validate runtime data rather than hiding uncertainty with a cast; type annotations are not validation.
- **Invalid state combinations:** examine optional fields and boolean flags permitting contradictory states. Use a discriminated union when it expresses actual mutually exclusive states without obscuring the contract.
- **Unnecessary type machinery:** identify callers needing generics and the input/output relationship they preserve. Remove speculative generics or redundant local annotations, but retain public contracts, domain restrictions, and widening controls.
- **Declaration-style churn:** prefer ordinary type aliases, but do not remove declaration merging, augmentation, or runtime classes. Existing interface syntax alone is not a correctness finding.
- **Ownership hidden by mutation or copies:** verify who may mutate data. Use readonly contracts where needed; remove copies only when ownership and representation remain safe.
- **Forwarding module layers:** trace barrels, wrapper modules, and aliases for actual public API or boundary responsibilities before replacing them with direct imports.
- **Build and deployment confusion:** distinguish TypeScript file selection, package linking/injection, bundler externalization, and deployed runtime imports. `tsconfig.exclude` does not control externalization. Check pinned package-manager and bundler contracts before recommending flags or `noExternal`.
- **Unsafe bulk rewrite:** inspect nested declarations and ambiguous replacement sites. Use syntax-aware tools or unique exact anchors rather than broad textual substitutions.

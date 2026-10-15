# Testing Code Smells

Compare behavior, boundaries, cases, and regression risks, not test counts or superficial similarity.

- **Missing behavioral coverage:** identify a changed contract or concrete regression path not exercised by existing tests. Add the smallest case reaching that boundary rather than speculative exhaustive cases.
- **Assertions that pass when behavior breaks:** verify returned, persisted, or emitted results and required failures or interactions. Configuration or registration assertions do not prove an integration executes correctly.
- **Implementation-detail coupling:** check whether tests force private exports, production interfaces, or services solely for mocking. Exercise the smallest existing public boundary that covers the contract.
- **Redundant cases or dependency-internal tests:** establish equivalent contract, boundary, and failure coverage before removing or merging. Preserve distinct regression cases and project-owned integration behavior.
- **Overbuilt setup:** compare local setup and simple fakes with shared infrastructure. Share only actual repeated complexity; do not introduce public production abstractions for tests.
- **Cross-test state leakage:** trace mutable fake state, directories, environment, and process-wide state under concurrent execution. Keep state local or isolate it; use subprocesses when distinct process state is required, preserving cleanup and diagnostics.
- **Uncontrolled external dependencies:** ensure real network or database usage belongs to explicit integration tests with controlled dependencies and resource cleanup.
- **Incorrect async or failure assertions:** await actual work and distinguish expected failures, defects, cancellation, ordering, and cleanup when their observable semantics differ. Do not assert incidental ordering or internal calls without a contractual reason.

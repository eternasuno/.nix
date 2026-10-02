---
name: architecture-design
description: Design or change software responsibilities, workflows, boundaries, dependencies, and contracts when a task requires structural decisions. Use for domain modeling, capability boundaries, interfaces, adapters, or resource ownership; not routine local edits.
---

# Architecture Design

Design the smallest structure that expresses real responsibilities and boundaries. Use the project's existing model when it fits; logical roles do not require physical layers, extra services, interfaces, or directories.

## Core rules

- Trace actual execution and data flow before choosing structure.
- Introduce abstractions for real responsibility, ownership, capability, lifecycle, or dependency boundaries, not hypothetical substitution or mocking alone.
- Keep business policy distinct from external mechanisms where that distinction is useful. Prefer direct composition and collapse layers with no remaining responsibility.
- Preserve validation, security, consistency, failure semantics, resource lifetime, side-effect ordering, and required performance.
- Assemble shared application-scoped capabilities at the composition root when appropriate. Consumers use the initialized instance; avoid duplicate initialization and accidental process-global lifetimes.

## Workflow

1. Identify the required behavior, existing structure, business decisions, external mechanisms, and ownership.
2. Determine whether structural change is necessary. A local change may need none.
3. Compare meaningful alternatives and select the smallest design that represents the actual boundaries; the parent agent owns overall choices and tradeoffs.
4. Define affected contracts, data/failure flow, dependency direction, and resource lifetimes. Distinguish runtime calls from static dependencies in diagrams.
5. Check the proposed structure against concrete normal, failure, and cleanup paths. For implemented changes, inspect the actual dependency direction and public surface.

## Conditional references

- Read [Architecture](architecture.md) when assigning logical roles, extracting domain operations, composing workflows, or distinguishing calls from static dependencies.
- Read [Boundaries and Dependencies](boundaries-and-dependencies.md) when introducing or changing capabilities, interfaces, adapters, dependencies, or abstraction boundaries.
- Read [Contracts and Data](contracts-and-data.md) when changing public contracts, representations, validation, ownership, or failure boundaries.

Done when the affected responsibilities, contracts, dependencies, and lifetimes are clear, required behavior is accounted for, and new indirection has a concrete purpose. Do not force this model onto projects with a different suitable structure.

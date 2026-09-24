---
name: architecture-design
description: Design software structure, domain operations, workflows, boundaries, capabilities, dependencies, and contracts. Use when introducing or changing system structure, module boundaries, business workflows, external capabilities, interfaces, ports, adapters, or domain abstractions.
---

# Architecture Design

Design the smallest structure that clearly represents the domain, required capabilities, and external boundaries.

Prefer structures that expose business meaning and dependency direction directly. Introduce abstractions, interfaces, modules, and layers only when they represent a real responsibility, boundary, ownership distinction, or capability.

## Core model

Think in logical roles rather than mandatory physical layers:

```text
             Entry
               │
               ▼
        ┌──────────────┐
        │   Workflow   │
        └──────┬───────┘
          ┌────┴────┐
          ▼         ▼
   Domain Ops    Capabilities
                     ▲
                     │
                  Adapters
                     │
                     ▼
               External World
```

- **Entry** translates external requests into business inputs and invokes workflows.
- **Workflows** coordinate business operations, decisions, capabilities, and required side-effect ordering.
- **Domain operations** express business rules, decisions, transformations, and meaningful business actions.
- **Capabilities** describe external abilities the business requires without depending on concrete technology.
- **Adapters** implement capabilities using databases, SDKs, filesystems, queues, networks, processes, or other external systems.

These are logical roles. Do not create separate packages, classes, interfaces, or directories merely to mirror the diagram.

## Design principles

- Understand the real execution flow before changing structure.
- Keep business policy separate from external mechanisms.
- Let dependencies point toward more stable business meaning.
- Prefer direct composition over architectural machinery.
- Introduce an interface only for a real stable boundary, dependency inversion need, materially different implementations, or deliberate capability contract.
- Do not introduce an interface solely for mocking or hypothetical future substitution.
- Split modules when ownership, responsibility, technology, lifecycle, deployment, or size creates a real boundary.
- Prefer deletion or collapse of layers whose responsibility has disappeared.
- Preserve required validation, security, consistency, failure semantics, resource lifetime, side-effect ordering, and performance constraints.
- For application-scoped capabilities shared across multiple components, assemble the dependency once at the application root when explicit parameter threading would obscure the dependency; treat it as runtime-scoped sharing, not a process-global singleton.
- Initialize the capability once during dependency assembly; consumers retrieve the initialized service rather than independently repeating initialization, which can duplicate resources and fragment instance-local state.

## Domain vocabulary

For non-trivial business logic, identify the meaningful domain operations that make up the workflow and compose workflows from them.

Let domain vocabulary emerge from concrete requirements and workflows. Do not design a generic DSL, command framework, interpreter, or abstraction hierarchy in advance unless the domain explicitly requires one.

See:

- `architecture.md` for system roles and dependency direction.
- `boundaries-and-dependencies.md` for capabilities, ports, adapters, interfaces, and dependency choices.
- `domain-operations.md` for business operations and workflow composition.
- `contracts-and-data.md` for data contracts, ownership, validation, and failure boundaries.

## Workflow

Before making architectural changes:

1. Trace the real execution path.
2. Identify business decisions, external mechanisms, and existing capability boundaries.
3. Determine whether the requested change requires a structural change at all.
4. Prefer the smallest structure that represents the real responsibilities.
5. Verify that new abstractions remove coupling or express meaningful domain structure rather than merely move code.
6. Inspect the final dependency direction and public surface for unnecessary indirection.

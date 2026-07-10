# Phase 1: Design

Plan the implementation before writing code.

## Architecture Review

Identify the structural impact of the change:

- Which layers are affected? (Entity, Port, Usecase, Adapter, Infrastructure)
- Dependency direction must point inward
- New files vs. modifications to existing files

## Phase Planning

Break the work into implementation phases:

1. Each phase produces a verifiable output
2. Phases should be independently testable where possible
3. Identify what can run in parallel vs. what must be sequential
4. Decide which specialists to delegate to (fixer, designer, etc.)

## Test Seams

Identify the public boundaries to test at. Write down the seams under test and confirm.

## Context Files

Identify which files or directories must be read before execution.

## Output

- Phase breakdown with verifiable outputs per phase
- Test seam identification
- Write plan to progress file before moving to implement

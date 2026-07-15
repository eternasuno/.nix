---
name: reflect
description: Analyze project and conversation, surface decisions and conventions, persist to AGENTS.md and memory. User-invoked.
disable-model-invocation: true
---

# Retrospective

## Process

1. **Analyze** — read `references/reflect.md` for analysis methodology, then review project state and recent work
2. **Extract** — identify architecture decisions, constraints, conventions, and reusable patterns
3. **Persist** —
   - Project structure, build commands, flow → AGENTS.md
   - Architecture, constraints, config paths → ctx_memory
4. **Evaluate** — after significant tasks, ask: "Did I learn something future sessions need?" If yes, run this skill.

## Completion

- AGENTS.md reflects current project understanding
- Memories capture architecture, constraints, and conventions
- No changes if nothing new was learned

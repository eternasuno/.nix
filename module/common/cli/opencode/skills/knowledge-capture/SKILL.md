---
name: knowledge-capture
description: Automatically capture project knowledge after bug fixes, human corrections, and constraint discoveries. Use as a background behavior to build durable project memory across sessions.
---

# Knowledge Capture

## Overview

Every bug fix, human correction, and project-specific constraint discovery is a learning opportunity that should outlive the current session. This skill defines when and how to capture that knowledge into durable project memory using `ctx_memory`.

The goal is to eliminate repeated mistakes: if you fixed it once, you should never need to rediscover the fix.

## When to Capture

### Bug Fixes

After fixing a bug — before moving on to the next task — capture:

- **Root cause**: What was fundamentally wrong? (not the symptoms)
- **Files changed**: Which files were modified and how
- **Fix summary**: What specific change resolved it
- **Prevention**: How to avoid this bug in the future

### Human Corrections

If the user corrects your work (direction, approach, implementation detail), capture:

- **Misunderstanding**: What did you assume that was wrong?
- **Correct approach**: What should you do instead?
- **Signal**: What should alert you to this situation next time?

### Project Constraints

When you discover a project-specific constraint that isn't documented elsewhere, capture:

- **Constraint**: What is the limitation or requirement?
- **Why it exists**: Context so future sessions don't question it
- **Scope**: Where does this constraint apply?

## Where to Capture

Use `ctx_memory` with appropriate categories:

| Event Type | Category | Content Pattern |
|------------|----------|-----------------|
| Bug fix | `CONSTRAINTS` or `PROJECT_RULES` | "Root cause: X. Fix: Y. Prevention: Z" |
| Correction | `PROJECT_RULES` or `CONSTRAINTS` | "Misunderstanding: X. Correct approach: Y" |
| Constraint | `CONSTRAINTS` or `CONFIG_VALUES` | "Constraint: X. Why: Y. Scope: Z" |

## Behavior

When this skill is loaded, treat knowledge capture as a mandatory step before considering a task fully done. The pattern is:

```
1. Complete the task
2. Ask: "Did I learn something this session that future sessions need?"
3. If yes, write one or more ctx_memory entries
4. Mark the task done
```

Do not skip capture because "the user already knows" or "it's obvious." The point is to persist knowledge so the next session doesn't repeat the same discovery.

## Verification

- [ ] Every bug fix has a corresponding memory entry
- [ ] Every human correction has a corresponding memory entry  
- [ ] Memory entries are specific and actionable, not vague

---
name: writing-for-agents
description: Write or revise instructions agents consume, including skills, AGENTS.md, CLAUDE.md, and conditional reference pointers. Use to clarify scope, workflow, completion criteria, and behavior validation.
---

# Writing for Agents

Write actionable instructions with clear triggers and checkable outcomes. Preserve the document's language and project conventions.

## Editing workflow

1. Establish the task, authorized scope, and trigger conditions. Read current instructions and evidence of the behavior being changed.
2. Separate responsibilities from neighboring skills or documents. Avoid mandatory cross-skill loading chains; a few necessary repeated rules are cheaper than a shared routing layer.
3. Write the smallest useful workflow and checkable completion criteria. Keep core scope, safety rules, execution steps, and completion in the main file.
4. Put low-frequency branches, long examples, theory, and command tables in internal references. Give each reference an explicit reading condition; multiple conditions may match, but do not default to loading everything.
5. Remove duplicates, stale constraints, directly queryable environment facts, and rules with no useful behavioral effect. Preserve compatibility, security, user work, and resource lifecycle boundaries.
6. Validate representative matching and non-matching scenarios, including a risky or ambiguous branch. Check links and contradictions; report what was actually tested and what remains uncertain.

Use precise steps for fragile or irreversible actions and principles for judgment-heavy work. Small useful repetition is acceptable; do not pursue a fixed word count or compression ratio.

## Conditional references

- Read [Skill mechanics](SKILL-MECHANICS.md) when changing skill frontmatter, discovery, or invocation claims. Verify claims against the relevant runtime/version.
- Read [Behavior validation](behavior-validation.md) when a wording change has uncertain effects or warrants fresh-context comparisons and baseline experiments.

Treat claims about wording and model behavior as hypotheses to test, not universal laws. Do not add approval steps when the user already authorized the specific edit.

Done when scope and triggers are distinct, instructions are executable, references are conditional and valid, and representative scenarios support the intended behavior without weakening safety.

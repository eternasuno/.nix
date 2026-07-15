---
name: domain-modeling
description: Sharpen domain language, challenge fuzzy terms, record ADRs, maintain glossary. FIRE BEFORE clean-architecture — clarify domain concepts BEFORE module structure decisions. ALWAYS trigger on vague/overloaded terms, code-description contradictions, or irreversible design decisions with real tradeoffs. Do NOT use for routine code style (use code-standards).
---

Actively build and sharpen the project's domain model as you work.

## File structure

```
docs/
└── adr/
    ├── 0001-event-sourced-orders.md
    └── 0002-postgres-for-write-model.md
```

Create files lazily — only when you have something to write. Use `docs/adr/` for architectural decision records.

## During the session

### Challenge fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You said 'account' — do you mean the Customer or the User? Those are different things."

### Stress-test with scenarios

When domain relationships are discussed, invent concrete edge-case scenarios that force precise boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. Surface contradictions: "Your code cancels entire Orders, but you just said partial cancellation is possible."

### Update the glossary

When a term is resolved, capture it immediately. Don't batch updates.

### Offer ADRs sparingly

Only offer an ADR when all three are true:
1. **Hard to reverse** — meaningful cost to change later
2. **Surprising without context** — future readers will wonder "why?"
3. **Real trade-off** — genuine alternatives with specific reasons for the choice

If any is missing, skip the ADR.

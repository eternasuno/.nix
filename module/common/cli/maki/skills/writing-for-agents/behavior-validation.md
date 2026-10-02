# Behavior validation

Use when wording has uncertain effects or a consequential change warrants comparison. This is an optional method, not a mandatory fresh-agent loop for every edit.

## Representative scenarios

Choose matching, nearby non-matching, and risky/ambiguous cases. State expected decisions: what loads, who decides, when to ask, what is checked, and where work stops. Check contradictions and reference conditions first.

Examples:

- Small local fixes need neither forced delegation nor every available check.
- Existing suitable dependencies need no renewed approval, but undefined retention policy may require a user decision.
- Read-only review must not alter user source for experiments.
- Effect unit tests use controlled dependencies and compatible APIs; explicit integration tests may use managed external resources.

## Baseline experiments

Where uncertainty warrants it, compare bounded scenarios in fresh contexts with old/new guidance and optionally a no-guidance control. Hold inputs and criteria stable; inspect actual decisions, omissions, and scope expansion rather than verbosity. Repeat as risk warrants, without a fixed sample count.

Record guidance versions, inputs, observations, and limitations. A static scenario walkthrough is not a measured model-behavior test.

## Writing hypotheses

Concrete triggers, nearby definitions, short workflows, and checkable completion can improve usability, but effects depend on model and context. Claims that leading words always improve reliability, prohibitions inherently backfire, or hidden later steps necessarily prevent premature completion are hypotheses, not runtime facts. Keep precise prohibitions that protect authorization, security, or user work, and pair them with safe actions where useful.

Retain constraints according to evidence and risk. Remove unsupported theory rather than presenting it as universal explanation.

# Macro Reflect

Periodic analysis of past sessions to find repeated patterns and improvement opportunities.

## Session Discovery

1. Load recent sessions from the SQLite database
2. For each session, analyze goal, success, frictions, and recommendations
3. Aggregate findings and rank by impact

## Scoring Candidates

- **Frequency:** How often has the pattern occurred?
- **Cost:** Does it waste meaningful time, context, money, or attention?
- **Risk:** Does inconsistent execution cause bugs or bad decisions?
- **Stability:** Are inputs and output predictable?
- **Coverage:** Is there already an asset that handles it?

## Choose the Smallest Useful Form

- **Prompt/config rule** — small behavior change to an existing agent
- **Skill** — reusable workflow guidance
- **Command** — repeatable manual trigger
- **Custom agent** — distinct specialist lane
- **Project playbook** — human-readable process guidance
- **Skip** — weak, one-off, or already-covered

## Output

Findings with evidence, recommended changes, skipped candidates, and items needing more evidence.

If nothing qualifies, say so. Do not manufacture improvements.

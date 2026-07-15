# Analysis Methodology

Methods for analyzing project state and identifying what to persist.

## Session Analysis

Review the project and recent work:

1. What was the goal? Was it achieved?
2. What decisions were made? Which are hard to reverse?
3. What constraints were discovered?
4. What patterns repeated across tasks?

## Scoring Candidates

- **Frequency** — how often has this pattern appeared?
- **Cost** — does it waste time, context, or money?
- **Risk** — does inconsistent execution cause bugs or bad decisions?
- **Stability** — are inputs and output predictable?
- **Coverage** — is there already an asset that handles it?

## Choose Storage

| Fit | Storage |
|-----|---------|
| Project structure, build commands, entry points | AGENTS.md |
| Architecture decisions, constraints, paths | ctx_memory |
| Reusable workflow patterns | Suggest as skill or config change |

## If Nothing Found

Say so. Do not manufacture improvements for the sake of it.

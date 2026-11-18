# Skill maintenance

Read only when a skill-change proposal or authorized skill edit is needed, after the main skill's invocation gate is satisfied. Not for routine memory updates; the conditions below do not trigger `self-improving` by themselves.

## Proposal gate

Require an explicit user request, repeated independent evidence of a reusable lesson (such as recurring review findings, reverts, or escaped bugs across separate changes), or direct evidence that existing guidance causes or omits target behavior. A candidate code or review rule must have a concrete code or diff trigger and survive falsification against legitimate counterexamples. Prefer memory/project instructions for repository-specific facts and commands. Do not promote commit summaries or unsupported inferences into general rules.

For self-initiated edits, present the target, observable evidence, smallest change, expected behavior, validation scenario, and risks; obtain approval before editing. Approval covers only that scope. Specific edits already authorized by the user do not need repeated approval.

## Apply and validate

1. Locate the maintained instruction source. If the active copy is generated or deployed from elsewhere, trace it back and edit the source rather than the generated copy.
2. Read current instructions and only relevant references. Preserve unrelated user work and stay within authorization.
3. Identify a scenario exposing the failure. Establish a baseline/fresh-context comparison when useful, not for every edit mechanically.
4. Apply focused changes without cross-skill prerequisites or shared rule layers merely to remove small repetition. Consolidate overlapping rules and prune stale or tool-enforced rules in the touched file so instructions do not only grow. Preserve safety, compatibility, resources, and user work.
5. Check links, contradictions, matching/non-matching triggers, and the failure scenario. Distinguish static checks from observed model behavior; do not claim experiments that were not run.
6. Report changed paths, actual validation, and uncertainty. Revise within approved scope or ask before material expansion. Update any memory candidate to confirmed, rejected, or superseded as evidence supports.

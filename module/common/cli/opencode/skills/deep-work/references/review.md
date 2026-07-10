# Phase 4: Review

Review the completed work against standards and specification.

## Diff Review

Generate and display a clear diff comparing the feature branch to the integration base.

## Review Axes

### Standards
Check against project conventions:
- Does every changed line trace to the requirement?
- No speculative features or over-engineering
- No unrelated files modified
- Conventions followed (naming, structure, style)

### Spec
Check against success criteria from Phase 0:
- All criteria met
- No missing requirements
- No scope creep

## Code Smells
- Mysterious Name — rename
- Duplicated Code — extract
- Feature Envy — move it
- Data Clumps — bundle into one type
- Primitive Obsession — give it a type
- Repeated Switches — polymorphism
- Shotgun Surgery — gather into one module
- Divergent Change — split the file
- Speculative Generality — delete
- Message Chains — hide behind one method
- Middle Man — cut it
- Refused Bequest — composition

A documented repo convention always overrides this baseline.

## Output

- Review findings per file
- Actionable issues (if any)
- Update progress file

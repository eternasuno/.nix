# Isolated experiments

Read only when a concrete size claim or bundler-dependent conclusion requires measurement, not for every dependency/import suggestion.

1. Establish the exact reviewed state, including relevant uncommitted changes, and permissions for an isolated copy or temporary worktree. HEAD alone may not reproduce the diff; copy only relevant authorized changes into isolation or disclose the mismatch.
2. Keep the original workspace untouched. Do not stash, reset, restore, or overwrite user work. If safe isolation cannot reproduce the state, report the candidate as unverified.
3. Use the project's production bundler, versions, environment, and configuration. Compare baseline and a one-variable variant in isolation. Control caches and other comparison factors; keep output outside tracked source.
4. Record build success, commands/configuration, raw and relevant compressed artifact sizes, and measurement scope. Do not invent numbers or generalize across bundlers, versions, or entry points.
5. Clean up only experiment-owned resources when authorized; otherwise report their location/state. Verify the original workspace remains unchanged. On permission failure, stop and report rather than bypassing it.

Failed or limited measurements remain unverified leads. Installing dependencies or executing untrusted build scripts still requires normal trust and permission checks.

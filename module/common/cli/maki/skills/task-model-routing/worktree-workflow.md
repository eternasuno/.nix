# Worktree workflow

Use this workflow for multiple independent features developed concurrently on separate branches. Ordinary delegation, read-only parallel research, and dependent changes use the current working tree.

## Prepare

1. Read project instructions and memory for worktree placement, ignore rules, branch naming, and commit/integration permissions. Inspect the base branch, current changes, and existing worktrees; preserve unrelated work.
2. Define one feature per task, with bounded behavior, acceptance tests, and explicit non-goals. Sequence dependent features instead of treating branch isolation as independence.
3. Create a separate branch and worktree for each feature in the approved location. Verify each path and branch before dispatch. Apply project ignore rules if the directory is inside the repository. On permission failure, stop the blocked operation and report the operation, path, and boundary; do not bypass it with different tools, paths, or privileges.

## Develop

- Give each subagent its absolute worktree path, branch, feature scope, allowed files, test commands, and explicit commit/integration permissions. Restrict writes to that worktree.
- In different worktrees, independent features may change the same repository-relative source file. Identify shared behavior and interfaces before dispatch, keep overlapping edits focused, and record integration risks. Sequence tasks that require each other's changes or incompatible shared-interface decisions.
- Validate each feature in its own worktree. Review its diff, preserve unrelated changes, and commit on its task branch only when authorized. Report the branch, commit or uncommitted state, test results, and remaining risks.

## Integrate only when authorized

Task completion, committing, and integration are separate authorization decisions. Leave completed features on their task branches until integration is authorized; commit permission alone does not authorize merging.

1. Confirm the target branch, integration order, and local changes. Integrate sequentially in dependency or requested order.
2. Resolve conflicts by preserving both intended behaviors and their regression tests. A clean textual merge does not establish semantic compatibility.
3. Run tests and applicable checks on the combined result, including interactions between features. Report integration commits and remaining local changes. Retain or remove branches/worktrees only as authorized.

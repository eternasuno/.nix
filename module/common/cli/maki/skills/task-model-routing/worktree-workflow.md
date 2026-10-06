# Worktree workflow

Use this workflow when small, independent implementation tasks need separate branches/worktrees for concurrent development. Worktree isolation does not make an oversized or dependent task suitable for delegation. Ordinary delegation, read-only parallel work, and dependent changes use the current working tree.

## Prepare

1. Read project instructions and memory for worktree placement, ignore rules, branch naming, and commit/integration permissions. Inspect the base branch, current changes, and existing worktrees; preserve unrelated work.
2. Decompose complex changes into small implementation tasks, each covering one detailed functional module in one or a few files, with acceptance tests and explicit non-goals. Establish shared contracts before dispatch and sequence dependent tasks instead of treating branch isolation as independence.
3. Create a separate branch and worktree for each task in the approved location. Verify each path and branch before dispatch. Apply project ignore rules if the directory is inside the repository.

## Develop

- Give each implementation task its absolute worktree path, branch, module scope, allowed files, test commands, and explicit commit/integration permissions. Restrict writes to that worktree.
- In different worktrees, independent tasks may change the same repository-relative source file. Identify shared behavior and interfaces before dispatch, keep overlapping edits focused, and record integration risks. Sequence tasks that require each other's changes or incompatible shared-interface decisions.
- Validate each module in its own worktree. Review its diff, preserve unrelated changes, and commit on its task branch only when authorized. Report the branch, commit or uncommitted state, test results, and remaining risks.

## Integrate only when authorized

Task completion, committing, and integration are separate authorization decisions. The main agent evaluates all task results and combines them when integration is authorized. Leave completed changes on their task branches otherwise; commit permission alone does not authorize merging.

1. Confirm the target branch, integration order, and local changes. Integrate sequentially in dependency or requested order.
2. After all assigned tasks finish, combine their changes and resolve conflicts by preserving the intended behaviors and their regression tests. A clean textual merge does not establish semantic compatibility.
3. Run tests and applicable checks on the combined result, including interactions between modules. Report integration commits and remaining local changes. Retain or remove branches/worktrees only as authorized.

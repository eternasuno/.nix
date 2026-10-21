# Worktree workflow

Use only when small, independent implementation tasks need separate branches/worktrees for concurrent development. Worktree isolation does not make an oversized or dependent task suitable for delegation; ordinary delegation, read-only parallel work, and dependent changes use the current working tree.

## Prepare

1. Read project instructions and memory for worktree placement, ignore rules, branch naming, and commit/integration permissions. Inspect the base branch, current changes, and existing worktrees; preserve unrelated work.
2. Confirm each task covers one small module with acceptance tests and explicit non-goals. Settle shared contracts and sequence dependent tasks before dispatch; branch isolation never substitutes for independence.
3. Create one branch and worktree per task in the approved location, applying project ignore rules if inside the repository, and verify each path and branch.

## Develop

- Give each task its absolute worktree path, branch, module scope, allowed files, test commands, and explicit commit/integration permissions. Writes stay in that worktree.
- Separate worktrees do not prevent integration conflicts: independent tasks may edit the same repository-relative file. Identify shared behavior and interfaces before dispatch, keep overlapping edits focused, record integration risks, and sequence tasks that need each other's changes or incompatible shared-interface decisions.
- Validate each module in its own worktree, review its diff, preserve unrelated changes, and commit on its task branch only when authorized. Report branch, commit or uncommitted state, test results, and remaining risks.

## Integrate only when authorized

Completion, committing, and integration are separate authorization decisions; commit permission alone does not authorize merging. Without integration authorization, leave completed changes on their task branches.

1. Confirm the target branch, integration order, and local changes; integrate sequentially in dependency or requested order.
2. Combine the finished tasks' changes and resolve conflicts by preserving the intended behaviors and their regression tests. A clean textual merge does not establish semantic compatibility.
3. Run tests and applicable checks on the combined result, including interactions between modules. Report integration commits and remaining local changes. Retain or remove branches/worktrees only as authorized.

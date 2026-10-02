---
name: excalidraw
description: Live Excalidraw canvas creation and element-level editing. Use when a diagram requires iterative visual refinement, precise layout control, screenshots, or Excalidraw round-trip editing.
---

# Excalidraw

Use this skill for live-canvas Excalidraw work, iterative visual refinement, precise element editing, screenshots, image export, or `.excalidraw` round trips. Draw.io XML and diagrams.net editor links are outside this workflow.

## Choose an interface

1. Prefer Excalidraw MCP tools when available.
2. Otherwise use an available compatible CLI. If none is installed, use `npx -y mcp-excalidraw-server <command>` only when network/package execution is permitted; do not silently install persistently.
3. Use REST only as a last resort; see `references/cheatsheet.md`.

Canvas-touching, screenshot, image-export, Mermaid, and viewport operations need an open browser tab. The CLI uses `http://127.0.0.1:3000` by default; see the cheatsheet for options and exit codes.

## Choose a creation mode

- Use Mermaid when the input is already Mermaid or maps cleanly to a standard flowchart, sequence, or ER diagram.
- Create elements directly for custom architecture, annotated cloud diagrams, exact coordinates, or layouts Mermaid cannot express well.

## Required workflow

1. Inspect or plan the coordinate grid before creating elements.
2. Create shapes with stable IDs, then create arrows bound to those IDs. For complex diagrams, create in meaningful batches.
3. After each meaningful batch, take a screenshot and actually view it.
4. Check the quality gate below. If any issue appears, stop, fix it, and re-screenshot before continuing.
5. Export or share only after the final screenshot passes.

For an existing diagram, run `describe` first; locate elements by stable ID or label, never by coordinates alone. Update, then screenshot again. Bound arrows reroute when their endpoints move or resize. Save a snapshot before risky changes.

## Quality gate

Check every batch and the final result:

- Text is fully visible; body text is at least 16px and titles at least 20px.
- Shapes do not overlap; zones contain children with about 50px padding.
- Keep at least 40px between elements, and reserve 120px or more for labeled arrows.
- Arrows do not cross unrelated elements; use waypoints, curved routes, or elbowed routes around obstacles.
- Arrow labels are short and necessary; omit them on dense diagrams.
- Large background zones do not use bound `text` or `label.text`; use an independent text element near the top edge.
- Avoid long diagonal cross-zone arrows; route along the perimeter.

## Layout baseline

- Coordinates use `(0, 0)` at the upper-left; x increases right and y increases down.
- Shape width: `max(160, labelCharCount * 12)`; single-line height about 60px, two-line height about 80px.
- Use solid fills for crisp shapes and dashed strokes for zones or asynchronous flows.
- Use `text` on shapes and `startElementId` / `endElementId` on arrows in CLI/MCP input. Raw REST uses the stricter formats documented in the cheatsheet.

## Arrow routing

Use intermediate points when a straight arrow would cross an unrelated element. Use curved routes for fan-out or gentle detours and elbowed routes for cross-lane or right-angle paths. Keep routing outside other zones when possible.

## Visual refinement

The essential loop is:

```text
plan or describe → create/update → screenshot → inspect → fix → re-screenshot
```

Do not proceed while labels are truncated, elements overlap, zones are mislabeled, or arrows collide with content. For duplicate bound text, inspect text elements with `containerId`; avoid labels on background zones and allow canvas auto-sync to settle before cleanup.

## Reference

Read only the relevant sections of `references/cheatsheet.md` when choosing CLI/MCP syntax, using REST/raw formats, managing snapshots/server options, exporting, or troubleshooting. Check the active tool version; do not load every interface table by default.

Done when the requested diagram/export is delivered, the final screenshot has been inspected, and unrelated canvas content and user work are preserved. Report unavailable browser/export verification.

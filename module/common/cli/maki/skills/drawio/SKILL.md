---
name: drawio
description: Draw.io XML authoring and diagrams.net editor URLs. Use when the requested deliverable must be editable draw.io source or an app.diagrams.net editor link.
---

# Drawio — XML & URL generation

Produce draw.io diagrams as `.drawio` XML and as `app.diagrams.net` editor
URLs. Everything is done with hand-written XML plus the bundled Node script —
no other software involved.

## When to use / when not

- Use when: the user requests draw.io XML, a `.drawio` file, or an
  app.diagrams.net editor URL.
- Do NOT use for: live-canvas editing, iterative element-level refinement, or
  generic PNG/SVG/PDF image delivery without a draw.io source requirement. Those need a suitable rendering workflow, not this XML/URL workflow.

## Workflow

### Step 0 — Resolve the style preset

Default is `default`. If the user asks for a look (dark, hand-drawn,
corporate, colorblind-safe, or a named preset), read
`references/style-presets.md` and apply its rules for the whole diagram.

### Step 1 — Choose the diagram type

For a specialized type (ERD, UML, sequence, C4, BPMN, SysML, network, or swimlane), read only the matching section of `references/diagram-types.md` and use its conventions. A simple flowchart does not require the full type catalog. Ask a clarifying question only if the type is genuinely
ambiguous.

### Step 2 — Author the XML

When authoring XML, read the relevant structure/edge sections of `references/xml-authoring.md`, then write the `.drawio` file by hand. Read `references/shapes.md` when selecting unfamiliar shapes or stencils — never guess an
`mxgraph.*` stencil name (a wrong name renders as a blank box).

**Non-negotiable rules** (violating any of these breaks the diagram):

- `<mxCell id="0" />` and `<mxCell id="1" parent="0" />` are required root
  cells — user shapes start at `id="2"` with `parent="1"` and increment
  sequentially
- Every edge must be an expanded form with a
  `<mxGeometry relative="1" as="geometry" />` child — never a self-closing
  `edge="1"` cell
- Generated XML files must not contain XML comments (`<!-- -->`). Keep explanations outside XML code blocks.
- All text-bearing cells use `html=1` in style
- Escape special characters in attributes: `&amp;` `&lt;` `&gt;` `&quot;`
- Line breaks inside `value` use `&#xa;`, never literal `\n`
- Save the file to disk (e.g. `./diagram.drawio`) — it is the persistent
  local copy the user can re-open and re-edit

### Step 3 — Convert to a URL

```bash
node <this-skill-dir>/scripts/encode_url.mjs diagram.drawio
```

- Prints the editor URL (`https://app.diagrams.net/?grid=0&pv=0&border=10&edit=_blank#create=…`) to stdout; sanity warnings go to stderr and do not block output
- Also accepts XML on stdin: `node <this-skill-dir>/scripts/encode_url.mjs < diagram.drawio`
- Do NOT open the URL yourself. Hand the URL to the user verbatim (never
  pass it through a shell that could truncate the `#` fragment)

### Step 4 — Deliver

Give the user: the URL (as a plain, unmodified string) and the local
`.drawio` file path. If anything looks off, read
`references/troubleshooting.md`. The diagrams.net editor is the final
validator — if a diagram renders wrong, fix the XML and regenerate the URL.

## URL size limit

URLs are capped at roughly 8 KB. If the encoded diagram exceeds that (the
script will print an extremely long line — no hard failure), deliver the
`.drawio` file alone and tell the user to open it in the diagrams.net editor
(File → Open, or drag into the editor page).

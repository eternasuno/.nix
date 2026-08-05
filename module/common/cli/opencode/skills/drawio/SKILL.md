---
name: drawio
description: Generate draw.io diagrams by hand-authoring .drawio XML and converting it to a shareable app.diagrams.net editor URL. Use when the user wants a flowchart, architecture diagram, ERD, UML, sequence diagram, C4 model, BPMN, network topology, mind map, or any diagram, and you need to deliver it as XML source or a browser URL. Author XML per the references in this skill, then run scripts/encode_url.mjs (Node, zero deps) to produce the URL. Do NOT use for image export (PNG/SVG/PDF) — this skill only produces XML and URLs, never shell out to external diagram tools.
---

# Drawio — XML & URL generation

Produce draw.io diagrams as `.drawio` XML and as `app.diagrams.net` editor
URLs. Everything is done with hand-written XML plus the bundled Node script —
no other software involved.

## When to use / when not

- Use when: user asks for any kind of diagram and expects it as XML source or
  a clickable URL to open in the diagrams.net editor.
- Do NOT use for: exporting PNG/SVG/PDF images, or anything requiring
  rendering locally. If the user needs an image file, say the URL opens in the
  editor where they can export — do not attempt it here.

## Workflow

### Step 0 — Resolve the style preset

Default is `default`. If the user asks for a look (dark, hand-drawn,
corporate, colorblind-safe, or a named preset), read
`references/style-presets.md` and apply its rules for the whole diagram.

### Step 1 — Choose the diagram type

Read `references/diagram-types.md`, pick the matching type (flowchart,
ERD, UML class, sequence, C4, BPMN, SysML, network, mind-map, …), and use its
style tables. Ask a clarifying question only if the type is genuinely
ambiguous.

### Step 2 — Author the XML

Read `references/xml-authoring.md` first, then write the `.drawio` file by
hand. Use `references/shapes.md` for any specific shape — never guess an
`mxgraph.*` stencil name (a wrong name renders as a blank box).

**Non-negotiable rules** (violating any of these breaks the diagram):

- `<mxCell id="0" />` and `<mxCell id="1" parent="0" />` are required root
  cells — user shapes start at `id="2"` with `parent="1"` and increment
  sequentially
- Every edge must be an expanded form with a
  `<mxGeometry relative="1" as="geometry" />` child — never a self-closing
  `edge="1"` cell
- Never write XML comments (`<!-- -->`) — they render oddly; omit them
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

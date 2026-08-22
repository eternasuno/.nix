# Style Presets — Apply

A **style preset** is a named JSON file capturing visual preferences — palette, shape vocabulary, fonts, edge style. When a preset is active, it fully replaces the built-in conventions in SKILL.md's color/shape/edge tables.

Read this file when:
- The user asks for a specific look ("dark", "hand-drawn", "corporate", "colorblind-safe", or a preset name)
- You've resolved an active preset in Step 0 and need the application rules

## Locations and lookup order

1. `~/.drawio-skill/styles/<name>.json` — user presets, if the user has any (survive updates).
2. `<this-skill-dir>/styles/built-in/<name>.json` — built-ins shipped with the skill:

| Preset | When |
|---|---|
| `default` | baseline look |
| `dark` | dark fills + page background, light strokes; needs the `extras.fontColor`/`edgeColor`/`background` rules below |
| `handdrawn` | sketch/`sketch=1` look |
| `corporate` | restrained business palette |
| `colorblind-safe` | Okabe-Ito palette, distinguishable under color-vision deficiency, thicker strokes |

A user preset shadows a built-in of the same name. Only user presets can have `"default": true`.

**Name normalisation:** always lowercase a preset name before looking up files.

## Applying a preset

These rules apply at generation time (existing `.drawio` files are not re-themed).

When SKILL.md's Step 0 identified a preset, it fully replaces the built-in palette, shape keywords, edge defaults, and font for this diagram — do not mix values from the built-in color table.

**Color lookup.** For each role a shape plays (service / database / queue / gateway / error / external / security), resolve `preset.roles[role]` to a slot name, then `preset.palette[<slot>]` to the `(fillColor, strokeColor)` pair. If `roles[role]` is unset or the resolved slot is `null`, follow this fallback ladder:

1. Try the role's canonical slot (`service→primary`, `database→success`, `queue→warning`, `gateway→accent`, `error→danger`, `external→neutral`, `security→secondary`).
2. If that slot is also empty, pick the most-populated non-null slot in the preset.
3. Never reach into the built-in color table — the preset is authoritative.

**Decision and container shapes** are not in `preset.roles` — they have shape vocabulary (`preset.shapes.decision`, `preset.shapes.container`) but no role-to-slot mapping. Pick their colors as follows:
- **Decision** (rhombus) → use `preset.palette.warning` (the canonical yellow slot in the built-in conventions). If `warning` is empty, apply the slot-fallback ladder above starting from `warning`.
- **Container** (swimlane) → use the palette slot matching the tier/grouping the container represents (e.g. a "Services" tier container uses `primary`; a "Data" tier uses `success`). If no tier signal is available, default to `primary`.

**Shape keywords.** Use `preset.shapes[role]` as the **prefix** of the vertex style string (before `whiteSpace=wrap;html=1;...`). Example: for a database role, if `preset.shapes.database = "shape=cylinder3"`, the vertex style starts `shape=cylinder3;whiteSpace=wrap;html=1;fillColor=...`. The six named shape keys are `service`, `database`, `queue`, `decision`, `external`, `container`. Roles `gateway`, `error`, and `security` reuse `preset.shapes.service` unless the preset explicitly populates a key with their name.

**Edges.** Use `preset.edges.style` as the base edge style string. Append `preset.edges.arrow`. Per-edge routing keys (`exitX/exitY/entryX/entryY/...`) are still added by the usual routing rules in SKILL.md. If the flow between two shapes matches a token from `preset.edges.dashedFor` (either because the user's prompt used that word, or because one end of the edge plays a role whose typical relation is "optional"), append `;dashed=1` to the edge style.

**Fonts.** Append `fontFamily=<preset.font.fontFamily>;fontSize=<preset.font.fontSize>` to every vertex style. Container headers and swimlane titles additionally get `fontSize=<preset.font.titleFontSize>;fontStyle=1` when `preset.font.titleBold` is `true`.

**Extras.**
- `preset.extras.sketch === true` → append `sketch=1` to every vertex style and every edge style.
- `preset.extras.globalStrokeWidth !== 1` (any value other than the drawio default of 1, including `0.5`) → append `strokeWidth=<n>` to every vertex style and every edge style.
- `preset.extras.fontColor` (present) → append `fontColor=<hex>` to every vertex and container style. Required for dark palettes — without it, dark fills render unreadable black text.
- `preset.extras.edgeColor` (present) → append `strokeColor=<hex>;fontColor=<hex>` to every edge style (edges otherwise default to black, invisible on dark backgrounds).
- `preset.extras.background` (present) → set `background="<hex>"` on the `<mxGraphModel>` element.

**Interaction with diagram-type presets** (ERD / UML / Sequence / ML / Flowchart). Diagram-type presets set structural style keywords that the user preset must preserve (e.g. ERD tables rely on `shape=table;startSize=30;container=1;childLayout=tableLayout;...`). The rule: keep the diagram-type preset's structural keywords, then layer the user preset's color / font / edge / extras on top. When a diagram-type preset hardcodes a color (`fillColor=#dae8fc`, etc.) that conflicts with the user preset, the user preset's color wins. Exception: `fillColor=none` is structural — do not replace it with a palette color.

## Preset file validation

When loading any preset, do a lightweight structural check:
- Required top-level fields present (`name`, `version`, `palette`, `roles`, `shapes`, `font`, `edges`).
- `version === 1`.
- Every populated palette slot has both `fillColor` and `strokeColor` as `#RRGGBB`.
- `confidence` ∈ {`"low"`, `"medium"`, `"high"`} if present.

On validation failure: warn the user, fall back to built-in conventions for this one diagram, do not mutate the file.

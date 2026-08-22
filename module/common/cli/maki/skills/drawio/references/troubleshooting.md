# Troubleshooting — Common Mistakes

Read this when something looks wrong in the output (rendering, layout, edges, URL).

| Mistake | Fix |
|---------|-----|
| Missing `id="0"` and `id="1"` root cells | Always include both at the top of `<root>` |
| Shapes not connected | `source` and `target` on edge must match existing shape `id` values |
| Self-closing edge `mxCell` (`<mxCell ... edge="1" />`) | Use the expanded form with `<mxGeometry relative="1" as="geometry" />` child — self-closing edges won't render |
| `--` inside XML comments | Illegal per XML spec — use single hyphens or rephrase (better: no comments at all) |
| Special characters in `value` | Use XML entities: `&amp;` `&lt;` `&gt;` `&quot;` |
| Literal `\n` in label text | Use `&#xa;` for line breaks in `value` attributes |
| Overlapping shapes | Scale spacing with complexity (200–350px); leave routing corridors |
| Edges crossing through shapes | Add waypoints, distribute entry/exit points, or increase spacing |
| Arrowhead overlaps bend | Final edge segment before target must be ≥20px — increase spacing or add waypoints |
| Shape renders as a blank box | A guessed `shape=mxgraph.*` name doesn't exist — replace with a cheatsheet shape from `shapes.md` |
| Browser URL opens a blank/empty diagram | The `#create=…` fragment was lost (shell stripped it at `#`/`&`). Never pass the URL through a shell that truncates fragments; give it to the user verbatim |
| URL is extremely long | URLs are capped (~8 KB); if the diagram is large, deliver the `.drawio` file instead and let the user open it in the diagrams.net editor |
| CJK/emoji labels throw "URI malformed" | The script handles encoding — if a hand-built URL fails, regenerate it with `scripts/encode_url.mjs` |
| Label text shows entities raw | `html=1` is missing from the cell style — all text-bearing cells need it |

If a URL still fails after the fixes above: drop it, deliver the `.drawio`
file, and let the user open it in the diagrams.net editor (it shows the
diagram exactly as it will render — the editor is the final validator).

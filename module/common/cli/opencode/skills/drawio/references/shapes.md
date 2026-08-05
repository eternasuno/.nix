# Shape vocabulary

Read this when a diagram needs a **specific shape** — a cloud-provider icon
(AWS/Azure/GCP), a network/Cisco/Kubernetes symbol, a UML/BPMN/ER element, an
electrical or P&ID part — or any time you'd otherwise *guess* a `style=` string.

## The one rule: never guess an `mxgraph.*` name

draw.io's extended libraries (AWS, Cisco, Kubernetes, BPMN, SysML, P&ID, …)
are addressed by stencil names like `shape=mxgraph.aws4.lambda`. A guessed
name that doesn't exist **silently renders as a blank box** — the diagram
looks fine in XML and broken in the editor.

- Only hand-write styles from the **cheatsheet below** (stable built-ins).
- For anything branded/vendor-specific that is not in the cheatsheet, use a
  **generic cheatsheet shape** instead (database → `shape=cylinder3;`, cloud →
  `cloud;`, actor → `shape=umlActor;`, …) — a correct generic shape beats a
  guessed vendor icon that renders blank.
- AI/LLM brand logos (OpenAI, Claude, …) are not in draw.io's bundled
  libraries. Use generic shapes for them too (e.g. a rounded box with the
  model name, a `cylinder3` for vector DBs).

## Cheatsheet — hand-writable styles

These are stable enough to write by hand. Combine with `whiteSpace=wrap;html=1;`.

### Common shapes (`shape=` keyword)

| Need | style |
|---|---|
| Rectangle / rounded box | `rounded=0;` / `rounded=1;` |
| Circle / ellipse | `ellipse;` (`aspect=fixed;` for a true circle) |
| Diamond (decision) | `rhombus;` |
| Cylinder (database) | `shape=cylinder3;` |
| Cloud | `cloud;` |
| Cube (3D) | `shape=cube;` |
| Sticky note | `shape=note;` |
| Document (curled bottom) | `shape=document;` |
| Folder | `shape=folder;` |
| Card (cut corner) | `shape=card;` |
| Process (double border) | `shape=process;` |
| Step / chevron | `shape=step;` |
| Parallelogram (I/O) | `shape=parallelogram;perimeter=parallelogramPerimeter;` |
| Trapezoid | `shape=trapezoid;perimeter=trapezoidPerimeter;` |
| Hexagon | `shape=hexagon;perimeter=hexagonPerimeter2;` |
| Manual input | `shape=manualInput;` |
| Data storage | `shape=dataStorage;` |
| Off-page connector | `shape=offPageConnector;` |
| Delay | `shape=delay;` |
| OR / XOR gate | `shape=or;` / `shape=xor;` |
| Block arrow | `shape=singleArrow;` / `shape=doubleArrow;` |
| Callout (speech bubble) | `shape=callout;` |

### UML primitives

| Element | style |
|---|---|
| Actor (stick figure) | `shape=umlActor;verticalLabelPosition=bottom;verticalAlign=top;` |
| Boundary | `shape=umlBoundary;` |
| Control | `shape=umlControl;` |
| Entity | `shape=umlEntity;` |
| Lifeline | `shape=umlLifeline;perimeter=lifelinePerimeter;container=1;` |
| Frame | `shape=umlFrame;` |
| Provided interface (lollipop) | `shape=lollipop;direction=south;` |
| Required interface | `shape=requires;direction=north;` |
| Component | `shape=component;` |

### Containers (parent-child; children use relative coords)

| Type | style | When |
|---|---|---|
| Invisible group | `group;pointerEvents=0;` | No border, no own connections |
| Titled swimlane | `swimlane;startSize=30;` | Visible title bar / has connections |
| Any shape as container | append `container=1;pointerEvents=0;` | Box without own connections |

### Edges

| Need | add to style |
|---|---|
| Orthogonal routing | `edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;` |
| Curved | `curved=1;` |
| No arrowhead | `endArrow=none;` |
| Open/thin arrow | `endArrow=open;` / `endArrow=classicThin;` |
| Dashed | `dashed=1;` (pattern via `dashPattern=8 8;`) |
| Flow animation | `flowAnimation=1;` |
| Label background | `labelBackgroundColor=#ffffff;` |

### Useful property knobs

- `fontStyle` is a bitmask: `1`=bold, `2`=italic, `4`=underline (add to combine: `3`=bold+italic).
- `direction=north|south|east|west` rotates a shape in 90° steps; `rotation=<deg>` for free rotation.
- `gradientColor=#RRGGBB;` + `gradientDirection=north;` for a gradient fill.
- `sketch=1;` gives a hand-drawn look (set globally via a style preset instead when possible).

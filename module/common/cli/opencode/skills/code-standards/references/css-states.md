# CSS States Over JS Events

CSS pseudo-classes track *states*, not events — but many interactions you'd instinctively wire with `addEventListener` can be expressed declaratively in CSS.

## Principle

Before reaching for JS to respond to a UI interaction, check whether a CSS pseudo-class already captures that state.

## CSS → JS Mapping

### Pointing Device
| CSS | Instead of JS |
|---|---|
| `:hover` | `pointerenter` / `pointerleave` |
| `:active` | `pointerdown` / `pointerup` |

### Focus
| CSS | Instead of JS |
|---|---|
| `:focus` | `focus` / `blur` |
| `:focus-visible` | `focus` + heuristic check for keyboard vs pointer |
| `:focus-within` | Traversing parent to set a class on focus |

### Form State
| CSS | Instead of JS |
|---|---|
| `:checked` | `change` event + `element.checked` check |
| `:valid` / `:invalid` | `checkValidity()` / `invalid` event |
| `:user-valid` / `:user-invalid` | `change` event (after user interaction and blur) |

### Media Elements
| CSS | Instead of JS |
|---|---|
| `:buffering` | `waiting` event |
| `:muted` | `volumechange` + `element.muted` check |
| `:paused` | `pause` event |
| `:playing` | `playing` event |
| `:stalled` | `stalled` event |

### Overlay / Disclosure
| CSS | Instead of JS |
|---|---|
| `:popover-open` | `toggle` event + `element.open` check |
| `:open` (dialog/details) | `toggle` event + `element.open` check |
| `:modal` | `fullscreenchange` + `document.fullscreenElement` |

### Navigation
| CSS | Instead of JS |
|---|---|
| `:fullscreen` | `fullscreenchange` + `fullscreenElement` check |
| `:target` | `hashchange` + `getElementById(hash)` |

## When CSS Is Enough
- **Show / hide** — tooltips, dropdowns, popovers via `:hover`, `:focus-within`, or `popover`
- **Highlight / decorate** — active links, focused fields, invalid forms, playing videos
- **Toggle visuals** — `:checked`-driven switches, `:open` widgets, `:modal` backdrops
- **Form feedback** — `:user-invalid` for validation styling; `:autofill` for auto-fill styling

## When to Reach for JS
- **Data mutation** — submitting values, persisting state, calling APIs
- **Orchestration** — one interaction changes multiple unrelated elements
- **Sequencing** — step A must finish before step B
- **Computed values** — runtime data (not just state)
- **Fallback / polyfill** — browser support gaps

## Applying the Pattern

1. Spot the `addEventListener` call
2. Ask: "Is this listener purely changing presentation?"
3. If yes, find the matching CSS pseudo-class in the table above
4. Replace the listener + class-toggling with a CSS rule
5. Keep the JS listener only for side effects (data, API, logging)

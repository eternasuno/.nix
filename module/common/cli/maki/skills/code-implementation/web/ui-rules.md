# Web UI Rules

Apply to web markup, styles, layout, and UI interactions, including framework templates and JSX/TSX.

When the project uses daisyUI, or its adoption is authorized, read [daisyUI rules](daisyui-rules.md) for all HTML/JSX and Tailwind UI work. Do not load it for unrelated projects.

## State and interaction

- Preserve the existing UI stack and design system. Prefer native HTML and CSS when they meet the required semantics and browser targets; do not add JavaScript state or dependencies for behavior they already provide.
- Keep one authoritative owner for each state. Do not mirror native open/checked state in framework state unless application integration requires it. Shared state, persistence, URL synchronization, and asynchronous workflows belong in application state.
- Choose elements by meaning: buttons for actions, anchors for navigation, native controls for input. A checkbox is not a modal; radio inputs and CSS visibility alone do not implement accessible tabs.
- Preserve labels, accessible names, keyboard operation, visible focus, reading order, and form submission. Do not hide required interactive controls from keyboard or assistive-technology users.
- Use JavaScript when required for focus management, keyboard navigation, or synchronized accessibility state. A styled component or ARIA role alone does not implement an interaction contract.
- Keep client validation feedback associated with the field; do not show errors on untouched fields. Client validation does not replace server validation of untrusted input.

## Styling and compatibility

- Reuse existing tokens, themes, and cascade structure. Keep local overrides scoped; do not introduce a global reset, theme system, or component-wide override for a local change.
- Prefer CSS layout over measurement observers, spacer elements, or JavaScript sizing. Add breakpoints only when behavior must change at a width; intrinsic sizing and wrapping may already satisfy the requirement.
- Keep visual order consistent with reading and keyboard order. Essential actions must not depend on hover; preserve visible focus, contrast, and existing light/dark or forced-color behavior.
- Derive browser targets from the project and check documentation for unfamiliar features. Add a fallback only when a required target lacks required behavior; optional enhancement must leave content and controls usable without it.
- Respect reduced-motion preferences. Do not hide content behind an animation that may not run. Reserve media dimensions to avoid layout shifts; do not lazy-load the likely primary above-the-fold image.

## Verification

Check only the dimensions affected by the change:

- Interaction: keyboard/pointer operation, relevant touch behavior, dismissal, focus entry/return, submission, and state exposure.
- Presentation: narrow widths, long content, zoom, relevant themes, contrast, and reduced motion.
- Compatibility: required fallback behavior against project browser targets.

Confirm that added state, JavaScript, or dependencies serve behavior not already provided by the existing implementation or supported platform. Report browser checks not run; static inspection is not browser verification.

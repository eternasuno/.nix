# Web UI Rules

Apply to web markup, styles, layout, and UI interactions, including framework templates and JSX/TSX.

When the project uses daisyUI, or its adoption is authorized, read [daisyUI rules](daisyui-rules.md) for all HTML/JSX and Tailwind UI work. Do not load it for unrelated projects.

When the project uses SolidJS, read [SolidJS rules](solidjs-rules.md) for components, reactivity, UI state, forms, and data flow. Do not load it for non-Solid projects.

## State and interaction

- Preserve the existing UI stack and design system. Prefer semantic HTML/native behavior, then CSS selectors/pseudo-classes, then DOM properties/native browser APIs, then JavaScript/framework application state. Choose the simplest implementation meeting semantics, accessibility, interaction, and project browser targets. Use framework state when it materially simplifies complex listeners or DOM coordination without significant performance cost; this preference order is not a prohibition on signals.
- Reuse browser-owned UI state rather than copying it into application state for styling. Consider `<details>`/`open`, `<dialog>`/`showModal()`/`close()`/`:open`, Popover API `popover`/`popovertarget`/`:popover-open`, checkbox/radio `:checked`, `:disabled`, `:focus-visible`, and native validity pseudo-classes when supported by project browser targets.
- Keep one authoritative owner for each state; do not maintain bidirectional mirrors of DOM/native and framework state. Promote state only when business logic, cross-component coordination, persistence, URL synchronization, or asynchronous workflows require application ownership; merely reading or controlling native state through its API does not require a duplicate.
- Choose elements by meaning: buttons for actions, anchors for navigation, native controls for input. A checkbox is not a modal; radio inputs and CSS visibility alone do not implement accessible tabs.
- Preserve labels, accessible names, keyboard operation, visible focus, reading order, and form submission. Do not hide required interactive controls from keyboard or assistive-technology users.
- Use JavaScript when required for focus management, keyboard navigation, or synchronized accessibility state. A styled component or ARIA role alone does not implement an interaction contract.

## Forms and validation

- Prefer native constraint validation for ordinary forms: `required`, appropriate types such as `email`/`url`, `min`/`max`, `minlength`/`maxlength`, `pattern`, and other applicable HTML constraints. Use `ValidityState` and `checkValidity()` instead of duplicating those constraints or their validation state in JavaScript; use `setCustomValidity()` for custom constraints and clear the custom error when resolved.
- Use CSS `:invalid`/`:valid` and, when supported, `:user-invalid`/`:user-valid` for validation presentation. `:invalid` matches whenever a constraint fails, including an untouched empty required input; prefer `:user-invalid` to defer error UI until sufficient user interaction. Keep feedback associated with its field; do not show initial untouched-field errors.
- When a submit attempt must reveal every invalid field, use one form-level submitted/attempted state or class with a selector such as `form.submitted :invalid`, alongside normal `:user-invalid` feedback. Do not create per-field touched/invalid state for behavior the browser already provides.
- For custom error UI backed by the browser validation engine, use `<form novalidate>` to disable automatic constraint validation and native validation UI on submission, not input constraints, `ValidityState`, or validity pseudo-classes. In the submit handler, use `form.checkValidity()`; it returns validity and fires relevant `invalid` events without showing native validation popups. Prevent business submission on failure; read and submit data only after validation passes. Use `reportValidity()` only when browser-provided validation UI is explicitly wanted.
- Client validation does not replace server validation of untrusted input.

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

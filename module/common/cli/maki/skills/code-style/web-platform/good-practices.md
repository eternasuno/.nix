# Web UI Rules

Apply to web markup, styles, layout, and UI interactions, including framework templates and JSX/TSX.

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

- Reuse existing tokens, themes, and cascade structure. Keep local overrides scoped; do not introduce a global reset, theme system, or component-wide override for a local change. Inspect the cascade before escalating specificity or using `!important`.
- Prefer rem for necessary custom fixed dimensions, reserving px for thin borders or genuinely pixel-bound interfaces; preserve project conventions and use intrinsic, relative, or viewport sizing when appropriate. Runtime measurements may arrive in px; do not hardcode the root font size when converting.
- Prefer CSS layout over measurement observers, spacer elements, or JavaScript sizing. Add breakpoints only when behavior must change at a width; intrinsic sizing and wrapping may already satisfy the requirement.
- Recover focus across responsive panels using actual visibility and current focus, not JavaScript breakpoints duplicating CSS. Preserve valid focus on visible controls and open dialogs; only recover lost or hidden focus. Layout belongs to CSS; focusing elements requires JavaScript.
- Keep visual order consistent with reading and keyboard order. Essential actions must not depend on hover; preserve visible focus, contrast across relevant themes, and existing light/dark or forced-color behavior. Keep navigation content accessible when navigation collapses on narrow screens.
- Derive browser targets from the project and check documentation for unfamiliar features. Add a fallback only when a required target lacks required behavior; optional enhancement must leave content and controls usable without it.
- Respect reduced-motion preferences. Do not hide content behind an animation that may not run. Reserve media dimensions to avoid layout shifts; do not lazy-load the likely primary above-the-fold image.

## Shared visual contracts

- When controls share a visual contract, implement it in a shared semantic component. Before declaring styles unified, inspect all affected consumers, including toolbars, menus, navigation, pagination, forms, and specialized wrappers.
- Put shared shape, hover, focus, and disabled behavior in the base component; specialized components compose it and own only their additional semantics or layout. Call sites must not independently redefine the shared interaction styles. Preserve native attributes, refs where applicable, event handlers, form submission, accessible names, and disabled behavior.
- Do not force all controls to have identical dimensions or erase selected, primary, destructive, or loading states. Separate a shared interaction contract from legitimate semantic variants; do not treat links as buttons merely to share styling.
- Remove superseded local styles during migration. Verify representative consumers and state combinations rather than assuming component reuse guarantees visual consistency.

## Verification

Check only the dimensions affected by the change:

- Interaction: keyboard/pointer operation, relevant touch behavior, dismissal, focus entry/return, submission, and state exposure.
- Presentation: narrow widths, long content, zoom, relevant themes, contrast, reduced motion, and affected hover, focus, selected, and disabled states.
- Compatibility: required fallback behavior against project browser targets.
- Reference-driven UI: inspect real default/hover/focus states and computed styles when available, rather than guessing border/shadow behavior. Check nested hit areas remain inside hover surfaces. Confirm actual viewport dimensions after resize requests before claiming responsive verification.

Confirm that added state, JavaScript, or dependencies serve behavior not already provided by the existing implementation or supported platform. Report browser checks not run; static inspection is not browser verification.

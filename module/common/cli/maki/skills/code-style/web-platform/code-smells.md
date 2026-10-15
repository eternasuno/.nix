# Web Platform Code Smells

Apply to HTML, CSS, DOM, forms, browser compatibility, and accessibility. Verify affected behavior in the browser when possible; disclose static-only checks.

- **Browser state mirrored into application state:** inspect duplicated open, checked, disabled, validity, or styling state. Prefer semantic HTML, CSS, and native APIs when they meet supported-browser and interaction requirements. Keep framework state when business logic, coordination, persistence, URL sync, or async workflows actually need ownership.
- **Incorrect semantics or incomplete interaction:** inspect action versus navigation elements, labels, accessible names, keyboard access, visible focus, reading order, dismissal, and focus restoration. A checkbox is not a modal; radio visibility tricks or ARIA roles alone do not implement accessible tabs.
- **Duplicated form validation:** compare field signals and JavaScript rules against native constraints, `ValidityState`, and `checkValidity()`. Retain custom business constraints and server validation; client validation is not a trust boundary.
- **Premature or inaccessible error UI:** check untouched required inputs, error associations, and failed submissions. Prefer `:user-invalid` where supported and one form-level submitted state when needed instead of per-field validity mirrors.
- **Misused validation APIs:** `novalidate` disables automatic submission validation/UI, not constraints or validity APIs. A custom handler must block invalid business submission and read payload only after validation passes. `reportValidity()` requests native popups; use it only when that UI is intended. Clear resolved custom validity errors.
- **JavaScript layout or global styling for local needs:** inspect CSS layout, intrinsic sizing, existing tokens, themes, and cascade before adding observers, spacers, breakpoints, resets, or broad overrides.
- **Inaccessible presentation:** check narrow widths, long content, zoom, visual versus reading order, hover-only actions, contrast, themes, forced colors, and reduced motion as affected. Content must remain usable when animations do not run.
- **Unverified compatibility or loading regressions:** derive browser targets before adding or removing fallbacks. Preserve usable optional enhancements, media dimensions, and prompt loading of likely primary above-the-fold imagery.

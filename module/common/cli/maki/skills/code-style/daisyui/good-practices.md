# daisyUI Component and Theme Rules

Apply when selecting or changing daisyUI components, component markup, themes, or configuration, or when adopting it is authorized. Preserve installed-version compatibility; a component edit does not authorize installation, upgrades, or configuration migration.

## Components and styling

- Start with a daisyUI component that matches the required behavior. Prefer its built-in styles and variants over recreating them with utilities or custom CSS; accept minor visual differences rather than overriding defaults unless an explicit requirement, accessibility, or necessary interaction requires the difference. Extend with Tailwind utilities for unmet requirements, and use utilities for components the library does not provide. Add custom CSS only for a requirement those options cannot meet.
- Consult version-matched component documentation when selecting an unfamiliar component or changing its structure or behavior. Search by intended interaction, not only the user's wording; for an explicitly named component, check its documentation first.
- Preserve the version-matched component structure and adapt documentation examples to project syntax; example markup does not establish a complete interaction contract.
- Prefer daisyUI semantic theme colors and their matching content colors. Do not add dark-mode overrides to already theme-aware semantic colors.
- When wrapping library controls, preserve filled/semantic hover variants rather than forcing a ghost-style hover onto every button. Check idle, hover, focus, invalid + focused, and disabled combinations; remove obsolete version-specific classes instead of compensating with unrelated overrides.

## Installation and configuration

- For authorized installation or upgrades, select the newest compatible daisyUI release after checking the project's Tailwind, runtime, and dependency constraints. Use `latest` only when it resolves to a compatible release; otherwise select the newest compatible version explicitly.
- Use the project package manager and avoid duplicate plugin setup. Prefer dependency installation over CDN delivery unless the task requires a browser-only setup.
- Change only required theme tokens and configuration values. Do not copy complete default configurations or theme token sets when overriding existing values suffices. If borders disappear or controls look malformed, inspect computed styles and the installed component's token dependencies before adding per-control fixes. In daisyUI 5 custom themes, check geometry/effect tokens such as `--border`, `--depth`, and `--noise`, plus required semantic color/content pairs; do not assume declaring colors alone supplies them.

For installation and build integration, start with the [official installation guide](https://daisyui.com/docs/install/); for configuration changes, use the [configuration reference](https://daisyui.com/docs/config/). Verify instructions against the selected version. Keep API syntax, class catalogs, and full examples in upstream documentation rather than duplicating them here.

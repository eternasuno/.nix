# daisyUI Component and Theme Rules

Apply when selecting or changing daisyUI components, component markup, themes, or configuration, or when adopting it is authorized. Preserve installed-version compatibility; a component edit does not authorize installation, upgrades, or configuration migration.

## Components and styling

- Start with a daisyUI component that matches the required behavior. Prefer its built-in styles and variants over recreating them with utilities or custom CSS; accept minor visual differences rather than overriding defaults unless an explicit requirement, accessibility, or necessary interaction requires the difference. Extend with Tailwind utilities for unmet requirements, and use utilities for components the library does not provide. Add custom CSS only for a requirement those options cannot meet.
- Consult version-matched component documentation when selecting an unfamiliar component or changing its structure or behavior. Search by intended interaction, not only the user's wording; for an explicitly named component, check its documentation first.
- Preserve the version-matched component structure and adapt documentation examples to project syntax; example markup does not establish a complete interaction contract.
- Prefer daisyUI semantic theme colors and their matching content colors. Do not add dark-mode overrides to already theme-aware semantic colors.
- When wrapping library controls, preserve filled/semantic hover variants rather than forcing a ghost-style hover onto every button. Check idle, hover, focus, invalid + focused, and disabled combinations; remove obsolete version-specific classes instead of compensating with unrelated overrides.

## Installation and configuration

- For authorized installation or upgrades, select the newest release compatible with the project's Tailwind and runtime constraints, using the project package manager without duplicate plugin setup. Prefer package installation over CDN delivery unless a browser-only setup is required.
- Override only required theme tokens and configuration values rather than copying full defaults. If borders disappear or controls look malformed, inspect computed styles and token dependencies before adding per-control fixes; in daisyUI 5 custom themes, check geometry/effect tokens (`--border`, `--depth`, `--noise`) alongside semantic color/content pairs.
- Consult the version-matched [installation](https://daisyui.com/docs/install/) and [configuration](https://daisyui.com/docs/config/) docs when changing setup.

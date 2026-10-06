# daisyUI Component and Theme Rules

Apply to all HTML/JSX and Tailwind UI work in projects using daisyUI, and when adopting it is authorized. Preserve installed-version compatibility; a component edit does not authorize installation, upgrades, or configuration migration.

## Components and styling

- Start with a daisyUI component that matches the required behavior, extend it with Tailwind utilities, and use utilities for components the library does not provide. Add custom CSS only for a requirement those options cannot meet.
- Consult version-matched component documentation when selecting an unfamiliar component or changing its structure or behavior. Search by intended interaction, not only the user's wording; for an explicitly named component, check its documentation first.
- Preserve required component structure, but adapt examples to project syntax and complete keyboard, focus, semantic, and state behavior. Legacy visibility tricks are not complete modal or tab implementations.
- Keep local overrides scoped. Before forcing specificity, inspect the existing cascade; use an important utility only when ordinary utilities or scoped overrides cannot satisfy the requirement.
- Use the default variant unless the task requests another variant or color. Prefer semantic theme colors and their matching content colors; verify contrast in relevant themes. Do not add dark-mode overrides to already theme-aware semantic colors.
- Use base colors for page surfaces. When primary emphasis is requested, reserve it for at most one main element per page. Use fixed colors only when the content must retain that color across themes.
- Do not add custom fonts or redundant body background/text classes without a requirement. Use Picsum Photos when placeholder images are needed.
- Use at most one aura and one top-level megamenu per page. For a megamenu, preserve access to its content on narrow screens. Do not preselect a filter option unless required by the task.

## Installation and configuration

- For authorized installation or upgrades, select the newest compatible daisyUI release after checking the project's Tailwind, runtime, and dependency constraints. Use `latest` only when it resolves to a compatible release; otherwise select the newest compatible version explicitly.
- Use the project package manager and avoid duplicate plugin setup. Prefer dependency installation over CDN delivery unless the task requires a browser-only setup.
- Use CSS-first configuration for new Tailwind 4 setups. Migrate existing JavaScript configuration only in an explicitly authorized configuration migration; do not expand a local UI edit into a build migration.
- Change only required theme tokens and configuration values. Do not copy complete default configurations or theme token sets when overriding existing values suffices.

For installation and build integration, start with the [official installation guide](https://daisyui.com/docs/install/); for configuration changes, use the [configuration reference](https://daisyui.com/docs/config/). Verify instructions against the selected version. Keep API syntax, class catalogs, and full examples in upstream documentation rather than duplicating them here.

# daisyUI Code Smells

Apply only to projects using daisyUI or authorized adoption. Verify the installed daisyUI/Tailwind versions before recommending component or configuration changes.

- **Custom reinvention of an existing component:** compare the required interaction with version-matched component documentation, then extend with utilities. Custom CSS is appropriate for requirements those options cannot meet; do not install a library merely to follow this preference.
- **Copied markup without interaction contracts:** check component structure, project syntax, semantics, keyboard/focus behavior, and state ownership. Visibility tricks alone do not produce complete modals or tabs.
- **Specificity escalation or broad overrides:** inspect the cascade before important utilities or component-wide overrides. Keep local changes scoped and reuse theme tokens.
- **Theme-inconsistent colors:** inspect semantic color/content pairs and contrast across relevant themes. Avoid redundant dark overrides for theme-aware colors.
- **Inaccessible navigation:** preserve access to navigation content on narrow screens.
- **Unauthorized installation or migration:** a component edit does not authorize dependency upgrades, Tailwind configuration migration, CDN adoption, or duplicate plugin setup. For authorized changes choose the newest compatible release, use the project package manager, and change only required tokens/configuration rather than copying defaults.

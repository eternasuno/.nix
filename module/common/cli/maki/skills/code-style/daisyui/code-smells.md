# daisyUI Code Smells

Apply when reviewing daisyUI component selection, markup, themes, configuration, or authorized adoption. Verify the installed daisyUI/Tailwind versions before recommending component or configuration changes.

- **Custom reinvention of built-in components or styles:** compare the required interaction and appearance with version-matched components and variants. Prefer built-in styles and accept minor visual differences unless an explicit requirement, accessibility, or necessary interaction requires customization. Extend with utilities only for unmet requirements; use custom CSS only when those options cannot meet them. Do not install a library merely to follow this preference.
- **Incompatible component markup:** check required structure against the installed version and adapt documentation examples to project syntax; copied markup does not establish a complete interaction contract.
- **Theme-inconsistent colors:** inspect daisyUI semantic color/content pairs. Avoid redundant dark overrides for theme-aware colors.
- **Unauthorized installation or migration:** a component edit does not authorize dependency upgrades, Tailwind configuration migration, CDN adoption, or duplicate plugin setup. For authorized changes choose the newest compatible release, use the project package manager, and change only required tokens/configuration rather than copying defaults.

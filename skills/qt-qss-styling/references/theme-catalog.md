# Theme Catalog

Use this file to pick a starting point before editing a QSS theme.

## Available Themes

### `MaterialDark.qss`

- Best for: IDE-like or developer-tool UIs
- Visual traits: near-black surfaces, cyan-green accent, thin underline emphasis on controls
- Good source sections: buttons, tabs, line edits, menus, sliders

### `ElegantDark.qss`

- Best for: restrained dark desktop tooling
- Visual traits: dark neutrals, softer contrast than AMOLED
- Good source sections: balanced global theme structure

### `AMOLED.qss`

- Best for: high-contrast black UI
- Visual traits: black backgrounds, vivid accent contrast
- Good source sections: OLED-style full-app theming

### `Ubuntu.qss`

- Best for: light desktop theme with warm orange accents
- Visual traits: gradients, rounded borders, orange hover states, fuller scrollbar styling
- Good source sections: scrollbars, buttons, menus, tabs

### `MacOS.qss`

- Best for: desktop controls with image-backed arrows
- Visual traits: cleaner light styling, URL-based image resources
- Good source sections: arrow assets and resource-path handling

### `ConsoleStyle.qss`

- Best for: terminal-like tools or diagnostics panels
- Visual traits: utility-first, high readability

### `ManjaroMix.qss`

- Best for: modern Linux-inspired styling
- Visual traits: minimalist arrows, custom checkbox visuals

### `NeonButtons.qss`

- Best for: CTA-heavy or demo interfaces
- Visual traits: strong accent glow and showcase buttons

### `Aqua.qss`

- Best for: light glossy styling
- Visual traits: brighter palette, desktop-theme feel

## Selection Heuristics

- Need a maintainable dark baseline: start with `MaterialDark.qss`.
- Need the richest light-theme widget coverage: start with `Ubuntu.qss`.
- Need asset-backed control arrows: inspect `MacOS.qss` and `QSS_IMG/`.
- Need only standout button treatments: inspect `NeonButtons.qss` and merge selectively.

## File Locations

- Bundled copies: `assets/qtqss-samples/*.qss`
- Bundled images: `assets/qtqss-samples/QSS_IMG/`
- Original source repo used to build this skill: `D:\github\QtQss\QSS`

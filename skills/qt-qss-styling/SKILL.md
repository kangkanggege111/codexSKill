---
name: qt-qss-styling
description: Author, refactor, review, or explain Qt style sheets for QWidget-based apps. Use when Codex is writing or editing `.qss` files, adding `setStyleSheet(...)` code, styling PyQt/PySide/Qt Widgets controls, porting a visual theme into QSS, or debugging selector/state/resource issues in Qt widget styling. Also use when the user asks in Chinese to write or modify "Qt样式", "QSS样式", "暗黑主题", "深色主题", "控件皮肤", "Qt界面美化", or "Qt控件主题".
---

# Qt QSS Styling

Use this skill for Qt Widgets styling work. Treat the bundled `QtQss` examples as reference material for theme direction and widget-state patterns, not as files to paste wholesale unless the user explicitly wants a full imported theme.

## Quick Start

1. Identify the target stack: Qt Widgets, PyQt5/PyQt6, PySide2/PySide6, or C++ Qt.
2. Identify the styling scope:
   - single widget or state fix
   - one component family such as buttons, tabs, or scrollbars
   - full application theme
3. If the request implies a theme direction, read [references/theme-catalog.md](references/theme-catalog.md).
4. If the request needs selector/state help, read [references/widget-patterns.md](references/widget-patterns.md).
5. If the request is in Chinese or the user wants Chinese guidance, read [references/zh-guide.md](references/zh-guide.md).
6. If the request needs project integration code, read [references/integration-examples.md](references/integration-examples.md).
7. If the request needs a new palette-derived theme, render [assets/templates/dark-tokenized-template.qss](assets/templates/dark-tokenized-template.qss) with [scripts/render_qss_template.py](scripts/render_qss_template.py).
8. Edit the smallest relevant `.qss` file or the code that loads the stylesheet.

## Working Rules

- Prefer existing project conventions over the bundled examples when the repository already has a theme.
- Keep selectors scoped when possible. Avoid broad `QWidget` rules unless the user wants an application-wide theme.
- Reuse a small palette of colors across normal, hover, pressed, selected, and disabled states.
- When a theme uses images, keep `url(...)` paths consistent with the final runtime layout. The bundled `MacOS.qss` and `QSS_IMG/` assets are the reference example.
- Preserve readability. If a visual effect needs too many gradients or border overrides, simplify before expanding coverage.
- When the user asks for a new theme, start by choosing one bundled theme family and adapt it instead of inventing dozens of unrelated rules.

## Authoring Convention

- Write skill rules, headings, workflow steps, and machine-facing instructions in English.
- Write explanatory comments for humans in Chinese when comments are needed.
- Keep code identifiers, file names, selectors, palette tokens, and command examples in their original technical language.
- Do not mix bilingual wording inside the same rule sentence unless the Chinese phrase is itself a user trigger or a literal example.

## Theme Selection

Use these defaults unless the user specifies a visual direction:

- dark developer UI: `MaterialDark.qss` or `ElegantDark.qss`
- pure black / OLED look: `AMOLED.qss`
- Linux desktop / warm light theme: `Ubuntu.qss`
- macOS-like controls with asset-backed arrows: `MacOS.qss`
- accent-heavy or playful buttons: `NeonButtons.qss`
- terminal / utility styling: `ConsoleStyle.qss`

Read [references/theme-catalog.md](references/theme-catalog.md) before adapting a bundled theme.

## Authoring Flow

### Small edits

- Find the exact selector and pseudo-state involved.
- Modify only the affected widget family.
- Add hover, pressed, selected, and disabled states only when the widget actually uses them.

### New component styling

- Start from the base selector.
- Add interactive states in this order: `:hover`, `:pressed`, `:checked` or `:selected`, `:disabled`.
- For compound widgets such as `QComboBox`, `QScrollBar`, and `QTabWidget`, mirror the subcontrols used in the bundled examples rather than guessing names.

### Full theme work

- Choose a base theme family from the bundled assets.
- Extract a palette first: background, surface, border, text, muted text, accent, accent-hover.
- Apply the palette consistently to `QMainWindow`, dialogs, text inputs, buttons, menus, tabs, progress controls, and scrollbars.
- If the user wants a direct derivative of a bundled theme, copy the closest file and then rename/rework colors and spacing.

## Bundled Resources

- Theme samples live in [assets/qtqss-samples](assets/qtqss-samples).
- A reusable dark template lives in [assets/templates/dark-universal-template.qss](assets/templates/dark-universal-template.qss).
- A tokenized dark template lives in [assets/templates/dark-tokenized-template.qss](assets/templates/dark-tokenized-template.qss).
- Theme overview lives in [references/theme-catalog.md](references/theme-catalog.md).
- Common selector and subcontrol patterns live in [references/widget-patterns.md](references/widget-patterns.md).
- Chinese usage notes live in [references/zh-guide.md](references/zh-guide.md).
- Integration snippets live in [references/integration-examples.md](references/integration-examples.md).
- Palette rendering script lives in [scripts/render_qss_template.py](scripts/render_qss_template.py).

Use the samples selectively:

- Read one or two relevant `.qss` files instead of loading every sample.
- Copy only the widget sections you need.
- Keep image-backed styles together with their referenced assets.
- Prefer the tokenized template plus render script when the user wants a fast custom theme from a small palette.

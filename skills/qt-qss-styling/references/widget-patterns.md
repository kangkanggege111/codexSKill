# Widget Patterns

Use this file when a request is about QSS structure, selectors, or widget-state coverage.

## Core Selector Strategy

- Style application surfaces with `QMainWindow`, `QDialog`, `QMenuBar`, and `QMenu`.
- Style text entry separately for `QLineEdit`, `QPlainTextEdit`, and `QTextEdit`.
- Style buttons separately for `QPushButton` and `QToolButton`; their hover and pressed behavior often differs.
- For item controls, use specific selectors such as `QTabBar::tab`, `QMenu::item`, and `QProgressBar::chunk`.

## Common State Coverage

Add pseudo-states only where they matter:

- `:hover` for pointer feedback
- `:pressed` for buttons and scrollbar line controls
- `:checked` / `:unchecked` for checkboxes and radio buttons
- `:selected` for tabs, menus, and list-like controls
- `:disabled` where the visual fallback must remain legible

## Subcontrols Worth Reusing

### Combo boxes

- `QComboBox`
- `QComboBox:editable`
- `QComboBox QAbstractItemView`
- `QComboBox::drop-down`

### Tabs

- `QTabWidget::pane`
- `QTabBar::tab`
- `QTabBar::tab:selected`

### Progress bars

- `QProgressBar`
- `QProgressBar::chunk`

### Scrollbars

- `QScrollBar:horizontal` / `QScrollBar:vertical`
- `QScrollBar::handle:*`
- `QScrollBar::add-line:*` / `QScrollBar::sub-line:*`
- `QScrollBar::add-page:*` / `QScrollBar::sub-page:*`
- `QScrollBar::left-arrow`, `right-arrow`, `up-arrow`, `down-arrow`

### Checkboxes and radio buttons

- `QCheckBox::indicator:checked`
- `QCheckBox::indicator:unchecked`
- `QRadioButton::indicator:checked`
- `QRadioButton::indicator:!checked`

## Practical Guidance

- Prefer a few repeated dimensions such as one border radius and one padding scale.
- Keep disabled colors distinct from normal text but still readable.
- When debugging "QSS not applied", verify:
  - the project uses Qt Widgets rather than Qt Quick
  - the stylesheet is loaded after widget creation when required by the codebase
  - the selector matches the real widget class
  - image URLs resolve relative to the runtime stylesheet location
  - the issue is not a palette/native-style limitation

## Sample Mining

Use these bundled files as focused references:

- `MaterialDark.qss`: compact dark-state patterns
- `Ubuntu.qss`: full scrollbar and gradient treatment
- `MacOS.qss`: image resource usage
- `NeonButtons.qss`: accent-heavy button ideas

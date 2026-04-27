# Integration Examples

Use this file when the user wants code that loads or switches QSS themes in a real application.

## PySide6 / PyQt6: load from file

```python
from pathlib import Path
from PySide6.QtWidgets import QApplication

def load_qss(app: QApplication, qss_path: str) -> None:
    qss = Path(qss_path).read_text(encoding="utf-8")
    app.setStyleSheet(qss)
```

## PySide6 / PyQt6: switch themes at runtime

```python
from pathlib import Path
from PySide6.QtWidgets import QApplication

def apply_theme(app: QApplication, theme_name: str) -> None:
    qss_path = Path("themes") / f"{theme_name}.qss"
    app.setStyleSheet(qss_path.read_text(encoding="utf-8"))
```

## C++ Qt Widgets: load from file

```cpp
#include <QApplication>
#include <QFile>
#include <QTextStream>

static void loadStyleSheet(QApplication& app, const QString& path) {
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return;
    }
    QTextStream in(&file);
    app.setStyleSheet(in.readAll());
}
```

## Resource-path guidance

- If a `.qss` file uses `url(...)`, keep images next to the deployed stylesheet or move them into Qt resources.
- For app bundles or installers, prefer `.qrc` resource paths for stable packaging.
- When a user reports "icons missing but colors apply", inspect relative paths first.

## Runtime decisions

- Apply one global stylesheet at `QApplication` level for whole-app theming.
- Apply per-widget `setStyleSheet(...)` only for local exceptions or temporary overrides.
- When a repo already mixes palette and QSS styling, avoid resetting everything globally unless the user asks for a full theme rewrite.

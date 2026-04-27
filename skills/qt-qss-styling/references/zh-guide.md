# 中文使用说明

这个 skill 用来处理 Qt Widgets 的界面样式，尤其是 `.qss` 文件、`setStyleSheet(...)` 调用，以及 PyQt / PySide / C++ Qt Widgets 的控件美化。

## 这些中文请求应该触发本 skill

- 写一个 Qt 的 QSS 样式
- 帮我改一下 PyQt 的按钮样式
- 做一个 Qt 暗黑主题
- 优化一下 QTableWidget / QTreeWidget / QTabWidget 的皮肤
- 修复 QSS 不生效、hover 没反应、边框颜色不对
- 给 Qt Widgets 做一套统一的深色主题

## 工作方式

1. 先判断是局部控件修改，还是整套主题。
2. 如果用户没有给风格，优先从深色稳健风格开始，默认参考 `MaterialDark.qss`。
3. 只修改必要的选择器，不要一开始就全局覆盖所有 `QWidget`。
4. 对交互控件优先补齐这些状态：
   - `:hover`
   - `:pressed`
   - `:selected` 或 `:checked`
   - `:disabled`
5. 如果用户要的是“通用模板”，优先从 `assets/templates/dark-universal-template.qss` 开始改。

## 中文场景下的默认策略

- “暗黑主题 / 深色主题”：优先用深灰背景 + 蓝绿色强调色，保证长时间使用不刺眼。
- “科技感一点”：可以在按钮、Tab、选中态上增强强调色，但不要让所有控件都发光。
- “像 IDE / 开发工具”：重点处理 `QPlainTextEdit`、`QTreeView`、`QTableView`、`QTabWidget`、菜单和滚动条。
- “像桌面软件”：重点处理 `QMainWindow`、`QDialog`、按钮、输入框、菜单栏、状态栏。

## 常见问题

### QSS 不生效

优先检查：

- 项目是不是 Qt Widgets，而不是 Qt Quick
- 样式是否真的加载到了目标 widget
- 选择器类名是否匹配真实控件
- 子控件是不是应该用 `::subcontrol`
- 图片 `url(...)` 路径是否相对最终运行位置可访问

### 样式太乱

- 收敛颜色数量
- 收敛圆角和边框宽度
- 把 normal / hover / pressed 的差异控制在同一套色系内

### 想快速出一版可用主题

直接基于：

- `assets/templates/dark-universal-template.qss`
- `assets/qtqss-samples/MaterialDark.qss`
- `assets/qtqss-samples/ElegantDark.qss`

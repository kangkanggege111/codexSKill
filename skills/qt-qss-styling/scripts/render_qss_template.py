#!/usr/bin/env python
from __future__ import annotations

import argparse
import json
from pathlib import Path


# 默认调色板：用于快速生成一套可落地的深色主题。
DEFAULT_PALETTE = {
    "BG_0": "#20252b",
    "BG_1": "#171c22",
    "BG_2": "#1b2026",
    "SURFACE_0": "#2a313a",
    "SURFACE_1": "#313a45",
    "BORDER_0": "#39424d",
    "BORDER_1": "#4a5866",
    "TEXT_0": "#d7dce2",
    "TEXT_1": "#e7edf3",
    "TEXT_MUTED": "#aeb8c2",
    "TEXT_INV": "#ffffff",
    "ACCENT_0": "#236c90",
    "ACCENT_1": "#48a6d9",
}


def load_palette(path: str | None) -> dict[str, str]:
    # 如果没有传入外部调色板，则直接使用默认配色。
    palette = DEFAULT_PALETTE.copy()
    if not path:
        return palette
    # 兼容 Windows 下常见的 UTF-8 BOM JSON 文件。
    data = json.loads(Path(path).read_text(encoding="utf-8-sig"))
    for key, value in data.items():
        if key not in palette:
            raise KeyError(f"Unknown palette key: {key}")
        palette[key] = value
    return palette


def render(template: str, palette: dict[str, str]) -> str:
    # 按 token 名称做直接替换，保持模板简单透明。
    output = template
    for key, value in palette.items():
        output = output.replace(f"{{{{{key}}}}}", value)
    return output


def main() -> None:
    parser = argparse.ArgumentParser(description="Render a tokenized Qt QSS template.")
    parser.add_argument("template", help="Path to tokenized .qss template")
    parser.add_argument("output", help="Path to rendered .qss output")
    parser.add_argument(
        "--palette",
        help="Optional JSON file overriding palette tokens. Example: {\"ACCENT_0\": \"#ff6600\"}",
    )
    args = parser.parse_args()

    # 读取模板、合成调色板并输出最终 qss 文件。
    template = Path(args.template).read_text(encoding="utf-8")
    palette = load_palette(args.palette)
    rendered = render(template, palette)
    Path(args.output).write_text(rendered, encoding="utf-8")


if __name__ == "__main__":
    main()

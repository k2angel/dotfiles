from __future__ import annotations

import argparse
import ast
import json
import re
from pathlib import Path
from typing import Any


def nix_attr_key(key: str) -> str:
    """Nix の属性名として出力する。"""
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_'-]*", key):
        return key

    return nix_string(key)


def nix_string(value: str) -> str:
    """Python string -> Nix string."""
    value = (
        value
        .replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\n", "\\n")
        .replace("\r", "\\r")
        .replace("\t", "\\t")
        .replace("${", "\\${")
    )
    return f'"{value}"'


def nix_value(value: Any, indent: int = 0) -> str:
    """JSON-compatible Python value -> Nix expression."""
    if value is None:
        return "null"

    if value is True:
        return "true"

    if value is False:
        return "false"

    if isinstance(value, str):
        return nix_string(value)

    if isinstance(value, int):
        return str(value)

    if isinstance(value, float):
        return repr(value)

    if isinstance(value, list):
        if not value:
            return "[]"

        pad = " " * (indent + 2)
        parent_pad = " " * indent

        return (
            "[\n"
            + "\n".join(
                f"{pad}{nix_value(v, indent + 2)}"
                for v in value
            )
            + f"\n{parent_pad}]"
        )

    if isinstance(value, dict):
        if not value:
            return "{}"

        pad = " " * (indent + 2)
        parent_pad = " " * indent

        lines = []
        for key, val in value.items():
            lines.append(
                f"{pad}{nix_attr_key(str(key))} = "
                f"{nix_value(val, indent + 2)};"
            )

        return (
            "{\n"
            + "\n".join(lines)
            + f"\n{parent_pad}}}"
        )

    raise TypeError(f"unsupported type: {type(value).__name__}")


def find_matching_paren(text: str, start: int) -> int:
    """Find the closing ')' corresponding to the '(' at start."""
    depth = 1
    quote: str | None = None
    escaped = False
    i = start + 1

    while i < len(text):
        ch = text[i]

        if quote:
            if escaped:
                escaped = False
            elif ch == "\\":
                escaped = True
            elif ch == quote:
                quote = None

            i += 1
            continue

        if text.startswith("//", i):
            nl = text.find("\n", i + 2)
            i = len(text) if nl < 0 else nl + 1
            continue

        if text.startswith("/*", i):
            end = text.find("*/", i + 2)
            if end < 0:
                raise ValueError("unterminated block comment")
            i = end + 2
            continue

        if ch in "\"'":
            quote = ch
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
            if depth == 0:
                return i

        i += 1

    raise ValueError("unterminated user_pref()")


def split_args(text: str) -> tuple[str, str]:
    """Split user_pref(key, value) into key and value."""
    depth = 0
    quote: str | None = None
    escaped = False

    for i, ch in enumerate(text):
        if quote:
            if escaped:
                escaped = False
            elif ch == "\\":
                escaped = True
            elif ch == quote:
                quote = None
            continue

        if ch in "\"'":
            quote = ch
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        elif ch == "," and depth == 0:
            return text[:i].strip(), text[i + 1:].strip()

    raise ValueError("user_pref() does not contain a top-level comma")


def parse_js_value(text: str) -> Any:
    """
    Parse the usual values found in Firefox user_pref().
    Supports JSON plus JS/Python-ish literals.
    """
    text = text.strip()

    try:
        return json.loads(text)
    except json.JSONDecodeError:
        pass

    converted = re.sub(r"\btrue\b", "True", text)
    converted = re.sub(r"\bfalse\b", "False", converted)
    converted = re.sub(r"\bnull\b", "None", converted)

    try:
        return ast.literal_eval(converted)
    except (SyntaxError, ValueError) as e:
        raise ValueError(f"unsupported value: {text}") from e


def parse_user_pref(text: str) -> dict[str, Any]:
    result: dict[str, Any] = {}

    for match in re.finditer(r"\buser_pref\s*\(", text):
        open_paren = text.find("(", match.start())
        close_paren = find_matching_paren(text, open_paren)

        args = text[open_paren + 1:close_paren]
        key_text, value_text = split_args(args)

        try:
            key = json.loads(key_text)
        except json.JSONDecodeError:
            key = ast.literal_eval(key_text)

        if not isinstance(key, str):
            raise ValueError(f"preference key is not a string: {key!r}")

        result[key] = parse_js_value(value_text)

    return result


def clean_policies(value: Any) -> Any:
    """
    Clean policies.json recursively.

    - Remove keys ending in "_comment"
    - Force top-level AppAutoUpdate to false
    """
    if isinstance(value, dict):
        result = {}

        for key, val in value.items():
            if key.endswith("_comment"):
                continue

            result[key] = clean_policies(val)

        return result

    if isinstance(value, list):
        return [clean_policies(item) for item in value]

    return value


def load_policies(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as f:
        value = json.load(f)

    value = value["policies"]

    if not isinstance(value, dict):
        raise ValueError(f"{path}: top level must be an object")

    value = clean_policies(value)

    # policies.json では AppAutoUpdate を必ず false にする
    value["AppAutoUpdate"] = False

    return value


def main() -> None:
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--user-js",
        type=Path,
        help="Firefox user.js / prefs.js",
    )

    parser.add_argument(
        "--policies",
        type=Path,
        help="Firefox policies.json",
    )

    args = parser.parse_args()

    if args.user_js:
        data = parse_user_pref(
            args.user_js.read_text(encoding="utf-8")
        )
    elif args.policies:
        data = load_policies(args.policies)
    else:
        parser.error("specify --user-js or --policies")

    print(nix_value(data))


if __name__ == "__main__":
    main()

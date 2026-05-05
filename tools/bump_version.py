#!/usr/bin/env python3
"""Bump the app version in web/index.html and lib/services/version_service.dart."""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
INDEX_HTML = ROOT / "web" / "index.html"
VERSION_DART = ROOT / "lib" / "services" / "version_service.dart"


def get_version_html(text: str) -> int | None:
    m = re.search(r'flutter_bootstrap\.js\?v=(\d+)', text)
    return int(m.group(1)) if m else None


def get_version_dart(text: str) -> int | None:
    m = re.search(r'static const int _clientVersion = (\d+);', text)
    return int(m.group(1)) if m else None


def set_version_html(text: str, version: int) -> str:
    return re.sub(
        r'(flutter_bootstrap\.js\?v=)\d+',
        rf'\g<1>{version}',
        text,
    )


def set_version_dart(text: str, version: int) -> str:
    return re.sub(
        r'(static const int _clientVersion = )\d+(;)',
        rf'\g<1>{version}\2',
        text,
    )


def main() -> None:
    if len(sys.argv) > 2:
        print("Usage: bump_version.py [new_version]")
        sys.exit(1)

    html_text = INDEX_HTML.read_text(encoding="utf-8")
    dart_text = VERSION_DART.read_text(encoding="utf-8")

    html_ver = get_version_html(html_text)
    dart_ver = get_version_dart(dart_text)

    print(f"  index.html version : {html_ver}")
    print(f"  version_service.dart version: {dart_ver}")

    if html_ver is None or dart_ver is None:
        print("Error: could not parse version from one or both files.")
        sys.exit(1)

    if len(sys.argv) == 2:
        try:
            new_version = int(sys.argv[1])
        except ValueError:
            print(f"Error: '{sys.argv[1]}' is not a valid integer version.")
            sys.exit(1)
    else:
        new_version = max(html_ver, dart_ver) + 1

    print(f"  -> bumping to v{new_version}")

    INDEX_HTML.write_text(set_version_html(html_text, new_version), encoding="utf-8")
    VERSION_DART.write_text(set_version_dart(dart_text, new_version), encoding="utf-8")

    print("Done.")


if __name__ == "__main__":
    main()

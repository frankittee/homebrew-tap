#!/usr/bin/env python3

import json
import re
import sys
from pathlib import Path


FORMULA = Path("Formula/git-config-manager.rb")
TARGETS = (
    "aarch64-apple-darwin",
    "x86_64-apple-darwin",
    "aarch64-unknown-linux-musl",
    "x86_64-unknown-linux-musl",
)


def release_assets(release: dict, version: str) -> dict[str, tuple[str, str]]:
    assets = {asset["name"]: asset for asset in release["assets"]}
    selected = {}

    for target in TARGETS:
        name = f"g-v{version}-{target}.tar.gz"
        asset = assets.get(name)
        if asset is None:
            raise RuntimeError(f"Missing release asset: {name}")

        digest = asset.get("digest", "")
        if not digest.startswith("sha256:"):
            raise RuntimeError(f"Missing SHA-256 digest: {name}")

        selected[target] = (asset["browser_download_url"], digest.removeprefix("sha256:"))

    return selected


def update_formula(path: Path, version: str, assets: dict[str, tuple[str, str]]) -> bool:
    original = path.read_text()
    updated, count = re.subn(r'  version "[^"]+"', f'  version "{version}"', original, count=1)
    if count != 1:
        raise RuntimeError(f"Could not update version in {path}")

    for target, (url, sha256) in assets.items():
        pattern = (
            rf'(?P<indent>\s+)url "[^"]*g-v[^/]+-{re.escape(target)}\.tar\.gz"\n'
            rf'(?P=indent)sha256 "[0-9a-f]{{64}}"'
        )
        replacement = rf'\g<indent>url "{url}"' + "\n" + rf'\g<indent>sha256 "{sha256}"'
        updated, count = re.subn(pattern, replacement, updated, count=1)
        if count != 1:
            raise RuntimeError(f"Could not update {target} in {path}")

    if updated == original:
        return False

    path.write_text(updated)
    return True


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit(f"Usage: {sys.argv[0]} RELEASE_JSON")

    release = json.loads(Path(sys.argv[1]).read_text())
    if release["draft"] or release["prerelease"]:
        raise RuntimeError("Latest release is not a stable release")

    version = release["tag_name"].removeprefix("v")
    assets = release_assets(release, version)
    changed = update_formula(FORMULA, version, assets)
    status = "updated" if changed else "current"
    print(f"release: {version} ({status})")


if __name__ == "__main__":
    main()

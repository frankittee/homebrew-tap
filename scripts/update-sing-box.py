#!/usr/bin/env python3

import json
import re
import sys
from pathlib import Path


CHANNELS = {
    "stable": Path("Formula/sing-box.rb"),
    "latest": Path("Formula/sing-box@latest.rb"),
}

PLATFORMS = (
    "darwin-arm64",
    "darwin-amd64",
    "linux-arm64",
    "linux-amd64",
)


def select_release(releases: list[dict], channel: str) -> dict:
    for release in releases:
        tag = release["tag_name"]
        if release["draft"]:
            continue
        if channel == "stable" and not release["prerelease"]:
            return release
        if channel == "latest" and release["prerelease"]:
            return release
    raise RuntimeError(f"No {channel} release found")


def release_assets(release: dict, version: str) -> dict[str, tuple[str, str]]:
    assets = {asset["name"]: asset for asset in release["assets"]}
    selected = {}

    for platform in PLATFORMS:
        name = f"sing-box-{version}-{platform}.tar.gz"
        asset = assets.get(name)
        if asset is None:
            raise RuntimeError(f"Missing release asset: {name}")

        digest = asset.get("digest", "")
        if not digest.startswith("sha256:"):
            raise RuntimeError(f"Missing SHA-256 digest: {name}")

        selected[platform] = (asset["browser_download_url"], digest.removeprefix("sha256:"))

    return selected


def update_formula(path: Path, version: str, assets: dict[str, tuple[str, str]]) -> bool:
    original = path.read_text()
    updated, count = re.subn(
        r'  version "[^"]+"',
        f'  version "{version}"',
        original,
        count=1,
    )
    if count != 1:
        raise RuntimeError(f"Could not update version in {path}")

    for platform, (url, sha256) in assets.items():
        pattern = (
            rf'(?P<indent>\s+)url "[^"]*{re.escape(platform)}\.tar\.gz"\n'
            rf'(?P=indent)sha256 "[0-9a-f]{{64}}"'
        )
        replacement = rf'\g<indent>url "{url}"' + "\n" + rf'\g<indent>sha256 "{sha256}"'
        updated, count = re.subn(pattern, replacement, updated, count=1)
        if count != 1:
            raise RuntimeError(f"Could not update {platform} in {path}")

    if updated == original:
        return False

    path.write_text(updated)
    return True


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit(f"Usage: {sys.argv[0]} RELEASES_JSON")

    raw_releases = json.loads(Path(sys.argv[1]).read_text())
    releases = [
        release
        for page in raw_releases
        for release in (page if isinstance(page, list) else [page])
    ]

    for channel, path in CHANNELS.items():
        release = select_release(releases, channel)
        version = release["tag_name"].removeprefix("v")
        assets = release_assets(release, version)
        changed = update_formula(path, version, assets)
        status = "updated" if changed else "current"
        print(f"{channel}: {version} ({status})")


if __name__ == "__main__":
    main()

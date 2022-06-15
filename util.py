import re
import subprocess
import sys

from datetime import datetime
from pathlib import Path

FORMAT = "%Y%m%d_%H%M%S"


def exiftool(command):
    out = subprocess.run(
        ["exiftool", *command], check=True, capture_output=True, text=True
    )
    if out.stdout:
        return out.stdout.split(":")[1].strip()


def get_date(path):
    """
    return the creation date of the file, as a string

    references
    - use `-api quicktimeutc` for `exiftool`
    - https://exiftool.org/forum/index.php?topic=10070.0
    - apparently not all cameras use UTC in quicktime files like the spec says.
        iphones appear to.
    - https://exiftool.org/TagNames/EXIF.html
    - CreationDate isn't listed, but the current (2022 jun 8) .mov files for
        live photos from my iphone xs has it, and it's the only field for those
        files that has the creation date with an offset (not in utc). this matters
        when the live photo was taken in a different time zone than the one i'm in
        when i run this script.
    """
    path = Path(path)
    if not path.exists():
        print("ERROR:", path, "does not exist", file=sys.stderr)
        return

    dir = path.parent
    base = path.stem
    ext = path.suffix

    xmp = dir / (base + ".xmp")
    if (
        not xmp.exists()
        and (match := re.match("IMG_[a-zA-Z]+([0-9]+)", base)) is not None
    ):
        xmp = dir / ("IMG_" + match[1] + ".xmp")
    if xmp.exists():
        with open(xmp) as f:
            if match := re.search(r"DateCreated>(.*)</", f.read()):
                return datetime.fromisoformat(match[1]).strftime(FORMAT)

    if path.name.lower().endswith(".mov"):
        out = exiftool(["-CreationDate", "-d", FORMAT, path])
        if out:
            return out

    out = exiftool(["-CreateDate", "-d", FORMAT, "-api", "quicktimeutc", path])
    if out:
        return out

    return datetime.fromtimestamp(path.stat().st_mtime).strftime(f"{FORMAT}_mtime")


def maybe_rename(path):
    """
    return the `dest` to which the file should be renamed

    - if the file looks like it already has been renamed, return `None`
    - also return `None` if any part of the path begins with `.`, `-`, or `_`
      (unless that part of the path consists solely of `.`s)
    """
    path = Path(path)
    if not path.exists():
        print("ERROR:", path, "does not exist", file=sys.stderr)
        return

    dir = path.parent
    base = path.stem
    ext = path.suffix

    for p in path.parts:
        if re.match(r"^\.+$", p):
            continue
        if len(p) == 0:
            continue
        if p[0] in (
            ".",
            "-",
            "_",
        ):
            return
    if re.match(r"([0-9]{8})[^0-9]([0-9]{6})", base):
        return

    dest = dir / (get_date(path) + "__" + base + ext)
    return dest

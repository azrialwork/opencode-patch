#!/usr/bin/env bash
# Package built Linux glibc binaries as .tar.gz release assets.
#
# Usage: scripts/package-linux-glibc.sh <dist-dir> <output-dir>
#
# <dist-dir> is upstream's packages/opencode/dist, which contains one
# directory per built target (opencode-linux-x64/bin/opencode, ...).
# Every opencode-linux-* target found there is packaged except the musl
# ones: this repo releases glibc builds only. The build jobs only produce
# glibc targets (see release.yml), so anything musl here means the build
# configuration drifted and packaging fails loudly instead of silently
# shipping it.
set -euo pipefail

DIST_DIR="${1:?usage: package-linux-glibc.sh <dist-dir> <output-dir>}"
OUT_DIR="${2:?usage: package-linux-glibc.sh <dist-dir> <output-dir>}"

mkdir -p "$OUT_DIR"
OUT_DIR="$(cd "$OUT_DIR" && pwd)"

shopt -s nullglob
count=0
for target_dir in "$DIST_DIR"/opencode-linux-*; do
  [ -d "$target_dir" ] || continue
  name="$(basename "$target_dir")"
  case "$name" in
    *musl*)
      echo "unexpected musl target in dist: $name" >&2
      exit 1
      ;;
  esac
  [ -x "$target_dir/bin/opencode" ] || { echo "missing binary: $target_dir/bin/opencode" >&2; exit 1; }
  tar -czf "$OUT_DIR/$name.tar.gz" -C "$target_dir/bin" opencode
  echo "packaged $name.tar.gz"
  count=$((count + 1))
done

if [ "$count" -eq 0 ]; then
  echo "no opencode-linux-* targets found in $DIST_DIR" >&2
  exit 1
fi

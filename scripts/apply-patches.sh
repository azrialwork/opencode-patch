#!/usr/bin/env bash
# Apply every patches/*.patch, in filename order, to the upstream checkout.
#
# Usage: scripts/apply-patches.sh <upstream-dir>
#
# An empty patch series is valid (the current state of this repo): the
# upstream tree is left untouched. If a patch does not apply cleanly the
# script fails, which must stop the build - a release is never produced
# from a half-patched tree.
set -euo pipefail

UPSTREAM_DIR="${1:?usage: apply-patches.sh <upstream-dir>}"
PATCH_DIR="$(cd "$(dirname "$0")/.." && pwd)/patches"

shopt -s nullglob
patches=("$PATCH_DIR"/*.patch)

if [ "${#patches[@]}" -eq 0 ]; then
  echo "no patches to apply"
  exit 0
fi

for patch in "${patches[@]}"; do
  echo "applying $(basename "$patch")"
  git -C "$UPSTREAM_DIR" apply --check "$patch"
  git -C "$UPSTREAM_DIR" apply "$patch"
done

echo "applied ${#patches[@]} patch(es)"
git -C "$UPSTREAM_DIR" status --porcelain

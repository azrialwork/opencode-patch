#!/usr/bin/env bash
# Print the latest stable upstream OpenCode v1.x.x tag and its commit SHA.
#
# Output (one per line, suitable for $GITHUB_OUTPUT):
#   tag=v1.19.4
#   sha=148842ef7cb1bc34192b3fff57d0f9721ab9c801
#   version=1.19.4
#
# Tags are the source of truth for "which v1.x.x exists": listing them with
# git ls-remote is fast and gives the exact commit each tag points at.
# Whether that tag is a published, stable GitHub Release is checked
# separately by the caller (see .github/workflows/release.yml), because a
# tag can exist before its release is published.
set -euo pipefail

UPSTREAM_REPO="${UPSTREAM_REPO:-https://github.com/anomalyco/opencode.git}"

# Keep only exact v1.<minor>.<patch> tags (no prereleases, no v2, no peeled
# ^{} entries), sort by version, take the highest.
line="$(
  git ls-remote --tags "$UPSTREAM_REPO" 'refs/tags/v1.*' \
    | awk '{ sub("refs/tags/", "", $2); print $2, $1 }' \
    | grep -E '^v1\.[0-9]+\.[0-9]+ ' \
    | sort -k1,1V \
    | tail -n 1
)"

if [ -z "$line" ]; then
  echo "no stable v1.x.x tag found in $UPSTREAM_REPO" >&2
  exit 1
fi

tag="${line%% *}"
sha="${line##* }"

echo "tag=${tag}"
echo "sha=${sha}"
echo "version=${tag#v}"

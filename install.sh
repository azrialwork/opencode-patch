#!/usr/bin/env bash
# Install the latest opencode-patch release (patched OpenCode, Linux glibc).
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/azrialwork/opencode-patch/main/install.sh | bash
#   curl -fsSL .../install.sh | bash -s -- --version v1.19.4 --install-dir ~/.local/bin
#
# Options (flags or environment variables):
#   --version <tag>      Release tag to install (default: latest release)
#   --install-dir <dir>  Where to put the binary
#                        (default: /usr/local/bin if writable, else ~/.local/bin)
#
# The archive's SHA256 is always verified against the release's SHA256SUMS
# before anything is installed.
set -euo pipefail

REPO="azrialwork/opencode-patch"
VERSION="${VERSION:-}"
INSTALL_DIR="${INSTALL_DIR:-}"

while [ $# -gt 0 ]; do
  case "$1" in
    --version) VERSION="$2"; shift 2 ;;
    --install-dir) INSTALL_DIR="$2"; shift 2 ;;
    -h|--help) grep '^#' "$0" | head -n 14; exit 0 ;;
    *) echo "install.sh: unknown argument: $1" >&2; exit 1 ;;
  esac
done

fail() { echo "install.sh: $1" >&2; exit 1; }

# --- Platform: Linux + glibc only, x64 / arm64 -------------------------------
[ "$(uname -s)" = "Linux" ] || fail "only Linux is supported"
if ldd --version 2>&1 | grep -qi musl; then
  fail "musl libc detected; this build is glibc only"
fi

case "$(uname -m)" in
  x86_64|amd64)
    # The baseline build drops the AVX2 requirement for older CPUs.
    if grep -qw avx2 /proc/cpuinfo 2>/dev/null; then
      ASSET="opencode-linux-x64.tar.gz"
    else
      ASSET="opencode-linux-x64-baseline.tar.gz"
    fi
    ;;
  aarch64|arm64) ASSET="opencode-linux-arm64.tar.gz" ;;
  *) fail "unsupported architecture: $(uname -m)" ;;
esac

# --- Install dir --------------------------------------------------------------
if [ -z "$INSTALL_DIR" ]; then
  if [ -w /usr/local/bin ] || [ "$(id -u)" = "0" ]; then
    INSTALL_DIR="/usr/local/bin"
  else
    INSTALL_DIR="$HOME/.local/bin"
  fi
fi
mkdir -p "$INSTALL_DIR"
[ -w "$INSTALL_DIR" ] || fail "install dir is not writable: $INSTALL_DIR (try --install-dir ~/.local/bin)"

# --- Download + verify ---------------------------------------------------------
if [ -n "$VERSION" ]; then
  BASE="https://github.com/$REPO/releases/download/$VERSION"
else
  BASE="https://github.com/$REPO/releases/latest/download"
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Downloading $ASSET ${VERSION:-(latest)}..."
curl -fsSL -o "$TMP/$ASSET" "$BASE/$ASSET" || fail "download failed: $BASE/$ASSET"
curl -fsSL -o "$TMP/SHA256SUMS" "$BASE/SHA256SUMS" || fail "download failed: $BASE/SHA256SUMS"

echo "Verifying SHA256..."
( cd "$TMP" && sha256sum -c SHA256SUMS --ignore-missing >/dev/null ) \
  || fail "checksum mismatch for $ASSET; refusing to install"

tar -xzf "$TMP/$ASSET" -C "$TMP"
[ -f "$TMP/opencode" ] || fail "archive did not contain an 'opencode' binary"

install -m 755 "$TMP/opencode" "$INSTALL_DIR/opencode"

echo "Installed: $("$INSTALL_DIR/opencode" --version) -> $INSTALL_DIR/opencode"
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *) echo "Note: $INSTALL_DIR is not in your PATH. Add it with:" ;
     echo "  export PATH=\"$INSTALL_DIR:\$PATH\"" ;;
esac

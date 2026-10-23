#!/usr/bin/env bash
# Assemble the Termux (Android/Bionic) release tarball.
#
# Usage: termux/package-termux.sh <built-binary> <native-dir> <output-dir>
#
# <built-binary> is upstream's dist/opencode-linux-arm64-android/bin/opencode
# after patch 0014; <native-dir> holds libopentui.so and
# libopencode-compat.so from the native-termux CI job. The tarball layout
# is relative to $PREFIX so install.sh can drop the files straight in:
#
#   bin/opencode                          launcher (termux/launcher.sh)
#   lib/opencode-patch/opencode           compiled Bionic binary
#   lib/opencode-patch/libopentui.so      TUI renderer (Zig, NDK)
#   lib/opencode-patch/libopencode-compat.so  close_range shim
#
# The archive must contain exactly those four files.
set -euo pipefail

BIN=${1:?usage: package-termux.sh <built-binary> <native-dir> <output-dir>}
NATIVE_DIR=${2:?usage: package-termux.sh <built-binary> <native-dir> <output-dir>}
OUT_DIR=${3:?usage: package-termux.sh <built-binary> <native-dir> <output-dir>}
HERE=$(cd "$(dirname "$0")" && pwd)

[ -x "$BIN" ] || { echo "missing built binary: $BIN" >&2; exit 1; }
[ -f "$NATIVE_DIR/libopentui.so" ] || { echo "missing libopentui.so in $NATIVE_DIR" >&2; exit 1; }
[ -f "$NATIVE_DIR/libopencode-compat.so" ] || { echo "missing libopencode-compat.so in $NATIVE_DIR" >&2; exit 1; }

mkdir -p "$OUT_DIR"
OUT_DIR=$(cd "$OUT_DIR" && pwd)

bundle=$(mktemp -d)
trap 'rm -rf "$bundle"' EXIT
mkdir -p "$bundle/bin" "$bundle/lib/opencode-patch"
install -m755 "$HERE/launcher.sh" "$bundle/bin/opencode"
install -m755 "$BIN" "$bundle/lib/opencode-patch/opencode"
install -m755 "$NATIVE_DIR/libopentui.so" "$bundle/lib/opencode-patch/libopentui.so"
install -m644 "$NATIVE_DIR/libopencode-compat.so" "$bundle/lib/opencode-patch/libopencode-compat.so"

archive="$OUT_DIR/opencode-termux-arm64.tar.gz"
tar -C "$bundle" -czf "$archive" .

layout="bin/opencode
lib/opencode-patch/libopencode-compat.so
lib/opencode-patch/libopentui.so
lib/opencode-patch/opencode"
actual=$(tar -tzf "$archive" | grep -v '/$' | sed 's|^\./||' | sort)
if [ "$actual" != "$(printf '%s\n' "$layout" | sort)" ]; then
  echo "unexpected files in $archive" >&2
  diff <(printf '%s\n' "$layout" | sort) <(printf '%s\n' "$actual") >&2 || true
  exit 1
fi

echo "packaged opencode-termux-arm64.tar.gz"

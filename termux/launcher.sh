#!/data/data/com.termux/files/usr/bin/sh
# Launcher for the opencode-patch Termux (Android/Bionic) build.
#
# Installed as $PREFIX/bin/opencode. The real binary and its native
# libraries live in $PREFIX/lib/opencode-patch/ and are started through
# this script so the Android-specific environment is always in place.
set -eu

: "${PREFIX:=/data/data/com.termux/files/usr}"
LIBDIR="$PREFIX/lib/opencode-patch"

export OPENTUI_LIB_PATH="$LIBDIR/libopentui.so"
# @ff-labs/fff-bun ships no Android binary; fall back to the system rg.
export OPENCODE_DISABLE_FFF=1
# @parcel/watcher ships no Android binding.
export OPENCODE_EXPERIMENTAL_DISABLE_FILEWATCHER=1

# Termux targets SDK 28, so Android's seccomp policy traps close_range
# with SIGSYS and Bun dies on startup. The shim emulates that one call.
COMPAT_LIB="$LIBDIR/libopencode-compat.so"
LD_PRELOAD="$COMPAT_LIB${LD_PRELOAD:+:$LD_PRELOAD}"
export LD_PRELOAD

# Optional full state isolation for debugging: point every XDG location
# at a private root so a test run cannot read or migrate real state.
if [ -n "${OPENCODE_TERMUX_HOME:-}" ]; then
  mkdir -p "$OPENCODE_TERMUX_HOME/config" "$OPENCODE_TERMUX_HOME/data" \
    "$OPENCODE_TERMUX_HOME/cache" "$OPENCODE_TERMUX_HOME/state" "$OPENCODE_TERMUX_HOME/tmp"
  export XDG_CONFIG_HOME="$OPENCODE_TERMUX_HOME/config"
  export XDG_DATA_HOME="$OPENCODE_TERMUX_HOME/data"
  export XDG_CACHE_HOME="$OPENCODE_TERMUX_HOME/cache"
  export XDG_STATE_HOME="$OPENCODE_TERMUX_HOME/state"
  export TMPDIR="$OPENCODE_TERMUX_HOME/tmp"
fi

for file in "$LIBDIR/opencode" "$OPENTUI_LIB_PATH" "$COMPAT_LIB"; do
  if [ ! -e "$file" ]; then
    echo "opencode: missing $file" >&2
    echo "opencode: reinstall with the opencode-patch install.sh" >&2
    exit 1
  fi
done

exec "$LIBDIR/opencode" "$@"

#!/usr/bin/env bash
# Verify a built Termux (Android/Bionic) bundle before it is packaged.
#
# Usage: termux/verify.sh <binary> <libopentui.so> <arch> <compat.so>
#
# Fails unless: both ELFs match the architecture, the binary carries no
# glibc dependency, the Android OpenTUI patch is present in the bundle,
# the compat shim exports close_range/syscall, and libopentui.so has
# 16 KB LOAD alignment.
set -euo pipefail

bin=${1:?binary}
lib=${2:?libopentui}
arch=${3:?arch}
compat=${4:?compat shim}

test -s "$bin" || { echo "missing binary: $bin"; exit 1; }
test -s "$lib" || { echo "missing libopentui: $lib"; exit 1; }

case "$arch" in
  arm64) machine="AArch64" ;;
  x64) machine="X86-64" ;;
  *) echo "unknown arch: $arch" >&2; exit 1 ;;
esac

echo "== $bin"
readelf -h "$bin" | grep -q "Machine:.*${machine}" || {
  echo "wrong machine for $arch" >&2
  readelf -h "$bin"
  exit 1
}

if readelf -d "$bin" 2>/dev/null | grep NEEDED |
  grep -Eq 'ld-linux|libc\.so\.6|libgcc_s|libpthread\.so\.0'; then
  echo "glibc dependency detected" >&2
  readelf -d "$bin" | grep NEEDED
  exit 1
fi
echo "no glibc dependencies"

grep -aq "OPENTUI_LIB_PATH must point to libopentui.so on Android" "$bin" || {
  echo "android opentui patch is missing from the bundle" >&2
  exit 1
}
echo "opentui android patch: present"

echo "== $compat"
readelf -h "$compat" | grep -q "Machine:.*${machine}" || {
  echo "wrong machine for compat shim" >&2
  readelf -h "$compat"
  exit 1
}
nm -D "$compat" | grep -Eq ' (close_range|syscall)$' || {
  echo "compat shim is missing close_range/syscall" >&2
  exit 1
}

echo "== $lib"
readelf -h "$lib" | grep -q "Machine:.*${machine}" || {
  echo "wrong machine for libopentui" >&2
  readelf -h "$lib"
  exit 1
}

align=$(python3 - "$lib" <<'PY'
import re
import subprocess
import sys

out = subprocess.check_output(["readelf", "-lW", sys.argv[1]], text=True)
values = [int(m, 16) for m in re.findall(r"^\s*LOAD\s+.*\s(0x[0-9a-fA-F]+)\s*$", out, re.M)]
if not values:
    raise SystemExit("no LOAD segments found")
print(hex(min(values)))
PY
)
if [ $((align)) -lt $((0x4000)) ]; then
  echo "libopentui LOAD alignment ${align} is below 16 KB" >&2
  exit 1
fi
echo "LOAD alignment: ${align}"

if readelf -d "$lib" | grep -q 'libc++_shared'; then
  test -f "$(dirname "$lib")/libc++_shared.so" || {
    echo "libopentui needs libc++_shared.so but it is not packaged" >&2
    exit 1
  }
fi

nm -D "$lib" | grep -q 'createEventSink' || {
  echo "libopentui is missing createEventSink" >&2
  exit 1
}

echo "ok"

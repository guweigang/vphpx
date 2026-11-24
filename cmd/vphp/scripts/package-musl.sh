#!/bin/sh
# Run inside a disposable Alpine container; installs packages in that container.
set -eu
repo=$(CDPATH='' cd "$(dirname "$0")/../../.." && pwd -P)
output=${1:?usage: package-musl.sh /output/vphp}
test -f /etc/alpine-release
apk add --no-cache build-base git python3 gc-dev gc-static file ca-certificates
if [ -n "${VPHP_MUSL_V_ROOT:-}" ]; then
    v_root=$VPHP_MUSL_V_ROOT
else
    v_root=$(mktemp -d /tmp/vphp-vlang.XXXXXX)
    trap 'rm -rf "$v_root"' 0
fi
if [ ! -x "$v_root/v" ]; then
    git clone --depth 1 https://github.com/vlang/v "$v_root"
    make -C "$v_root" VEXE=./v VROOT=.
fi
export PATH="$v_root:$PATH"
VPHP_CLI_STATIC=1 sh "$repo/cmd/vphp/scripts/package.sh" "$output"
file "$output" | grep -Eq 'statically linked|static-pie linked'
"$output" -v

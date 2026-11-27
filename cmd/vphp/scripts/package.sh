#!/bin/sh
# Build one executable carrying the matching VPHP runtime and stub renderer.
set -eu
repo=$(CDPATH='' cd "$(dirname "$0")/../../.." && pwd -P)
output=${1:-"$repo/build/vphp"}
case "$output" in /*) ;; *) output="$PWD/$output" ;; esac
mkdir -p "$(dirname "$output")"
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vphp-package.XXXXXX")
trap 'rm -rf "$tmp"' 0
for source in "$repo"/cmd/vphp/*.v; do
    case "$source" in *_test.v) continue ;; esac
    cp "$source" "$tmp/"
done
cp "$repo/cmd/vphp/v.mod" "$tmp/"
python3 "$repo/cmd/vphp/scripts/embed-sdk.py" "$repo/vphp" "$tmp/sdk.json"
set -- "${VPHP_V:-v}" -prod -path "$repo:@vlib" -d vphp_bundled
if [ "$(uname -s)" = Darwin ]; then
    set -- "$@" -cflags -fbracket-depth=1024
fi
if [ "${VPHP_CLI_STATIC:-0}" = 1 ]; then
    if [ "$(uname -s)" != Linux ]; then
        printf '%s\n' 'VPHP_CLI_STATIC requires a Linux/musl build environment' >&2
        exit 1
    fi
    set -- "$@" -cflags -static -ldflags -static
fi
"$@" -o "$output" "$tmp"
printf '%s\n' "$output"

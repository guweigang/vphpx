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
python3 - "$repo/vphp" "$tmp/sdk.json" <<'PY'
import json
import pathlib
import sys
root = pathlib.Path(sys.argv[1])
files = {}
for path in sorted(root.rglob('*')):
    relative = path.relative_to(root)
    if any(part.startswith('.') or part in ('compiler', 'docs', 'assets', 'tests') for part in relative.parts):
        continue
    if path.is_file() and not path.name.endswith('_test.v') and (
        path.suffix in ('.v', '.c', '.h', '.php') or path.name == 'v.mod'
    ):
        files[relative.as_posix()] = path.read_text()
pathlib.Path(sys.argv[2]).write_text(json.dumps(files, ensure_ascii=False))
PY
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

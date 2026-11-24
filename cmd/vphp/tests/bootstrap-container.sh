#!/bin/sh
# Run only in a disposable, initially unprovisioned Linux container.
set -eu
cli=${1:-/usr/local/bin/vphp}
project_root=$(mktemp -d /tmp/vphp-bootstrap.XXXXXX)
trap 'rm -rf "$project_root"' 0
"$cli" setup --dry-run
"$cli" setup
# Each invocation must find installed tools without inheriting setup's environment.
"$cli" doctor
"$cli" setup --dry-run > "$project_root/ready.log"
grep -q 'nothing to install' "$project_root/ready.log"
"$cli" new "$project_root/extension"
"$cli" build "$project_root/extension"
"$cli" stub "$project_root/extension"
test -f "$project_root/extension/build/extension.so"
test -f "$project_root/extension/build/extension.php"
printf '%s\n' 'VPHP fresh Linux setup passed'

#!/bin/sh
set -eu

repo=$(CDPATH='' cd "$(dirname "$0")/../../.." && pwd -P)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vphp-smoke.XXXXXX")
trap 'rm -rf "$tmp"' 0

project="$tmp/External Extension"
mkdir -p "$project/extra"
project=$(CDPATH='' cd "$project" && pwd -P)
cat > "$project/entry.v" <<'EOF'
module main

import extra
import vphp

const ext_config = vphp.ExtensionConfig{name: 'standalone_probe'}

@[php_function]
fn standalone_greeting(name string) string {
	return extra.greet(name)
}

@[php_function]
@[php_arg_type(value: '(Iterator&Countable)|int')]
@[php_return_type: '(Iterator&Countable)|int']
fn standalone_identity(value vphp.PhpValue) vphp.PhpValue {
	return value
}
EOF
cat > "$project/extra/extra.v" <<'EOF'
module extra

pub fn greet(name string) string {
	return 'Hello ${name}'
}

@[php_function]
pub fn standalone_number() int {
	return 42
}
EOF

cd "$project"
"$repo/bin/vphp" check
test ! -e build
"$repo/bin/vphp" build
test -f "$project/build/standalone_probe.so"
"${VPHP_PHP:-php}" -n -d "extension=$project/build/standalone_probe.so" -r '
    if (!extension_loaded("standalone_probe")
        || standalone_greeting("PHP") !== "Hello PHP"
        || standalone_number() !== 42
        || standalone_identity(7) !== 7) {
        exit(1);
    }
'
"$repo/bin/vphp" stub --output "$tmp/Standalone Stub.php"
"${VPHP_PHP:-php}" -n -l "$tmp/Standalone Stub.php"
# shellcheck disable=SC2016
grep -F 'function standalone_identity((\Iterator&\Countable)|int $value): (\Iterator&\Countable)|int' "$tmp/Standalone Stub.php"
test ! -e vphp_bridge.v
test ! -e extra/vphp_bridge.v
test ! -e php_bridge.c

sed 's/return extra.greet(name)/return 42/' "$project/entry.v" > "$tmp/broken.v"
mv "$tmp/broken.v" "$project/entry.v"
if "$repo/bin/vphp" check > "$tmp/check.log" 2>&1; then
    echo 'check accepted an invalid V return value' >&2
    exit 1
fi
grep -F "$project/entry.v:" "$tmp/check.log"

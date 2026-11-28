#!/bin/sh
set -eu
repo=$(CDPATH='' cd "$(dirname "$0")/../../.." && pwd -P)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vphp-scaffold.XXXXXX")
trap 'rm -rf "$tmp"' 0
if [ "$#" -gt 0 ]; then
    binary=$1
else
    binary=${VPHP_PACKAGE_OUTPUT:-"$tmp/release/vphp"}
    sh "$repo/cmd/vphp/scripts/package.sh" "$binary"
fi
# The packaging source directory has already been deleted. Move only the executable.
mkdir -p "$tmp/Downloaded CLI" "$tmp/Outside Checkout"
cp "$binary" "$tmp/Downloaded CLI/vphp"
cli="$tmp/Downloaded CLI/vphp"
cd "$tmp/Outside Checkout"
expected_version=$(awk -F "'" '/^[[:space:]]*version:/ {print $2}' "$repo/cmd/vphp/v.mod")
test -n "$expected_version"
for flag in -v --version version; do
    actual_version=$(VPHP_V="$tmp/missing-v" VPHP_PHP="$tmp/missing-php" \
        VPHP_PHP_CONFIG="$tmp/missing-php-config" VPHP_CLI_SCRATCH="$tmp/missing-scratch" \
        "$cli" "$flag" 2> "$tmp/version.err")
    test "$actual_version" = "vphp $expected_version"
    test ! -s "$tmp/version.err"
done
for flag in -h --help help; do
    "$cli" "$flag" > "$tmp/help.out" 2> "$tmp/help.err"
    grep -q 'vphp new' "$tmp/help.out"
    grep -q -- '--version' "$tmp/help.out"
    test ! -s "$tmp/help.err"
done
"$cli" > "$tmp/default-help.out"
cmp "$tmp/help.out" "$tmp/default-help.out"
for command in new build check stub doctor setup; do
    for flag in -h --help; do
        "$cli" "$command" "$flag" > "$tmp/command-help.out"
        cmp "$tmp/help.out" "$tmp/command-help.out"
    done
done
for flag in --unknown --version --help; do
    status=0
    "$cli" "$flag" unexpected > "$tmp/options.out" 2> "$tmp/options.err" || status=$?
    test "$status" = 2
    test ! -s "$tmp/options.out"
    grep -q 'vphp:' "$tmp/options.err"
done
test ! -e "$tmp/missing-scratch"
sh "$repo/cmd/vphp/tests/dependencies.sh" "$cli"
"$cli" new demo
for file in src/config.v src/config.toml v.mod README.md .gitignore tests/smoke.php; do
    test -f "demo/$file"
done
if "$cli" new demo > "$tmp/existing.log" 2>&1; then
    echo 'new overwrote an existing project' >&2
    exit 1
fi
grep -q 'destination already exists' "$tmp/existing.log"
grep -q 'name = "demo"' demo/src/config.toml
if grep -q 'ExtensionConfig' demo/src/config.v; then
    echo 'new project duplicates extension configuration' >&2
    exit 1
fi
for invalid in bad-name 123demo; do
    if "$cli" new "$invalid" > "$tmp/invalid.log" 2>&1; then
        echo 'new accepted an invalid extension name' >&2
        exit 1
    fi
    test ! -e "$invalid"
done
if "$cli" new > "$tmp/missing.log" 2>&1; then
    exit 1
fi
ln -s "$tmp/missing-target" dangling
if "$cli" new dangling > "$tmp/symlink.log" 2>&1; then
    exit 1
fi
test -L dangling
test ! -e "$tmp/missing-target"
cd demo
# Explicit selection must replace the build machine's @VEXE.
cat > "$tmp/select-v" <<'SH'
#!/bin/sh
printf 'selected\n' >> "$VPHP_TEST_V_LOG"
exec "$VPHP_TEST_V_REAL" "$@"
SH
chmod +x "$tmp/select-v"
VPHP_TEST_V_REAL=${VPHP_V:-$(command -v v)}
VPHP_TEST_V_LOG="$tmp/v-selected.log"
VPHP_V="$tmp/select-v"
export VPHP_TEST_V_REAL VPHP_TEST_V_LOG VPHP_V
"$cli" check
test ! -e build
"$cli" build
"${VPHP_PHP:-php}" -n -d "extension=$PWD/build/demo.so" tests/smoke.php | grep -qx OK
"$cli" stub
"${VPHP_PHP:-php}" -n -l build/demo.php
grep -q 'function demo_hello' build/demo.php
test "$(wc -l < "$VPHP_TEST_V_LOG" | tr -d ' ')" = 3
sh "$repo/cmd/vphp/tests/toml-config.sh" "$cli" "$tmp" "$repo"
# Source launcher has the same project creation contract.
test "$("$repo/bin/vphp" -v)" = "vphp $expected_version"
"$repo/bin/vphp" -h > "$tmp/source-help.out"
cmp "$tmp/help.out" "$tmp/source-help.out"
"$repo/bin/vphp" new "$tmp/source_demo"
test -f "$tmp/source_demo/src/config.v"
printf '%s\n' 'VPHP scaffold and bundled SDK smoke passed'

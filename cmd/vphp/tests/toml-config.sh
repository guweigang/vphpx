#!/bin/sh
set -eu
cli=$1
root=$2
repo=$3
fixture="$repo/cmd/vphp/tests/fixtures/toml-config"
cat >> "$root/Outside Checkout/demo/src/config.v" <<'EOF'

const ext_config = vphp.ExtensionConfig{ name: 'demo', version: '0.1.0' }
EOF
cp "$fixture/mixed.toml" "$root/Outside Checkout/demo/src/config.toml"
mkdir -p "$root/toml-only/src"
cp "$fixture/extension.v" "$root/toml-only/src/extension.v"
cp "$fixture/config.toml" "$root/toml-only/src/config.toml"
"$cli" check "$root/toml-only"
"$cli" build "$root/toml-only"
"$cli" stub "$root/toml-only"
"${VPHP_PHP:-php}" -n -d "extension=$root/toml-only/build/tomldemo.so" -r '
if (tomldemo_hello() !== "from TOML" || phpversion("tomldemo") !== "1.2.3" || ini_get("tomldemo.answer") !== "42" || ini_set("tomldemo.answer", "9") !== false) exit(1);
'
"${VPHP_PHP:-php}" -n -d "extension=$root/toml-only/build/tomldemo.so" -d tomldemo.answer=73 -r 'if (ini_get("tomldemo.answer") !== "73") exit(1);'
"${VPHP_PHP:-php}" -n -l "$root/toml-only/build/tomldemo.php"
"$cli" check "$root/Outside Checkout/demo"
cp "$fixture/conflict.toml" "$root/Outside Checkout/demo/src/config.toml"
if "$cli" check "$root/Outside Checkout/demo" > "$root/toml-conflict.log" 2>&1; then
    echo 'conflicting ExtensionConfig and TOML accepted' >&2
    exit 1
fi
grep -F 'extension.name conflicts with ExtensionConfig.name' "$root/toml-conflict.log"
mkdir -p "$root/legacy-multiple/src"
cat > "$root/legacy-multiple/src/extension.v" <<'EOF'
module main
import vphp
const first_ext_config = vphp.ExtensionConfig{ version: '1' }
const second_ext_config = vphp.ExtensionConfig{ name: 'legacy_multiple' }
EOF
"$cli" check "$root/legacy-multiple"
mkdir -p "$root/toml-symlink/src"
cp "$fixture/extension.v" "$root/toml-symlink/src/extension.v"
ln -s "$fixture/config.toml" "$root/toml-symlink/src/config.toml"
if "$cli" check "$root/toml-symlink" > "$root/toml-symlink.log" 2>&1; then
    echo 'symlinked config.toml silently accepted' >&2
    exit 1
fi
grep -F 'symlinked source entries are unsupported' "$root/toml-symlink.log"
mkdir -p "$root/root-only"
cp "$fixture/extension.v" "$root/root-only/extension.v"
if "$cli" check "$root/root-only" > "$root/root-only.log" 2>&1; then
    echo 'root-only project unexpectedly accepted' >&2
    exit 1
fi
grep -F 'expected a source directory' "$root/root-only.log"
mkdir -p "$root/src-project/src" "$root/src-project/helper"
cat > "$root/src-project/src/config.v" <<'EOF'
module main
import helper
import vphp
@[vphp.PhpExportFunction(name: 'src_demo_value')]
fn value() string { return helper.value() }
EOF
cat > "$root/src-project/helper/helper.v" <<'EOF'
module helper
pub fn value() string { return 'sibling module' }
EOF
cat > "$root/src-project/config.toml" <<'EOF'
[extension]
name = "src_demo"
EOF
"$cli" build "$root/src-project"
"${VPHP_PHP:-php}" -n -d "extension=$root/src-project/build/src_demo.so" -r 'if (src_demo_value() !== "sibling module") exit(1);'
printf '%s\n' 'VPHP TOML config smoke passed'

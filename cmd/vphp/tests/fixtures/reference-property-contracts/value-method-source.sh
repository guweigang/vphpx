#!/bin/sh
set -eu

case "$1" in
    interface) parent="@[vphp.PhpImplements(names: 'RefMethodContract')]" ;;
    abstract) parent="@[vphp.PhpExtends('RefMethodBase')]" ;;
    *) exit 2 ;;
esac

cat <<SCRIPT
module main

import vphp

@[vphp.PhpExportClass(name: '')]
$parent
pub struct ValueRefMethodImplementation {}

@[vphp.PhpExportMethod(name: 'slot')]
@[vphp.PhpReturnType(php_type: 'mixed')]
pub fn (target &ValueRefMethodImplementation) slot(value vphp.PhpReference) vphp.PhpValue {
    return value.deref()
}
SCRIPT

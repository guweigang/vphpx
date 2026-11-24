module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassMixedInherited')]
@[php_prop: 'slot']
struct VClassUnexpectedUntyped {}

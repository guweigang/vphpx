module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassUntypedBase')]
@[vphp.PhpDeclaredProperty('slot', 'mixed')]
struct VClassUnexpectedMixed {}

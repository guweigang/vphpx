module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassTypedInherited')]
@[vphp.PhpDeclaredPropertyWithDefault('choice', 'int|float', '7')]
struct VClassUnexpectedTyped {}

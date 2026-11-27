module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRefProperty')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VValueAbstractImplementation {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VValueAbstractImplementation) get_score() int {
	return 1
}

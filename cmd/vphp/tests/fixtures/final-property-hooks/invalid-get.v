module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('BackedGetterChild')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VOverrideFinalGet {
	BackedGetterChild
}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VOverrideFinalGet) attempt_get_score() int {
	return 0
}

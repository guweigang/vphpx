module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VGetterChild')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VOverrideFinalSet {
	VGetterChild
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (mut target VOverrideFinalSet) attempt_set_score(value int) {
	target.stored = value
}

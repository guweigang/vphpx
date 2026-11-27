module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '3')]
pub struct RefHookBackedPair {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &RefHookBackedPair) get_score() vphp.PhpReference {
	return vphp.PhpReference.hook_backing()
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (target &RefHookBackedPair) set_score(value int) {}

module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('RefHookBackedChild')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct RefHookValueOverride {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &RefHookValueOverride) get_score() int {
	return 10
}

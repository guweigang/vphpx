module main

import vphp

const ext_config = vphp.ExtensionConfig{name: 'unmatched_property_hook'}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct HookGetOnly {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &HookGetOnly) read_score() int {
	return 1
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('HookGetOnly')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct HookMissingSetter {}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &HookMissingSetter) write_score(incoming int) {}

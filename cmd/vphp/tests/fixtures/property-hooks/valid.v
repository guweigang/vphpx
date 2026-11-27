module main

import vphp

const ext_config = vphp.ExtensionConfig{name: 'property_hooks'}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct HookPair {
mut:
	value int = 3 @[vphp.PhpIgnoreField]
}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &HookPair) read_score() int {
	return target.value
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (mut target HookPair) write_score(incoming int) {
	target.value = incoming * 2
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '2')]
pub struct HookPlain {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('HookPlain')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct HookChild {}

@[vphp.PhpPropertyGet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &HookChild) read_score() int {
	return 17
}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &HookChild) write_score(incoming int) {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements('HookContract')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct HookImplementation {}

@[vphp.PhpPropertyGet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &HookImplementation) read_score() int {
	return 23
}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &HookImplementation) write_score(incoming int) {}

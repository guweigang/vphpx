module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'final_property_hooks' }

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct LockedGetter {
mut:
	stored int = 3 @[vphp.PhpIgnoreField]
}

@[vphp.PhpPropertyGet(property: 'score')]
@[vphp.PhpFinalMethod]
pub fn (target &LockedGetter) get_score() int {
	return target.stored
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (mut target LockedGetter) set_score(value int) {
	target.stored = value
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('LockedGetter')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VSetterChild {
	LockedGetter
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (mut target VSetterChild) set_score(value int) {
	target.stored = value + 10
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('LockedGetter')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '4')]
pub struct BackedGetterChild {
	LockedGetter
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct LockedSetter {
mut:
	stored int = 2 @[vphp.PhpIgnoreField]
}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &LockedSetter) get_score() int {
	return target.stored
}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpFinalMethod]
pub fn (mut target LockedSetter) set_score(value int) {
	target.stored = value * 2
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('LockedSetter')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VGetterChild {
	LockedSetter
}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VGetterChild) get_score() int {
	return target.stored + 1
}

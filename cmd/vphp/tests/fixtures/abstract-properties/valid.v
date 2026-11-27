module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'abstract_properties' }

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct AbstractRead {}

const reads = vphp.PhpAbstractProperties[AbstractRead]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .get }]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRead')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct NativeRead {}

@[vphp.PhpPropertyGet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &NativeRead) read_score() int {
	return 17
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct AbstractWrite {}

const writes = vphp.PhpAbstractProperties[AbstractWrite]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .set }]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractWrite')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct NativeWrite {}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &NativeWrite) write_score(value int) {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct ConcreteGet {}

const concrete_get = vphp.PhpAbstractProperties[ConcreteGet]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .set }]
}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &ConcreteGet) read_score() int {
	return 41
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('ConcreteGet')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '7')]
pub struct NativeBackedWrite {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('ConcreteGet')]
pub struct NativeFieldWrite {
pub mut:
	score int
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct ConcreteSet {}

const concrete_set = vphp.PhpAbstractProperties[ConcreteSet]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .get }]
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (target &ConcreteSet) write_score(value int) {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('ConcreteSet')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct NativeMixedRead {}

@[vphp.PhpPropertyGet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (target &NativeMixedRead) read_score() int {
	return 51
}

module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'interface_properties' }

@[vphp.PhpExportInterface(name: 'ReadableScore')]
pub interface ReadableScore {}

const readable_score_contract = vphp.PhpInterfaceProperties[ReadableScore]{
	properties: [
		vphp.PhpInterfaceProperty{ name: 'score', php_type: 'int', access: .get },
	]
}

@[vphp.PhpExportInterface(name: 'WritableScore')]
pub interface WritableScore {}

const writable_score_contract = vphp.PhpInterfaceProperties[WritableScore]{
	properties: [
		vphp.PhpInterfaceProperty{ name: 'score', php_type: 'int', access: .set },
	]
}

@[vphp.PhpExportInterface(name: 'MutableRecord')]
@[vphp.PhpExtendsInterfaces(names: 'ReadableScore')]
pub interface MutableRecord {}

const mutable_record_contract = vphp.PhpInterfaceProperties[MutableRecord]{
	properties: [
		vphp.PhpInterfaceProperty{ name: 'label', php_type: '?string', access: .get_set },
		vphp.PhpInterfaceProperty{ name: 'data', php_type: 'mixed', access: .get_set },
	]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'ReadableScore')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VScoreReader {}

@[vphp.PhpPropertyGet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (receiver &VScoreReader) read_score() int {
	return 13
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'WritableScore')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VScoreWriter {}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpCallableAttribute('Override', '')]
pub fn (receiver &VScoreWriter) write_score(value int) {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'MutableRecord')]
@[vphp.PhpDeclaredPropertyWithDefault('label', '?string', "'initial'")]
@[vphp.PhpDeclaredProperty('data', 'mixed')]
pub struct VMutableRecord {
pub mut:
	score int
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
@[vphp.PhpImplements(names: 'ReadableScore')]
pub struct VAbstractScore {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VAbstractScore')]
pub struct VConcreteScore {
pub mut:
	score int
}

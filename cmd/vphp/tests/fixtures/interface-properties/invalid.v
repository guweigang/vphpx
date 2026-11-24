module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_interface_property' }

@[vphp.PhpExportInterface(name: 'RequiresPropertyWrite')]
pub interface RequiresPropertyWrite {}

const write_contract = vphp.PhpInterfaceProperties[RequiresPropertyWrite]{
	properties: [
		vphp.PhpInterfaceProperty{ name: 'score', php_type: 'int', access: .set },
	]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'RequiresPropertyWrite')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VMissingPropertyWrite {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (receiver &VMissingPropertyWrite) read_score() int {
	return 1
}

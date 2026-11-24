module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_abstract_property' }

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct BasePropertyWrite {}

const contract = vphp.PhpAbstractProperties[BasePropertyWrite]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .set }]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('BasePropertyWrite')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VMissingAbstractWrite {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VMissingAbstractWrite) read_score() int {
	return 1
}

module main

import vphp

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'InheritedRefPropertyContract')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct VValueInterfaceImplementation {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VValueInterfaceImplementation) get_score() int {
	return 1
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (target &VValueInterfaceImplementation) set_score(value int) {}

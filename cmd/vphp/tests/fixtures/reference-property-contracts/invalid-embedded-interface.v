module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_embedded_interface' }

pub interface VInternalParent {
	run()
}

@[vphp.PhpExportInterface(name: 'MissingParent')]
pub interface VMissingParent {
	VInternalParent
}

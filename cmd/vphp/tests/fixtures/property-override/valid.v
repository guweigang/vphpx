module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'property_override' }

@[vphp.PhpExportClass(name: '')]
pub struct PropertyOverrideBase {
pub mut:
	current int
	shared  int @[vphp.PhpStaticProperty]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('PropertyOverrideBase')]
pub struct PropertyOverrideMiddle {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('PropertyOverrideMiddle')]
pub struct PropertyOverrideChild {
pub mut:
	current int @[vphp.PhpPropertyAttribute(name: 'Override', args: '')]
	shared  int @[vphp.PhpStaticProperty; vphp.PhpPropertyAttribute(name: '\\Override', args: '')]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements('PropertyOverrideContract')]
pub struct PropertyOverrideImplementation {
pub mut:
	label string @[vphp.PhpPropertyAttribute(name: 'Override', args: '')]
}

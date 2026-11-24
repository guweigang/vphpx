module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'unmatched_property_override' }

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('hidden', 'int')]
@[vphp.PhpDeclaredPropertyVisibility('hidden', .private)]
pub struct PropertyOverridePrivateBase {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('PropertyOverridePrivateBase')]
pub struct UnmatchedPropertyOverride {
pub mut:
	hidden int @[vphp.PhpPropertyAttribute(name: 'Override', args: '')]
}

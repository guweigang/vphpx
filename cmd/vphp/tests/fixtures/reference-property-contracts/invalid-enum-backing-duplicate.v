module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_enum_backing' }

@[vphp.PhpExportEnum(name: 'DuplicateEnumBacking')]
@[_allow_multiple_values]
pub enum DuplicateBacking {
	first  = 7
	second = 0b111
}

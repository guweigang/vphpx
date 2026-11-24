module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'invalid_enum_backing' }

@[vphp.PhpExportEnum(name: 'OutOfRangeEnumBacking')]
pub enum OutOfRangeBacking as u64 {
	small     = 7
	too_large = 0x8000_0000_0000_0000
}

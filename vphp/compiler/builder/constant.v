module builder

import strings

pub struct ConstantBuilder {
pub:
	name  string
	type_ string
	value string
}

pub fn new_constant_builder(name string, type_ string, value string) ConstantBuilder {
	return ConstantBuilder{
		name:  name
		type_: type_
		value: value
	}
}

pub fn (b ConstantBuilder) render_register() string {
	match b.type_ {
		'string' {
			value := c_string_literal_bytes(b.value)
			return '    REGISTER_STRINGL_CONSTANT("${b.name}", "${value}", ${b.value.len}, CONST_CS | CONST_PERSISTENT);'
		}
		'double', 'f64' {
			return '    REGISTER_DOUBLE_CONSTANT("${b.name}", ${b.value}, CONST_CS | CONST_PERSISTENT);'
		}
		'bool' {
			return '    REGISTER_BOOL_CONSTANT("${b.name}", ${b.value}, CONST_CS | CONST_PERSISTENT);'
		}
		else {
			return '    REGISTER_LONG_CONSTANT("${b.name}", ${b.value}, CONST_CS | CONST_PERSISTENT);'
		}
	}
}

fn c_string_literal_bytes(value string) string {
	mut literal := strings.new_builder(value.len)
	for byte in value.bytes() {
		match byte {
			`"`, `\\` {
				literal.write_u8(`\\`)
				literal.write_u8(byte)
			}
			else {
				if byte < 0x20 || byte >= 0x7f {
					literal.write_string('\\${byte:03o}')
				} else {
					literal.write_u8(byte)
				}
			}
		}
	}
	return literal.str()
}

pub fn (b ConstantBuilder) export_fragments() ExportFragments {
	return ExportFragments{
		minit_lines: [b.render_register()]
	}
}

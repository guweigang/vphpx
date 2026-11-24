module builder

import strings
import compiler.php_types

pub struct ConstantBuilder {
pub:
	name       string
	type_      string
	value      string
	attributes []ClassAttribute
pub mut:
	min_php_version int
}

pub fn new_constant_builder(name string, type_ string, value string, attributes ...ClassAttribute) ConstantBuilder {
	return ConstantBuilder{
		name:       name
		type_:      type_
		value:      value
		attributes: attributes
	}
}

fn (b ConstantBuilder) render_register(flags string) string {
	name := c_string_literal_bytes(b.name)
	match b.type_ {
		'string' {
			value := c_string_literal_bytes(b.value)
			return 'REGISTER_STRINGL_CONSTANT("${name}", "${value}", ${b.value.len}, ${flags})'
		}
		'double', 'f64' {
			return 'REGISTER_DOUBLE_CONSTANT("${name}", ${b.value}, ${flags})'
		}
		'bool' {
			return 'REGISTER_BOOL_CONSTANT("${name}", ${b.value}, ${flags})'
		}
		else {
			return 'REGISTER_LONG_CONSTANT("${name}", ${b.value}, ${flags})'
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
	flags := 'CONST_CS | CONST_PERSISTENT'
	register := '    ${b.render_register(flags)};'
	if b.attributes.len == 0 {
		return ExportFragments{
			minit_lines: for_php_version(b.min_php_version, [register])
		}
	}
	attribute_flags := if b.attributes.any(php_types.is_deprecated_attribute(it.name)) {
		flags + ' | CONST_DEPRECATED'
	} else {
		flags
	}
	mut lines := [
		'#if PHP_VERSION_ID >= 80500',
		'    {',
		'        zend_constant *constant = ${b.render_register(attribute_flags)};',
		'        if (constant == NULL) { return FAILURE; }',
	]
	for i, attr in b.attributes {
		lines << render_attribute_registration('global_constant_attribute_${i}', attr,
			'zend_add_global_constant_attribute', ['constant'])
	}
	lines << ['    }', '#else', register, '#endif']
	return ExportFragments{
		minit_lines: for_php_version(b.min_php_version, lines)
	}
}

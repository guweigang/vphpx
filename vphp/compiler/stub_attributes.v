module compiler

import strings
import compiler.php_types
import compiler.repr

pub struct StubExpressions {
pub mut:
	attributes         map[string]map[string][]string
	parameter_defaults map[string]map[string]string
}

// Reflecting on argument values can autoload PHP classes or run constructors.
// Preserve declaration source for stub generation without evaluating it.
pub fn (c Compiler) stub_expressions() StubExpressions {
	mut expressions := StubExpressions{}
	for element in c.elements {
		match element {
			repr.PhpFuncRepr {
				collect_stub_callable_attributes(mut expressions, 'function ${element.name.trim_left('\\')}', element.attributes, element.args)
			}
			repr.PhpConstRepr {
				if element.has_php_const && element.const_type != 'struct' {
					collect_stub_attributes(mut expressions.attributes, 'constant ${element.name.trim_left('\\')}', element.attributes)
				}
			}
			repr.PhpClassRepr {
				owner := php_types.class_lookup_name(element.php_name)
				collect_stub_type_attributes(mut expressions, owner, element.attributes, element.constants, element.methods)
				for property in element.properties {
					collect_stub_attributes(mut expressions.attributes, '${owner}::$${property.name}', property.attributes)
				}
			}
			repr.PhpInterfaceRepr {
				owner := php_types.class_lookup_name(element.php_name)
				collect_stub_type_attributes(mut expressions, owner, element.attributes, element.constants, element.methods)
			}
			repr.PhpEnumRepr {
				owner := php_types.class_lookup_name(element.php_name)
				collect_stub_type_attributes(mut expressions, owner, element.attributes, element.constants, element.methods)
				for case_ in element.cases {
					collect_stub_attributes(mut expressions.attributes, '${owner}::${case_.php_name}', case_.attributes)
				}
			}
		}
	}
	return expressions
}

pub fn (c Compiler) stub_attribute_expressions() map[string]map[string][]string {
	return c.stub_expressions().attributes
}

fn collect_stub_type_attributes(mut expressions StubExpressions, owner string, attrs []repr.PhpAttributeRepr, constants []repr.PhpClassConstRepr, methods []repr.PhpMethodRepr) {
	collect_stub_attributes(mut expressions.attributes, 'class ${owner}', attrs)
	for constant in constants {
		collect_stub_attributes(mut expressions.attributes, '${owner}::${constant.name}', constant.attributes)
	}
	for method in methods {
		name := if method.hook_kind == '' {
			method.php_name()
		} else {
			'$${method.hook_property}::${method.hook_kind}'
		}
		collect_stub_callable_attributes(mut expressions, '${owner}::${name}()', method.attributes, method.args)
	}
}

fn collect_stub_callable_attributes(mut expressions StubExpressions, owner string, attrs []repr.PhpAttributeRepr, args []repr.PhpArgRepr) {
	collect_stub_attributes(mut expressions.attributes, owner, attrs)
	mut defaults := map[string]string{}
	for arg in args {
		collect_stub_attributes(mut expressions.attributes, '${owner} $${arg.name}', arg.attributes)
		if arg.use_php_default && arg.php_default != '' {
			defaults[arg.name] = arg.php_default
		}
	}
	if defaults.len > 0 {
		expressions.parameter_defaults[owner] = defaults
	}
}

fn collect_stub_attributes(mut expressions map[string]map[string][]string, owner string, attrs []repr.PhpAttributeRepr) {
	if !attrs.any(it.args.any(it.has_constant_expression())) {
		return
	}
	mut by_name := map[string][]string{}
	for attr in attrs {
		name := php_types.class_lookup_name(attr.name)
		source := if attr.args.any(it.has_constant_expression()) {
			attr.args.map(render_stub_attribute_argument(it)).join(', ')
		} else {
			''
		}
		by_name[name] << source
	}
	expressions[owner] = by_name
}

fn render_stub_attribute_argument(arg repr.PhpAttributeArg) string {
	value := render_stub_attribute_value(arg)
	return if arg.name == '' { value } else { '${arg.name}: ${value}' }
}

fn render_stub_attribute_value(arg repr.PhpAttributeArg) string {
	return match arg.kind {
		'array' { '[' + arg.items.map(render_stub_attribute_item(it)).join(', ') + ']' }
		'class_constant' {
			owner := arg.value.all_before('::').to_lower()
			if owner in ['self', 'parent'] { arg.value } else { '\\' + arg.value }
		}
		'int' {
			if arg.value == min_i64.str() { '(-9223372036854775807 - 1)' } else { arg.value }
		}
		'bool', 'float' { arg.value }
		'null' { 'null' }
		else { stub_attribute_string(arg.value) }
	}
}

fn render_stub_attribute_item(arg repr.PhpAttributeArg) string {
	value := render_stub_attribute_value(arg)
	if arg.key_kind == '' {
		return value
	}
	key := render_stub_attribute_value(repr.PhpAttributeArg{ kind: arg.key_kind, value: arg.key })
	return '${key} => ${value}'
}

// Emit arbitrary bytes as a PHP string and keep JSON metadata valid UTF-8.
fn stub_attribute_string(value string) string {
	mut literal := strings.new_builder(value.len + 2)
	literal.write_byte(`"`)
	for byte in value {
		match byte {
			`"`, `\\`, `$` {
				literal.write_byte(`\\`)
				literal.write_byte(byte)
			}
			else {
				if byte < 32 || byte >= 127 {
					literal.write_string('\\x${byte:02x}')
				} else {
					literal.write_byte(byte)
				}
			}
		}
	}
	literal.write_byte(`"`)
	return literal.str()
}

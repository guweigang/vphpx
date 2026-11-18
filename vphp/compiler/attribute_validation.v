module compiler

import compiler.repr

fn validate_attribute_arguments(elements []repr.PhpRepr) ! {
	for element in elements {
		match element {
			repr.PhpClassRepr {
				name := element.php_name
				validate_attributes(element.attributes, name)!
				for constant in element.constants {
					validate_attributes(constant.attributes, '${name}::${constant.name}')!
				}
				for property in element.properties {
					validate_attributes(property.attributes, '${name}::${property.name}')!
				}
				validate_method_attributes(element.methods, name)!
			}
			repr.PhpEnumRepr {
				validate_attributes(element.attributes, element.php_name)!
				for item in element.cases {
					validate_attributes(item.attributes, '${element.php_name}::${item.name}')!
				}
			}
			repr.PhpInterfaceRepr {
				validate_attributes(element.attributes, element.php_name)!
				validate_method_attributes(element.methods, element.php_name)!
			}
			repr.PhpFuncRepr {
				validate_attributes(element.attributes, element.name)!
				validate_parameter_attributes(element.args, element.name)!
			}
			else {}
		}
	}
}

fn validate_method_attributes(methods []repr.PhpMethodRepr, owner string) ! {
	for method in methods {
		name := '${owner}::${method.name}'
		validate_attributes(method.attributes, name)!
		validate_parameter_attributes(method.args, name)!
	}
}

fn validate_parameter_attributes(args []repr.PhpArgRepr, owner string) ! {
	for arg in args {
		validate_attributes(arg.attributes, '${owner} parameter ${arg.name}')!
	}
}

fn validate_attributes(attrs []repr.PhpAttributeRepr, owner string) ! {
	for attr in attrs {
		if attr.parse_error != '' {
			return error('PHP attribute ${attr.name} on ${owner}: ${attr.parse_error}')
		}
	}
}

module parser

import compiler.repr
import compiler.syntax as ast

struct InterfaceMethodDecl {
mut:
	v_name          string
	php_name        string
	static_         bool
	php_return_type string
	parameters      map[string]InterfaceParameterDecl
	attributes      []repr.PhpAttributeRepr
	min_php_version int
}

struct InterfaceParameterDecl {
	php_name   string
	php_type   string
	attributes []repr.PhpAttributeRepr
}

fn collect_interface_methods(stmts []ast.Stmt) !map[string][]InterfaceMethodDecl {
	prefix := 'vphp.PhpInterfaceMethods['
	mut tables := map[string][]InterfaceMethodDecl{}
	for stmt in stmts {
		if stmt !is ast.ConstDecl {
			continue
		}
		decl := stmt as ast.ConstDecl
		for constant in decl.fields {
			if constant.expr !is ast.StructInit {
				continue
			}
			expr := constant.expr as ast.StructInit
			if !expr.typ.starts_with(prefix) || !expr.typ.ends_with(']') {
				continue
			}
			target := qualified_v_type(decl.module_name, expr.typ[prefix.len..expr.typ.len - 1].trim_space())
			if target in tables {
				return error('duplicate PhpInterfaceMethods for ${target}')
			}
			if expr.init_fields.len != 1 || expr.init_fields[0].name != 'methods'
				|| expr.init_fields[0].expr !is ast.ArrayLiteral {
				return error('PhpInterfaceMethods ${constant.name}: methods must be an array literal')
			}
			values := expr.init_fields[0].expr as ast.ArrayLiteral
			if values.values.len == 0 {
				return error('PhpInterfaceMethods ${constant.name}: declare at least one method')
			}
			mut methods := []InterfaceMethodDecl{cap: values.values.len}
			for value in values.values {
				methods << parse_interface_method(value) or {
					return error('PhpInterfaceMethods ${constant.name}: ${err.msg()}')
				}
			}
			tables[target] = methods
		}
	}
	return tables
}

fn parse_interface_method(expr ast.Expr) !InterfaceMethodDecl {
	if expr !is ast.StructInit || expr.typ !in ['', 'vphp.PhpInterfaceMethod'] {
		return error('expected a PhpInterfaceMethod initializer')
	}
	mut method := InterfaceMethodDecl{}
	for field in expr.init_fields {
		value := field.expr
		match field.name {
			'v_name', 'php_name', 'php_return_type' {
				if value !is ast.StringLiteral {
					return error('${field.name} must be a string literal')
				}
				match field.name {
					'v_name' { method.v_name = value.val }
					'php_name' { method.php_name = value.val }
					else { method.php_return_type = value.val.trim_space() }
				}
			}
			'static_' {
				if value !is ast.BoolLiteral {
					return error('static_ must be a boolean literal')
				}
				method.static_ = value.val
			}
			'parameters' {
				if value !is ast.ArrayLiteral {
					return error('parameters must be an array literal')
				}
				for item in value.values {
					v_name, parameter := parse_interface_parameter(item)!
					if v_name in method.parameters {
						return error('duplicate parameter ${v_name}')
					}
					method.parameters[v_name] = parameter
				}
			}
			'attributes' {
				method.attributes = parse_interface_member_attributes(value)!
			}
			'since' {
				if value !is ast.EnumValueExpr {
					return error('since must be a PhpVersion enum value')
				}
				method.min_php_version = parse_min_php_version(value.name, 'PhpInterfaceMethod')!
			}
			else {
				return error('unknown PhpInterfaceMethod field ${field.name}')
			}
		}
	}
	if method.v_name == '' {
		return error('v_name is required')
	}
	return method
}

fn parse_interface_parameter(expr ast.Expr) !(string, InterfaceParameterDecl) {
	if expr !is ast.StructInit || expr.typ !in ['', 'vphp.PhpInterfaceParameter'] {
		return error('expected a PhpInterfaceParameter initializer')
	}
	mut names := map[string]string{}
	mut attributes := []repr.PhpAttributeRepr{}
	for field in expr.init_fields {
		value := field.expr
		if field.name == 'attributes' {
			attributes = parse_interface_member_attributes(value)!
			continue
		}
		if field.name !in ['v_name', 'php_name', 'php_type'] || value !is ast.StringLiteral {
			return error('expected a string literal for PhpInterfaceParameter.${field.name}')
		}
		names[field.name] = (value as ast.StringLiteral).val
	}
	php_name := names['php_name']
	php_type := names['php_type'].trim_space()
	if names['v_name'] == '' || (php_name == '' && php_type == '' && attributes.len == 0) {
		return error('parameter v_name and at least one of php_name, php_type, or attributes are required')
	}
	if php_name != '' && !interface_export_identifier(php_name) {
		return error('invalid PHP parameter name ${php_name}')
	}
	return names['v_name'], InterfaceParameterDecl{php_name, php_type, attributes}
}

fn parse_interface_member_attributes(expr ast.Expr) ![]repr.PhpAttributeRepr {
	if expr !is ast.ArrayLiteral {
		return error('attributes must be an array literal')
	}
	mut attributes := []repr.PhpAttributeRepr{cap: expr.values.len}
	for item in expr.values {
		if item !is ast.StructInit || item.typ !in ['', 'vphp.PhpAttributeSpec'] {
			return error('expected a PhpAttributeSpec initializer')
		}
		mut values := map[string]string{}
		for field in item.init_fields {
			value := field.expr
			if field.name !in ['name', 'args'] || value !is ast.StringLiteral {
				return error('expected a string literal for PhpAttributeSpec.${field.name}')
			}
			values[field.name] = (value as ast.StringLiteral).val
		}
		attributes << (php_attribute_from_parts(values['name'], values['args']) or {
			return error('PhpAttributeSpec.name is required')
		})
	}
	return attributes
}

fn bind_interface_methods(mut iface repr.PhpInterfaceRepr, declarations []InterfaceMethodDecl) ! {
	methods := iface.methods.map(it.v_name)
	mut seen := map[string]bool{}
	for decl in declarations {
		owner := 'PHP interface ${iface.php_name}::${decl.v_name}'
		index := methods.index(decl.v_name)
		if index < 0 {
			return error('${owner}: unknown method')
		}
		if decl.v_name in seen {
			return error('${owner}: duplicate declaration')
		}
		seen[decl.v_name] = true
		mut method := &iface.methods[index]
		if decl.php_name != '' {
			if !interface_export_identifier(decl.php_name) {
				return error('${owner}: invalid PHP method name ${decl.php_name}')
			}
			method.name = decl.php_name
		}
		method.is_static = method.is_static || decl.static_
		if method.is_static && method.is_constructor() {
			return error('${owner}: a constructor cannot be static')
		}
		if decl.php_return_type != '' {
			method.return_spec = repr.new_return_repr(method.return_spec.v_type, decl.php_return_type)
		}
		method.attributes = decl.attributes
		method.min_php_version = decl.min_php_version
		mut names := method.args.map(it.name)
		mut bound := map[int]bool{}
		for v_name, parameter in decl.parameters {
			param := interface_parameter_index(method.args, v_name)
			if param < 0 {
				return error('${owner}: unknown parameter $${v_name}')
			}
			if param in bound {
				return error('${owner}: duplicate declaration for parameter $${v_name}')
			}
			bound[param] = true
			if parameter.php_name != '' {
				names[param] = parameter.php_name
			}
			method.args[param].php_type = parameter.php_type
			method.args[param].attributes = parameter.attributes
		}
		mut parameter_names := map[string]bool{}
		for i, name in names {
			if name in parameter_names {
				return error('${owner}: duplicate PHP parameter name $${name}')
			}
			parameter_names[name] = true
			method.args[i].name = name
		}
	}
	mut php_names := map[string]bool{}
	for method in iface.methods {
		name := method.php_name()
		if name.to_lower() in php_names {
			return error('PHP interface ${iface.php_name}::${name}: duplicate PHP method name')
		}
		php_names[name.to_lower()] = true
	}
}

fn interface_parameter_index(args []repr.PhpArgRepr, name string) int {
	index := args.map(if it.source.kind == .params_field {
		it.source.params_field
	} else {
		it.source.direct_name
	}).index(name)
	return if index >= 0 { index } else { args.map(it.name).index(name) }
}

fn interface_export_identifier(name string) bool {
	return name != '' && !name[0].is_digit()
		&& name.bytes().all(it.is_alnum() || it == `_` || it >= 128)
}

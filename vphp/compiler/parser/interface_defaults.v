module parser

import compiler.repr
import compiler.syntax as ast

struct InterfaceParamDefault {
	method    string
	parameter string
	value     string
}

fn collect_interface_defaults(stmts []ast.Stmt) !map[string][]InterfaceParamDefault {
	prefix := 'vphp.PhpInterfaceDefaults['
	mut tables := map[string][]InterfaceParamDefault{}
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
				return error('duplicate PhpInterfaceDefaults for ${target}')
			}
			if expr.init_fields.len != 1 || expr.init_fields[0].name != 'defaults'
				|| expr.init_fields[0].expr !is ast.ArrayLiteral {
				return error('PhpInterfaceDefaults ${constant.name}: defaults must be an array literal')
			}
			values := expr.init_fields[0].expr as ast.ArrayLiteral
			if values.values.len == 0 {
				return error('PhpInterfaceDefaults ${constant.name}: declare at least one default')
			}
			mut defaults := []InterfaceParamDefault{cap: values.values.len}
			for value in values.values {
				defaults << parse_interface_default(value) or {
					return error('PhpInterfaceDefaults ${constant.name}: ${err.msg()}')
				}
			}
			tables[target] = defaults
		}
	}
	return tables
}

fn parse_interface_default(expr ast.Expr) !InterfaceParamDefault {
	if expr !is ast.StructInit || expr.typ !in ['', 'vphp.PhpInterfaceDefault'] {
		return error('expected a PhpInterfaceDefault initializer')
	}
	mut fields := map[string]string{}
	for field in expr.init_fields {
		value := field.expr
		if value !is ast.StringLiteral || field.name !in ['method', 'parameter', 'default_value'] {
			return error('expected a string literal for PhpInterfaceDefault.${field.name}')
		}
		fields[field.name] = (value as ast.StringLiteral).val.trim_space()
	}
	if fields['method'] == '' || fields['parameter'] == '' || fields['default_value'] == '' {
		return error('method, parameter and default_value are required')
	}
	return InterfaceParamDefault{fields['method'], fields['parameter'], fields['default_value']}
}

fn bind_interface_defaults(mut iface repr.PhpInterfaceRepr, defaults []InterfaceParamDefault) ! {
	methods := iface.methods.map(it.v_name)
	for entry in defaults {
		owner := 'PHP interface ${iface.php_name}::${entry.method}($${entry.parameter})'
		index := methods.index(entry.method)
		if index < 0 {
			return error('${owner}: unknown method')
		}
		mut method := &iface.methods[index]
		param := interface_parameter_index(method.args, entry.parameter)
		if param < 0 {
			return error('${owner}: unknown parameter')
		}
		if method.args[param].is_variadic {
			return error('${owner}: variadic parameters cannot have defaults')
		}
		if method.args[param].use_php_default {
			return error('${owner}: duplicate default')
		}
		method.args[param].is_optional = true
		method.args[param].use_php_default = true
		method.args[param].php_default = entry.value
	}
	for method in iface.methods {
		mut optional := false
		for arg in method.args {
			if optional && !arg.is_optional && !arg.is_variadic {
				return error('PHP interface ${iface.php_name}::${method.v_name}($${arg.name}): required parameter follows a default')
			}
			optional = optional || arg.is_optional
		}
	}
}

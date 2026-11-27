module parser

import compiler.syntax as ast
import compiler.repr

fn collect_property_contracts(stmts []ast.Stmt, table_name string, entry_name string) !map[string][]repr.PhpInterfacePropertyRepr {
	prefix := 'vphp.${table_name}['
	mut contracts := map[string][]repr.PhpInterfacePropertyRepr{}
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
			if target in contracts {
				return error('duplicate ${table_name} for ${target}')
			}
			mut properties := []repr.PhpInterfacePropertyRepr{}
			for field in expr.init_fields {
				values := field.expr
				if field.name != 'properties' || values !is ast.ArrayLiteral {
					return error('${table_name} ${constant.name}: properties must be an array literal')
				}
				for i, value in values.values {
					properties << parse_property_contract(value, entry_name) or {
						return error('${table_name} ${constant.name}[${i}]: ${err.msg()}')
					}
				}
			}
			if properties.len == 0 {
				return error('${table_name} ${constant.name}: declare at least one property')
			}
			contracts[target] = properties
		}
	}
	return contracts
}

fn parse_property_contract(expr ast.Expr, entry_name string) !repr.PhpInterfacePropertyRepr {
	if expr !is ast.StructInit || expr.typ !in ['', 'vphp.${entry_name}'] {
		return error('expected a ${entry_name} initializer')
	}
	mut name := ''
	mut php_type := ''
	mut access := ''
	mut since := 'php82'
	access_options := ['get', 'set', 'get_set', 'get_ref', 'get_ref_set']
	for field in expr.init_fields {
		value := field.expr
		match field.name {
			'name', 'php_type' {
				if value !is ast.StringLiteral {
					return error('${field.name} must be a string literal')
				}
				if field.name == 'name' {
					name = value.val
				} else {
					php_type = value.val.trim_space()
				}
			}
			'access' {
				if value !is ast.EnumValueExpr {
					return error('access must be ${access_options.map('.' + it).join(', ')}')
				}
				access = value.name
			}
			'since' {
				if value !is ast.EnumValueExpr {
					return error('since must be a PhpVersion enum value')
				}
				since = value.name
			}
			else {
				return error('unknown ${entry_name} field ${field.name}')
			}
		}
	}
	if name == '' || php_type == '' || access !in access_options {
		return error('name, php_type and access (${access_options.map('.' + it).join(', ')}) are required')
	}
	return repr.PhpInterfacePropertyRepr{
		name:             name
		php_type:         php_type
		has_get:          access != 'set'
		has_set:          access in ['set', 'get_set', 'get_ref_set']
		get_by_reference: access in ['get_ref', 'get_ref_set']
		min_php_version:  parse_min_php_version(since, 'PHP property contract ${name}')!
	}
}

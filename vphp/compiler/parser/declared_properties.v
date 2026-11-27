module parser

import compiler.repr
import compiler.syntax as ast

fn collect_declared_properties(stmts []ast.Stmt) !map[string][]repr.PhpClassPropRepr {
	prefix := 'vphp.PhpDeclaredProperties['
	mut tables := map[string][]repr.PhpClassPropRepr{}
	for stmt in stmts {
		if stmt !is ast.ConstDecl {
			continue
		}
		decl := stmt as ast.ConstDecl
		if decl.attrs.any(it.name == 'php_ignore') {
			continue
		}
		for constant in decl.fields {
			if constant.expr !is ast.StructInit {
				continue
			}
			init := constant.expr as ast.StructInit
			if !init.typ.starts_with(prefix) || !init.typ.ends_with(']') {
				continue
			}
			target := qualified_v_type(decl.module_name, init.typ[prefix.len..init.typ.len - 1].trim_space())
			if target in tables {
				return error('duplicate PhpDeclaredProperties for ${target}')
			}
			if init.init_fields.len != 1 || init.init_fields[0].name != 'properties'
				|| init.init_fields[0].expr !is ast.ArrayLiteral {
				return error('PhpDeclaredProperties ${constant.name}: properties must be an array literal')
			}
			values := init.init_fields[0].expr as ast.ArrayLiteral
			mut properties := []repr.PhpClassPropRepr{cap: values.values.len}
			for index, value in values.values {
				properties << parse_declared_property_spec(value) or {
					return error('PhpDeclaredProperties ${constant.name}[${index}]: ${err.msg()}')
				}
			}
			tables[target] = properties
		}
	}
	return tables
}

fn parse_declared_property_spec(expr ast.Expr) !repr.PhpClassPropRepr {
	if expr !is ast.StructInit || expr.typ !in ['', 'vphp.PhpDeclaredPropertySpec'] {
		return error('expected a PhpDeclaredPropertySpec initializer')
	}
	mut name := ''
	mut php_type := ''
	mut default_value := ?string(none)
	mut visibility := 'public'
	mut set_visibility := ?string(none)
	mut is_static := false
	mut is_readonly := false
	mut is_final := false
	mut since := 'php82'
	for field in expr.init_fields {
		value := field.expr
		match field.name {
			'name', 'php_type', 'default_value' {
				if field.name == 'default_value' && value is ast.Ident && value.name == 'none' {
					continue
				}
				if value !is ast.StringLiteral {
					return error('${field.name} must be a string literal')
				}
				match field.name {
					'name' { name = value.val.trim_space() }
					'php_type' { php_type = value.val.trim_space() }
					else { default_value = value.val }
				}
			}
			'visibility', 'set_visibility', 'since' {
				if field.name == 'set_visibility' && value is ast.Ident && value.name == 'none' {
					continue
				}
				if value !is ast.EnumValueExpr {
					return error('${field.name} must be an enum value')
				}
				match field.name {
					'visibility' { visibility = value.name }
					'set_visibility' { set_visibility = value.name }
					else { since = value.name }
				}
			}
			'is_static', 'is_readonly', 'is_final' {
				if value !is ast.BoolLiteral {
					return error('${field.name} must be a boolean literal')
				}
				match field.name {
					'is_static' { is_static = value.val }
					'is_readonly' { is_readonly = value.val }
					else { is_final = value.val }
				}
			}
			else { return error('unknown property field ${field.name}') }
		}
	}
	base := php_only_property(name, php_type, visibility, is_readonly) or {
		return error('name is required')
	}
	if visibility !in ['public', 'protected', 'private'] {
		return error('invalid property visibility ${visibility}')
	}
	if is_readonly && (php_type == '' || is_static) {
		return error('readonly properties require a PHP type and cannot be static')
	}
	property := repr.PhpClassPropRepr{
		...base
		set_visibility:  set_visibility
		is_static:       is_static
		is_final:        is_final
		explicit_mixed:  php_type.to_lower() == 'mixed'
		min_php_version: parse_min_php_version(since, 'PHP property ${name}')!
	}
	if value := default_value {
		return property_with_default(property, value)
	}
	return property
}

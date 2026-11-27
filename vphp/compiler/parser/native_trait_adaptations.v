module parser

import compiler.syntax as ast
import compiler.repr

struct NativeTraitRulesDecl {
	name        string
	module_name string
	fields      map[string]ast.Expr
}

fn qualified_v_type(module_name string, type_name string) string {
	return if type_name.contains('.') { type_name } else { '${module_name}.${type_name}' }
}

fn collect_native_trait_rules(stmts []ast.Stmt) !map[string]NativeTraitRulesDecl {
	mut rules := map[string]NativeTraitRulesDecl{}
	prefix := 'vphp.PhpTraitRules['
	for stmt in stmts {
		if stmt is ast.ConstDecl {
			for field in stmt.fields {
				expr := field.expr
				if expr !is ast.StructInit {
					continue
				}
				init := expr as ast.StructInit
				if !init.typ.starts_with(prefix) || !init.typ.ends_with(']') {
					continue
				}
				target := qualified_v_type(stmt.module_name, init.typ[prefix.len..init.typ.len - 1].trim_space())
				if previous := rules[target] {
					return error('duplicate PhpTraitRules for ${target}: `${previous.name}` and `${field.name}`')
				}
				mut fields := map[string]ast.Expr{}
				for entry in init.init_fields {
					if entry.name !in ['uses', 'precedences', 'adaptations'] {
						return error('unknown PhpTraitRules field `${entry.name}` in `${field.name}`')
					}
					if entry.name in fields {
						return error('duplicate PhpTraitRules field `${entry.name}` in `${field.name}`')
					}
					fields[entry.name] = entry.expr
				}
				rules[target] = NativeTraitRulesDecl{field.name, stmt.module_name, fields}
			}
		}
	}
	return rules
}

fn bind_native_trait_declarations(mut trait repr.PhpClassRepr, attrs []ast.Attr, stmts []ast.Stmt, rules NativeTraitRulesDecl) ! {
	uses_name, uses_module, uses_values := native_trait_rule_array(attrs, stmts,
		trait.module_name, rules, 'uses', 'PhpUsesTraits')!
	trait.native_trait_use_types = parse_trait_types(uses_values, uses_module) or {
		return error('${uses_name}: ${err.msg()}')
	}
	precedences_name, precedences_module, precedences_values := native_trait_rule_array(attrs,
		stmts, trait.module_name, rules, 'precedences', 'PhpTraitPrecedences')!
	for index, value in precedences_values {
		trait.native_trait_precedence_specs << parse_trait_precedence(value, precedences_module) or {
			return error('${precedences_name}[${index}]: ${err.msg()}')
		}
	}
	adaptations_name, adaptations_module, adaptations_values := native_trait_rule_array(attrs,
		stmts, trait.module_name, rules, 'adaptations', 'PhpTraitAdaptations')!
	for index, value in adaptations_values {
		trait.native_trait_adaptations << parse_trait_adaptation(value, adaptations_module) or {
			return error('${adaptations_name}[${index}]: ${err.msg()}')
		}
	}
}

fn native_trait_rule_array(attrs []ast.Attr, stmts []ast.Stmt, trait_module string, rules NativeTraitRulesDecl, field string, attribute string) !(string, string, []ast.Expr) {
	source := ast.find_attr_arg(attrs, 'vphp.${attribute}', 'source')
	if value := rules.fields[field] {
		label := 'PhpTraitRules ${rules.name}.${field}'
		if source != none {
			return error('${label} and ${attribute} both declare ${field}')
		}
		if value is ast.ArrayLiteral {
			return label, rules.module_name, value.values
		}
		if value is ast.Ident {
			return label, rules.module_name, trait_constant_array(stmts, rules.module_name, value.name, label)!
		}
		return error('${label} must be an array literal or a constant array name')
	}
	if name := source {
		return '${attribute} ${name}', trait_module, trait_constant_array(stmts, trait_module, name, attribute)!
	}
	return '', trait_module, []ast.Expr{}
}

fn trait_constant_array(stmts []ast.Stmt, module_name string, name string, attribute string) ![]ast.Expr {
	if field := find_module_constant(stmts, module_name, name) {
		expr := field.expr
		if expr !is ast.ArrayLiteral {
			return error('${attribute} source `${name}` must be a constant array literal')
		}
		return expr.values
	}
	return error('${attribute} source `${name}` must name a constant in module ${module_name}')
}

fn parse_trait_types(values []ast.Expr, module_name string) ![]string {
	mut types := []string{cap: values.len}
	for index, value in values {
		types << parse_trait_type(value, module_name) or {
			return error('entry ${index}: ${err.msg()}')
		}
	}
	return types
}

fn parse_trait_type(expr ast.Expr, module_name string) !string {
	init := match expr {
		ast.CastExpr { *expr.expr }
		ast.CallExpr {
			if expr.name != 'PhpNativeTraitSource' || expr.args.len != 1 {
				return error('expected a V trait initializer')
			}
			expr.args[0].expr
		}
		else { expr }
	}
	if init !is ast.StructInit || init.typ == '' || init.init_fields.len > 0 {
		return error('expected an empty initializer of the exported V trait type')
	}
	return qualified_v_type(module_name, init.typ)
}

fn parse_trait_precedence(expr ast.Expr, module_name string) !repr.PhpTypedTraitPrecedence {
	if expr !is ast.StructInit || expr.typ != 'vphp.PhpTraitPrecedence' {
		return error('expected a vphp.PhpTraitPrecedence initializer')
	}
	mut source := ''
	mut method := ''
	mut excluded := []string{}
	for field in expr.init_fields {
		value := field.expr
		match field.name {
			'source' { source = parse_trait_type(value, module_name)! }
			'method' {
				if value !is ast.StringLiteral {
					return error('method must be a string literal')
				}
				method = value.val
			}
			'instead_of' {
				if value !is ast.ArrayLiteral {
					return error('instead_of must be an array literal of V trait initializers')
				}
				excluded = parse_trait_types(value.values, module_name)!
			}
			else { return error('unknown PhpTraitPrecedence field `${field.name}`') }
		}
	}
	if source == '' || method == '' || excluded.len == 0 {
		return error('source, method and at least one instead_of trait are required')
	}
	return repr.PhpTypedTraitPrecedence{source, method, excluded}
}

fn parse_trait_adaptation(expr ast.Expr, module_name string) !repr.PhpTypedTraitAdaptation {
	if expr !is ast.StructInit || expr.typ != 'vphp.PhpTraitAdaptation' {
		return error('expected a vphp.PhpTraitAdaptation initializer')
	}
	mut source := ''
	mut method := ''
	mut alias := ''
	mut visibility := ''
	mut is_final := false
	for field in expr.init_fields {
		value := field.expr
		match field.name {
			'source' { source = parse_trait_type(value, module_name)! }
			'method', 'alias' {
				if value !is ast.StringLiteral {
					return error('${field.name} must be a string literal')
				}
				if field.name == 'method' {
					method = value.val
				} else {
					alias = value.val
				}
			}
			'visibility' {
				if value !is ast.EnumValueExpr {
					return error('visibility must be a PhpTraitAccess enum value such as .protected')
				}
				access := (value as ast.EnumValueExpr).name
				if access !in ['inherit', 'public', 'protected', 'private'] {
					return error('unknown visibility .${access}')
				}
				visibility = if access == 'inherit' { '' } else { access }
			}
			'is_final' {
				if value !is ast.BoolLiteral {
					return error('is_final must be a bool literal')
				}
				is_final = value.val
			}
			else {
				return error('unknown PhpTraitAdaptation field `${field.name}`')
			}
		}
	}
	if source == '' || method == '' {
		return error('source and method are required')
	}
	if alias == '' && visibility == '' && !is_final {
		return error('supply an alias, a visibility change or is_final')
	}
	return repr.PhpTypedTraitAdaptation{
		source_v_type: source
		rule:          repr.PhpTraitAlias{
			method:     method
			alias:      alias
			visibility: visibility
			is_final:   is_final
		}
	}
}

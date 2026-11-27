module parser

import math
import strconv
import strings
import compiler.syntax as ast
import compiler.php_types
import compiler.repr

pub fn collect_params_structs(stmts []ast.Stmt, table &ast.Table, elements []repr.PhpRepr) map[string]repr.PhpParamsStruct {
	mut enums := map[string]repr.PhpEnumRepr{}
	mut classes := map[string]string{}
	for element in elements {
		if element is repr.PhpEnumRepr {
			enums[qualified_v_type(element.module_name, element.name)] = element
		} else if element is repr.PhpClassRepr && !element.is_trait && !element.is_native_trait {
			classes[qualified_v_type(element.module_name, element.name)] = element.php_name
		}
	}
	mut out := map[string]repr.PhpParamsStruct{}
	for stmt in stmts {
		if stmt !is ast.StructDecl {
			continue
		}
		struct_decl := stmt as ast.StructDecl
		if !struct_decl.attrs.any(it.name == 'params') {
			continue
		}
		struct_name := strip_module(struct_decl.name)
		module_name := struct_decl.module_name
		mut params_struct := repr.PhpParamsStruct{
			name:        struct_name
			module_name: module_name
		}
		for field in struct_decl.fields {
			field_type := strip_module(table.type_to_str(field.typ))
			base_type := field_type.trim_left('?')
			php_enum := enums[qualified_v_type(module_name, base_type)] or {
				repr.PhpEnumRepr{}
			}
			php_name := php_types.class_lookup_name(if base_type.starts_with('&') {
				classes[qualified_v_type(module_name, base_type[1..])]
			} else {
				php_enum.php_name
			})
			php_named_type := if php_name == '' {
				''
			} else if field_type.starts_with('?') {
				'?${php_name}'
			} else {
				php_name
			}
			default_spec := php_types.PhpDefaultSpec.from_v_type(field_type)
			literal := if field.has_default_expr {
				params_field_literal(field.default_expr, field_type, php_enum)
			} else {
				none
			}
			value := literal or { ParamsLiteral{default_spec.v_expr, default_spec.php_expr} }
			mut v_type := field_type
			mut v_default := value.v_expr
			local_name := base_type.trim_left('&')
			if module_name !in ['', 'main'] && !local_name.contains('.')
				&& table.has_declared_type(qualified_v_type(module_name, local_name)) {
				qualified := '${module_name.all_after_last('.')}.${local_name}'
				v_type = field_type[..field_type.len - local_name.len] + qualified
				v_default = v_default.replace('${local_name}.', '${qualified}.').replace('?${local_name}(', '?${qualified}(')
			}
			params_struct.fields << repr.PhpParamsField{
				name:             field.name
				v_type:           v_type
				php_named_type:   php_named_type
				v_default:        v_default
				php_default:      value.php_expr
				has_default:      field.has_default_expr
				computed_default: field.has_default_expr && literal == none
				is_sensitive:     field.attrs.any(it.name == 'vphp.PhpSensitiveField')
			}
		}
		out[repr.params_struct_key(module_name, struct_name)] = params_struct
	}
	return out
}

fn params_field_literal(expr ast.Expr, v_type string, php_enum repr.PhpEnumRepr) ?ParamsLiteral {
	if enum_literal := parse_params_enum_literal(expr, v_type, php_enum) {
		return enum_literal
	}
	return parse_params_literal(expr, v_type)
}

fn parse_params_enum_literal(expr ast.Expr, v_type string, php_enum repr.PhpEnumRepr) ?ParamsLiteral {
	if php_enum.php_name == '' {
		return none
	}
	if expr is ast.ParExpr {
		return parse_params_enum_literal(*expr.expr, v_type, php_enum)
	}
	base_type := v_type.trim_left('?')
	case_ref := parse_constant_enum_case(expr, base_type, php_enum.module_name) or { return none }
	for case_ in php_enum.cases {
		if case_.v_name != case_ref.case_name {
			continue
		}
		value := '${base_type}.${case_.v_name}'
		v_expr := if v_type.starts_with('?') { '${v_type}(${value})' } else { value }
		return ParamsLiteral{v_expr, '${php_types.class_lookup_name(php_enum.php_name)}::${case_.php_name}'}
	}
	return none
}

struct ParamsLiteral {
	v_expr   string
	php_expr string
}

// Derive both spellings from the same decoded literal. PHP reads the metadata
// to fill named gaps, while the V wrapper uses v_expr for omitted trailing fields.
fn parse_params_literal(expr ast.Expr, v_type string) ?ParamsLiteral {
	if expr is ast.ParExpr {
		return parse_params_literal(*expr.expr, v_type)
	}
	base_type := v_type.trim_left('?')
	value := match expr {
		ast.StringLiteral {
			v_expr := quote_params_string(expr.val, `'`)
			php_quote := if v_expr.contains('\\') { `"` } else { `'` }
			ParamsLiteral{v_expr, quote_params_string(expr.val, php_quote)}
		}
		ast.BoolLiteral {
			ParamsLiteral{expr.val.str(), expr.val.str()}
		}
		ast.Ident {
			if expr.name == 'none' && v_type.starts_with('?') {
				return ParamsLiteral{'none', 'null'}
			}
			return none
		}
		ast.IntegerLiteral, ast.FloatLiteral, ast.PrefixExpr {
			parse_params_number(expr, base_type) or { return none }
		}
		ast.ArrayLiteral {
			parse_params_array(expr.values, base_type) or { return none }
		}
		ast.MapInit {
			parse_params_map(expr, base_type) or { return none }
		}
		else {
			return none
		}
	}
	if v_type.starts_with('?') {
		return ParamsLiteral{'${v_type}(${value.v_expr})', value.php_expr}
	}
	return value
}

fn quote_params_string(value string, quote u8) string {
	mut out := strings.new_builder(value.len + 2)
	out.write_u8(quote)
	for ch in value {
		match ch {
			quote, `\\`, `$` {
				out.write_u8(`\\`)
				out.write_u8(ch)
			}
			`\n` { out.write_string(r'\n') }
			`\r` { out.write_string(r'\r') }
			`\t` { out.write_string(r'\t') }
			else {
				if ch < 32 || ch >= 127 {
					out.write_string(r'\x' + ch.hex())
				} else {
					out.write_u8(ch)
				}
			}
		}
	}
	out.write_u8(quote)
	return out.str()
}

fn params_number_token(expr ast.Expr) ?string {
	return match expr {
		ast.IntegerLiteral, ast.FloatLiteral { expr.val.replace('_', '') }
		ast.ParExpr { params_number_token(*expr.expr) }
		ast.PrefixExpr {
			if expr.op != .minus {
				return none
			}
			inner := params_number_token(*expr.right) or { return none }
			if inner.starts_with('-') { inner[1..] } else { '-' + inner }
		}
		else { none }
	}
}

fn parse_params_number(expr ast.Expr, v_type string) ?ParamsLiteral {
	token := params_number_token(expr) or { return none }
	magnitude := token.trim_left('-').to_lower()
	base := if magnitude.starts_with('0x') || magnitude.starts_with('0b')
		|| magnitude.starts_with('0o') {
		0
	} else {
		10
	}
	if v_type in ['f32', 'f64'] {
		decimal := if base == 0 {
			(strconv.common_parse_int(token, base, 64, true, true) or { return none }).str()
		} else {
			token
		}
		if v_type == 'f32' {
			rounded := f64(f32(strconv.atof64(decimal) or { return none }))
			if !math.is_finite(rounded) {
				return none
			}
			return ParamsLiteral{'f32(${params_php_float(decimal)})', params_php_float(rounded.str())}
		}
		return ParamsLiteral{params_php_float(decimal), params_php_float(decimal)}
	}
	number := strconv.common_parse_int(token, base, 64, true, true) or { return none }
	// PHP parses the magnitude of its minimum integer as a float.
	php_expr := if number == min_i64 { '(-9223372036854775807 - 1)' } else { number.str() }
	v_expr := if v_type == 'i64' { 'i64(${php_expr})' } else { php_expr }
	return ParamsLiteral{v_expr, php_expr}
}

fn params_php_float(value string) string {
	return if value.contains_any('.eE') { value } else { value + '.0' }
}

fn parse_params_array(values []ast.Expr, v_type string) ?ParamsLiteral {
	if v_type !in ['[]string', '[]int', '[]i64', '[]f64', '[]bool'] {
		return none
	}
	if values.len == 0 {
		return ParamsLiteral{'${v_type}{}', '[]'}
	}
	mut v_values := []string{cap: values.len}
	mut php_values := []string{cap: values.len}
	for expr in values {
		value := parse_params_literal(expr, v_type[2..]) or { return none }
		v_values << value.v_expr
		php_values << value.php_expr
	}
	return ParamsLiteral{'[${v_values.join(', ')}]', '[${php_values.join(', ')}]'}
}

fn parse_params_map(expr ast.MapInit, v_type string) ?ParamsLiteral {
	if v_type !in ['map[string]string', 'map[string]int', 'map[string]f64'] {
		return none
	}
	if expr.keys.len == 0 {
		return ParamsLiteral{'${v_type}{}', '[]'}
	}
	mut v_values := []string{cap: expr.keys.len}
	mut php_values := []string{cap: expr.keys.len}
	for i, key_expr in expr.keys {
		key := parse_params_literal(key_expr, 'string') or { return none }
		value := parse_params_literal(expr.vals[i], v_type.all_after(']')) or { return none }
		v_values << '${key.v_expr}: ${value.v_expr}'
		php_values << '${key.php_expr} => ${value.php_expr}'
	}
	return ParamsLiteral{'{${v_values.join(', ')}}', '[${php_values.join(', ')}]'}
}

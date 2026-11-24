module parser

import compiler.syntax as ast
import compiler.repr

pub fn parse_constant_decl(const_decl ast.ConstDecl, table &ast.Table, mut elements []repr.PhpRepr) ! {
	has_version := const_decl.attrs.any(it.name == 'vphp.PhpGlobalConstantSince')
	if const_decl.attrs.any(it.name == 'php_ignore') {
		if has_version {
			return error('PhpGlobalConstantSince requires an exported PHP scalar constant')
		}
		return
	}
	mut con := repr.new_const_repr()
	con.has_php_const = const_decl.attrs.any(it.name in ['php_const', 'vphp.PhpExportConstant'])
	export_name := ast.find_attr_arg(const_decl.attrs, 'vphp.PhpExportConstant', 'name') or { '' }

	for field in const_decl.fields {
		if field.name.ends_with('ext_config') {
			continue
		}

		raw_name := field.name.all_after_last('.')
		con.name = raw_name.to_upper()

		if field.expr is ast.StringLiteral {
			con.value = (field.expr as ast.StringLiteral).val
			con.const_type = 'string'
		} else if field.expr is ast.IntegerLiteral {
			con.value = (field.expr as ast.IntegerLiteral).val
			con.const_type = 'int'
		} else if field.expr is ast.FloatLiteral {
			con.value = (field.expr as ast.FloatLiteral).val
			con.const_type = 'f64'
		} else if field.expr is ast.BoolLiteral {
			con.value = if (field.expr as ast.BoolLiteral).val { '1' } else { '0' }
			con.const_type = 'bool'
		} else if field.expr is ast.StructInit {
			expr := field.expr as ast.StructInit
			if expr.typ.starts_with(constant_table_prefix) || expr.typ.starts_with(static_table_prefix) {
				continue
			}
			struct_value := parse_constant_struct(expr, raw_name, const_decl.module_name,
				table)!
			con.v_type = struct_value.v_type
			con.name = struct_value.name
			con.const_type = struct_value.const_type
			con.fields = struct_value.fields
		} else {
			continue
		}
		if export_name != '' && con.const_type != 'struct' {
			con.name = export_name.trim_string_left('\\')
		}
		if con.has_php_const && con.const_type != 'struct' {
			con.attributes = parse_typed_php_attributes(const_decl.attrs, 'vphp.PhpGlobalConstantAttribute')
			con.min_php_version = export_min_php_version(const_decl.attrs,
				'vphp.PhpGlobalConstantSince', 'PHP constant ${con.name}')!
		} else if has_version {
			return error('PhpGlobalConstantSince requires an exported PHP scalar constant')
		}
		elements << con
		return
	}

	if has_version {
		return error('PhpGlobalConstantSince requires an exported PHP scalar constant')
	}
}

fn parse_constant_struct(expr ast.StructInit, name string, module_name string, table &ast.Table) !repr.PhpConstRepr {
	mut con := repr.PhpConstRepr{
		name:       name
		const_type: 'struct'
	}
	v_type := table.get_type_name(expr.typ)
	con.v_type = v_type.all_after_last('.')
	type_key := if v_type.contains('.') {
		v_type
	} else {
		'${module_name}.${v_type}'
	}
	mut fields := map[string]ast.Field{}
	if symbol := table.find_sym(type_key) {
		info := symbol.info
		if info is ast.Struct {
			for member in info.fields {
				fields[member.name] = member
			}
		}
	}

	for f in expr.init_fields {
		attrs := fields[f.name].attrs
		mut sub := repr.PhpConstRepr{
			name:       ast.find_attr_arg(attrs, 'vphp.PhpClassConstantName', 'name') or {
				f.name.to_upper()
			}
			attributes: parse_typed_php_attributes(attrs, 'vphp.PhpClassConstantAttribute')
			visibility: ast.find_attr_arg(attrs, 'vphp.PhpClassConstantVisibility', 'visibility') or {
				'public'
			}
			is_final:   attrs.any(it.name == 'vphp.PhpFinalClassConstant')
		}
		if f.expr is ast.StringLiteral {
			sub.value = (f.expr as ast.StringLiteral).val
			sub.const_type = 'string'
		} else if f.expr is ast.IntegerLiteral {
			raw := (f.expr as ast.IntegerLiteral).val
			sub.value = if integer := parse_integer_literal(raw) { integer.str() } else { raw }
			sub.const_type = 'int'
		} else if f.expr is ast.FloatLiteral {
			sub.value = (f.expr as ast.FloatLiteral).val.replace('_', '')
			sub.const_type = 'f64'
		} else if f.expr is ast.BoolLiteral {
			sub.value = if (f.expr as ast.BoolLiteral).val { '1' } else { '0' }
			sub.const_type = 'bool'
		} else if case_ref := parse_constant_enum_case(f.expr, fields[f.name].typ,
			type_key.all_before_last('.')) {
			sub.enum_case = case_ref
		}
		if attrs.any(it.name == 'vphp.PhpClassConstantSince') {
			if sub.const_type == '' && sub.enum_case == none {
				return error('PhpClassConstantSince requires a scalar constant or enum case reference: ${type_key}.${f.name}')
			}
			sub.min_php_version = export_min_php_version(attrs, 'vphp.PhpClassConstantSince',
				'PHP constant ${type_key}.${f.name}')!
		}
		con.fields[f.name] = sub
	}
	return con
}

fn parse_constant_enum_case(expr ast.Expr, field_type string, module_name string) ?repr.PhpEnumCaseRef {
	if field_type == '' {
		return none
	}
	case_name := match expr {
		ast.EnumValueExpr { expr.name }
		ast.SelectorExpr {
			qualifier := *expr.expr
			type_name := match qualifier {
				ast.Ident { qualifier.name }
				ast.SelectorExpr { qualifier.field_name }
				else { '' }
			}
			if type_name != field_type.all_after_last('.') {
				return none
			}
			expr.field_name
		}
		else { return none }
	}
	return repr.PhpEnumCaseRef{field_type, module_name, case_name}
}

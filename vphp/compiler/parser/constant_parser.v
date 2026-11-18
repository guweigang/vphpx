module parser

import compiler.syntax as ast
import compiler.repr

pub fn parse_constant_decl(stmt ast.Stmt, table &ast.Table) ?&repr.PhpConstRepr {
	if stmt !is ast.ConstDecl {
		return none
	}
	const_decl := stmt as ast.ConstDecl
	if const_decl.attrs.any(it.name == 'php_ignore') {
		return none
	}
	mut con := repr.new_const_repr()
	con.has_php_const = const_decl.attrs.any(it.name in ['php_const', 'vphp.PhpExportConstant'])

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
			con.const_type = 'struct'
			con.name = raw_name
			v_type := table.get_type_name(expr.typ)
			con.v_type = v_type.all_after_last('.')
			type_key := if v_type.contains('.') {
				v_type
			} else {
				'${const_decl.module_name}.${v_type}'
			}
			mut field_attributes := map[string][]repr.PhpAttributeRepr{}
			if symbol := table.find_sym(type_key) {
				info := symbol.info
				if info is ast.Struct {
					for member in info.fields {
						field_attributes[member.name] = parse_typed_php_attributes(member.attrs,
							'vphp.PhpClassConstantAttribute')
					}
				}
			}

			for f in expr.init_fields {
				mut sub := repr.PhpConstRepr{
					name:       f.name.to_upper()
					attributes: field_attributes[f.name]
				}
				if f.expr is ast.StringLiteral {
					sub.value = (f.expr as ast.StringLiteral).val
					sub.const_type = 'string'
				} else if f.expr is ast.IntegerLiteral {
					sub.value = (f.expr as ast.IntegerLiteral).val
					sub.const_type = 'int'
				} else if f.expr is ast.FloatLiteral {
					sub.value = (f.expr as ast.FloatLiteral).val
					sub.const_type = 'f64'
				} else if f.expr is ast.BoolLiteral {
					sub.value = if (f.expr as ast.BoolLiteral).val { '1' } else { '0' }
					sub.const_type = 'bool'
				}
				con.fields[f.name] = sub
			}
		} else {
			continue
		}
		return con
	}

	return none
}

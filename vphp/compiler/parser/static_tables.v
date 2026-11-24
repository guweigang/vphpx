module parser

import compiler.syntax as ast
import compiler.repr

pub fn collect_static_tables(stmts []ast.Stmt, table &ast.Table) !map[string]repr.PhpStaticTableRepr {
	mut tables := map[string]repr.PhpStaticTableRepr{}
	for target, entry in collect_shadow_tables(stmts, static_table_prefix)! {
		properties := parse_static_table_properties(entry, table) or {
			return error('PhpStaticTable `${entry.name}`: ${err.msg()}')
		}
		tables[target] = repr.PhpStaticTableRepr{entry.name, entry.module_name, entry.value_type, properties}
	}
	return tables
}

fn parse_static_table_properties(entry ShadowTableSource, table &ast.Table) ![]repr.PhpClassPropRepr {
	type_name := qualified_v_type(entry.module_name, entry.values.typ)
	symbol := table.find_sym(type_name) or {
		return error('values must use a V struct declared in the extension')
	}
	info := symbol.info
	if info !is ast.Struct {
		return error('values must use a V struct')
	}
	mut initializers := map[string]ast.Expr{}
	for field in entry.values.init_fields {
		initializers[field.name] = field.expr
	}
	mut properties := []repr.PhpClassPropRepr{cap: info.fields.len}
	for field in info.fields {
		v_type := table.get_type_name(field.typ)
		if !field.is_mut {
			return error('field `${field.name}` must be mutable')
		}
		if v_type !in ['int', 'i64', 'f64', 'string', 'bool'] {
			return error('field `${field.name}` has unsupported static property type `${v_type}`')
		}
		mut default_value := ?repr.PhpAttributeArg(none)
		if value := initializers[field.name] {
			default_value = static_table_default(value, field.name, v_type)!
		} else if field.has_default_expr {
			default_value = static_table_default(field.default_expr, field.name, v_type)!
		}
		properties << repr.PhpClassPropRepr{
			name:             field.name
			v_field_name:     field.name
			v_type:           v_type
			visibility:       'public'
			is_static:        true
			is_static_shadow: true
			is_mut:           true
			default_value:    default_value
		}
	}
	return properties
}

fn static_table_default(expr ast.Expr, field string, v_type string) !repr.PhpAttributeArg {
	if expr is ast.ParExpr {
		return static_table_default(*expr.expr, field, v_type)
	}
	if expr is ast.StringLiteral {
		return repr.PhpAttributeArg{ kind: 'string', value: expr.val }
	}
	if expr is ast.BoolLiteral {
		return repr.PhpAttributeArg{ kind: 'bool', value: expr.val.str() }
	}
	literal := parse_params_number(expr, v_type) or {
		return error('field `${field}` default must be a scalar literal')
	}
	if literal.php_expr == '(-9223372036854775807 - 1)' {
		return repr.PhpAttributeArg{ kind: 'int', value: min_i64.str() }
	}
	return parse_attr_value(literal.php_expr, '', true)
}

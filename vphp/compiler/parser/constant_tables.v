module parser

import compiler.syntax as ast
import compiler.repr

const constant_table_prefix = 'vphp.PhpConstantTable['
const static_table_prefix = 'vphp.PhpStaticTable['

struct ShadowTableSource {
	name        string
	module_name string
	value_type  string
	values      ast.StructInit
}

pub fn collect_constant_tables(stmts []ast.Stmt, table &ast.Table) !map[string]repr.PhpConstantTableRepr {
	mut tables := map[string]repr.PhpConstantTableRepr{}
	for target, entry in collect_shadow_tables(stmts, constant_table_prefix)! {
		source := parse_constant_struct(entry.values, entry.name, entry.module_name, table)!
		tables[target] = repr.PhpConstantTableRepr{entry.module_name, entry.value_type, source}
	}
	return tables
}

fn collect_shadow_tables(stmts []ast.Stmt, prefix string) !map[string]ShadowTableSource {
	mut tables := map[string]ShadowTableSource{}
	kind := prefix.all_after('.').trim_right('[')
	for stmt in stmts {
		if stmt is ast.ConstDecl && !stmt.attrs.any(it.name == 'php_ignore') {
			for field in stmt.fields {
				expr := field.expr
				if expr !is ast.StructInit {
					continue
				}
				init := expr as ast.StructInit
				if !init.typ.starts_with(prefix) || !init.typ.ends_with(']') {
					continue
				}
				args := init.typ[prefix.len..init.typ.len - 1]
				if !args.contains(',') {
					return error('${kind} `${field.name}` requires a target type and a values type')
				}
				target := qualified_v_type(stmt.module_name, args.all_before(',').trim_space())
				if previous := tables[target] {
					return error('duplicate ${kind} for ${target}: `${previous.name}` and `${field.name}`')
				}
				values := parse_shadow_table_values(init, stmt.module_name, stmts) or {
					return error('${kind} `${field.name}`: ${err.msg()}')
				}
				value_type := args.all_after(',').trim_space().trim_string_left('${stmt.module_name}.')
				tables[target] = ShadowTableSource{field.name.all_after_last('.'), stmt.module_name, value_type, values}
			}
		}
	}
	return tables
}

fn parse_shadow_table_values(init ast.StructInit, module_name string, stmts []ast.Stmt) !ast.StructInit {
	if init.init_fields.len != 1 || init.init_fields[0].name != 'values' {
		return error('expected a single values field')
	}
	mut values := init.init_fields[0].expr
	if values is ast.Ident {
		name := (values as ast.Ident).name
		field := find_module_constant(stmts, module_name, name) or {
			return error('constant source `${name}` must be a V constant struct in ${module_name}')
		}
		values = field.expr
	}
	if values is ast.StructInit {
		return values as ast.StructInit
	}
	return error('values must be a struct initializer or the name of a constant struct')
}

fn find_module_constant(stmts []ast.Stmt, module_name string, name string) ?ast.ValueField {
	for stmt in stmts {
		if stmt is ast.ConstDecl && stmt.module_name == module_name {
			for field in stmt.fields {
				if field.name.all_after_last('.') == name {
					return field
				}
			}
		}
	}
	return none
}

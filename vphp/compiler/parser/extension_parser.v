module parser

import compiler.syntax as ast

pub struct ExtensionMeta {
pub:
	name        string
	version     string
	description string
	ini_entries map[string]string
	present     map[string]bool
}

// Keep the original parser API for callers that expect a named V declaration.
pub fn parse_extension_meta(file_ast ast.File, table &ast.Table) ?(string, string, string, map[string]string) {
	meta := parse_extension_meta_fields(file_ast, table) or { return none }
	if meta.name == '' { return none }
	return meta.name, meta.version, meta.description, meta.ini_entries
}

pub fn parse_extension_meta_fields(file_ast ast.File, table &ast.Table) ?ExtensionMeta {
	mut fallback := ?ExtensionMeta(none)
	for stmt in file_ast.stmts {
		if stmt is ast.ConstDecl {
			for field in stmt.fields {
				if field.name.ends_with('ext_config') && field.expr is ast.StructInit {
					expr := field.expr as ast.StructInit
					v_type := table.get_type_name(expr.typ)
					if !v_type.ends_with('ExtensionConfig') {
						continue
					}
					mut name := ''
					mut version := ''
					mut description := ''
					mut ini_entries := map[string]string{}
					mut present := map[string]bool{}
					for f in expr.init_fields {
						if f.name == 'name' && f.expr is ast.StringLiteral {
							present['name'] = true
							name = (f.expr as ast.StringLiteral).val
						} else if f.name == 'version' && f.expr is ast.StringLiteral {
							present['version'] = true
							version = (f.expr as ast.StringLiteral).val
						} else if f.name == 'description' && f.expr is ast.StringLiteral {
							present['description'] = true
							description = (f.expr as ast.StringLiteral).val
						} else if f.name == 'ini_entries' && f.expr is ast.MapInit {
							m_expr := f.expr as ast.MapInit
							for i, key in m_expr.keys {
								val := m_expr.vals[i]
								if key is ast.StringLiteral && val is ast.StringLiteral {
									k := (key as ast.StringLiteral).val
									v := (val as ast.StringLiteral).val
									ini_entries[k] = v
								}
							}
						}
					}
					meta := ExtensionMeta{name, version, description, ini_entries, present}
					if name != '' {
						return meta
					}
					if fallback == none {
						fallback = meta
					}
				}
			}
		}
	}
	return fallback
}

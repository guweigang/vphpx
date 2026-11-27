module compiler

import compiler.repr

// ---- Class V Glue ----
fn (g VGenerator) gen_class_glue(r &repr.PhpClassRepr) []string {
	return g.gen_class_glue_for_module(r, 'main')
}

fn (g VGenerator) gen_class_glue_for_module(r &repr.PhpClassRepr, module_name string) []string {
	mut out := []string{}
	lower_name := to_snake_case(r.name)
	type_ref := if module_name == r.module_name { r.name } else { r.type_ref() }
	uses_inherited_receiver := class_uses_inherited_receiver(r)

	if r.is_native_trait {
		for method in r.methods {
			if method.is_abstract {
				continue
			}
			glue := ClassMethodGlue.new(r, lower_name, false, method, g.params_structs,
				type_ref, g.table) or { continue }
			out << glue.render_lines()
		}
		return out
	}

	// A. 堆分配器
	out << ClassLifecycleGlue.new(r.name, type_ref, lower_name, r).render_lines()
	if r.cloneable {
		out << [
			"@[export: '${lower_name}_clone_into_raw']",
			'pub fn ${lower_name}_clone_into_raw(source voidptr, target voidptr) {',
			'    unsafe {',
			'        src := &${type_ref}(source)',
			'        mut dst := &${type_ref}(target)',
			'        src.clone_into(mut dst)',
			'    }',
			'}',
		]
	}

	if uses_inherited_receiver {
		out << InheritedReceiverGlue.new(type_ref, lower_name, r, module_name).render_lines()
	}

	mut properties := r.properties.clone()
	properties << r.copy_parent_properties
	out << ClassPropertyGlue.new(r.name, type_ref, lower_name, properties).render_lines()

	// F. 影子访问器
	out << ClassShadowGlue.new(r).render_lines()

	// G. 方法的胶水包装
	for m in r.methods {
		method_glue := ClassMethodGlue.new(r, lower_name, uses_inherited_receiver, m,
			g.params_structs, type_ref, g.table) or { continue }
		out << method_glue.render_lines()
	}

	// F. Handlers 导出
	out << ClassHandlersGlue.new(type_ref, lower_name).render_lines(r.has_init_php_state_method)
	if !r.is_trait {
		out << ClassObjectBindingGlue.new(r.name, type_ref, r.c_name(), lower_name).render_lines()
	}

	return out
}

fn (g VGenerator) gen_enum_glue(r &repr.PhpEnumRepr) []string {
	owner := r.method_owner()
	mut lines := []string{}
	if r.backing == .integer && r.cases.len > 0 {
		backing_values := r.backing_values_function()
		value_type := if r.unsigned_backing { 'u64' } else { 'i64' }
		lines << "@[export: '${backing_values}']"
		lines << 'fn ${backing_values}(values &${value_type}) {'
		lines << '    unsafe {'
		for i, case_ in r.cases {
			name := if is_v_keyword(case_.v_name) { '@' + case_.v_name } else { case_.v_name }
			lines << '        values[${i}] = ${value_type}(${r.name}.${name})'
		}
		lines << '    }'
		lines << '}'
	}
	for method in r.methods {
		glue := ClassMethodGlue.new(&owner, to_snake_case(r.name), false, method,
			g.params_structs, r.name, g.table) or { continue }
		lines << glue.render_lines()
	}
	lines << 'pub fn (val ${r.name}) php_class_name() string {'
	lines << "    return '${r.php_name.replace("'", "\\'")}'"
	lines << '}'
	if r.cases.any(it.v_name != it.php_name) {
		lines << 'pub fn (val ${r.name}) php_enum_case_name() string {'
		for case_ in r.cases {
			name := if is_v_keyword(case_.v_name) { '@' + case_.v_name } else { case_.v_name }
			lines << "    if val == .${name} { return '${case_.php_name}' }"
		}
		lines << '    return val.str()'
		lines << '}'
	}
	return lines
}

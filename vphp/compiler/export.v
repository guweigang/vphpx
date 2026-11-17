module compiler

import os
import strings
import compiler.builder
import compiler.repr

fn (c Compiler) collect_non_type_fragments() builder.ExportFragments {
	mut fragments := builder.ExportFragments{}
	c_emitter := CGenerator{
		ext_name:          c.ext_name
		class_ce_by_type:  c.class_ce_map()
		class_php_by_type: c.class_php_map()
		table:             c.table
	}

	for el in c.elements {
		if el is repr.PhpFuncRepr {
			fragments.merge(c_emitter.build_func_export(el))
		} else if el is repr.PhpConstRepr {
			if el.has_php_const && el.const_type != 'struct' {
				fragments.merge(c_emitter.build_global_constant(el).export_fragments())
			}
		}
	}

	return fragments
}

fn (c Compiler) collect_type_fragments() builder.ExportFragments {
	mut fragments := builder.ExportFragments{}
	c_emitter := CGenerator{
		ext_name:          c.ext_name
		class_ce_by_type:  c.class_ce_map()
		class_php_by_type: c.class_php_map()
		table:             c.table
	}

	for el in c.elements {
		if el is repr.PhpInterfaceRepr {
			fragments.merge(c_emitter.build_interface_export(el))
		}
	}

	for el in c.elements {
		if el is repr.PhpClassRepr && !el.is_trait {
			fragments.merge(c_emitter.build_class_export(el))
		} else if el is repr.PhpEnumRepr {
			fragments.merge(c_emitter.build_enum_export(el))
		}
	}

	return fragments
}

fn (c Compiler) struct_closure_metadata() []StructClosureBinding {
	mut bindings := []StructClosureBinding{}
	for el in c.elements {
		if el is repr.PhpFuncRepr {
			if binding := StructClosureBinding.new(el.name, el.return_spec.effective_v_type(),
				c.params_structs) {
				if binding.kind == .params_struct {
					bindings << binding
				}
			}
		} else if el is repr.PhpClassRepr && !el.is_trait {
			for method in el.methods {
				if method.has_export || method.is_abstract {
					continue
				}
				name := if method.v_name != '' { method.v_name } else { method.name }
				if binding := StructClosureBinding.new('${el.name}_${name}',
					method.return_spec.effective_v_type(), c.params_structs) {
					if binding.kind == .params_struct {
						bindings << binding
					}
				}
			}
		}
	}
	return bindings
}

// ==========================================
// 1. 总入口：由外部 build.v 调用
// ==========================================
pub fn (mut c Compiler) generate_all() ! {
	mut closure_defaults := []StructClosureBinding{}
	for binding in c.struct_closure_metadata() {
		if binding.computed_default_indices().len > 0 {
			closure_defaults << binding
		}
	}
	default_class := 'VPHP\\Internal\\${sanitize_struct_closure_token(c.ext_name)}_ClosureDefault'
	ordinary_defaults := c.bind_ordinary_defaults(default_class, closure_defaults.len)
	c.generate_h()!
	c.generate_c(default_class, closure_defaults, ordinary_defaults)!
	c.generate_v_glue()!
}

struct OrdinaryDefaultBinding {
	handler string
	fields  []int
}

fn (mut c Compiler) bind_ordinary_defaults(default_class string, first_id int) []OrdinaryDefaultBinding {
	mut bindings := []OrdinaryDefaultBinding{}
	for mut el in c.elements {
		if mut el is repr.PhpFuncRepr {
			if !el.uses_context {
				handler := 'ZEND_FN(${el.name})'
				fields := bind_default_markers(mut el.args, default_class, first_id + bindings.len)
				if fields.len > 0 {
					bindings << OrdinaryDefaultBinding{handler, fields}
				}
			}
		} else if mut el is repr.PhpClassRepr {
			if el.is_trait {
				continue
			}
			for mut method in el.methods {
				if method.has_export || method.is_abstract || method_uses_context_arg(method) {
					continue
				}
				handler := 'ZEND_MN(${el.c_name()}_${php_method_name(method.name)})'
				fields := bind_default_markers(mut method.args, default_class, first_id + bindings.len)
				if fields.len > 0 {
					bindings << OrdinaryDefaultBinding{handler, fields}
				}
			}
		}
	}
	return bindings
}

fn bind_default_markers(mut args []repr.PhpArgRepr, default_class string, id int) []int {
	mut fields := []int{}
	for index, mut arg in args {
		if arg.source.params_computed_default && !arg.use_php_default {
			arg.php_default = 'new \\${default_class}(${id}, ${index})'
			fields << index
		}
	}
	return fields
}

// ==========================================
// 2. 生成 C 源文件 (php_bridge.c)
// ==========================================
fn (mut c Compiler) generate_c(default_class string, closure_defaults []StructClosureBinding, ordinary_defaults []OrdinaryDefaultBinding) ! {
	mut res := strings.new_builder(2048)
	res.write_string('/* ⚠️ VPHP Compiler Generated for ${c.ext_name} */\n')
	res.write_string('#include "php_bridge.h"\n\n')
	res.write_string('#include "../vphp/v_bridge.h"\n\n')

	// 2. 模块层：初始化 ModuleBuilder 并收集功能点
	mut mod_builder := builder.new_module_builder(c.ext_name, c.ext_version, c.ext_description)
	mut fragments := c.collect_non_type_fragments()
	mut type_fragments := c.collect_type_fragments()
	for k, v in c.ini_entries {
		mod_builder.add_ini_entry(k, v)
	}
	mod_builder.globals = c.globals_repr

	res.write_string(mod_builder.render_declarations())
	mut default_id := 0
	for binding in c.struct_closure_metadata() {
		mut computed_defaults := map[int]string{}
		for i in binding.computed_default_indices() {
			// Reflection can construct the descriptor without invoking V.
			computed_defaults[i] = 'new \\${default_class}(${default_id}, ${i})'
		}
		if computed_defaults.len > 0 {
			default_id++
		}
		res.write_string(builder.render_closure_arginfo(binding.arginfo_symbol(), binding.fields,
			binding.required_fields(), computed_defaults, c.table) + '\n')
	}
	// 1. 业务逻辑层：写入每个导出单元的实例实现
	for line in fragments.implementations {
		res.write_string(line + '\n')
	}
	for line in type_fragments.implementations {
		res.write_string(line + '\n')
	}
	if closure_defaults.len > 0 || ordinary_defaults.len > 0 {
		res.write_string(render_computed_default_dispatch(closure_defaults, ordinary_defaults))
		mod_builder.add_minit_line('vphp_register_closure_default_class("${c_string_escape(default_class)}", vphp_dispatch_computed_default);')
	}

	for fn_builder in fragments.function_table {
		mod_builder.add_function(fn_builder)
	}

	// 注入 MINIT 内容
	for line in fragments.minit_lines {
		mod_builder.add_minit_line(line)
	}
	for line in type_fragments.minit_lines {
		mod_builder.add_minit_line(line)
	}
	for line in fragments.rinit_lines {
		mod_builder.add_rinit_line(line)
	}
	for line in type_fragments.rinit_lines {
		mod_builder.add_rinit_line(line)
	}

	// 3. 渲染各个 C 块
	res.write_string(mod_builder.render_globals_struct())
	res.write_string(mod_builder.render_ginit())
	res.write_string(mod_builder.render_ini_entries())
	res.write_string(mod_builder.render_functions_table())
	res.write_string(mod_builder.render_minit())
	res.write_string(mod_builder.render_mshutdown())
	res.write_string(mod_builder.render_rinit())
	res.write_string(mod_builder.render_rshutdown())
	res.write_string(mod_builder.render_minfo())
	res.write_string(mod_builder.render_globals_getter())
	res.write_string(mod_builder.render_module_entry())
	res.write_string(mod_builder.render_get_module())

	os.write_file('php_bridge.c', res.str())!
}

fn render_computed_default_dispatch(closures []StructClosureBinding, ordinary []OrdinaryDefaultBinding) string {
	mut lines := ['static bool vphp_dispatch_computed_default(const zend_internal_function *func, zend_long callable, zend_long field) {']
	lines << '    switch (callable) {'
	for i, binding in closures {
		fields := binding.computed_default_indices().map('field == ${it}').join(' || ')
		lines << '        case ${i}:'
		lines << '            return (${fields}) && func->arg_info == ${binding.arginfo_symbol()}_storage + 1;'
	}
	for i, binding in ordinary {
		fields := binding.fields.map('field == ${it}').join(' || ')
		lines << '        case ${closures.len + i}:'
		lines << '            return (${fields}) && vphp_matches_computed_default_handler(func, ${binding.handler});'
	}
	lines << '        default: break;'
	lines << '    }'
	lines << '    return false;'
	lines << '}'
	return lines.join('\n') + '\n'
}

// ==========================================
// 3. 生成 V 胶水代码 (_task_glue.v)
// ==========================================
fn (mut c Compiler) generate_v_glue() ! {
	v_glue := VGenerator{
		ext_name:       c.ext_name
		globals_repr:   c.globals_repr
		params_structs: c.params_structs
		table:          c.table
	}
	v_code := v_glue.generate(mut c.elements)
	os.write_file(c.bridge_output_path(), v_code)!
	v_glue.generate_module_bridges(c.elements, c.module_dirs)!
}

fn (c Compiler) bridge_output_path() string {
	if c.target_files.len == 0 {
		return 'vphp_bridge.v'
	}
	mut target_dir := os.dir(c.target_files[0])
	for file in c.target_files[1..] {
		dir := os.dir(file)
		if dir.len < target_dir.len {
			target_dir = dir
		}
	}
	if target_dir == '' {
		return 'vphp_bridge.v'
	}
	return os.join_path(target_dir, 'vphp_bridge.v')
}

// ==========================================
// 4. 生成头文件 (php_bridge.h)
// ==========================================
fn (mut c Compiler) generate_h() ! {
	mut res := strings.new_builder(1024)

	// 1. 写入文件头和头文件保护 (Header Guard)
	res.write_string('/* ⚠️ VPHP Compiler Generated，请勿手动修改 */\n')
	guard := 'VPHP_EXT_${c.ext_name.to_upper()}_BRIDGE_H'
	res.write_string('#ifndef ${guard}\n')
	res.write_string('#define ${guard}\n\n')

	// 2. 引入必要的 PHP 内核头文件
	res.write_string('#include <php.h>\n')
	res.write_string('#include <Zend/zend_attributes.h>\n')
	res.write_string('#include <Zend/zend_enum.h>\n')
	res.write_string('#include <ext/standard/info.h>\n\n')
	res.write_string('#ifndef ZEND_ACC_READONLY_CLASS\n')
	res.write_string('#define ZEND_ACC_READONLY_CLASS 0\n')
	res.write_string('#endif\n\n')

	// 3. 写入扩展模块入口声明
	res.write_string('extern zend_module_entry ${c.ext_name}_module_entry;\n')
	res.write_string('#define phpext_${c.ext_name}_ptr &${c.ext_name}_module_entry\n\n')
	res.write_string('extern void* vphp_get_active_globals();\n\n')
	for binding in c.struct_closure_metadata() {
		res.write_string('extern void *${binding.arginfo_symbol()};\n')
	}

	fragments := c.collect_non_type_fragments()
	type_fragments := c.collect_type_fragments()
	for line in fragments.declarations {
		res.write_string(line + '\n')
	}
	for line in type_fragments.declarations {
		res.write_string(line + '\n')
	}

	// 6. 写入头文件保护结束
	res.write_string('#endif\n')

	// 7. 物理写入文件
	os.write_file('php_bridge.h', res.str()) or { return error('无法写入 php_bridge.h: $err') }

	println('  - [Generator] 已生成 php_bridge.h')
}

module compiler

import os
import strings
import compiler.builder
import compiler.linker
import compiler.php_types
import compiler.repr

// Reflection exposes trait aliases but has no API for insteadof rules.
pub fn (c Compiler) stub_trait_precedences() map[string][]repr.PhpTraitPrecedence {
	mut rules := map[string][]repr.PhpTraitPrecedence{}
	for element in c.elements {
		if element is repr.PhpClassRepr && element.native_trait_precedences.len > 0 {
			rules[php_types.class_lookup_name(element.php_name)] = element.native_trait_precedences.map(repr.PhpTraitPrecedence{
				...it
				trait_name:      php_types.class_lookup_name(it.trait_name)
				method:          it.method
				excluded_traits: it.excluded_traits.map(php_types.class_lookup_name(it))
			})
		}
	}
	return rules
}

pub struct StubTraitAdaptations {
pub:
	precedences map[string][]repr.PhpTraitPrecedence
	aliases     map[string][]repr.PhpTraitAlias
}

// Reflection omits the visibility modifiers and as rules without a new name.
pub fn (c Compiler) stub_trait_adaptations() StubTraitAdaptations {
	mut aliases := map[string][]repr.PhpTraitAlias{}
	for element in c.elements {
		if element is repr.PhpClassRepr && element.native_trait_aliases.len > 0 {
			aliases[php_types.class_lookup_name(element.php_name)] = element.native_trait_aliases.map(repr.PhpTraitAlias{
				...it
				trait_name: php_types.class_lookup_name(it.trait_name)
			})
		}
	}
	return StubTraitAdaptations{
		precedences: c.stub_trait_precedences()
		aliases:     aliases
	}
}

fn method_has_override(method repr.PhpMethodRepr) bool {
	return method.attributes.any(php_types.is_override_attribute(it.name))
}

fn property_has_override(property repr.PhpClassPropRepr) bool {
	return property.attributes.any(php_types.is_override_attribute(it.name))
}

// An external interface may only be available once PHP user code is loaded.
pub fn (c Compiler) stub_override_interfaces() map[string][]string {
	return c.collect_stub_member_interfaces(.method)
}

pub fn (c Compiler) stub_property_override_interfaces() map[string][]string {
	return c.collect_stub_member_interfaces(.property)
}

pub fn (c Compiler) stub_hook_interfaces() map[string][]string {
	return c.collect_stub_member_interfaces(.hook)
}

enum StubInterfaceMember {
	method
	property
	hook
}

fn (c Compiler) collect_stub_member_interfaces(member StubInterfaceMember) map[string][]string {
	mut classes := map[string]repr.PhpClassRepr{}
	mut interfaces := map[string][]string{}
	for element in c.elements {
		if element is repr.PhpClassRepr && !element.is_trait {
			classes[php_types.class_lookup_name(element.php_name).to_lower()] = element
		}
	}
	for _, class_ in classes {
		needs_interfaces := match member {
			.method { class_.methods.any(it.hook_kind == '' && method_has_override(it)) }
			.property { class_.properties.any(property_has_override(it)) }
			.hook { class_.methods.any(it.hook_kind != '') }
		}
		if !needs_interfaces {
			continue
		}
		mut ancestor := class_
		for {
			if ancestor.auto_interface_bindings.len > 0 {
				name := php_types.class_lookup_name(ancestor.php_name)
				interfaces[name] = ancestor.auto_interface_bindings.map(php_types.class_lookup_name(it))
			}
			ancestor = classes[php_types.class_lookup_name(ancestor.parent).to_lower()] or { break }
		}
	}
	return interfaces
}

fn (c Compiler) collect_non_type_fragments() builder.ExportFragments {
	mut fragments := builder.ExportFragments{}
	c_emitter := CGenerator{
		ext_name:              c.ext_name
		class_ce_by_type:      c.class_ce_map()
		class_php_by_type:     c.class_php_map()
		interface_php_by_type: c.interface_php_map()
		table:                 c.table
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

fn (c Compiler) collect_type_fragments() !builder.ExportFragments {
	mut fragments := builder.ExportFragments{}
	c_emitter := CGenerator{
		ext_name:              c.ext_name
		class_ce_by_type:      c.class_ce_map()
		class_php_by_type:     c.class_php_map()
		interface_php_by_type: c.interface_php_map()
		table:                 c.table
	}

	mut types := []repr.PhpRepr{}
	for el in c.elements {
		if el is repr.PhpInterfaceRepr {
			types << el
		}
	}
	for el in c.elements {
		if (el is repr.PhpClassRepr && (!el.is_trait || el.is_native_trait)) || el is repr.PhpEnumRepr {
			types << el
		}
	}
	for el in linker.registration_order(types)! {
		if el is repr.PhpInterfaceRepr {
			fragments.merge(c_emitter.build_interface_export(el))
		} else if el is repr.PhpClassRepr {
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
			if binding := StructClosureBinding.new(el.symbol(), el.return_spec.effective_v_type(),
				el.module_name, c.params_structs, c.table) {
				bindings << binding
			}
		} else if el is repr.PhpClassRepr && (!el.is_trait || el.is_native_trait) {
			for method in el.methods {
				if method.has_export || method.is_abstract || method.native_trait_source != '' {
					continue
				}
				name := if method.v_name != '' { method.v_name } else { method.name }
				if binding := StructClosureBinding.new('${el.name}_${name}',
					method.return_spec.effective_v_type(), el.module_name, c.params_structs, c.table) {
					bindings << binding
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
	has_interface_defaults := c.bind_interface_default_markers(default_class,
		closure_defaults.len + ordinary_defaults.len)
	c.generate_h()!
	c.generate_c(default_class, closure_defaults, ordinary_defaults, has_interface_defaults)!
	c.generate_v_glue()!
}

fn (mut c Compiler) bind_interface_default_markers(default_class string, first_id int) bool {
	mut next_id := first_id
	for mut element in c.elements {
		if mut element is repr.PhpInterfaceRepr {
			for mut method in element.methods {
				if bind_default_markers(mut method.args, default_class, next_id).len > 0 {
					next_id++
				}
			}
		}
	}
	return next_id > first_id
}

struct OrdinaryDefaultBinding {
	handler                   string
	fields                    []int
	min_php_version           int
	max_php_version_exclusive int
}

fn (mut c Compiler) bind_ordinary_defaults(default_class string, first_id int) []OrdinaryDefaultBinding {
	mut bindings := []OrdinaryDefaultBinding{}
	for mut el in c.elements {
		if mut el is repr.PhpFuncRepr {
			if !el.uses_context {
				handler := 'ZEND_FN(${el.symbol()})'
				fields := bind_default_markers(mut el.args, default_class, first_id + bindings.len)
				if fields.len > 0 {
					bindings << OrdinaryDefaultBinding{
						handler:         handler
						fields:          fields
						min_php_version: el.min_php_version
					}
				}
			}
		} else if mut el is repr.PhpClassRepr {
			if el.is_trait && !el.is_native_trait {
				continue
			}
			for mut method in el.methods {
				if method.has_export || method.is_abstract || class_method_uses_context_arg(el, &method) {
					continue
				}
				handler := 'ZEND_MN(${method.handler_symbol(el.c_name())})'
				fields := bind_default_markers(mut method.args, default_class, first_id + bindings.len)
				if fields.len > 0 {
					bindings << OrdinaryDefaultBinding{
						handler:                   handler
						fields:                    fields
						min_php_version:           if method.min_php_version > el.min_php_version {
							method.min_php_version
						} else {
							el.min_php_version
						}
						max_php_version_exclusive: method.max_php_version_exclusive
					}
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
fn (mut c Compiler) generate_c(default_class string, closure_defaults []StructClosureBinding, ordinary_defaults []OrdinaryDefaultBinding, has_interface_defaults bool) ! {
	mut res := strings.new_builder(2048)
	res.write_string('/* ⚠️ VPHP Compiler Generated for ${c.ext_name} */\n')
	res.write_string('#include "php_bridge.h"\n\n')
	res.write_string('#include "../vphp/v_bridge.h"\n\n')

	// 2. 模块层：初始化 ModuleBuilder 并收集功能点
	mut mod_builder := builder.new_module_builder(c.ext_name, c.ext_version, c.ext_description)
	mod_builder.has_native_traits = c.elements.any(it is repr.PhpClassRepr && it.is_native_trait)
	mut fragments := c.collect_non_type_fragments()
	mut type_fragments := c.collect_type_fragments()!
	for k, v in c.ini_entries {
		mod_builder.add_ini_entry(k, v)
	}
	mod_builder.globals = c.globals_repr

	res.write_string(mod_builder.render_declarations())
	signatures := CGenerator{
		class_php_by_type:     c.class_php_map()
		interface_php_by_type: c.interface_php_map()
		table:                 c.table
	}
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
		php_return := signatures.interface_wrapper_signature(binding.ret_type, binding.module_name) or {
			if binding.returns_object() {
				signatures.named_type_signature(binding.ret_type, binding.module_name, true)
			} else {
				''
			}
		}
		php_variadic_type := signatures.interface_wrapper_signature(binding.variadic_arg_type,
			binding.module_name) or {
			if binding.has_bound_variadic_args() {
				signatures.named_type_signature(binding.variadic_arg_type, binding.module_name, true)
			} else {
				''
			}
		}
		mut fields := binding.fields.clone()
		for mut field in fields {
			if php_type := signatures.interface_wrapper_signature(field.v_type, binding.module_name) {
				field.php_named_type = php_type
			} else if binding.kind == .fixed && is_closure_named_field(field.v_type, c.table) {
				field.php_named_type = signatures.named_type_signature(field.v_type, binding.module_name, true)
			}
		}
		arginfo, setup := builder.render_closure_arginfo(binding.arginfo_symbol(), fields,
			binding.required_fields(), computed_defaults, binding.variadic_arg_type, binding.variadic_arg_name,
			php_variadic_type, binding.returns_reference(), php_return, binding.ret_type, c.table)
		res.write_string(arginfo + '\n')
		for line in setup {
			mod_builder.add_minit_line(line)
		}
		if fields.any(it.is_sensitive) {
			// Internal closures borrow their attribute table from the module.
			attributes := '${binding.arginfo_symbol()}_attributes'
			res.write_string('HashTable *${attributes} = NULL;\n')
			for i, field in fields {
				if field.is_sensitive {
					mod_builder.add_minit_line('vphp_add_sensitive_closure_parameter(&${attributes}, ${i});')
				}
			}
			mod_builder.mshutdown_content << 'if (${attributes} != NULL) { zend_hash_destroy(${attributes}); pefree(${attributes}, 1); ${attributes} = NULL; }'
		}
	}
	// 1. 业务逻辑层：写入每个导出单元的实例实现
	for line in fragments.implementations {
		res.write_string(line + '\n')
	}
	for line in type_fragments.implementations {
		res.write_string(line + '\n')
	}
	static_request := c.render_static_request_binding()
	if static_request != '' {
		res.write_string(static_request)
		mod_builder.has_static_request = true
	}
	if closure_defaults.len > 0 || ordinary_defaults.len > 0 || has_interface_defaults {
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
		lines << '            return (${fields}) && vphp_matches_computed_default_arginfo(func, ${binding.arginfo_symbol()}_storage);'
	}
	for i, binding in ordinary {
		fields := binding.fields.map('field == ${it}').join(' || ')
		lines << builder.for_php_version_range(binding.min_php_version,
			binding.max_php_version_exclusive, [
				'        case ${closures.len + i}:',
				'            return (${fields}) && vphp_matches_computed_default_handler(func, ${binding.handler});',
			])
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
		ext_name:            c.ext_name
		globals_repr:        c.globals_repr
		params_structs:      c.params_structs
		external_interfaces: c.external_interfaces
		table:               c.table
	}
	v_code := v_glue.generate(mut c.elements, c.module_dirs)
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
		if binding.fields.any(it.is_sensitive) {
			res.write_string('extern HashTable *${binding.arginfo_symbol()}_attributes;\n')
		}
	}

	fragments := c.collect_non_type_fragments()
	type_fragments := c.collect_type_fragments()!
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

// vphp/compiler/entry.v
module compiler

import os
import compiler.syntax as ast
import compiler.linker
import compiler.parser as cparser
import compiler.repr

pub struct Compiler {
pub:
	target_files []string
pub mut:
	ext_name        string
	ext_version     string
	ext_description string
	ini_entries     map[string]string
	globals_repr    repr.PhpGlobalsRepr
	elements        []repr.PhpRepr
	params_structs  map[string]repr.PhpParamsStruct
mut:
	table               &ast.Table
	decl_modules        map[string]string
	module_dirs         map[string]string
	external_interfaces map[string]string
	userland_subclasses []UserlandSubclass
}

pub fn new(target_files []string) Compiler {
	return Compiler{
		target_files: target_files
		ext_name:     ''
		table:        ast.new_table()
	}
}

pub fn (mut c Compiler) compile() !string {
	mut all_stmts := []ast.Stmt{}
	c.module_dirs.clear()

	for file in c.target_files {
		file_ast := ast.parse_file(file, mut c.table)!
		if file_ast.module_name !in c.module_dirs {
			c.module_dirs[file_ast.module_name] = os.dir(file)
		}
		if c.ext_name == '' {
			if name, version, description, ini_entries := cparser.parse_extension_meta(file_ast,
				c.table)
			{
				c.ext_name = name
				c.ext_version = version
				c.ext_description = description
				c.ini_entries = ini_entries.clone()
			}
		}
		c.remember_decl_modules(file_ast.stmts, file_ast.module_name)
		all_stmts << file_ast.stmts
	}

	if c.ext_name == '' {
		return error('无法在输入的文件中找到 ext_config 配置，请确保定义了 ExtensionConfig')
	}
	println('  - [Compiler] 识别到扩展名: ${c.ext_name}')
	c.external_interfaces = cparser.collect_external_interfaces(all_stmts)!
	field_types := cparser.collect_struct_field_types(all_stmts, c.table)
	resolved_borrowed := linker.resolve_borrowed_methods(all_stmts, c.table, field_types)
	method_return_types := linker.collect_method_return_types(all_stmts, c.table, field_types)

	// --- 第一阶段：扫描所有 Struct 定义 ---
	c.elements, c.globals_repr, c.params_structs = cparser.parse_structural_elements(all_stmts, c.table,
		c.decl_modules)!

	// --- 第二阶段：扫描所有 Fn 定义 ---
	cparser.parse_behavioral_elements(all_stmts, c.table, mut c.elements,
		field_types, c.params_structs, resolved_borrowed, method_return_types)!
	validate_function_names(c.elements)!
	validate_constant_names(c.elements)!

	linker.link_class_shadows(mut c.elements, c.table)!
	mut constant_tables := cparser.collect_constant_tables(all_stmts, c.table)!
	linker.link_constant_tables(mut c.elements, mut constant_tables)!
	mut static_tables := cparser.collect_static_tables(all_stmts, c.table)!
	linker.link_static_tables(mut c.elements, mut static_tables)!
	linker.resolve_and_apply_borrow_returns(mut c.elements, all_stmts, c.table, field_types)
	signature_generator := CGenerator{
		class_ce_by_type:  c.class_ce_map()
		class_php_by_type: c.class_php_map()
		table:             c.table
	}
	linker.link_native_trait_uses(mut c.elements, fn [signature_generator] (owner &repr.PhpClassRepr, left &repr.PhpMethodRepr, right &repr.PhpMethodRepr) bool {
		if left.is_static != right.is_static {
			return false
		}
		left_signature := signature_generator.build_method_signature(owner, left)
		right_signature := signature_generator.build_method_signature(owner, right)
		return left_signature.same_php_signature(right_signature, signature_generator.table)
	})!
	linker.link_class_traits(mut c.elements)!
	linker.link_class_embeds(mut c.elements)!
	linker.link_class_parents(mut c.elements)!
	linker.link_object_copy_policies(mut c.elements)!
	linker.validate_inherited_object_classes(c.elements)!
	linker.link_interface_parents(mut c.elements)!
	linker.link_class_interfaces(mut c.elements)!
	type_versions := linker.link_type_versions(mut c.elements)!
	c.userland_subclasses = collect_userland_subclasses(c.elements, type_versions)!
	validate_attribute_arguments(c.elements)!
	c.link_function_signature_versions(type_versions)

	return c.ext_name
}

fn validate_function_names(elements []repr.PhpRepr) ! {
	mut seen := map[string]string{}
	for element in elements {
		if element is repr.PhpFuncRepr {
			if !valid_php_export_name(element.name) {
				return error('invalid exported PHP function name `${element.name}`')
			}
			key := element.name.to_lower()
			if previous := seen[key] {
				return error('duplicate exported PHP function name `${element.name}` (already exported as `${previous}`)')
			}
			seen[key] = element.name
		}
	}
}

fn validate_constant_names(elements []repr.PhpRepr) ! {
	mut seen := map[string]string{}
	for element in elements {
		if element is repr.PhpConstRepr && element.has_php_const && element.const_type != 'struct' {
			name := element.name
			if !valid_php_export_name(name) {
				return error('invalid exported PHP constant name `${name}`')
			}
			// Zend folds only the namespace; the constant's short name is case-sensitive.
			key := if separator := name.last_index('\\') {
				name[..separator].to_lower() + name[separator..]
			} else {
				name
			}
			if previous := seen[key] {
				return error('duplicate exported PHP constant name `${name}` (already exported as `${previous}`)')
			}
			seen[key] = name
		}
	}
}

fn valid_php_export_name(name string) bool {
	for part in name.split('\\') {
		if part == '' || part[0].is_digit()
			|| !part.bytes().all(it.is_alnum() || it == `_` || it >= 128) {
			return false
		}
	}
	return true
}

fn (mut c Compiler) remember_decl_modules(stmts []ast.Stmt, module_name string) {
	for stmt in stmts {
		key := cparser.decl_key(stmt)
		if key != '' {
			c.decl_modules[key] = module_name
		}
		short_key := cparser.decl_short_key(stmt)
		if short_key != '' {
			c.decl_modules[short_key] = module_name
		}
	}
}

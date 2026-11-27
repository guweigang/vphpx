module parser

import compiler.syntax as ast
import compiler.repr

pub fn parse_class_decl(stmt ast.Stmt, table &ast.Table, module_name string) ?&repr.PhpClassRepr {
	if stmt !is ast.StructDecl {
		return none
	}
	struct_decl := stmt as ast.StructDecl
	if struct_decl.attrs.any(it.name == 'php_ignore') {
		return none
	}
	mut cls := repr.new_class_repr()
	cls.is_native_trait = struct_decl.attrs.any(it.name == 'vphp.PhpExportTrait')
	cls.is_trait = cls.is_native_trait || struct_decl.attrs.any(it.name in ['php_trait', 'vphp.PhpTrait'])
	if !cls.is_trait && !struct_decl.attrs.any(it.name == 'php_class') {
		return none
	}
	cls.native_trait_alias_spec = ast.find_attr_arg(struct_decl.attrs, 'vphp.PhpTraitAliases', 'aliases') or { '' }

	cls.name = struct_decl.name.all_after_last('.')
	cls.module_name = module_name
	subclass := 'vphp.PhpUserlandSubclass'
	if struct_decl.attrs.any(it.name == subclass) {
		cls.userland_subclass = repr.PhpUserlandSubclassRepr{
			name:   ast.find_attr_arg(struct_decl.attrs, subclass, 'name') or { '' }
			parent: ast.find_attr_arg(struct_decl.attrs, subclass, 'parent') or { '' }
		}
	}
	cls.has_v_fields = struct_decl.fields.len > 0 || struct_decl.embeds.len > 0
	cls.attributes = parse_php_type_attributes(struct_decl.attrs, 'vphp.PhpClassAttribute')
	cls.php_name = cls.name
	if name := ast.find_attr_arg(struct_decl.attrs, 'vphp.PhpExportTrait', 'name') {
		if name != '' {
			cls.php_name = name.trim_string_left('\\').replace('\\', '\\\\')
		}
	} else if attr := ast.find_attr(struct_decl.attrs, if cls.is_trait {
		'php_trait'
	} else {
		'php_class'
	}) {
		cls.php_name = if attr.arg != '' { attr.arg } else { cls.name }
	}
	if attr := ast.find_attr(struct_decl.attrs, 'php_extends') {
		cls.parent = normalize_attr_value(attr.arg)
	}
	mut php_prop_map := map[string]string{}
	for attr in struct_decl.attrs {
		if attr.name == 'php_const' {
			cls.shadow_const_name = attr.arg
		} else if attr.name == 'php_static' {
			cls.shadow_static_name = attr.arg
		} else if attr.name in ['php_abstract', 'vphp.PhpAbstractClass'] {
			cls.is_abstract = true
		} else if attr.name == 'vphp.PhpFinalClass' {
			cls.is_final = true
		} else if attr.name == 'vphp.PhpReadonlyClass' {
			cls.is_readonly = true
		} else if attr.name == 'vphp.PhpObjectCopy' {
			cls.cloneable = attr.args['cloneable'] == 'true'
			cls.serializable = attr.args['serializable'] == 'true'
		} else if attr.name == 'vphp.PhpZendPropertyCopy' {
			cls.copy_zend_properties = true
		} else if attr.name == 'php_implements' {
			cls.implements_attr << parse_attr_list(attr.arg)
		} else if attr.name == 'php_prop' {
			if php_prop := parse_php_prop_attr(attr.arg) {
				cls.properties << php_prop
			}
		} else if attr.name in ['vphp.PhpDeclaredProperty', 'vphp.PhpDeclaredPropertyWithDefault',
			'vphp.PhpDeclaredStaticProperty', 'vphp.PhpDeclaredStaticPropertyWithDefault',
			'vphp.PhpDeclaredPropertyWithSetVisibility',
			'vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault',
			'vphp.PhpDeclaredStaticPropertyWithSetVisibility',
			'vphp.PhpDeclaredStaticPropertyWithSetVisibilityAndDefault',
			'vphp.PhpDeclaredReadonlyProperty'] {
			if php_prop := parse_declared_property_attr(attr) {
				cls.properties << php_prop
			}
		} else if attr.name == 'php_prop_map' {
			for v_field_name, php_prop_name in parse_php_prop_map(attr.arg) {
				php_prop_map[v_field_name] = php_prop_name
			}
		}
	}
	if struct_decl.is_implements {
		for iface in struct_decl.implements_types {
			name := strip_module(table.get_type_name(iface.typ))
			if name != '' {
				cls.implements_v << name
			}
		}
	}
	for embed in struct_decl.embeds {
		embed_name := strip_module(table.get_type_name(embed.typ))
		if embed_name != '' {
			cls.embeds_v << embed_name
		}
	}
	for field in struct_decl.fields {
		if field.attrs.any(it.name in ['php_ignore', 'vphp.PhpIgnoreField']) {
			continue
		}
		type_name := table.get_type_name(field.typ)
		mut is_static := field.attrs.any(it.name in ['php_static', 'vphp.PhpStaticProperty'])
		mut php_prop_name := php_prop_map[field.name] or { field.name }
		if attr := ast.find_attr(field.attrs, 'php_prop') {
			normalized := normalize_attr_value(attr.arg)
			if normalized != '' {
				php_prop_name = normalized
			}
		}
		if attr := ast.find_attr(field.attrs, 'php_prop_name') {
			normalized := normalize_attr_value(attr.arg)
			if normalized != '' {
				php_prop_name = normalized
			}
		}
		if !is_static {
			for comment in field.comments {
				if comment.text.contains('@[php_static]') {
					is_static = true
					break
				}
			}
		}
		if php_prop_name == field.name {
			for comment in field.comments {
				text := comment.text
				start := text.index('@[php_prop_name:') or { continue }
				rest := text[start + '@[php_prop_name:'.len..]
				end := rest.index(']') or { continue }
				normalized := normalize_attr_value(rest[..end])
				if normalized != '' {
					php_prop_name = normalized
					break
				}
			}
		}

		cls.properties << repr.PhpClassPropRepr{
			name:             php_prop_name
			v_field_name:     field.name
			v_type:           type_name
			visibility:       if field.is_pub { 'public' } else { 'protected' }
			is_static:        is_static
			is_mut:           field.is_mut
			is_property_only: false
			attributes:       parse_typed_php_attributes(field.attrs, 'vphp.PhpPropertyAttribute')
		}
	}
	return cls
}

fn declared_property_index(cls &repr.PhpClassRepr, name string, modifier string) !int {
	for i, prop in cls.properties {
		if prop.name == name && prop.is_property_only {
			return i
		}
	}
	return error('PHP class ${cls.php_name}: ${modifier} modifier targets unknown PHP-only property `${name}`')
}

fn apply_declared_property_modifiers(mut cls repr.PhpClassRepr, attrs []ast.Attr) ! {
	for attr in attrs {
		match attr.name {
			'vphp.PhpDeclaredPropertyVisibility' {
				index := declared_property_index(&cls, attr.args['name'], 'visibility')!
				prop := cls.properties[index]
				cls.properties[index] = repr.PhpClassPropRepr{ ...prop, visibility: attr.args['visibility'] }
			}
			'vphp.PhpFinalDeclaredProperty' {
				index := declared_property_index(&cls, attr.args['name'], 'final')!
				prop := cls.properties[index]
				cls.properties[index] = repr.PhpClassPropRepr{ ...prop, is_final: true }
			}
			else {}
		}
	}
}

pub fn add_class_method(mut cls repr.PhpClassRepr, stmt ast.FnDecl, table &ast.Table, field_types map[string]string, borrowed_methods map[string]bool, method_return_types map[string]string, params_structs map[string]repr.PhpParamsStruct) ! {
	if stmt.is_method {
		if stmt.name == 'free' {
			cls.has_free_method = true
		} else if stmt.name == 'cleanup' {
			cls.has_cleanup_method = true
		} else if stmt.name == 'init_php_state' && stmt.params.len == 1 {
			cls.has_init_php_state_method = true
		} else if stmt.name == 'clone_into' {
			cls.has_clone_into = true
		}
	}
	attrs := parse_callable_attrs(stmt.attrs, 'php_method', stmt.name)
	get_hook := ast.find_attr_arg(stmt.attrs, 'vphp.PhpPropertyGet', 'property')
	set_hook := ast.find_attr_arg(stmt.attrs, 'vphp.PhpPropertySet', 'property')
	mut hook_property := ''
	mut hook_kind := ''
	if get := get_hook {
		hook_property = get
		hook_kind = 'get'
	}
	if set := set_hook {
		if hook_kind != '' {
			return error('PHP property hook ${stmt.name}: declare either get or set')
		}
		hook_property = set
		hook_kind = 'set'
	}
	if hook_kind != '' && (hook_property == '' || attrs.has_php_callable || attrs.has_export) {
		return error('PHP property hook ${stmt.name}: declare a property name and use the generated instance bridge')
	}
	if !attrs.has_php_callable && hook_kind == '' {
		if stmt.attrs.any(it.name == 'vphp.PhpSensitiveParameter') {
			return error('PhpSensitiveParameter requires an exported PHP callable: ${cls.php_name}::${stmt.name}')
		}
		if stmt.attrs.any(it.name == 'vphp.PhpMethodSince') {
			return error('PhpMethodSince requires an exported PHP method: ${cls.php_name}::${stmt.name}')
		}
		if attrs.is_final {
			return error('PhpFinalMethod requires an exported PHP method: ${cls.php_name}::${stmt.name}')
		}
		if attrs.visibility != '' {
			return error('PhpMethodVisibility requires an exported PHP method: ${cls.php_name}::${stmt.name}')
		}
		return
	}
	start_idx := if stmt.is_method { 1 } else { 0 }
	args := build_php_args(stmt.params, stmt.module_name, table, start_idx, stmt.is_variadic, attrs,
		params_structs)
	validate_parameter_attribute_targets(attrs, args, '${cls.php_name}::${attrs.php_name}')!

	ret_type := strip_module(table.type_to_str(stmt.return_type))
	inferred_borrowed := infer_borrowed_object_return(stmt, table, field_types, borrowed_methods,
		method_return_types)
	if compiler_notes_enabled() && !attrs.borrowed_return && inferred_borrowed
		&& normalize_delegated_target_type(ret_type) == cls.name {
		println('  - [Compiler][note] borrowed self-return inferred: ${cls.name}.${stmt.name} -> consider adding @[vphp.PhpBorrowedReturn]')
	}
	mut php_return_type := attrs.php_return_type
	if stmt.is_noreturn && php_return_type == '' {
		php_return_type = 'never'
	}
	cls.methods << repr.PhpMethodRepr{
		hook_property:           hook_property
		hook_kind:               hook_kind
		name:                    attrs.php_name
		v_name:                  stmt.name
		v_c_func:                '${cls.name}_${stmt.name}'
		is_static:               false
		return_spec:             repr.new_return_repr(ret_type, php_return_type)
		borrowed_return:         attrs.borrowed_return || inferred_borrowed
		attributes:              attrs.php_attributes
		visibility:              attrs.exported_method_visibility(stmt.is_pub)
		has_explicit_visibility: attrs.visibility != ''
		args:                    args
		has_export:              attrs.has_export
		is_abstract:             attrs.is_abstract
		is_final:                attrs.is_final
		min_php_version:         method_min_php_version(stmt, cls)!
	}
	delegated_type, delegated_method := infer_delegated_method_ref(stmt, table, field_types)
	cls.methods[cls.methods.len - 1].delegated_target_type = delegated_type
	cls.methods[cls.methods.len - 1].delegated_target_method = delegated_method
}

pub fn add_class_static_method(mut cls repr.PhpClassRepr, stmt ast.FnDecl, table &ast.Table, method_name string, params_structs map[string]repr.PhpParamsStruct) ! {
	if stmt.attrs.any(it.name in ['vphp.PhpPropertyGet', 'vphp.PhpPropertySet']) {
		return error('PHP property hook ${method_name}: requires an instance method')
	}
	attrs := parse_callable_attrs(stmt.attrs, 'php_method', method_name)
	if !attrs.has_php_callable {
		if stmt.attrs.any(it.name == 'vphp.PhpSensitiveParameter') {
			return error('PhpSensitiveParameter requires an exported PHP callable: ${cls.php_name}::${method_name}')
		}
		if stmt.attrs.any(it.name == 'vphp.PhpMethodSince') {
			return error('PhpMethodSince requires an exported PHP method: ${cls.php_name}::${method_name}')
		}
		if attrs.is_final {
			return error('PhpFinalMethod requires an exported PHP method: ${cls.php_name}::${method_name}')
		}
		if attrs.visibility != '' {
			return error('PhpMethodVisibility requires an exported PHP method: ${cls.php_name}::${method_name}')
		}
		return
	}
	args := build_php_args(stmt.params, stmt.module_name, table, 0, stmt.is_variadic, attrs,
		params_structs)
	validate_parameter_attribute_targets(attrs, args, '${cls.php_name}::${attrs.php_name}')!

	ret_type := strip_module(table.type_to_str(stmt.return_type))
	mut php_return_type_static := attrs.php_return_type
	if stmt.is_noreturn && php_return_type_static == '' {
		php_return_type_static = 'never'
	}
	cls.methods << repr.PhpMethodRepr{
		name:                    attrs.php_name
		v_name:                  method_name
		v_c_func:                '${cls.name}_${method_name}'
		is_static:               true
		return_spec:             repr.new_return_repr(ret_type, php_return_type_static)
		borrowed_return:         attrs.borrowed_return
		attributes:              attrs.php_attributes
		visibility:              attrs.exported_method_visibility(stmt.is_pub)
		has_explicit_visibility: attrs.visibility != ''
		args:                    args
		has_export:              attrs.has_export
		is_abstract:             attrs.is_abstract
		is_final:                attrs.is_final
		min_php_version:         method_min_php_version(stmt, cls)!
	}
}

fn method_min_php_version(stmt ast.FnDecl, cls repr.PhpClassRepr) !int {
	version := export_min_php_version(stmt.attrs, 'vphp.PhpMethodSince',
		'PHP method ${cls.php_name}::${stmt.name}')!
	return version
}

pub fn build_method_borrow_profile(stmt ast.FnDecl, table &ast.Table, field_types map[string]string) ?MethodBorrowProfile {
	if !stmt.is_method || stmt.is_static_type_method {
		return none
	}
	receiver_type := normalize_delegated_target_type(table.get_type_name(stmt.receiver.typ))
	if receiver_type == '' {
		return none
	}
	delegated_type, delegated_method := infer_delegated_method_ref(stmt, table, field_types)
	return MethodBorrowProfile{
		receiver_type:           receiver_type
		method_name:             stmt.name
		return_type:             normalize_delegated_target_type(table.type_to_str(stmt.return_type))
		direct_borrowed:         infer_borrowed_object_return(stmt, table, field_types,
			map[string]bool{}, map[string]string{})
		delegated_target_type:   delegated_type
		delegated_target_method: delegated_method
	}
}

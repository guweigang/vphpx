module linker

import os
import compiler.php_types
import compiler.syntax as ast
import compiler.repr

fn strip_module_name(name string) string {
	if name.contains('.') {
		return name.all_after_last('.')
	}
	return name
}

fn check_php_internal_parent(name string, min_php_version int) ! {
	php := os.getenv_opt('VPHP_PHP') or { 'php' }
	lookup_name := php_types.class_lookup_name(name)
	script := r"if (PHP_VERSION_ID < (int) $argv[2]) { exit(0); } $name = $argv[1]; if (!class_exists($name, false)) { exit(1); } exit((new ReflectionClass($name))->isInternal() ? 0 : 2);"
	probe := os.exec([php, '-r', script, '--', lookup_name, min_php_version.str()])
	match probe.exit_code {
		0 {}
		1 { return error('PHP parent class `${lookup_name}` was not found in `${php}`') }
		2 { return error('unsupported userland PHP parent class `${lookup_name}`') }
		else {
			return error('could not inspect PHP parent class `${lookup_name}` with `${php}` (exit ${probe.exit_code}): ${probe.output.trim_space()}')
		}
	}
}

fn has_property_named(props []repr.PhpClassPropRepr, name string) bool {
	return props.any(it.name == name)
}

fn has_method_named(methods []repr.PhpMethodRepr, name string, is_static bool) bool {
	return methods.any(it.php_name().to_lower() == name.to_lower() && it.is_static == is_static)
}

fn is_inherited_object_safe_property_type(v_type string) bool {
	return v_type in ['string', 'int', 'i64', 'bool', 'f64', 'PhpValue', 'vphp.PhpValue']
}

pub fn link_class_shadows(mut elements []repr.PhpRepr, table &ast.Table) ! {
	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr {
			link_class_shadow_statics(mut el, elements, table)
			link_class_shadow_constants(mut el, elements)!
			elements[i] = el
		} else if mut el is repr.PhpInterfaceRepr {
			if source_name := el.constant_source {
				el.constants = resolve_class_constant_source(elements, source_name, 'interface',
					el.php_name)!
			}
			elements[i] = el
		} else if mut el is repr.PhpEnumRepr {
			if source_name := el.constant_source {
				el.constants = resolve_class_constant_source(elements, source_name, 'enum',
					el.php_name)!
			}
			elements[i] = el
		}
	}
}

pub fn link_constant_tables(mut elements []repr.PhpRepr, mut tables map[string]repr.PhpConstantTableRepr) ! {
	for i in 0 .. elements.len {
		mut el := elements[i]
		match mut el {
			repr.PhpClassRepr {
				target := '${el.module_name}.${el.name}'
				if entry := tables[target] {
					if el.shadow_const_name != '' {
						return error('PhpConstantTable for ${target} conflicts with an existing class constant source')
					}
					kind := if el.is_trait { 'trait' } else { 'class' }
					el.constants << class_constants_from_source(elements, entry.source, kind,
						el.php_name)!
					if el.module_name == entry.module_name {
						el.shadow_const_name = '${entry.source.name}.values'
						el.shadow_const_type = entry.value_type
					}
					tables.delete(target)
				}
			}
			repr.PhpInterfaceRepr {
				target := '${el.module_name}.${el.name}'
				if entry := tables[target] {
					if el.constant_source != none {
						return error('PhpConstantTable for ${target} conflicts with PhpInterfaceConstants')
					}
					el.constants = class_constants_from_source(elements, entry.source, 'interface',
						el.php_name)!
					tables.delete(target)
				}
			}
			repr.PhpEnumRepr {
				target := '${el.module_name}.${el.name}'
				if entry := tables[target] {
					if el.constant_source != none {
						return error('PhpConstantTable for ${target} conflicts with PhpEnumConstants')
					}
					el.constants = class_constants_from_source(elements, entry.source, 'enum',
						el.php_name)!
					tables.delete(target)
				}
			}
			else {}
		}
		elements[i] = el
	}
	for target, entry in tables {
		return error('PhpConstantTable `${entry.source.name}` must target an exported PHP type: ${target}')
	}
}

pub fn link_static_tables(mut elements []repr.PhpRepr, mut tables map[string]repr.PhpStaticTableRepr) ! {
	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr && !el.is_trait {
			target := '${el.module_name}.${el.name}'
			if entry := tables[target] {
				if el.shadow_static_name != '' {
					return error('PhpStaticTable for ${target} conflicts with an existing class static source')
				}
				if el.module_name != entry.module_name {
					return error('PhpStaticTable for ${target} must be declared in the class module')
				}
				for prop in entry.properties {
					if has_property_named(el.properties, prop.name) {
						return error('PhpStaticTable for ${target} duplicates PHP property `${prop.name}`')
					}
				}
				el.shadow_static_name = '${entry.name}.values'
				el.shadow_static_type = entry.value_type
				el.properties << entry.properties
				elements[i] = el
				tables.delete(target)
			}
		}
	}
	for target, entry in tables {
		return error('PhpStaticTable `${entry.name}` must target an exported PHP class: ${target}')
	}
}

fn resolve_enum_case_alias(elements []repr.PhpRepr, case_ref repr.PhpEnumCaseRef, owner string) !repr.PhpEnumCaseAlias {
	name := case_ref.v_type.all_after_last('.')
	module_name := if case_ref.v_type.contains('.') {
		case_ref.v_type.all_before_last('.')
	} else {
		case_ref.module_name
	}
	for element in elements {
		if element is repr.PhpEnumRepr && element.name == name
			&& (element.module_name == module_name || element.module_name.all_after_last('.') == module_name) {
			for case_ in element.cases {
				if case_.v_name == case_ref.case_name {
					return repr.PhpEnumCaseAlias{element.php_name, case_.php_name}
				}
			}
			return error('${owner}: unknown case `${case_ref.case_name}` on ${element.php_name}')
		}
	}
	return error('${owner}: `${case_ref.v_type}` must name an exported V enum')
}

fn resolve_class_constant_source(elements []repr.PhpRepr, name string, kind string, php_name string) ![]repr.PhpClassConstRepr {
	source := find_class_constant_source(elements, name) or {
		return error('PHP ${kind} ${php_name}: constant source `${name}` must be a V constant struct')
	}
	return class_constants_from_source(elements, source, kind, php_name)
}

pub fn link_class_embeds(mut elements []repr.PhpRepr) ! {
	mut class_map := map[string]string{}
	for el in elements {
		if el is repr.PhpClassRepr && !el.is_trait {
			class_map[el.name] = el.php_name
			class_map[el.type_ref()] = el.php_name
			class_map['${el.module_name}.${el.name}'] = el.php_name
		}
	}

	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr {
			if el.is_trait {
				elements[i] = el
				continue
			}
			if el.parent != '' || el.embeds_v.len == 0 {
				elements[i] = el
				continue
			}

			mut embedded_php_classes := []string{}
			for embed_name in el.embeds_v {
				if embed_name in class_map {
					embedded_php_classes << class_map[embed_name]
				}
			}

			if embedded_php_classes.len > 1 {
				return error('class `${el.name}` embeds multiple `@[php_class]` structs; please declare `@[php_extends: ...]` explicitly')
			}

			if embedded_php_classes.len == 1 {
				el.parent = embedded_php_classes[0]
			}

			elements[i] = el
		}
	}
}

pub fn link_class_parents(mut elements []repr.PhpRepr) ! {
	mut class_map := map[string]string{}
	mut php_classes := map[string]string{}
	for el in elements {
		if el is repr.PhpClassRepr && !el.is_trait {
			class_map[el.name] = el.php_name
			php_classes[registration_key(el.php_name)] = el.php_name
		}
	}

	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr {
			if el.is_trait || el.parent == '' {
				elements[i] = el
				continue
			}
			parent_name := strip_module_name(el.parent)
			if parent_name in class_map {
				el.parent = class_map[parent_name]
			} else if declared := php_classes[registration_key(el.parent)] {
				el.parent = declared
			} else {
				check_php_internal_parent(el.parent, el.min_php_version) or {
					return error('class `${el.name}`: ${err.msg()}')
				}
				el.direct_internal_parent = true
				el.uses_inherited_object = true
			}
			elements[i] = el
		}
	}

	for {
		mut changed := false
		mut inherited_map := map[string]bool{}
		for el in elements {
			if el is repr.PhpClassRepr && !el.is_trait {
				inherited_map[el.name] = el.uses_inherited_object
				inherited_map[el.php_name] = el.uses_inherited_object
			}
		}
		for i in 0 .. elements.len {
			mut el := elements[i]
			if mut el is repr.PhpClassRepr {
				if el.is_trait || el.parent == '' || el.uses_inherited_object {
					elements[i] = el
					continue
				}
				parent_name := strip_module_name(el.parent)
				if inherited_map[el.parent] or { false } || inherited_map[parent_name] or { false } {
					el.uses_inherited_object = true
					changed = true
				}
				elements[i] = el
			}
		}
		if !changed {
			break
		}
	}
	mut native_receivers := map[string]repr.PhpClassRepr{}
	for el in elements {
		if el is repr.PhpClassRepr && el.uses_inherited_object && !el.is_trait {
			native_receivers[registration_key(el.php_name)] = el
		}
	}
	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr {
			if !el.uses_inherited_object {
				continue
			}
			parent := native_receivers[registration_key(el.parent)] or { continue }
			if el.embeds_v.any(it == parent.type_ref() || it == '${parent.module_name}.${parent.name}'
				|| (it == parent.name && parent.module_name == el.module_name)) {
				el.inherited_receiver_parent = repr.PhpReceiverParent{
					name:        parent.name
					module_name: parent.module_name
				}
				elements[i] = el
			}
		}
	}
}

pub fn link_object_copy_policies(mut elements []repr.PhpRepr) ! {
	mut copies_zend_properties := map[string]bool{}
	mut classes := map[string]repr.PhpClassRepr{}
	for element in elements {
		if element is repr.PhpClassRepr {
			validate_object_copy_policy(element)!
			classes[registration_key(element.php_name)] = element
			if element.copy_zend_properties {
				copies_zend_properties[registration_key(element.php_name)] = true
			}
		}
	}
	for i in 0 .. elements.len {
		mut element := elements[i]
		if mut element is repr.PhpClassRepr {
			if (element.cloneable || element.serializable) && element.parent != '' {
				link_copy_parent_embeds(mut element, classes)!
				elements[i] = element
			}
		}
	}
	if copies_zend_properties.len == 0 {
		return
	}
	// Preserve the root's explicit policy only along paths with no V instance state.
	for {
		mut changed := false
		for i in 0 .. elements.len {
			mut cls := elements[i]
			if mut cls is repr.PhpClassRepr {
				if cls.copy_zend_properties || cls.is_trait || cls.has_v_fields
					|| cls.has_free_method || cls.has_cleanup_method || cls.has_init_php_state_method
					|| !(copies_zend_properties[registration_key(cls.parent)] or { false }) {
					continue
				}
				cls.copy_zend_properties = true
				copies_zend_properties[registration_key(cls.php_name)] = true
				elements[i] = cls
				changed = true
			}
		}
		if !changed {
			break
		}
	}
}

fn validate_object_copy_policy(element repr.PhpClassRepr) ! {
	if !element.cloneable && !element.serializable && !element.copy_zend_properties {
		return
	}
	if element.copy_zend_properties {
		if element.is_trait || element.parent != '' || element.has_v_fields || element.cloneable
			|| element.serializable {
			return error('PhpZendPropertyCopy requires ${element.php_name} to be a root class with no V fields or PhpObjectCopy options')
		}
		return
	}
	if element.is_trait || element.uses_inherited_object {
		return error('class ${element.php_name} must own its V payload to opt into PhpObjectCopy')
	}
	if element.cloneable && !element.has_clone_into {
		return error('cloneable class ${element.php_name} must define clone_into(mut target ${element.name})')
	}
	if element.serializable {
		for name in ['__serialize', '__unserialize'] {
			if !element.methods.any(it.php_name().to_lower() == name && it.visibility == 'public'
				&& !it.is_static && !it.is_abstract) {
				return error('serializable class ${element.php_name} must export a public ${name} method')
			}
			if element.methods.any(it.php_name().to_lower() == name && it.min_php_version != 0) {
				return error('serializable class ${element.php_name} must expose ${name} on every supported PHP version')
			}
		}
	}
}

fn link_copy_parent_embeds(mut element repr.PhpClassRepr, classes map[string]repr.PhpClassRepr) ! {
	mut current := element
	mut visited := map[string]bool{}
	mut properties := map[string]bool{}
	for prop in element.properties {
		properties[prop.name] = true
	}
	for current.parent != '' {
		key := registration_key(current.parent)
		parent := classes[key] or {
			return error('class ${current.php_name} requires a VPHP parent to opt into PhpObjectCopy')
		}
		if visited[key] {
			return error('class ${element.php_name} has a cyclic parent chain')
		}
		visited[key] = true
		if element.cloneable && !parent.cloneable {
			return error('cloneable class ${current.php_name} requires a cloneable VPHP parent')
		}
		if element.serializable && !parent.serializable {
			return error('serializable class ${current.php_name} requires a serializable VPHP parent')
		}
		embed := current.embeds_v[0] or { '' }
		if !((embed == parent.name && current.module_name == parent.module_name)
			|| embed == '${parent.module_name}.${parent.name}'
			|| (embed.contains('.') && embed == parent.type_ref())) {
			return error('class ${current.php_name} must embed its V parent ${parent.name} first to opt into PhpObjectCopy')
		}
		element.copy_parent_embeds << parent.name
		path := element.copy_parent_embeds.join('.')
		for prop in parent.properties {
			if prop.is_static || prop.name in properties {
				continue
			}
			properties[prop.name] = true
			if prop.is_property_only || prop.visibility != 'public' {
				continue
			}
			element.copy_parent_properties << repr.PhpClassPropRepr{
				...prop
				v_field_name: '${path}.${prop.v_field_name}'
			}
		}
		element.has_init_php_state_method = element.has_init_php_state_method
			|| parent.has_init_php_state_method
		element.has_cleanup_method = element.has_cleanup_method || parent.has_cleanup_method
		element.has_free_method = element.has_free_method || parent.has_free_method
		current = parent
	}
}

pub fn validate_inherited_object_classes(elements []repr.PhpRepr) ! {
	for cls in elements {
		if cls is repr.PhpClassRepr && !cls.is_trait && cls.uses_inherited_object {
			for prop in cls.properties {
				if prop.is_property_only || prop.is_static
					|| is_inherited_object_safe_property_type(prop.v_type) {
					continue
				}
				return error('class `${cls.name}` extends a PHP internal object layout via `${cls.parent}` and cannot embed `${prop.v_type}` field `${prop.v_field_name}` in its V struct; keep complex state in PHP properties and access it through property helpers instead')
			}
		}
	}
}

pub fn link_class_traits(mut elements []repr.PhpRepr) ! {
	mut trait_map := map[string]repr.PhpClassRepr{}
	for el in elements {
		if el is repr.PhpClassRepr && el.is_trait {
			trait_map[el.name] = el
			trait_map[el.type_ref()] = el
		}
	}

	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr {
			if el.is_trait || el.embeds_v.len == 0 {
				elements[i] = el
				continue
			}
			for embed_name in el.embeds_v {
				if embed_name !in trait_map {
					continue
				}
				trait_repr := trait_map[embed_name]
				for prop in trait_repr.properties {
					if prop.is_static && !prop.is_property_only {
						continue
					}
					// Match PHP trait resolution: the outer class wins on conflicts.
					if has_property_named(el.properties, prop.name) {
						continue
					}
					el.properties << prop
				}
				for method in trait_repr.methods {
					// Match PHP trait resolution: the consuming class keeps its own method.
					if has_method_named(el.methods, method.php_name(), method.is_static) {
						continue
					}
					if method.is_static {
						// V promotes embedded instance methods, so static calls keep the original type.
						el.methods << repr.PhpMethodRepr{
							...method
							trait_static_receiver: if trait_repr.module_name == el.module_name {
								trait_repr.name
							} else {
								trait_repr.type_ref()
							}
						}
					} else {
						el.methods << method
					}
				}
				for constant in trait_repr.constants {
					if el.constants.any(it.name == constant.name) {
						continue
					}
					el.constants << constant
				}
			}
			elements[i] = el
		}
	}
}

fn link_class_shadow_statics(mut cls repr.PhpClassRepr, elements []repr.PhpRepr, table &ast.Table) {
	if cls.shadow_static_name == '' {
		return
	}
	for el in elements {
		if el is repr.PhpConstRepr && el.name == cls.shadow_static_name {
			cls.shadow_static_type = el.v_type
			if sym := table.find_sym(cls.shadow_static_type) {
				sym_info := sym.info
				if sym_info is ast.Struct {
					for field in sym_info.fields {
						cls.properties << repr.PhpClassPropRepr{
							name:             field.name
							v_field_name:     field.name
							v_type:           table.get_type_name(field.typ)
							visibility:       'public'
							is_static:        true
							is_static_shadow: true
							is_mut:           true
						}
					}
				}
			}
			break
		}
	}
}

fn link_class_shadow_constants(mut cls repr.PhpClassRepr, elements []repr.PhpRepr) ! {
	if cls.shadow_const_name == '' {
		return
	}
	kind := if cls.is_trait { 'trait' } else { 'class' }
	source := find_class_constant_source(elements, cls.shadow_const_name) or {
		if cls.is_native_trait {
			return error('PHP trait ${cls.php_name}: constant source `${cls.shadow_const_name}` must be a V constant struct')
		}
		return
	}
	cls.shadow_const_type = source.v_type
	cls.constants << class_constants_from_source(elements, source, kind, cls.php_name)!
}

fn find_class_constant_source(elements []repr.PhpRepr, name string) ?repr.PhpConstRepr {
	for el in elements {
		if el is repr.PhpConstRepr && el.name == name && el.const_type == 'struct' {
			return el
		}
	}
	return none
}

fn class_constants_from_source(elements []repr.PhpRepr, source repr.PhpConstRepr, kind string, php_name string) ![]repr.PhpClassConstRepr {
	mut constants := []repr.PhpClassConstRepr{cap: source.fields.len}
	mut names := map[string]bool{}
	for field_name, constant in source.fields {
		if constant.name in names {
			return error('PHP ${kind} constant ${php_name}::${constant.name}: duplicate declaration')
		}
		names[constant.name] = true
		alias := if case_ref := constant.enum_case {
			owner := 'PHP ${kind} constant ${php_name}::${constant.name}'
			?repr.PhpEnumCaseAlias(resolve_enum_case_alias(elements, case_ref, owner)!)
		} else {
			none
		}
		constants << repr.PhpClassConstRepr{
			name:            constant.name
			v_field_name:    field_name
			value:           constant.value
			const_type:      constant.const_type
			attributes:      constant.attributes
			visibility:      constant.visibility
			is_final:        constant.is_final
			enum_alias:      alias
			min_php_version: constant.min_php_version
		}
	}
	return constants
}

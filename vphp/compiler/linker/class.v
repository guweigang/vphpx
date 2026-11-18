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

fn check_php_internal_parent(name string) ! {
	php := os.getenv_opt('VPHP_PHP') or { 'php' }
	lookup_name := php_types.class_lookup_name(name)
	script := r"$name = $argv[1] ?? ''; if (!class_exists($name, false)) { exit(1); } exit((new ReflectionClass($name))->isInternal() ? 0 : 2);"
	probe := os.exec([php, '-r', script, '--', lookup_name])
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
	return methods.any(it.name == name && it.is_static == is_static)
}

fn is_inherited_object_safe_property_type(v_type string) bool {
	return v_type in ['string', 'int', 'i64', 'bool', 'f64']
}

pub fn link_class_shadows(mut elements []repr.PhpRepr, table &ast.Table) {
	for i in 0 .. elements.len {
		mut el := elements[i]
		if mut el is repr.PhpClassRepr {
			link_class_shadow_statics(mut el, elements, table)
			link_class_shadow_constants(mut el, elements)
			elements[i] = el
		}
	}
}

pub fn link_class_embeds(mut elements []repr.PhpRepr) ! {
	mut class_map := map[string]string{}
	for el in elements {
		if el is repr.PhpClassRepr && !el.is_trait {
			class_map[el.name] = el.php_name
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
				check_php_internal_parent(el.parent) or {
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
}

pub fn validate_object_copy_policies(elements []repr.PhpRepr) ! {
	for element in elements {
		if element is repr.PhpClassRepr {
			validate_object_copy_policy(element)!
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
	if element.is_trait || element.parent != '' {
		return error('class ${element.php_name} must be a root VPHP class to opt into cloning or serialization with PhpObjectCopy')
	}
	if element.cloneable && !element.has_clone_into {
		return error('cloneable class ${element.php_name} must define clone_into(mut target ${element.name})')
	}
	if element.serializable {
		for name in ['__serialize', '__unserialize'] {
			if !element.methods.any(it.name.to_lower() == name && it.visibility == 'public'
				&& !it.is_static && !it.is_abstract) {
				return error('serializable class ${element.php_name} must export a public ${name} method')
			}
		}
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
					if prop.is_static {
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
					if has_method_named(el.methods, method.name, method.is_static) {
						continue
					}
					el.methods << method
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
							name:         field.name
							v_field_name: field.name
							v_type:       table.get_type_name(field.typ)
							visibility:   'public'
							is_static:    true
							is_mut:       true
						}
					}
				}
			}
			break
		}
	}
}

fn link_class_shadow_constants(mut cls repr.PhpClassRepr, elements []repr.PhpRepr) {
	if cls.shadow_const_name == '' {
		return
	}
	for el in elements {
		if el is repr.PhpConstRepr && el.name == cls.shadow_const_name {
			cls.shadow_const_type = el.v_type
			for f_name, sub_con in el.fields {
				cls.constants << repr.PhpClassConstRepr{
					name:         sub_con.name
					v_field_name: f_name
					value:        sub_con.value
					const_type:   sub_con.const_type
					attributes:   sub_con.attributes
				}
			}
			break
		}
	}
}

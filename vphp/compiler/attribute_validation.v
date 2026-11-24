module compiler

import compiler.builder
import compiler.php_types
import compiler.repr

fn validate_attribute_arguments(elements []repr.PhpRepr) ! {
	for element in elements {
		match element {
			repr.PhpClassRepr {
				name := element.php_name
				validate_type_deprecation_attribute(element.attributes, name, element.is_native_trait)!
				validate_dynamic_properties_attribute(element.attributes, name,
					!element.is_trait && !element.is_php_readonly())!
				if element.is_readonly {
					validate_readonly_class(element)!
				}
				if element.is_native_trait {
					validate_native_trait(element)!
				}
				validate_attributes(element.attributes, name)!
				for constant in element.constants {
					validate_class_constant(constant, '${name}::${constant.name}')!
				}
				for property in element.properties {
					owner := '${name}::${property.name}'
					validate_attributes(property.attributes, owner)!
					validate_property_declaration(element, property, owner)!
				}
				validate_method_attributes(element.methods, name, element.is_native_trait)!
				validate_property_hooks(element)!
			}
			repr.PhpEnumRepr {
				validate_enum_methods(element)!
				validate_type_deprecation_attribute(element.attributes, element.php_name, false)!
				validate_dynamic_properties_attribute(element.attributes, element.php_name, false)!
				validate_attributes(element.attributes, element.php_name)!
				mut constant_names := map[string]bool{}
				for item in element.cases {
					owner := '${element.php_name}::${item.php_name}'
					if !valid_php_class_constant_name(item.php_name) {
						return error('PHP enum case ${owner}: invalid case name')
					}
					if item.php_name in constant_names {
						return error('PHP enum case ${owner}: duplicate declaration')
					}
					constant_names[item.php_name] = true
					validate_attributes(item.attributes, owner)!
				}
				for constant in element.constants {
					owner := '${element.php_name}::${constant.name}'
					if constant.name in constant_names {
						return error('PHP enum constant ${owner}: name already used by a case or constant')
					}
					constant_names[constant.name] = true
					if constant.name.to_lower() == 'class' {
						return error('PHP enum constant ${owner}: class is a reserved constant name')
					}
					if constant.const_type == '' && constant.enum_alias == none {
						return error('PHP enum constant ${owner}: value must be a supported scalar literal or enum case')
					}
					validate_class_constant(constant, owner)!
				}
			}
			repr.PhpInterfaceRepr {
				validate_type_deprecation_attribute(element.attributes, element.php_name, false)!
				validate_dynamic_properties_attribute(element.attributes, element.php_name, false)!
				validate_attributes(element.attributes, element.php_name)!
				for constant in element.constants {
					owner := '${element.php_name}::${constant.name}'
					if constant.visibility != 'public' {
						return error('PHP interface constant ${owner}: visibility must be public')
					}
					if constant.const_type == '' && constant.enum_alias == none {
						return error('PHP interface constant ${owner}: value must be a supported scalar literal or enum case')
					}
					validate_attributes(constant.attributes, owner)!
				}
				validate_method_attributes(element.methods, element.php_name, false)!
				validate_interface_method_declarations(element)!
				validate_interface_property_declarations(element)!
			}
			repr.PhpFuncRepr {
				validate_callable_attributes(element.attributes, element.name, element.return_spec,
					element.uses_context, '')!
				validate_parameter_attributes(element.args, element.name)!
			}
			repr.PhpConstRepr {
				if element.has_php_const && element.const_type != 'struct' {
					validate_attributes(element.attributes, element.name)!
				}
			}
			else {}
		}
	}
	validate_backed_property_redeclarations(elements)!
	validate_member_overrides(elements)!
}

fn validate_type_deprecation_attribute(attrs []repr.PhpAttributeRepr, owner string, is_native_trait bool) ! {
	if !is_native_trait && attrs.any(php_types.is_deprecated_attribute(it.name)) {
		return error('PHP attribute Deprecated on ${owner}: requires an exported native trait')
	}
}

fn validate_interface_method_declarations(iface repr.PhpInterfaceRepr) ! {
	for method in iface.methods {
		owner := 'PHP interface ${iface.php_name}::${method.php_name()}'
		validate_parameter_attributes(method.args, owner)!
		if method.return_spec.php_type != '' {
			builder.validate_interface_signature_type(method.return_spec.php_type, true) or {
				return error('${owner} return type: ${err.msg()}')
			}
		}
		for arg in method.args {
			for attr in arg.attributes {
				if php_types.is_nodiscard_attribute(attr.name) || php_types.is_override_attribute(attr.name) {
					return error('${owner} parameter $${arg.name}: PHP attribute ${attr.name} requires a method target')
				}
			}
			if arg.php_type != '' {
				builder.validate_interface_signature_type(arg.php_type, false) or {
					return error('${owner} parameter $${arg.name}: ${err.msg()}')
				}
			}
		}
	}
}

fn validate_backed_property_redeclarations(elements []repr.PhpRepr) ! {
	mut classes := map[string]repr.PhpClassRepr{}
	for element in elements {
		if element is repr.PhpClassRepr && !element.is_trait {
			classes[php_types.class_lookup_name(element.php_name).to_lower()] = element
		}
	}
	for element in classes.values() {
		if element.parent == '' {
			continue
		}
		for property in element.properties {
			if !is_plain_backed_property(element, property) {
				continue
			}
			declared := builder.resolve_property_type(property.declaration_type(), property.is_property_only).declaration(property.explicit_mixed)
			min_version := element.property_min_php_version(property)
			mut older_than := max_int
			mut parent_key := php_types.class_lookup_name(element.parent).to_lower()
			mut visited := map[string]bool{}
			for parent_key != '' && parent_key !in visited {
				parent := classes[parent_key] or { break }
				visited[parent_key] = true
				parent_key = php_types.class_lookup_name(parent.parent).to_lower()
				matches := parent.properties.filter(it.name == property.name)
				if matches.len != 0 {
					inherited := matches[0]
					parent_min_version := parent.property_min_php_version(inherited)
					if parent_min_version >= older_than {
						continue
					}
					if inherited.visibility != 'private' && is_plain_backed_property(parent, inherited) {
						expected := builder.resolve_property_type(inherited.declaration_type(), inherited.is_property_only).declaration(inherited.explicit_mixed)
						// Zend already handles omission versus mixed during registration.
						if declared.has_type() && expected.has_type() && !declared.equivalent(expected) {
							return error('PHP property ${element.php_name}::$${property.name}: type must match ${parent.php_name}::$${inherited.name} (${inherited.declaration_type()})')
						}
					}
					if parent_min_version <= min_version {
						break
					}
					// Older builds inherit from the next ancestor with this name.
					older_than = parent_min_version
				}
			}
		}
	}
}

fn is_plain_backed_property(owner repr.PhpClassRepr, property repr.PhpClassPropRepr) bool {
	return !property.abstract_get && !property.abstract_set && property.set_visibility == none
		&& !property.is_final && !owner.methods.any(it.hook_property == property.name)
}

fn validate_interface_property_declarations(interface_ repr.PhpInterfaceRepr) ! {
	mut names := map[string]bool{}
	for property in interface_.properties {
		owner := '${interface_.php_name}::$${property.name}'
		validate_property_contract(owner, property.name, property.php_type)!
		if property.name in names {
			return error('PHP interface property ${owner}: already declared')
		}
		names[property.name] = true
	}
}

fn validate_property_contract(owner string, name string, php_type string) ! {
	if name.contains('\\') || !valid_php_export_name(name) {
		return error('PHP property contract ${owner}: invalid property name')
	}
	type_ := builder.resolve_property_type(php_type, true)
	if (!type_.is_typed() && type_.code != 'IS_MIXED')
		|| type_.code in ['IS_CALLABLE', 'IS_RESOURCE', 'IS_VOID', 'IS_NEVER', 'IS_STATIC'] {
		return error('PHP property contract ${owner}: invalid property type ${php_type}')
	}
}

fn validate_property_hooks(class_ repr.PhpClassRepr) ! {
	mut hooks := map[string]bool{}
	for prop in class_.properties {
		if !prop.abstract_get && !prop.abstract_set {
			continue
		}
		owner := '${class_.php_name}::$${prop.name}'
		validate_property_contract(owner, prop.name, prop.php_type)!
		if prop.is_final || prop.visibility == 'private' || class_.is_php_readonly() {
			return error('PHP abstract property ${owner}: cannot be final, private or readonly')
		}
		if prop.abstract_get {
			hooks['${owner}::get'] = true
		}
		if prop.abstract_set {
			hooks['${owner}::set'] = true
		}
	}
	for method in class_.methods {
		if method.hook_kind == '' {
			continue
		}
		owner := '${class_.php_name}::$${method.hook_property}::${method.hook_kind}'
		mut found := false
		for prop in class_.properties {
			if prop.name == method.hook_property {
				found = prop.is_property_only && !prop.is_static && prop.is_mut
				if method.is_final && prop.visibility == 'private' {
					return error('PHP property hook ${owner}: cannot be both final and private')
				}
			}
		}
		if !found || class_.is_trait || class_.is_php_readonly() {
			return error('PHP property hook ${owner}: requires a writable PHP-only instance property declared on a class')
		}
		if owner in hooks {
			return error('PHP property hook ${owner}: is already declared')
		}
		hooks[owner] = true
		if method.is_constructor() || method.is_abstract || method.has_explicit_visibility {
			return error('PHP property hook ${owner}: requires a concrete instance method and uses the property visibility')
		}
		return_type := method.return_spec.effective_v_type()
		if method.hook_kind == 'get' {
			if method.args.len != 0 || return_type in ['', 'void', '!', '!void'] {
				return error('PHP property hook ${owner}: get must take no parameters and return a value')
			}
		} else if return_type !in ['', 'void', '!', '!void'] || method.args.len != 1
			|| method.args.any(it.is_variadic || it.is_optional || it.source.kind != .direct
				|| is_context_v_type(it.v_type) || php_types.is_reference_parameter(it.v_type, false)) {
			return error('PHP property hook ${owner}: set must take one required value and return void')
		}
	}
}

fn validate_dynamic_properties_attribute(attrs []repr.PhpAttributeRepr, owner string, allowed bool) ! {
	count := attrs.filter(it.is_allow_dynamic_properties()).len
	if count > 0 && !allowed {
		return error('PHP type ${owner}: AllowDynamicProperties is not allowed')
	}
	if count > 1 {
		return error('PHP class ${owner}: AllowDynamicProperties must not be repeated')
	}
}

fn validate_readonly_class(class_ repr.PhpClassRepr) ! {
	if class_.is_trait {
		return error('PHP trait ${class_.php_name}: PhpReadonlyClass requires a class export')
	}
	for prop in class_.properties {
		owner := '${class_.php_name}::${prop.name}'
		if prop.is_static {
			return error('PHP readonly class property ${owner}: static properties are not allowed')
		}
		if prop.is_mut && !prop.is_property_only {
			return error('PHP readonly class property ${owner}: exported V fields must be immutable')
		}
		type_ := builder.resolve_property_type(prop.declaration_type(), prop.is_property_only)
		if type_.code in ['IS_CALLABLE', 'IS_RESOURCE', 'IS_VOID', 'IS_NEVER', 'IS_STATIC']
			|| (!type_.is_typed()
				&& !(prop.is_property_only && prop.declaration_type().to_lower() == 'mixed')) {
			return error('PHP readonly class property ${owner}: a valid PHP property type is required')
		}
	}
}

fn validate_native_trait(trait repr.PhpClassRepr) ! {
	name := php_types.class_lookup_name(trait.php_name)
	if !valid_php_export_name(name) {
		return error('invalid exported PHP trait name `${name}`')
	}
	if trait.has_v_fields || trait.shadow_static_name != '' {
		return error('PHP trait ${name}: declare state with PhpDeclaredProperty instead of V fields or statics')
	}
	if trait.parent != '' || trait.implements_attr.len > 0 || trait.implements_v.len > 0
		|| trait.is_abstract || trait.is_final {
		return error('PHP trait ${name}: cannot extend a class, implement interfaces, or be marked abstract or final')
	}
	for method in trait.methods {
		owner := '${name}::${method.php_name()}'
		if method.is_constructor() {
			if method.is_static {
				return error('PHP trait ${owner}: a constructor must be an instance method')
			}
			if method.return_spec.effective_v_type() !in ['', 'void', '!', '!void']
				|| method.return_spec.php_type != '' {
				return error('PHP trait ${owner}: a constructor cannot return a value or declare a PHP return type')
			}
		}
		if method.has_export && !method.is_static && !method.is_abstract {
			return error('PHP trait ${owner}: an instance method must use the generated PHP method bridge')
		}
		if !method.is_abstract
			&& php_types.normalize_export_type_key(method.return_spec.effective_v_type()) == trait.name {
			return error('PHP trait ${owner}: a trait cannot be returned as a VPHP object')
		}
	}
}

fn valid_php_class_constant_name(name string) bool {
	return !name.contains('\\') && name.to_lower() != 'class' && valid_php_export_name(name)
}

fn validate_class_constant(constant repr.PhpClassConstRepr, owner string) ! {
	if !valid_php_class_constant_name(constant.name) {
		return error('PHP class constant ${owner}: invalid constant name')
	}
	if constant.is_final && constant.visibility == 'private' {
		return error('PHP class constant ${owner}: a private constant cannot be final')
	}
	validate_attributes(constant.attributes, owner)!
}

fn validate_property_declaration(class_ repr.PhpClassRepr, prop repr.PhpClassPropRepr, owner string) ! {
	if prop.attributes.filter(php_types.is_override_attribute(it.name)).len > 1 {
		return error('PHP attribute Override on ${owner}: must not be repeated')
	}
	if prop.is_final && prop.visibility == 'private' {
		return error('PHP property ${owner}: property cannot be both final and private')
	}
	if prop.default_error != '' {
		return error('PHP property ${owner} default: ${prop.default_error}')
	}
	type_name := prop.declaration_type()
	property_type := builder.resolve_property_type(type_name, prop.is_property_only)
	if property_type.compound && !property_type.is_typed() {
		return error('PHP property ${owner}: unsupported or invalid compound type ${type_name}')
	}
	if property_type.nullable && !property_type.is_typed() {
		return error('PHP property ${owner}: unsupported nullable type ${type_name}')
	}
	if set_visibility := prop.set_visibility {
		if set_visibility !in ['private', 'protected'] {
			return error('PHP property ${owner}: set visibility must be private or protected')
		}
		if prop.visibility == 'private' && set_visibility == 'protected' {
			return error('PHP property ${owner}: set visibility cannot be wider than read visibility')
		}
		if (!property_type.is_typed() && property_type.code != 'IS_MIXED')
			|| property_type.code in ['IS_CALLABLE', 'IS_RESOURCE', 'IS_VOID', 'IS_NEVER', 'IS_STATIC'] {
			return error('PHP property ${owner}: asymmetric visibility requires a valid PHP property type')
		}
	}
	value := prop.default_value or { return }
	if !prop.is_static && (!prop.is_mut || class_.is_php_readonly())
		&& class_.min_php_version < 80600 && class_.property_min_php_version(prop) < 80600 {
		return error('PHP readonly property ${owner}: default values are not allowed before PHP 8.6; use since: .php86')
	}
	if !property_type.accepts_default(value) {
		return error('PHP property ${owner} default: ${value.kind} does not match type ${type_name}')
	}
}

fn validate_enum_methods(enum_ repr.PhpEnumRepr) ! {
	for method in enum_.methods {
		name := method.php_name().to_lower()
		if method.is_abstract || method.has_export || method.hook_kind != '' {
			return error('PHP enum ${enum_.php_name}::${method.php_name()} requires a concrete generated method')
		}
		if (enum_.backing != .unit && name in ['from', 'tryfrom'])
			|| name in ['cases', '__construct', '__destruct', '__clone', '__get', '__set', '__unset',
				'__isset', '__tostring', '__debuginfo', '__serialize', '__unserialize', '__sleep',
				'__wakeup', '__set_state'] {
			return error('PHP enum ${enum_.php_name} cannot declare method ${method.php_name()}')
		}
	}
	validate_method_attributes(enum_.methods, enum_.php_name, false)!
}

fn validate_method_attributes(methods []repr.PhpMethodRepr, owner string, allow_private_abstract bool) ! {
	for method in methods {
		name := '${owner}::${method.name}'
		if method.is_abstract && method.is_final {
			return error('PHP method ${name}: an abstract method cannot be final')
		}
		if method.hook_kind == '' && method.visibility == 'private' {
			if method.is_abstract && !allow_private_abstract {
				return error('PHP method ${name}: an abstract method cannot be private')
			}
			if method.is_final && !method.is_constructor() {
				return error('PHP method ${name}: only a private constructor can be final')
			}
		}
		validate_callable_attributes(method.attributes, name, method.return_spec,
			method_uses_context_arg(&method) || method.has_export, method.php_name())!
		validate_parameter_attributes(method.args, name)!
	}
}

fn validate_member_overrides(elements []repr.PhpRepr) ! {
	mut classes := map[string]repr.PhpClassRepr{}
	mut interfaces := map[string]repr.PhpInterfaceRepr{}
	mut has_member_constraints := false
	for element in elements {
		if element is repr.PhpClassRepr && !element.is_trait {
			classes[php_types.class_lookup_name(element.php_name).to_lower()] = element
			has_member_constraints = has_member_constraints
				|| element.is_readonly
				|| element.methods.any(it.hook_kind == '' && (it.is_final || it.has_explicit_visibility))
				|| element.constants.any(it.is_final)
		} else if element is repr.PhpInterfaceRepr {
			interfaces[php_types.class_lookup_name(element.php_name).to_lower()] = element
			has_member_constraints = has_member_constraints || element.constants.any(it.is_final)
		}
	}
	if !has_member_constraints {
		return
	}
	for _, interface_ in interfaces {
		validate_interface_constant_overrides(interface_.php_name, interface_.constants.map(it.name),
			interface_.extends, interfaces)!
	}
	for _, element in classes {
		direct_parent_key := php_types.class_lookup_name(element.parent).to_lower()
		if direct_parent := classes[direct_parent_key] {
			if (element.is_readonly || direct_parent.is_readonly)
				&& element.is_php_readonly() != direct_parent.is_php_readonly() {
				return error('PHP class ${element.php_name}: readonly modifier must match parent ${direct_parent.php_name}')
			}
		}
		mut methods := map[string]repr.PhpMethodRepr{}
		for method in element.methods {
			if method.hook_kind == '' {
				methods[method.php_name().to_lower()] = method
			}
		}
		constants := element.constants.map(it.name)
		if !class_uses_inherited_receiver(&element) && '__construct' !in methods {
			methods['__construct'] = repr.PhpMethodRepr{ visibility: 'public' }
		}
		mut contracts := element.internal_implements.clone()
		mut parent_key := direct_parent_key
		mut visited := map[string]bool{}
		mut checked_visibility := map[string]bool{}
		for parent_key != '' && parent_key !in visited {
			parent := classes[parent_key] or { break }
			visited[parent_key] = true
			contracts << parent.internal_implements
			if !class_uses_inherited_receiver(&parent)
				&& !parent.methods.any(it.is_constructor()) {
				checked_visibility['__construct'] = true
			}
			for method in parent.methods {
				if method.hook_kind != '' {
					continue
				}
				name := method.php_name()
				key := name.to_lower()
				child := methods[key] or { continue }
				if method.is_final {
					return error('PHP class ${element.php_name}: cannot override final method ${parent.php_name}::${name}')
				}
				if key !in checked_visibility {
					checked_visibility[key] = true
					if (child.has_explicit_visibility || method.has_explicit_visibility)
						&& (key != '__construct' || method.is_abstract)
						&& method.visibility != 'private'
						&& (child.visibility == 'private'
							|| (method.visibility == 'public' && child.visibility != 'public')) {
						return error('PHP method ${element.php_name}::${name}: access must be ${method.visibility} or wider (as in ${parent.php_name})')
					}
				}
			}
			for constant in parent.constants {
				if constant.is_final && constant.name in constants {
					return error('PHP class ${element.php_name}: cannot override final constant ${parent.php_name}::${constant.name}')
				}
			}
			parent_key = php_types.class_lookup_name(parent.parent).to_lower()
		}
		validate_interface_constant_overrides(element.php_name, constants, contracts, interfaces)!
	}
}

fn validate_interface_constant_overrides(owner string, constants []string, parents []string, interfaces map[string]repr.PhpInterfaceRepr) ! {
	if constants.len == 0 {
		return
	}
	mut pending := parents.clone()
	mut visited := map[string]bool{}
	for pending.len > 0 {
		name := php_types.class_lookup_name(pending.pop()).to_lower()
		if name in visited {
			continue
		}
		visited[name] = true
		parent := interfaces[name] or { continue }
		for constant in parent.constants {
			if constant.is_final && constant.name in constants {
				return error('PHP type ${owner}: cannot override final interface constant ${parent.php_name}::${constant.name}')
			}
		}
		pending << parent.extends
	}
}

fn validate_callable_attributes(attrs []repr.PhpAttributeRepr, owner string, return_spec repr.PhpReturnRepr, manual_return bool, method_name string) ! {
	validate_attributes(attrs, owner)!
	if attrs.any(php_types.is_sensitive_parameter_attribute(it.name)) {
		return error('PHP attribute SensitiveParameter on ${owner}: requires a parameter target')
	}
	override_count := attrs.filter(php_types.is_override_attribute(it.name)).len
	if override_count > 0 {
		if method_name == '' || method_name.to_lower() == '__construct' {
			return error('PHP attribute Override on ${owner}: requires a method other than a constructor')
		}
		if override_count > 1 {
			return error('PHP attribute Override on ${owner}: must not be repeated')
		}
	}
	for attr in attrs {
		if !php_types.is_nodiscard_attribute(attr.name) {
			continue
		}
		if return_spec.php_type.trim_space().to_lower() in ['void', 'never']
			|| (!manual_return && return_spec.effective_v_type() in ['void', 'never'])
			|| method_name.to_lower() in ['__construct', '__destruct', '__clone', '__set', '__unset',
				'__wakeup', '__unserialize'] {
			return error('PHP attribute NoDiscard on ${owner}: requires a callable that returns a value')
		}
		if attr.args.len > 1 || attr.args.any(it.name !in ['', 'message']
			|| it.kind !in ['string', 'null']) {
			return error('PHP attribute NoDiscard on ${owner}: expected at most one string or null message')
		}
	}
}

fn validate_parameter_attributes(args []repr.PhpArgRepr, owner string) ! {
	for arg in args {
		target := '${owner} parameter ${arg.name}'
		validate_attributes(arg.attributes, target)!
		sensitive := arg.attributes.filter(php_types.is_sensitive_parameter_attribute(it.name))
		if sensitive.len > 1 {
			return error('PHP attribute SensitiveParameter on ${target}: must not be repeated')
		}
		if sensitive.len == 1 && sensitive[0].args.len != 0 {
			return error('PHP attribute SensitiveParameter on ${target}: does not accept arguments')
		}
	}
}

fn validate_attributes(attrs []repr.PhpAttributeRepr, owner string) ! {
	if attrs.filter(php_types.is_deprecated_attribute(it.name)).len > 1 {
		return error('PHP attribute Deprecated on ${owner}: must not be repeated')
	}
	for attr in attrs {
		if attr.parse_error != '' {
			return error('PHP attribute ${attr.name} on ${owner}: ${attr.parse_error}')
		}
	}
}

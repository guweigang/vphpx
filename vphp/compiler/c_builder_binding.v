module compiler

import compiler.builder
import compiler.php_types
import compiler.repr

fn (mut c Compiler) link_function_signature_versions(type_versions map[string]int) {
	if type_versions.len == 0 {
		return
	}
	generator := CGenerator{
		class_ce_by_type:      c.class_ce_map()
		class_php_by_type:     c.class_php_map()
		interface_php_by_type: c.interface_php_map()
		table:                 c.table
	}
	for mut element in c.elements {
		if mut element is repr.PhpFuncRepr {
			for name in generator.build_func(element).signature_class_names() {
				version := type_versions[php_types.class_lookup_name(name).to_lower()]
				if version > element.min_php_version {
					element.min_php_version = version
				}
			}
		}
	}
}

fn (g CGenerator) build_func_return_spec(f &repr.PhpFuncRepr) builder.ReturnSpec {
	return_type := f.return_spec.effective_v_type()
	return builder.new_return_spec(return_type, g.signature_return_type(return_type,
		f.return_spec.php_type, f.has_export, f.module_name), g.php_name_for_type(return_type))
}

fn (g CGenerator) build_method_return_spec(php_name string, m &repr.PhpMethodRepr, module_name string) builder.ReturnSpec {
	raw_return_type := m.return_spec.effective_v_type()
	return_type := if php_name == '__construct' || (m.native_trait_alias != ''
		&& is_constructor_method(m.name)) {
		''
	} else {
		raw_return_type
	}
	return builder.new_return_spec(return_type, g.signature_return_type(return_type,
		m.return_spec.php_type, m.has_export, module_name), g.php_name_for_type(return_type))
}

fn (g CGenerator) build_func(f &repr.PhpFuncRepr) builder.FuncBuilder {
	mut args := []builder.ClassMethodArg{}
	for arg in f.args {
		if arg.v_type == 'Context' || arg.v_type == 'vphp.Context' {
			continue
		}
		args << builder.ClassMethodArg{
			name:        arg.name
			type_:       arg.v_type
			php_type:    g.signature_arg_type(arg, f.module_name)
			is_optional: arg.is_optional
			is_variadic: arg.is_variadic
			php_default: arg.php_default
			attributes:  php_attributes_to_builder(arg.attributes)
		}
	}
	spec := g.build_func_return_spec(f)
	mut func_builder := builder.new_func_builder_with_args(f.name, f.symbol(), spec, args,
		f.uses_context)
	func_builder.table = g.table
	func_builder.attributes = php_attributes_to_builder(f.attributes)
	func_builder.min_php_version = f.min_php_version
	return *func_builder
}

fn (g CGenerator) build_global_constant(c &repr.PhpConstRepr) builder.ConstantBuilder {
	mut constant := builder.new_constant_builder(c.name, c.const_type, c.value,
		...php_attributes_to_builder(c.attributes))
	constant.min_php_version = c.min_php_version
	return constant
}

fn class_uses_inherited_receiver(r &repr.PhpClassRepr) bool {
	return r.direct_internal_parent || r.uses_inherited_object
}

fn fallback_constructor(r &repr.PhpClassRepr) ?builder.ClassMethod {
	if r.is_native_trait || class_uses_inherited_receiver(r) {
		return none
	}
	mut until := 0
	for method in r.methods {
		if !method.is_constructor() {
			continue
		}
		if method.min_php_version == 0 {
			return none
		}
		if until == 0 || method.min_php_version < until {
			until = method.min_php_version
		}
	}
	c_name := r.c_name()
	return builder.ClassMethod{
		php_name:                  '__construct'
		c_func:                    '${c_name.to_lower()}___construct'
		return_spec:               builder.new_return_spec('', '', '')
		flags:                     'ZEND_ACC_PUBLIC'
		handler_symbol:            if until == 0 { '' } else { '${c_name}_vphp_default_construct' }
		max_php_version_exclusive: until
	}
}

fn class_needs_inherited_object_wrapper(r &repr.PhpClassRepr, has_init bool) bool {
	if !class_uses_inherited_receiver(r) {
		return false
	}
	if has_init || r.has_free_method {
		return true
	}
	for prop in r.properties {
		if prop.is_static || prop.is_property_only {
			continue
		}
		return true
	}
	return false
}

fn visibility_to_method_flags(visibility string) string {
	return match visibility {
		'protected' { 'ZEND_ACC_PROTECTED' }
		'private' { 'ZEND_ACC_PRIVATE' }
		else { 'ZEND_ACC_PUBLIC' }
	}
}

fn visibility_to_property_flags(prop repr.PhpClassPropRepr, readonly_class bool) string {
	mut flags := visibility_to_method_flags(prop.visibility)
	if prop.is_static {
		flags += ' | ZEND_ACC_STATIC'
	}
	if !prop.is_static && (!prop.is_mut || readonly_class) {
		flags += ' | ZEND_ACC_READONLY'
	}
	set_visibility := prop.set_visibility or { '' }
	if set_visibility != '' && set_visibility != prop.visibility {
		flags += if set_visibility == 'private' {
			' | ZEND_ACC_PRIVATE_SET'
		} else {
			' | ZEND_ACC_PROTECTED_SET'
		}
	}
	if prop.is_final || (set_visibility == 'private' && prop.visibility != 'private') {
		flags += ' | ZEND_ACC_FINAL'
	}
	return flags
}

fn (g CGenerator) method_args_to_builder(args []repr.PhpArgRepr, module_name string) []builder.ClassMethodArg {
	mut out := []builder.ClassMethodArg{}
	for arg in args {
		if is_context_v_type(arg.v_type) {
			continue
		}
		out << builder.ClassMethodArg{
			name:        arg.name
			type_:       arg.v_type
			php_type:    g.signature_arg_type(arg, module_name)
			is_optional: arg.is_optional
			is_variadic: arg.is_variadic
			php_default: arg.php_default
			attributes:  php_attributes_to_builder(arg.attributes)
		}
	}
	return out
}

fn (g CGenerator) build_method_signature(owner &repr.PhpClassRepr, method &repr.PhpMethodRepr) builder.ClassMethod {
	name := method.php_name()
	return builder.ClassMethod{
		php_name:          name
		trait_method_name: if method.native_trait_alias != '' && !method.is_abstract {
			php_method_name(method.name)
		} else {
			''
		}
		return_spec:       g.build_method_return_spec(name, method, owner.module_name)
		args:              g.method_args_to_builder(method.args, owner.module_name)
		uses_context:      class_method_uses_context_arg(owner, method)
	}
}

fn is_context_v_type(v_type string) bool {
	return v_type == 'Context' || v_type == 'vphp.Context'
}

fn method_uses_context_arg(m &repr.PhpMethodRepr) bool {
	// Attributes, defaults and references need typed arginfo even with a hidden Context.
	if php_types.is_reference_return(m.return_spec.effective_v_type())
		|| m.args.any(it.attributes.len > 0)
		|| (!m.has_export && (m.return_spec.php_type.contains('&') || m.args.any(it.use_php_default
			|| it.php_type.contains('&') || php_types.is_reference_parameter(it.v_type, it.is_variadic)))) {
		return false
	}
	for arg in m.args {
		if is_context_v_type(arg.v_type) {
			return true
		}
	}
	return false
}

fn class_method_uses_context_arg(owner &repr.PhpClassRepr, method &repr.PhpMethodRepr) bool {
	return !((owner.is_native_trait || method.native_trait_source != '')
		&& (method.is_constructor() || is_constructor_method(method.name)))
		&& method_uses_context_arg(method)
}

fn (g CGenerator) interface_method_args_to_builder(args []repr.PhpArgRepr, module_name string) []builder.ClassMethodArg {
	mut out := []builder.ClassMethodArg{}
	for arg in args {
		v_type := if arg.is_variadic { arg.v_type.trim_string_left('[]') } else { arg.v_type }
		php_type := if arg.php_type != '' {
			arg.php_type
		} else {
			g.named_interface_signature(v_type, module_name) or { g.signature_arg_type(arg, module_name) }
		}
		out << builder.ClassMethodArg{
			name:        arg.name
			type_:       arg.v_type
			php_type:    php_type
			is_optional: arg.is_optional
			is_variadic: arg.is_variadic
			php_default: arg.php_default
			attributes:  php_attributes_to_builder(arg.attributes)
		}
	}
	return out
}

fn php_attributes_to_builder(attrs []repr.PhpAttributeRepr) []builder.ClassAttribute {
	mut out := []builder.ClassAttribute{}
	for attr in attrs {
		out << builder.ClassAttribute{
			name: attr.name
			args: attr.args.map(builder.ClassAttributeArg(it))
		}
	}
	return out
}

fn (g CGenerator) build_interface_type(r &repr.PhpInterfaceRepr) &builder.ClassBuilder {
	mut class_builder := builder.new_interface_builder(r.php_name, r.c_name())
	class_builder.min_php_version = r.min_php_version
	class_builder.table = g.table
	class_builder.attributes = php_attributes_to_builder(r.attributes)
	for iface in r.extends {
		class_builder.add_interface(iface)
	}
	add_class_constants(mut class_builder, r.constants)
	for property in r.properties {
		class_builder.add_property(builder.ClassProperty{
			name:            property.name
			type_:           property.php_type
			flags:           'ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT | ZEND_ACC_VIRTUAL'
			property_only:   true
			min_php_version: property.min_php_version
		})
		add_abstract_property_hooks(mut class_builder, property.name, property.has_get,
			property.has_set, property.get_by_reference)
	}
	for m in r.methods {
		c_func := if m.v_c_func != '' {
			m.v_c_func.to_lower()
		} else {
			'${r.c_name().to_lower()}_${m.v_name}'
		}
		php_name := m.php_name()
		spec := if !m.is_constructor() && m.return_spec.php_type == '' {
			v_type := m.return_spec.effective_v_type()
			if php_type := g.named_interface_signature(v_type, r.module_name) {
				builder.new_return_spec(v_type, php_type, '')
			} else {
				g.build_method_return_spec(php_name, m, r.module_name)
			}
		} else {
			g.build_method_return_spec(php_name, m, r.module_name)
		}
		mut flags := visibility_to_method_flags(m.visibility) + ' | ZEND_ACC_ABSTRACT'
		if m.is_static {
			flags += ' | ZEND_ACC_STATIC'
		}
		class_builder.methods << builder.ClassMethod{
			php_name:        php_name
			c_func:          c_func
			return_spec:     spec
			flags:           flags
			is_abstract:     true
			args:            g.interface_method_args_to_builder(m.args, r.module_name)
			attributes:      php_attributes_to_builder(m.attributes)
			min_php_version: m.min_php_version
		}
	}
	return class_builder
}

fn add_abstract_property_hooks(mut class_builder builder.ClassBuilder, property string, has_get bool, has_set bool, get_by_reference bool) {
	for kind in ['get', 'set'] {
		if (kind == 'get' && has_get) || (kind == 'set' && has_set) {
			class_builder.methods << builder.ClassMethod{
				hook_property:     property
				hook_kind:         kind
				is_abstract:       true
				returns_reference: kind == 'get' && get_by_reference
			}
		}
	}
}

fn (g CGenerator) build_enum_type(r &repr.PhpEnumRepr) &builder.ClassBuilder {
	mut class_builder := builder.new_enum_builder(r.php_name, r.c_name())
	class_builder.min_php_version = r.min_php_version
	class_builder.set_v_name(r.name)
	class_builder.enum_backing = r.backing
	if r.backing == .integer && r.cases.len > 0 {
		class_builder.enum_backing_values = r.backing_values_function()
		class_builder.enum_unsigned_backing = r.unsigned_backing
	}
	class_builder.table = g.table
	class_builder.attributes = php_attributes_to_builder(r.attributes)
	for case_ in r.cases {
		class_builder.add_enum_case(case_.php_name, case_.value,
			...php_attributes_to_builder(case_.attributes))
	}
	add_class_constants(mut class_builder, r.constants)
	for iface in r.interfaces {
		class_builder.add_interface(iface)
	}
	owner := r.method_owner()
	g.add_type_methods(mut class_builder, &owner)
	return class_builder
}

fn (g CGenerator) build_class_type(r &repr.PhpClassRepr, has_init bool) &builder.ClassBuilder {
	mut class_builder := builder.new_class_builder(r.php_name, r.c_name())
	class_builder.table = g.table
	class_builder.min_php_version = r.min_php_version
	if r.min_php_version > 0 {
		class_builder.auto_interfaces = r.auto_interface_bindings
	}
	if r.is_native_trait {
		class_builder.type = .trait_
		class_builder.native_trait_uses = r.native_trait_uses
		class_builder.native_trait_aliases = r.native_trait_aliases
	}
	needs_inherited_wrapper := class_needs_inherited_object_wrapper(r, has_init)
	class_builder.set_parent(r.parent)
	class_builder.requires_internal_parent = r.direct_internal_parent && r.min_php_version > 0
	class_builder.set_uses_inherited_object(needs_inherited_wrapper)
	if class_uses_inherited_receiver(r) && inherited_receiver_fields(r.properties).len > 0 {
		class_builder.inherited_field_initializer = '${to_snake_case(r.name)}_init_inherited_fields'
	}
	if r.is_native_trait || class_uses_inherited_receiver(r) {
		class_builder.set_create_object(false)
	} else if !r.serializable && !r.copy_zend_properties {
		class_builder.add_class_flag('ZEND_ACC_NOT_SERIALIZABLE')
	}
	if r.cloneable {
		class_builder.clone_handler_prefix = to_snake_case(r.name)
	}
	if r.copy_parent_embeds.len > 0 {
		class_builder.instance_handler_prefix = to_snake_case(r.name)
	}
	class_builder.clone_zend_properties = r.copy_zend_properties
	if r.is_final {
		class_builder.add_class_flag('ZEND_ACC_FINAL')
	}
	if r.is_abstract {
		class_builder.add_class_flag('ZEND_ACC_EXPLICIT_ABSTRACT_CLASS')
	}
	if r.is_php_readonly() {
		class_builder.add_class_flag('ZEND_ACC_READONLY_CLASS')
	}
	if r.is_readonly {
		class_builder.add_class_flag('ZEND_ACC_NO_DYNAMIC_PROPERTIES')
	}
	if r.attributes.any(it.is_allow_dynamic_properties()) {
		class_builder.add_class_flag('ZEND_ACC_ALLOW_DYNAMIC_PROPERTIES')
	}
	for iface in r.internal_implements {
		class_builder.add_interface(iface)
	}
	add_class_constants(mut class_builder, r.constants)
	for prop in r.properties {
		abstract_property := prop.abstract_get || prop.abstract_set
		flags := visibility_to_property_flags(prop, r.is_readonly)
		class_builder.add_property(builder.ClassProperty{
			name:                    prop.name
			type_:                   prop.declaration_type()
			flags:                   if abstract_property {
				flags + ' | ZEND_ACC_ABSTRACT'
			} else {
				flags
			}
			attributes:              php_attributes_to_builder(prop.attributes)
			default_value:           prop.default_value
			property_only:           prop.is_property_only
			explicit_mixed:          prop.explicit_mixed || abstract_property
				|| (class_uses_inherited_receiver(r) && !prop.is_mut
					&& is_inherited_php_value(prop.v_type))
			is_static:               prop.is_static
			is_static_shadow:        prop.is_static_shadow
			is_final:                prop.is_final
			has_set_visibility:      prop.set_visibility != none
			explicit_readonly_class: r.is_readonly
			min_php_version:         r.property_min_php_version(prop)
		})
		add_abstract_property_hooks(mut class_builder, prop.name, prop.abstract_get,
			prop.abstract_set, prop.abstract_get_by_reference)
	}
	if constructor := fallback_constructor(r) {
		class_builder.methods << constructor
	}
	g.add_type_methods(mut class_builder, r)
	for attr in php_attributes_to_builder(r.attributes) {
		class_builder.add_attribute(attr.name, attr.args)
	}
	return class_builder
}

fn (g CGenerator) add_type_methods(mut class_builder builder.ClassBuilder, r &repr.PhpClassRepr) {
	for m in r.methods {
		php_name := m.php_name()
		mut flags := visibility_to_method_flags(m.visibility)
		if m.is_static {
			flags += ' | ZEND_ACC_STATIC'
		}
		if m.is_final {
			flags += ' | ZEND_ACC_FINAL'
		} else if m.is_trait_final {
			flags += ' | VPHP_ACC_TRAIT_FINAL'
		}
		// Each PHP type needs its own arginfo when a V method is composed into multiple types.
		c_func := '${r.c_name().to_lower()}_${php_name.to_lower()}'
		signature := g.build_method_signature(r, &m)
		attributes := php_attributes_to_builder(m.attributes)
		if m.is_abstract {
			class_builder.add_abstract_method_spec_with_context(php_name, c_func, signature.return_spec,
				flags + ' | ZEND_ACC_ABSTRACT', signature.args, signature.uses_context, ...attributes)
		} else {
			class_builder.add_method_spec_with_context(php_name, c_func, signature.return_spec,
				flags, signature.args, signature.uses_context, ...attributes)
		}
		if m.min_php_version != 0 || m.max_php_version_exclusive != 0 {
			index := class_builder.methods.len - 1
			class_builder.methods[index] = builder.ClassMethod{
				...class_builder.methods[index]
				min_php_version:           m.min_php_version
				max_php_version_exclusive: m.max_php_version_exclusive
			}
		}
		if m.hook_kind != '' {
			index := class_builder.methods.len - 1
			class_builder.methods[index] = builder.ClassMethod{
				...class_builder.methods[index]
				hook_property:     m.hook_property
				hook_kind:         m.hook_kind
				returns_reference: m.property_hook_returns_reference()
			}
		}
		if m.native_trait_source != '' && !m.is_abstract {
			index := class_builder.methods.len - 1
			class_builder.methods[index] = builder.ClassMethod{
				...class_builder.methods[index]
				handler_symbol:    m.handler_symbol(r.c_name())
				trait_method_name: signature.trait_method_name
			}
		}
	}
}

fn add_class_constants(mut class_builder builder.ClassBuilder, constants []repr.PhpClassConstRepr) {
	for constant in constants {
		mut flags := visibility_to_method_flags(constant.visibility)
		if constant.is_final {
			flags += ' | ZEND_ACC_FINAL'
		}
		class_builder.add_constant_spec(builder.ClassConstant{
			name:                      constant.name
			type_:                     constant.const_type
			value:                     constant.value
			attributes:                php_attributes_to_builder(constant.attributes)
			flags:                     flags
			enum_alias:                constant.enum_alias
			min_php_version:           constant.min_php_version
			max_php_version_exclusive: constant.max_php_version_exclusive
		})
	}
}

module builder

import compiler.syntax as ast
import compiler.php_types
import compiler.repr

pub enum ClassType {
	class_
	interface_
	enum_
	trait_
}

pub struct ClassProperty {
pub:
	name                    string
	type_                   string
	flags                   string
	attributes              []ClassAttribute
	default_value           ?repr.PhpAttributeArg
	property_only           bool
	explicit_mixed          bool
	explicit_readonly_class bool
	is_static               bool
	is_static_shadow        bool
	is_final                bool
	has_set_visibility      bool
	min_php_version         int
}

pub struct ClassConstant {
pub:
	name                      string
	type_                     string
	value                     string
	attributes                []ClassAttribute
	flags                     string = 'ZEND_ACC_PUBLIC'
	enum_alias                ?repr.PhpEnumCaseAlias
	min_php_version           int
	max_php_version_exclusive int
}

struct ClassEnumCase {
	name       string
	value      string
	attributes []ClassAttribute
}

pub struct ClassMethod {
pub:
	hook_property             string
	hook_kind                 string
	returns_reference         bool
	php_name                  string
	c_func                    string
	return_spec               ReturnSpec
	flags                     string
	is_abstract               bool
	uses_context              bool
	args                      []ClassMethodArg
	attributes                []ClassAttribute
	handler_symbol            string
	trait_method_name         string
	min_php_version           int
	max_php_version_exclusive int
}

fn (m ClassMethod) for_php_version(lines []string) []string {
	return for_php_version_range(m.min_php_version, m.max_php_version_exclusive, lines)
}

fn for_php_version(min_php_version int, lines []string) []string {
	return for_php_version_range(min_php_version, 0, lines)
}

pub fn for_php_version_range(min_version int, end_version int, lines []string) []string {
	if lines.len == 0 || (min_version == 0 && end_version == 0) {
		return lines
	}
	mut conditions := []string{}
	if min_version > 0 {
		conditions << 'PHP_VERSION_ID >= ${min_version}'
	}
	if end_version > 0 {
		conditions << 'PHP_VERSION_ID < ${end_version}'
	}
	return ['#if ${conditions.join(' && ')}', ...lines, '#endif']
}

pub struct ClassMethodArg {
pub:
	name        string
	type_       string
	php_type    string
	is_optional bool
	is_variadic bool
	php_default string
	attributes  []ClassAttribute
}

pub type ClassAttributeArg = repr.PhpAttributeArg

pub struct ClassAttribute {
pub:
	name string
	args []ClassAttributeArg
}

@[heap]
pub struct ClassBuilder {
pub mut:
	type                        ClassType = .class_
	php_name                    string
	c_name                      string
	parent                      string
	requires_internal_parent    bool
	min_php_version             int
	auto_interfaces             []string
	create_object               bool = true
	clone_handler_prefix        string
	instance_handler_prefix     string
	clone_zend_properties       bool
	uses_inherited_object       bool
	inherited_field_initializer string
	class_flags                 []string
	interfaces                  []string
	native_trait_uses           []string
	native_trait_aliases        []repr.PhpTraitAlias
	properties                  []ClassProperty
	constants                   []ClassConstant
	methods                     []ClassMethod
	attributes                  []ClassAttribute
	table                       &ast.Table = unsafe { nil } // SAFETY: nil literal in unsafe context
	v_name                      string
	enum_backing                repr.PhpEnumBacking
	enum_backing_values         string
	enum_unsigned_backing       bool
mut:
	enum_cases []ClassEnumCase
}

fn new_builder(type_ ClassType, php_name string, c_name string) &ClassBuilder {
	return &ClassBuilder{
		type:     type_
		php_name: php_name
		c_name:   c_name
	}
}

pub fn new_class_builder(php_name string, c_name string) &ClassBuilder {
	return new_builder(.class_, php_name, c_name)
}

pub fn new_interface_builder(php_name string, c_name string) &ClassBuilder {
	mut b := new_builder(.interface_, php_name, c_name)
	b.create_object = false
	return b
}

pub fn new_enum_builder(php_name string, c_name string) &ClassBuilder {
	mut b := new_builder(.enum_, php_name, c_name)
	b.create_object = false
	return b
}

pub fn (mut b ClassBuilder) set_v_name(v_name string) &ClassBuilder {
	b.v_name = v_name
	return b
}

pub fn (mut b ClassBuilder) set_parent(parent_name string) &ClassBuilder {
	b.parent = parent_name
	return b
}

pub fn (mut b ClassBuilder) set_uses_inherited_object(enabled bool) &ClassBuilder {
	b.uses_inherited_object = enabled
	return b
}

pub fn (mut b ClassBuilder) set_create_object(enabled bool) &ClassBuilder {
	b.create_object = enabled
	return b
}

pub fn (mut b ClassBuilder) add_class_flag(flag string) &ClassBuilder {
	b.class_flags << flag
	return b
}

pub fn (mut b ClassBuilder) add_interface(interface_name string) &ClassBuilder {
	b.interfaces << interface_name
	return b
}

pub fn (mut b ClassBuilder) add_property(property ClassProperty) &ClassBuilder {
	b.properties << property
	return b
}

pub fn (mut b ClassBuilder) add_enum_case(name string, value string, attributes ...ClassAttribute) {
	b.enum_cases << ClassEnumCase{
		name:       name
		value:      value
		attributes: attributes
	}
}

pub fn (mut b ClassBuilder) add_constant_spec(constant ClassConstant) &ClassBuilder {
	b.constants << constant
	return b
}

pub fn (mut b ClassBuilder) add_method(php_name string, c_func string, return_type string, php_return_type string, flags string, args []ClassMethodArg) &ClassBuilder {
	return b.add_method_spec(php_name, c_func, new_return_spec(return_type, php_return_type, ''),
		flags, args)
}

pub fn (mut b ClassBuilder) add_method_with_return_obj(php_name string, c_func string, return_type string, php_return_type string, return_obj_type string, flags string, args []ClassMethodArg) &ClassBuilder {
	return b.add_method_spec(php_name, c_func, new_return_spec(return_type, php_return_type,
		return_obj_type), flags, args)
}

pub fn (mut b ClassBuilder) add_method_spec(php_name string, c_func string, return_spec ReturnSpec, flags string, args []ClassMethodArg) &ClassBuilder {
	return b.add_method_spec_with_context(php_name, c_func, return_spec, flags, args, false)
}

pub fn (mut b ClassBuilder) add_method_spec_with_context(php_name string, c_func string, return_spec ReturnSpec, flags string, args []ClassMethodArg, uses_context bool, attributes ...ClassAttribute) &ClassBuilder {
	b.methods << ClassMethod{
		php_name:     php_name
		c_func:       c_func
		return_spec:  return_spec
		flags:        flags
		is_abstract:  false
		uses_context: uses_context
		args:         args
		attributes:   attributes
	}
	return b
}

pub fn (mut b ClassBuilder) add_attribute(name string, args []ClassAttributeArg) &ClassBuilder {
	b.attributes << ClassAttribute{
		name: name
		args: args
	}
	return b
}

pub fn (mut b ClassBuilder) add_abstract_method(php_name string, c_func string, return_type string, php_return_type string, flags string, args []ClassMethodArg) &ClassBuilder {
	return b.add_abstract_method_spec(php_name, c_func, new_return_spec(return_type,
		php_return_type, ''), flags, args)
}

pub fn (mut b ClassBuilder) add_abstract_method_with_return_obj(php_name string, c_func string, return_type string, php_return_type string, return_obj_type string, flags string, args []ClassMethodArg) &ClassBuilder {
	return b.add_abstract_method_spec(php_name, c_func, new_return_spec(return_type,
		php_return_type, return_obj_type), flags, args)
}

pub fn (mut b ClassBuilder) add_abstract_method_spec(php_name string, c_func string, return_spec ReturnSpec, flags string, args []ClassMethodArg) &ClassBuilder {
	return b.add_abstract_method_spec_with_context(php_name, c_func, return_spec, flags, args,
		false)
}

pub fn (mut b ClassBuilder) add_abstract_method_spec_with_context(php_name string, c_func string, return_spec ReturnSpec, flags string, args []ClassMethodArg, uses_context bool, attributes ...ClassAttribute) &ClassBuilder {
	b.methods << ClassMethod{
		php_name:     php_name
		c_func:       c_func
		return_spec:  return_spec
		flags:        flags
		is_abstract:  true
		uses_context: uses_context
		args:         args
		attributes:   attributes
	}
	return b
}

pub fn (b &ClassBuilder) ce_var_name() string {
	return '${b.c_name.to_lower()}_ce'
}

pub fn (b &ClassBuilder) render_ce_declaration() string {
	return 'zend_class_entry *${b.ce_var_name()} = NULL;'
}

pub fn (b &ClassBuilder) render_ce_extern_declaration() string {
	return 'extern zend_class_entry *${b.ce_var_name()};'
}

fn (b &ClassBuilder) registration_func_name() string {
	return '${b.c_name.to_lower()}_register_class'
}

fn (b &ClassBuilder) render_registration_function() string {
	mut res := []string{}
	lower_name := b.c_name.to_lower()
	ce_ptr := b.ce_var_name()
	self_name := c_string_escape(php_types.normalize_php_type_literal(b.php_name))
	register_constants_before_inheritance := b.type == .class_ && b.parent != ''
		&& b.constants.len > 0
	mut compound_setup := []string{}
	mut legacy_compound_methods := []ClassMethod{}
	for method in b.methods {
		setup := method.compound_arginfo_setup(b.table)
		compound_setup << method.for_php_version(setup)
		if method.min_php_version == 0 && setup.len > 0 {
			legacy_compound_methods << method
		}
	}

	res << 'static int ${b.registration_func_name()}(void) {'
	res << '    if (${ce_ptr} != NULL) {'
	res << '        return SUCCESS;'
	res << '    }'
	res << '    ${ce_ptr} = vphp_find_loaded_class_entry("${self_name}", sizeof("${self_name}")-1);'
	res << '    if (${ce_ptr} != NULL) {'
	res << '        return SUCCESS;'
	res << '    }'

	res << '    {'
	if compound_setup.len > 0 {
		res << '#if PHP_VERSION_ID >= 80300'
		res << compound_setup.map('        ' + it)
		res << '#endif'
	}
	match b.type {
		.enum_ {
			methods := if b.methods.len == 0 { 'NULL' } else { '${lower_name}_methods' }
			backing_type := match b.enum_backing {
				.integer { 'IS_LONG' }
				.string_ { 'IS_STRING' }
				.unit { 'IS_UNDEF' }
			}
			res << '        ${ce_ptr} = zend_register_internal_enum("${self_name}", ${backing_type}, ${methods});'
		}
		else {
			res << '        zend_class_entry ce;'
			res << '        INIT_CLASS_ENTRY(ce, "${b.php_name}", ${lower_name}_methods);'
			if b.type == .trait_ {
				res << '        ce.ce_flags |= ZEND_ACC_TRAIT;'
			}

			match b.type {
				.interface_ {
					res << '        ${ce_ptr} = zend_register_internal_interface(&ce);'
				}
				else {
					has_abstract_static := b.methods.any(it.is_abstract
						&& it.flags.contains('ZEND_ACC_STATIC'))
					if b.parent != '' {
						parent_name := c_string_escape(php_types.class_lookup_name(b.parent))
						res << '        zend_class_entry *parent_ce = vphp_require_class_entry("${parent_name}", sizeof("${parent_name}")-1, 0);'
						res << '        if (!parent_ce) {'
						res << '            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "${self_name}", "${parent_name}");'
						res << '            return FAILURE;'
						res << '        }'
						if b.requires_internal_parent {
							res << '        if (parent_ce->type != ZEND_INTERNAL_CLASS) {'
							res << '            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s must be internal", "${self_name}", "${parent_name}");'
							res << '            return FAILURE;'
							res << '        }'
						}
						res << '        vphp_verify_parent_reference_methods(&ce, parent_ce);'
						if register_constants_before_inheritance {
							registration := if has_abstract_static {
								'vphp_register_class_with_abstract_statics(&ce, NULL)'
							} else {
								'zend_register_internal_class(&ce)'
							}
							res << '        ${ce_ptr} = ${registration};'
						} else {
							register := if has_abstract_static {
								'vphp_register_class_with_abstract_statics'
							} else {
								'zend_register_internal_class_ex'
							}
							if legacy_compound_methods.len > 0 {
								res << '#if PHP_VERSION_ID < 80300'
								res << '        ${ce_ptr} = ${register}(&ce, NULL);'
								res << '#else'
							}
							res << '        ${ce_ptr} = ${register}(&ce, parent_ce);'
							if legacy_compound_methods.len > 0 {
								res << '#endif'
							}
						}
					} else if has_abstract_static {
						res << '        ${ce_ptr} = vphp_register_class_with_abstract_statics(&ce, NULL);'
					} else {
						res << '        ${ce_ptr} = zend_register_internal_class(&ce);'
					}
				}
			}
		}
	}

	if legacy_compound_methods.len > 0 {
		res << '#if PHP_VERSION_ID < 80300'
		for method in legacy_compound_methods {
			res << registered_compound_arginfo_setup(method.php_name, '&${ce_ptr}->function_table',
				method.return_spec, if method.uses_context { [] } else { method.args },
				b.table).map('        ' + it)
		}
		res << '#endif'
	}

	enum_value_type := if b.enum_unsigned_backing { 'uint64_t' } else { 'int64_t' }
	if b.enum_backing_values != '' {
		res << '        ${enum_value_type} backing_values[${b.enum_cases.len}];'
		res << '        ${b.enum_backing_values}(backing_values);'
	}
	for i, case_ in b.enum_cases {
		name := c_string_literal_bytes(case_.name)
		match b.enum_backing {
			.unit {
				res << '        zend_enum_add_case_cstr(${ce_ptr}, "${name}", NULL);'
			}
			.integer {
				res << '        {'
				res << '            ${enum_value_type} value = backing_values[${i}];'
				out_of_range := if b.enum_unsigned_backing {
					'value > ZEND_LONG_MAX'
				} else {
					'value < ZEND_LONG_MIN || value > ZEND_LONG_MAX'
				}
				res << '            if (${out_of_range}) {'
				res << '                zend_error(E_WARNING, "PHP enum ${self_name}::${name} has a backing value outside the PHP integer range");'
				res << '                return FAILURE;'
				res << '            }'
				res << '            if (zend_hash_index_exists(${ce_ptr}->backed_enum_table, (zend_ulong)value)) {'
				res << '                zend_error(E_WARNING, "PHP enum ${self_name}::${name} duplicates an integer backing value");'
				res << '                return FAILURE;'
				res << '            }'
				res << '            zval backing_value;'
				res << '            ZVAL_LONG(&backing_value, (zend_long)value);'
				res << '            zend_enum_add_case_cstr(${ce_ptr}, "${name}", &backing_value);'
				res << '        }'
			}
			.string_ {
				literal := c_string_literal_bytes(case_.value)
				res << '        { zval _ev; ZVAL_STR(&_ev, zend_string_init("${literal}", sizeof("${literal}")-1, 1)); zend_enum_add_case_cstr(${ce_ptr}, "${name}", &_ev); }'
			}
		}
		res << render_class_constant_attributes(ce_ptr, case_.name, case_.attributes)
	}

	for con in b.constants {
		lines := b.render_typed_class_constant(ce_ptr, con)
		res << for_php_version_range(con.min_php_version, con.max_php_version_exclusive,
			lines)
	}
	if b.native_trait_uses.len > 0 {
		// The entries and interned names live as long as the registered trait.
		res << '        static zend_class_name trait_names[${b.native_trait_uses.len}];'
		for i, trait in b.native_trait_uses {
			name := c_string_escape(php_types.class_lookup_name(trait))
			lower := c_string_escape(php_types.class_lookup_name(trait).to_lower())
			res << '        trait_names[${i}].name = zend_string_init_interned("${name}", sizeof("${name}")-1, 1);'
			res << '        trait_names[${i}].lc_name = zend_string_init_interned("${lower}", sizeof("${lower}")-1, 1);'
		}
		res << '        ${ce_ptr}->trait_names = vphp_zend_trait_names(trait_names, ${b.native_trait_uses.len});'
		res << '        ${ce_ptr}->num_traits = ${b.native_trait_uses.len};'
	}
	if b.native_trait_aliases.len > 0 {
		res << '        static zend_trait_alias trait_aliases[${b.native_trait_aliases.len}];'
		mut entries := []string{}
		for i, alias in b.native_trait_aliases {
			entry := '&trait_aliases[${i}],'
			min_version := if alias.is_final && alias.alias == '' && alias.visibility == ''
				&& alias.min_php_version < 80300 {
				80300
			} else {
				alias.min_php_version
			}
			entries << for_php_version_range(min_version, alias.max_php_version_exclusive,
				[entry])
			mut init := []string{}
			for field, value in {
				'trait_method.class_name':  php_types.class_lookup_name(alias.trait_name)
				'trait_method.method_name': alias.method
			} {
				literal := c_string_literal_bytes(value)
				init << '        trait_aliases[${i}].${field} = zend_string_init_interned("${literal}", sizeof("${literal}")-1, 1);'
			}
			literal := c_string_literal_bytes(alias.alias)
			alias_value := if alias.alias == '' {
				'NULL'
			} else {
				'zend_string_init_interned("${literal}", sizeof("${literal}")-1, 1)'
			}
			init << '        trait_aliases[${i}].alias = ${alias_value};'
			mut modifiers := []string{}
			if alias.visibility != '' {
				modifiers << 'ZEND_ACC_${alias.visibility.to_upper()}'
			}
			if alias.is_final {
				modifiers << 'VPHP_ACC_TRAIT_FINAL'
			}
			if modifiers.len > 0 {
				init << '        trait_aliases[${i}].modifiers = ${modifiers.join(' | ')};'
			}
			res << for_php_version_range(min_version, alias.max_php_version_exclusive, init)
		}
		res << '        static zend_trait_alias *trait_alias_ptrs[] = {'
		res << entries
		res << '            NULL'
		res << '        };'
		res << '        ${ce_ptr}->trait_aliases = vphp_zend_trait_aliases(trait_alias_ptrs);'
	}
	if register_constants_before_inheritance {
		res << '        vphp_inherit_class_before_properties(${ce_ptr}, parent_ce);'
	} else if b.parent != '' && legacy_compound_methods.len > 0 {
		res << '#if PHP_VERSION_ID < 80300'
		res << '        vphp_inherit_class_before_properties(${ce_ptr}, parent_ce);'
		res << '#endif'
	}
	if b.class_flags.len > 0 {
		res << '        ${ce_ptr}->ce_flags |= ${b.class_flags.join(' | ')};'
	}
	if b.clone_handler_prefix != '' || b.clone_zend_properties {
		res << '        vphp_init_cloneable_object_handlers(&${lower_name}_object_handlers, ${lower_name}_clone_object);'
	}
	if b.clone_handler_prefix != '' || b.clone_zend_properties || b.instance_handler_prefix != '' {
		res << '        ${ce_ptr}->create_object = ${lower_name}_create_object;'
	} else if b.create_object {
		res << '        ${ce_ptr}->create_object = vphp_create_object_handler;'
	} else if b.type == .class_ && b.uses_inherited_object {
		res << '        ${ce_ptr}->create_object = vphp_create_inherited_object_handler;'
	}
	if b.properties.len > 0 {
		for prop in b.properties {
			res << b.render_versioned_property(ce_ptr, prop)
		}
	}
	if b.type == .class_ {
		storage := b.properties.filter(it.property_only || (it.is_static && !it.is_static_shadow))
		shadows := b.properties.filter(it.is_static_shadow).map(it.name)
		if storage.len > 0 || shadows.len > 0 || b.inherited_field_initializer != '' {
			shadow_names := c_string_literal_bytes(shadows.join('\x00') + '\x00')
			res << '        static const vphp_php_property_names property_names = {'
			for prop in storage {
				name := c_string_literal_bytes(prop.name + '\x00')
				res << for_php_version(prop.min_php_version, ['            "${name}"'])
			}
			init := if b.inherited_field_initializer != '' {
				b.inherited_field_initializer
			} else {
				'NULL'
			}
			res << '            "\\000", "${shadow_names}", ${init}'
			res << '        };'
			res << '        vphp_register_php_property_storage(${ce_ptr}, &property_names);'
		}
	}
	// Zend links interface property contracts against the class's completed property table.
	for i, iface in b.interfaces {
		iface_name := c_string_escape(php_types.class_lookup_name(iface))
		iface_var := 'iface_${i}_ce'
		res << '        zend_class_entry *${iface_var} = vphp_require_class_entry("${iface_name}", sizeof("${iface_name}")-1, 0);'
		res << '        if (!${iface_var}) {'
		res << '            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "${self_name}", "${iface_name}");'
		res << '            return FAILURE;'
		res << '        }'
		res << '        vphp_verify_interface_reference_methods(${ce_ptr}, ${iface_var});'
		res << '#if PHP_VERSION_ID >= 80400'
		res << '        vphp_verify_interface_restricted_hooks(${ce_ptr}, ${iface_var});'
		res << '#endif'
		res << '        zend_class_implements(${ce_ptr}, 1, ${iface_var});'
	}
	if b.parent != '' || b.interfaces.len > 0 {
		res << '        vphp_prepare_class_constant_cache(${ce_ptr});'
	}
	if b.type == .class_ && (b.parent != '' || b.interfaces.len > 0) {
		declared_abstract := b.class_flags.contains('ZEND_ACC_EXPLICIT_ABSTRACT_CLASS')
			|| b.methods.any(it.hook_kind == '' && it.is_abstract)
		res << '#if PHP_VERSION_ID >= 80400'
		res << '        vphp_verify_interface_property_contracts(${ce_ptr}, ${declared_abstract});'
		res << '#endif'
	}
	if b.type == .class_ && (b.properties.any(class_property_has_override(it))
		|| b.methods.any(it.hook_kind != '' && class_method_has_override(it))) {
		res << '#if PHP_VERSION_ID >= 80500'
		res << '        if (!vphp_validate_property_overrides(${ce_ptr}, true)) { return FAILURE; }'
		res << '#endif'
	}
	res << b.render_class_attributes(ce_ptr, lower_name)
	for mi, method in b.methods {
		if method.hook_kind != '' {
			continue
		}
		if method.attributes.len == 0 && method.args.all(it.attributes.len == 0) {
			continue
		}
		mut method_lines := []string{}
		method_func_var := 'method_${lower_name}_${mi}'
		method_lines << '        zend_function *${method_func_var} = zend_hash_str_find_ptr_lc(&${ce_ptr}->function_table, "${c_string_escape(method.php_name)}", sizeof("${c_string_escape(method.php_name)}")-1);'
		method_lines << '        if (${method_func_var} != NULL) {'
		if b.type != .trait_ && method.attributes.any(php_types.is_override_attribute(it.name)) {
			method_lines << '#if PHP_VERSION_ID >= 80300'
			method_lines << '            if (!vphp_validate_method_override(${method_func_var}, true)) { return FAILURE; }'
			method_lines << '#endif'
		}
		method_lines << render_callable_attributes(method_func_var, '${lower_name}_${mi}',
			method.attributes, method.args)
		method_lines << '        }'
		res << method.for_php_version(method_lines)
	}

	res << '    }'
	res << '    return SUCCESS;'
	res << '}'
	return res.join('\n')
}

fn class_property_has_override(prop ClassProperty) bool {
	return prop.attributes.any(php_types.is_override_attribute(it.name))
}

fn class_method_has_override(method ClassMethod) bool {
	return method.attributes.any(php_types.is_override_attribute(it.name))
}

pub fn (b &ClassBuilder) render_impl_prelude() string {
	mut parts := [b.render_arginfo_defs()]
	if b.inherited_field_initializer != '' {
		parts << 'extern void ${b.inherited_field_initializer}(zend_object *, zend_class_entry *);'
	}
	if b.enum_backing_values != '' {
		value_type := if b.enum_unsigned_backing { 'uint64_t' } else { 'int64_t' }
		parts << 'extern void ${b.enum_backing_values}(${value_type} *);'
	}
	for method in b.methods {
		if method.handler_symbol != '' && !method.is_abstract {
			parts << method.for_php_version([
				'ZEND_NAMED_FUNCTION(ZEND_MN(${method.handler_symbol}));',
			]).join('\n')
		}
	}
	clone_handler := b.clone_handler_prefix != '' || b.clone_zend_properties
	if clone_handler || b.instance_handler_prefix != '' {
		lower_name := b.c_name.to_lower()
		prefix := b.clone_handler_prefix
		handler_prefix := if b.instance_handler_prefix != '' {
			b.instance_handler_prefix
		} else {
			prefix
		}
		if handler_prefix != '' {
			parts << 'extern vphp_class_handlers *${handler_prefix}_handlers(void);'
		}
		if clone_handler {
			parts << 'static zend_object_handlers ${lower_name}_object_handlers;'
		}
		mut create := [
			'static zend_object *${lower_name}_create_object(zend_class_entry *ce) {',
			'    zend_object *obj = vphp_create_object_handler(ce);',
		]
		if clone_handler {
			create << '    obj->handlers = &${lower_name}_object_handlers;'
		}
		if b.instance_handler_prefix != '' {
			create << '    vphp_obj_from_obj(obj)->instance_handlers = ${handler_prefix}_handlers;'
		}
		create << ['    return obj;', '}']
		parts << create.join('\n')
		if b.clone_zend_properties {
			parts << 'static zend_object *${lower_name}_clone_object(zend_object *obj) {
    zend_object *target = obj->ce->create_object(obj->ce);
    zend_objects_clone_members(target, obj);
    return target;
}'
		} else if prefix != '' {
			parts << 'extern void ${prefix}_clone_into_raw(void *, void *);'
			parts << 'static zend_object *${lower_name}_clone_object(zend_object *obj) {
    return vphp_clone_bound_object(obj, ${prefix}_handlers(), ${prefix}_clone_into_raw);
}'
		}
	}
	return parts.join('\n')
}

pub fn (b &ClassBuilder) render_impl_postlude() string {
	return '${b.render_methods_array()}\n${b.render_registration_function()}'
}

fn arg_type_info(v_type string, table &ast.Table) ArgTypeInfo {
	decl := parse_php_type_decl(v_type)
	if union_info := union_type_info(decl) {
		return union_info
	}
	clean := decl.clean
	allow_null := decl.allow_null
	if table != unsafe { nil } // SAFETY: nil literal in unsafe context

	{
		if sym := table.find_sym(clean) {
			if sym.kind == .sum_type {
				mut masks := []string{}
				mut resolved_allow_null := allow_null
				if sym.info is ast.SumType {
					for variant in sym.info.variants {
						name := table.get_type_name(variant)
						if name == 'none' {
							resolved_allow_null = true
							continue
						}
						if builtin := php_builtin_type_info(name) {
							if builtin.mask != '' {
								masks << builtin.mask
							} else if builtin.code == 'IS_STRING' {
								masks << 'MAY_BE_STRING'
							} else if builtin.code == 'IS_LONG' {
								masks << 'MAY_BE_LONG'
							} else if builtin.code == '_IS_BOOL' {
								masks << 'MAY_BE_BOOL'
							} else if builtin.code == 'IS_DOUBLE' {
								masks << 'MAY_BE_DOUBLE'
							} else if builtin.code == 'IS_ARRAY' {
								masks << 'MAY_BE_ARRAY'
							} else if builtin.code == 'IS_OBJECT' {
								masks << 'MAY_BE_OBJECT'
							}
						} else {
							masks << 'MAY_BE_OBJECT'
						}
					}
				}
				if masks.len > 0 {
					return ArgTypeInfo{
						code:           ''
						mask:           masks.join('|')
						mask_obj_class: ''
						allow_null:     resolved_allow_null
					}
				}
			}
		}
	}
	if builtin := php_builtin_type_info(v_type) {
		return ArgTypeInfo{
			code:           builtin.code
			mask:           builtin.mask
			mask_obj_class: builtin.mask_obj_class
			allow_null:     allow_null
		}
	}
	if spec := php_types.PhpTypeSpec.from_v_type(clean) {
		if spec.php_class != '' {
			return ArgTypeInfo{
				mask:          spec.php_mask
				named_members: [spec.php_class]
				allow_null:    allow_null
			}
		}
		return ArgTypeInfo{
			code:       spec.php_code
			mask:       spec.php_mask
			allow_null: allow_null
		}
	}
	code := match clean {
		'callable', 'Callable', 'vphp.Callable' {
			'IS_CALLABLE'
		}
		else {
			''
		}
	}

	return ArgTypeInfo{
		code:           code
		mask:           ''
		mask_obj_class: ''
		allow_null:     allow_null
	}
}

fn method_has_literal_class_arg(m ClassMethod) bool {
	for arg in m.args {
		raw_type := if arg.php_type != '' { arg.php_type } else { arg.type_ }
		if is_class_literal_type(raw_type) {
			return true
		}
	}
	return false
}

fn method_arginfo_header(m ClassMethod, table &ast.Table) string {
	resolved_return_type := m.return_spec.resolved_type()
	type_info := arg_type_info(resolved_return_type, table)
	name := if m.trait_method_name != '' { m.trait_method_name } else { m.php_name }
	return render_method_arginfo_header(m.c_func, name, required_arg_count(m.args),
		resolved_return_type, m.return_spec.arginfo_obj_type(), type_info, m.return_spec.arginfo_return_reference(),
		method_has_literal_class_arg(m), m.compound_arginfo_setup(table).len > 0)
}

fn (m ClassMethod) compound_arginfo_setup(table &ast.Table) []string {
	if m.hook_kind != '' || (m.uses_context && !m.return_spec.has_context_object_return()) {
		return []
	}
	return compound_arginfo_setup('arginfo_${m.c_func}', m.return_spec,
		if m.uses_context { [] } else { m.args }, table)
}

fn c_string_escape(s string) string {
	return s.replace('\\', '\\\\').replace('"', '\\"')
}

fn render_attribute_arg_value_lines(attr_var string, args []ClassAttributeArg) []string {
	mut res := []string{}
	for j, arg in args {
		if arg.name != '' {
			res << '        ${attr_var}->args[${j}].name = zend_string_init_interned("${c_string_literal_bytes(arg.name)}", ${arg.name.len}, 1);'
		}
		render_attribute_value(mut res, '&${attr_var}->args[${j}].value', repr.PhpAttributeArg(arg))
	}
	return res
}

fn render_attribute_value(mut res []string, dest string, arg repr.PhpAttributeArg) {
	if arg.has_constant_expression() {
		res << '        {'
		res << '            static union { zend_ast_zval alignment; unsigned char bytes[sizeof(zend_ast_ref) + ${attribute_ast_capacity(arg)}]; } storage;'
		res << '            char *cursor = vphp_begin_attribute_ast(${dest}, storage.bytes);'
		render_attribute_ast(mut res, arg)
		res << '        }'
		return
	}
	match arg.kind {
		'array' {
			if arg.items.len == 0 {
				res << '        ZVAL_EMPTY_ARRAY(${dest});'
				return
			}
			res << '        {'
			res << '            HashTable *array = vphp_new_attribute_array(${arg.items.len});'
			for item in arg.items {
				res << '            {'
				res << '                zval item;'
				render_attribute_value(mut res, '&item', item)
				match item.key_kind {
					'int' {
						res << '                zend_hash_index_update(array, ${attribute_c_int(item.key)}, &item);'
					}
					'string' {
						key := c_string_literal_bytes(item.key)
						res << '                zend_string *key = zend_string_init_interned("${key}", ${item.key.len}, 1);'
						res << '                zend_symtable_update(array, key, &item);'
						res << '                zend_string_release(key);'
					}
					else {
						res << '                if (!zend_hash_next_index_insert(array, &item)) {'
						res << '                    zend_error(E_CORE_WARNING, "Cannot append after the maximum PHP attribute array index");'
						res << '                    return FAILURE;'
						res << '                }'
					}
				}
				res << '            }'
			}
			res << '            vphp_set_attribute_array(${dest}, array);'
			res << '        }'
		}
		'bool' {
			res << '        ZVAL_BOOL(${dest}, ${if arg.value == 'true' {
				'1'
			} else {
				'0'
			}});'
		}
		'float' {
			res << '        ZVAL_DOUBLE(${dest}, ${arg.value});'
		}
		'int' {
			res << '        ZVAL_LONG(${dest}, ${attribute_c_int(arg.value)});'
		}
		'null' {
			res << '        ZVAL_NULL(${dest});'
		}
		else {
			value := c_string_literal_bytes(arg.value)
			res << '        ZVAL_STR(${dest}, zend_string_init_interned("${value}", ${arg.value.len}, 1));'
		}
	}
}

fn attribute_ast_capacity(arg repr.PhpAttributeArg) string {
	if arg.kind == 'class_constant' {
		return 'sizeof(zend_ast) + sizeof(zend_ast *) + 2 * sizeof(zend_ast_zval)'
	}
	if arg.kind != 'array' {
		return 'sizeof(zend_ast_zval)'
	}
	mut sizes := ['sizeof(zend_ast_list) + ${arg.items.len} * sizeof(zend_ast *)']
	for item in arg.items {
		sizes << 'sizeof(zend_ast) + sizeof(zend_ast *)'
		sizes << attribute_ast_capacity(item)
		if item.key_kind != '' {
			sizes << attribute_ast_capacity(repr.PhpAttributeArg{
				kind:  item.key_kind
				value: item.key
			})
		}
	}
	return sizes.join(' + ')
}

fn render_attribute_ast(mut res []string, arg repr.PhpAttributeArg) string {
	node := 'node_${res.len}'
	match arg.kind {
		'class_constant' {
			class_name := arg.value.all_before('::')
			member := arg.value.all_after('::')
			if member.to_lower() == 'class' {
				fetch := if class_name.to_lower() == 'self' {
					'ZEND_FETCH_CLASS_SELF'
				} else {
					'ZEND_FETCH_CLASS_PARENT'
				}
				res << '            zend_ast *${node} = vphp_attribute_ast_node(&cursor, ZEND_AST_CLASS_NAME, ${fetch}, 1);'
				res << '            ${node}->child[0] = NULL;'
			} else {
				res << '            zend_ast *${node} = vphp_attribute_ast_class_constant(&cursor, "${c_string_literal_bytes(class_name)}", "${c_string_literal_bytes(member)}");'
				res << '            (void)${node};'
			}
			return node
		}
		'array' {
			res << '            zend_ast_list *${node} = vphp_attribute_ast_array(&cursor, ${arg.items.len});'
			res << '            (void)${node};'
			for index, item in arg.items {
				element := 'element_${res.len}'
				res << '            zend_ast *${element} = vphp_attribute_ast_node(&cursor, ZEND_AST_ARRAY_ELEM, 0, 2);'
				res << '            ${node}->child[${index}] = ${element};'
				value := render_attribute_ast(mut res, item)
				key := if item.key_kind == '' {
					'NULL'
				} else {
					render_attribute_ast(mut res, repr.PhpAttributeArg{
						kind:  item.key_kind
						value: item.key
					})
				}
				res << '            ${element}->child[0] = (zend_ast *)${value};'
				res << '            ${element}->child[1] = (zend_ast *)${key};'
			}
			return node
		}
		else {
			res << '            zend_ast_zval *${node} = vphp_attribute_ast_literal(&cursor);'
			render_attribute_value(mut res, '&${node}->val', arg)
			return node
		}
	}
}

fn attribute_c_int(value string) string {
	return if value == min_i64.str() { '(-9223372036854775807 - 1)' } else { value }
}

fn render_callable_attributes(func_var string, id string, attributes []ClassAttribute, args []ClassMethodArg) []string {
	mut res := []string{}
	for i, attr in attributes {
		min_version, flag := callable_attribute_settings(attr.name)
		mut lines := render_add_callable_attribute(func_var, -1, attr, 'attribute_${id}_callable_${i}')
		if flag != '' {
			lines << '        ${func_var}->common.fn_flags |= ${flag};'
		}
		res << for_php_version(min_version, lines)
	}
	for ai, arg in args {
		for i, attr in arg.attributes {
			res << render_add_callable_attribute(func_var, ai, attr, 'attribute_${id}_${ai}_${i}')
		}
	}
	return res
}

fn callable_attribute_settings(name string) (int, string) {
	if php_types.is_nodiscard_attribute(name) {
		return 80500, 'ZEND_ACC_NODISCARD'
	}
	if php_types.is_deprecated_attribute(name) {
		return 80400, 'ZEND_ACC_DEPRECATED'
	}
	if php_types.is_override_attribute(name) {
		return 80300, ''
	}
	return 0, ''
}

fn render_add_callable_attribute(func_var string, arg_index int, attr ClassAttribute, attr_var string) []string {
	if arg_index < 0 {
		return render_attribute_registration(attr_var, attr, 'zend_add_function_attribute',
			[func_var])
	}
	return render_attribute_registration(attr_var, attr, 'vphp_zend_add_parameter_attribute',
		[func_var, arg_index.str()])
}

fn (b &ClassBuilder) render_class_attributes(ce_ptr string, lower_name string) []string {
	mut res := []string{}
	for i, attr in b.attributes {
		mut lines := render_attribute_registration('attribute_${lower_name}_${i}', attr,
			'vphp_zend_add_class_attribute', [ce_ptr])
		if b.type == .trait_ && php_types.is_deprecated_attribute(attr.name) {
			lines << '        ${ce_ptr}->ce_flags |= ZEND_ACC_DEPRECATED;'
			lines = for_php_version(80500, lines)
		}
		res << lines
	}
	return res
}

fn render_attribute_registration(attr_var string, attr ClassAttribute, register string, target []string) []string {
	mut res := []string{}
	attr_name_var := '${attr_var}_name'
	attr_name := c_string_escape(php_types.class_lookup_name(attr.name))
	args := [...target, attr_name_var, attr.args.len.str()].join(', ')
	res << '        zend_string *${attr_name_var} = zend_string_init_interned("${attr_name}", sizeof("${attr_name}")-1, 1);'
	res << '        zend_attribute *${attr_var} = ${register}(${args});'
	res << '        zend_string_release(${attr_name_var});'
	res << render_attribute_arg_value_lines(attr_var, attr.args)
	return res
}

pub fn (b &ClassBuilder) render_arginfo_defs() string {
	mut res := []string{}
	for m in b.methods {
		if m.hook_kind != '' {
			continue
		}
		if m.uses_context {
			res << m.for_php_version([render_context_arginfo(m.c_func, m.php_name, m.return_spec,
				b.table)])
			continue
		}
		mut declaration := [method_arginfo_header(m, b.table)]
		for arg in m.args {
			declaration << arg.render_arginfo_line(m.php_name, b.table)
		}
		declaration << 'ZEND_END_ARG_INFO()'
		res << m.for_php_version(declaration)
	}
	return res.join('\n')
}

pub fn (b &ClassBuilder) render_methods_array() string {
	mut res := []string{}
	lower_name := b.c_name.to_lower()
	res << 'static const zend_function_entry ${lower_name}_methods[] = {'
	for m in b.methods {
		if m.hook_kind != '' {
			continue
		}
		entry := if m.is_abstract {
			'    VPHP_ZEND_RAW_FENTRY("${m.php_name}", NULL, arginfo_${m.c_func}, ${m.flags})'
		} else if m.handler_symbol != '' {
			'    VPHP_ZEND_RAW_FENTRY("${m.php_name}", ZEND_MN(${m.handler_symbol}), arginfo_${m.c_func}, ${m.flags})'
		} else {
			'    PHP_ME(${b.c_name}, ${m.php_name}, arginfo_${m.c_func}, ${m.flags})'
		}
		res << m.for_php_version([entry])
	}
	res << '    PHP_FE_END\n};\n'
	return res.join('\n')
}

pub fn (b &ClassBuilder) render_minit() string {
	return 'if (${b.registration_func_name()}() != SUCCESS) { return FAILURE; }'
}

pub fn (b &ClassBuilder) export_fragments(implementation []string) ExportFragments {
	mut registration := []string{}
	owner := c_string_escape(php_types.normalize_php_type_literal(b.php_name))
	for iface in b.auto_interfaces {
		name := c_string_escape(php_types.normalize_php_type_literal(iface))
		registration << 'vphp_register_auto_interface_binding("${owner}", sizeof("${owner}") - 1, "${name}", sizeof("${name}") - 1);'
	}
	registration << b.render_minit()
	return ExportFragments{
		declarations:    [b.render_ce_extern_declaration()]
		implementations: [b.render_ce_declaration(), ...for_php_version(b.min_php_version,
			implementation)]
		minit_lines:     for_php_version(b.min_php_version, registration)
	}
}

pub fn class_constant_type(kind string, enum_alias ?repr.PhpEnumCaseAlias) php_types.TypeDeclaration {
	if alias := enum_alias {
		return php_types.TypeDeclaration{ names: [php_types.class_lookup_name(alias.php_enum)] }
	}
	code := match kind {
		'string' { 'IS_STRING' }
		'double', 'f64' { 'IS_DOUBLE' }
		'long', 'int' { 'IS_LONG' }
		'bool' { '_IS_BOOL' }
		else { '' }
	}
	return php_types.TypeDeclaration{ code: code }
}

fn (b &ClassBuilder) render_typed_class_constant(ce_ptr string, con ClassConstant) []string {
	mut res := []string{}
	declaration := class_constant_type(con.type_, con.enum_alias)
	c_type_code := declaration.code

	if c_type_code == '' && con.enum_alias == none {
		return res
	}

	mut c_constant_type := 'ZEND_TYPE_INIT_CODE(${c_type_code}, 0, 0)'
	zval_init := if alias := con.enum_alias {
		php_enum := c_string_literal_bytes(declaration.names[0])
		c_constant_type = 'vphp_arginfo_class_type("${php_enum}")'
		'vphp_init_enum_case_alias(&val, "${php_enum}", "${c_string_literal_bytes(alias.case_name)}");'
	} else {
		match c_type_code {
			'IS_STRING' {
				'ZVAL_STR(&val, zend_string_init("${c_string_literal_bytes(con.value)}", ${con.value.len}, 1));'
			}
			'IS_DOUBLE' { 'ZVAL_DOUBLE(&val, ${con.value});' }
			'IS_LONG' { 'ZVAL_LONG(&val, ${attribute_c_int(con.value)});' }
			'_IS_BOOL' { 'ZVAL_BOOL(&val, ${con.value});' }
			else { '' }
		}
	}

	name := c_string_literal_bytes(con.name)
	assignment := if con.enum_alias != none { 'zend_class_constant *case_alias = ' } else { '' }
	res << '        {'
	res << '            zval val;'
	res << '            ${zval_init}'
	res << '            zend_string *const_name = zend_string_init("${name}", ${con.name.len}, 1);'
	res << '#if PHP_VERSION_ID >= 80300'
	res << '            zend_type constant_type = ${c_constant_type};'
	res << '            ${assignment}zend_declare_typed_class_constant(${ce_ptr}, const_name, &val, ${con.flags}, NULL, constant_type);'
	res << '#else'
	res << '            ${assignment}zend_declare_class_constant_ex(${ce_ptr}, const_name, &val, ${con.flags}, NULL);'
	res << '#endif'
	if con.enum_alias != none {
		res << '            vphp_track_enum_case_alias(case_alias);'
	}
	res << '            zend_string_release(const_name);'
	res << '        }'
	res << render_class_constant_attributes(ce_ptr, con.name, con.attributes)

	return res
}

fn render_class_constant_attributes(ce_ptr string, constant_name string, attributes []ClassAttribute) []string {
	if attributes.len == 0 {
		return []
	}
	name := c_string_literal_bytes(constant_name)
	mut res := [
		'        {',
		'            zend_class_constant *constant = zend_hash_str_find_ptr(&${ce_ptr}->constants_table, "${name}", sizeof("${name}")-1);',
	]
	for i, attr in attributes {
		mut lines := render_attribute_registration('constant_attribute_${i}', attr,
			'zend_add_class_constant_attribute', [ce_ptr, 'constant'])
		if php_types.is_deprecated_attribute(attr.name) {
			lines << '        ZEND_CLASS_CONST_FLAGS(constant) |= ZEND_ACC_DEPRECATED;'
			lines = for_php_version(80400, lines)
		}
		res << lines.map('    ' + it)
	}
	res << '        }'
	return res
}

fn property_php_code(v_type string) string {
	if builtin := php_builtin_type_info(v_type) {
		return builtin.code
	}
	if spec := php_types.PhpTypeSpec.from_v_type(v_type) {
		if spec.php_mask == '' {
			return spec.php_code
		}
	}
	return ''
}

pub struct PropertyType {
pub:
	code          string
	class_name    string
	nullable      bool
	compound      bool
	compound_type ?ArgTypeInfo
}

pub fn (t PropertyType) is_typed() bool {
	return t.compound_type != none || t.class_name != '' || (t.code != '' && t.code != 'IS_MIXED')
}

fn (t PropertyType) has_declaration(explicit_mixed bool) bool {
	return t.is_typed() || (explicit_mixed && t.code == 'IS_MIXED')
}

pub fn (t PropertyType) declaration(explicit_mixed bool) php_types.TypeDeclaration {
	if !t.has_declaration(explicit_mixed) {
		return php_types.TypeDeclaration{}
	}
	if info := t.compound_type {
		return info.declaration()
	}
	return php_types.TypeDeclaration{
		code:     t.code
		names:    if t.class_name == '' { []string{} } else { [t.class_name] }
		nullable: t.nullable
	}
}

fn property_compound_type(decl PhpTypeDecl) ?ArgTypeInfo {
	if decl.allow_null {
		return none
	}
	mut terms := []string{}
	for item in decl.clean.split('|') {
		name := item.trim_space()
		lower := name.to_lower()
		if is_php_builtin_type(lower) {
			terms << lower
		} else {
			unqualified := lower.trim_left('\\')
			if is_php_builtin_type(unqualified) || unqualified in ['self', 'parent', 'resource'] {
				return none
			}
			terms << name
		}
	}
	info := union_type_info(PhpTypeDecl{ ...decl, clean: terms.join('|') })?
	for group in info.intersections {
		if group.any(is_php_builtin_type(it.to_lower()) || it.to_lower() == 'resource') {
			return none
		}
	}
	mask := if info.mask == '' { []string{} } else { info.mask.split('|') }
	members := info.named_members.len + info.intersections.len + mask.len + int(info.allow_null)
	if members != terms.len || 'MAY_BE_CALLABLE' in mask
		|| ('MAY_BE_OBJECT' in mask && info.named_members.len > 0)
		|| ('MAY_BE_TRUE' in mask && 'MAY_BE_FALSE' in mask)
		|| ('MAY_BE_BOOL' in mask && ('MAY_BE_TRUE' in mask || 'MAY_BE_FALSE' in mask)) {
		return none
	}
	return info
}

pub fn resolve_property_type(v_type string, property_only bool) PropertyType {
	decl := parse_php_type_decl(v_type)
	if property_only && decl.clean.contains_any('|&') {
		if info := property_compound_type(decl) {
			return PropertyType{ compound: true, nullable: info.allow_null, compound_type: info }
		}
		return PropertyType{ compound: true }
	}
	if property_only && decl.allow_null {
		if decl.clean.starts_with('?') {
			return PropertyType{ nullable: true }
		}
		code := property_php_code(decl.clean)
		if code in ['IS_STRING', 'IS_LONG', 'IS_DOUBLE', '_IS_BOOL', 'IS_TRUE', 'IS_FALSE', 'IS_ARRAY',
			'IS_OBJECT'] {
			return PropertyType{ code: code, nullable: true }
		}
		if code == '' && is_class_literal_type(decl.clean)
			&& decl.clean !in ['self', 'parent', 'resource'] {
			return PropertyType{ class_name: php_types.class_lookup_name(decl.clean), nullable: true }
		}
		return PropertyType{ nullable: true }
	}
	class_name := if v_type.contains('\\') && is_class_literal_type(v_type) {
		php_types.class_lookup_name(v_type)
	} else {
		''
	}
	return PropertyType{ code: property_php_code(v_type), class_name: class_name }
}

fn (t PropertyType) widens_integer_default() bool {
	if info := t.compound_type {
		mask := info.mask.split('|')
		return 'MAY_BE_DOUBLE' in mask && 'MAY_BE_LONG' !in mask
	}
	return t.code == 'IS_DOUBLE'
}

pub fn (t PropertyType) normalize_default(value repr.PhpAttributeArg) repr.PhpAttributeArg {
	if value.kind == 'int' && t.widens_integer_default() {
		return repr.PhpAttributeArg{
			...value
			kind:  'float'
			value: '${value.value}.0'
		}
	}
	return value
}

pub fn (t PropertyType) accepts_default(value repr.PhpAttributeArg) bool {
	if value.kind == 'null' && t.nullable {
		return true
	}
	if info := t.compound_type {
		mask := info.mask.split('|')
		return match value.kind {
			'string' { 'MAY_BE_STRING' in mask }
			'int' { 'MAY_BE_LONG' in mask || 'MAY_BE_DOUBLE' in mask }
			'float' { 'MAY_BE_DOUBLE' in mask }
			'bool' { 'MAY_BE_BOOL' in mask || 'MAY_BE_${value.value.to_upper()}' in mask }
			'array' { 'MAY_BE_ARRAY' in mask }
			else { false }
		}
	}
	return match t.code {
		'IS_STRING' { value.kind == 'string' }
		'IS_LONG' { value.kind == 'int' }
		'IS_DOUBLE' { value.kind in ['int', 'float'] }
		'_IS_BOOL' { value.kind == 'bool' }
		'IS_TRUE' { value.kind == 'bool' && value.value == 'true' }
		'IS_FALSE' { value.kind == 'bool' && value.value == 'false' }
		'IS_NULL' { value.kind == 'null' }
		'IS_ARRAY' { value.kind == 'array' }
		'IS_MIXED' { true }
		else { false }
	}
}

fn (info ArgTypeInfo) render_property_compound_type() []string {
	mut masks := []string{}
	if info.mask != '' {
		masks << info.mask
	}
	if info.allow_null {
		masks << 'MAY_BE_NULL'
	}
	mut lines := []string{}
	mut members := info.named_members.map('vphp_arginfo_class_type("${c_string_escape(it)}")')
	for index, group in info.intersections {
		group_members := group.map('vphp_arginfo_class_type("${c_string_escape(it)}")')
		group_var := 'property_intersection_${index}'
		lines << '            zend_type ${group_var}[] = { ${group_members.join(', ')} };'
		intersection := 'vphp_arginfo_type_list(${group_var}, ${group_members.len}, _ZEND_TYPE_INTERSECTION_BIT)'
		if info.is_intersection {
			lines << '            zend_type property_type = ${intersection};'
			return lines
		}
		members << intersection
	}
	if members.len == 0 {
		return ['            zend_type property_type = ZEND_TYPE_INIT_MASK(${masks.join(' | ')});']
	}
	if members.len == 1 && info.intersections.len == 0 {
		return [
			'            zend_type property_type = ${members[0]};',
			'            property_type.type_mask |= ${masks.join(' | ')};',
		]
	}
	masks << '_ZEND_TYPE_UNION_BIT'
	lines << [
		'            zend_type property_types[] = { ${members.join(', ')} };',
		'            zend_type property_type = vphp_arginfo_type_list(property_types, ${members.len}, ${masks.join(' | ')});',
	]
	return lines
}

fn (b &ClassBuilder) render_versioned_property(ce_ptr string, prop ClassProperty) []string {
	hooks := b.methods.filter(it.hook_kind != '' && it.hook_property == prop.name)
	min_version := if hooks.len > 0 && prop.min_php_version < 80400 {
		80400
	} else {
		prop.min_php_version
	}
	mut boundaries := [min_version]
	for hook in hooks {
		for version in [hook.min_php_version, hook.max_php_version_exclusive] {
			if version > min_version && version !in boundaries {
				boundaries << version
			}
		}
	}
	boundaries.sort()
	mut lines := []string{}
	for index, start in boundaries {
		end := if index + 1 < boundaries.len { boundaries[index + 1] } else { 0 }
		active_hooks := hooks.filter(it.min_php_version <= start
			&& (it.max_php_version_exclusive == 0 || start < it.max_php_version_exclusive))
		lines << for_php_version_range(start, end, b.render_typed_property(ce_ptr, prop,
			active_hooks))
	}
	return lines
}

fn (b &ClassBuilder) render_typed_property(ce_ptr string, prop ClassProperty, hooks []ClassMethod) []string {
	mut res := []string{}
	property_type := resolve_property_type(prop.type_, prop.property_only)
	php_code := property_type.code
	class_name := c_string_escape(property_type.class_name)
	typed := property_type.has_declaration(b.type == .interface_ || prop.explicit_mixed
		|| prop.has_set_visibility || prop.explicit_readonly_class)
	has_override := class_property_has_override(prop)
	has_attributes := hooks.len > 0 || prop.attributes.any(!php_types.is_override_attribute(it.name))
	name := c_string_escape(prop.name)
	if b.parent != '' && hooks.len == 0 {
		res << '#if PHP_VERSION_ID >= 80400'
		res << '        vphp_prepare_backed_property(${ce_ptr}, "${name}", sizeof("${name}")-1);'
		res << '#endif'
	}
	if !typed && !has_attributes && !has_override && prop.default_value == none {
		if b.parent != '' {
			res << '        vphp_verify_mixed_property_redeclaration(${ce_ptr}, "${name}", sizeof("${name}")-1, false);'
		}
		res << '        zend_declare_property_null(${ce_ptr}, "${name}", sizeof("${name}")-1, ${prop.flags});'
		if b.parent != '' {
			res << render_backed_property_contract(ce_ptr, name)
		}
		return res
	}
	default_init := if (b.inherited_field_initializer != '' && !prop.property_only && !prop.is_static)
		|| (prop.property_only && prop.flags.contains('ZEND_ACC_READONLY'))
		|| (prop.property_only && typed && (prop.is_static || php_code == 'IS_MIXED'))
		|| class_name != '' || property_type.nullable || property_type.compound
		|| prop.has_set_visibility || prop.explicit_readonly_class {
		'ZVAL_UNDEF(&default_val);'
	} else {
		match php_code {
			'IS_STRING' { 'ZVAL_EMPTY_STRING(&default_val);' }
			'IS_LONG' { 'ZVAL_LONG(&default_val, 0);' }
			'IS_DOUBLE' { 'ZVAL_DOUBLE(&default_val, 0.0);' }
			'_IS_BOOL', 'IS_FALSE' { 'ZVAL_FALSE(&default_val);' }
			'IS_TRUE' { 'ZVAL_TRUE(&default_val);' }
			else { 'ZVAL_NULL(&default_val);' }
		}
	}

	res << '        {'
	res << '            zval default_val;'
	if value := prop.default_value {
		render_attribute_value(mut res, '&default_val', property_type.normalize_default(value))
	} else {
		res << '            ${default_init}'
	}
	zend_type := if class_name != '' {
		'vphp_arginfo_class_type("${class_name}")'
	} else if typed {
		allow_null := if property_type.nullable { 1 } else { 0 }
		'ZEND_TYPE_INIT_CODE(${php_code}, ${allow_null}, 0)'
	} else {
		'ZEND_TYPE_INIT_NONE(0)'
	}
	if info := property_type.compound_type {
		res << info.render_property_compound_type()
	} else {
		res << '            zend_type property_type = ${zend_type};'
		if class_name != '' && property_type.nullable {
			res << '            property_type.type_mask |= MAY_BE_NULL;'
		}
	}
	res << '            zend_string *property_name = zend_string_init_interned("${name}", sizeof("${name}")-1, 1);'
	mut flags := prop.flags
	if hooks.len > 0 {
		if b.type != .interface_ {
			backed := if prop.default_value != none { 'true' } else { 'false' }
			res << '            uint32_t hook_flags = vphp_prepare_property_hooks(${ce_ptr}, property_name, ${backed});'
			flags += ' | hook_flags'
		}
		if prop.default_value == none {
			res << '            ZVAL_UNDEF(&default_val);'
		}
	}
	if b.parent != '' && hooks.len == 0 && (!typed || php_code == 'IS_MIXED') {
		res << '            vphp_verify_mixed_property_redeclaration(${ce_ptr}, "${name}", sizeof("${name}")-1, ${typed});'
	}
	if has_override && !has_attributes {
		res << '#if PHP_VERSION_ID >= 80500'
	}
	if has_attributes || has_override {
		res << '            zend_property_info *property_info ='
	}
	if has_override && !has_attributes {
		res << '#endif'
	}
	res << '            zend_declare_typed_property(${ce_ptr}, property_name, &default_val, ${flags}, NULL, property_type);'
	if hooks.len == 0 && b.parent != '' {
		res << render_backed_property_contract(ce_ptr, name)
	}
	if hooks.len > 0 {
		res << '            static vphp_property_hooks property_hooks;'
		for hook in hooks {
			kind := 'ZEND_PROPERTY_HOOK_${hook.hook_kind.to_upper()}'
			arg_name := if hook.hook_kind == 'set' {
				if hook.is_abstract { 'value' } else { c_string_escape(hook.args[0].name) }
			} else {
				''
			}
			handler := if hook.is_abstract {
				'NULL'
			} else {
				'ZEND_MN(${b.c_name}_${hook.php_name})'
			}
			declaration_ := if hook.is_abstract && !hook.returns_reference {
				''
			} else {
				'zend_function *hook_${hook.hook_kind} = '
			}
			res << '            ${declaration_}vphp_install_property_hook(&property_hooks, property_info, property_name, ${kind}, ${handler}, "${arg_name}");'
			if hook.flags.contains('ZEND_ACC_FINAL') {
				res << '            hook_${hook.hook_kind}->common.fn_flags |= ZEND_ACC_FINAL;'
			}
			if hook.returns_reference {
				res << '            hook_${hook.hook_kind}->common.fn_flags |= ZEND_ACC_RETURN_REFERENCE;'
			}
			res << render_callable_attributes('hook_${hook.hook_kind}', 'property_hook_${hook.hook_kind}', hook.attributes.filter(!php_types.is_override_attribute(it.name)), hook.args)
			for attr in hook.attributes.filter(php_types.is_override_attribute(it.name)) {
				res << '#if PHP_VERSION_ID >= 80500'
				res << render_add_callable_attribute('hook_${hook.hook_kind}', -1, attr,
					'property_hook_${hook.hook_kind}_override')
				res << '#endif'
			}
		}
		if b.type != .interface_ {
			res << '            vphp_inherit_property_hooks(property_info, property_name);'
			res << '            vphp_verify_reference_property_hook(property_info, "${name}");'
		}
	}
	for i, attr in prop.attributes {
		is_override := php_types.is_override_attribute(attr.name)
		if is_override {
			res << '#if PHP_VERSION_ID >= 80500'
		}
		lines := render_attribute_registration('property_attribute_${i}', attr,
			'zend_add_property_attribute', [ce_ptr, 'property_info'])
		res << lines.map('    ' + it)
		if is_override {
			res << '#endif'
		}
	}
	res << '        }'
	return res
}

fn render_backed_property_contract(ce_ptr string, name string) []string {
	return [
		'#if PHP_VERSION_ID >= 80400',
		'        {',
		'            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];',
		'            vphp_inherit_backed_property_contract(${ce_ptr}, "${name}", sizeof("${name}")-1, inherited_hooks);',
		'        }',
		'#endif',
	]
}

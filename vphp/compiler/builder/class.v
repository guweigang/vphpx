module builder

import compiler.syntax as ast
import compiler.php_types
import compiler.repr

pub enum ClassType {
	class_
	interface_
	enum_
}

pub struct ClassProperty {
pub:
	name       string
	type_      string
	flags      string
	attributes []ClassAttribute
}

pub struct ClassConstant {
pub:
	name       string
	type_      string
	value      string
	attributes []ClassAttribute
}

pub struct ClassMethod {
pub:
	php_name     string
	c_func       string
	return_spec  ReturnSpec
	flags        string
	is_abstract  bool
	uses_context bool
	args         []ClassMethodArg
	attributes   []ClassAttribute
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
	type                  ClassType = .class_
	php_name              string
	c_name                string
	parent                string
	create_object         bool = true
	clone_handler_prefix  string
	clone_zend_properties bool
	uses_inherited_object bool
	class_flags           []string
	interfaces            []string
	properties            []ClassProperty
	constants             []ClassConstant
	methods               []ClassMethod
	attributes            []ClassAttribute
	table                 &ast.Table = unsafe { nil } // SAFETY: nil literal in unsafe context
	v_name                string
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

pub fn (mut b ClassBuilder) add_property(name string, type_ string, flags string, attributes ...ClassAttribute) &ClassBuilder {
	b.properties << ClassProperty{name, type_, flags, attributes}
	return b
}

pub fn (mut b ClassBuilder) add_constant(name string, type_ string, value string, attributes ...ClassAttribute) &ClassBuilder {
	b.constants << ClassConstant{name, type_, value, attributes}
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

	res << 'static int ${b.registration_func_name()}(void) {'
	res << '    if (${ce_ptr} != NULL) {'
	res << '        return SUCCESS;'
	res << '    }'
	res << '    ${ce_ptr} = vphp_find_loaded_class_entry("${self_name}", sizeof("${self_name}")-1);'
	res << '    if (${ce_ptr} != NULL) {'
	res << '        return SUCCESS;'
	res << '    }'

	match b.type {
		.enum_ {
			res << '    ${ce_ptr} = zend_register_internal_enum("${b.php_name}", IS_LONG, NULL);'
			for con in b.constants {
				res << '    { zval _ev; ZVAL_LONG(&_ev, ${con.value}); zend_enum_add_case_cstr(${ce_ptr}, "${con.name}", &_ev); }'
				res << render_class_constant_attributes(ce_ptr, con)
			}
			res << b.render_class_attributes(ce_ptr, lower_name)
			res << '    return SUCCESS;'
			res << '}'
			return res.join('\n')
		}
		else {
			res << '    {   zend_class_entry ce;'
			for method in b.methods {
				res << method.compound_arginfo_setup(b.table).map('        ' + it)
			}
			res << '        INIT_CLASS_ENTRY(ce, "${b.php_name}", ${lower_name}_methods);'

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
						register := if has_abstract_static {
							'vphp_register_class_with_abstract_statics'
						} else {
							'zend_register_internal_class_ex'
						}
						res << '        ${ce_ptr} = ${register}(&ce, parent_ce);'
					} else if has_abstract_static {
						res << '        ${ce_ptr} = vphp_register_class_with_abstract_statics(&ce, NULL);'
					} else {
						res << '        ${ce_ptr} = zend_register_internal_class(&ce);'
					}
				}
			}
		}
	}

	if b.class_flags.len > 0 {
		res << '        ${ce_ptr}->ce_flags |= ${b.class_flags.join(' | ')};'
	}
	if b.clone_handler_prefix != '' || b.clone_zend_properties {
		res << '        vphp_init_cloneable_object_handlers(&${lower_name}_object_handlers, ${lower_name}_clone_object);'
		res << '        ${ce_ptr}->create_object = ${lower_name}_create_object;'
	} else if b.create_object {
		res << '        ${ce_ptr}->create_object = vphp_create_object_handler;'
	} else if b.type == .class_ && b.uses_inherited_object {
		res << '        ${ce_ptr}->create_object = vphp_create_inherited_object_handler;'
	}
	if b.interfaces.len > 0 {
		mut args := []string{}
		for i, iface in b.interfaces {
			iface_name := c_string_escape(php_types.class_lookup_name(iface))
			iface_var := 'iface_${i}_ce'
			res << '        zend_class_entry *${iface_var} = vphp_require_class_entry("${iface_name}", sizeof("${iface_name}")-1, 0);'
			res << '        if (!${iface_var}) {'
			res << '            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "${self_name}", "${iface_name}");'
			res << '            return FAILURE;'
			res << '        }'
			args << iface_var
		}
		if args.len == 1 {
			res << '        zend_class_implements(${ce_ptr}, 1, ${args[0]});'
		} else {
			res << '        zend_class_implements(${ce_ptr}, ${args.len}, ${args.join(', ')});'
		}
	}
	if b.type != .interface_ {
		for con in b.constants {
			res << b.render_typed_class_constant(ce_ptr, con)
		}
		for prop in b.properties {
			res << b.render_typed_property(ce_ptr, prop)
		}
	}
	res << b.render_class_attributes(ce_ptr, lower_name)
	for mi, method in b.methods {
		if method.attributes.len == 0 && method.args.all(it.attributes.len == 0) {
			continue
		}
		method_func_var := 'method_${lower_name}_${mi}'
		res << '        zend_function *${method_func_var} = zend_hash_str_find_ptr_lc(&${ce_ptr}->function_table, "${c_string_escape(method.php_name)}", sizeof("${c_string_escape(method.php_name)}")-1);'
		res << '        if (${method_func_var} != NULL) {'
		res << render_callable_attributes(method_func_var, '${lower_name}_${mi}', method.attributes, method.args)
		res << '        }'
	}

	res << '    }'
	res << '    return SUCCESS;'
	res << '}'
	return res.join('\n')
}

pub fn (b &ClassBuilder) render_impl_prelude() string {
	mut parts := [b.render_ce_declaration(), b.render_arginfo_defs()]
	if b.clone_handler_prefix != '' || b.clone_zend_properties {
		lower_name := b.c_name.to_lower()
		prefix := b.clone_handler_prefix
		if prefix != '' {
			parts << 'extern vphp_class_handlers *${prefix}_handlers(void);'
			parts << 'extern void ${prefix}_clone_into_raw(void *, void *);'
		}
		parts << 'static zend_object_handlers ${lower_name}_object_handlers;'
		parts << 'static zend_object *${lower_name}_create_object(zend_class_entry *ce) {
    zend_object *obj = vphp_create_object_handler(ce);
    obj->handlers = &${lower_name}_object_handlers;
    return obj;
}'
		if b.clone_zend_properties {
			parts << 'static zend_object *${lower_name}_clone_object(zend_object *obj) {
    zend_object *target = obj->ce->create_object(obj->ce);
    zend_objects_clone_members(target, obj);
    return target;
}'
		} else {
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
		return ArgTypeInfo{
			code:           spec.php_code
			mask:           spec.php_mask
			mask_obj_class: spec.mask_obj_class
			allow_null:     allow_null
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
	return render_method_arginfo_header(m.c_func, m.php_name, required_arg_count(m.args),
		resolved_return_type, m.return_spec.arginfo_obj_type(), type_info,
		method_has_literal_class_arg(m), m.compound_arginfo_setup(table).len > 0)
}

fn (m ClassMethod) compound_arginfo_setup(table &ast.Table) []string {
	if m.uses_context {
		return []
	}
	return compound_arginfo_setup(m.c_func, m.return_spec.resolved_type(), m.args, table)
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

fn attribute_c_int(value string) string {
	return if value == min_i64.str() { '(-9223372036854775807 - 1)' } else { value }
}

fn render_callable_attributes(func_var string, id string, attributes []ClassAttribute, args []ClassMethodArg) []string {
	mut res := []string{}
	for i, attr in attributes {
		res << render_add_callable_attribute(func_var, -1, attr, 'attribute_${id}_callable_${i}')
	}
	for ai, arg in args {
		for i, attr in arg.attributes {
			res << render_add_callable_attribute(func_var, ai, attr, 'attribute_${id}_${ai}_${i}')
		}
	}
	return res
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
		res << render_attribute_registration('attribute_${lower_name}_${i}', attr,
			'vphp_zend_add_class_attribute', [ce_ptr])
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
		if m.uses_context {
			res << 'ZEND_BEGIN_ARG_INFO_EX(arginfo_${m.c_func}, 0, 0, 0)'
			res << 'ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)'
			res << 'ZEND_END_ARG_INFO()'
			continue
		}
		res << method_arginfo_header(m, b.table)
		for arg in m.args {
			res << arg.render_arginfo_line(m.php_name, b.table)
		}
		res << 'ZEND_END_ARG_INFO()'
	}
	return res.join('\n')
}

pub fn (b &ClassBuilder) render_methods_array() string {
	mut res := []string{}
	lower_name := b.c_name.to_lower()
	res << 'static const zend_function_entry ${lower_name}_methods[] = {'
	for m in b.methods {
		if m.is_abstract {
			res << '    VPHP_ZEND_RAW_FENTRY("${m.php_name}", NULL, arginfo_${m.c_func}, ${m.flags})'
		} else {
			res << '    PHP_ME(${b.c_name}, ${m.php_name}, arginfo_${m.c_func}, ${m.flags})'
		}
	}
	res << '    PHP_FE_END\n};\n'
	return res.join('\n')
}

pub fn (b &ClassBuilder) render_minit() string {
	return 'if (${b.registration_func_name()}() != SUCCESS) { return FAILURE; }'
}

pub fn (b &ClassBuilder) export_fragments() ExportFragments {
	return ExportFragments{
		declarations: [b.render_ce_extern_declaration()]
		minit_lines:  [b.render_minit()]
	}
}

fn (b &ClassBuilder) render_typed_class_constant(ce_ptr string, con ClassConstant) []string {
	mut res := []string{}
	c_type_code := match con.type_ {
		'string' { 'IS_STRING' }
		'double' { 'IS_DOUBLE' }
		'long', 'int' { 'IS_LONG' }
		'bool' { '_IS_BOOL' }
		else { '' }
	}

	if c_type_code == '' {
		return res
	}

	zval_init := match con.type_ {
		'string' {
			'ZVAL_STR(&val, zend_string_init("${con.value}", sizeof("${con.value}")-1, 1));'
		}
		'double' { 'ZVAL_DOUBLE(&val, ${con.value});' }
		'long', 'int' { 'ZVAL_LONG(&val, ${con.value});' }
		'bool' { 'ZVAL_BOOL(&val, ${con.value});' }
		else { '' }
	}

	legacy_fn := match con.type_ {
		'string' {
			'zend_declare_class_constant_string(${ce_ptr}, "${con.name}", sizeof("${con.name}")-1, "${con.value}");'
		}
		'double' {
			'zend_declare_class_constant_double(${ce_ptr}, "${con.name}", sizeof("${con.name}")-1, ${con.value});'
		}
		'long', 'int' {
			'zend_declare_class_constant_long(${ce_ptr}, "${con.name}", sizeof("${con.name}")-1, ${con.value});'
		}
		'bool' {
			'zend_declare_class_constant_bool(${ce_ptr}, "${con.name}", sizeof("${con.name}")-1, ${con.value});'
		}
		else { '' }
	}

	res << '#if PHP_VERSION_ID >= 80300'
	res << '        {'
	res << '            zval val;'
	res << '            ${zval_init}'
	res << '            zend_string *const_name = zend_string_init("${con.name}", sizeof("${con.name}")-1, 1);'
	res << '            zend_declare_typed_class_constant(${ce_ptr}, const_name, &val, ZEND_ACC_PUBLIC, NULL, (zend_type) ZEND_TYPE_INIT_CODE(${c_type_code}, 0, 0));'
	res << '            zend_string_release(const_name);'
	res << '            zval_ptr_dtor(&val);'
	res << '        }'
	res << '#else'
	res << '        ${legacy_fn}'
	res << '#endif'
	res << render_class_constant_attributes(ce_ptr, con)

	return res
}

fn render_class_constant_attributes(ce_ptr string, con ClassConstant) []string {
	if con.attributes.len == 0 {
		return []
	}
	name := c_string_escape(con.name)
	mut res := [
		'        {',
		'            zend_class_constant *constant = zend_hash_str_find_ptr(&${ce_ptr}->constants_table, "${name}", sizeof("${name}")-1);',
	]
	for i, attr in con.attributes {
		lines := render_attribute_registration('constant_attribute_${i}', attr,
			'zend_add_class_constant_attribute', [ce_ptr, 'constant'])
		res << lines.map('    ' + it)
	}
	res << '        }'
	return res
}

fn (b &ClassBuilder) render_typed_property(ce_ptr string, prop ClassProperty) []string {
	mut res := []string{}
	// 先查原始 V 标量类型（string/int/i64/bool/f64/f32）
	mut php_code := ''
	if builtin := php_builtin_type_info(prop.type_) {
		php_code = builtin.code
	}
	// 再查包装类型（PhpString/PhpInt/PhpArray 等）
	if php_code == '' {
		if spec := php_types.PhpTypeSpec.from_v_type(prop.type_) {
			if spec.php_mask == '' {
				php_code = spec.php_code
			}
		}
	}
	// IS_MIXED / 空 code → 无类型属性
	class_name := if prop.type_.contains('\\') && is_class_literal_type(prop.type_) {
		c_string_escape(php_types.class_lookup_name(prop.type_))
	} else {
		''
	}
	typed := class_name != '' || (php_code != '' && php_code != 'IS_MIXED')
	has_attributes := prop.attributes.len > 0
	name := c_string_escape(prop.name)
	if !typed && !has_attributes {
		res << '        zend_declare_property_null(${ce_ptr}, "${name}", sizeof("${name}")-1, ${prop.flags});'
		return res
	}
	default_init := if class_name != '' {
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
	res << '            ${default_init}'
	zend_type := if class_name != '' {
		'vphp_arginfo_class_type("${class_name}")'
	} else if typed {
		'ZEND_TYPE_INIT_CODE(${php_code}, 0, 0)'
	} else {
		'ZEND_TYPE_INIT_NONE(0)'
	}
	declaration := if has_attributes { 'zend_property_info *property_info = ' } else { '' }
	res << '            ${declaration}zend_declare_typed_property(${ce_ptr}, zend_string_init_interned("${name}", sizeof("${name}")-1, 1), &default_val, ${prop.flags}, NULL, (zend_type) ${zend_type});'
	for i, attr in prop.attributes {
		lines := render_attribute_registration('property_attribute_${i}', attr,
			'zend_add_property_attribute', [ce_ptr, 'property_info'])
		res << lines.map('    ' + it)
	}
	res << '        }'
	return res
}

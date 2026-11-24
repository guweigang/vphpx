module compiler

import compiler.repr

struct InheritedReceiverGlue {
	type_ref     string
	lower_name   string
	props        []repr.PhpClassPropRepr
	parent_field string
	parent_glue  string
}

struct InheritedReceiverFieldBinding {
	prop repr.PhpClassPropRepr
}

fn InheritedReceiverGlue.new(type_ref string, lower_name string, owner &repr.PhpClassRepr, module_name string) InheritedReceiverGlue {
	mut glue := InheritedReceiverGlue{
		type_ref:   type_ref
		lower_name: lower_name
		props:      inherited_receiver_fields(owner.properties)
	}
	if parent := owner.inherited_receiver_parent {
		glue = InheritedReceiverGlue{
			...glue
			parent_field: parent.name
			parent_glue:  if parent.module_name in ['', 'main', module_name] {
				to_snake_case(parent.name)
			} else {
				'${parent.module_name.all_after_last('.')}.${to_snake_case(parent.name)}'
			}
		}
	}
	return glue
}

fn (glue InheritedReceiverGlue) render_lines() []string {
	mut lines := []string{}
	lines << glue.render_initialization_lines()
	lines << glue.render_load_lines()
	lines << glue.render_snapshot_lines()
	lines << glue.render_sync_lines()
	return lines
}

fn inherited_receiver_fields(props []repr.PhpClassPropRepr) []repr.PhpClassPropRepr {
	return props.filter(!it.is_property_only && !it.is_static)
}

fn (glue InheritedReceiverGlue) render_initialization_lines() []string {
	if glue.props.len == 0 {
		return []
	}
	mut out := [
		"@[export: '${glue.lower_name}_init_inherited_fields']",
		'pub fn ${glue.lower_name}_init_inherited_fields(obj voidptr, owner voidptr) {',
		'    mut scope := vphp.PhpScope.once()',
		'    defer { scope.close() }',
		'    php_obj := vphp.ZendObject.from_ptr(obj)',
	]
	if glue.parent_field != '' {
		// The native allocator has already initialized the parent's PHP fields.
		out << '    defaults := ${glue.type_ref}{'
		out << '        ${glue.parent_field}: ${glue.parent_glue}_load_from_php(vphp.ZendObject.invalid())'
		out << '    }'
	} else {
		out << '    defaults := ${glue.type_ref}{}'
	}
	for prop in glue.props {
		out << "    php_obj.init_inherited_field(owner, '${prop.name}', defaults.${prop.v_field_name})"
	}
	out << '}'
	return out
}

fn (glue InheritedReceiverGlue) render_snapshot_lines() []string {
	values := glue.props.filter(it.is_mut && is_inherited_php_value(it.v_type))
	mut out := ['pub fn ${glue.lower_name}_snapshot(recv ${glue.type_ref}) ${glue.type_ref} {']
	if values.len == 0 && glue.parent_field == '' {
		out << '    return recv'
	} else {
		out << '    return ${glue.type_ref}{'
		out << '        ...recv'
		if glue.parent_field != '' {
			out << '        ${glue.parent_field}: ${glue.parent_glue}_snapshot(recv.${glue.parent_field})'
		}
		for prop in values {
			out << '        ${prop.v_field_name}: vphp.snapshot_inherited_value(recv.${prop.v_field_name})'
		}
		out << '    }'
	}
	out << '}'
	return out
}

fn (glue InheritedReceiverGlue) render_load_lines() []string {
	mut out := []string{}
	out << 'pub fn ${glue.lower_name}_load_from_php(php_obj vphp.ZendObject) ${glue.type_ref} {'
	out << '    return ${glue.type_ref}{'
	if glue.parent_field != '' {
		out << '        ${glue.parent_field}: ${glue.parent_glue}_load_from_php(php_obj)'
	}
	for prop in glue.props {
		out << InheritedReceiverFieldBinding.new(prop).load_lines()
	}
	out << '    }'
	out << '}'
	return out
}

fn (glue InheritedReceiverGlue) render_sync_lines() []string {
	mut out := []string{}
	out << 'pub fn ${glue.lower_name}_sync_to_php(php_obj vphp.ZendObject, original ${glue.type_ref}, recv ${glue.type_ref}) {'
	out << '    if !php_obj.is_valid() {'
	out << '        return'
	out << '    }'
	if glue.parent_field != '' {
		out << '    ${glue.parent_glue}_sync_to_php(php_obj, original.${glue.parent_field}, recv.${glue.parent_field})'
	}
	for prop in glue.props {
		out << InheritedReceiverFieldBinding.new(prop).sync_lines()
	}
	out << '}'
	return out
}

fn InheritedReceiverFieldBinding.new(prop repr.PhpClassPropRepr) InheritedReceiverFieldBinding {
	return InheritedReceiverFieldBinding{
		prop: prop
	}
}

fn (field InheritedReceiverFieldBinding) load_lines() []string {
	prop := field.prop
	read := match prop.v_type {
		'string' {
			"php_obj.prop_string_or('${prop.name}', '', inherited_storage: true)"
		}
		'int' {
			"int(php_obj.prop_i64_or('${prop.name}', 0, inherited_storage: true))"
		}
		'i64' {
			"php_obj.prop_i64_or('${prop.name}', 0, inherited_storage: true)"
		}
		'bool' {
			"php_obj.prop_bool_or('${prop.name}', false, inherited_storage: true)"
		}
		'f64' {
			"php_obj.prop_f64_or('${prop.name}', 0.0, inherited_storage: true)"
		}
		'PhpValue', 'vphp.PhpValue' {
			"php_obj.inherited_value('${prop.name}')"
		}
		else { return [] }
	}
	return ['        ${prop.v_field_name}: ${read}']
}

fn (field InheritedReceiverFieldBinding) sync_lines() []string {
	prop := field.prop
	if !prop.is_mut {
		return []
	}
	if is_inherited_php_value(prop.v_type) {
		return ["    php_obj.sync_inherited_value('${prop.name}', original.${prop.v_field_name}, recv.${prop.v_field_name})"]
	}
	return ["    php_obj.sync_scalar_prop('${prop.name}', original.${prop.v_field_name}, recv.${prop.v_field_name})"]
}

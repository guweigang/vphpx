module compiler

import compiler.repr

struct ClassShadowGlue {
	class_name         string
	php_name           string
	shadow_const_name  string
	shadow_static_name string
	shadow_const_type  string
	shadow_static_type string
	static_state_name  string
	props              []repr.PhpClassPropRepr
}

fn ClassShadowGlue.new(r &repr.PhpClassRepr) ClassShadowGlue {
	return ClassShadowGlue{
		class_name:         r.name
		php_name:           r.php_name.replace('\\\\', '\\')
		shadow_const_name:  r.shadow_const_name
		shadow_static_name: r.shadow_static_name
		shadow_const_type:  r.shadow_const_type
		shadow_static_type: r.shadow_static_type
		static_state_name:  class_static_state_name(r)
		props:              r.properties
	}
}

fn class_static_state_name(r &repr.PhpClassRepr) string {
	return 'vphp_${r.c_name().to_lower()}_static_state'
}

fn (glue ClassShadowGlue) render_lines() []string {
	mut lines := []string{}
	lines << glue.render_const_accessor_lines()
	lines << glue.render_static_accessor_lines()
	return lines
}

fn (glue ClassShadowGlue) render_const_accessor_lines() []string {
	if glue.shadow_const_name == '' {
		return []
	}
	ret_type := if glue.shadow_const_type != '' { glue.shadow_const_type } else { 'voidptr' }
	return [
		'pub fn ${glue.class_name}.consts() ${ret_type} {',
		'    return ${glue.shadow_const_name}',
		'}',
	]
}

fn (glue ClassShadowGlue) render_static_accessor_lines() []string {
	if glue.shadow_static_name == '' {
		return []
	}
	type_name := if glue.shadow_static_type != '' {
		glue.shadow_static_type
	} else {
		glue.shadow_static_name.title()
	}
	mut out := []string{}
	fields := glue.props.filter(it.is_static_shadow).map(it.name + '\x00').join('')
	base := php_attribute_v_string(glue.php_name)
	field_names := php_attribute_v_string(fields)
	out << 'pub fn ${glue.class_name}.statics() &${type_name} {'
	out << '    return ${glue.static_state_name}(vphp.current_static_sync_class(${glue.static_state_name}_from_php))'
	out << '}'
	out << 'fn ${glue.static_state_name}(raw_ce voidptr) &${type_name} {'
	out << '    key := vphp.static_shadow_state_key("${glue.static_state_name}", raw_ce, ${base}, ${field_names})'
	out << '    return vphp.request_static_state[${type_name}](key, fn () ${type_name} {'
	out << '        return ${glue.static_state_initializer(type_name)}'
	out << '    })'
	out << '}'
	out << 'pub fn ${glue.class_name}.sync_statics_to_php(ctx vphp.Context) {'
	out << '    ${glue.static_state_name}_to_php(ctx.static_sync_class_entry().raw_ptr())'
	out << '}'
	out << 'fn ${glue.static_state_name}_to_php(raw_ce voidptr) {'
	out << '    ce := vphp.ZendClassEntry(vphp.ZendClassEntry.from_ptr(raw_ce))'
	out << '    if !ce.is_valid() { return }'
	out << '    s := ${glue.static_state_name}(raw_ce)'
	for prop in glue.props {
		if prop.is_static_shadow {
			out << '    ce.set_static_prop("${prop.name}", s.${prop.v_field_name})'
		}
	}
	out << '}'
	out << 'pub fn ${glue.class_name}.sync_statics_from_php(ctx vphp.Context) {'
	out << '    ${glue.static_state_name}_from_php(ctx.static_sync_class_entry().raw_ptr())'
	out << '}'
	out << 'fn ${glue.static_state_name}_from_php(raw_ce voidptr) {'
	out << '    ce := vphp.ZendClassEntry(vphp.ZendClassEntry.from_ptr(raw_ce))'
	out << '    if !ce.is_valid() { return }'
	out << '    mut s := ${glue.static_state_name}(raw_ce)'
	for prop in glue.props {
		if prop.is_static_shadow {
			out << '    s.${prop.v_field_name} = ce.static_prop[${prop.v_type}]("${prop.name}")'
		}
	}
	out << '}'
	return out
}

fn (glue ClassShadowGlue) static_state_initializer(type_name string) string {
	mut values := []string{}
	for prop in glue.props {
		if !prop.is_static_shadow {
			continue
		}
		if default_value := prop.default_value {
			literal := match default_value.kind {
				'string' { php_attribute_v_string(default_value.value) }
				'int' {
					if default_value.value == min_i64.str() {
						'min_i64'
					} else {
						default_value.value
					}
				}
				else { default_value.value }
			}
			values << '${prop.v_field_name}: ${literal}'
		}
	}
	return if values.len > 0 {
		'${type_name}{${values.join(', ')}}'
	} else {
		glue.shadow_static_name
	}
}

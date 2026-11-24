module compiler

struct ClassHandlersGlue {
	type_ref   string
	lower_name string
}

fn ClassHandlersGlue.new(type_ref string, lower_name string) ClassHandlersGlue {
	return ClassHandlersGlue{
		type_ref:   type_ref
		lower_name: lower_name
	}
}

fn (glue ClassHandlersGlue) render_lines(has_init_php_state_method bool) []string {
	mut lines := [
		"@[export: '${glue.lower_name}_handlers']",
		'pub fn ${glue.lower_name}_handlers() voidptr {',
		'    return vphp.ZendClassHandlers.new_typed(',
		'        prop_handler: ${glue.lower_name}_get_prop,',
		'        write_handler: ${glue.lower_name}_set_prop,',
		'        sync_handler: ${glue.lower_name}_sync_props,',
		'        new_raw: ${glue.lower_name}_new_raw,',
		'        cleanup_raw: ${glue.lower_name}_cleanup_raw,',
	]
	if has_init_php_state_method {
		lines << [
			'        free_raw: ${glue.lower_name}_free_raw,',
			'        init_php_state: ${glue.lower_name}_init_php_state',
		]
	} else {
		lines << '        free_raw: ${glue.lower_name}_free_raw'
	}
	lines << ['    )', '}']
	if has_init_php_state_method {
		lines << [
			'fn ${glue.lower_name}_init_php_state(ptr voidptr) {',
			'    unsafe {',
			'        mut obj := &${glue.type_ref}(ptr)',
			'        obj.init_php_state()',
			'    }',
			'}',
		]
	}
	return lines
}

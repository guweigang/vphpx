module compiler

import compiler.repr

fn (c Compiler) render_static_request_binding() string {
	mut properties := []string{}
	for element in c.elements {
		if element is repr.PhpClassRepr {
			ce := element.c_name().to_lower() + '_ce'
			for prop in element.properties {
				if prop.is_static {
					name := c_string_escape(prop.name)
					properties << '    {&${ce}, "${name}", sizeof("${name}") - 1},'
				}
			}
		}
	}
	if properties.len == 0 {
		return ''
	}
	name := 'vphp_${c.ext_name}_with_static_request'
	return [
		'static const vphp_static_request_property ${name}_properties[] = {',
		...properties,
		'};',
		'ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_${name}, 0, 1, IS_MIXED, 0)',
		'    ZEND_ARG_CALLABLE_INFO(0, callback, 0)',
		'ZEND_END_ARG_INFO()',
		'PHP_FUNCTION(${name}) {',
		'    vphp_run_static_request(INTERNAL_FUNCTION_PARAM_PASSTHRU, ${name}_properties,',
		'        sizeof(${name}_properties) / sizeof(${name}_properties[0]));',
		'}',
		'',
	].join('\n')
}

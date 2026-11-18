module main

import vphp as bridge

@[bridge.PhpStringParam('value', php_name: 'text', default_value: r'C:\tmp\$HOME', optional: true)]
@[php_function]
pub fn v_typed_raw_string_param(value string) string {
	return value
}

@[bridge.PhpBoolParam('value', php_name: 'enabled', default_value: true, optional: true)]
@[php_function]
pub fn v_typed_alias_bool_param(value bool) bool {
	return value
}

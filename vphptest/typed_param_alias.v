module main

import vphp
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

// The installed V parser requires distinct qualified spellings for repeated attributes.
@[vphp.PhpBoolParam('first', php_name: 'firstFlag', default_value: true, optional: true)]
@[bridge.PhpBoolParam(v_name: 'second', php_name: 'secondFlag', default_value: false, optional: true)]
@[vphp.PhpExportFunction(name: 'v_typed_bool_params')]
pub fn v_typed_bool_params(first bool, second bool) int {
	return (if first { 2 } else { 0 }) + (if second { 1 } else { 0 })
}

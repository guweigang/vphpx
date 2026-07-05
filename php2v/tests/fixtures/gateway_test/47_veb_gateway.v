module main

import rt

pub fn run_47_veb_gateway() rt.PhpVal {
	mut var_user := if !(rt.get_superglobal('_GET').array_get(rt.new_string('user'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('user'))
	} else {
		rt.new_string('anonymous')
	}
	mut var_method := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))
	} else {
		rt.new_string('GET')
	}
	rt.print_str('Hello, ' + var_user.str() + '! Method is ' + var_method.str())
	return rt.new_null()
}

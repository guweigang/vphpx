import rt

fn readonly(var_readonly_value rt.PhpVal, current bool, display bool) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('5.9.0'), rt.new_string('wp_readonly()')])
	return rt.call_function('wp_readonly', [var_readonly_value.dup(),
		rt.new_bool(current), rt.new_bool(display)])
}

pub fn init_wp_includes_php_compat_readonly_php() {
}

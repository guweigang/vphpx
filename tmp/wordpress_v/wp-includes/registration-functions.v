import rt

pub fn init_wp_includes_registration_functions_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('2.1.0'),
		rt.new_string(''),
		rt.call_function('__', [rt.new_string('This file no longer needs to be included.')]),
	])
}

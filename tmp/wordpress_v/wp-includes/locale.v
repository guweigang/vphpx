import rt

pub fn init_wp_includes_locale_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('4.7.0'),
	])
}

import rt

pub fn init_wp_includes_spl_autoload_compat_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('5.3.0'),
		rt.new_string(''),
		rt.new_string('SPL can no longer be disabled as of PHP 5.3.'),
	])
}

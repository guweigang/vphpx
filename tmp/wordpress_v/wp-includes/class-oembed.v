import rt

pub fn init_wp_includes_class_oembed_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('5.3.0'),
		(rt.get_constant('WPINC')).str() + '/class-wp-oembed.php',
	])
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-oembed.php',
		'4')
}

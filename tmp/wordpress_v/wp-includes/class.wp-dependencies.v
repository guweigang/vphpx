import rt

pub fn init_wp_includes_class_wp_dependencies_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('6.1.0'),
		(rt.get_constant('WPINC')).str() + '/class-wp-dependencies.php',
	])
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-dependencies.php',
		'4')
}

import rt

pub fn init_wp_includes_session_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('4.7.0'),
	])
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-session-tokens.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-user-meta-session-tokens.php',
		'4')
}

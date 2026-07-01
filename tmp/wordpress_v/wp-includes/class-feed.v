import rt

pub fn init_wp_includes_class_feed_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('4.7.0'),
		rt.new_string('fetch_feed()'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('SimplePie\\SimplePie'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-simplepie.php',
			'4')
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-feed-cache.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-feed-cache-transient.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-simplepie-file.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-simplepie-sanitize-kses.php',
		'4')
}

import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('4.7.0'),
		rt.new_string('class-wp-upgrader.php'),
	])
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader-skin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-upgrader-skin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-upgrader-skin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-plugin-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-bulk-theme-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-plugin-installer-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-theme-installer-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-language-pack-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-automatic-upgrader-skin.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-ajax-upgrader-skin.php',
		'4')
}

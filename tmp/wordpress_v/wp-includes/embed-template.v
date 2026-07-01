import rt

pub fn init_wp_includes_embed_template_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('4.5.0'),
		(rt.get_constant('WPINC')).str() + '/theme-compat/embed.php',
	])
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/theme-compat/embed.php',
		'3')
}

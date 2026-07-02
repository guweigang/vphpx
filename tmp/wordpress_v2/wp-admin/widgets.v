import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/widgets.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('widgets'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('The theme you are currently using is not widget-aware, meaning that it has no sidebars that you are able to change. For information on making your theme widget-aware, please <a href="https://developer.wordpress.org/themes/functionality/widgets/">follow these instructions</a>.'),
			]),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Widgets')])
	mut var_parent_file := 'themes.php'
	if rt.is_true(rt.call_function('wp_use_widgets_block_editor', []rt.PhpVal{})) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/widgets-form-blocks.php',
			'3')
	} else {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/widgets-form.php', '3')
	}
}

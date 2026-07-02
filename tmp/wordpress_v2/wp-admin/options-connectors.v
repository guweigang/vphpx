import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage connectors on this site.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WordPress\\AiClient\\AiClient')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_options_connectors_wp_admin_render_page')]))))) {
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('Connectors are not available.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The Connectors page requires build files. Please run <code>npm install</code> to build the necessary files.')])).str() +
				'</p>'),
			rt.new_int(503),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Connectors')])
	mut var_parent_file := 'options-general.php'
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.call_function('wp_options_connectors_wp_admin_render_page', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

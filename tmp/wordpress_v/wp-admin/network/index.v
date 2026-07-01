import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/dashboard.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_network'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to access this page.'),
			]),
			rt.new_int(403),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Dashboard')])
	mut var_parent_file := 'index.php'
	mut var_overview := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Welcome to your Network Admin. This area of the Administration Screens is used for managing all aspects of your Multisite Network.')])).str() +
		'</p>')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_overview }]),
	])
	mut var_quick_tasks := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('The Right Now widget on this screen provides current user and site counts on your network.')])).str() +
		'</p>')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'quick-tasks' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Quick Tasks'),
			]) }, rt.ArrayItem{ key: 'content', val: var_quick_tasks }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		'<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/">Documentation on the Network Admin</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() +
			'</p>',
	])
	rt.call_function('wp_dashboard_setup', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('dashboard')])
	rt.call_function('wp_enqueue_script', [rt.new_string('plugin-install')])
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dashboard', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_community_events_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

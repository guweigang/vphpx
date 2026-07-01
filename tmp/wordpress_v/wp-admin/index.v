import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/dashboard.php', '4')
	rt.call_function('wp_dashboard_setup', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('dashboard')])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('plugin-install')])
		rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('media-upload')])
	}
	rt.call_function('add_thickbox', []rt.PhpVal{})
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Dashboard')])
	mut var_parent_file := 'index.php'
	mut var_help := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Welcome to your WordPress Dashboard!')])).str() + '</p>')
	// unsupported expression: Expr_AssignOp_Concat
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_help }])])
	var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The left-hand navigation menu provides links to all of the WordPress administration screens, with submenu items displayed on hover. You can minimize this menu to a narrow icon strip by clicking on the Collapse Menu arrow at the bottom.')])).str() + '</p>')
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(var_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'help-navigation' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Navigation')]) }, rt.ArrayItem{ key: 'content', val: var_help }])])
	var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can use the following controls to arrange your Dashboard screen to suit your workflow. This is true on most other administration screens as well.')])).str() + '</p>')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(var_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'help-layout' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Layout')]) }, rt.ArrayItem{ key: 'content', val: var_help }])])
	var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The boxes on your Dashboard screen are:')])).str() + '</p>')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_site_health_checks')])) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(var_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'help-content' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Content')]) }, rt.ArrayItem{ key: 'content', val: var_help }])])
	var_help = rt.new_null()
	mut var_wp_version := rt.call_function('get_bloginfo', [rt.new_string('version'), rt.new_string('display')])
	mut var_wp_version_text := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s')]), var_wp_version.dup()])
	mut var_is_dev_version := rt.call_function('preg_match', [rt.new_string('/alpha|beta|RC/'), var_wp_version.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dev_version)))) {
		mut var_version_url := rt.call_function('sprintf', [rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/')])]), rt.call_function('sanitize_title', [var_wp_version.dup()])])
		var_wp_version_text = rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'), var_version_url.dup(), var_wp_version_text.dup()])
	}
	rt.call_method(var_screen, 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/dashboard-screen/">Documentation on Dashboard</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>' + '<p>' + (var_wp_version_text).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('admin_email_remind_later'))) {
		mut var_remind_interval := // unsupported expression: Expr_Cast_Int
		mut var_postponed_time := rt.call_function('get_option', [rt.new_string('admin_email_lifespan')])
		mut var_time_passed := rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.sub(var_postponed_time, var_remind_interval))
		if rt.is_true(rt.less(var_time_passed, rt.get_constant('MINUTE_IN_SECONDS'))) {
			mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The admin email verification page will reappear after %s.')]), rt.call_function('human_time_diff', [rt.add(rt.call_function('time', []rt.PhpVal{}), var_remind_interval)])])
			rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('has_action', [rt.new_string('welcome_panel')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])))) {
		mut var_classes := 'welcome-panel'
		mut var_option := // unsupported expression: Expr_Cast_Int
		mut var_hide := rt.is_true(rt.identical(rt.new_int(0), var_option)) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(2), var_option)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
		if var_hide {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_classes).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('welcome-panel-nonce'), rt.new_string('welcomepanelnonce'), rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('?welcome=0')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Dismiss the welcome panel')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Dismiss')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('welcome_panel')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dashboard', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_community_events_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

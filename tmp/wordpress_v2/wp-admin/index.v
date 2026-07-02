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
	mut var_help := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Welcome to your WordPress Dashboard!')])).str() +
		'</p>')
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('The Dashboard is the first place you will come to every time you log into your site. It is where you will find all your WordPress tools. If you need help, just click the &#8220;Help&#8221; tab above the screen title.')])).str() +
		'</p>'))
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
	])
	var_help = rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('The left-hand navigation menu provides links to all of the WordPress administration screens, with submenu items displayed on hover. You can minimize this menu to a narrow icon strip by clicking on the Collapse Menu arrow at the bottom.')])).str() +
		'</p>')
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Links in the Toolbar at the top of the screen connect your dashboard and the front end of your site, and provide access to your profile and helpful WordPress information.')])).str() +
		'</p>'))
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'help-navigation' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Navigation'),
			]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
	])
	var_help = rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('You can use the following controls to arrange your Dashboard screen to suit your workflow. This is true on most other administration screens as well.')])).str() +
		'</p>')
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<strong>Screen Options</strong> &mdash; Use the Screen Options tab to choose which Dashboard boxes to show.')])).str() +
		'</p>'))
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<strong>Drag and Drop</strong> &mdash; To rearrange the boxes, drag and drop by clicking on the title bar of the selected box and releasing when you see a gray dotted-line rectangle appear in the location you want to place the box.')])).str() +
		'</p>'))
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<strong>Box Controls</strong> &mdash; Click the title bar of the box to expand or collapse it. Some boxes added by plugins may have configurable content, and will show a &#8220;Configure&#8221; link in the title bar if you hover over it.')])).str() +
		'</p>'))
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'help-layout' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Layout'),
			]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
	])
	var_help = rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('The boxes on your Dashboard screen are:')])).str() +
		'</p>')
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	]))
	{
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Welcome</strong> &mdash; Shows links for some of the most common tasks when setting up a new site.')])).str() +
			'</p>'))
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('view_site_health_checks'),
	]))
	{
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Site Health Status</strong> &mdash; Informs you of any potential issues that should be addressed to improve the performance or security of your website.')])).str() +
			'</p>'))
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<strong>At a Glance</strong> &mdash; Displays a summary of the content on your site and identifies which theme and version of WordPress you are using.')])).str() +
			'</p>'))
	}
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('<strong>Activity</strong> &mdash; Shows the upcoming scheduled posts, recently published posts, and the most recent comments on your posts and allows you to moderate them.')])).str() +
		'</p>'))
	if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string("<strong>Quick Draft</strong> &mdash; Allows you to create a new post and save it as a draft. Also displays links to the 3 most recent draft posts you've started.")])).str() +
			'</p>'))
	}
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>WordPress Events and News</strong> &mdash; Upcoming events near you as well as the latest news from the official WordPress project and the <a href="%s">WordPress Planet</a>.')]), rt.call_function('__', [rt.new_string('https://planet.wordpress.org/')])])).str() +
		'</p>'))
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'help-content' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Content'),
			]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
	])
	var_help = rt.new_null()
	mut var_wp_version := rt.call_function('get_bloginfo', [rt.new_string('version'),
		rt.new_string('display')])
	mut var_wp_version_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Version %s')]),
		var_wp_version.clone(),
	])
	mut var_is_dev_version := rt.call_function('preg_match', [
		rt.new_string('/alpha|beta|RC/'),
		var_wp_version.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dev_version)))) {
		mut var_version_url := rt.call_function('sprintf', [
			rt.call_function('esc_url', [
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/'),
				]),
			]),
			rt.call_function('sanitize_title', [
				var_wp_version.clone(),
			]),
		])
		var_wp_version_text = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s">%2$s</a>'),
			var_version_url.clone(),
			var_wp_version_text.clone(),
		])
	}
	rt.call_method(var_screen, 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/dashboard-screen/">Documentation on Dashboard</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>' + '<p>' + var_wp_version_text.str() + '</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('admin_email_remind_later')))) {
		mut var_remind_interval := rt.new_int((rt.call_function('apply_filters', [
			rt.new_string('admin_email_remind_interval'),
			rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS')),
		])).to_i64())
		mut var_postponed_time := rt.call_function('get_option', [
			rt.new_string('admin_email_lifespan'),
		])
		mut var_time_passed := rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.sub(var_postponed_time,
			var_remind_interval))
		if rt.is_true(rt.less(var_time_passed, rt.get_constant('MINUTE_IN_SECONDS'))) {
			mut var_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The admin email verification page will reappear after %s.'),
				]),
				rt.call_function('human_time_diff', [
					rt.add(rt.call_function('time', []rt.PhpVal{}), var_remind_interval),
				]),
			])
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
					rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('welcome_panel')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
		mut var_classes := 'welcome-panel'
		mut var_option := rt.new_int((rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('show_welcome_panel'),
			rt.new_bool(true),
		])).to_i64())
		mut var_hide := rt.is_true(rt.identical(rt.new_int(0), var_option))
			|| rt.is_true(rt.identical(rt.new_int(2), var_option))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'user_email'), rt.call_function('get_option', [rt.new_string('admin_email')])))))
		if var_hide {
			var_classes = var_classes + ' hidden'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_classes.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('welcome-panel-nonce'),
			rt.new_string('welcomepanelnonce'), rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('?welcome=0')]),
		]))
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

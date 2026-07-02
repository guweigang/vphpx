import rt

fn _wp_admin_bar_init() bool {
	mut var_admin_bar_class := rt.new_null()
	mut var_wp_admin_bar := rt.new_null()
	if !(is_admin_bar_showing()) {
		return false
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-admin-bar.php',
		'4')
	var_admin_bar_class = rt.call_function('apply_filters', [
		rt.new_string('wp_admin_bar_class'),
		rt.new_string('WP_Admin_Bar'),
	])
	if rt.is_true(rt.call_function('class_exists', [var_admin_bar_class.clone()])) {
		var_wp_admin_bar = rt.create_object_dynamically(var_admin_bar_class, []rt.PhpVal{})
	} else {
		return false
	}
	rt.call_method(var_wp_admin_bar, 'initialize', []rt.PhpVal{})
	rt.call_method(var_wp_admin_bar, 'add_menus', []rt.PhpVal{})
	return true
}

fn wp_admin_bar_render() {
	mut var_wp_admin_bar := rt.new_null()
	mut var_rendered := false
	if var_rendered {
		return
	}
	if !(is_admin_bar_showing()) || !(var_wp_admin_bar.clone().is_object()) {
		return
	}
	rt.call_function('do_action_ref_array', [rt.new_string('admin_bar_menu'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_wp_admin_bar }])])
	rt.call_function('do_action', [rt.new_string('wp_before_admin_bar_render')])
	rt.call_method(var_wp_admin_bar, 'render', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('wp_after_admin_bar_render')])
	var_rendered = true
}

fn wp_admin_bar_wp_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_about_url := rt.new_null()
	mut var_contribute_url := rt.new_null()
	mut var_wp_logo_menu_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read')])) {
		var_about_url = rt.call_function('self_admin_url', [rt.new_string('about.php')])
		var_contribute_url = rt.call_function('self_admin_url', [
			rt.new_string('contribute.php'),
		])
	} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_about_url = rt.call_function('get_dashboard_url', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('about.php'),
		])
		var_contribute_url = rt.call_function('get_dashboard_url', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('contribute.php'),
		])
	} else {
		var_about_url = rt.new_bool(false)
		var_contribute_url = rt.new_bool(false)
	}
	var_wp_logo_menu_args = {
		'id':    rt.new_string('wp-logo')
		'title':
			'<span class="ab-icon" aria-hidden="true"></span><span class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('About WordPress')])).str() + '</span>'
		'href':  var_about_url
		'meta':  {
			'menu_title': rt.call_function('__', [rt.new_string('About WordPress')])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_about_url)))) {
		var_wp_logo_menu_args['meta'] = rt.create_array([
			rt.ArrayItem{ key: 'tabindex', val: 0 },
		])
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array_from_native_map(var_wp_logo_menu_args),
	])
	if rt.is_true(var_about_url) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo' },
				rt.ArrayItem{ key: 'id', val: 'about' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('About WordPress'),
				]) }, rt.ArrayItem{ key: 'href', val: var_about_url }]),
		])
	}
	if rt.is_true(var_contribute_url) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo' },
				rt.ArrayItem{ key: 'id', val: 'contribute' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Get Involved'),
				]) }, rt.ArrayItem{ key: 'href', val: var_contribute_url }]),
		])
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo-external' },
			rt.ArrayItem{ key: 'id', val: 'wporg' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WordPress.org'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('__', [
				rt.new_string('https://wordpress.org/'),
			]) }]),
	])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo-external' },
			rt.ArrayItem{ key: 'id', val: 'documentation' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Documentation'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('__', [
				rt.new_string('https://wordpress.org/documentation/'),
			]) }]),
	])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo-external' },
			rt.ArrayItem{ key: 'id', val: 'learn' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Learn WordPress'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('__', [
				rt.new_string('https://learn.wordpress.org/'),
			]) }]),
	])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo-external' },
			rt.ArrayItem{ key: 'id', val: 'support-forums' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Support'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('__', [
				rt.new_string('https://wordpress.org/support/forums/'),
			]) }]),
	])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo-external' },
			rt.ArrayItem{ key: 'id', val: 'feedback' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Feedback'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('__', [
				rt.new_string('https://wordpress.org/support/forum/requests-and-feedback'),
			]) }]),
	])
}

fn wp_admin_bar_sidebar_toggle(var_wp_admin_bar rt.PhpVal) {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'menu-toggle' },
				rt.ArrayItem{ key: 'title', val:
					'<span class="ab-icon" aria-hidden="true"></span><span class="screen-reader-text">' +
					(rt.call_function('__', [rt.new_string('Menu')])).str() + '</span>' },
				rt.ArrayItem{ key: 'href', val: '#' }]),
		])
	}
}

fn wp_admin_bar_my_account_item(var_wp_admin_bar rt.PhpVal) {
	mut var_user_id := rt.new_null()
	mut var_profile_url := rt.new_null()
	mut var_howdy := rt.new_null()
	mut var_avatar := rt.new_null()
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read')])) {
		var_profile_url = rt.call_function('get_edit_profile_url', [
			var_user_id.clone()])
	} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_profile_url = rt.call_function('get_dashboard_url', [
			var_user_id.clone(), rt.new_string('profile.php')])
	} else {
		var_profile_url = rt.new_bool(false)
	}
	var_howdy = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Howdy, %s')]),
		rt.new_string('<span class="display-name">' +
			(rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'display_name')).str() +
			'</span>'),
	])
	var_avatar = rt.call_function('get_avatar', [var_user_id.clone(),
		rt.new_int(26)])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'my-account' },
			rt.ArrayItem{ key: 'parent', val: 'top-secondary' },
			rt.ArrayItem{ key: 'title', val: var_howdy.str() + var_avatar.str() },
			rt.ArrayItem{ key: 'href', val: var_profile_url },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: if !rt.is_true(var_avatar) { '' } else { 'with-avatar' }
				},
				rt.ArrayItem{ key: 'menu_title', val: rt.call_function('wp_strip_all_tags', [
					var_howdy.clone(),
				]) },
				rt.ArrayItem{
					key: 'tabindex'
					val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
						var_profile_url))))
					{
						rt.new_string('')
					} else {
						rt.new_int(0)
					}
				},
			]) }]),
	])
}

fn wp_admin_bar_my_account_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_user_id := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_profile_url := rt.new_null()
	mut var_user_info := rt.new_null()
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read')])) {
		var_profile_url = rt.call_function('get_edit_profile_url', [
			var_user_id.clone()])
	} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_profile_url = rt.call_function('get_dashboard_url', [
			var_user_id.clone(), rt.new_string('profile.php')])
	} else {
		var_profile_url = rt.new_bool(false)
	}
	rt.call_method(var_wp_admin_bar, 'add_group', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'my-account' },
			rt.ArrayItem{ key: 'id', val: 'user-actions' }]),
	])
	var_user_info = rt.call_function('get_avatar', [var_user_id.clone(),
		rt.new_int(64)])
	var_user_info = rt.concat(var_user_info, rt.concat(rt.concat(rt.new_string("<span class='display-name'>"), rt.get_property(var_current_user,
		'display_name')), rt.new_string('</span>')))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_current_user,
		'display_name'), rt.get_property(var_current_user, 'user_login')))))
	{
		var_user_info = rt.concat(var_user_info, rt.concat(rt.concat(rt.new_string("<span class='username'>"), rt.get_property(var_current_user,
			'user_login')), rt.new_string('</span>')))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_profile_url)))) {
		var_user_info = rt.concat(var_user_info, rt.new_string(
			"<span class='display-name edit-profile'>" +
			(rt.call_function('__', [rt.new_string('Edit Profile')])).str() + '</span>'))
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'user-actions' },
			rt.ArrayItem{ key: 'id', val: 'user-info' }, rt.ArrayItem{
				key: 'title'
				val: var_user_info
			}, rt.ArrayItem{ key: 'href', val: var_profile_url }]),
	])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'user-actions' },
			rt.ArrayItem{ key: 'id', val: 'logout' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Log Out'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('wp_logout_url', []rt.PhpVal{}) }]),
	])
}

fn wp_admin_bar_site_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_blogname := rt.new_null()
	mut var_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network')]))))) {
		return
	}
	var_blogname = rt.call_function('get_bloginfo', [rt.new_string('name')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blogname)))) {
		var_blogname = rt.call_function('preg_replace', [
			rt.new_string('#^(https?://)?(www\\.)?#'),
			rt.new_string(''),
			rt.call_function('get_home_url', []rt.PhpVal{}),
		])
	}
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		var_blogname = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Network Admin: %s')]),
			rt.call_function('esc_html', [
				rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
			]),
		])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		var_blogname = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('User Dashboard: %s')]),
			rt.call_function('esc_html', [
				rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
			]),
		])
	}
	var_title = rt.call_function('wp_html_excerpt', [var_blogname.clone(),
		rt.new_int(40), rt.new_string('&hellip;')])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'site-name' },
			rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{
				key: 'href'
				val: if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read')]))))) { rt.call_function('home_url', [
						rt.new_string('/'),
					]) } else { rt.call_function('admin_url', []rt.PhpVal{}) }
			}, rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'menu_title', val: var_title },
			]) }]),
	])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'site-name' },
				rt.ArrayItem{ key: 'id', val: 'view-site' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Visit Site'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('home_url', [
					rt.new_string('/'),
				]) }]),
		])
		if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_sites')])) {
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'site-name' },
					rt.ArrayItem{ key: 'id', val: 'edit-site' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Manage Site'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
						rt.new_string('site-info.php?id=' +
							(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()),
					]) }]),
			])
		}
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('read')]))
	{
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'site-name' },
				rt.ArrayItem{ key: 'id', val: 'dashboard' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Dashboard'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', []rt.PhpVal{}) }]),
		])
		wp_admin_bar_appearance_menu(var_wp_admin_bar.clone())
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('activate_plugins'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'site-name' },
					rt.ArrayItem{ key: 'id', val: 'plugins' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Plugins'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
						rt.new_string('plugins.php'),
					]) }]),
			])
		}
	}
}

fn wp_admin_bar_edit_site_menu(var_wp_admin_bar rt.PhpVal) {
	mut var__wp_current_template_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])))))
		|| rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		return
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'site-editor' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Edit Site'),
			]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'postType', val: 'wp_template' },
					rt.ArrayItem{ key: 'postId', val: var__wp_current_template_id },
					rt.ArrayItem{ key: 'canvas', val: 'edit' }]),
				rt.call_function('admin_url', [rt.new_string('site-editor.php')]),
			]) }]),
	])
}

fn wp_admin_bar_customize_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_wp_customize := rt.new_null()
	mut var_current_url := rt.new_null()
	mut var_customize_url := rt.new_null()
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('customize_register')]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])))))
		|| rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_wp_customize, 'changeset_post_id', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'edit_post'), rt.call_method(var_wp_customize, 'changeset_post_id', []rt.PhpVal{})]))))) {
		return
	}
	var_current_url = rt.new_string((
		if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https://' } else { 'http://' } +
		(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
		(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()).str())
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_wp_customize, 'changeset_uuid', []rt.PhpVal{})) {
		var_current_url = rt.call_function('remove_query_arg', [
			rt.new_string('customize_changeset_uuid'),
			var_current_url.clone(),
		])
	}
	var_customize_url = rt.call_function('add_query_arg', [rt.new_string('url'),
		rt.call_function('urlencode', [var_current_url.clone()]),
		rt.call_function('wp_customize_url', []rt.PhpVal{})])
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		var_customize_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'changeset_uuid', val: rt.call_method(var_wp_customize,
					'changeset_uuid', []rt.PhpVal{}) },
			]),
			var_customize_url.clone(),
		])
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'customize' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Customize'),
			]) }, rt.ArrayItem{ key: 'href', val: var_customize_url },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: 'hide-if-no-customize' },
			]) }]),
	])
	rt.call_function('add_action', [rt.new_string('wp_before_admin_bar_render'),
		rt.new_string('wp_customize_support_script')])
}

fn wp_admin_bar_my_sites_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_my_sites_url := rt.new_null()
	mut var_show_site_icons := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_blavatar := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_menu_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return
	}
	if rt.get_property(rt.get_property(var_wp_admin_bar, 'user'), 'blogs').array_count() < 1
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network')]))))) {
		return
	}
	if rt.is_true(rt.get_property(rt.get_property(var_wp_admin_bar, 'user'), 'active_blog')) {
		var_my_sites_url = rt.call_function('get_admin_url', [
			rt.get_property(rt.get_property(rt.get_property(var_wp_admin_bar, 'user'),
				'active_blog'), 'blog_id'),
			rt.new_string('my-sites.php'),
		])
	} else {
		var_my_sites_url = rt.call_function('admin_url', [rt.new_string('my-sites.php')])
	}
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'my-sites' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('My Sites'),
			]) }, rt.ArrayItem{ key: 'href', val: var_my_sites_url }]),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network')])) {
		rt.call_method(var_wp_admin_bar, 'add_group', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'my-sites' },
				rt.ArrayItem{ key: 'id', val: 'my-sites-super-admin' }]),
		])
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'my-sites-super-admin' },
				rt.ArrayItem{ key: 'id', val: 'network-admin' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Network Admin'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url',
					[]rt.PhpVal{}) }]),
		])
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'network-admin' },
				rt.ArrayItem{ key: 'id', val: 'network-admin-d' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Dashboard'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url',
					[]rt.PhpVal{}) }]),
		])
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_sites'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'network-admin' },
					rt.ArrayItem{ key: 'id', val: 'network-admin-s' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Sites'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
						rt.new_string('sites.php'),
					]) }]),
			])
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_users'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'network-admin' },
					rt.ArrayItem{ key: 'id', val: 'network-admin-u' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Users'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
						rt.new_string('users.php'),
					]) }]),
			])
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_themes'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'network-admin' },
					rt.ArrayItem{ key: 'id', val: 'network-admin-t' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Themes'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
						rt.new_string('themes.php'),
					]) }]),
			])
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_plugins'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'network-admin' },
					rt.ArrayItem{ key: 'id', val: 'network-admin-p' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Plugins'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
						rt.new_string('plugins.php'),
					]) }]),
			])
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_options'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'network-admin' },
					rt.ArrayItem{ key: 'id', val: 'network-admin-o' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Settings'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
						rt.new_string('settings.php'),
					]) }]),
			])
		}
	}
	rt.call_method(var_wp_admin_bar, 'add_group', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'my-sites' },
			rt.ArrayItem{ key: 'id', val: 'my-sites-list' }, rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{
					key: 'class'
					val: if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('manage_network'),
					]))
					{ 'ab-sub-secondary' } else { '' }
				},
			]) }]),
	])
	var_show_site_icons = rt.call_function('apply_filters', [
		rt.new_string('wp_admin_bar_show_site_icons'),
		rt.new_bool(true),
	])
	mut iter_1 :=
		rt.cast_array(rt.get_property(rt.get_property(var_wp_admin_bar, 'user'), 'blogs')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_blog_shadow := item_1.val
		rt.call_function('switch_to_blog', [
			rt.get_property(var_blog_shadow, 'userblog_id'),
		])
		if rt.is_true(rt.identical(rt.new_bool(true), var_show_site_icons))
			&& rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) {
			var_blavatar = rt.call_function('sprintf', [
				rt.new_string('<img class="blavatar" src="%s" srcset="%s 2x" alt="" width="16" height="16"%s />'),
				rt.call_function('esc_url', [
					rt.call_function('get_site_icon_url', [rt.new_int(16)]),
				]),
				rt.call_function('esc_url', [
					rt.call_function('get_site_icon_url', [rt.new_int(32)]),
				]),
				rt.new_string((if rt.is_true(rt.call_function('wp_lazy_loading_enabled', [
					rt.new_string('img'),
					rt.new_string('site_icon_in_toolbar'),
				]))
				{ ' loading="lazy"' } else { '' }).str()),
			])
		} else {
			var_blavatar = rt.new_string('<div class="blavatar"></div>')
		}
		var_blogname = rt.get_property(var_blog_shadow, 'blogname')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_blogname)))) {
			var_blogname = rt.call_function('preg_replace', [
				rt.new_string('#^(https?://)?(www\\.)?#'),
				rt.new_string(''),
				rt.call_function('get_home_url', []rt.PhpVal{}),
			])
		}
		var_menu_id = rt.new_string('blog-' +
			(rt.get_property(var_blog_shadow, 'userblog_id')).str())
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read')])) {
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'my-sites-list' },
					rt.ArrayItem{ key: 'id', val: var_menu_id },
					rt.ArrayItem{ key: 'title', val: var_blavatar.str() + var_blogname.str() },
					rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', []rt.PhpVal{}) }]),
			])
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: var_menu_id },
					rt.ArrayItem{ key: 'id', val: var_menu_id.str() + '-d' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Dashboard'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url',
						[]rt.PhpVal{}) }]),
			])
		} else {
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: 'my-sites-list' },
					rt.ArrayItem{ key: 'id', val: var_menu_id },
					rt.ArrayItem{ key: 'title', val: var_blavatar.str() + var_blogname.str() },
					rt.ArrayItem{ key: 'href', val: rt.call_function('home_url', []rt.PhpVal{}) }]),
			])
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
				rt.new_string('post'),
			]), 'cap'), 'create_posts'),
		]))
		{
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: var_menu_id },
					rt.ArrayItem{ key: 'id', val: var_menu_id.str() + '-n' },
					rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
						rt.new_string('post'),
					]), 'labels'), 'new_item') }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
						rt.new_string('post-new.php'),
					]) }]),
			])
		}
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: var_menu_id },
					rt.ArrayItem{ key: 'id', val: var_menu_id.str() + '-c' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Manage Comments'),
					]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
						rt.new_string('edit-comments.php'),
					]) }]),
			])
		}
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: var_menu_id },
				rt.ArrayItem{ key: 'id', val: var_menu_id.str() + '-v' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Visit Site'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('home_url', [
					rt.new_string('/'),
				]) }]),
		])
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
}

fn wp_admin_bar_shortlink_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_short := rt.new_null()
	mut var_id := ''
	mut var_html := rt.new_null()
	var_short = rt.call_function('wp_get_shortlink', [rt.new_int(0),
		rt.new_string('query')])
	var_id = 'get-shortlink'
	if !rt.is_true(var_short) {
		return
	}
	var_html = rt.new_string(
		'<input class="shortlink-input" type="text" readonly="readonly" value="' +
		(rt.call_function('esc_attr', [var_short.clone()])).str() + '" aria-label="' +
		(rt.call_function('__', [rt.new_string('Shortlink')])).str() + '" />')
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: var_id },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shortlink'),
			]) }, rt.ArrayItem{ key: 'href', val: var_short },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: var_html },
			]) }]),
	])
}

fn wp_admin_bar_edit_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_tag := rt.new_null()
	mut var_wp_the_query := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_current_screen := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_preview_link := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_user_object := rt.new_null()
	mut var_view_link := rt.new_null()
	mut var_current_object := rt.new_null()
	mut var_edit_post_link := rt.new_null()
	mut var_edit_term_link := rt.new_null()
	mut var_edit_user_link := rt.new_null()
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		var_current_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
		var_post = rt.call_function('get_post', []rt.PhpVal{})
		var_post_type_object = rt.new_null()
		if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_current_screen,
			'base')))
		{
			var_post_type_object = rt.call_function('get_post_type_object', [
				rt.get_property(var_post, 'post_type'),
			])
		} else if rt.is_true(rt.identical(rt.new_string('edit'), rt.get_property(var_current_screen,
			'base')))
		{
			var_post_type_object = rt.call_function('get_post_type_object', [
				rt.get_property(var_current_screen, 'post_type'),
			])
		} else if
			rt.is_true(rt.identical(rt.new_string('edit-comments'), rt.get_property(var_current_screen, 'base')))
			&& rt.is_true(var_post_id) {
			var_post = rt.call_function('get_post', [var_post_id.clone()])
			if rt.is_true(var_post) {
				var_post_type_object = rt.call_function('get_post_type_object', [
					rt.get_property(var_post, 'post_type'),
				])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_current_screen, 'base')))
			|| rt.is_true(rt.identical(rt.new_string('edit-comments'), rt.get_property(var_current_screen, 'base')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('add'), rt.get_property(var_current_screen, 'action')))))
			&& rt.is_true(var_post_type_object)
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post, 'ID')]))
			&& rt.is_true(rt.get_property(var_post_type_object, 'public'))
			&& rt.is_true(rt.get_property(var_post_type_object, 'show_in_admin_bar')) {
			if rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post,
				'post_status')))
			{
				var_preview_link = rt.call_function('get_preview_post_link', [
					var_post.clone()])
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'preview' },
						rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_post_type_object,
							'labels'), 'view_item') }, rt.ArrayItem{ key: 'href', val: rt.call_function('esc_url', [
							var_preview_link.clone(),
						]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([
							rt.ArrayItem{ key: 'target', val: 'wp-preview-' +
								(rt.get_property(var_post, 'ID')).str() },
						]) }]),
				])
			} else {
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'view' },
						rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_post_type_object,
							'labels'), 'view_item') }, rt.ArrayItem{ key: 'href', val: rt.call_function('get_permalink', [
							rt.get_property(var_post, 'ID'),
						]) }]),
				])
			}
		} else if
			rt.is_true(rt.identical(rt.new_string('edit'), rt.get_property(var_current_screen, 'base')))
			&& rt.is_true(var_post_type_object)
			&& rt.is_true(rt.get_property(var_post_type_object, 'public'))
			&& rt.is_true(rt.get_property(var_post_type_object, 'show_in_admin_bar'))
			&& rt.is_true(rt.call_function('get_post_type_archive_link', [rt.get_property(var_post_type_object, 'name')]))
			&& !(rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post_type_object, 'name')))
			&& rt.is_true(rt.identical(rt.new_string('posts'), rt.call_function('get_option', [rt.new_string('show_on_front')])))) {
			rt.call_method(var_wp_admin_bar, 'add_node', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'archive' },
					rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_post_type_object,
						'labels'), 'view_items') }, rt.ArrayItem{ key: 'href', val: rt.call_function('get_post_type_archive_link', [
						rt.get_property(var_current_screen, 'post_type'),
					]) }]),
			])
		} else if
			rt.is_true(rt.identical(rt.new_string('term'), rt.get_property(var_current_screen, 'base')))
			&& !var_tag.is_null() && var_tag.clone().is_object()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()]))))) {
			var_tax = rt.call_function('get_taxonomy', [
				rt.get_property(var_tag, 'taxonomy'),
			])
			if rt.is_true(rt.call_function('is_term_publicly_viewable', [
				var_tag.clone()]))
			{
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'view' },
						rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_tax,
							'labels'), 'view_item') }, rt.ArrayItem{ key: 'href', val: rt.call_function('get_term_link', [
							var_tag.clone(),
						]) }]),
				])
			}
		} else if
			rt.is_true(rt.identical(rt.new_string('user-edit'), rt.get_property(var_current_screen, 'base')))
			&& !var_user_id.is_null() {
			var_user_object = rt.call_function('get_userdata', [
				var_user_id.clone()])
			var_view_link = rt.call_function('get_author_posts_url', [
				rt.get_property(var_user_object, 'ID'),
			])
			if rt.is_true(rt.call_method(var_user_object, 'exists', []rt.PhpVal{}))
				&& rt.is_true(var_view_link) {
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'view' },
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('View User'),
						]) }, rt.ArrayItem{ key: 'href', val: var_view_link }]),
				])
			}
		}
	} else {
		var_current_object = rt.call_method(var_wp_the_query, 'get_queried_object', []rt.PhpVal{})
		if !rt.is_true(var_current_object) {
			return
		}
		if !(!rt.is_true(rt.get_property(var_current_object, 'post_type'))) {
			var_post_type_object = rt.call_function('get_post_type_object', [
				rt.get_property(var_current_object, 'post_type'),
			])
			var_edit_post_link = rt.call_function('get_edit_post_link', [
				rt.get_property(var_current_object, 'ID'),
			])
			if rt.is_true(var_post_type_object) && rt.is_true(var_edit_post_link)
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_current_object, 'ID')]))
				&& rt.is_true(rt.get_property(var_post_type_object, 'show_in_admin_bar')) {
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'edit' },
						rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_post_type_object,
							'labels'), 'edit_item') }, rt.ArrayItem{
							key: 'href'
							val: var_edit_post_link
						}]),
				])
			}
		} else if !(!rt.is_true(rt.get_property(var_current_object, 'taxonomy'))) {
			var_tax = rt.call_function('get_taxonomy', [
				rt.get_property(var_current_object, 'taxonomy'),
			])
			var_edit_term_link = rt.call_function('get_edit_term_link', [
				rt.get_property(var_current_object, 'term_id'),
				rt.get_property(var_current_object, 'taxonomy'),
			])
			if rt.is_true(var_tax) && rt.is_true(var_edit_term_link)
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), rt.get_property(var_current_object, 'term_id')])) {
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'edit' },
						rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_tax,
							'labels'), 'edit_item') }, rt.ArrayItem{
							key: 'href'
							val: var_edit_term_link
						}]),
				])
			}
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_current_object, 'WP_User')))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_current_object, 'ID')])) {
			var_edit_user_link = rt.call_function('get_edit_user_link', [
				rt.get_property(var_current_object, 'ID'),
			])
			if rt.is_true(var_edit_user_link) {
				rt.call_method(var_wp_admin_bar, 'add_node', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'edit' },
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Edit User'),
						]) }, rt.ArrayItem{ key: 'href', val: var_edit_user_link }]),
				])
			}
		}
	}
}

fn wp_admin_bar_command_palette_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_shortcut_labels := map[string]rt.PhpVal{}
	mut var_apple_pattern := ''
	mut var_is_apple_os := rt.new_null()
	mut var_shortcut_label := rt.new_null()
	mut var_title := rt.new_null()
	mut var_function := ''
	mut var_script := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [rt.new_string('wp-core-commands'), rt.new_string('enqueued')]))))) {
		return
	}
	var_shortcut_labels = {
		'appleOS': rt.call_function('_x', [rt.new_string('⌘K'),
			rt.new_string('keyboard shortcut to open the command palette')])
		'default': rt.call_function('_x', [rt.new_string('Ctrl+K'),
			rt.new_string('keyboard shortcut to open the command palette')])
	}
	var_apple_pattern = 'Macintosh|Mac OS X|Mac_PowerPC'
	var_is_apple_os = rt.new_bool((rt.call_function('preg_match', [
		rt.new_string('/${var_apple_pattern}/i'),
		if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))).is_null() {
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))
		} else {
			rt.new_string('')
		},
	])).to_bool())
	var_shortcut_label = if rt.is_true(var_is_apple_os) {
		var_shortcut_labels['appleOS']
	} else {
		var_shortcut_labels['default']
	}
	var_title = rt.call_function('sprintf', [
		rt.new_string('<span class="ab-icon" aria-hidden="true"></span><span class="ab-label"><kbd>%s</kbd><span class="screen-reader-text"> %s</span></span>'),
		var_shortcut_label.clone(),
		rt.call_function('__', [rt.new_string('Open command palette')]),
	])
	var_function = "\t( applePattern, appleOSLabel ) => {\n\t\tif ( ! ( new RegExp( applePattern, 'i' ) ).test( navigator.userAgent ) ) {\n\t\t\treturn;\n\t\t}\n\t\tconst kbd = document.querySelector( '#wp-admin-bar-command-palette .ab-label kbd' );\n\t\tif ( kbd ) {\n\t\t\tkbd.textContent = appleOSLabel;\n\t\t}\n\t}"
	var_script = rt.call_function('sprintf', [rt.new_string('( %s )( %s, %s );'),
		rt.new_string(var_function.str()).clone(),
		rt.call_function('wp_json_encode', [
			rt.new_string(var_apple_pattern.str()).clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES')),
		]),
		rt.call_function('wp_json_encode', [
			var_shortcut_labels['appleOS'],
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES')),
		])])
	var_script = rt.concat(var_script, rt.new_string('\n//# sourceURL=' +
		(rt.call_function('rawurlencode', [rt.new_string(@FN)])).str()))
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'command-palette' },
			rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'href', val: '#' },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: 'hide-if-no-js' },
				rt.ArrayItem{
					key: 'onclick'
					val: 'wp.data.dispatch( "core/commands" ).open(); return false;'
				},
				rt.ArrayItem{ key: 'html', val: rt.call_function('wp_get_inline_script_tag', [
					var_script.clone(),
				]) },
			]) }]),
	])
}

fn wp_admin_bar_new_content_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_id := rt.new_null()
	mut var_actions := rt.new_null()
	mut var_cpts := rt.new_null()
	mut var_cpt := rt.new_null()
	mut var_key := rt.new_null()
	mut var_title := rt.new_null()
	mut var_action := rt.new_null()
	mut var_link := rt.new_null()
	var_actions = rt.new_array()
	var_cpts = rt.cast_array(rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_admin_bar', val: true }]),
		rt.new_string('objects'),
	]))
	if var_cpts.array_isset(rt.new_string('post'))
		&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_cpts.array_get(rt.new_string('post')), 'cap'), 'create_posts')])) {
		var_actions.array_set('post-new.php', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_cpts.array_get(rt.new_string('post')),
				'labels'), 'name_admin_bar') },
			rt.ArrayItem{ key: none, val: 'new-post' },
		]))
	}
	if var_cpts.array_isset(rt.new_string('attachment'))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		var_actions.array_set('media-new.php', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_cpts.array_get(rt.new_string('attachment')),
				'labels'), 'name_admin_bar') },
			rt.ArrayItem{ key: none, val: 'new-media' },
		]))
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_links')])) {
		var_actions.array_set('link-add.php', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Link'), rt.new_string('add new from admin bar')]) },
			rt.ArrayItem{ key: none, val: 'new-link' },
		]))
	}
	if var_cpts.array_isset(rt.new_string('page'))
		&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_cpts.array_get(rt.new_string('page')), 'cap'), 'create_posts')])) {
		var_actions.array_set('post-new.php?post_type=page', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_cpts.array_get(rt.new_string('page')),
				'labels'), 'name_admin_bar') },
			rt.ArrayItem{ key: none, val: 'new-page' },
		]))
	}
	var_cpts.array_unset(rt.new_string('post'))
	var_cpts.array_unset(rt.new_string('page'))
	var_cpts.array_unset(rt.new_string('attachment'))
	mut iter_2 := var_cpts.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_cpt_shadow := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_cpt_shadow, 'cap'), 'create_posts'),
		])))))
		{
			continue
		}
		var_key = rt.new_string('post-new.php?post_type=' +
			(rt.get_property(var_cpt_shadow, 'name')).str())
		var_actions.array_set(var_key, rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_cpt_shadow, 'labels'),
				'name_admin_bar') },
			rt.ArrayItem{ key: none, val: 'new-' + (rt.get_property(var_cpt_shadow, 'name')).str() },
		]))
	}
	if var_actions.array_isset(rt.new_string('post-new.php?post_type=content')) {
		var_actions.array_get_mut('post-new.php?post_type=content').array_set(1, 'add-new-content')
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')]))
		|| (rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))) {
		var_actions.array_set('user-new.php', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('User'), rt.new_string('add new from admin bar')]) },
			rt.ArrayItem{ key: none, val: 'new-user' },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actions)))) {
		return
	}
	var_title = rt.new_string(
		'<span class="ab-icon" aria-hidden="true"></span><span class="ab-label">' +
		(rt.call_function('_x', [rt.new_string('New'), rt.new_string('admin bar menu group label')])).str() +
		'</span>')
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'new-content' },
			rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
				rt.call_function('current', [rt.func_array_keys(var_actions.clone())]),
			]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'menu_title', val: rt.call_function('_x', [
					rt.new_string('New'), rt.new_string('admin bar menu group label')]) },
			]) }]),
	])
	mut iter_3 := var_actions.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_action_shadow := item_3.val
		mut var_link_shadow := item_3.key
		mut list_tmp_1 := var_action_shadow
		var_title = list_tmp_1.array_get(0)
		var_id = list_tmp_1.array_get(1)
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'new-content' },
				rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'title', val: var_title },
				rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
					var_link_shadow.clone(),
				]) }]),
		])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_sites')])) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'new-content' },
				rt.ArrayItem{ key: 'id', val: 'add-new-site' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
					rt.new_string('Site'),
					rt.new_string('add new from admin bar'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
					rt.new_string('site-new.php'),
				]) }]),
		])
	}
}

fn wp_admin_bar_comments_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_awaiting_mod := rt.new_null()
	mut var_awaiting_text := rt.new_null()
	mut var_icon := ''
	mut var_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return
	}
	var_awaiting_mod = rt.call_function('wp_count_comments', []rt.PhpVal{})
	var_awaiting_mod = rt.get_property(var_awaiting_mod, 'moderated')
	var_awaiting_text = rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s Comment in moderation'),
			rt.new_string('%s Comments in moderation'), var_awaiting_mod.clone()]),
		rt.call_function('number_format_i18n', [var_awaiting_mod.clone()]),
	])
	var_icon = '<span class="ab-icon" aria-hidden="true"></span>'
	var_title = rt.new_string('<span class="ab-label awaiting-mod pending-count count-' +
		var_awaiting_mod.str() + '" aria-hidden="true">' +
		(rt.call_function('number_format_i18n', [var_awaiting_mod.clone()])).str() + '</span>')
	var_title = rt.concat(var_title, rt.new_string(
		'<span class="screen-reader-text comments-in-moderation-text">' + var_awaiting_text.str() +
		'</span>'))
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'comments' },
			rt.ArrayItem{ key: 'title', val: var_icon + var_title.str() },
			rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
				rt.new_string('edit-comments.php'),
			]) }]),
	])
}

fn wp_admin_bar_appearance_menu(var_wp_admin_bar rt.PhpVal) {
	rt.call_method(var_wp_admin_bar, 'add_group', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'site-name' },
			rt.ArrayItem{ key: 'id', val: 'appearance' }]),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'appearance' },
				rt.ArrayItem{ key: 'id', val: 'themes' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Themes'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
					rt.new_string('themes.php'),
				]) }]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		return
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('widgets')]))
	{
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'appearance' },
				rt.ArrayItem{ key: 'id', val: 'widgets' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Widgets'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
					rt.new_string('widgets.php'),
				]) }]),
		])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('menus')]))
		|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')])) {
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'appearance' },
				rt.ArrayItem{ key: 'id', val: 'menus' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Menus'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
					rt.new_string('nav-menus.php'),
				]) }]),
		])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-background'),
	]))
	{
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'appearance' },
				rt.ArrayItem{ key: 'id', val: 'background' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
					rt.new_string('Background'),
					rt.new_string('custom background'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
					rt.new_string('themes.php?page=custom-background'),
				]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([
					rt.ArrayItem{ key: 'class', val: 'hide-if-customize' },
				]) }]),
		])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
	]))
	{
		rt.call_method(var_wp_admin_bar, 'add_node', [
			rt.create_array([rt.ArrayItem{ key: 'parent', val: 'appearance' },
				rt.ArrayItem{ key: 'id', val: 'header' }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
					rt.new_string('Header'),
					rt.new_string('custom image header'),
				]) }, rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
					rt.new_string('themes.php?page=custom-header'),
				]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([
					rt.ArrayItem{ key: 'class', val: 'hide-if-customize' },
				]) }]),
		])
	}
}

fn wp_admin_bar_updates_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_update_data := rt.new_null()
	mut var_updates_text := rt.new_null()
	mut var_icon := ''
	mut var_title := rt.new_null()
	var_update_data = rt.call_function('wp_get_update_data', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('total')))))) {
		return
	}
	var_updates_text = rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s update available'),
			rt.new_string('%s updates available'), var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('total'))]),
		rt.call_function('number_format_i18n',
			[var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('total'))]),
	])
	var_icon = '<span class="ab-icon" aria-hidden="true"></span>'
	var_title = rt.new_string('<span class="ab-label" aria-hidden="true">' +
		(rt.call_function('number_format_i18n', [var_update_data.array_get(rt.new_string('counts')).array_get(rt.new_string('total'))])).str() +
		'</span>')
	var_title = rt.concat(var_title, rt.new_string(
		'<span class="screen-reader-text updates-available-text">' + var_updates_text.str() +
		'</span>'))
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'updates' },
			rt.ArrayItem{ key: 'title', val: var_icon + var_title.str() },
			rt.ArrayItem{ key: 'href', val: rt.call_function('network_admin_url', [
				rt.new_string('update-core.php'),
			]) }]),
	])
}

fn wp_admin_bar_search_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_form := rt.new_null()
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		return
	}
	var_form = rt.new_string('<form action="' +
		(rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])])).str() +
		'" method="get" id="adminbarsearch">')
	var_form = rt.concat(var_form,
		rt.new_string('<input class="adminbar-input" name="s" id="adminbar-search" type="text" value="" maxlength="150" />'))
	var_form = rt.concat(var_form, rt.new_string(
		'<label for="adminbar-search" class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Search')])).str() + '</label>'))
	var_form = rt.concat(var_form, rt.new_string(
		'<input type="submit" class="adminbar-button" value="' +
		(rt.call_function('__', [rt.new_string('Search')])).str() + '" />'))
	var_form = rt.concat(var_form, rt.new_string('</form>'))
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'top-secondary' },
			rt.ArrayItem{ key: 'id', val: 'search' }, rt.ArrayItem{ key: 'title', val: var_form },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: 'admin-bar-search' },
				rt.ArrayItem{ key: 'tabindex', val: -1 },
			]) }]),
	])
}

fn wp_admin_bar_recovery_mode_menu(var_wp_admin_bar rt.PhpVal) {
	mut var_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{}))))) {
		return
	}
	var_url = rt.call_function('wp_login_url', []rt.PhpVal{})
	var_url = rt.call_function('add_query_arg', [rt.new_string('action'),
		Class_WP_Recovery_Mode.exit_action(), var_url.clone()])
	var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
		Class_WP_Recovery_Mode.exit_action()])
	rt.call_method(var_wp_admin_bar, 'add_node', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'top-secondary' },
			rt.ArrayItem{ key: 'id', val: 'recovery-mode' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Exit Recovery Mode'),
			]) }, rt.ArrayItem{ key: 'href', val: var_url }]),
	])
}

fn wp_admin_bar_add_secondary_groups(var_wp_admin_bar rt.PhpVal) {
	rt.call_method(var_wp_admin_bar, 'add_group', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'top-secondary' },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: 'ab-top-secondary' },
			]) }]),
	])
	rt.call_method(var_wp_admin_bar, 'add_group', [
		rt.create_array([rt.ArrayItem{ key: 'parent', val: 'wp-logo' },
			rt.ArrayItem{ key: 'id', val: 'wp-logo-external' },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: 'ab-sub-secondary' },
			]) }]),
	])
}

fn wp_enqueue_admin_bar_header_styles() {
	mut var_action := ''
	var_action = if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		'admin_head'
	} else {
		'wp_head'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
		rt.new_string(var_action.str()).clone(), rt.new_string('wp_admin_bar_header')])))))
	{
		return
	}
	rt.call_function('remove_action', [rt.new_string(var_action.str()).clone(),
		rt.new_string('wp_admin_bar_header')])
	rt.call_function('wp_add_inline_style', [rt.new_string('admin-bar'),
		rt.new_string('@media print { #wpadminbar { display:none; } }')])
}

fn wp_enqueue_admin_bar_bump_styles() {
	mut var_admin_bar_args := rt.new_null()
	mut var_header_callback := rt.new_null()
	mut var_css := ''
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('admin-bar')]))
	{
		var_admin_bar_args = rt.call_function('get_theme_support', [
			rt.new_string('admin-bar'),
		])
		var_header_callback =
			var_admin_bar_args.array_get(rt.new_int(0)).array_get(rt.new_string('callback'))
	}
	if !rt.is_true(var_header_callback) {
		var_header_callback = rt.new_string('_admin_bar_bump_cb')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('_admin_bar_bump_cb'),
		var_header_callback))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
		rt.new_string('wp_head'),
		var_header_callback.clone(),
	])))))
	{
		return
	}
	rt.call_function('remove_action', [rt.new_string('wp_head'),
		var_header_callback.clone()])
	var_css = '\n\t\t@media screen { html { margin-top: 32px !important; } }\n\t\t@media screen and ( max-width: 782px ) { html { margin-top: 46px !important; } }\n\t'
	rt.call_function('wp_add_inline_style', [rt.new_string('admin-bar'),
		rt.new_string(var_css.str()).clone()])
}

fn show_admin_bar(var_show rt.PhpVal) {
	mut var_show_admin_bar := rt.new_null()
	var_show_admin_bar = rt.new_bool(var_show.to_bool())
}

fn is_admin_bar_showing() bool {
	mut var_pagenow := rt.new_null()
	mut var_show_admin_bar := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('IFRAME_REQUEST')]))
		|| rt.is_true(rt.call_function('wp_is_json_request', []rt.PhpVal{})) {
		return false
	}
	if rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})) {
		return false
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		return true
	}
	if !(!var_show_admin_bar.is_null()) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
			|| rt.is_true(rt.identical(rt.new_string('wp-login.php'), var_pagenow)) {
			var_show_admin_bar = rt.new_bool(false)
		} else {
			var_show_admin_bar = rt.new_bool(_get_admin_bar_pref('', 0))
		}
	}
	var_show_admin_bar = rt.call_function('apply_filters', [
		rt.new_string('show_admin_bar'),
		var_show_admin_bar.clone(),
	])
	return var_show_admin_bar.to_bool()
}

fn _get_admin_bar_pref(context string, user i64) bool {
	mut var_context := context
	mut var_user := user
	mut var_pref := rt.new_null()
	var_pref = rt.call_function('get_user_option', [
		rt.new_string('show_admin_bar_${var_context}'),
		rt.new_int(user),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_pref)) {
		return true
	}
	return (rt.identical(rt.new_string('true'), var_pref)).to_bool()
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}

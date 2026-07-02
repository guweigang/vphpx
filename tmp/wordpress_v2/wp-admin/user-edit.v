import rt

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_session_tokens(_args ...rt.PhpVal) &Class_WP_Session_Tokens {
	mut obj := &Class_WP_Session_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Session_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Session_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Session_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	mut var_user_login := rt.new_null()
	mut var_super_admins := rt.new_null()
	mut var__wp_admin_css_colors := rt.new_null()
	mut var_wp_roles := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php',
		'4')
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	mut var_user_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('user_id')))) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('user_id')),
		]) } else { rt.new_int(0) }
	mut var_wp_http_referer := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_http_referer')))) { rt.call_function('sanitize_url', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_http_referer')),
		]) } else { rt.new_string('') }
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('IS_PROFILE_PAGE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('IS_PROFILE_PAGE'),
			rt.identical(var_user_id, rt.get_property(var_current_user, 'ID'))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id))))
		&& rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
		var_user_id = rt.get_property(var_current_user, 'ID')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Invalid user ID.')]),
		])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_userdata', [
		var_user_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Invalid user ID.')]),
		])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('user-profile')])
	if rt.is_true(rt.call_function('wp_is_application_passwords_available_for_user', [
		var_user_id.clone(),
	]))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('application-passwords')])
	}
	if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
		mut var_title := rt.call_function('__', [rt.new_string('Profile')])
	} else {
		var_title = rt.call_function('__', [rt.new_string('Edit User %s')])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))) {
		mut var_submenu_file := 'users.php'
	} else {
		var_submenu_file = 'profile.php'
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{}))))) {
		mut var_parent_file := 'users.php'
	} else {
		var_parent_file = 'profile.php'
	}
	mut var_profile_help := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Your profile contains information about you (your &#8220;account&#8221;) as well as some personal options related to using WordPress.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('You can change your password, turn on keyboard shortcuts, change the color scheme of your WordPress administration screens, and turn off the WYSIWYG (Visual) editor, among other things. You can hide the Toolbar (formerly called the Admin Bar) from the front end of your site, however it cannot be disabled on the admin screens.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('You can select the language you wish to use while using the WordPress administration screen without affecting the language site visitors see.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Your username cannot be changed, but you can use other fields to enter your real name or a nickname, and change which name to display on your posts.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('You can log out of other devices, such as your phone or a public computer, by clicking the Log Out Everywhere Else button.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Required fields are indicated; the rest are optional. Profile information will only be displayed if your theme is set up to do so.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Remember to click the Update Profile button when you are finished.')])).str() +
		'</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_profile_help }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/users-your-profile-screen/">Documentation on User Profiles</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	var_wp_http_referer = rt.call_function('remove_query_arg', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'update' },
			rt.ArrayItem{ key: none, val: 'delete_count' }, rt.ArrayItem{ key: none, val: 'user_id' }]),
		var_wp_http_referer.clone(),
	])
	mut var_user_can_edit :=
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_pages')]))
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_user_id, rt.get_property(var_current_user, 'ID')))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_edit_any_user_configuration'), rt.new_bool(true)]))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this user.'),
			]),
		])
	}
	if rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('newuseremail'))
		&& rt.is_true(rt.get_property(var_current_user, 'ID')) {
		mut var_new_email := rt.call_function('get_user_meta', [
			rt.get_property(var_current_user, 'ID'),
			rt.new_string('_new_email'),
			rt.new_bool(true),
		])
		if rt.is_true(var_new_email)
			&& rt.is_true(rt.call_function('hash_equals', [var_new_email.array_get(rt.new_string('hash')), rt.get_superglobal('_GET').array_get(rt.new_string('newuseremail'))])) {
			mut var_user := create_stdclass()
			rt.set_property(var_user, 'ID', rt.get_property(var_current_user, 'ID'))
			rt.set_property(var_user, 'user_email', rt.call_function('esc_html', [
				rt.new_string(var_new_email.array_get(rt.new_string('newemail')).to_string().trim_space()),
			]))
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_login FROM '), rt.get_property(var_wpdb, 'signups')), rt.new_string(' WHERE user_login = %s')), rt.get_property(var_current_user, 'user_login')])])) {
				rt.call_method(var_wpdb, 'query', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
							'signups')),
							rt.new_string(' SET user_email = %s WHERE user_login = %s')),
						rt.get_property(var_user, 'user_email'),
						rt.get_property(var_current_user, 'user_login'),
					]),
				])
			}
			rt.call_function('wp_update_user', [var_user.clone()])
			rt.call_function('delete_user_meta', [
				rt.get_property(var_current_user, 'ID'),
				rt.new_string('_new_email'),
			])
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'updated', val: 'true' }]),
					rt.call_function('self_admin_url', [rt.new_string('profile.php')]),
				]),
			])
			exit(0)
		} else {
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'error', val: 'new-email' }]),
					rt.call_function('self_admin_url', [rt.new_string('profile.php')]),
				]),
			])
		}
	} else if rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('dismiss'))))
		&& rt.is_true(rt.identical((rt.get_property(var_current_user, 'ID')).str() + '_new_email', rt.get_superglobal('_GET').array_get(rt.new_string('dismiss')))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('dismiss-' + (rt.get_property(var_current_user, 'ID')).str() +
				'_new_email'),
		])
		rt.call_function('delete_user_meta', [rt.get_property(var_current_user, 'ID'),
			rt.new_string('_new_email')])
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'updated', val: 'true' }]),
				rt.call_function('self_admin_url', [rt.new_string('profile.php')]),
			]),
		])
		exit(0)
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('update'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('update-user_' + var_user_id.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_user'),
			var_user_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this user.'),
				]),
			])
		}
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			rt.call_function('do_action', [rt.new_string('personal_options_update'),
				var_user_id.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('edit_user_profile_update'),
				var_user_id.clone()])
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_user = rt.call_function('get_userdata', [var_user_id.clone()])
			if rt.is_true(rt.get_property(var_user, 'user_login'))
				&& rt.get_superglobal('_POST').array_isset(rt.new_string('email'))
				&& rt.is_true(rt.call_function('is_email', [rt.get_superglobal('_POST').array_get(rt.new_string('email'))]))
				&& rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_login FROM '), rt.get_property(var_wpdb, 'signups')), rt.new_string(' WHERE user_login = %s')), rt.get_property(var_user, 'user_login')])])) {
				rt.call_method(var_wpdb, 'query', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
							'signups')),
							rt.new_string(' SET user_email = %s WHERE user_login = %s')),
						rt.get_superglobal('_POST').array_get(rt.new_string('email')),
						var_user_login.clone(),
					]),
				])
			}
		}
		mut var_errors := rt.call_function('edit_user', [var_user_id.clone()])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')]))
			&& !(!var_super_admins.is_null())
			&& rt.is_true(rt.identical(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('super_admin')))), rt.call_function('is_super_admin', [var_user_id.clone()]))) {
			if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('super_admin'))) {
				rt.call_function('revoke_super_admin', [var_user_id.clone()])
			} else {
				rt.call_function('grant_super_admin', [var_user_id.clone()])
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_errors.clone(),
		])))))
		{
			mut var_redirect := rt.call_function('add_query_arg', [
				rt.new_string('updated'),
				rt.new_bool(true),
				rt.call_function('get_edit_user_link', [var_user_id.clone()]),
			])
			if rt.is_true(var_wp_http_referer) {
				var_redirect = rt.call_function('add_query_arg', [
					rt.new_string('wp_http_referer'),
					rt.call_function('urlencode', [var_wp_http_referer.clone()]),
					var_redirect.clone(),
				])
			}
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
	} else {
		mut var_profile_user := rt.call_function('get_user_to_edit', [
			var_user_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_user'),
			var_user_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this user.'),
				]),
			])
		}
		var_title = rt.call_function('sprintf', [var_title.clone(),
			rt.get_property(var_profile_user, 'display_name')])
		mut iife_temp_0 := Class_WP_Session_Tokens{}
		mut iife_result_0 := iife_temp_0.get_instance(rt.get_property(var_profile_user, 'ID'))
		mut var_sessions := iife_result_0
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))))
			&& rt.is_true(rt.call_function('is_super_admin', [rt.get_property(var_profile_user, 'ID')]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')])) {
			mut var_message := rt.new_string('<strong>' +
				(rt.call_function('__', [rt.new_string('Important:')])).str() + '</strong> ' +(rt.call_function('__', [rt.new_string('This user has super admin privileges.')])).str())
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }])])
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
			if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
				var_message = rt.new_string('<p><strong>' +
					(rt.call_function('__', [rt.new_string('Profile updated.')])).str() +
					'</strong></p>')
			} else {
				var_message = rt.new_string('<p><strong>' +
					(rt.call_function('__', [rt.new_string('User updated.')])).str() +
					'</strong></p>')
			}
			if rt.is_true(var_wp_http_referer)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_wp_http_referer.clone(), rt.new_string('user-new.php')])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))) {
				var_message = rt.concat(var_message, rt.call_function('sprintf', [
					rt.new_string('<p><a href="%1$s">%2$s</a></p>'),
					rt.call_function('esc_url', [
						rt.call_function('wp_validate_redirect', [
							rt.call_function('sanitize_url', [
								var_wp_http_referer.clone()]),
							rt.call_function('self_admin_url', [
								rt.new_string('users.php')]),
						]),
					]),
					rt.call_function('__', [
						rt.new_string('&larr; Go to Users'),
					]),
				]))
			}
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'dismissible', val: true },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('error')) {
			var_message = rt.new_string('')
			if rt.is_true(rt.identical(rt.new_string('new-email'),
				rt.get_superglobal('_GET').array_get(rt.new_string('error'))))
			{
				var_message = rt.call_function('__', [
					rt.new_string('Error while saving the new email address. Please try again.'),
				])
			}
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }])])
		}
		if !var_errors.is_null()
			&& rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) {
			rt.call_function('wp_admin_notice', [
				rt.call_function('implode', [rt.new_string('</p>\n<p>'),
					rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{})]),
				rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) }]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('create_users'),
			]))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add User')]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html__', [
					rt.new_string('Add Existing User'),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('self_admin_url', [
				rt.new_string((if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
					'profile.php'
				} else {
					'user-edit.php'
				}).str()),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('user_edit_form_tag')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [
			rt.new_string('update-user_' + var_user_id.str()),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_wp_http_referer) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_wp_http_referer.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_current_user_id', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Personal Options')])
		// unsupported statement: Stmt_InlineHTML
		if !(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) && !var_user_can_edit)
			&& rt.is_true(rt.identical(rt.new_string('false'), rt.get_property(var_profile_user, 'rich_editing'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Visual Editor')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_string('false'),
				rt.get_property(var_profile_user, 'rich_editing')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Disable the visual editor when writing'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_show_syntax_highlighting_preference :=
			rt.is_true(rt.call_function('user_can', [var_profile_user.clone(), rt.new_string('edit_theme_options')]))
			|| rt.is_true(rt.call_function('user_can', [var_profile_user.clone(), rt.new_string('edit_plugins')]))
			|| rt.is_true(rt.call_function('user_can', [var_profile_user.clone(), rt.new_string('edit_themes')]))
		// unsupported statement: Stmt_InlineHTML
		if var_show_syntax_highlighting_preference {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Syntax Highlighting')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_string('false'),
				rt.get_property(var_profile_user, 'syntax_highlighting')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Disable syntax highlighting when editing code'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if var__wp_admin_css_colors.clone().array_count() > 1
			&& rt.is_true(rt.call_function('has_action', [rt.new_string('admin_color_scheme_picker')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Administration Color Scheme')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [rt.new_string('admin_color_scheme_picker'),
				var_user_id.clone()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if !(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) && !var_user_can_edit) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Keyboard Shortcuts')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_string('true'),
				rt.get_property(var_profile_user, 'comment_shortcuts')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Enable keyboard shortcuts for comment moderation.'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('<a href="https://wordpress.org/documentation/article/keyboard-shortcuts-classic-editor/#keyboard-shortcuts-for-comments">Documentation on Keyboard Shortcuts</a>'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Toolbar')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [
			rt.call_function('_get_admin_bar_pref', [rt.new_string('front'),
				rt.get_property(var_profile_user, 'ID')]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Show Toolbar when viewing site')])
		// unsupported statement: Stmt_InlineHTML
		mut var_languages := rt.call_function('get_available_languages', []rt.PhpVal{})
		mut var_can_install_translations :=
			rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')]))
			&& rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_languages) || var_can_install_translations {
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Language')])
			// unsupported statement: Stmt_InlineHTML
			mut var_user_locale := rt.get_property(var_profile_user, 'locale')
			if rt.is_true(rt.identical(rt.new_string('en_US'), var_user_locale)) {
				var_user_locale = rt.new_string('')
			} else if rt.is_true(rt.identical(rt.new_string(''), var_user_locale))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_user_locale.clone(), var_languages.clone(), rt.new_bool(true)]))))) {
				var_user_locale = rt.new_string('site-default')
			}
			rt.call_function('wp_dropdown_languages', [
				rt.create_array([rt.ArrayItem{ key: 'name', val: 'locale' },
					rt.ArrayItem{ key: 'id', val: 'locale' },
					rt.ArrayItem{ key: 'selected', val: var_user_locale },
					rt.ArrayItem{ key: 'languages', val: var_languages },
					rt.ArrayItem{
						key: 'show_available_translations'
						val: var_can_install_translations
					}, rt.ArrayItem{ key: 'show_option_site_default', val: true }]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('personal_options'),
			var_profile_user.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			rt.call_function('do_action', [rt.new_string('profile_personal_options'),
				var_profile_user.clone()])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Username')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_profile_user, 'user_login'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Usernames cannot be changed.')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_user'), rt.get_property(var_profile_user, 'ID')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Role')])
			// unsupported statement: Stmt_InlineHTML
			mut var_user_roles := rt.call_function('array_intersect', [
				rt.call_function('array_values', [
					rt.get_property(var_profile_user, 'roles'),
				]),
				rt.func_array_keys(rt.call_function('get_editable_roles', []rt.PhpVal{})),
			])
			mut var_user_role := rt.call_function('reset', [var_user_roles.clone()])
			rt.call_function('wp_dropdown_roles', [var_user_role.clone()])
			if rt.is_true(var_user_role) {
				print('<option value="">' +
					(rt.call_function('__', [rt.new_string('&mdash; No role for this site &mdash;')])).str() +
					'</option>')
			} else {
				print('<option value="" selected="selected">' +
					(rt.call_function('__', [rt.new_string('&mdash; No role for this site &mdash;')])).str() +
					'</option>')
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))))
			&& !(!var_super_admins.is_null()) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Super Admin')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [
				rt.call_function('is_super_admin', [
					rt.get_property(var_profile_user, 'ID'),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Grant this user super admin privileges for the Network.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('First Name')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'first_name'),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'first_name'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Last Name')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'last_name'),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'last_name'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Nickname')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('(required)')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'nickname'),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'nickname'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Display name publicly as')])
		// unsupported statement: Stmt_InlineHTML
		mut var_public_display := rt.new_array()
		var_public_display.array_set('display_nickname', rt.get_property(var_profile_user,
			'nickname'))
		var_public_display.array_set('display_username', rt.get_property(var_profile_user,
			'user_login'))
		if !(!rt.is_true(rt.get_property(var_profile_user, 'first_name'))) {
			var_public_display.array_set('display_firstname', rt.get_property(var_profile_user,
				'first_name'))
		}
		if !(!rt.is_true(rt.get_property(var_profile_user, 'last_name'))) {
			var_public_display.array_set('display_lastname', rt.get_property(var_profile_user,
				'last_name'))
		}
		if !(!rt.is_true(rt.get_property(var_profile_user, 'first_name')))
			&& !(!rt.is_true(rt.get_property(var_profile_user, 'last_name'))) {
			var_public_display.array_set('display_firstlast',
				(rt.get_property(var_profile_user, 'first_name')).str() + ' ' +
				(rt.get_property(var_profile_user, 'last_name')).str())
			var_public_display.array_set('display_lastfirst',
				(rt.get_property(var_profile_user, 'last_name')).str() + ' ' +
				(rt.get_property(var_profile_user, 'first_name')).str())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_profile_user, 'display_name'),
			var_public_display.clone(),
			rt.new_bool(true),
		])))))
		{
			var_public_display = rt.add(rt.create_array([
				rt.ArrayItem{ key: 'display_displayname', val: rt.get_property(var_profile_user,
					'display_name') },
			]), var_public_display)
		}
		var_public_display = rt.call_function('array_map', [rt.new_string('trim'),
			var_public_display.clone()])
		var_public_display = rt.call_function('array_unique', [
			var_public_display.clone()])
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_public_display.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_id := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [
				rt.get_property(var_profile_user, 'display_name'),
				var_item.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_item)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Contact Info')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Email')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('(required)')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.get_property(var_profile_user, 'ID'), rt.get_property(var_current_user,
			'ID')))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'user_email'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('If you change this, an email will be sent at your new address to confirm it. <strong>The new address will not become active until confirmed.</strong>'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user, 'user_email'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		var_new_email = rt.call_function('get_user_meta', [
			rt.get_property(var_current_user, 'ID'),
			rt.new_string('_new_email'),
			rt.new_bool(true),
		])
		if rt.is_true(var_new_email)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_email.array_get(rt.new_string('newemail')), rt.get_property(var_current_user, 'user_email')))))
			&& rt.is_true(rt.identical(rt.get_property(var_profile_user, 'ID'), rt.get_property(var_current_user, 'ID'))) {
			mut var_pending_change_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('There is a pending change of your email to %s.'),
				]),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_new_email.array_get(rt.new_string('newemail'))])).str() +
					'</code>'),
			])
			var_pending_change_message = rt.concat(var_pending_change_message, rt.call_function('sprintf', [
				rt.new_string(' <a href="%1$s">%2$s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('wp_nonce_url', [
						rt.call_function('self_admin_url', [
							rt.new_string('profile.php?dismiss=' +
								(rt.get_property(var_current_user, 'ID')).str() + '_new_email'),
						]),
						rt.new_string('dismiss-' + (rt.get_property(var_current_user, 'ID')).str() +
							'_new_email'),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('Cancel'),
				]),
			]))
			rt.call_function('wp_admin_notice', [var_pending_change_message.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
						rt.ArrayItem{ key: none, val: 'inline' },
					]) },
				])])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Website')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_profile_user, 'user_url'),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := rt.call_function('wp_get_user_contact_methods', [
			var_profile_user.clone()]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_desc := item_2.val
			mut var_name := item_2.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_name)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_name)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('user_${var_name.to_string()}_label'),
				var_desc.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_name)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_name)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_profile_user,
					'{"nodeType":"Expr_Variable","line":621,"name":"name"}'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			rt.call_function('_e', [rt.new_string('About Yourself')])
		} else {
			rt.call_function('_e', [rt.new_string('About the user')])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Biographical Info')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_profile_user, 'description'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Share a little biographical information to fill out your profile. This may be shown publicly.'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Profile Picture')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_avatar', [var_user_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
				mut var_description := rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('<a href="%s">You can change your profile picture on Gravatar</a>.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://gravatar.com/'),
					]),
				])
			} else {
				var_description = rt.new_string('')
			}
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('user_profile_picture_description'),
				var_description.clone(),
				var_profile_user.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_show_password_fields := rt.call_function('apply_filters', [
			rt.new_string('show_password_fields'),
			rt.new_bool(true),
			var_profile_user.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_show_password_fields) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Account Management')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('New Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Set New Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wp_generate_password', [rt.new_int(24)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Hide password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Hide')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Cancel password change')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Cancel')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Repeat New Password')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Type your new password again.')])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Type the new password again.')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Confirm Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Confirm use of weak password')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))))
			&& rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wp_is_password_reset_allowed_for_user', [var_profile_user.clone()]))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Password Reset')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Send Reset Link')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Send %s a link to reset their password. This will not change their password, nor will it force a change.'),
				]),
				rt.call_function('esc_html', [
					rt.get_property(var_profile_user, 'display_name'),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))
			&& rt.call_method(var_sessions, 'get_all', []rt.PhpVal{}).array_count() == 1 {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Sessions')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Log Out Everywhere Else')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('You are only logged in at this location.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))
			&& rt.call_method(var_sessions, 'get_all', []rt.PhpVal{}).array_count() > 1 {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Sessions')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Log Out Everywhere Else')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Did you lose your phone or leave your account logged in at a public computer? You can log out everywhere else, and stay logged in here.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))))
			&& rt.is_true(rt.call_method(var_sessions, 'get_all', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Sessions')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Log Out Everywhere')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Log %s out of all locations.')]),
				rt.get_property(var_profile_user, 'display_name'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wp_is_application_passwords_available_for_user', [var_user_id.clone()]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_application_passwords_supported', []rt.PhpVal{}))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Application Passwords')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Application passwords allow authentication via non-interactive systems, such as XML-RPC or the REST API, without providing your actual password. Application passwords can be easily revoked. They cannot be used for traditional logins to your website.'),
			])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('wp_is_application_passwords_available_for_user', [
				var_user_id.clone(),
			]))
			{
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
					mut var_blogs := rt.call_function('get_blogs_of_user', [
						var_user_id.clone(), rt.new_bool(true)])
					mut var_blogs_count := var_blogs.clone().array_count()
					if var_blogs_count > 1 {
						// unsupported statement: Stmt_InlineHTML
						var_message = rt.call_function('_n', [
							rt.new_string('Application passwords grant access to <a href="%1$s">the %2$s site in this installation that you have permissions on</a>.'),
							rt.new_string('Application passwords grant access to <a href="%1$s">all %2$s sites in this installation that you have permissions on</a>.'),
							rt.new_int(var_blogs_count).clone(),
						])
						if rt.is_true(rt.call_function('is_super_admin', [
							var_user_id.clone()]))
						{
							var_message = rt.call_function('_n', [
								rt.new_string('Application passwords grant access to <a href="%1$s">the %2$s site on the network as you have Super Admin rights</a>.'),
								rt.new_string('Application passwords grant access to <a href="%1$s">all %2$s sites on the network as you have Super Admin rights</a>.'),
								rt.new_int(var_blogs_count).clone(),
							])
						}
						rt.call_function('printf', [var_message.clone(),
							rt.call_function('admin_url', [rt.new_string('my-sites.php')]),
							rt.call_function('number_format_i18n', [
								rt.new_int(var_blogs_count).clone()])])
						// unsupported statement: Stmt_InlineHTML
					}
				}
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_site_protected_by_basic_auth', [
					rt.new_string('front'),
				])))))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('New Application Password Name'),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('Required to create an Application Password, but not to update the user.'),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('do_action', [
						rt.new_string('wp_create_application_password_form'),
						var_profile_user.clone(),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Add Application Password')])
					// unsupported statement: Stmt_InlineHTML
				} else {
					rt.call_function('wp_admin_notice', [
						rt.call_function('__', [
							rt.new_string('Your website appears to use Basic Authentication, which is not currently compatible with Application Passwords.'),
						]),
						rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'error' },
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'inline' },
							]) },
						]),
					])
				}
				// unsupported statement: Stmt_InlineHTML
				mut var_application_passwords_list_table := rt.call_function('_get_list_table', [
					rt.new_string('WP_Application_Passwords_List_Table'),
					rt.create_array([
						rt.ArrayItem{ key: 'screen', val: 'application-passwords-user' },
					]),
				])
				rt.call_method(var_application_passwords_list_table, 'prepare_items', []rt.PhpVal{})
				rt.call_method(var_application_passwords_list_table, 'display', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_application_passwords_supported',
				[]rt.PhpVal{})))))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('The application password feature requires HTTPS, which is not enabled on this site.'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('If this is a development website, you can <a href="%s">set the environment type accordingly</a> to enable application passwords.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://developer.wordpress.org/apis/wp-config-php/#wp-environment-type'),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			rt.call_function('do_action', [rt.new_string('show_user_profile'),
				var_profile_user.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('edit_user_profile'),
				var_profile_user.clone()])
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_display_additional_caps := rt.call_function('apply_filters', [
			rt.new_string('additional_capabilities_display'),
			rt.new_bool(true),
			var_profile_user.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.get_property(var_profile_user, 'caps').array_count() > rt.get_property(var_profile_user, 'roles').array_count()
			&& rt.is_true(rt.identical(rt.new_bool(true), var_display_additional_caps)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Additional Capabilities')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Capabilities')])
			// unsupported statement: Stmt_InlineHTML
			mut var_output := ''
			mut iter_3 := rt.get_property(var_profile_user, 'caps').iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_value := item_3.val
				mut var_cap := item_3.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_roles, 'is_role', [
					var_cap.clone(),
				])))))
				{
					if rt.is_true(rt.new_bool('' != var_output)) {
						var_output = var_output + ', '
					}
					if rt.is_true(var_value) {
						var_output = var_output + var_cap.str()
					} else {
						var_output = var_output +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Denied: %s')]), var_cap.clone()])).str()
					}
				}
			}
			print(var_output)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) { rt.call_function('__', [
				rt.new_string('Update Profile'),
			]) } else { rt.call_function('__', [
				rt.new_string('Update User'),
			]) }])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !var_application_passwords_list_table.is_null() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Your new password for %s is:')]),
			rt.new_string('<strong>{{ data.name }}</strong>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Copy')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Copied!')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Be sure to save this in a safe location. You will not be able to retrieve it.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Dismiss this notice.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_application_passwords_list_table, 'print_js_template_row', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

import rt

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_session_tokens() &Class_WP_Session_Tokens {
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
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	mut var_user_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('user_id'))) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('user_id')]) } else { rt.new_int(0) }
	mut var_wp_http_referer := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('wp_http_referer'))) { rt.call_function('sanitize_url', [rt.get_superglobal('_REQUEST').array_get('wp_http_referer')]) } else { rt.new_string('') }
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IS_PROFILE_PAGE')]))))) {
		rt.call_function('define', [rt.new_string('IS_PROFILE_PAGE'), rt.identical(var_user_id, rt.get_property(var_current_user, 'ID'))])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) && rt.is_true(rt.get_constant('IS_PROFILE_PAGE')))) {
		var_user_id = rt.get_property(var_current_user, 'ID')
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid user ID.')])])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_userdata', [var_user_id.dup()]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid user ID.')])])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('user-profile')])
	if rt.is_true(rt.call_function('wp_is_application_passwords_available_for_user', [var_user_id.dup()])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('application-passwords')])
	}
	if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
		mut var_title := rt.call_function('__', [rt.new_string('Profile')])
	} else {
		var_title = rt.call_function('__', [rt.new_string('Edit User %s')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))))) {
		mut var_submenu_file := 'users.php'
	} else {
		var_submenu_file = 'profile.php'
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{}))))))) {
		mut var_parent_file := 'users.php'
	} else {
		var_parent_file = 'profile.php'
	}
	mut var_profile_help := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Your profile contains information about you (your &#8220;account&#8221;) as well as some personal options related to using WordPress.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can change your password, turn on keyboard shortcuts, change the color scheme of your WordPress administration screens, and turn off the WYSIWYG (Visual) editor, among other things. You can hide the Toolbar (formerly called the Admin Bar) from the front end of your site, however it cannot be disabled on the admin screens.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can select the language you wish to use while using the WordPress administration screen without affecting the language site visitors see.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Your username cannot be changed, but you can use other fields to enter your real name or a nickname, and change which name to display on your posts.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can log out of other devices, such as your phone or a public computer, by clicking the Log Out Everywhere Else button.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Required fields are indicated; the rest are optional. Profile information will only be displayed if your theme is set up to do so.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Remember to click the Update Profile button when you are finished.')])).str() + '</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_profile_help }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/users-your-profile-screen/">Documentation on User Profiles</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	var_wp_http_referer = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'update' }, rt.ArrayItem{ key: none, val: 'delete_count' }, rt.ArrayItem{ key: none, val: 'user_id' }]), var_wp_http_referer.dup()])
	mut var_user_can_edit := rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_pages')]))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_edit_any_user_configuration'), rt.new_bool(true)]))))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) && rt.get_superglobal('_GET').array_isset(rt.new_string('newuseremail')))) && rt.is_true(rt.get_property(var_current_user, 'ID')))) {
		mut var_new_email := rt.call_function('get_user_meta', [rt.get_property(var_current_user, 'ID'), rt.new_string('_new_email'), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(rt.is_true(var_new_email) && rt.is_true(rt.call_function('hash_equals', [var_new_email.array_get('hash'), rt.get_superglobal('_GET').array_get('newuseremail')])))) {
			mut var_user := create_stdclass()
			rt.set_property(var_user, 'ID', rt.get_property(var_current_user, 'ID'))
			rt.set_property(var_user, 'user_email', rt.call_function('esc_html', [rt.new_string(var_new_email.array_get('newemail').to_string().trim_space())]))
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_login FROM '), rt.get_property(var_wpdb, 'signups')), rt.new_string(' WHERE user_login = %s')), rt.get_property(var_current_user, 'user_login')])])))) {
				rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'signups')), rt.new_string(' SET user_email = %s WHERE user_login = %s')), rt.get_property(var_user, 'user_email'), rt.get_property(var_current_user, 'user_login')])])
			}
			rt.call_function('wp_update_user', [var_user.dup()])
			rt.call_function('delete_user_meta', [rt.get_property(var_current_user, 'ID'), rt.new_string('_new_email')])
			rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'updated', val: 'true' }]), rt.call_function('self_admin_url', [rt.new_string('profile.php')])])])
			// unsupported expression: Expr_Exit
		} else {
			rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'error', val: 'new-email' }]), rt.call_function('self_admin_url', [rt.new_string('profile.php')])])])
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) && !(!rt.is_true(rt.get_superglobal('_GET').array_get('dismiss'))))) && rt.is_true(rt.identical((rt.get_property(var_current_user, 'ID')).str() + '_new_email', rt.get_superglobal('_GET').array_get('dismiss'))))) {
		rt.call_function('check_admin_referer', ['dismiss-' + (rt.get_property(var_current_user, 'ID')).str() + '_new_email'])
		rt.call_function('delete_user_meta', [rt.get_property(var_current_user, 'ID'), rt.new_string('_new_email')])
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'updated', val: 'true' }]), rt.call_function('self_admin_url', [rt.new_string('profile.php')])])])
		// unsupported expression: Expr_Exit
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('update'))) {
		rt.call_function('check_admin_referer', ['update-user_' + (var_user_id).str()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.dup()]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')])])
		}
		if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
			rt.call_function('do_action', [rt.new_string('personal_options_update'), var_user_id.dup()])
		} else {
			rt.call_function('do_action', [rt.new_string('edit_user_profile_update'), var_user_id.dup()])
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_user = rt.call_function('get_userdata', [var_user_id.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_user, 'user_login')) && rt.get_superglobal('_POST').array_isset(rt.new_string('email')))) && rt.is_true(rt.call_function('is_email', [rt.get_superglobal('_POST').array_get('email')])))) && rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT user_login FROM '), rt.get_property(var_wpdb, 'signups')), rt.new_string(' WHERE user_login = %s')), rt.get_property(var_user, 'user_login')])])))) {
				rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'signups')), rt.new_string(' SET user_email = %s WHERE user_login = %s')), rt.get_superglobal('_POST').array_get('email'), var_user_login.dup()])])
			}
		}
		mut var_errors := rt.call_function('edit_user', [var_user_id.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')])))) && !(!(var_super_admins).is_null()))) && rt.is_true(rt.identical(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('super_admin'))), rt.call_function('is_super_admin', [var_user_id.dup()]))))) {
			if !rt.is_true(rt.get_superglobal('_POST').array_get('super_admin')) { rt.call_function('revoke_super_admin', [var_user_id.dup()]) } else { rt.call_function('grant_super_admin', [var_user_id.dup()]) }
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_errors.dup()]))))) {
			mut var_redirect := rt.call_function('add_query_arg', [rt.new_string('updated'), rt.new_bool(true), rt.call_function('get_edit_user_link', [var_user_id.dup()])])
			if rt.is_true(var_wp_http_referer) {
				var_redirect = rt.call_function('add_query_arg', [rt.new_string('wp_http_referer'), rt.call_function('urlencode', [var_wp_http_referer.dup()]), var_redirect.dup()])
			}
			rt.call_function('wp_redirect', [var_redirect.dup()])
			// unsupported expression: Expr_Exit
		}
	} else {
		mut var_profile_user := rt.call_function('get_user_to_edit', [var_user_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.dup()]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')])])
		}
		var_title = rt.call_function('sprintf', [var_title.dup(), rt.get_property(var_profile_user, 'display_name')])
		mut var_sessions := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Session_Tokens{}; return temp.get_instance(arg_0) }(rt.get_property(var_profile_user, 'ID'))
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))) && rt.is_true(rt.call_function('is_super_admin', [rt.get_property(var_profile_user, 'ID')])))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')])))) {
			mut var_message := rt.new_string('<strong>' + (rt.call_function('__', [rt.new_string('Important:')])).str() + '</strong> ' + (rt.call_function('__', [rt.new_string('This user has super admin privileges.')])).str())
			rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }])])
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
			if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) {
				var_message = rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('Profile updated.')])).str() + '</strong></p>')
			} else {
				var_message = rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('User updated.')])).str() + '</strong></p>')
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_wp_http_referer) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_wp_http_referer.dup(), rt.new_string('user-new.php')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'dismissible', val: true }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('error')) {
			var_message = rt.new_string(rt.new_string(''))
			if rt.is_true(rt.identical(rt.new_string('new-email'), rt.get_superglobal('_GET').array_get('error'))) {
				var_message = rt.call_function('__', [rt.new_string('Error while saving the new email address. Please try again.')])
			}
			rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }])])
		}
		if rt.is_true(rt.new_bool(!(var_errors).is_null() && rt.is_true(rt.call_function('is_wp_error', [var_errors.dup()])))) {
			rt.call_function('wp_admin_notice', [rt.call_function('implode', [rt.new_string('</p>\n<p>'), rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('IS_PROFILE_PAGE'))))) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')])) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add User')]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Existing User')]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('self_admin_url', [if rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) { rt.new_string('profile.php') } else { rt.new_string('user-edit.php') }])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('user_edit_form_tag')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', ['update-user_' + (var_user_id).str()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_wp_http_referer) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_wp_http_referer.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_current_user_id', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Personal Options')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('IS_PROFILE_PAGE')) && !(var_user_can_edit)))))) && rt.is_true(rt.identical(rt.new_string('false'), rt.get_property(var_profile_user, 'rich_editing'))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Visual Editor')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_string('false'), rt.get_property(, 'rich_editing')])
			// unsupported statement: Stmt_InlineHTML
			
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

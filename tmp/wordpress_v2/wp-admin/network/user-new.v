import rt

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('create_users'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to add users to this network.'),
			]),
		])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Add User will set up a new user account on the network and send that person an email with username and password.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Users who are signed up to the network without a site are added as subscribers to the main or primary dashboard site, giving them profile pages to manage their accounts. These users will only see Dashboard and My Sites in the main navigation until a site is created for them.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Network_Admin_Users_Screen">Documentation on Network Users</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() +
			'</p>'),
	])
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('add-user'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-user'),
			rt.new_string('_wpnonce_add-user')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_users'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to access this page.'),
				]),
				rt.new_int(403),
			])
		}
		if !(rt.get_superglobal('_POST').array_get(rt.new_string('user')).is_array()) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Cannot create an empty user.')]),
			])
		}
		mut var_user := rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('user')),
		])
		mut var_user_details := rt.call_function('wpmu_validate_user_signup', [
			var_user.array_get(rt.new_string('username')),
			var_user.array_get(rt.new_string('email')),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_user_details.array_get(rt.new_string('errors'))]))
			&& rt.is_true(rt.call_method(var_user_details.array_get(rt.new_string('errors')), 'has_errors', []rt.PhpVal{})) {
			mut var_add_user_errors := var_user_details.array_get(rt.new_string('errors'))
		} else {
			mut var_password := rt.call_function('wp_generate_password', [
				rt.new_int(12), rt.new_bool(false)])
			mut var_user_id := rt.call_function('wpmu_create_user', [
				rt.call_function('esc_html', [
					rt.new_string(var_user.array_get(rt.new_string('username')).to_string().to_lower()),
				]),
				var_password.clone(),
				rt.call_function('sanitize_email', [
					var_user.array_get(rt.new_string('email')),
				]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
				var_add_user_errors = create_wp_error(rt.new_string('add_user_fail'), rt.call_function('__', [
					rt.new_string('Cannot add user.'),
				]))
			} else {
				rt.call_function('do_action', [
					rt.new_string('network_user_new_created_user'),
					var_user_id.clone(),
				])
				rt.call_function('wp_redirect', [
					rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'update', val: 'added' },
							rt.ArrayItem{ key: 'user_id', val: var_user_id }]),
						rt.new_string('user-new.php'),
					]),
				])
				exit(0)
			}
		}
	}
	mut var_message := rt.new_string('')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
		if rt.is_true(rt.identical(rt.new_string('added'),
			rt.get_superglobal('_GET').array_get(rt.new_string('update'))))
		{
			mut var_edit_link := rt.new_string('')
			if rt.get_superglobal('_GET').array_isset(rt.new_string('user_id')) {
				mut var_user_id_new := rt.call_function('absint', [
					rt.get_superglobal('_GET').array_get(rt.new_string('user_id')),
				])
				if rt.is_true(var_user_id_new) {
					var_edit_link = rt.call_function('esc_url', [
						rt.call_function('add_query_arg', [
							rt.new_string('wp_http_referer'),
							rt.call_function('urlencode', [
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
								]),
							]),
							rt.call_function('get_edit_user_link', [
								var_user_id_new.clone(),
							]),
						]),
					])
				}
			}
			var_message = rt.call_function('__', [rt.new_string('User added.')])
			if rt.is_true(var_edit_link) {
				var_message = rt.concat(var_message, rt.call_function('sprintf', [
					rt.new_string(' <a href="%s">%s</a>'),
					var_edit_link.clone(),
					rt.call_function('__', [rt.new_string('Edit user')]),
				]))
			}
		}
	}
	mut var_title := rt.call_function('__', [rt.new_string('Add User')])
	mut var_parent_file := 'users.php'
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add User')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_message)))) {
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }])])
	}
	if !var_add_user_errors.is_null()
		&& rt.is_true(rt.call_function('is_wp_error', [var_add_user_errors.clone()])) {
		mut var_error_messages := ''
		mut iter_1 :=
			rt.call_method(var_add_user_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error := item_1.val
			var_error_messages = var_error_messages + '<p>${var_error.to_string()}</p>'
		}
		rt.call_function('wp_admin_notice', [rt.new_string(var_error_messages.str()).clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{
					key: 'paragraph_wrap'
					val: false
				}])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('network_admin_url', [
			rt.new_string('user-new.php?action=add-user'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_required_field_message', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Username')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_required_field_indicator', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_required_field_indicator', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('A password reset link will be sent to the user via email.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('network_user_new_form')])
	rt.call_function('wp_nonce_field', [rt.new_string('add-user'),
		rt.new_string('_wpnonce_add-user')])
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Add User')]),
		rt.new_string('primary'),
		rt.new_string('add-user'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

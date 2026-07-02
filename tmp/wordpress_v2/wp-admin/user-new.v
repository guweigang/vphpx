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

	mut var_blog_id := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_errors := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))))) {
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to add users to this network.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('create_users'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create users.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('add_filter', [
			rt.new_string('wpmu_signup_user_notification_email'),
			rt.new_string('admin_created_user_email'),
		])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('adduser'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-user'),
			rt.new_string('_wpnonce_add-user')])
		mut var_user_details := rt.new_null()
		mut var_user_email := rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('email')),
		])
		if rt.is_true(rt.call_function('str_contains', [var_user_email.clone(),
			rt.new_string('@')]))
		{
			var_user_details = rt.call_function('get_user_by', [
				rt.new_string('email'), var_user_email.clone()])
		} else {
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('manage_network_users'),
			]))
			{
				var_user_details = rt.call_function('get_user_by', [
					rt.new_string('login'),
					var_user_email.clone(),
				])
			} else {
				rt.call_function('wp_redirect', [
					rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'update', val: 'enter_email' },
						]),
						rt.new_string('user-new.php'),
					]),
				])
				exit(0)
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user_details)))) {
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'update', val: 'does_not_exist' },
					]),
					rt.new_string('user-new.php'),
				]),
			])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('promote_user'),
			rt.get_property(var_user_details, 'ID'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to add users to this network.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		mut var_new_user_email := rt.new_array()
		mut var_redirect := rt.new_string('user-new.php')
		mut var_username := rt.get_property(var_user_details, 'user_login')
		mut var_user_id := rt.get_property(var_user_details, 'ID')
		if rt.is_true(rt.new_bool(rt.call_function('get_blogs_of_user', [
			var_user_id.clone()]).array_isset(var_blog_id.clone())))
		{
			var_redirect = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'update', val: 'addexisting' }]),
				rt.new_string('user-new.php'),
			])
		} else {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('noconfirmation'))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])) {
				rt.call_function('wp_ensure_editable_role', [
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('role')),
				])
				mut var_result := rt.call_function('add_existing_user_to_blog', [
					rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id },
						rt.ArrayItem{
							key: 'role'
							val: rt.get_superglobal('_REQUEST').array_get(rt.new_string('role'))
						}]),
				])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
					var_result.clone(),
				])))))
				{
					var_redirect = rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'update', val: 'addnoconfirmation' },
							rt.ArrayItem{ key: 'user_id', val: var_user_id },
						]),
						rt.new_string('user-new.php'),
					])
				} else {
					var_redirect = rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'update', val: 'could_not_add' },
						]),
						rt.new_string('user-new.php'),
					])
				}
			} else {
				mut var_newuser_key := rt.call_function('wp_generate_password', [
					rt.new_int(20),
					rt.new_bool(false),
				])
				rt.call_function('add_option', [
					rt.new_string('new_user_' + var_newuser_key.str()),
					rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id },
						rt.ArrayItem{ key: 'email', val: rt.get_property(var_user_details,
							'user_email') }, rt.ArrayItem{
							key: 'role'
							val: rt.get_superglobal('_REQUEST').array_get(rt.new_string('role'))
						}]),
				])
				mut var_roles := rt.call_function('get_editable_roles', []rt.PhpVal{})
				mut var_role :=
					var_roles.array_get(rt.get_superglobal('_REQUEST').array_get(rt.new_string('role')))
				rt.call_function('do_action', [rt.new_string('invite_user'),
					var_user_id.clone(), var_role.clone(), var_newuser_key.clone()])
				mut var_switched_locale := rt.call_function('switch_to_user_locale', [
					var_user_id.clone(),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [
					rt.new_string('blogname'),
				])))))
				{
					mut var_site_title := rt.call_function('wp_specialchars_decode', [
						rt.call_function('get_option', [rt.new_string('blogname')]),
						rt.get_constant('ENT_QUOTES'),
					])
				} else {
					var_site_title = rt.call_function('parse_url', [
						rt.call_function('home_url', []rt.PhpVal{}),
						rt.get_constant('PHP_URL_HOST'),
					])
				}
				mut var_message := rt.call_function('__', [
					rt.new_string("Hi,\n\nYou've been invited to join '%1$s' at\n%2$s with the role of %3$s.\n\nPlease click the following link to confirm the invite:\n%4$s"),
				])
				var_new_user_email.array_set('to', rt.get_property(var_user_details, 'user_email'))
				var_new_user_email.array_set('subject', rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('[%s] Joining Confirmation')]),
					var_site_title.clone(),
				]))
				var_new_user_email.array_set('message', rt.call_function('sprintf', [
					var_message.clone(),
					rt.call_function('get_option', [rt.new_string('blogname')]),
					rt.call_function('home_url', []rt.PhpVal{}),
					rt.call_function('wp_specialchars_decode', [
						rt.call_function('translate_user_role', [
							var_role.array_get(rt.new_string('name')),
						])]),
					rt.call_function('home_url', [
						rt.new_string('/newbloguser/${var_newuser_key.to_string()}/'),
					]),
				]))
				var_new_user_email.array_set('headers', '')
				var_new_user_email = rt.call_function('apply_filters', [
					rt.new_string('invited_user_email'),
					var_new_user_email.clone(),
					var_user_id.clone(),
					var_role.clone(),
					var_newuser_key.clone(),
				])
				rt.call_function('wp_mail', [var_new_user_email.array_get(rt.new_string('to')),
					var_new_user_email.array_get(rt.new_string('subject')),
					var_new_user_email.array_get(rt.new_string('message')),
					var_new_user_email.array_get(rt.new_string('headers'))])
				if rt.is_true(var_switched_locale) {
					rt.call_function('restore_previous_locale', []rt.PhpVal{})
				}
				var_redirect = rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'update', val: 'add' }]),
					rt.new_string('user-new.php'),
				])
			}
		}
		rt.call_function('wp_redirect', [var_redirect.clone()])
		exit(0)
	} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('createuser'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		rt.call_function('check_admin_referer', [rt.new_string('create-user'),
			rt.new_string('_wpnonce_create-user')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('create_users'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create users.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			var_user_id = rt.call_function('edit_user', []rt.PhpVal{})
			if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
				mut var_add_user_errors := var_user_id.clone()
			} else {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('list_users'),
				]))
				{
					var_redirect = rt.new_string('users.php?update=add&id=' + var_user_id.str())
				} else {
					var_redirect = rt.call_function('add_query_arg', [
						rt.new_string('update'),
						rt.new_string('add'),
						rt.new_string('user-new.php'),
					])
				}
				rt.call_function('wp_redirect', [var_redirect.clone()])
				exit(0)
			}
		} else {
			var_new_user_email = rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('email')),
			])
			var_user_details = rt.call_function('wpmu_validate_user_signup', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('user_login')),
				var_new_user_email.clone(),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_user_details.array_get(rt.new_string('errors'))]))
				&& rt.is_true(rt.call_method(var_user_details.array_get(rt.new_string('errors')), 'has_errors', []rt.PhpVal{})) {
				var_add_user_errors = var_user_details.array_get(rt.new_string('errors'))
			} else {
				mut var_new_user_login := rt.call_function('apply_filters', [
					rt.new_string('pre_user_login'),
					rt.call_function('sanitize_user', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_REQUEST').array_get(rt.new_string('user_login')),
						]),
						rt.new_bool(true),
					]),
				])
				if rt.get_superglobal('_POST').array_isset(rt.new_string('noconfirmation'))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])) {
					rt.call_function('add_filter', [
						rt.new_string('wpmu_signup_user_notification'),
						rt.new_string('__return_false'),
					])
					rt.call_function('add_filter', [
						rt.new_string('wpmu_welcome_user_notification'),
						rt.new_string('__return_false'),
					])
				}
				rt.call_function('wp_ensure_editable_role', [
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('role')),
				])
				rt.call_function('wpmu_signup_user', [var_new_user_login.clone(),
					var_new_user_email.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'add_to_blog', val: rt.call_function('get_current_blog_id',
							[]rt.PhpVal{}) },
						rt.ArrayItem{
							key: 'new_role'
							val: rt.get_superglobal('_REQUEST').array_get(rt.new_string('role'))
						},
					])])
				if rt.get_superglobal('_POST').array_isset(rt.new_string('noconfirmation'))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])) {
					mut var_key := rt.call_method(var_wpdb, 'get_var', [
						rt.call_method(var_wpdb, 'prepare', [
							rt.concat(rt.concat(rt.new_string('SELECT activation_key FROM '), rt.get_property(var_wpdb,
								'signups')),
								rt.new_string(' WHERE user_login = %s AND user_email = %s')),
							var_new_user_login.clone(),
							var_new_user_email.clone(),
						]),
					])
					mut var_new_user := rt.call_function('wpmu_activate_signup', [
						var_key.clone(),
					])
					if rt.is_true(rt.call_function('is_wp_error', [
						var_new_user.clone()]))
					{
						var_redirect = rt.call_function('add_query_arg', [
							rt.create_array([
								rt.ArrayItem{ key: 'update', val: 'addnoconfirmation' },
							]),
							rt.new_string('user-new.php'),
						])
					} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [
						var_new_user.array_get(rt.new_string('user_id')),
					])))))
					{
						var_redirect = rt.call_function('add_query_arg', [
							rt.create_array([
								rt.ArrayItem{ key: 'update', val: 'created_could_not_add' },
							]),
							rt.new_string('user-new.php'),
						])
					} else {
						var_redirect = rt.call_function('add_query_arg', [
							rt.create_array([
								rt.ArrayItem{ key: 'update', val: 'addnoconfirmation' },
								rt.ArrayItem{
									key: 'user_id'
									val: var_new_user.array_get(rt.new_string('user_id'))
								},
							]),
							rt.new_string('user-new.php'),
						])
					}
				} else {
					var_redirect = rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'update', val: 'newuserconfirmation' },
						]),
						rt.new_string('user-new.php'),
					])
				}
				rt.call_function('wp_redirect', [var_redirect.clone()])
				exit(0)
			}
		}
	}
	mut var_title := rt.call_function('__', [rt.new_string('Add User')])
	mut var_parent_file := 'users.php'
	mut var_do_both := false
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')])) {
		var_do_both = true
	}
	mut var_help := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('To add a new user to your site, fill in the form on this screen and click the Add User button at the bottom.')])).str() +
		'</p>')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Because this is a multisite installation, you may add accounts that already exist on the Network by specifying a username or email, and defining a role. For more options, such as specifying a password, you have to be a Network Administrator and use the hover link under an existing user&#8217;s name to Edit the user profile under Network Admin > All Users.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('New users will receive an email letting them know they&#8217;ve been added as a user for your site. This email will also contain their password. Check the box if you do not want the user to receive a welcome email.')])).str() +
			'</p>'))
	} else {
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('New users are automatically assigned a password, which they can change after logging in. You can view or edit the assigned password by clicking the Show Password button. The username cannot be changed once the user has been added.')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('By default, new users will receive an email letting them know they&#8217;ve been added as a user for your site. This email will also contain a password reset link. Uncheck the box if you do not want to send the new user a welcome email.')])).str() +
			'</p>'))
	}
	var_help = rt.concat(var_help, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Remember to click the Add User button at the bottom of this screen when you are finished.')])).str() +
		'</p>'))
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'user-roles' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('User Roles'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Here is a basic overview of the different user roles and the permissions associated with each one:')])).str() +
				'</p>' + '<ul>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Subscribers can read comments/comment/receive newsletters, etc. but cannot create regular site content.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Contributors can write and manage their posts but not publish posts or upload media files.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Authors can publish and manage their own posts, and are able to upload files.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Editors can publish posts, manage posts as well as manage other people&#8217;s posts, etc.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Administrators have access to all the administration features.')])).str() +
				'</li>' + '</ul>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/users-add-new-screen/">Documentation on Adding New Users</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-ajax-response')])
	rt.call_function('wp_enqueue_script', [rt.new_string('user-profile')])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')])))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))
		|| rt.is_true(rt.call_function('apply_filters', [rt.new_string('autocomplete_users_for_site_admins'), rt.new_bool(false)])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('user-suggest')])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
		mut var_messages := rt.new_array()
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
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
			mut switch_val_1 := rt.get_superglobal('_GET').array_get(rt.new_string('update'))
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('newuserconfirmation'))) {
				var_messages << rt.call_function('__', [
					rt.new_string('Invitation email sent to new user. A confirmation link must be clicked before their account is created.'),
				])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('add'))) {
				var_messages << rt.call_function('__', [
					rt.new_string('Invitation email sent to user. A confirmation link must be clicked for them to be added to your site.'),
				])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('addnoconfirmation'))) {
				var_message = rt.call_function('__', [
					rt.new_string('User has been added to your site.'),
				])
				if rt.is_true(var_edit_link) {
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' <a href="%s">%s</a>'),
						var_edit_link.clone(),
						rt.call_function('__', [rt.new_string('Edit user')]),
					]))
				}
				var_messages << var_message.clone()
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('addexisting'))) {
				var_messages << rt.call_function('__', [
					rt.new_string('That user is already a member of this site.'),
				])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('could_not_add'))) {
				var_add_user_errors = create_wp_error(rt.new_string('could_not_add'), rt.call_function('__', [
					rt.new_string('That user could not be added to this site.'),
				]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('created_could_not_add'))) {
				var_add_user_errors = create_wp_error(rt.new_string('created_could_not_add'), rt.call_function('__', [
					rt.new_string('User has been created, but could not be added to this site.'),
				]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('does_not_exist'))) {
				var_add_user_errors = create_wp_error(rt.new_string('does_not_exist'), rt.call_function('__', [
					rt.new_string('The requested user does not exist.'),
				]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enter_email'))) {
				var_add_user_errors = create_wp_error(rt.new_string('enter_email'), rt.call_function('__', [
					rt.new_string('Please enter a valid email address.'),
				]))
			}
		} else {
			if rt.is_true(rt.identical(rt.new_string('add'),
				rt.get_superglobal('_GET').array_get(rt.new_string('update'))))
			{
				var_messages << rt.call_function('__', [rt.new_string('User added.')])
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')])) {
		rt.call_function('_e', [rt.new_string('Add User')])
	} else if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('promote_users'),
	]))
	{
		rt.call_function('_e', [rt.new_string('Add Existing User')])
	}
	// unsupported statement: Stmt_InlineHTML
	if !var_errors.is_null() && rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) {
		mut var_error_message := ''
		mut iter_1 := rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_err := item_1.val
			var_error_message = var_error_message + '<li>${var_err.to_string()}</li>\n'
		}
		rt.call_function('wp_admin_notice', [
			rt.new_string('<ul>' + var_error_message + '</ul>'),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
				rt.ArrayItem{ key: 'paragraph_wrap', val: false },
			]),
		])
	}
	if !(!rt.is_true(var_messages)) {
		for var_msg in var_messages {
			rt.call_function('wp_admin_notice', [var_msg.clone(),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if !var_add_user_errors.is_null()
		&& rt.is_true(rt.call_function('is_wp_error', [var_add_user_errors.clone()])) {
		var_error_message = ''
		mut iter_2 :=
			rt.call_method(var_add_user_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_message_shadow := item_2.val
			var_error_message = var_error_message + '<p>${var_message.to_string()}</p>\n'
		}
		rt.call_function('wp_admin_notice', [rt.new_string(var_error_message.str()).clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
				rt.ArrayItem{ key: 'paragraph_wrap', val: false },
			])])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])) {
		if var_do_both {
			print('<h2 id="add-existing-user">' +
				(rt.call_function('__', [rt.new_string('Add Existing User')])).str() + '</h2>')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_users'),
		])))))
		{
			print('<p>' +
				(rt.call_function('__', [rt.new_string('Enter the email address of an existing user on this network to invite them to this site. That person will be sent an email asking them to confirm the invite.')])).str() +
				'</p>')
			mut var_label := rt.call_function('__', [rt.new_string('Email')])
			mut var_type := 'email'
		} else {
			print('<p>' +
				(rt.call_function('__', [rt.new_string('Enter the email address or username of an existing user on this network to invite them to this site. That person will be sent an email asking them to confirm the invite.')])).str() +
				'</p>')
			var_label = rt.call_function('__', [rt.new_string('Email or Username')])
			var_type = 'text'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('user_new_form_tag')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('add-user'),
			rt.new_string('_wpnonce_add-user')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_type.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Role')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_dropdown_roles', [
			rt.call_function('get_option', [rt.new_string('default_role')]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_network_users'),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Skip Confirmation Email')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Add the user without sending an email that requires their confirmation'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('user_new_form'),
			rt.new_string('add-existing-user')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Add Existing User')]),
			rt.new_string('primary'),
			rt.new_string('adduser'),
			rt.new_bool(true),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'addusersub' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')])) {
		if var_do_both {
			print('<h2 id="create-new-user">' +
				(rt.call_function('__', [rt.new_string('Add User')])).str() + '</h2>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Create a brand new user and add them to this site.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('user_new_form_tag')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('create-user'),
			rt.new_string('_wpnonce_create-user')])
		// unsupported statement: Stmt_InlineHTML
		mut var_creating :=
			rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('createuser')))
		var_new_user_login = if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('user_login')),
			]) } else { rt.new_string('') }
		mut var_new_user_firstname := if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('first_name')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('first_name')),
			]) } else { rt.new_string('') }
		mut var_new_user_lastname := if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('last_name')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('last_name')),
			]) } else { rt.new_string('') }
		var_new_user_email = if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('email')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('email')),
			]) } else { rt.new_string('') }
		mut var_new_user_uri := if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('url')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('url')),
			]) } else { rt.new_string('') }
		mut var_new_user_role := if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('role')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('role')),
			]) } else { rt.new_string('') }
		mut var_new_user_send_notification := if rt.is_true(var_creating)
			&& !(rt.get_superglobal('_POST').array_isset(rt.new_string('send_user_notification'))) {
			false
		} else {
			true
		}
		mut var_new_user_ignore_pass := if rt.is_true(var_creating) && rt.get_superglobal('_POST').array_isset(rt.new_string('noconfirmation')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('noconfirmation')),
			]) } else { rt.new_string('') }
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Username')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('(required)')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_new_user_login.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Email')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('(required)')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_new_user_email.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('First Name')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_new_user_firstname.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Last Name')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_new_user_lastname.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Website')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_new_user_uri.clone()]))
			// unsupported statement: Stmt_InlineHTML
			mut var_languages := rt.call_function('get_available_languages', []rt.PhpVal{})
			if rt.is_true(var_languages) {
				// unsupported statement: Stmt_InlineHTML
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Language')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('wp_dropdown_languages', [
					rt.create_array([rt.ArrayItem{ key: 'name', val: 'locale' },
						rt.ArrayItem{ key: 'id', val: 'locale' },
						rt.ArrayItem{ key: 'selected', val: 'site-default' },
						rt.ArrayItem{ key: 'languages', val: var_languages },
						rt.ArrayItem{ key: 'show_available_translations', val: false },
						rt.ArrayItem{ key: 'show_option_site_default', val: true }]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('(required)')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Generate password')])
			// unsupported statement: Stmt_InlineHTML
			mut var_initial_password := rt.call_function('wp_generate_password', [
				rt.new_int(24),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_initial_password.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Hide password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Hide')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Repeat Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('(required)')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Type the password again.')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Confirm Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Confirm use of weak password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Send User Notification')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_bool(var_new_user_send_notification).clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Send the new user an email about their account'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('promote_users'),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Role')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_new_user_role)))) {
				var_new_user_role = rt.call_function('get_option', [
					rt.new_string('default_role'),
				])
			}
			rt.call_function('wp_dropdown_roles', [var_new_user_role.clone()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Skip Confirmation Email')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_new_user_ignore_pass.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Add the user without sending an email that requires their confirmation'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('user_new_form'),
			rt.new_string('add-new-user')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Add User')]),
			rt.new_string('primary'),
			rt.new_string('createuser'),
			rt.new_bool(true),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'createusersub' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

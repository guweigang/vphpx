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

	mut var_current_user := rt.new_null()
	mut var_wp_roles := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_usersearch := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('list_users'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to list users.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Users_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [rt.new_string('Users')])
	mut var_parent_file := 'users.php'
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen lists all the existing users for your site. Each user has one of five defined roles as set by the site admin: Site Administrator, Editor, Author, Contributor, or Subscriber. Users with roles other than Administrator will see fewer options in the dashboard navigation when they are logged in, based on their role.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('To add a new user for your site, click the Add User button at the top of the screen or Add User in the Users menu section.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'screen-content' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Screen Content'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can customize the display of this screen in a number of ways:')])).str() +
				'</p>' + '<ul>' + '<li>' +
				(rt.call_function('__', [rt.new_string('You can hide/display columns based on your needs and decide how many users to list per screen using the Screen Options tab.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('You can filter the list of users by User Role using the text links above the users list to show All, Administrator, Editor, Author, Contributor, or Subscriber. The default view is to show all users. Unused User Roles are not listed.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('You can view all posts made by a user by clicking on the number under the Posts column.')])).str() +
				'</li>' + '</ul>' }]),
	])
	mut var_help := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Hovering over a row in the users list will display action links that allow you to manage users. You can perform the following actions:')])).str() +
		'</p>' + '<ul>' + '<li>' +
		(rt.call_function('__', [rt.new_string('<strong>Edit</strong> takes you to the editable profile screen for that user. You can also reach that screen by clicking on the username.')])).str() +
		'</li>')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_help = rt.concat(var_help, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('<strong>Remove</strong> allows you to remove a user from your site. It does not delete their content. You can also remove multiple users at once by using bulk actions.')])).str() +
			'</li>'))
	} else {
		var_help = rt.concat(var_help, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('<strong>Delete</strong> brings you to the Delete Users screen for confirmation, where you can permanently remove a user from your site and delete their content. You can also delete multiple users at once by using bulk actions.')])).str() +
			'</li>'))
	}
	var_help = rt.concat(var_help, rt.new_string('<li>' +
		(rt.call_function('__', [rt.new_string('<strong>View</strong> takes you to a public author archive which lists all the posts published by the user.')])).str() +
		'</li>'))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')])) {
		var_help = rt.concat(var_help, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('<strong>Send password reset</strong> sends the user an email with a link to set a new password.')])).str() +
			'</li>'))
	}
	var_help = rt.concat(var_help, rt.new_string('</ul>'))
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'action-links' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Available Actions'),
			]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
	])
	var_help = rt.new_null()
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/users-screen/">Documentation on Managing Users</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/roles-and-capabilities/">Descriptions of Roles and Capabilities</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter users list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Users list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Users list'),
			]) },
		]),
	])
	if !rt.is_true(rt.get_superglobal('_REQUEST')) {
		mut var_referer := rt.new_string('<input type="hidden" name="wp_http_referer" value="' +
			(rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])])).str() +
			'" />')
	} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_http_referer')) {
		mut var_redirect := rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'wp_http_referer' },
				rt.ArrayItem{ key: none, val: 'updated' }, rt.ArrayItem{
					key: none
					val: 'delete_count'
				}]),
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_http_referer'))]),
		])
		var_referer = rt.new_string('<input type="hidden" name="wp_http_referer" value="' +
			(rt.call_function('esc_attr', [var_redirect.clone()])).str() + '" />')
	} else {
		var_redirect = rt.new_string('users.php')
		var_referer = rt.new_string('')
	}
	mut var_update := ''
	mut switch_val_1 := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('promote'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('promote_users'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this user.'),
				]),
				rt.new_int(403),
			])
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users'))) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
		mut var_editable_roles := rt.call_function('get_editable_roles', []rt.PhpVal{})
		mut var_role := rt.get_superglobal('_REQUEST').array_get(rt.new_string('new_role'))
		var_editable_roles.array_set('none', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('&mdash; No role for this site &mdash;'),
			]) },
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_role))))
			|| !rt.is_true(var_editable_roles.array_get(var_role)) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to give users that role.'),
				]),
				rt.new_int(403),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('none'), var_role)) {
			var_role = rt.new_string('')
		}
		mut var_user_ids := rt.call_function('array_map', [rt.new_string('intval'),
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
		var_update = 'promote'
		mut iter_1 := var_user_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('promote_user'),
				var_id.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to edit this user.'),
					]),
					rt.new_int(403),
				])
			}
			if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
				if rt.is_true(rt.identical(rt.new_string(''), var_role)) {
					rt.call_function('wp_die', [
						rt.call_function('__', [
							rt.new_string('Sorry, you cannot remove your own role.'),
						]),
						rt.new_int(403),
					])
				}
				if rt.is_true(rt.call_method(rt.get_property(var_wp_roles, 'role_objects').array_get(var_role), 'has_cap', [rt.new_string('promote_users')]))
					|| (rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))) {
					continue
				}
				var_update = 'err_admin_role'
				continue
			}
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_id.clone()]))))) {
				rt.call_function('wp_die', [
					rt.new_string('<h1>' +
						(rt.call_function('__', [rt.new_string('An error occurred.')])).str() +
						'</h1>' + '<p>' +
						(rt.call_function('__', [rt.new_string('One of the selected users is not a member of this site.')])).str() +
						'</p>'),
					rt.new_int(403),
				])
			}
			mut var_user := rt.call_function('get_userdata', [
				var_id.clone()])
			rt.call_method(var_user, 'set_role', [var_role.clone()])
		}
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('update'),
				rt.new_string(var_update.str()).clone(), var_redirect.clone()]),
		])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('dodelete'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('User deletion is not allowed from this screen.'),
				]),
				rt.new_int(400),
			])
		}
		rt.call_function('check_admin_referer', [rt.new_string('delete-users')])
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users'))) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
		var_user_ids = rt.call_function('array_map', [rt.new_string('intval'),
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_option'))) {
			mut var_url := rt.call_function('self_admin_url', [
				rt.new_string('users.php?action=delete&users[]=' +
					(rt.call_function('implode', [rt.new_string('&users[]='), var_user_ids.clone()])).str() +
					'&error=true'),
			])
			var_url = rt.call_function('str_replace', [rt.new_string('&amp;'),
				rt.new_string('&'),
				rt.call_function('wp_nonce_url', [
					var_url.clone(), rt.new_string('bulk-users')])])
			rt.call_function('wp_redirect', [var_url.clone()])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_users'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to delete users.'),
				]),
				rt.new_int(403),
			])
		}
		var_update = 'del'
		mut var_delete_count := rt.new_int(0)
		mut iter_2 := var_user_ids.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_id := item_2.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_user'),
				var_id.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to delete that user.'),
					]),
					rt.new_int(403),
				])
			}
			if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
				var_update = 'err_admin_del'
				continue
			}
			mut switch_val_2 :=
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_option'))
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
				rt.call_function('wp_delete_user', [var_id.clone()])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('reassign'))) {
				rt.call_function('wp_delete_user', [var_id.clone(),
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('reassign_user'))])
			}
			rt.pre_inc(var_delete_count)
		}
		var_redirect = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'delete_count', val: var_delete_count },
				rt.ArrayItem{ key: 'update', val: var_update }]),
			var_redirect.clone(),
		])
		rt.call_function('wp_redirect', [var_redirect.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resetpassword'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_users'),
		])))))
		{
			mut var_errors := create_wp_error(rt.new_string('edit_users'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit users.'),
			]))
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users'))) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
		var_user_ids = rt.call_function('array_map', [rt.new_string('intval'),
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
		mut var_reset_count := rt.new_int(0)
		mut iter_3 := var_user_ids.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_id := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_user'),
				var_id.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to edit this user.'),
					]),
				])
			}
			if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
				var_update = 'err_admin_reset'
				continue
			}
			mut var_user := rt.call_function('get_userdata', [
				var_id.clone()])
			if rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('retrieve_password', [
				rt.get_property(var_user, 'user_login'),
			])))
			{
				rt.pre_inc(var_reset_count)
			}
		}
		var_redirect = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'reset_count', val: var_reset_count },
				rt.ArrayItem{ key: 'update', val: 'resetpassword' }]),
			var_redirect.clone(),
		])
		rt.call_function('wp_redirect', [var_redirect.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('User deletion is not allowed from this screen.'),
				]),
				rt.new_int(400),
			])
		}
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))
			&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('user'))) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_users'),
		])))))
		{
			var_errors = create_wp_error(rt.new_string('edit_users'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to delete users.'),
			]))
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users'))) {
			var_user_ids = rt.create_array([
				rt.ArrayItem{
					key: none
					val: rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('user'))).to_i64())
				},
			])
		} else {
			var_user_ids = rt.call_function('array_map', [rt.new_string('intval'),
				rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
		}
		mut var_all_user_ids := var_user_ids.clone()
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_current_user, 'ID'),
			var_user_ids.clone(),
			rt.new_bool(true),
		]))
		{
			var_user_ids = rt.call_function('array_diff', [var_user_ids.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(var_current_user, 'ID') },
				])])
		}
		mut var_users_have_content := rt.new_bool((rt.call_function('apply_filters', [
			rt.new_string('users_have_additional_content'),
			rt.new_bool(false),
			var_user_ids.clone(),
		])).to_bool())
		if rt.is_true(var_user_ids)
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_users_have_content)))) {
			if rt.is_true(rt.call_method(var_wpdb, 'get_var', [
				rt.new_string((
					rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_author IN( ')) +
					(rt.call_function('implode', [rt.new_string(','), var_user_ids.clone()])).str() +
					' )\n\t\t\t\tLIMIT 1').str()),
			]))
			{
				var_users_have_content = rt.new_bool(true)
			} else if rt.is_true(rt.call_method(var_wpdb, 'get_var', [
				rt.new_string((
					rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string('\n\t\t\t\tWHERE link_owner IN( ')) +
					(rt.call_function('implode', [rt.new_string(','), var_user_ids.clone()])).str() +
					' )\n\t\t\t\tLIMIT 1').str()),
			]))
			{
				var_users_have_content = rt.new_bool(true)
			}
		}
		if rt.is_true(var_users_have_content) {
			rt.call_function('add_action', [rt.new_string('admin_head'),
				rt.new_string('delete_users_add_js')])
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('delete-users')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_referer)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Delete Users')])
		// unsupported statement: Stmt_InlineHTML
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('error')) {
			rt.call_function('wp_admin_notice', [
				rt.new_string('<strong>' +
					(rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ' +
					(rt.call_function('__', [rt.new_string('Please select an option.')])).str()),
				rt.create_array([
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) },
				]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		if 1 == var_all_user_ids.clone().array_count() {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('You have specified this user for deletion:'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('You have specified these users for deletion:'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_go_delete := 0
		mut iter_4 := var_all_user_ids.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_id := item_4.val
			mut var_user := rt.call_function('get_userdata', [
				var_id.clone()])
			if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
				print('<li>')
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('ID #%1$s: %2$s <strong>The current user will not be deleted.</strong>'),
					]),
					var_id.clone(),
					rt.get_property(var_user, 'user_login'),
				])
				print('</li>\n')
			} else {
				print('<li>')
				rt.call_function('printf', [
					rt.new_string('<input type="hidden" name="users[]" value="%s" />'),
					rt.call_function('esc_attr', [var_id.clone()]),
				])
				rt.call_function('printf', [
					rt.call_function('__', [rt.new_string('ID #%1$s: %2$s')]),
					var_id.clone(),
					rt.get_property(var_user, 'user_login'),
				])
				print('</li>\n')
				var_go_delete += 1
			}
		}
		// unsupported statement: Stmt_InlineHTML
		if var_go_delete != 0 {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_users_have_content)))) {
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				if 1 == var_go_delete {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('What should be done with content owned by this user?'),
					])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('What should be done with content owned by these users?'),
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Delete all content.')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Attribute all content to:')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('wp_dropdown_users', [
					rt.create_array([rt.ArrayItem{ key: 'name', val: 'reassign_user' },
						rt.ArrayItem{ key: 'exclude', val: var_user_ids },
						rt.ArrayItem{ key: 'show', val: 'display_name_with_login' }]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			rt.call_function('do_action', [rt.new_string('delete_user_form'),
				var_current_user.clone(), var_user_ids.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Confirm Deletion')]),
				rt.new_string('primary'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('There are no valid users selected for deletion.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('doremove'))) {
		rt.call_function('check_admin_referer', [rt.new_string('remove-users')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('You cannot remove users.')]),
				rt.new_int(400),
			])
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users'))) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('remove_users'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to remove users.'),
				]),
				rt.new_int(403),
			])
		}
		var_user_ids = rt.call_function('array_map', [rt.new_string('intval'),
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
		var_update = 'remove'
		mut iter_5 := var_user_ids.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_id := item_5.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('remove_user'),
				var_id.clone(),
			])))))
			{
				var_update = 'err_admin_remove'
				continue
			}
			rt.call_function('remove_user_from_blog', [var_id.clone(),
				var_blog_id.clone()])
		}
		var_redirect = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'update', val: var_update }]),
			var_redirect.clone(),
		])
		rt.call_function('wp_redirect', [var_redirect.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('remove'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('You cannot remove users.')]),
				rt.new_int(400),
			])
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))
			&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('user'))) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('remove_users'),
		])))))
		{
			mut var_error := create_wp_error(rt.new_string('edit_users'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to remove users.'),
			]))
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users'))) {
			var_user_ids = rt.create_array([
				rt.ArrayItem{
					key: none
					val: rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('user'))).to_i64())
				},
			])
		} else {
			var_user_ids = rt.call_function('array_map', [rt.new_string('intval'),
				rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('remove-users')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_referer)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove Users from Site')])
		// unsupported statement: Stmt_InlineHTML
		if 1 == var_user_ids.clone().array_count() {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('You have specified this user for removal:'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('You have specified these users for removal:'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_go_remove := false
		mut iter_6 := var_user_ids.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_id := item_6.val
			mut var_user := rt.call_function('get_userdata', [
				var_id.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('remove_user'),
				var_id.clone(),
			])))))
			{
				print('<li>')
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('ID #%1$s: %2$s <strong>Sorry, you are not allowed to remove this user.</strong>'),
					]),
					var_id.clone(),
					rt.get_property(var_user, 'user_login'),
				])
				print('</li>\n')
			} else {
				print('<li>')
				rt.call_function('printf', [
					rt.new_string('<input type="hidden" name="users[]" value="%s" />'),
					rt.call_function('esc_attr', [var_id.clone()]),
				])
				rt.call_function('printf', [
					rt.call_function('__', [rt.new_string('ID #%1$s: %2$s')]),
					var_id.clone(),
					rt.get_property(var_user, 'user_login'),
				])
				print('</li>\n')
				var_go_remove = true
			}
		}
		// unsupported statement: Stmt_InlineHTML
		if var_go_remove {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Confirm Removal')]),
				rt.new_string('primary'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('There are no valid users selected for removal.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_wp_http_referer')))) {
			rt.call_function('wp_redirect', [
				rt.call_function('remove_query_arg', [
					rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
						rt.ArrayItem{ key: none, val: '_wpnonce' }]),
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
				]),
			])
			exit(0)
		}
		if rt.is_true(rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{}))
			&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))) {
			mut var_screen :=
				rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
			mut var_sendback := rt.call_function('wp_get_referer', []rt.PhpVal{})
			var_user_ids = rt.call_function('array_map', [rt.new_string('intval'),
				rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('users')))])
			var_sendback = rt.call_function('apply_filters', [
				rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
				var_sendback.clone(),
				rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{}),
				var_user_ids.clone(),
			])
			rt.call_function('wp_safe_redirect', [var_sendback.clone()])
			exit(0)
		}
		rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
		mut var_total_pages := rt.call_method(var_wp_list_table, 'get_pagination_arg', [
			rt.new_string('total_pages'),
		])
		if rt.is_true(rt.greater(var_pagenum, var_total_pages))
			&& rt.is_true(rt.greater(var_total_pages, rt.new_int(0))) {
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [rt.new_string('paged'),
					var_total_pages.clone()]),
			])
			exit(0)
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		mut var_messages := rt.new_array()
		if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
			mut switch_val_3 := rt.get_superglobal('_GET').array_get(rt.new_string('update'))
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('del')))
				|| rt.is_true(rt.equal(switch_val_3, rt.new_string('del_many'))) {
				var_delete_count = rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('delete_count')) {
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('delete_count'))).to_i64())
				} else {
					0
				})
				if rt.is_true(rt.identical(rt.new_int(1), var_delete_count)) {
					mut var_message := rt.call_function('__', [
						rt.new_string('User deleted.'),
					])
				} else {
					var_message = rt.call_function('_n', [
						rt.new_string('%s user deleted.'),
						rt.new_string('%s users deleted.'),
						var_delete_count.clone(),
					])
				}
				var_message = rt.call_function('sprintf', [var_message.clone(),
					rt.call_function('number_format_i18n', [var_delete_count.clone()])])
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					var_message.clone(),
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
						]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('add'))) {
				var_message = rt.call_function('__', [rt.new_string('New user created.')])
				mut var_user_id := if !(rt.get_superglobal('_GET').array_get(rt.new_string('id'))).is_null() {
					rt.get_superglobal('_GET').array_get(rt.new_string('id'))
				} else {
					rt.new_bool(false)
				}
				if rt.is_true(var_user_id)
					&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.clone()])) {
					var_message = rt.concat(var_message, rt.call_function('sprintf', [
						rt.new_string(' <a href="%1$s">%2$s</a>'),
						rt.call_function('esc_url', [
							rt.call_function('add_query_arg', [
								rt.new_string('wp_http_referer'),
								rt.call_function('urlencode', [
									rt.call_function('wp_unslash', [
										rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
									]),
								]),
								rt.call_function('self_admin_url', [
									rt.new_string('user-edit.php?user_id=' + var_user_id.str()),
								]),
							]),
						]),
						rt.call_function('__', [
							rt.new_string('Edit user'),
						]),
					]))
				}
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					var_message.clone(),
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
						]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('resetpassword'))) {
				var_reset_count = rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('reset_count')) {
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('reset_count'))).to_i64())
				} else {
					0
				})
				if rt.is_true(rt.identical(rt.new_int(1), var_reset_count)) {
					var_message = rt.call_function('__', [
						rt.new_string('Password reset link sent.'),
					])
				} else {
					var_message = rt.call_function('_n', [
						rt.new_string('Password reset links sent to %s user.'),
						rt.new_string('Password reset links sent to %s users.'),
						var_reset_count.clone(),
					])
				}
				var_message = rt.call_function('sprintf', [var_message.clone(),
					rt.call_function('number_format_i18n', [var_reset_count.clone()])])
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					var_message.clone(),
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
						]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('promote'))) {
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [rt.new_string('Changed roles.')]),
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
						]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('err_admin_role'))) {
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('You cannot change your own role to one that does not allow managing other users. Your role was not changed.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'error' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('Other user roles have been changed.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('err_admin_del'))) {
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('You cannot delete the current user.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'error' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('Other users have been deleted.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('remove'))) {
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('User removed from this site.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
							rt.ArrayItem{ key: none, val: 'fade' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
			} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('err_admin_remove'))) {
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('You cannot remove the current user.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'error' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
				var_messages.array_push(rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('Other users have been removed.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'updated' },
							rt.ArrayItem{ key: none, val: 'fade' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				]))
			}
		}
		// unsupported statement: Stmt_InlineHTML
		if !var_errors.is_null() && rt.is_true(rt.call_function('is_wp_error', [var_errors])) {
			mut var_error_message := ''
			mut iter_7 := var_errors.get_error_messages().iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_err := item_7.val
				var_error_message = var_error_message + '<li>${var_err.to_string()}</li>\n'
			}
			rt.call_function('wp_admin_notice', [
				rt.new_string('<ul>' + var_error_message + '</ul>'),
				rt.create_array([
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) },
				]),
			])
		}
		if !(!rt.is_true(var_messages)) {
			mut iter_8 := var_messages.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_msg := item_8.val
				rt.echo_val(var_msg)
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('create_users'),
		]))
		{
			rt.call_function('printf', [
				rt.new_string('<a href="%1$s" class="page-title-action">%2$s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [rt.new_string('user-new.php')]),
				]),
				rt.call_function('esc_html__', [
					rt.new_string('Add User'),
				]),
			])
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])) {
			rt.call_function('printf', [
				rt.new_string('<a href="%1$s" class="page-title-action">%2$s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [rt.new_string('user-new.php')]),
				]),
				rt.call_function('esc_html__', [
					rt.new_string('Add Existing User'),
				]),
			])
		}
		if rt.is_true(rt.new_int(var_usersearch.clone().to_string().len)) {
			print('<span class="subtitle">')
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Search results for: %s')]),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_usersearch.clone()])).str() + '</strong>'),
			])
			print('</span>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_wp_list_table, 'search_box', [
			rt.call_function('__', [rt.new_string('Search Users')]),
			rt.new_string('user'),
		])
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('role')))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('role')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

import rt

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to list users.')])).str() + '</p>', rt.new_int(403)])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_Users_List_Table')])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [rt.new_string('Users')])
	mut var_parent_file := 'users.php'
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen lists all the existing users for your site. Each user has one of five defined roles as set by the site admin: Site Administrator, Editor, Author, Contributor, or Subscriber. Users with roles other than Administrator will see fewer options in the dashboard navigation when they are logged in, based on their role.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('To add a new user for your site, click the Add User button at the top of the screen or Add User in the Users menu section.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'screen-content' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Screen Content')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can customize the display of this screen in a number of ways:')])).str() + '</p>' + '<ul>' + '<li>' + (rt.call_function('__', [rt.new_string('You can hide/display columns based on your needs and decide how many users to list per screen using the Screen Options tab.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('You can filter the list of users by User Role using the text links above the users list to show All, Administrator, Editor, Author, Contributor, or Subscriber. The default view is to show all users. Unused User Roles are not listed.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('You can view all posts made by a user by clicking on the number under the Posts column.')])).str() + '</li>' + '</ul>' }])])
	mut var_help := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Hovering over a row in the users list will display action links that allow you to manage users. You can perform the following actions:')])).str() + '</p>' + '<ul>' + '<li>' + (rt.call_function('__', [rt.new_string('<strong>Edit</strong> takes you to the editable profile screen for that user. You can also reach that screen by clicking on the username.')])).str() + '</li>')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')])) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'action-links' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Available Actions')]) }, rt.ArrayItem{ key: 'content', val: var_help }])])
	var_help = rt.new_null()
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/users-screen/">Documentation on Managing Users</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/roles-and-capabilities/">Descriptions of Roles and Capabilities</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [rt.new_string('Filter users list')]) }, rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [rt.new_string('Users list navigation')]) }, rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [rt.new_string('Users list')]) }])])
	if !rt.is_true(rt.get_superglobal('_REQUEST')) {
		mut var_referer := rt.new_string('<input type="hidden" name="wp_http_referer" value="' + (rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])).str() + '" />')
	} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_http_referer')) {
		mut var_redirect := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'wp_http_referer' }, rt.ArrayItem{ key: none, val: 'updated' }, rt.ArrayItem{ key: none, val: 'delete_count' }]), rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('wp_http_referer')])])
		var_referer = rt.new_string('<input type="hidden" name="wp_http_referer" value="' + (rt.call_function('esc_attr', [var_redirect.dup()])).str() + '" />')
	} else {
		var_redirect = rt.new_string(rt.new_string('users.php'))
		var_referer = rt.new_string(rt.new_string(''))
	}
	mut var_update := ''
	mut switch_val_1 := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('promote'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')]), rt.new_int(403)])
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('users')) {
			rt.call_function('wp_redirect', [var_redirect.dup()])
			// unsupported expression: Expr_Exit
		}
		mut var_editable_roles := rt.call_function('get_editable_roles', []rt.PhpVal{})
		mut var_role := rt.get_superglobal('_REQUEST').array_get('new_role')
		var_editable_roles.array_set('none', rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('&mdash; No role for this site &mdash;')]) }]))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_role)))) || !rt.is_true(var_editable_roles.array_get(var_role)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to give users that role.')]), rt.new_int(403)])
		}
		if rt.is_true(rt.identical(rt.new_string('none'), var_role)) {
			var_role = rt.new_string(rt.new_string(''))
		}
		mut var_user_ids := rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(rt.get_superglobal('_REQUEST').array_get('users'))])
		var_update = 'promote'
		{
			mut iter_1 := var_user_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_user'), var_id.dup()]))))) {
					rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')]), rt.new_int(403)])
				}
				if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
					if rt.is_true(rt.identical(rt.new_string(''), var_role)) {
						rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you cannot remove your own role.')]), rt.new_int(403)])
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(var_wp_roles, 'role_objects').array_get(var_role), 'has_cap', [rt.new_string('promote_users')])) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])))))) {
						continue
					}
					var_update = 'err_admin_role'
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_id.dup()]))))))) {
					rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('An error occurred.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('One of the selected users is not a member of this site.')])).str() + '</p>', rt.new_int(403)])
				}
				mut var_user := rt.call_function('get_userdata', [var_id.dup()])
				rt.call_method(var_user, 'set_role', [var_role.dup()])
			}
		}
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('update'), rt.new_string(var_update).dup(), var_redirect.dup()])])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('dodelete'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('User deletion is not allowed from this screen.')]), rt.new_int(400)])
		}
		rt.call_function('check_admin_referer', [rt.new_string('delete-users')])
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('users')) {
			rt.call_function('wp_redirect', [var_redirect.dup()])
			// unsupported expression: Expr_Exit
		}
		var_user_ids = rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(rt.get_superglobal('_REQUEST').array_get('users'))])
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('delete_option')) {
			mut var_url := rt.call_function('self_admin_url', ['users.php?action=delete&users[]=' + (rt.call_function('implode', [rt.new_string('&users[]='), var_user_ids.dup()])).str() + '&error=true'])
			var_url = rt.call_function('str_replace', [rt.new_string('&amp;'), rt.new_string('&'), rt.call_function('wp_nonce_url', [var_url.dup(), rt.new_string('bulk-users')])])
			rt.call_function('wp_redirect', [var_url.dup()])
			// unsupported expression: Expr_Exit
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete users.')]), rt.new_int(403)])
		}
		var_update = 'del'
		mut var_delete_count := rt.new_int(rt.new_int(0))
		{
			mut iter_1 := var_user_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_user'), var_id.dup()]))))) {
					rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete that user.')]), rt.new_int(403)])
				}
				if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
					var_update = 'err_admin_del'
					continue
				}
				mut switch_val_2 := rt.get_superglobal('_REQUEST').array_get('delete_option')
				if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
					rt.call_function('wp_delete_user', [var_id.dup()])
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('reassign'))) {
					rt.call_function('wp_delete_user', [var_id.dup(), rt.get_superglobal('_REQUEST').array_get('reassign_user')])
				}
				rt.pre_inc(var_delete_count)
			}
		}
		var_redirect = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'delete_count', val: var_delete_count }, rt.ArrayItem{ key: 'update', val: var_update }]), var_redirect.dup()])
		rt.call_function('wp_redirect', [var_redirect.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resetpassword'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')]))))) {
			mut var_errors := create_wp_error(rt.new_string('edit_users'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit users.')]))
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('users')) {
			rt.call_function('wp_redirect', [var_redirect.dup()])
			// unsupported expression: Expr_Exit
		}
		var_user_ids = rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(rt.get_superglobal('_REQUEST').array_get('users'))])
		mut var_reset_count := rt.new_int(rt.new_int(0))
		{
			mut iter_1 := var_user_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_id.dup()]))))) {
					rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')])])
				}
				if rt.is_true(rt.identical(var_id, rt.get_property(var_current_user, 'ID'))) {
					var_update = 'err_admin_reset'
					continue
				}
				mut var_user := rt.call_function('get_userdata', [var_id.dup()])
				if rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('retrieve_password', [rt.get_property(var_user, 'user_login')]))) {
					rt.pre_inc(var_reset_count)
				}
			}
		}
		var_redirect = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'reset_count', val: var_reset_count }, rt.ArrayItem{ key: 'update', val: 'resetpassword' }]), var_redirect.dup()])
		rt.call_function('wp_redirect', [var_redirect.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('User deletion is not allowed from this screen.')]), rt.new_int(400)])
		}
		rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('users')) && !rt.is_true(rt.get_superglobal('_REQUEST').array_get('user')) {
			rt.call_function('wp_redirect', [var_redirect.dup()])
			// unsupported expression: Expr_Exit
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')]))))) {
			var_errors = create_wp_error(rt.new_string('edit_users'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete users.')]))
		}
		if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('users')) {
			var_user_ids = rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }])
		} else {
			var_user_ids = rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(rt.get_superglobal('_REQUEST').array_get('users'))])
		}
		mut var_all_user_ids := var_user_ids.dup()
		if rt.is_true(rt.call_function('in_array', [rt.get_property(var_current_user, 'ID'), var_user_ids.dup(), rt.new_bool(true)])) {
			var_user_ids = rt.call_function('array_diff', [var_user_ids.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(, 'ID') }])])
		}
		mut var_users_have_content := // unsupported expression: Expr_Cast_Bool
		if rt.is_true(rt.new_bool(rt.is_true(var_user_ids) && rt.is_true(rt.new_bool(!(rt.is_true(var_users_have_content)))))) {
			if rt.is_true(rt.call_method(var_wpdb, 'get_var', [ + ])) {
				var_users_have_content = rt.new_bool()
			} else if rt.is_true(rt.call_method(, 'get_var', [])) {
				
			}
		}
		if rt.is_true(var_users_have_content) {
			
		}
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}

import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_sites')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this site.')]), rt.new_int(403)])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_Users_List_Table')])
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.call_function('get_site_screen_help_tab_args', []rt.PhpVal{})])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [rt.call_function('get_site_screen_help_sidebar_content', []rt.PhpVal{})])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [rt.new_string('Filter site users list')]) }, rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [rt.new_string('Site users list navigation')]) }, rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [rt.new_string('Site users list')]) }])])
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [rt.new_string('update'), rt.get_superglobal('_SERVER').array_get('REQUEST_URI')]))
	mut var_referer := rt.call_function('remove_query_arg', [rt.new_string('update'), rt.call_function('wp_get_referer', []rt.PhpVal{})])
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('paged'))) {
		var_referer = rt.call_function('add_query_arg', [rt.new_string('paged'), // unsupported expression: Expr_Cast_Int, var_referer.dup()])
	}
	mut var_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid site ID.')])])
	}
	mut var_details := rt.call_function('get_site', [var_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_details)))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('The requested site does not exist.')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('can_edit_network', [rt.get_property(var_details, 'site_id')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
	}
	mut var_is_main_site := rt.call_function('is_main_site', [var_id.dup()])
	rt.call_function('switch_to_blog', [var_id.dup()])
	mut var_action := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(var_action) {
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('newuser'))) {
			rt.call_function('check_admin_referer', [rt.new_string('add-user'), rt.new_string('_wpnonce_add-new-user')])
			mut var_user := rt.get_superglobal('_POST').array_get('user')
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('user').is_array()))))) || !rt.is_true(var_user.array_get('username')))) || !rt.is_true(var_user.array_get('email')))) {
				mut var_update := rt.new_string(rt.new_string('err_new'))
			} else {
				mut var_password := rt.call_function('wp_generate_password', [rt.new_int(12), rt.new_bool(false)])
				mut var_user_id := rt.call_function('wpmu_create_user', [rt.call_function('esc_html', [rt.new_string(var_user.array_get('username').to_string().to_lower())]), var_password.dup(), rt.call_function('esc_html', [var_user.array_get('email')])])
				if rt.is_true(rt.identical(rt.new_bool(false), var_user_id)) {
					var_update = rt.new_string(rt.new_string('err_new_dup'))
				} else {
					mut var_result := rt.call_function('add_user_to_blog', [var_id.dup(), var_user_id.dup(), rt.get_superglobal('_POST').array_get('new_role')])
					if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
						var_update = rt.new_string(rt.new_string('err_add_fail'))
					} else {
						var_update = rt.new_string(rt.new_string('newuser'))
						rt.call_function('do_action', [rt.new_string('network_site_users_created_user'), var_user_id.dup()])
					}
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('adduser'))) {
			rt.call_function('check_admin_referer', [rt.new_string('add-user'), rt.new_string('_wpnonce_add-user')])
			if !(!rt.is_true(rt.get_superglobal('_POST').array_get('newuser'))) {
				var_update = rt.new_string(rt.new_string('adduser'))
				mut var_newuser := rt.get_superglobal('_POST').array_get('newuser')
				var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_newuser.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(var_user) && rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{})))) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [rt.get_property(var_user, 'ID'), var_id.dup()]))))) {
						var_result = rt.call_function('add_user_to_blog', [var_id.dup(), rt.get_property(var_user, 'ID'), rt.get_superglobal('_POST').array_get('new_role')])
						if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
							var_update = rt.new_string(rt.new_string('err_add_fail'))
						}
					} else {
						var_update = rt.new_string(rt.new_string('err_add_member'))
					}
				} else {
					var_update = rt.new_string(rt.new_string('err_add_notfound'))
				}
			} else {
				var_update = rt.new_string(rt.new_string('err_add_notfound'))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('remove'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('remove_users')]))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to remove users.')]), rt.new_int(403)])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
			var_update = rt.new_string(rt.new_string('remove'))
			if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('users')) {
				mut var_userids := rt.get_superglobal('_REQUEST').array_get('users')
				{
					mut iter_1 := var_userids.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_user_id_shadow := item_1.val
						var_user_id_shadow = // unsupported expression: Expr_Cast_Int
						rt.call_function('remove_user_from_blog', [var_user_id_shadow.dup(), var_id.dup()])
					}
				}
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('user')) {
				rt.call_function('remove_user_from_blog', [rt.get_superglobal('_GET').array_get('user')])
			} else {
				var_update = rt.new_string(rt.new_string('err_remove'))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('promote'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')]), rt.new_int(403)])
			}
			mut var_editable_roles := rt.call_function('get_editable_roles', []rt.PhpVal{})
			mut var_role := rt.get_superglobal('_REQUEST').array_get('new_role')
			var_editable_roles.array_set('none', rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('&mdash; No role for this site &mdash;')]) }]))
			if !rt.is_true(var_editable_roles.array_get(var_role)) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to give users that role.')]), rt.new_int(403)])
			}
			if rt.is_true(rt.identical(rt.new_string('none'), var_role)) {
				var_role = rt.new_string(rt.new_string(''))
			}
			if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('users')) {
				var_userids = rt.get_superglobal('_REQUEST').array_get('users')
				var_update = rt.new_string(rt.new_string('promote'))
				{
					mut iter_1 := var_userids.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_user_id_shadow := item_1.val
						var_user_id_shadow = // unsupported expression: Expr_Cast_Int
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_user'), var_user_id_shadow.dup()]))))) {
							rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')]), rt.new_int(403)])
						}
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [var_user_id_shadow.dup()]))))) {
							rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('An error occurred.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('One of the selected users is not a member of this site.')])).str() + '</p>', rt.new_int(403)])
						}
						var_user = rt.call_function('get_userdata', [var_user_id_shadow.dup()])
						rt.call_method(var_user, 'set_role', [var_role.dup()])
					}
				}
			} else {
				var_update = rt.new_string(rt.new_string('err_promote'))
			}
		} else {
			if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('users'))) {
				break
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-users')])
			var_userids = rt.get_superglobal('_REQUEST').array_get('users')
			var_referer = rt.call_function('apply_filters', ['handle_network_bulk_actions-' + (rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')).str(), var_referer.dup(), var_action.dup(), var_userids.dup(), var_id.dup()])
			var_update = var_action.dup()
		}
		rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.new_string('update'), var_update.dup(), var_referer.dup()])])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.new_string('update-site'), rt.get_superglobal('_GET').array_get('action'))))) {
		rt.call_function('wp_safe_redirect', [var_referer.dup()])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	mut var_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Edit Site: %s')]), rt.call_function('esc_html', [rt.get_property(var_details, 'blogname')])])
	mut var_parent_file := 'sites.php'
	mut var_submenu_file := 'sites.php'
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')]))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('show_network_site_users_add_existing_form'), rt.new_bool(true)])))) {
		rt.call_function('wp_enqueue_script', [rt.new_string('user-suggest')])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('get_home_url', [var_id.dup(), rt.new_string('/')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Visit')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('get_admin_url', [var_id.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dashboard')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('network_edit_site_nav', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id }, rt.ArrayItem{ key: 'selected', val: 'site-users' }])])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
		mut var_message := rt.new_string(rt.new_string(''))
		mut var_type := 'error'
		mut switch_val_2 := rt.get_superglobal('_GET').array_get('update')
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('adduser'))) {
			var_type = 'success'
			var_message = 
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('err_add_member'))) {
			
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		} else if rt.is_true(rt.equal(switch_val_2, )) {
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

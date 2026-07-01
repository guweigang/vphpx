import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_usersearch := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		rt.call_function('do_action', [rt.new_string('wpmuadminedit')])
		mut switch_val_1 := rt.get_superglobal('_GET').array_get('action')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('deleteuser'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
			}
			rt.call_function('check_admin_referer', [rt.new_string('deleteuser')])
			mut var_id := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.greater(var_id, rt.new_int(1))) {
				rt.get_superglobal('_POST').array_set('allusers', rt.create_array([rt.ArrayItem{ key: none, val: var_id }]))
				mut var_title := rt.call_function('__', [rt.new_string('Users')])
				mut var_parent_file := 'users.php'
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
				print('<div class="wrap">')
				rt.call_function('confirm_delete_users', [rt.get_superglobal('_POST').array_get('allusers')])
				print('</div>')
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			} else {
				rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string('users.php')])])
			}
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('allusers'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
			}
			if rt.get_superglobal('_POST').array_isset(rt.new_string('action')) && rt.get_superglobal('_POST').array_isset(rt.new_string('allusers')) {
				rt.call_function('check_admin_referer', [rt.new_string('bulk-users-network')])
				mut var_doaction := rt.get_superglobal('_POST').array_get('action')
				mut var_userfunction := ''
				{
					mut iter_1 := rt.cast_array(rt.get_superglobal('_POST').array_get('allusers')).iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_user_id := item_1.val
						if !(!rt.is_true(var_user_id)) {
							mut switch_val_2 := var_doaction
							if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
								if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')]))))) {
									rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
								}
								var_title = rt.call_function('__', [rt.new_string('Users')])
								var_parent_file = 'users.php'
								rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
								print('<div class="wrap">')
								rt.call_function('confirm_delete_users', [rt.get_superglobal('_POST').array_get('allusers')])
								print('</div>')
								rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
								// unsupported expression: Expr_Exit
							} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('spam'))) {
								mut var_user := rt.call_function('get_userdata', [var_user_id.dup()])
								if rt.is_true(rt.call_function('is_super_admin', [rt.get_property(var_user, 'ID')])) {
									rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Warning! User cannot be modified. The user %s is a network administrator.')]), rt.call_function('esc_html', [rt.get_property(var_user, 'user_login')])]), rt.new_int(403)])
								}
								var_userfunction = 'all_spam'
								if rt.is_true(rt.call_function('apply_filters', [rt.new_string('propagate_network_user_spam_to_blogs'), rt.new_bool(false), var_user_id.dup()])) {
									{
										mut iter_2 := rt.call_function('get_blogs_of_user', [var_user_id.dup(), rt.new_bool(true)]).iterator()
										for {
											item_2 := iter_2.next() or { break }
											mut var_details := item_2.val
											if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [rt.get_property(var_details, 'userblog_id')]))))) {
												rt.call_function('update_blog_status', [rt.get_property(var_details, 'userblog_id'), rt.new_string('spam'), rt.new_string('1')])
											}
										}
									}
								}
								mut var_user_data := rt.call_method(var_user, 'to_array', []rt.PhpVal{})
								var_user_data.array_set('spam', '1')
								rt.call_function('wp_update_user', [var_user_data.dup()])
							} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('notspam'))) {
								var_user = rt.call_function('get_userdata', [var_user_id.dup()])
								if rt.is_true(rt.call_function('is_super_admin', [rt.get_property(var_user, 'ID')])) {
									rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Warning! User cannot be modified. The user %s is a network administrator.')]), rt.call_function('esc_html', [rt.get_property(var_user, 'user_login')])]), rt.new_int(403)])
								}
								var_userfunction = 'all_notspam'
								mut var_blogs := rt.call_function('get_blogs_of_user', [var_user_id.dup(), rt.new_bool(true)])
								if rt.is_true(rt.call_function('apply_filters', [rt.new_string('propagate_network_user_spam_to_blogs'), rt.new_bool(false), var_user_id.dup()])) {
									{
										mut iter_2 := rt.call_function('get_blogs_of_user', [var_user_id.dup(), rt.new_bool(true)]).iterator()
										for {
											item_2 := iter_2.next() or { break }
											mut var_details := item_2.val
											if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [rt.get_property(var_details, 'userblog_id')]))))) && rt.is_true(rt.identical(rt.call_function('get_current_network_id', []rt.PhpVal{}), rt.get_property(var_details, 'site_id'))))) {
												rt.call_function('update_blog_status', [rt.get_property(var_details, 'userblog_id'), rt.new_string('spam'), rt.new_string('0')])
											}
										}
									}
								}
								var_user_data = rt.call_method(var_user, 'to_array', []rt.PhpVal{})
								var_user_data.array_set('spam', '0')
								rt.call_function('wp_update_user', [var_user_data.dup()])
							}
						}
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_doaction.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'delete' }, rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'notspam' }]), rt.new_bool(true)]))))) {
					mut var_sendback := rt.call_function('wp_get_referer', []rt.PhpVal{})
					mut var_user_ids := rt.cast_array(rt.get_superglobal('_POST').array_get('allusers'))
					var_sendback = rt.call_function('apply_filters', ['handle_network_bulk_actions-' + (rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')).str(), var_sendback.dup(), var_doaction.dup(), var_user_ids.dup()])
					rt.call_function('wp_safe_redirect', [var_sendback.dup()])
					// unsupported expression: Expr_Exit
				}
				rt.call_function('wp_safe_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'updated', val: 'true' }, rt.ArrayItem{ key: 'action', val: var_userfunction }]), rt.call_function('wp_get_referer', []rt.PhpVal{})])])
			} else {
				mut var_location := rt.call_function('network_admin_url', [rt.new_string('users.php')])
				if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('paged'))) {
					var_location = rt.call_function('add_query_arg', [rt.new_string('paged'), // unsupported expression: Expr_Cast_Int, var_location.dup()])
				}
				rt.call_function('wp_redirect', [var_location.dup()])
			}
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('dodelete'))) {
			rt.call_function('check_admin_referer', [rt.new_string('ms-users-delete')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')]))))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('blog'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('blog').is_array())))) {
				{
					mut iter_1 := rt.get_superglobal('_POST').array_get('blog').iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_users := item_1.val
						mut var_id_shadow := item_1.key
						{
							mut iter_2 := var_users.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_user_id := item_2.val
								mut var_blogid := item_2.key
								if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_user'), var_id_shadow.dup()]))))) {
									continue
								}
								if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('delete'))) && rt.is_true(rt.identical(rt.new_string('reassign'), rt.get_superglobal('_POST').array_get('delete').array_get(var_blogid).array_get(var_id_shadow))))) {
									rt.call_function('remove_user_from_blog', [var_id_shadow.dup(), var_blogid.dup(), // unsupported expression: Expr_Cast_Int])
								} else {
									rt.call_function('remove_user_from_blog', [var_id_shadow.dup(), var_blogid.dup()])
								}
							}
						}
					}
				}
			}
			mut var_i := 0
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('user').is_array())) && !(!rt.is_true(rt.get_superglobal('_POST').array_get('user'))))) {
				{
					mut iter_1 := rt.get_superglobal('_POST').array_get('user').iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_id_shadow := item_1.val
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_user'), var_id_shadow.dup()]))))) {
							continue
						}
						rt.call_function('wpmu_delete_user', [var_id_shadow.dup()])
						var_i += 1
					}
				}
			}
			if 1 == var_i {
				mut var_deletefunction := 'delete'
			} else {
				var_deletefunction = 'all_delete'
			}
			rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'updated', val: 'true' }, rt.ArrayItem{ key: 'action', val: var_deletefunction }]), rt.call_function('network_admin_url', [rt.new_string('users.php')])])])
			// unsupported expression: Expr_Exit
		}
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_MS_Users_List_Table')])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	mut var_total_pages := rt.call_method(var_wp_list_table, 'get_pagination_arg', [rt.new_string('total_pages')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_pagenum, var_total_pages)) && rt.is_true(rt.greater(var_total_pages, rt.new_int(0))))) {
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('paged'), var_total_pages.dup()])])
		// unsupported expression: Expr_Exit
	}
	var_title = rt.call_function('__', [rt.new_string('Users')])
	var_parent_file = 'users.php'
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val:  +  + '<p>' + (rt.call_function('__', [rt.new_string('You can also go to the user&#8217;s profile page by clicking on the individual username.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can sort the table by clicking on any of the table headings and switch between list and excerpt views by using the icons above the users list.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('The bulk action will permanently delete selected users, or mark/unmark those selected as spam. Spam users will have posts removed and will be unable to sign up again with the same email addresses.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can make an existing user an additional super admin by going to the Edit User profile page and checking the box to grant that privilege.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Network_Admin_Users_Screen">Documentation on Network Users</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() + '</p>'])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [rt.new_string('Filter users list')]) }, rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [rt.new_string('Users list navigation')]) }, rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [rt.new_string('Users list')]) }])])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('updated')) && rt.is_true(rt.identical(rt.new_string('true'), rt.get_superglobal('_REQUEST').array_get('updated'))))) && !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))))) {
		mut var_message := rt.new_string(rt.new_string(''))
		mut switch_val_3 := rt.get_superglobal('_REQUEST').array_get('action')
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('delete'))) {
			var_message = rt.call_function('__', [rt.new_string('User deleted.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('all_spam'))) {
			var_message = rt.call_function('__', [rt.new_string('Users marked as spam.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('all_notspam'))) {
			var_message = rt.call_function('__', [rt.new_string('Users removed from spam.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('all_delete'))) {
			var_message = rt.call_function('__', [rt.new_string('Users deleted.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('add'))) {
			var_message = rt.call_function('__', [rt.new_string('User added.')])
		}
		rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' }, rt.ArrayItem{ key: 'dismissible', val: true }, rt.ArrayItem{ key: 'id', val: 'message' }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Users')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	// unsupported statement: Stmt_InlineHTML
}

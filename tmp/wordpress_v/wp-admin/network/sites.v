import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_s := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_sites')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_MS_Sites_List_Table')])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [rt.new_string('Sites')])
	mut var_parent_file := 'sites.php'
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Add Site takes you to the screen for adding a new site to the network. You can search for a site by Name, ID number, or IP address. Screen Options allows you to choose how many sites to display on one page.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('This is the main table of all sites on this network. Switch between list and excerpt views by using the icons above the right side of the table.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Hovering over each site reveals seven options (three for the primary site):')])).str() + '</p>' + '<ul><li>' + (rt.call_function('__', [rt.new_string('An Edit link to a separate Edit Site screen.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('Dashboard leads to the Dashboard for that site.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('Flag for Deletion, Archive, and Spam which lead to confirmation screens. These actions can be reversed later.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('Delete Permanently which is a permanent action after the confirmation screen.')])).str() + '</li>' + '<li>' + (rt.call_function('__', [rt.new_string('Visit to go to the front-end of the live site.')])).str() + '</li></ul>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-sites-screen">Documentation on Site Management</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() + '</p>'])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [rt.new_string('Sites list navigation')]) }, rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [rt.new_string('Sites list')]) }])])
	mut var_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		rt.call_function('do_action', [rt.new_string('wpmuadminedit')])
		mut var_manage_actions := rt.create_array([rt.ArrayItem{ key: 'activateblog', val: rt.call_function('__', [rt.new_string('You are about to remove the deletion flag from the site %s.')]) }, rt.ArrayItem{ key: 'deactivateblog', val: rt.call_function('__', [rt.new_string('You are about to flag the site %s for deletion.')]) }, rt.ArrayItem{ key: 'unarchiveblog', val: rt.call_function('__', [rt.new_string('You are about to unarchive the site %s.')]) }, rt.ArrayItem{ key: 'archiveblog', val: rt.call_function('__', [rt.new_string('You are about to archive the site %s.')]) }, rt.ArrayItem{ key: 'unspamblog', val: rt.call_function('__', [rt.new_string('You are about to unspam the site %s.')]) }, rt.ArrayItem{ key: 'spamblog', val: rt.call_function('__', [rt.new_string('You are about to mark the site %s as spam.')]) }, rt.ArrayItem{ key: 'deleteblog', val: rt.call_function('__', [rt.new_string('You are about to delete the site %s.')]) }, rt.ArrayItem{ key: 'unmatureblog', val: rt.call_function('__', [rt.new_string('You are about to mark the site %s as mature.')]) }, rt.ArrayItem{ key: 'matureblog', val: rt.call_function('__', [rt.new_string('You are about to mark the site %s as not mature.')]) }])
		if rt.is_true(rt.identical(rt.new_string('confirm'), rt.get_superglobal('_GET').array_get('action'))) {
			mut var_site_action := rt.get_superglobal('_GET').array_get('action2')
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_manage_actions.dup().array_isset(var_site_action.dup())))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('The requested action is not valid.')])])
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('matureblog'), var_site_action)) || rt.is_true(rt.identical(rt.new_string('unmatureblog'), var_site_action)))) {
				rt.call_function('check_admin_referer', [rt.new_string('confirm')])
			} else {
				rt.call_function('check_admin_referer', [(var_site_action).str() + '_' + (var_id).str()])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
				rt.call_function('nocache_headers', []rt.PhpVal{})
				rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
			}
			if rt.is_true(rt.call_function('is_main_site', [var_id.dup()])) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to change the current site.')])])
			}
			mut var_site_details := rt.call_function('get_site', [var_id.dup()])
			mut var_site_address := rt.call_function('untrailingslashit', [rt.concat(rt.get_property(var_site_details, 'domain'), rt.get_property(var_site_details, 'path'))])
			mut var_submit := rt.call_function('__', [rt.new_string('Confirm')])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Confirm your action')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_site_action.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_site_action.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wp_get_referer', []rt.PhpVal{})]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_nonce_field', [(var_site_action).str() + '_' + (var_id).str(), rt.new_string('_wpnonce'), rt.new_bool(false)])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.new_string('deleteblog'), var_site_action)) {
				var_submit = rt.call_function('__', [rt.new_string('Delete this site permanently')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Deleting a site is a permanent action that cannot be undone. This will delete the entire site and its uploads directory.')])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.identical(rt.new_string('archiveblog'), var_site_action)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Archiving a site makes the site unavailable to its users and visitors. This is a reversible action.')])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.identical(rt.new_string('deactivateblog'), var_site_action)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Flagging a site for deletion makes the site unavailable to its users and visitors. This is a reversible action. A super admin can permanently delete the site at a later date.')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [var_manage_actions.array_get(var_site_action), rt.new_string("<strong>${var_site_address.to_string()}</strong>")])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('submit_button', [var_submit.dup(), rt.new_string('primary')])
			// unsupported statement: Stmt_InlineHTML
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.new_bool(var_manage_actions.dup().array_isset(rt.get_superglobal('_GET').array_get('action')))) {
			mut var_action := rt.get_superglobal('_GET').array_get('action')
			rt.call_function('check_admin_referer', [(var_action).str() + '_' + (var_id).str()])
		} else if rt.is_true(rt.identical(rt.new_string('allblogs'), rt.get_superglobal('_GET').array_get('action'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-sites')])
		}
		mut var_updated_action := rt.new_string(rt.new_string(''))
		mut switch_val_1 := rt.get_superglobal('_GET').array_get('action')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('deleteblog'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_sites')]))))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: 'response', val: 403 }])])
			}
			var_updated_action = rt.new_string(rt.new_string('not_deleted'))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [var_id.dup()]))))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_site'), var_id.dup()])))) {
				rt.call_function('wpmu_delete_blog', [var_id.dup(), rt.new_bool(true)])
				var_updated_action = rt.new_string(rt.new_string('delete'))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_sites'))) {
			rt.call_function('check_admin_referer', [rt.new_string('ms-delete-sites')])
			{
				mut iter_1 := rt.cast_array(rt.get_superglobal('_POST').array_get('site_ids')).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_site_id := item_1.val
					var_site_id = // unsupported expression: Expr_Cast_Int
					if rt.is_true(rt.call_function('is_main_site', [var_site_id.dup()])) {
						continue
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_site'), var_site_id.dup()]))))) {
						mut var_site := rt.call_function('get_site', [var_site_id.dup()])
						var_site_address = rt.call_function('untrailingslashit', [rt.concat(rt.get_property(var_site, 'domain'), rt.get_property(var_site, 'path'))])
						rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete the site %s.')]), var_site_address.dup()]), rt.new_int(403)])
					}
					var_updated_action = rt.new_string(rt.new_string('all_delete'))
					rt.call_function('wpmu_delete_blog', [var_site_id.dup(), rt.new_bool(true)])
				}
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('allblogs'))) {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('action')) && rt.get_superglobal('_POST').array_isset(rt.new_string('allblogs')) {
				mut var_doaction := rt.get_superglobal('_POST').array_get('action')
				{
					mut iter_1 := rt.cast_array(rt.get_superglobal('_POST').array_get('allblogs')).iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_site_id := item_1.val
						var_site_id = // unsupported expression: Expr_Cast_Int
						if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [var_site_id.dup()]))))))) {
							mut switch_val_2 := var_doaction
							if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
								rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
								// unsupported statement: Stmt_InlineHTML
								rt.call_function('_e', [rt.new_string('Confirm your action')])
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wp_get_referer', []rt.PhpVal{})]))
								// unsupported statement: Stmt_InlineHTML
								rt.call_function('wp_nonce_field', [rt.new_string('ms-delete-sites'), rt.new_string('_wpnonce'), rt.new_bool(false)])
								// unsupported statement: Stmt_InlineHTML
								rt.call_function('_e', [rt.new_string('Deleting a site is a permanent action that cannot be undone. This will delete the entire site and its uploads directory.')])
								// unsupported statement: Stmt_InlineHTML
								rt.call_function('_e', [rt.new_string('You are about to delete the following sites:')])
								// unsupported statement: Stmt_InlineHTML
								{
									mut iter_2 := rt.get_superglobal('_POST').array_get('allblogs').iterator()
									for {
										item_2 := iter_2.next() or { break }
										mut var_site_id_shadow := item_2.val
										var_site_id_shadow = // unsupported expression: Expr_Cast_Int
										mut var_site := rt.call_function('get_site', [var_site_id_shadow.dup()])
										var_site_address = rt.call_function('untrailingslashit', [rt.concat(rt.get_property(var_site, 'domain'), rt.get_property(var_site, 'path'))])
										// unsupported statement: Stmt_InlineHTML
										rt.echo_val(var_site_address)
										// unsupported statement: Stmt_InlineHTML
										rt.echo_val(rt.call_function('esc_attr', [.dup()]))
										// unsupported statement: Stmt_InlineHTML
									}
								}
							} else if rt.is_true(rt.equal(switch_val_2, )) || rt.is_true(rt.equal(switch_val_2, )) {
							}
						} else {
						}
					}
				}
				if rt.is_true() {
				}
			} else {
				
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('archiveblog'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('unarchiveblog'))) {
			
		} else if rt.is_true(rt.equal(switch_val_1, )) {
		} else if rt.is_true(rt.equal(switch_val_1, )) {
		} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
		} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
		}
	}
	
}

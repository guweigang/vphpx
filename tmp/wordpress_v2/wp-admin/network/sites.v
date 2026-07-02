import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_s := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_sites'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to access this page.'),
			]),
			rt.new_int(403),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_MS_Sites_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [rt.new_string('Sites')])
	mut var_parent_file := 'sites.php'
	rt.call_function('add_screen_option', [rt.new_string('per_page')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Add Site takes you to the screen for adding a new site to the network. You can search for a site by Name, ID number, or IP address. Screen Options allows you to choose how many sites to display on one page.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('This is the main table of all sites on this network. Switch between list and excerpt views by using the icons above the right side of the table.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Hovering over each site reveals seven options (three for the primary site):')])).str() +
				'</p>' + '<ul><li>' +
				(rt.call_function('__', [rt.new_string('An Edit link to a separate Edit Site screen.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Dashboard leads to the Dashboard for that site.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Flag for Deletion, Archive, and Spam which lead to confirmation screens. These actions can be reversed later.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Delete Permanently which is a permanent action after the confirmation screen.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Visit to go to the front-end of the live site.')])).str() +
				'</li></ul>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-sites-screen">Documentation on Site Management</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Sites list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Sites list'),
			]) },
		]),
	])
	mut var_id := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		rt.call_function('do_action', [rt.new_string('wpmuadminedit')])
		mut var_manage_actions := rt.create_array([
			rt.ArrayItem{ key: 'activateblog', val: rt.call_function('__', [
				rt.new_string('You are about to remove the deletion flag from the site %s.'),
			]) },
			rt.ArrayItem{ key: 'deactivateblog', val: rt.call_function('__', [
				rt.new_string('You are about to flag the site %s for deletion.'),
			]) },
			rt.ArrayItem{ key: 'unarchiveblog', val: rt.call_function('__', [
				rt.new_string('You are about to unarchive the site %s.'),
			]) },
			rt.ArrayItem{ key: 'archiveblog', val: rt.call_function('__', [
				rt.new_string('You are about to archive the site %s.'),
			]) },
			rt.ArrayItem{ key: 'unspamblog', val: rt.call_function('__', [
				rt.new_string('You are about to unspam the site %s.'),
			]) },
			rt.ArrayItem{ key: 'spamblog', val: rt.call_function('__', [
				rt.new_string('You are about to mark the site %s as spam.'),
			]) },
			rt.ArrayItem{ key: 'deleteblog', val: rt.call_function('__', [
				rt.new_string('You are about to delete the site %s.'),
			]) },
			rt.ArrayItem{ key: 'unmatureblog', val: rt.call_function('__', [
				rt.new_string('You are about to mark the site %s as mature.'),
			]) },
			rt.ArrayItem{ key: 'matureblog', val: rt.call_function('__', [
				rt.new_string('You are about to mark the site %s as not mature.'),
			]) },
		])
		if rt.is_true(rt.identical(rt.new_string('confirm'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			mut var_site_action := rt.get_superglobal('_GET').array_get(rt.new_string('action2'))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_manage_actions.clone().array_isset(var_site_action.clone())))))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('The requested action is not valid.'),
					]),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('matureblog'), var_site_action))
				|| rt.is_true(rt.identical(rt.new_string('unmatureblog'), var_site_action)) {
				rt.call_function('check_admin_referer', [rt.new_string('confirm')])
			} else {
				rt.call_function('check_admin_referer', [
					rt.new_string(var_site_action.str() + '_' + var_id.str()),
				])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
				rt.call_function('nocache_headers', []rt.PhpVal{})
				rt.call_function('header', [
					rt.new_string('Content-Type: text/html; charset=utf-8'),
				])
			}
			if rt.is_true(rt.call_function('is_main_site', [var_id.clone()])) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to change the current site.'),
					]),
				])
			}
			mut var_site_details := rt.call_function('get_site', [
				var_id.clone()])
			mut var_site_address := rt.call_function('untrailingslashit', [
				rt.new_string((rt.get_property(var_site_details, 'domain')).str() +
					(rt.get_property(var_site_details, 'path')).str()),
			])
			mut var_submit := rt.call_function('__', [rt.new_string('Confirm')])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Confirm your action')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_site_action.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_site_action.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wp_get_referer', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_nonce_field', [
				rt.new_string(var_site_action.str() + '_' + var_id.str()),
				rt.new_string('_wpnonce'),
				rt.new_bool(false),
			])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.new_string('deleteblog'), var_site_action)) {
				var_submit = rt.call_function('__', [
					rt.new_string('Delete this site permanently'),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('Deleting a site is a permanent action that cannot be undone. This will delete the entire site and its uploads directory.'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.identical(rt.new_string('archiveblog'), var_site_action)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('Archiving a site makes the site unavailable to its users and visitors. This is a reversible action.'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.identical(rt.new_string('deactivateblog'), var_site_action)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('Flagging a site for deletion makes the site unavailable to its users and visitors. This is a reversible action. A super admin can permanently delete the site at a later date.'),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [var_manage_actions.array_get(var_site_action),
				rt.new_string('<strong>${var_site_address.to_string()}</strong>')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('submit_button', [var_submit.clone(),
				rt.new_string('primary')])
			// unsupported statement: Stmt_InlineHTML
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		} else if rt.is_true(rt.new_bool(var_manage_actions.clone().array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('action'))))) {
			mut var_action := rt.get_superglobal('_GET').array_get(rt.new_string('action'))
			rt.call_function('check_admin_referer', [
				rt.new_string(var_action.str() + '_' + var_id.str()),
			])
		} else if rt.is_true(rt.identical(rt.new_string('allblogs'),
			rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
		{
			rt.call_function('check_admin_referer', [rt.new_string('bulk-sites')])
		}
		mut var_updated_action := rt.new_string('')
		mut switch_val_1 := rt.get_superglobal('_GET').array_get(rt.new_string('action'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('deleteblog'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_sites'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to access this page.'),
					]),
					rt.new_string(''),
					rt.create_array([
						rt.ArrayItem{ key: 'response', val: 403 },
					]),
				])
			}
			var_updated_action = rt.new_string('not_deleted')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_id))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [var_id.clone()])))))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_site'), var_id.clone()])) {
				rt.call_function('wpmu_delete_blog', [var_id.clone(),
					rt.new_bool(true)])
				var_updated_action = rt.new_string('delete')
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_sites'))) {
			rt.call_function('check_admin_referer', [rt.new_string('ms-delete-sites')])
			mut iter_1 :=
				rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('site_ids'))).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_site_id := item_1.val
				var_site_id = rt.new_int(var_site_id.to_i64())
				if rt.is_true(rt.call_function('is_main_site', [
					var_site_id.clone()]))
				{
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('delete_site'),
					var_site_id.clone(),
				])))))
				{
					mut var_site := rt.call_function('get_site', [
						var_site_id.clone()])
					var_site_address = rt.call_function('untrailingslashit', [
						rt.new_string((rt.get_property(var_site, 'domain')).str() +
							(rt.get_property(var_site, 'path')).str()),
					])
					rt.call_function('wp_die', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('Sorry, you are not allowed to delete the site %s.'),
							]),
							var_site_address.clone(),
						]),
						rt.new_int(403),
					])
				}
				var_updated_action = rt.new_string('all_delete')
				rt.call_function('wpmu_delete_blog', [var_site_id.clone(),
					rt.new_bool(true)])
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('allblogs'))) {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('action'))
				&& rt.get_superglobal('_POST').array_isset(rt.new_string('allblogs')) {
				mut var_doaction := rt.get_superglobal('_POST').array_get(rt.new_string('action'))
				mut iter_2 :=
					rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('allblogs'))).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_site_id := item_2.val
					var_site_id = rt.new_int(var_site_id.to_i64())
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_site_id))))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [var_site_id.clone()]))))) {
						mut switch_val_2 := var_doaction
						if rt.is_true(rt.equal(switch_val_2, rt.new_string('delete'))) {
							rt.include_file(
								(rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php',
								'4')
							// unsupported statement: Stmt_InlineHTML
							rt.call_function('_e', [rt.new_string('Confirm your action')])
							// unsupported statement: Stmt_InlineHTML
							rt.echo_val(rt.call_function('esc_attr', [
								rt.call_function('wp_get_referer', []rt.PhpVal{}),
							]))
							// unsupported statement: Stmt_InlineHTML
							rt.call_function('wp_nonce_field', [
								rt.new_string('ms-delete-sites'),
								rt.new_string('_wpnonce'),
								rt.new_bool(false),
							])
							// unsupported statement: Stmt_InlineHTML
							rt.call_function('_e', [
								rt.new_string('Deleting a site is a permanent action that cannot be undone. This will delete the entire site and its uploads directory.'),
							])
							// unsupported statement: Stmt_InlineHTML
							rt.call_function('_e', [
								rt.new_string('You are about to delete the following sites:'),
							])
							// unsupported statement: Stmt_InlineHTML
							mut iter_3 :=
								rt.get_superglobal('_POST').array_get(rt.new_string('allblogs')).iterator()
							for {
								item_3 := iter_3.next() or { break }
								mut var_site_id_shadow := item_3.val
								var_site_id_shadow = rt.new_int(var_site_id_shadow.to_i64())
								mut var_site := rt.call_function('get_site', [
									var_site_id_shadow.clone()])
								var_site_address = rt.call_function('untrailingslashit', [
									rt.new_string((rt.get_property(var_site, 'domain')).str() +
										(rt.get_property(var_site, 'path')).str()),
								])
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(var_site_address)
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [
									var_site_id_shadow.clone()]))
								// unsupported statement: Stmt_InlineHTML
							}
							// unsupported statement: Stmt_InlineHTML
							rt.call_function('submit_button', [
								rt.call_function('__', [
									rt.new_string('Delete these sites permanently'),
								]),
								rt.new_string('primary'),
							])
							// unsupported statement: Stmt_InlineHTML
							rt.include_file(
								(rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php',
								'4')
							exit(0)
						} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('spam')))
							|| rt.is_true(rt.equal(switch_val_2, rt.new_string('notspam'))) {
							var_updated_action = rt.new_string((if rt.is_true(rt.identical(rt.new_string('spam'),
								var_doaction))
							{
								'all_spam'
							} else {
								'all_notspam'
							}).str())
							rt.call_function('update_blog_status', [
								var_site_id.clone(), rt.new_string('spam'),
								rt.new_string((if rt.is_true(rt.identical(rt.new_string('spam'),
									var_doaction))
								{
									'1'
								} else {
									'0'
								}).str())])
						}
					} else {
						rt.call_function('wp_die', [
							rt.call_function('__', [
								rt.new_string('Sorry, you are not allowed to change the current site.'),
							]),
						])
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
					var_doaction.clone(),
					rt.create_array([rt.ArrayItem{ key: none, val: 'delete' },
						rt.ArrayItem{ key: none, val: 'spam' },
						rt.ArrayItem{ key: none, val: 'notspam' }]),
					rt.new_bool(true),
				])))))
				{
					mut var_redirect_to := rt.call_function('wp_get_referer', []rt.PhpVal{})
					mut var_blogs :=
						rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('allblogs')))
					var_redirect_to = rt.call_function('apply_filters', [
						rt.new_string('handle_network_bulk_actions-' +(rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')).str()),
						var_redirect_to.clone(),
						var_doaction.clone(),
						var_blogs.clone(),
						var_id.clone(),
					])
					rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
					exit(0)
				}
			} else {
				mut var_location := rt.call_function('remove_query_arg', [
					rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
						rt.ArrayItem{ key: none, val: '_wpnonce' }]),
					rt.call_function('add_query_arg', [rt.get_superglobal('_POST').clone(),
						rt.call_function('network_admin_url', [
							rt.new_string('sites.php'),
						])]),
				])
				rt.call_function('wp_redirect', [var_location.clone()])
				exit(0)
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('archiveblog')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('unarchiveblog'))) {
			rt.call_function('update_blog_status', [var_id.clone(),
				rt.new_string('archived'),
				rt.new_string((if rt.is_true(rt.identical(rt.new_string('archiveblog'),
					rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
				{
					'1'
				} else {
					'0'
				}).str())])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('activateblog'))) {
			rt.call_function('update_blog_status', [var_id.clone(),
				rt.new_string('deleted'), rt.new_string('0')])
			rt.call_function('do_action', [rt.new_string('activate_blog'),
				var_id.clone()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deactivateblog'))) {
			rt.call_function('do_action', [rt.new_string('deactivate_blog'),
				var_id.clone()])
			rt.call_function('update_blog_status', [var_id.clone(),
				rt.new_string('deleted'), rt.new_string('1')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('unspamblog')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('spamblog'))) {
			rt.call_function('update_blog_status', [var_id.clone(),
				rt.new_string('spam'),
				rt.new_string((if rt.is_true(rt.identical(rt.new_string('spamblog'),
					rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
				{
					'1'
				} else {
					'0'
				}).str())])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('unmatureblog')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('matureblog'))) {
			rt.call_function('update_blog_status', [var_id.clone(),
				rt.new_string('mature'),
				rt.new_string((if rt.is_true(rt.identical(rt.new_string('matureblog'),
					rt.get_superglobal('_GET').array_get(rt.new_string('action'))))
				{
					'1'
				} else {
					'0'
				}).str())])
		}
		if !rt.is_true(var_updated_action)
			&& rt.is_true(rt.new_bool(var_manage_actions.clone().array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('action'))))) {
			var_updated_action = rt.get_superglobal('_GET').array_get(rt.new_string('action'))
		}
		if !(!rt.is_true(var_updated_action)) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'updated', val: var_updated_action },
					]),
					rt.call_function('wp_get_referer', []rt.PhpVal{}),
				]),
			])
			exit(0)
		}
	}
	mut var_msg := rt.new_string('')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
		var_action = rt.get_superglobal('_GET').array_get(rt.new_string('updated'))
		mut switch_val_3 := var_action
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('all_notspam'))) {
			var_msg = rt.call_function('__', [rt.new_string('Sites removed from spam.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('all_spam'))) {
			var_msg = rt.call_function('__', [rt.new_string('Sites marked as spam.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('all_delete'))) {
			var_msg = rt.call_function('__', [
				rt.new_string('Sites permanently deleted.'),
			])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('delete'))) {
			var_msg = rt.call_function('__', [rt.new_string('Site permanently deleted.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('not_deleted'))) {
			var_msg = rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to delete that site.'),
			])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('archiveblog'))) {
			var_msg = rt.call_function('__', [rt.new_string('Site archived.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('unarchiveblog'))) {
			var_msg = rt.call_function('__', [rt.new_string('Site unarchived.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('activateblog'))) {
			var_msg = rt.call_function('__', [
				rt.new_string('Site deletion flag removed.'),
			])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('deactivateblog'))) {
			var_msg = rt.call_function('__', [
				rt.new_string('Site flagged for deletion.'),
			])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('unspamblog'))) {
			var_msg = rt.call_function('__', [rt.new_string('Site removed from spam.')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('spamblog'))) {
			var_msg = rt.call_function('__', [rt.new_string('Site marked as spam.')])
		} else {
			var_msg = rt.call_function('apply_filters', [
				rt.new_string('network_sites_updated_message_${var_action.to_string()}'),
				rt.call_function('__', [rt.new_string('Settings saved.')]),
			])
		}
		if !(!rt.is_true(var_msg)) {
			var_msg = rt.call_function('wp_get_admin_notice', [
				var_msg.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'success' },
					rt.ArrayItem{ key: 'dismissible', val: true },
					rt.ArrayItem{ key: 'id', val: 'message' },
				])])
		}
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Sites')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_sites')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('network_admin_url', [rt.new_string('site-new.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Site')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s'))
		&& rt.is_true(rt.new_int(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')).to_string().len)) {
		print('<span class="subtitle">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Search results for: %s')]),
			rt.new_string('<strong>' + (rt.call_function('esc_html', [var_s.clone()])).str() +
				'</strong>'),
		])
		print('</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_msg)
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search Sites')]),
		rt.new_string('site'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

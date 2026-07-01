import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_db_version := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/http.php', '4')
	// unsupported statement: Stmt_Global
	mut var_title := rt.call_function('__', [rt.new_string('Upgrade Network')])
	mut var_parent_file := 'upgrade.php'
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('Only use this screen once you have updated to a new version of WordPress through Updates/Available Updates (via the Network Administration navigation menu or the Toolbar). Clicking the Upgrade Network button will step through each site in the network, five at a time, and make sure any database updates are applied.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('If a version update to core has not happened, clicking this button will not affect anything.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('If this process fails for any reason, users logging in to their sites will force the same update.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-updates-screen">Documentation on Upgrade Network</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('upgrade_network')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
	}
	print('<div class="wrap">')
	print('<h1>' + (rt.call_function('__', [rt.new_string('Upgrade Network')])).str() + '</h1>')
	mut var_action := if !(rt.get_superglobal('_GET').array_get('action')).is_null() { rt.get_superglobal('_GET').array_get('action') } else { rt.new_string('show') }
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade'))) {
		mut var_n := if rt.get_superglobal('_GET').array_isset(rt.new_string('n')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		if rt.is_true(rt.less(var_n, rt.new_int(5))) {
			rt.call_function('update_site_option', [rt.new_string('wpmu_upgrade_site'), var_wp_db_version.dup()])
		}
		mut var_site_ids := rt.call_function('get_sites', [rt.create_array([rt.ArrayItem{ key: 'spam', val: 0 }, rt.ArrayItem{ key: 'deleted', val: 0 }, rt.ArrayItem{ key: 'archived', val: 0 }, rt.ArrayItem{ key: 'network_id', val: rt.call_function('get_current_network_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'number', val: 5 }, rt.ArrayItem{ key: 'offset', val: var_n }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'update_site_meta_cache', val: false }])])
		if !rt.is_true(var_site_ids) {
			print('<p>' + (rt.call_function('__', [rt.new_string('All done!')])).str() + '</p>')
			break
		}
		print('<ul>')
		{
			mut iter_1 := rt.cast_array(var_site_ids).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_site_id := item_1.val
				rt.call_function('switch_to_blog', [var_site_id.dup()])
				mut var_siteurl := rt.call_function('site_url', []rt.PhpVal{})
				mut var_upgrade_url := rt.call_function('admin_url', [rt.new_string('upgrade.php?step=upgrade_db')])
				rt.call_function('restore_current_blog', []rt.PhpVal{})
				print("<li>${var_siteurl.to_string()}</li>")
				mut var_response := rt.call_function('wp_remote_get', [var_upgrade_url.dup(), rt.create_array([rt.ArrayItem{ key: 'timeout', val: 120 }, rt.ArrayItem{ key: 'httpversion', val: '1.1' }, rt.ArrayItem{ key: 'sslverify', val: false }])])
				if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
					rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Warning! Problem updating %1$s. Your server may not be able to connect to sites running on it. Error message: %2$s')]), var_siteurl.dup(), '<em>' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str() + '</em>'])])
				}
				rt.call_function('do_action', [rt.new_string('after_mu_upgrade'), var_response.dup()])
				rt.call_function('do_action', [rt.new_string('wpmu_upgrade_site'), var_site_id.dup()])
			}
		}
		print('</ul>')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('If your browser does not start loading the next page automatically, click this link:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.add(var_n, rt.new_int(5)))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Next Sites')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.add(var_n, rt.new_int(5)))
		// unsupported statement: Stmt_InlineHTML
	} else {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Database Update Required')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('WordPress has been updated! Next and final step is to individually upgrade the sites in your network.')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('The database update process may take a little while, so please be patient.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Upgrade Network')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('wpmu_upgrade_page')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

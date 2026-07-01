import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_sites')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this site.')])])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.call_function('get_site_screen_help_tab_args', []rt.PhpVal{})])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [rt.call_function('get_site_screen_help_sidebar_content', []rt.PhpVal{})])
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
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.new_string('update-site'), rt.get_superglobal('_REQUEST').array_get('action'))))) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('option').is_array())))) {
		rt.call_function('check_admin_referer', [rt.new_string('edit-site')])
		rt.call_function('switch_to_blog', [var_id.dup()])
		mut var_skip_options := ['allowedthemes']
		{
			mut iter_1 := rt.cast_array(rt.get_superglobal('_POST').array_get('option')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_val := item_1.val
				mut var_key := item_1.key
				var_key = rt.call_function('wp_unslash', [var_key.dup()])
				var_val = rt.call_function('wp_unslash', [var_val.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_key)) || rt.is_true(rt.new_bool(var_val.dup().is_array())))) || rt.is_true(rt.call_function('in_array', [var_key.dup(), var_skip_options.dup(), rt.new_bool(true)])))) {
					continue
					// unsupported statement: Stmt_Nop
				}
				rt.call_function('update_option', [var_key.dup(), var_val.dup()])
			}
		}
		rt.call_function('do_action', [rt.new_string('wpmu_update_blog_options'), var_id.dup()])
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'update', val: 'updated' }, rt.ArrayItem{ key: 'id', val: var_id }]), rt.new_string('site-settings.php')])])
		// unsupported expression: Expr_Exit
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
		mut var_messages := []rt.PhpVal{}
		if rt.is_true(rt.identical(rt.new_string('updated'), rt.get_superglobal('_GET').array_get('update'))) {
			var_messages << rt.call_function('__', [rt.new_string('Site options updated.')])
		}
	}
	mut var_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Edit Site: %s')]), rt.call_function('esc_html', [rt.get_property(var_details, 'blogname')])])
	mut var_parent_file := 'sites.php'
	mut var_submenu_file := 'sites.php'
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
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
	rt.call_function('network_edit_site_nav', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id }, rt.ArrayItem{ key: 'selected', val: 'site-settings' }])])
	if !(!rt.is_true(var_messages)) {
		mut var_notice_args := { 'type': rt.new_string('success'), 'dismissible': rt.new_bool(true), 'id': rt.new_string('message') }
		for var_msg in var_messages {
			rt.call_function('wp_admin_notice', [var_msg.dup(), var_notice_args.dup()])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('edit-site')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_blog_prefix := rt.call_method(var_wpdb, 'get_blog_prefix', [var_id.dup()])
	mut var_options := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT * FROM %i\n\t\t\t\tWHERE option_name NOT LIKE %s\n\t\t\t\tAND option_name NOT LIKE %s'), rt.new_string("${var_blog_prefix.to_string()}options"), (rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_')])).str() + '%', '%' + (rt.call_method(var_wpdb, 'esc_like', [rt.new_string('user_roles')])).str()])])
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			if rt.is_true(rt.identical(rt.new_string('default_role'), rt.get_property(var_option, 'option_name'))) {
				mut var_editblog_default_role := rt.get_property(var_option, 'option_value')
			}
			mut var_disabled := false
			mut var_class := 'all-options'
			if rt.is_true(rt.call_function('is_serialized', [rt.get_property(var_option, 'option_value')])) {
				if rt.is_true(rt.call_function('is_serialized_string', [rt.get_property(var_option, 'option_value')])) {
					rt.set_property(var_option, 'option_value', rt.call_function('esc_html', [rt.call_function('maybe_unserialize', [rt.get_property(var_option, 'option_value')])]))
				} else {
					rt.set_property(var_option, 'option_value', rt.new_string('SERIALIZED DATA'))
					var_disabled = true
					var_class = 'all-options disabled'
				}
			}
			mut var_ltr_fields := ['siteurl', 'home', 'admin_email', 'new_admin_email', 'mailserver_url', 'mailserver_login', 'mailserver_pass', 'ping_sites', 'permalink_structure', 'category_base', 'tag_base', 'upload_path', 'upload_url_path']
			if rt.is_true(rt.call_function('in_array', [rt.get_property(var_option, 'option_name'), var_ltr_fields.dup(), rt.new_bool(true)])) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_option, 'option_value'), rt.new_string('\n')])) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_name')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_option, 'option_name')]))
				// unsupported statement: Stmt_InlineHTML
				print(var_class)
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_name')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_name')]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('disabled', [rt.new_bool(var_disabled).dup()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_textarea', [rt.get_property(var_option, 'option_value')]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_name')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_option, 'option_name')]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(rt.is_true(var_is_main_site) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_option, 'option_name'), rt.create_array([rt.ArrayItem{ key: none, val: 'siteurl' }, rt.ArrayItem{ key: none, val: 'home' }]), rt.new_bool(true)])))) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_option, 'option_value')]))
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					print(var_class)
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_name')]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_name')]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_option, 'option_value')]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('disabled', [rt.new_bool(var_disabled).dup()])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('wpmueditblogaction'), var_id.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}

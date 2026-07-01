import rt


fn main() {
	defer {
		rt.shutdown()
	}

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
	mut var_parsed_scheme := rt.call_function('parse_url', [rt.get_property(var_details, 'siteurl'), rt.get_constant('PHP_URL_SCHEME')])
	mut var_is_main_site := rt.call_function('is_main_site', [var_id.dup()])
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.new_string('update-site'), rt.get_superglobal('_REQUEST').array_get('action'))))) {
		rt.call_function('check_admin_referer', [rt.new_string('edit-site')])
		rt.call_function('switch_to_blog', [var_id.dup()])
		rt.call_function('delete_option', [rt.new_string('rewrite_rules')])
		mut var_blog_data := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('blog')])
		var_blog_data.array_set('scheme', var_parsed_scheme.dup())
		if rt.is_true(var_is_main_site) {
			var_blog_data.array_set('domain', rt.get_property(var_details, 'domain'))
			var_blog_data.array_set('path', rt.get_property(var_details, 'path'))
		} else {
			mut var_new_url_scheme := rt.call_function('parse_url', [var_blog_data.array_get('url'), rt.get_constant('PHP_URL_SCHEME')])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_new_url_scheme)))) {
				var_blog_data.array_set('url', rt.call_function('esc_url', [(var_parsed_scheme).str() + '://' + (var_blog_data.array_get('url')).str()]))
			}
			mut var_update_parsed_url := rt.call_function('parse_url', [var_blog_data.array_get('url')])
			if !(var_update_parsed_url.array_isset(rt.new_string('path'))) {
				var_update_parsed_url.array_set('path', '/')
			}
			var_blog_data.array_set('scheme', var_update_parsed_url.array_get('scheme'))
			var_blog_data.array_set('domain', var_update_parsed_url.array_get('host'))
			if var_update_parsed_url.array_isset(rt.new_string('port')) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			var_blog_data.array_set('path', var_update_parsed_url.array_get('path'))
		}
		mut var_existing_details := rt.call_function('get_site', [var_id.dup()])
		mut var_blog_data_checkboxes := ['public', 'archived', 'spam', 'mature', 'deleted']
		for var_c in var_blog_data_checkboxes {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [// unsupported expression: Expr_Cast_Int, rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 1 }]), rt.new_bool(true)]))))) {
				var_blog_data.array_set(c, rt.get_property(var_existing_details, '{"nodeType":"Expr_Variable","line":84,"name":"c"}'))
			} else {
				var_blog_data.array_set(c, if rt.get_superglobal('_POST').array_get('blog').array_isset(rt.new_string(c)) { 1 } else { 0 })
			}
		}
		rt.call_function('update_blog_details', [var_id.dup(), var_blog_data.dup()])
		mut var_new_details := rt.call_function('get_site', [var_id.dup()])
		mut var_old_home_url := rt.call_function('trailingslashit', [rt.call_function('esc_url', [rt.call_function('get_option', [rt.new_string('home')])])])
		mut var_old_home_parsed := rt.call_function('parse_url', [var_old_home_url.dup()])
		mut var_old_home_host := rt.new_string((var_old_home_parsed.array_get('host')).str() + if var_old_home_parsed.array_isset(rt.new_string('port')) { ':' + (var_old_home_parsed.array_get('port')).str() } else { '' })
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_old_home_host, rt.get_property(var_existing_details, 'domain'))) && rt.is_true(rt.identical(var_old_home_parsed.array_get('path'), rt.get_property(var_existing_details, 'path'))))) {
			mut var_new_home_url := rt.call_function('untrailingslashit', [rt.call_function('sanitize_url', [(var_blog_data.array_get('scheme')).str() + '://' + (rt.get_property(var_new_details, 'domain')).str() + (rt.get_property(var_new_details, 'path')).str()])])
			rt.call_function('update_option', [rt.new_string('home'), var_new_home_url.dup()])
		}
		mut var_old_site_url := rt.call_function('trailingslashit', [rt.call_function('esc_url', [rt.call_function('get_option', [rt.new_string('siteurl')])])])
		mut var_old_site_parsed := rt.call_function('parse_url', [var_old_site_url.dup()])
		mut var_old_site_host := rt.new_string((var_old_site_parsed.array_get('host')).str() + if var_old_site_parsed.array_isset(rt.new_string('port')) { ':' + (var_old_site_parsed.array_get('port')).str() } else { '' })
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_old_site_host, rt.get_property(var_existing_details, 'domain'))) && rt.is_true(rt.identical(var_old_site_parsed.array_get('path'), rt.get_property(var_existing_details, 'path'))))) {
			mut var_new_site_url := rt.call_function('untrailingslashit', [rt.call_function('sanitize_url', [(var_blog_data.array_get('scheme')).str() + '://' + (rt.get_property(var_new_details, 'domain')).str() + (rt.get_property(var_new_details, 'path')).str()])])
			rt.call_function('update_option', [rt.new_string('siteurl'), var_new_site_url.dup()])
		}
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'update', val: 'updated' }, rt.ArrayItem{ key: 'id', val: var_id }]), rt.new_string('site-info.php')])])
		// unsupported expression: Expr_Exit
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
		mut var_messages := []rt.PhpVal{}
		if rt.is_true(rt.identical(rt.new_string('updated'), rt.get_superglobal('_GET').array_get('update'))) {
			var_messages << rt.call_function('__', [rt.new_string('Site info updated.')])
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
	rt.call_function('network_edit_site_nav', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id }, rt.ArrayItem{ key: 'selected', val: 'site-info' }])])
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
	if rt.is_true(var_is_main_site) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Address (URL)')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [(var_parsed_scheme).str() + '://' + (rt.get_property(var_details, 'domain')).str() + (rt.get_property(var_details, 'path')).str()]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Address (URL)')])
		// unsupported statement: Stmt_InlineHTML
		print((var_parsed_scheme).str() + '://' + (rt.call_function('esc_attr', [rt.get_property(var_details, 'domain')])).str() + (rt.call_function('esc_attr', [rt.get_property(var_details, 'path')])).str())
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Registered'), rt.new_string('site')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_details, 'registered')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Last Updated')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_details, 'last_updated')]))
	// unsupported statement: Stmt_InlineHTML
	mut var_site_attributes_title := rt.call_function('__', [rt.new_string('Attributes')])
	mut var_attribute_fields := { 'public': rt.call_function('_x', [rt.new_string('Public'), rt.new_string('site')]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_main_site)))) {
		var_attribute_fields['archived'] = rt.call_function('__', [rt.new_string('Archived')])
		var_attribute_fields['spam'] = rt.call_function('_x', [rt.new_string('Spam'), rt.new_string('site')])
		var_attribute_fields['deleted'] = rt.call_function('__', [])
	}
	var_attribute_fields['mature'] = rt.call_function('__', [])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}

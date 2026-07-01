import rt

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

fn create_wp_site_health() &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	mut var_tabs := rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('_x', [rt.new_string('Status'), rt.new_string('Site Health')]) }, rt.ArrayItem{ key: 'debug', val: rt.call_function('_x', [rt.new_string('Info'), rt.new_string('Site Health')]) }])
	var_tabs = rt.call_function('apply_filters', [rt.new_string('site_health_navigation_tabs'), var_tabs.dup()])
	mut var_wrapper_classes := ['health-check-tabs-wrapper', 'hide-if-no-js', 'tab-count-' + var_tabs.dup().array_count().str()]
	mut var_current_tab := if !(rt.get_superglobal('_GET').array_get('tab')).is_null() { rt.get_superglobal('_GET').array_get('tab') } else { rt.new_string('') }
	mut var_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Site Health - %s')]), if var_tabs.array_isset(var_current_tab) { rt.call_function('esc_html', [var_tabs.array_get(var_current_tab)]) } else { rt.call_function('esc_html', [rt.call_function('reset', [var_tabs.dup()])]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_site_health_checks')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access site health information.')]), rt.new_string(''), rt.new_int(403)])
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('site-health')])
	rt.call_function('wp_enqueue_script', [rt.new_string('site-health')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Site_Health')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
	}
	if rt.is_true(rt.identical(rt.new_string('update_https'), var_action)) {
		rt.call_function('check_admin_referer', [rt.new_string('wp_update_https')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_https')]))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to update this site to HTTPS.')]), rt.new_int(403)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_https_supported', []rt.PhpVal{}))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('It looks like HTTPS is not supported for your website at this point.')])])
		}
		mut var_result := rt.call_function('wp_update_urls_to_https', []rt.PhpVal{})
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('https_updated'), // unsupported expression: Expr_Cast_Int, rt.call_function('wp_get_referer', []rt.PhpVal{})])])
		// unsupported expression: Expr_Exit
	}
	mut var_health_check_site_status := fn () rt.PhpVal { mut temp := Class_WP_Site_Health{}; return temp.get_instance() }()
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen allows you to obtain a health diagnosis of your site, and displays an overall rating of the status of your installation.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('In the Status tab, you can see critical information about your WordPress configuration, along with anything else that requires your attention.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('In the Info tab, you will find all the details about the configuration of your WordPress site, server, and database. There is also an export feature that allows you to copy all of the information about your site to the clipboard, to help solve problems on your site when obtaining support.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/site-health-screen/">Documentation on Site Health tool</a>')])).str() + '</p>'])
	rt.call_method(var_health_check_site_status, 'check_wp_version_check_exists', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Health')])
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('https_updated')) {
		if rt.is_true(rt.get_superglobal('_GET').array_get('https_updated')) {
			rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Site URLs switched to HTTPS.')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' }, rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		} else {
			rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Site URLs could not be switched to HTTPS.')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Results are still loading&hellip;')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '), var_wrapper_classes.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Secondary menu')])
	// unsupported statement: Stmt_InlineHTML
	mut var_tabs_slice := var_tabs.dup()
	if var_tabs.dup().array_count() > 4 {
		var_tabs_slice = rt.call_function('array_slice', [var_tabs.dup(), rt.new_int(0), rt.new_int(3)])
	}
	{
		mut iter_1 := var_tabs_slice.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_slug := item_1.key
			rt.call_function('printf', [rt.new_string('<a href="%s" class="health-check-tab %s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'tab', val: var_slug }]), rt.call_function('admin_url', [rt.new_string('site-health.php')])])]), if rt.is_true(rt.identical(var_current_tab, var_slug)) { rt.new_string('active') } else { rt.new_string('') }, rt.call_function('esc_html', [var_label.dup()])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if var_tabs.dup().array_count() > 4 {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Toggle extra menu items')])
		// unsupported statement: Stmt_InlineHTML
		var_tabs_slice = rt.call_function('array_slice', [var_tabs.dup(), rt.new_int(3)])
		{
			mut iter_1 := var_tabs_slice.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_label := item_1.val
				mut var_slug := item_1.key
				rt.call_function('printf', [rt.new_string('<a href="%s" class="health-check-tab %s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'tab', val: var_slug }]), rt.call_function('admin_url', [rt.new_string('site-health.php')])])]), if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('tab')) && rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get('tab'), var_slug)))) { rt.new_string('active') } else { rt.new_string('') }, rt.call_function('esc_html', [var_label.dup()])])
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('tab')) && !(!rt.is_true(rt.get_superglobal('_GET').array_get('tab'))) {
		rt.call_function('do_action', [rt.new_string('site_health_tab_content'), rt.get_superglobal('_GET').array_get('tab')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		return rt.new_null()
	} else {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('The Site Health check requires JavaScript.')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'hide-if-js' }]) }])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Great job!')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Everything is running smoothly here.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Health Status')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('The site health check shows information about your WordPress configuration and items that may need your attention.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('_n', [rt.new_string('%s critical issue'), rt.new_string('%s critical issues'), rt.new_int(0)]), rt.new_string('<span class="issue-count">0</span>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Critical issues are items that may have a high impact on your site&#8217;s performance or security. Resolving these issues should be prioritized.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('_n', [rt.new_string('%s recommended improvement'), rt.new_string('%s recommended improvements'), rt.new_int(0)]), rt.new_string('<span class="issue-count">0</span>')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Recommended items are considered beneficial to your site, although not as important to prioritize as a critical issue. They may include improvements in areas such as security, performance, and user experience.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Passed tests')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('_n', [rt.new_string('%s item with no issues detected'), rt.new_string('%s items with no issues detected'), rt.new_int(0)]), rt.new_string('<span class="issue-count">0</span>')])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

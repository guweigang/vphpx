import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_db_version := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_wp_importers := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ADMIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_ADMIN'),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_NETWORK_ADMIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_NETWORK_ADMIN'),
			rt.new_bool(false)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_USER_ADMIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_USER_ADMIN'),
			rt.new_bool(false)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_NETWORK_ADMIN')))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_USER_ADMIN'))))) {
		rt.call_function('define', [rt.new_string('WP_BLOG_ADMIN'),
			rt.new_bool(true)])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('import'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_LOAD_IMPORTERS')]))))) {
		rt.call_function('define', [rt.new_string('WP_LOAD_IMPORTERS'),
			rt.new_bool(true)])
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.call_function('get_option', [rt.new_string('db_upgraded')])) {
		rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
		rt.call_function('update_option', [rt.new_string('db_upgraded'),
			rt.new_bool(false), rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('after_db_upgrade')])
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))))
		&& !rt.is_true(rt.get_superglobal('_POST'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('db_version')])).to_i64()), var_wp_db_version)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('upgrade.php?_wp_http_referer=' +(rt.call_function('urlencode', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])])).str()),
				]),
			])
			exit(0)
		}
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('do_mu_upgrade'),
			rt.new_bool(true)]))
		{
			mut var_blog_count := rt.call_function('get_blog_count', []rt.PhpVal{})
			if rt.is_true(rt.less_equal(var_blog_count, rt.new_int(50)))
				|| (rt.is_true(rt.greater(var_blog_count, rt.new_int(50)))
				&& rt.is_true(rt.identical(rt.call_function('mt_rand', [rt.new_int(0), rt.new_int((rt.div(var_blog_count, rt.new_int(50))).to_i64())]), rt.new_int(1)))) {
				rt.include_file(
					(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/http.php',
					'4')
				mut var_response := rt.call_function('wp_remote_get', [
					rt.call_function('admin_url', [rt.new_string('upgrade.php?step=1')]),
					rt.create_array([rt.ArrayItem{ key: 'timeout', val: 120 },
						rt.ArrayItem{ key: 'httpversion', val: '1.1' }]),
				])
				rt.call_function('do_action', [rt.new_string('after_mu_upgrade'),
					var_response.clone()])
				var_response = rt.new_null()
			}
			var_blog_count = rt.new_null()
		}
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.call_function('auth_redirect', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_scheduled_delete')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('daily'), rt.new_string('wp_scheduled_delete')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('delete_expired_transients')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('daily'), rt.new_string('delete_expired_transients')])
	}
	rt.call_function('set_screen_options', []rt.PhpVal{})
	mut var_date_format := rt.call_function('__', [rt.new_string('F j, Y')])
	mut var_time_format := rt.call_function('__', [rt.new_string('g:i a')])
	rt.call_function('wp_enqueue_script', [rt.new_string('common')])
	mut var_hook_suffix := rt.get_superglobal('hook_suffix')
	mut var_plugin_page := rt.get_superglobal('plugin_page')
	mut var_typenow := rt.get_superglobal('typenow')
	mut var_taxnow := rt.get_superglobal('taxnow')
	mut var_page_hook := rt.new_null()
	mut var_editing := false
	if rt.get_superglobal('_GET').array_isset(rt.new_string('page')) {
		var_plugin_page = rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('page')),
		])
		var_plugin_page = rt.call_function('plugin_basename', [
			var_plugin_page.clone()])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_type'))
		&& rt.is_true(rt.call_function('post_type_exists', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type'))])) {
		var_typenow = rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_type'))
	} else {
		var_typenow = rt.new_string('')
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('taxonomy'))
		&& rt.is_true(rt.call_function('taxonomy_exists', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('taxonomy'))])) {
		var_taxnow = rt.get_superglobal('_REQUEST').array_get(rt.new_string('taxonomy'))
	} else {
		var_taxnow = rt.new_string('')
	}
	if rt.is_true(rt.get_constant('WP_NETWORK_ADMIN')) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/network/menu.php', '3')
	} else if rt.is_true(rt.get_constant('WP_USER_ADMIN')) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/user/menu.php', '3')
	} else {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/menu.php', '3')
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])) {
		rt.call_function('wp_raise_memory_limit', [rt.new_string('admin')])
	}
	rt.call_function('do_action', [rt.new_string('admin_init')])
	if !var_plugin_page.is_null() {
		if !(!rt.is_true(var_typenow)) {
			mut var_the_parent := rt.new_string(var_pagenow.str() + '?post_type=' +
				var_typenow.str())
		} else {
			var_the_parent = var_pagenow
		}
		var_page_hook = rt.call_function('get_plugin_page_hook', [
			var_plugin_page.clone(), var_the_parent.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_page_hook)))) {
			var_page_hook = rt.call_function('get_plugin_page_hook', [
				var_plugin_page.clone(), var_plugin_page.clone()])
			if !rt.is_true(var_page_hook)
				&& rt.is_true(rt.identical(rt.new_string('edit.php'), var_pagenow))
				&& rt.is_true(rt.call_function('get_plugin_page_hook', [var_plugin_page.clone(), rt.new_string('tools.php')])) {
				if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING')))) {
					mut var_query_string :=
						rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING'))
				} else {
					var_query_string = rt.new_string('page=' + var_plugin_page.str())
				}
				rt.call_function('wp_redirect', [
					rt.call_function('admin_url', [
						rt.new_string('tools.php?' + var_query_string.str()),
					]),
				])
				exit(0)
			}
		}
		var_the_parent = rt.new_null()
	}
	var_hook_suffix = rt.new_string('')
	if !var_page_hook.is_null() {
		var_hook_suffix = var_page_hook.clone()
	} else if !var_plugin_page.is_null() {
		var_hook_suffix = var_plugin_page.clone()
	} else if !var_pagenow.is_null() {
		var_hook_suffix = var_pagenow
	}
	rt.call_function('set_current_screen', []rt.PhpVal{})
	if !var_plugin_page.is_null() {
		if rt.is_true(var_page_hook) {
			rt.call_function('do_action', [
				rt.new_string('load-${var_page_hook.to_string()}'),
			])
			if !(rt.get_superglobal('_GET').array_isset(rt.new_string('noheader'))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php',
					'4')
			}
			rt.call_function('do_action', [var_page_hook.clone()])
		} else {
			if rt.is_true(rt.call_function('validate_file', [
				var_plugin_page.clone()]))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [rt.new_string('Invalid plugin page.')]),
				])
			}
			if !(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}')]))
				&& rt.is_true(rt.call_function('is_file', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}')])))
				&& !(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}')]))
				&& rt.is_true(rt.call_function('is_file', [rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}')]))) {
				rt.call_function('wp_die', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Cannot load %s.')]),
						rt.call_function('htmlentities', [var_plugin_page.clone()]),
					]),
				])
			}
			rt.call_function('do_action', [
				rt.new_string('load-${var_plugin_page.to_string()}'),
			])
			if !(rt.get_superglobal('_GET').array_isset(rt.new_string('noheader'))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php',
					'4')
			}
			if rt.is_true(rt.call_function('file_exists', [
				rt.new_string(
					(rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}'),
			]))
			{
				rt.include_file(
					(rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}',
					'1')
			} else {
				rt.include_file(
					(rt.get_constant('WP_PLUGIN_DIR')).str() + '/${var_plugin_page.to_string()}',
					'1')
			}
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		exit(0)
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('import')) {
		mut var_importer := rt.get_superglobal('_GET').array_get(rt.new_string('import'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('import'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to import content into this site.'),
				]),
			])
		}
		if rt.is_true(rt.call_function('validate_file', [var_importer.clone()])) {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('import.php?invalid=' + var_importer.str()),
				]),
			])
			exit(0)
		}
		if !(var_wp_importers.array_isset(var_importer))
			|| !(rt.call_function('is_callable', [var_wp_importers.array_get(var_importer).array_get(rt.new_int(2))])) {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('import.php?invalid=' + var_importer.str()),
				]),
			])
			exit(0)
		}
		rt.call_function('do_action', [
			rt.new_string('load-importer-${var_importer.to_string()}'),
		])
		mut var_title := rt.call_function('__', [rt.new_string('Import')])
		mut var_parent_file := 'tools.php'
		mut var_submenu_file := 'import.php'
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('noheader'))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
		rt.call_function('define', [rt.new_string('WP_IMPORTING'),
			rt.new_bool(true)])
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('force_filtered_html_on_import'),
			rt.new_bool(false),
		]))
		{
			rt.call_function('kses_init_filters', []rt.PhpVal{})
		}
		rt.call_function('call_user_func',
			[var_wp_importers.array_get(var_importer).array_get(rt.new_int(2))])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		rt.call_function('flush_rewrite_rules', [rt.new_bool(false)])
		exit(0)
	} else {
		rt.call_function('do_action', [rt.new_string('load-${var_pagenow.to_string()}')])
		if rt.is_true(rt.identical(rt.new_string('page'), var_typenow)) {
			if rt.is_true(rt.identical(rt.new_string('post-new.php'), var_pagenow)) {
				rt.call_function('do_action', [rt.new_string('load-page-new.php')])
			} else if rt.is_true(rt.identical(rt.new_string('post.php'), var_pagenow)) {
				rt.call_function('do_action', [rt.new_string('load-page.php')])
			}
		} else if rt.is_true(rt.identical(rt.new_string('edit-tags.php'), var_pagenow)) {
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxnow)) {
				rt.call_function('do_action', [rt.new_string('load-categories.php')])
			} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxnow)) {
				rt.call_function('do_action', [
					rt.new_string('load-edit-link-categories.php'),
				])
			}
		} else if rt.is_true(rt.identical(rt.new_string('term.php'), var_pagenow)) {
			rt.call_function('do_action', [rt.new_string('load-edit-tags.php')])
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		mut var_action := rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))
		rt.call_function('do_action', [
			rt.new_string('admin_action_${var_action.to_string()}'),
		])
	}
}

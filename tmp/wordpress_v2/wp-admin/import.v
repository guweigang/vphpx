import rt

const global_const_wp_load_importers = true

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
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
	mut var_title := rt.call_function('__', [rt.new_string('Import')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen lists links to plugins to import data from blogging/content management platforms. Choose the platform you want to import from, and click Install Now when you are prompted in the popup window. If your platform is not listed, click the link to search the plugin directory for other importer plugins to see if there is one for your platform.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('In previous versions of WordPress, all importers were built-in. They have been turned into plugins since most people only use them once or infrequently.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/tools-import-screen/">Documentation on Import</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
		mut var_popular_importers := rt.call_function('wp_get_popular_importers', []rt.PhpVal{})
	} else {
		var_popular_importers = rt.new_array()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('invalid'))))
		&& var_popular_importers.array_isset(rt.get_superglobal('_GET').array_get(rt.new_string('invalid'))) {
		mut var_importer_id :=
			var_popular_importers.array_get(rt.get_superglobal('_GET').array_get(rt.new_string('invalid'))).array_get(rt.new_string('importer-id'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_importer_id,
			rt.get_superglobal('_GET').array_get(rt.new_string('invalid'))))))
		{
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [
					rt.new_string('admin.php?import=' + var_importer_id.str()),
				]),
			])
			exit(0)
		}
		var_importer_id = rt.new_null()
	}
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('plugin-install')])
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	mut var_parent_file := 'tools.php'
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('invalid')))) {
		mut var_importer_not_installed := rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s importer is invalid or is not installed.')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [rt.get_superglobal('_GET').array_get(rt.new_string('invalid'))])).str() +
			'</strong>')])).str())
		rt.call_function('wp_admin_notice', [var_importer_not_installed.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you have posts or comments in another system, WordPress can import those into this site. To get started, choose a system to import from below:'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_importers := rt.call_function('get_importers', []rt.PhpVal{})
	mut iter_1 := var_popular_importers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_pop_data := item_1.val
		mut var_pop_importer := item_1.key
		if var_importers.array_isset(var_pop_importer) {
			continue
		}
		if var_importers.array_isset(var_pop_data.array_get(rt.new_string('importer-id'))) {
			continue
		}
		var_importers.array_set(var_pop_data.array_get(rt.new_string('importer-id')), rt.create_array([
			rt.ArrayItem{ key: none, val: var_pop_data.array_get(rt.new_string('name')) },
			rt.ArrayItem{ key: none, val: var_pop_data.array_get(rt.new_string('description')) },
			rt.ArrayItem{ key: 'install', val: var_pop_data.array_get(rt.new_string('plugin-slug')) },
		]))
	}
	if !rt.is_true(var_importers) {
		print('<p>' +
			(rt.call_function('__', [rt.new_string('No importers are available.')])).str() + '</p>')
	} else {
		rt.call_function('uasort', [var_importers.clone(), rt.new_string('_usort_by_first_member')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_importers.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_data := item_2.val
			mut var_importer_id_shadow := item_2.key
			mut var_plugin_slug := rt.new_string('')
			mut var_action := rt.new_string('')
			mut var_is_plugin_installed := false
			if var_data.array_isset(rt.new_string('install')) {
				var_plugin_slug = var_data.array_get(rt.new_string('install'))
				if rt.is_true(rt.call_function('file_exists', [
					rt.new_string(
						(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_slug.str()),
				]))
				{
					mut var_plugins := rt.call_function('get_plugins', [
						rt.new_string('/' + var_plugin_slug.str()),
					])
					if !(!rt.is_true(var_plugins)) {
						mut var_keys := rt.func_array_keys(var_plugins.clone())
						mut var_plugin_file := rt.new_string(var_plugin_slug.str() + '/' +
							(var_keys.array_get(rt.new_int(0))).str())
						mut var_url := rt.call_function('wp_nonce_url', [
							rt.call_function('add_query_arg', [
								rt.create_array([
									rt.ArrayItem{ key: 'action', val: 'activate' },
									rt.ArrayItem{ key: 'plugin', val: var_plugin_file },
									rt.ArrayItem{ key: 'from', val: 'import' },
								]),
								rt.call_function('admin_url', [
									rt.new_string('plugins.php'),
								]),
							]),
							rt.new_string('activate-plugin_' + var_plugin_file.str()),
						])
						var_action = rt.call_function('sprintf', [
							rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
							rt.call_function('esc_url', [var_url.clone()]),
							rt.call_function('esc_attr', [
								rt.call_function('sprintf', [
									rt.call_function('__', [rt.new_string('Run %s')]),
									var_data.array_get(rt.new_int(0)),
								]),
							]),
							rt.call_function('__', [
								rt.new_string('Run Importer'),
							]),
						])
						var_is_plugin_installed = true
					}
				}
				if !rt.is_true(var_action) {
					if rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})) {
						var_url = rt.call_function('wp_nonce_url', [
							rt.call_function('add_query_arg', [
								rt.create_array([
									rt.ArrayItem{ key: 'action', val: 'install-plugin' },
									rt.ArrayItem{ key: 'plugin', val: var_plugin_slug },
									rt.ArrayItem{ key: 'from', val: 'import' },
								]),
								rt.call_function('self_admin_url', [
									rt.new_string('update.php'),
								]),
							]),
							rt.new_string('install-plugin_' + var_plugin_slug.str()),
						])
						var_action = rt.call_function('sprintf', [
							rt.new_string('<a href="%1$s" class="install-now" data-slug="%2$s" data-name="%3$s" aria-label="%4$s">%5$s</a>'),
							rt.call_function('esc_url', [var_url.clone()]),
							rt.call_function('esc_attr', [var_plugin_slug.clone()]),
							rt.call_function('esc_attr', [var_data.array_get(rt.new_int(0))]),
							rt.call_function('esc_attr', [
								rt.call_function('sprintf', [
									rt.call_function('_x', [
										rt.new_string('Install %s now'),
										rt.new_string('plugin'),
									]),
									var_data.array_get(rt.new_int(0)),
								]),
							]),
							rt.call_function('_x', [
								rt.new_string('Install Now'),
								rt.new_string('plugin'),
							]),
						])
					} else {
						var_action = rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('This importer is not installed. Please install importers from <a href="%s">the main site</a>.'),
							]),
							rt.call_function('get_admin_url', [
								rt.call_function('get_current_network_id', []rt.PhpVal{}),
								rt.new_string('import.php'),
							]),
						])
					}
				}
			} else {
				var_url = rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'import', val: var_importer_id_shadow },
					]),
					rt.call_function('self_admin_url', [
						rt.new_string('admin.php'),
					]),
				])
				var_action = rt.call_function('sprintf', [
					rt.new_string('<a href="%1$s" aria-label="%2$s">%3$s</a>'),
					rt.call_function('esc_url', [var_url.clone()]),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Run %s')]),
							var_data.array_get(rt.new_int(0)),
						]),
					]),
					rt.call_function('__', [
						rt.new_string('Run Importer'),
					]),
				])
				var_is_plugin_installed = true
			}
			if !var_is_plugin_installed
				&& rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})) {
				var_url = rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'tab', val: 'plugin-information' },
						rt.ArrayItem{ key: 'plugin', val: var_plugin_slug },
						rt.ArrayItem{ key: 'from', val: 'import' },
						rt.ArrayItem{ key: 'TB_iframe', val: 'true' },
						rt.ArrayItem{ key: 'width', val: 600 },
						rt.ArrayItem{ key: 'height', val: 550 },
					]),
					rt.call_function('network_admin_url', [
						rt.new_string('plugin-install.php'),
					]),
				])
				var_action = rt.concat(var_action, rt.call_function('sprintf', [
					rt.new_string(' | <a href="%1$s" class="thickbox open-plugin-details-modal" aria-label="%2$s">%3$s</a>'),
					rt.call_function('esc_url', [var_url.clone()]),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('More information about %s'),
							]),
							var_data.array_get(rt.new_int(0)),
						]),
					]),
					rt.call_function('__', [
						rt.new_string('Details'),
					]),
				]))
			}
			print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("\n\t\t\t<tr class='importer-item'>\n\t\t\t\t<td class='import-system'>\n\t\t\t\t\t<span class='importer-title'>"),
				var_data.array_get(rt.new_int(0))),
				rt.new_string("</span>\n\t\t\t\t\t<span class='importer-action'>")), var_action),
				rt.new_string("</span>\n\t\t\t\t</td>\n\t\t\t\t<td class='desc'>\n\t\t\t\t\t<span class='importer-desc'>")),
				var_data.array_get(rt.new_int(1))),
				rt.new_string('</span>\n\t\t\t\t</td>\n\t\t\t</tr>')))
		}
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
		print('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If the importer you need is not listed, <a href="%s">search the plugin directory</a> to see if an importer is available.')]), rt.call_function('esc_url', [rt.call_function('network_admin_url', [rt.new_string('plugin-install.php?tab=search&type=tag&s=importer')])])])).str() +
			'</p>')
	}
	rt.call_function('do_action', [rt.new_string('import_filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_request_filesystem_credentials_modal', []rt.PhpVal{})
	rt.call_function('wp_print_admin_notice_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

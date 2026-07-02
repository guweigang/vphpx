import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_matches := []rt.PhpVal{}
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', [rt.new_string('plugin-editor.php')]),
		])
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_plugins'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit plugins for this site.'),
			]),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Edit Plugins')])
	mut var_parent_file := 'plugins.php'
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	if !rt.is_true(var_plugins) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('No plugins are currently available.')]),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) }]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		exit(0)
	}
	mut var_file := rt.new_string('')
	mut var_plugin := rt.new_string('')
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('file')) {
		var_file = rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('file'))])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('plugin')) {
		var_plugin = rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('plugin')),
		])
	}
	if !rt.is_true(var_plugin) {
		if rt.is_true(var_file) {
			mut var_file_dirname := rt.call_function('dirname', [
				var_file.clone()])
			mut iter_1 := rt.func_array_keys(var_plugins.clone()).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin_candidate := item_1.val
				if rt.is_true(rt.identical(var_plugin_candidate, var_file))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_file_dirname))))
					&& rt.is_true(rt.identical(rt.call_function('dirname', [var_plugin_candidate.clone()]), var_file_dirname))) {
					var_plugin = var_plugin_candidate
					break
				}
			}
			if !rt.is_true(var_plugin) {
				var_plugin = var_file.clone()
			}
		} else {
			var_plugin = rt.func_array_keys(var_plugins.clone())
			var_plugin = var_plugin.array_get(rt.new_int(0))
		}
	}
	mut var_plugin_files := rt.call_function('get_plugin_files', [
		var_plugin.clone()])
	if !rt.is_true(var_file) {
		var_file = var_plugin_files.array_get(rt.new_int(0))
	}
	var_file = rt.call_function('validate_file_to_edit', [var_file.clone(),
		var_plugin_files.clone()])
	mut var_real_file := rt.new_string(
		(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_file.str())
	mut var_plugin_data := rt.call_function('get_plugin_data', [
		rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' +
			(var_plugin_files.array_get(rt.new_int(0))).str()),
	])
	mut var_plugin_name := var_plugin_data.array_get(rt.new_string('Name'))
	mut var_edit_error := rt.new_null()
	mut var_posted_content := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('POST'),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))))
	{
		mut var_edit_result := rt.call_function('wp_edit_theme_plugin_file', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_edit_result.clone()])) {
			var_edit_error = var_edit_result.clone()
			if rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('edit-plugin_' + var_file.str()), rt.new_string('nonce'), rt.new_bool(false)]))
				&& rt.get_superglobal('_POST').array_isset(rt.new_string('newcontent')) {
				var_posted_content = rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('newcontent')),
				])
			}
		} else {
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'a', val: 1 },
						rt.ArrayItem{ key: 'plugin', val: var_plugin },
						rt.ArrayItem{ key: 'file', val: var_file }]),
					rt.call_function('admin_url', [rt.new_string('plugin-editor.php')]),
				]),
			])
			exit(0)
		}
	}
	mut var_editable_extensions := rt.call_function('wp_get_plugin_file_editable_extensions', [
		var_plugin.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [
		var_real_file.clone()])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('sprintf', [rt.new_string('<p>%s</p>'),
				rt.call_function('__', [
					rt.new_string('File does not exist! Please double check the name and try again.'),
				])]),
		])
	} else {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.([^.]+)$/'),
			var_real_file.clone(), rt.create_array_from_list(var_matches)]))
		{
			mut var_extension := var_matches[1].to_string().to_lower()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.new_string(var_extension.str()).clone(),
				var_editable_extensions.clone(),
				rt.new_bool(true),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('sprintf', [rt.new_string('<p>%s</p>'),
						rt.call_function('__', [
							rt.new_string('Files of this type are not editable.'),
						])]),
				])
			}
		}
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can use the plugin file editor to make changes to any of your plugins&#8217; individual PHP files. Be aware that if you make changes, plugins updates will overwrite your customizations.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Choose a plugin to edit from the dropdown menu and click the Select button. Click once on any file name to load it in the editor, and make your changes. Do not forget to save your changes (Update File) when you are finished.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The documentation menu below the editor lists the PHP functions recognized in the plugin file. Clicking Look Up takes you to a web page about that particular function.')])).str() +
				'</p>' + '<p id="editor-keyboard-trap-help-1">' +
				(rt.call_function('__', [rt.new_string('When using a keyboard to navigate:')])).str() +
				'</p>' + '<ul>' + '<li id="editor-keyboard-trap-help-2">' +
				(rt.call_function('__', [rt.new_string('In the editing area, the Tab key enters a tab character.')])).str() +
				'</li>' + '<li id="editor-keyboard-trap-help-3">' +
				(rt.call_function('__', [rt.new_string('To move away from this area, press the Esc key followed by the Tab key.')])).str() +
				'</li>' + '<li id="editor-keyboard-trap-help-4">' +
				(rt.call_function('__', [rt.new_string('Screen reader users: when in forms mode, you may need to press the Esc key twice.')])).str() +
				'</li>' + '</ul>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If you want to make changes but do not want them to be overwritten when the plugin is updated, you may be ready to think about writing your own plugin. For information on how to edit plugins, write your own from scratch, or just better understand their anatomy, check out the links below.')])).str() +
				'</p>' +
				if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) { '<p>' +
				(rt.call_function('__', [rt.new_string('Any edits to files from this screen will be reflected on all sites in the network.')])).str() +
				'</p>' } else { '' } }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/plugins/editor-screen/">Documentation on Editing Plugins</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/plugins/">Documentation on Writing Plugins</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	mut var_settings := {
		'codeEditor': rt.call_function('wp_enqueue_code_editor', [
			{
				'file': var_real_file
			},
		])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-theme-plugin-editor')])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-theme-plugin-editor'),
		rt.call_function('sprintf', [
			rt.new_string('jQuery( function( $ ) { wp.themePluginEditor.init( $( "#template" ), %s ); } )'),
			rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_settings),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-theme-plugin-editor'),
		rt.call_function('sprintf', [
			rt.new_string('wp.themePluginEditor.themeOrPlugin = "plugin";'),
		])])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.call_function('update_recently_edited', [
		rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_file.str()),
	])
	if !(!rt.is_true(var_posted_content)) {
		mut var_content := var_posted_content.clone()
	} else {
		var_content = rt.call_function('file_get_contents', [
			var_real_file.clone()])
	}
	if rt.is_true(rt.call_function('str_ends_with', [var_real_file.clone(),
		rt.new_string('.php')]))
	{
		mut var_functions := rt.call_function('wp_doc_link_parse', [
			var_content.clone()])
		if !(!rt.is_true(var_functions)) {
			mut var_docs_select := '<select name="docs-list" id="docs-list">'
			var_docs_select = var_docs_select + '<option value="">' +
				(rt.call_function('esc_html__', [rt.new_string('Function Name&hellip;')])).str() +
				'</option>'
			mut iter_2 := var_functions.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_function := item_2.val
				var_docs_select = var_docs_select + '<option value="' +
					(rt.call_function('esc_attr', [var_function.clone()])).str() + '">' +
					(rt.call_function('esc_html', [var_function.clone()])).str() + '()</option>'
			}
			var_docs_select = var_docs_select + '</select>'
		}
	}
	var_content = rt.call_function('esc_textarea', [var_content.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('a')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('File edited successfully.')]),
			rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'updated' },
				rt.ArrayItem{ key: none, val: 'is-dismissible' },
			]) }, rt.ArrayItem{ key: 'id', val: 'message' }]),
		])
	} else if rt.is_true(rt.call_function('is_wp_error', [var_edit_error.clone()])) {
		mut var_error := rt.call_function('esc_html', [if rt.is_true(rt.call_method(var_edit_error,
			'get_error_message', []rt.PhpVal{}))
		{
			rt.call_method(var_edit_error, 'get_error_message', []rt.PhpVal{})
		} else {
			rt.call_method(var_edit_error, 'get_error_code', []rt.PhpVal{})
		}])
		mut var_message := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('There was an error while trying to update the file. You may need to fix something and try updating again.')])).str() +
			'</p>\n\t<pre>' + var_error.str() + '</pre>')
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{
					key: 'paragraph_wrap'
					val: false
				}])])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_plugin_active', [var_plugin.clone()])) {
		if rt.is_true(rt.call_function('is_writable', [var_real_file.clone()])) {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Editing %s (active)')]),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_plugin_name.clone()])).str() + '</strong>'),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Browsing %s (active)')]),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_plugin_name.clone()])).str() + '</strong>'),
			])
		}
	} else {
		if rt.is_true(rt.call_function('is_writable', [var_real_file.clone()])) {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Editing %s (inactive)')]),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_plugin_name.clone()])).str() + '</strong>'),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('Browsing %s (inactive)')]),
				rt.new_string('<strong>' +
					(rt.call_function('esc_html', [var_plugin_name.clone()])).str() + '</strong>'),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string(' <span><strong>' +
			(rt.call_function('__', [rt.new_string('File: %s')])).str() + '</strong></span>'),
		rt.call_function('esc_html', [
			var_file.clone(),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select plugin to edit:')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := var_plugins.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_a_plugin := item_3.val
		mut var_plugin_key := item_3.key
		var_plugin_name = var_a_plugin.array_get(rt.new_string('Name'))
		if rt.is_true(rt.identical(var_plugin_key, var_plugin)) {
			mut var_selected := " selected='selected'"
		} else {
			var_selected = ''
		}
		var_plugin_name = rt.call_function('esc_attr', [var_plugin_name.clone()])
		var_plugin_key = rt.call_function('esc_attr', [var_plugin_key.clone()])
		print("\n\t<option value=\"${var_plugin_key.to_string()}\" ${var_selected}>${var_plugin_name.to_string()}</option>")
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Select')]),
		rt.new_string(''), rt.new_string('Submit'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Plugin Files')])
	// unsupported statement: Stmt_InlineHTML
	mut var_plugin_editable_files := []rt.PhpVal{}
	mut iter_4 := var_plugin_files.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_plugin_file := item_4.val
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.([^.]+)$/'), var_plugin_file.clone(), rt.create_array_from_list(var_matches)]))
			&& rt.is_true(rt.call_function('in_array', [var_matches[1], var_editable_extensions.clone(), rt.new_bool(true)])) {
			var_plugin_editable_files << var_plugin_file.clone()
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_plugin_file_tree', [
		rt.call_function('wp_make_plugin_file_tree', [
			rt.create_array_from_list(var_plugin_editable_files),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('edit-plugin_' + var_file.str()),
		rt.new_string('nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Selected file content:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_content)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_file.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_plugin.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(var_docs_select == '') {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Documentation:')])
		// unsupported statement: Stmt_InlineHTML
		print(var_docs_select)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Look Up')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('urlencode', [
			rt.call_function('get_user_locale', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('urlencode', [
			rt.call_function('get_bloginfo', [rt.new_string('version')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_writable', [var_real_file.clone()])) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('in_array', [var_plugin.clone(),
			rt.cast_array(rt.call_function('get_option', [
				rt.new_string('active_plugins'),
				[]rt.PhpVal{},
			])),
			rt.new_bool(true)]))
		{
			rt.call_function('wp_admin_notice', [
				rt.call_function('__', [
					rt.new_string('<strong>Warning:</strong> Making changes to active plugins is not recommended.'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'warning' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'inline' },
						rt.ArrayItem{ key: none, val: 'active-plugin-edit-warning' },
					]) },
				]),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Update File')]),
			rt.new_string('primary'),
			rt.new_string('submit'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('You need to make this file writable before you can save your changes. See <a href="%s">Changing File Permissions</a> for more information.'),
			]),
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/advanced-administration/server/file-permissions/'),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_file_editor_templates', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut var_dismissed_pointers := rt.call_function('explode', [
		rt.new_string(','),
		rt.new_string((rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('dismissed_wp_pointers'),
			rt.new_bool(true),
		])).str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('plugin_editor_notice'),
		var_dismissed_pointers.clone(),
		rt.new_bool(true),
	])))))
	{
		mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
		mut var_excluded_referer_basenames := ['plugin-editor.php', 'wp-login.php']
		mut var_return_url := rt.call_function('admin_url', [
			rt.new_string('/')])
		if rt.is_true(var_referer) {
			mut var_referer_path := rt.call_function('parse_url', [
				var_referer.clone(), rt.get_constant('PHP_URL_PATH')])
			if var_referer_path.clone().is_string()
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('basename', [var_referer_path.clone()]), rt.create_array_from_list(var_excluded_referer_basenames), rt.new_bool(true)]))))) {
				var_return_url = var_referer.clone()
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Heads up!')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You appear to be making direct edits to your plugin in the WordPress dashboard. Editing plugins directly is not recommended as it may introduce incompatibilities that break your site and your changes may be lost in future updates.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('If you absolutely have to make direct edits to this plugin, use a file manager to create a copy with a new name and hang on to the original. That way, you can re-enable a functional version if something goes wrong.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_return_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Go back')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('I understand')])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

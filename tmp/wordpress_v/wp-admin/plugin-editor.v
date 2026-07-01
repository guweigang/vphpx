import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_matches := []rt.PhpVal{}
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))))) {
		rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string('plugin-editor.php')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_plugins')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit plugins for this site.')])])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Edit Plugins')])
	mut var_parent_file := 'plugins.php'
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	if !rt.is_true(var_plugins) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('No plugins are currently available.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
		// unsupported statement: Stmt_InlineHTML
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		// unsupported expression: Expr_Exit
	}
	mut var_file := rt.new_string(rt.new_string(''))
	mut var_plugin := rt.new_string(rt.new_string(''))
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('file')) {
		var_file = rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('file')])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('plugin')) {
		var_plugin = rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('plugin')])
	}
	if !rt.is_true(var_plugin) {
		if rt.is_true(var_file) {
			mut var_file_dirname := rt.call_function('dirname', [var_file.dup()])
			{
				mut iter_1 := rt.func_array_keys(var_plugins.dup()).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_plugin_candidate := item_1.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_plugin_candidate, var_file)) || rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.call_function('dirname', [var_plugin_candidate.dup()]), var_file_dirname)))))) {
						var_plugin = var_plugin_candidate
						break
					}
				}
			}
			if !rt.is_true(var_plugin) {
				var_plugin = var_file.dup()
			}
		} else {
			var_plugin = rt.func_array_keys(var_plugins.dup())
			var_plugin = var_plugin.array_get(0)
		}
	}
	mut var_plugin_files := rt.call_function('get_plugin_files', [var_plugin.dup()])
	if !rt.is_true(var_file) {
		var_file = var_plugin_files.array_get(0)
	}
	var_file = rt.call_function('validate_file_to_edit', [var_file.dup(), var_plugin_files.dup()])
	mut var_real_file := rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str())
	mut var_plugin_data := rt.call_function('get_plugin_data', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin_files.array_get(0)).str()])
	mut var_plugin_name := var_plugin_data.array_get('Name')
	mut var_edit_error := rt.new_null()
	mut var_posted_content := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('POST'), rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD'))) {
		mut var_edit_result := rt.call_function('wp_edit_theme_plugin_file', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').dup()])])
		if rt.is_true(rt.call_function('is_wp_error', [var_edit_result.dup()])) {
			var_edit_error = var_edit_result.dup()
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('check_ajax_referer', ['edit-plugin_' + (var_file).str(), rt.new_string('nonce'), rt.new_bool(false)])) && rt.get_superglobal('_POST').array_isset(rt.new_string('newcontent')))) {
				var_posted_content = rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('newcontent')])
			}
		} else {
			rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'a', val: 1 }, rt.ArrayItem{ key: 'plugin', val: var_plugin }, rt.ArrayItem{ key: 'file', val: var_file }]), rt.call_function('admin_url', [rt.new_string('plugin-editor.php')])])])
			// unsupported expression: Expr_Exit
		}
	}
	mut var_editable_extensions := rt.call_function('wp_get_plugin_file_editable_extensions', [var_plugin.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_real_file.dup()]))))) {
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('File does not exist! Please double check the name and try again.')])])])
	} else {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.([^.]+)$/'), var_real_file.dup(), var_matches.dup()])) {
			mut var_extension := var_matches.array_get(1).to_string().to_lower()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_extension).dup(), var_editable_extensions.dup(), rt.new_bool(true)]))))) {
				rt.call_function('wp_die', [rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('Files of this type are not editable.')])])])
			}
		}
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can use the plugin file editor to make changes to any of your plugins&#8217; individual PHP files. Be aware that if you make changes, plugins updates will overwrite your customizations.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Choose a plugin to edit from the dropdown menu and click the Select button. Click once on any file name to load it in the editor, and make your changes. Do not forget to save your changes (Update File) when you are finished.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('The documentation menu below the editor lists the PHP functions recognized in the plugin file. Clicking Look Up takes you to a web page about that particular function.')])).str() + '</p>' + '<p id="editor-keyboard-trap-help-1">' + (rt.call_function('__', [rt.new_string('When using a keyboard to navigate:')])).str() + '</p>' + '<ul>' + '<li id="editor-keyboard-trap-help-2">' + (rt.call_function('__', [rt.new_string('In the editing area, the Tab key enters a tab character.')])).str() + '</li>' + '<li id="editor-keyboard-trap-help-3">' + (rt.call_function('__', [rt.new_string('To move away from this area, press the Esc key followed by the Tab key.')])).str() + '</li>' + '<li id="editor-keyboard-trap-help-4">' + (rt.call_function('__', [rt.new_string('Screen reader users: when in forms mode, you may need to press the Esc key twice.')])).str() + '</li>' + '</ul>' + '<p>' + (rt.call_function('__', [rt.new_string('If you want to make changes but do not want them to be overwritten when the plugin is updated, you may be ready to think about writing your own plugin. For information on how to edit plugins, write your own from scratch, or just better understand their anatomy, check out the links below.')])).str() + '</p>' + if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) { '<p>' + (rt.call_function('__', [rt.new_string('Any edits to files from this screen will be reflected on all sites in the network.')])).str() + '</p>' } else { '' } }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/plugins/editor-screen/">Documentation on Editing Plugins</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/plugins/">Documentation on Writing Plugins</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	mut var_settings := { 'codeEditor': rt.call_function('wp_enqueue_code_editor', [{ 'file': var_real_file }]) }
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-theme-plugin-editor')])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-theme-plugin-editor'), rt.call_function('sprintf', [rt.new_string('jQuery( function( $ ) { wp.themePluginEditor.init( $( "#template" ), %s ); } )'), rt.call_function('wp_json_encode', [var_settings.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-theme-plugin-editor'), rt.call_function('sprintf', [rt.new_string('wp.themePluginEditor.themeOrPlugin = "plugin";')])])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.call_function('update_recently_edited', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str()])
	if !(!rt.is_true(var_posted_content)) {
		mut var_content := var_posted_content.dup()
	} else {
		var_content = rt.call_function('file_get_contents', [var_real_file.dup()])
	}
	if rt.is_true(rt.call_function('str_ends_with', [var_real_file.dup(), rt.new_string('.php')])) {
		mut var_functions := rt.call_function('wp_doc_link_parse', [var_content.dup()])
		if !(!rt.is_true(var_functions)) {
			mut var_docs_select := '<select name="docs-list" id="docs-list">'
			// unsupported expression: Expr_AssignOp_Concat
			{
				mut iter_1 := var_functions.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_function := item_1.val
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	var_content = rt.call_function('esc_textarea', [var_content.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('a')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('File edited successfully.')]), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }, rt.ArrayItem{ key: none, val: 'is-dismissible' }]) }, rt.ArrayItem{ key: 'id', val: 'message' }])])
	} else if rt.is_true(rt.call_function('is_wp_error', [var_edit_error.dup()])) {
		mut var_error := rt.call_function('esc_html', [if rt.is_true(rt.call_method(var_edit_error, 'get_error_message', []rt.PhpVal{})) { rt.call_method(var_edit_error, 'get_error_message', []rt.PhpVal{}) } else { rt.call_method(var_edit_error, 'get_error_code', []rt.PhpVal{}) }])
		mut var_message := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('There was an error while trying to update the file. You may need to fix something and try updating again.')])).str() + '</p>\n\t<pre>' + (var_error).str() + '</pre>')
		rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_plugin_active', [var_plugin.dup()])) {
		if rt.is_true(rt.call_function('is_writable', [var_real_file.dup()])) {
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Editing %s (active)')]), '<strong>' + (rt.call_function('esc_html', [var_plugin_name.dup()])).str() + '</strong>'])
		} else {
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Browsing %s (active)')]), '<strong>' + (rt.call_function('esc_html', [var_plugin_name.dup()])).str() + '</strong>'])
		}
	} else {
		if rt.is_true(rt.call_function('is_writable', [var_real_file.dup()])) {
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Editing %s (inactive)')]), '<strong>' + (rt.call_function('esc_html', [var_plugin_name.dup()])).str() + '</strong>'])
		} else {
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Browsing %s (inactive)')]), '<strong>' + (rt.call_function('esc_html', [var_plugin_name.dup()])).str() + '</strong>'])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [' <span><strong>' + (rt.call_function('__', [rt.new_string('File: %s')])).str() + '</strong></span>', rt.call_function('esc_html', [var_file.dup()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select plugin to edit:')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_a_plugin := item_1.val
			mut var_plugin_key := item_1.key
			var_plugin_name = var_a_plugin.array_get('Name')
			if rt.is_true(rt.identical(var_plugin_key, var_plugin)) {
				mut var_selected := ' selected=\'selected\''
			} else {
				var_selected = ''
			}
			var_plugin_name = rt.call_function('esc_attr', [var_plugin_name.dup()])
			var_plugin_key = rt.call_function('esc_attr', [var_plugin_key.dup()])
			print("\n\t<option value=\"${var_plugin_key.to_string()}\" ${var_selected}>${var_plugin_name.to_string()}</option>")
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Select')]), rt.new_string(''), rt.new_string('Submit'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Plugin Files')])
	// unsupported statement: Stmt_InlineHTML
	mut var_plugin_editable_files := []rt.PhpVal{}
	{
		mut iter_1 := var_plugin_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_file := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.([^.]+)$/'), var_plugin_file.dup(), var_matches.dup()])) && rt.is_true(rt.call_function('in_array', [var_matches.array_get(1), var_editable_extensions.dup(), rt.new_bool(true)])))) {
				var_plugin_editable_files << var_plugin_file.dup()
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_plugin_file_tree', [rt.call_function('wp_make_plugin_file_tree', [var_plugin_editable_files.dup()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', ['edit-plugin_' + (var_file).str(), rt.new_string('nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Selected file content:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}

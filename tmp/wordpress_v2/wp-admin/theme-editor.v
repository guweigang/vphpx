import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', [rt.new_string('theme-editor.php')]),
		])
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_themes'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit templates for this site.')])).str() +
				'</p>'),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Edit Themes')])
	mut var_parent_file := 'themes.php'
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can use the theme file editor to edit the individual CSS and PHP files which make up your theme.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Begin by choosing a theme to edit from the dropdown menu and clicking the Select button. A list then appears of the theme&#8217;s template files. Clicking once on any file name causes the file to appear in the large Editor box.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('For PHP files, you can use the documentation dropdown to select from functions recognized in that file. Look Up takes you to a web page with reference material about that particular function.')])).str() +
				'</p>' + '<p id="editor-keyboard-trap-help-1">' +
				(rt.call_function('__', [rt.new_string('When using a keyboard to navigate:')])).str() +
				'</p>' + '<ul>' + '<li id="editor-keyboard-trap-help-2">' +
				(rt.call_function('__', [rt.new_string('In the editing area, the Tab key enters a tab character.')])).str() +
				'</li>' + '<li id="editor-keyboard-trap-help-3">' +
				(rt.call_function('__', [rt.new_string('To move away from this area, press the Esc key followed by the Tab key.')])).str() +
				'</li>' + '<li id="editor-keyboard-trap-help-4">' +
				(rt.call_function('__', [rt.new_string('Screen reader users: when in forms mode, you may need to press the Esc key twice.')])).str() +
				'</li>' + '</ul>' + '<p>' +
				(rt.call_function('__', [rt.new_string('After typing in your edits, click Update File.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('<strong>Advice:</strong> Think very carefully about your site crashing if you are live-editing the theme currently in use.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Upgrading to a newer version of the same theme will override changes made here. To avoid this, consider creating a <a href="%s">child theme</a> instead.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/')])])).str() +
				'</p>' +
				if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) { '<p>' +
				(rt.call_function('__', [rt.new_string('Any edits to files from this screen will be reflected on all sites in the network.')])).str() +
				'</p>' } else { '' } }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/themes/">Documentation on Theme Development</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-theme-file-editor-screen/">Documentation on Editing Themes</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/wordpress/edit-files/">Documentation on Editing Files</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/themes/basics/template-tags/">Documentation on Template Tags</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	mut var_theme := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme')),
		]) } else { rt.new_string('') }
	mut var_file := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('file')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('file')),
		]) } else { rt.new_string('') }
	mut var_error := !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('error'))))
	if rt.is_true(var_theme) {
		mut var_stylesheet := var_theme.clone()
	} else {
		var_stylesheet = rt.call_function('get_stylesheet', []rt.PhpVal{})
	}
	var_theme = rt.call_function('wp_get_theme', [var_stylesheet.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('The requested theme does not exist.')]),
		])
	}
	if rt.is_true(rt.call_method(var_theme, 'errors', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('theme_no_stylesheet'), rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_code', []rt.PhpVal{}))) {
		rt.call_function('wp_die', [
			rt.new_string(
				(rt.call_function('__', [rt.new_string('The requested theme does not exist.')])).str() +
				' ' +(rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str()),
		])
	}
	mut var_allowed_files := rt.new_array()
	mut var_style_files := rt.new_array()
	mut var_file_types := rt.call_function('wp_get_theme_file_editable_extensions', [
		var_theme.clone(),
	])
	mut iter_1 := var_file_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_type := item_1.val
		mut switch_val_1 := var_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('php'))) {
			var_allowed_files = rt.add(var_allowed_files, rt.call_method(var_theme, 'get_files', [
				rt.new_string('php'),
				rt.new_int(-1),
			]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('css'))) {
			var_style_files = rt.call_method(var_theme, 'get_files', [
				rt.new_string('css'),
				rt.new_int(-1),
			])
			var_allowed_files.array_set('style.css',
				var_style_files.array_get(rt.new_string('style.css')))
			var_allowed_files = rt.add(var_allowed_files, var_style_files)
		} else {
			var_allowed_files = rt.add(var_allowed_files, rt.call_method(var_theme, 'get_files', [
				var_type.clone(),
				rt.new_int(-1),
			]))
		}
	}
	if var_allowed_files.array_isset(rt.new_string('functions.php')) {
		var_allowed_files = rt.add(rt.create_array([
			rt.ArrayItem{
				key: 'functions.php'
				val: var_allowed_files.array_get(rt.new_string('functions.php'))
			},
		]), var_allowed_files)
	}
	if var_allowed_files.array_isset(rt.new_string('style.css')) {
		var_allowed_files = rt.add(rt.create_array([
			rt.ArrayItem{
				key: 'style.css'
				val: var_allowed_files.array_get(rt.new_string('style.css'))
			},
		]), var_allowed_files)
	}
	if !rt.is_true(var_file) {
		mut var_relative_file := rt.new_string('style.css')
		var_file = var_allowed_files.array_get(rt.new_string('style.css'))
	} else {
		var_relative_file = rt.call_function('wp_unslash', [var_file.clone()])
		var_file = rt.new_string(
			(rt.call_method(var_theme, 'get_stylesheet_directory', []rt.PhpVal{})).str() + '/' +
			var_relative_file.str())
	}
	rt.call_function('validate_file_to_edit', [var_file.clone(),
		var_allowed_files.clone()])
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
			if rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('edit-theme_' + var_stylesheet.str() + '_' + var_relative_file.str()), rt.new_string('nonce'), rt.new_bool(false)]))
				&& rt.get_superglobal('_POST').array_isset(rt.new_string('newcontent')) {
				var_posted_content = rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('newcontent')),
				])
			}
		} else {
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'a', val: 1 },
						rt.ArrayItem{ key: 'theme', val: var_stylesheet },
						rt.ArrayItem{ key: 'file', val: var_relative_file }]),
					rt.call_function('admin_url', [rt.new_string('theme-editor.php')]),
				]),
			])
			exit(0)
		}
	}
	mut var_settings := {
		'codeEditor': rt.call_function('wp_enqueue_code_editor', [
			rt.call_function('compact', [rt.new_string('file')]),
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
		rt.new_string('wp.themePluginEditor.themeOrPlugin = "theme";')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.call_function('update_recently_edited', [var_file.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [
		var_file.clone()])))))
	{
		var_error = true
	}
	mut var_content := rt.new_string('')
	if !(!rt.is_true(var_posted_content)) {
		var_content = var_posted_content.clone()
	} else if !var_error
		&& rt.is_true(rt.greater(rt.call_function('filesize', [var_file.clone()]), rt.new_int(0))) {
		mut var_f := rt.call_function('fopen', [var_file.clone(),
			rt.new_string('r')])
		var_content = rt.call_function('fread', [var_f.clone(),
			rt.call_function('filesize', [var_file.clone()])])
		if rt.is_true(rt.call_function('str_ends_with', [var_file.clone(),
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
	}
	mut var_file_show := rt.call_function('array_search', [var_file.clone(),
		rt.call_function('array_filter', [var_allowed_files.clone()]),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('a')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('File edited successfully.')]),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }]),
		])
	} else if rt.is_true(rt.call_function('is_wp_error', [var_edit_error.clone()])) {
		mut var_error_code := rt.call_function('esc_html', [if rt.is_true(rt.call_method(var_edit_error,
			'get_error_message', []rt.PhpVal{}))
		{
			rt.call_method(var_edit_error, 'get_error_message', []rt.PhpVal{})
		} else {
			rt.call_method(var_edit_error, 'get_error_code', []rt.PhpVal{})
		}])
		mut var_message := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('There was an error while trying to update the file. You may need to fix something and try updating again.')])).str() +
			'</p>\n\t<pre>' + var_error_code.str() + '</pre>')
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'id', val: 'message' }])])
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.css$/'),
		var_file.clone()]))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
			var_message = rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('Did you know?')])).str() +
				'</strong></p><p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is no need to change your CSS here &mdash; you can edit and live preview CSS changes in the <a href="%s">built-in CSS editor</a>.')]), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('autofocus[section]'), rt.new_string('custom_css'), rt.call_function('admin_url', [rt.new_string('customize.php')])])])])).str() +
				'</p>')
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
					rt.ArrayItem{ key: 'id', val: 'message' }])])
		} else if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
			mut var_site_editor_url := rt.call_function('admin_url', [
				rt.call_function('add_query_arg', [
					rt.call_function('urlencode_deep', [
						rt.create_array([rt.ArrayItem{ key: 'p', val: '/styles' },
							rt.ArrayItem{ key: 'section', val: '/css' }]),
					]),
					rt.new_string('site-editor.php'),
				]),
			])
			var_message = rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('Did you know?')])).str() +
				'</strong></p><p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is no need to change your CSS here &mdash; you can edit and live preview CSS changes in the <a href="%s">built-in CSS editor</a>.')]), rt.call_function('esc_url', [var_site_editor_url.clone()])])).str() +
				'</p>')
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
					rt.ArrayItem{ key: 'id', val: 'message' }])])
		}
		if rt.is_true(rt.call_function('file_exists', [
			rt.call_function('preg_replace', [rt.new_string('/\\.css$/'),
				rt.new_string('.min.css'), var_file.clone()]),
		]))
		{
			var_message = rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('There is a minified version of this stylesheet.')])).str() +
				'</strong></p><p>' +
				(rt.call_function('__', [rt.new_string('It is likely that this unminified stylesheet will not be served to visitors.')])).str() +
				'</p>')
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
					rt.ArrayItem{ key: 'id', val: 'wp-css-min-warning' }])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
		'get', [rt.new_string('Name')]), rt.call_method(var_theme, 'display', [
		rt.new_string('Name'),
	])))
	{
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Editing %s (active)')]),
			rt.new_string('<strong>' +
				(rt.call_method(var_theme, 'display', [rt.new_string('Name')])).str() + '</strong>'),
		])
	} else {
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Editing %s (inactive)')]),
			rt.new_string('<strong>' +
				(rt.call_method(var_theme, 'display', [rt.new_string('Name')])).str() + '</strong>'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string(' <span><strong>' +
			(rt.call_function('__', [rt.new_string('File: %s')])).str() + '</strong></span>'),
		rt.call_function('esc_html', [
			var_file_show.clone(),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select theme to edit:')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := rt.call_function('wp_get_themes', [
		rt.create_array([rt.ArrayItem{ key: 'errors', val: rt.new_null() }]),
	]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_a_theme := item_3.val
		mut var_a_stylesheet := item_3.key
		if rt.is_true(rt.call_method(var_a_theme, 'errors', []rt.PhpVal{}))
			&& rt.is_true(rt.identical(rt.new_string('theme_no_stylesheet'), rt.call_method(rt.call_method(var_a_theme, 'errors', []rt.PhpVal{}), 'get_error_code', []rt.PhpVal{}))) {
			continue
		}
		mut var_selected := if rt.is_true(rt.identical(var_a_stylesheet, var_stylesheet)) {
			' selected="selected"'
		} else {
			''
		}
		print('\n\t' + '<option value="' +
			(rt.call_function('esc_attr', [var_a_stylesheet.clone()])).str() + '"' + var_selected +
			'>' + (rt.call_method(var_a_theme, 'display', [rt.new_string('Name')])).str() +
			'</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Select')]),
		rt.new_string(''), rt.new_string('Submit'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_theme, 'errors', []rt.PhpVal{})) {
		rt.call_function('wp_admin_notice', [
			rt.new_string('<strong>' +
				(rt.call_function('__', [rt.new_string('This theme is broken.')])).str() +
				'</strong> ' +(rt.call_method(rt.call_method(var_theme, 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Theme Files')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_theme, 'parent', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('This child theme inherits templates from a parent theme, %s.'),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<a href="%s">%s</a>'),
				rt.call_function('self_admin_url', [
					rt.new_string('theme-editor.php?theme=' +(rt.call_function('urlencode', [rt.call_method(var_theme, 'get_template', []rt.PhpVal{})])).str()),
				]),
				rt.call_method(rt.call_method(var_theme, 'parent', []rt.PhpVal{}), 'display', [
					rt.new_string('Name'),
				]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_theme_file_tree', [
		rt.call_function('wp_make_theme_file_tree', [var_allowed_files.clone()]),
	])
	// unsupported statement: Stmt_InlineHTML
	if var_error {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('File does not exist! Please double check the name and try again.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			]),
		])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [
			rt.new_string('edit-theme_' + var_stylesheet.str() + '_' + var_relative_file.str()),
			rt.new_string('nonce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Selected file content:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_content)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_relative_file.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_functions)) {
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
		if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{}))
			&& rt.is_true(rt.identical(rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}), rt.call_function('get_template', []rt.PhpVal{}))) {
			var_message = rt.new_string((if rt.is_true(rt.call_function('is_writable', [
				var_file.clone(),
			]))
			{
				'<strong>' + (rt.call_function('__', [rt.new_string('Caution:')])).str() +
					'</strong> '
			} else {
				''
			}).str())
			var_message = rt.concat(var_message, rt.call_function('__', [
				rt.new_string('This is a file in your current parent theme.'),
			]))
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'inline' },
					]) }])])
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_writable', [var_file.clone()])) {
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
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_dismissed_pointers := rt.call_function('explode', [
		rt.new_string(','),
		rt.new_string((rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('dismissed_wp_pointers'),
			rt.new_bool(true),
		])).str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('theme_editor_notice'),
		var_dismissed_pointers.clone(),
		rt.new_bool(true),
	])))))
	{
		mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
		mut var_excluded_referer_basenames := ['theme-editor.php', 'wp-login.php']
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
			rt.new_string('You appear to be making direct edits to your theme in the WordPress dashboard. It is not recommended! Editing your theme directly could break your site and your changes may be lost in future updates.'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'parent', []rt.PhpVal{}))))) {
			print('<p>')
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('If you need to tweak more than your theme&#8217;s CSS, you might want to try <a href="%s">making a child theme</a>.'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('__', [
						rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/'),
					]),
				]),
			])
			print('</p>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('If you decide to go ahead with direct edits anyway, use a file manager to create a copy with a new name and hang on to the original. That way, you can re-enable a functional version if something goes wrong.'),
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

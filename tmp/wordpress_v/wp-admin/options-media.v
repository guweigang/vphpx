import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage options for this site.')])])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Media Settings')])
	mut var_parent_file := 'options-general.php'
	mut var_media_options_help := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can set maximum sizes for images inserted into your written content; you can also insert an image as Full Size.')])).str() + '</p>')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('upload_url_path')])) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('upload_path')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_media_options_help }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-media-screen/">Documentation on Media Settings</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('media')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image sizes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The sizes listed below determine the maximum dimensions in pixels to use when adding an image to the Media Library.')])
	// unsupported statement: Stmt_InlineHTML
	mut var_thumbnail_size_title := rt.call_function('__', [rt.new_string('Thumbnail size')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_thumbnail_size_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_thumbnail_size_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Width')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('thumbnail_size_w')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Height')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('thumbnail_size_h')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('thumbnail_crop')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Crop thumbnail to exact dimensions (normally thumbnails are proportional)')])
	// unsupported statement: Stmt_InlineHTML
	mut var_medium_size_title := rt.call_function('__', [rt.new_string('Medium size')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_medium_size_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_medium_size_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Max Width')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('medium_size_w')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Max Height')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('medium_size_h')])
	// unsupported statement: Stmt_InlineHTML
	mut var_large_size_title := rt.call_function('__', [rt.new_string('Large size')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_large_size_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_large_size_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Max Width')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('large_size_w')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Max Height')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('large_size_h')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_fields', [rt.new_string('media'), rt.new_string('default')])
	// unsupported statement: Stmt_InlineHTML
	if var_GLOBALS.array_get('wp_settings').array_get('media').array_isset(rt.new_string('embeds')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Embeds')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_settings_fields', [rt.new_string('media'), rt.new_string('embeds')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Uploading Files')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('upload_url_path')])) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_option', [rt.new_string('upload_path')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Store uploads in this folder')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('upload_path')])]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Default is %s')]), rt.new_string('<code>wp-content/uploads</code>')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Full URL path to files')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('upload_url_path')])]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Configuring this is optional. By default, it should be blank.')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('uploads_use_yearmonth_folders')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Organize my uploads into month- and year-based folders')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_settings_fields', [rt.new_string('media'), rt.new_string('uploads')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_sections', [])
	// unsupported statement: Stmt_InlineHTML
}

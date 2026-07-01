import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_locale := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage options for this site.')])])
	}
	mut var_title := rt.call_function('__', [rt.new_string('General Settings')])
	mut var_parent_file := 'options-general.php'
	mut var_timezone_format := rt.call_function('_x', [rt.new_string('Y-m-d H:i:s'), rt.new_string('timezone date format')])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.new_string('options_general_add_js')])
	mut var_options_help := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The fields on this screen determine some of the basics of your site setup.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Most themes show the site title at the top of every page, in the title bar of the browser, and as the identifying name for syndicated feeds. Many themes also show the tagline.')])).str() + '</p>')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_options_help }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-general-screen/">Documentation on General Settings</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('general')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('blogname')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_sample_tagline := rt.call_function('__', [rt.new_string('Just another WordPress site')])
	} else {
		var_sample_tagline = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Just another %s site')]), rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name')])
	}
	mut var_tagline_description := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('In a few words, explain what this site is about. Example: &#8220;%s.&#8221;')]), var_sample_tagline.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Tagline')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('blogdescription')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_tagline_description)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_enqueue_media', []rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [rt.new_string('site-icon')])
		mut var_classes_for_upload_button := 'upload-button button-hero button'
		mut var_classes_for_update_button := 'button'
		mut var_classes_for_wrapper := ''
		if rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) {
			// unsupported expression: Expr_AssignOp_Concat
			mut var_classes_for_button := var_classes_for_update_button
			mut var_classes_for_button_on_change := var_classes_for_upload_button
		} else {
			// unsupported expression: Expr_AssignOp_Concat
			var_classes_for_button = var_classes_for_upload_button
			var_classes_for_button_on_change = var_classes_for_update_button
		}
		mut var_site_icon_id := // unsupported expression: Expr_Cast_Int
		mut var_app_icon_alt_value := rt.new_string(rt.new_string(''))
		mut var_browser_icon_alt_value := rt.new_string(rt.new_string(''))
		mut var_site_icon_url := rt.call_function('get_site_icon_url', []rt.PhpVal{})
		if rt.is_true(var_site_icon_id) {
			mut var_img_alt := rt.call_function('get_post_meta', [var_site_icon_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
			mut var_filename := rt.call_function('wp_basename', [var_site_icon_url.dup()])
			var_app_icon_alt_value = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('App icon preview: The current image has no alternative text. The file name is: %s')]), var_filename.dup()])
			var_browser_icon_alt_value = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Browser icon preview: The current image has no alternative text. The file name is: %s')]), var_filename.dup()])
			if rt.is_true(var_img_alt) {
				var_app_icon_alt_value = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('App icon preview: Current image: %s')]), var_img_alt.dup()])
				var_browser_icon_alt_value = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Browser icon preview: Current image: %s')]), var_img_alt.dup()])
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_site_icon_url.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_classes_for_wrapper).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_site_icon_url.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_app_icon_alt_value.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_site_icon_url.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_browser_icon_alt_value.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('bloginfo', [rt.new_string('name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('site_icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_classes_for_button).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_classes_for_button_on_change).dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Choose a Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Change Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Set as Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_function('has_site_icon', []rt.PhpVal{})]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Change Site Icon')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Choose a Site Icon')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('has_site_icon', []rt.PhpVal{})) { 'class="button button-secondary reset remove-site-icon"' } else { 'class="button button-secondary reset remove-site-icon hidden"' })
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove Site Icon')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', []), rt.new_int(512), rt.new_int(512)])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		
	}
	// unsupported statement: Stmt_InlineHTML
}

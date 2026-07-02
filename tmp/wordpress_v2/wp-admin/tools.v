import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& !(!rt.is_true(rt.get_superglobal('_POST'))) {
		if rt.is_true(rt.identical(rt.new_string('export_personal_data'),
			rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		{
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/export-personal-data.php',
				'4')
			return rt.new_null()
		} else if rt.is_true(rt.identical(rt.new_string('remove_personal_data'),
			rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		{
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/erase-personal-data.php',
				'4')
			return rt.new_null()
		}
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('wp-privacy-policy-guide')) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
			'4')
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('options-privacy.php?tab=policyguide'),
			]),
			rt.new_int(301),
		])
		exit(0)
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('page')) {
		if rt.is_true(rt.identical(rt.new_string('export_personal_data'),
			rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		{
			rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() +
				'/wp-load.php', '4')
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('export-personal-data.php')]),
				rt.new_int(301),
			])
			exit(0)
		} else if rt.is_true(rt.identical(rt.new_string('remove_personal_data'),
			rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		{
			rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() +
				'/wp-load.php', '4')
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('erase-personal-data.php')]),
				rt.new_int(301),
			])
			exit(0)
		}
	}
	rt.include_file(@DIR + '/admin.php', '4')
	mut var_title := rt.call_function('__', [rt.new_string('Tools')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'converter' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Categories and Tags Converter'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Categories have hierarchy, meaning that you can nest sub-categories. Tags do not have hierarchy and cannot be nested. Sometimes people start out using one on their posts, then later realize that the other would work better for their content.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The Categories and Tags Converter link on this screen will take you to the Import screen, where that Converter is one of the plugins you can install. Once that plugin is installed, the Activate Plugin &amp; Run Importer link will take you to a screen where you can choose to convert tags into categories or vice versa.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/tools-screen/">Documentation on Tools</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('import')])) {
		mut var_cats := rt.call_function('get_taxonomy', [rt.new_string('category')])
		mut var_tags := rt.call_function('get_taxonomy', [rt.new_string('post_tag')])
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_cats, 'cap'), 'manage_terms')]))
			|| rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tags, 'cap'), 'manage_terms')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Categories and Tags Converter')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('If you want to convert your categories to tags (or vice versa), use the <a href="%s">Categories and Tags Converter</a> available from the Import screen.'),
				]),
				rt.new_string('import.php'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	rt.call_function('do_action', [rt.new_string('tool_box')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

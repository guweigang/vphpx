import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage options for this site.'),
			]),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Writing Settings')])
	mut var_parent_file := 'options-general.php'
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can submit content in several different ways; this screen holds the settings for all of them. The top section controls the editor within the dashboard, while the rest control external publishing methods. For more information on any of these methods, use the documentation links.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() +
				'</p>' }]),
	])
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_post_by_email_configuration'),
		rt.new_bool(true),
	]))
	{
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'options-postemail' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Post Via Email'),
				]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('Post via email settings allow you to send your WordPress installation an email with the content of your post. You must set up a secret email account with POP3 access to use this, and any mail received at this address will be posted, so it&#8217;s a good idea to keep this address very secret.')])).str() +
					'</p>' }]),
		])
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_update_services_configuration'),
		rt.new_bool(true),
	]))
	{
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'options-services' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Update Services'),
				]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('If desired, WordPress will automatically alert various services of your new posts.')])).str() +
					'</p>' }]),
		])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		'<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-writing-screen/">Documentation on Writing Settings</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>',
	])
	rt.call_function('wp_enqueue_script', [rt.new_string('user-profile')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('writing')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.less(rt.call_function('get_site_option', [
		rt.new_string('initial_db_version'),
	]), rt.new_int(32453)))
	{
		// unsupported statement: Stmt_InlineHTML
		mut var_formatting_title := rt.call_function('__', [rt.new_string('Formatting')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_formatting_title)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_formatting_title)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('1'),
			rt.call_function('get_option', [rt.new_string('use_smilies')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Convert emoticons like <code>:-)</code> and <code>:-P</code> to graphics on display'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('1'),
			rt.call_function('get_option', [rt.new_string('use_balanceTags')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('WordPress should correct invalidly nested XHTML automatically'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Default Post Category')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dropdown_categories', [
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 },
			rt.ArrayItem{ key: 'name', val: 'default_category' },
			rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'selected', val: rt.call_function('get_option', [
				rt.new_string('default_category'),
			]) }, rt.ArrayItem{ key: 'hierarchical', val: true }]),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_post_formats := rt.call_function('get_post_format_strings', []rt.PhpVal{})
	var_post_formats.array_unset(rt.new_string('standard'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Default Post Format')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_post_format_string', [rt.new_string('standard')]))
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_post_formats.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_format_name := item_1.val
			mut var_format_slug := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [
				rt.call_function('get_option', [rt.new_string('default_post_format')]),
				var_format_slug.dup(),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_format_slug.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_format_name.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('get_option', [rt.new_string('link_manager_enabled')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Default Link Category')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_dropdown_categories', [
			rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 },
				rt.ArrayItem{ key: 'name', val: 'default_link_category' },
				rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'selected', val: rt.call_function('get_option', [
					rt.new_string('default_link_category'),
				]) }, rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'taxonomy', val: 'link_category' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_fields', [rt.new_string('writing'),
		rt.new_string('default')])
	rt.call_function('do_settings_fields', [rt.new_string('writing'),
		rt.new_string('remote_publishing')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_post_by_email_configuration'),
		rt.new_bool(true),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Post via email')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('To post to WordPress by email, you must set up a secret email account with POP3 access. Any mail received at this address will be posted, so it&#8217;s a good idea to keep this address very secret. Here are three random strings you could use: %1$s, %2$s, %3$s.'),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<kbd>%s</kbd>'),
				rt.call_function('wp_generate_password', [rt.new_int(8),
					rt.new_bool(false)]),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<kbd>%s</kbd>'),
				rt.call_function('wp_generate_password', [rt.new_int(8),
					rt.new_bool(false)]),
			]),
			rt.call_function('sprintf', [
				rt.new_string('<kbd>%s</kbd>'),
				rt.call_function('wp_generate_password', [rt.new_int(8),
					rt.new_bool(false)]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Mail Server')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('mailserver_url')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Port')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('mailserver_port')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Login Name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('form_option', [rt.new_string('mailserver_login')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('get_option', [rt.new_string('mailserver_pass')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Hide password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Default Mail Category')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_dropdown_categories', [
			rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 },
				rt.ArrayItem{ key: 'name', val: 'default_email_category' },
				rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'selected', val: rt.call_function('get_option', [
					rt.new_string('default_email_category'),
				]) }, rt.ArrayItem{ key: 'hierarchical', val: true }]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_settings_fields', [rt.new_string('writing'),
			rt.new_string('post_via_email')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_update_services_configuration'),
		rt.new_bool(true),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Update Services')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_option', [
			rt.new_string('blog_public'),
		])))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('__', []),
				rt.call_function('__', [])])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val()
		} else {
		}
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}

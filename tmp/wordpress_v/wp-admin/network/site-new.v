import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php',
		'4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('create_sites'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to add sites to this network.'),
			]),
		])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen is for Super Admins to add new sites to the network. This is not affected by the registration settings.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If the admin email for the new site does not exist in the database, a new user will also be created.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		'<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-sites-screen">Documentation on Site Management</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forum/multisite/">Support forums</a>')])).str() +
			'</p>',
	])
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('add-site'), rt.get_superglobal('_REQUEST').array_get('action')))))
	{
		rt.call_function('check_admin_referer', [rt.new_string('add-blog'),
			rt.new_string('_wpnonce_add-blog')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('blog').is_array()))))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Cannot create an empty site.')]),
			])
		}
		mut var_blog := rt.get_superglobal('_POST').array_get('blog')
		mut var_domain := ''
		var_blog.array_set('domain', var_blog.array_get('domain').to_string().trim_space())
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('|^([a-zA-Z0-9-])+$|'),
			var_blog.array_get('domain'),
		]))
		{
			var_domain = var_blog.array_get('domain').to_string().to_lower()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install',
			[]rt.PhpVal{})))))
		{
			mut var_subdirectory_reserved_names := rt.call_function('get_subdirectory_reserved_names',
				[]rt.PhpVal{})
			if rt.is_true(rt.call_function('in_array', [rt.new_string(var_domain).dup(),
				var_subdirectory_reserved_names.dup(), rt.new_bool(true)]))
			{
				rt.call_function('wp_die', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The following words are reserved for use by WordPress functions and cannot be used as site names: %s'),
						]),
						'<code>' +
							(rt.call_function('implode', [rt.new_string('</code>, <code>'), var_subdirectory_reserved_names.dup()])).str() +
							'</code>',
					]),
				])
			}
		}
		mut var_title := var_blog.array_get('title')
		mut var_meta := {
			'public': rt.new_int(1)
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('WPLANG')) {
			if rt.is_true(rt.identical(rt.new_string(''),
				rt.get_superglobal('_POST').array_get('WPLANG')))
			{
				var_meta['WPLANG'] = rt.new_string('')
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.call_function('in_array', [
				rt.get_superglobal('_POST').array_get('WPLANG'),
				rt.call_function('get_available_languages', []rt.PhpVal{}),
				rt.new_bool(true)]))
			{
				var_meta['WPLANG'] = rt.get_superglobal('_POST').array_get('WPLANG')
			} else if rt.is_true(rt.new_bool(
				rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')]))
				&& rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{}))))
			{
				mut var_language := rt.call_function('wp_download_language_pack', [
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_POST').array_get('WPLANG')]),
				])
				if rt.is_true(var_language) {
					var_meta['WPLANG'] = var_language.dup()
				}
			}
		}
		if !rt.is_true(var_title) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Missing site title.')]),
			])
		}
		if var_domain == '' {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Missing or invalid site address.'),
				]),
			])
		}
		if rt.is_true(rt.new_bool(var_blog.array_isset(rt.new_string('email'))
			&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_blog.array_get('email').to_string().trim_space())))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Missing email address.')]),
			])
		}
		mut var_email := rt.call_function('sanitize_email', [
			var_blog.array_get('email')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
			var_email.dup()])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid email address.')]),
			])
		}
		if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
			mut var_newdomain :=
				rt.new_string(var_domain + '.' +(rt.call_function('preg_replace', [rt.new_string('|^www\\.|'), rt.new_string(''), rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain')])).str())
			mut var_path := rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'path')
		} else {
			var_newdomain = rt.get_property(rt.call_function('get_network', []rt.PhpVal{}),
				'domain')
			var_path = rt.new_string(
				(rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'path')).str() +
				var_domain + '/')
		}
		mut var_password := rt.new_string(rt.new_string('N/A'))
		mut var_user_id := rt.call_function('email_exists', [
			var_email.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
			rt.call_function('do_action', [
				rt.new_string('pre_network_site_new_created_user'),
				var_email.dup(),
			])
			var_user_id = rt.call_function('username_exists', [
				rt.new_string(var_domain).dup()])
			if rt.is_true(var_user_id) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('The domain or path entered conflicts with an existing username.'),
					]),
				])
			}
			var_password = rt.call_function('wp_generate_password', [
				rt.new_int(12), rt.new_bool(false)])
			var_user_id = rt.call_function('wpmu_create_user', [
				rt.new_string(var_domain).dup(), var_password.dup(),
				var_email.dup()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_user_id)) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('There was an error creating the user.'),
					]),
				])
			}
			rt.call_function('do_action', [
				rt.new_string('network_site_new_created_user'),
				var_user_id.dup(),
			])
		}
		rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
		mut var_id := rt.call_function('wpmu_create_blog', [var_newdomain.dup(),
			var_path.dup(), var_title.dup(), var_user_id.dup(),
			var_meta.dup(), rt.call_function('get_current_network_id', []rt.PhpVal{})])
		rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_id.dup()])))))
		{
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_super_admin', [var_user_id.dup()])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_option', [rt.new_string('primary_blog'), var_user_id.dup()])))))))
			{
				rt.call_function('update_user_option', [var_user_id.dup(),
					rt.new_string('primary_blog'), var_id.dup(),
					rt.new_bool(true)])
			}
			rt.call_function('wpmu_new_site_admin_notification', [
				var_id.dup(), var_user_id.dup()])
			rt.call_function('wpmu_welcome_notification', [var_id.dup(),
				var_user_id.dup(), var_password.dup(), var_title.dup(),
				rt.create_array([rt.ArrayItem{ key: 'public', val: 1 }])])
			rt.call_function('wp_redirect', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'update', val: 'added' },
						rt.ArrayItem{ key: 'id', val: var_id }]),
					rt.new_string('site-new.php'),
				]),
			])
			// unsupported expression: Expr_Exit
		} else {
			rt.call_function('wp_die', [
				rt.call_method(var_id, 'get_error_message', []rt.PhpVal{}),
			])
		}
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('update')) {
		mut var_messages := []rt.PhpVal{}
		if rt.is_true(rt.identical(rt.new_string('added'),
			rt.get_superglobal('_GET').array_get('update')))
		{
			var_messages << rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Site added. <a href="%1$s">Visit Dashboard</a> or <a href="%2$s">Edit Site</a>'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('get_admin_url', [
						rt.call_function('absint', [rt.get_superglobal('_GET').array_get('id')]),
					]),
				]),
				rt.call_function('network_admin_url', [
					'site-info.php?id=' +(rt.call_function('absint', [rt.get_superglobal('_GET').array_get('id')])).str(),
				]),
			])
		}
	}
	var_title = rt.call_function('__', [rt.new_string('Add Site')])
	mut var_parent_file := 'sites.php'
	rt.call_function('wp_enqueue_script', [rt.new_string('user-suggest')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Site')])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_messages)) {
		mut var_notice_args := {
			'type':        rt.new_string('success')
			'dismissible': rt.new_bool(true)
			'id':          rt.new_string('message')
		}
		for var_msg in var_messages {
			rt.call_function('wp_admin_notice', [var_msg.dup(),
				var_notice_args.dup()])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_required_field_message', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('network_admin_url', [
			rt.new_string('site-new.php?action=add-site'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('add-blog'),
		rt.new_string('_wpnonce_add-blog')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Address (URL)')])
	print(' ' + (rt.call_function('wp_required_field_indicator', []rt.PhpVal{})).str())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			'.' +(rt.call_function('preg_replace', [rt.new_string('|^www\\.|'), rt.new_string(''), rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain')])).str(),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.concat(rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain'), rt.get_property(rt.call_function('get_network',
				[]rt.PhpVal{}), 'path')),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Only lowercase letters (a-z), numbers, and hyphens are allowed.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title')])
	print(' ' + (rt.call_function('wp_required_field_indicator', []rt.PhpVal{})).str())
	// unsupported statement: Stmt_InlineHTML
	mut var_languages := rt.call_function('get_available_languages', []rt.PhpVal{})
	mut var_translations := rt.call_function('wp_get_available_translations', []rt.PhpVal{})
	if !(!rt.is_true(var_languages)) || !(!rt.is_true(var_translations)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Language')])
		// unsupported statement: Stmt_InlineHTML
		mut var_lang := rt.call_function('get_site_option', [
			rt.new_string('WPLANG')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_lang.dup(), var_languages.dup(), rt.new_bool(true)])))))
		{
			var_lang = rt.new_string(rt.new_string(''))
		}
		rt.call_function('wp_dropdown_languages', [
			rt.create_array([rt.ArrayItem{ key: 'name', val: 'WPLANG' },
				rt.ArrayItem{ key: 'id', val: 'site-language' },
				rt.ArrayItem{ key: 'selected', val: var_lang },
				rt.ArrayItem{ key: 'languages', val: var_languages },
				rt.ArrayItem{ key: 'translations', val: var_translations },
				rt.ArrayItem{ key: 'show_available_translations', val:
					rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')]))
					&& rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Admin Email')])
	print(' ' + (rt.call_function('wp_required_field_indicator', []rt.PhpVal{})).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('A new user will be created if the above email address is not in the database.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The username and a link to set the password will be mailed to this email address.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

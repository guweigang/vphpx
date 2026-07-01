import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_options')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Network Settings')])
	mut var_parent_file := 'settings.php'
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('network_admin_hash'))) {
		mut var_new_admin_details := rt.call_function('get_site_option', [rt.new_string('network_admin_hash')])
		mut var_redirect := 'settings.php?updated=false'
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_new_admin_details.dup().is_array())) && rt.is_true(rt.call_function('hash_equals', [var_new_admin_details.array_get('hash'), rt.get_superglobal('_GET').array_get('network_admin_hash')])))) && !(!rt.is_true(var_new_admin_details.array_get('newemail'))))) {
			rt.call_function('update_site_option', [rt.new_string('admin_email'), var_new_admin_details.array_get('newemail')])
			rt.call_function('delete_site_option', [rt.new_string('network_admin_hash')])
			rt.call_function('delete_site_option', [rt.new_string('new_admin_email')])
			var_redirect = 'settings.php?updated=true'
		}
		rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string(var_redirect).dup()])])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('dismiss'))) && rt.is_true(rt.identical(rt.new_string('new_network_admin_email'), rt.get_superglobal('_GET').array_get('dismiss'))))) {
		rt.call_function('check_admin_referer', [rt.new_string('dismiss_new_network_admin_email')])
		rt.call_function('delete_site_option', [rt.new_string('network_admin_hash')])
		rt.call_function('delete_site_option', [rt.new_string('new_admin_email')])
		rt.call_function('wp_redirect', [rt.call_function('network_admin_url', [rt.new_string('settings.php?updated=true')])])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.new_string('network_settings_add_js')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen sets and changes options for the network as a whole. The first site is the main site in the network and network options are pulled from that original site&#8217;s options.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Operational settings has fields for the network&#8217;s name and admin email.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Registration settings can disable/enable public signups. If you let others sign up for a site, install spam plugins. Spaces, not commas, should separate names banned as sites for this network.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('New site settings are defaults applied when a new site is created in the network. These include welcome email for when a new site or user account is registered, and what&#8127;s put in the first post, page, comment, comment author, and comment URL.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Upload settings control the size of the uploaded files and the amount of available upload space for each site. You can change the default value for specific sites when you edit a particular site. Allowed file types are also listed (space separated only).')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You can set the language, and WordPress will automatically download and install the translation files (available if your filesystem is writable).')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Menu setting enables/disables the plugin menus from appearing for non super admins, so that only super admins, not site admins, have access to activate plugins.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Super admins can no longer be added on the Options screen. You must now go to the list of existing users on Network Admin > Users and click on Username or the Edit action link below that name. This goes to an Edit User page where you can check a box to grant super admin privileges.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/settings/">Documentation on Network Settings</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	if rt.is_true(rt.get_superglobal('_POST')) {
		rt.call_function('do_action', [rt.new_string('wpmuadminedit')])
		rt.call_function('check_admin_referer', [rt.new_string('siteoptions')])
		mut var_checked_options := { 'menu_items': map[string]rt.PhpVal{}, 'registrationnotification': rt.new_string('no'), 'upload_space_check_disabled': rt.new_int(1), 'add_new_users': rt.new_int(0) }
		for var_option_name, var_option_unchecked_value in var_checked_options {
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string(option_name))) {
				rt.get_superglobal('_POST').array_set(option_name, var_option_unchecked_value.dup())
			}
		}
		mut var_options := ['registrationnotification', 'registration', 'add_new_users', 'menu_items', 'upload_space_check_disabled', 'blog_upload_space', 'upload_filetypes', 'site_name', 'first_post', 'first_page', 'first_comment', 'first_comment_url', 'first_comment_author', 'welcome_email', 'welcome_user_email', 'fileupload_maxk', 'illegal_names', 'limited_email_domains', 'banned_email_domains', 'WPLANG', 'new_admin_email', 'first_comment_email']
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('WPLANG'))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')])))) && rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})))) {
			mut var_language := rt.call_function('wp_download_language_pack', [rt.get_superglobal('_POST').array_get('WPLANG')])
			if rt.is_true(var_language) {
				rt.get_superglobal('_POST').array_set('WPLANG', var_language.dup())
			}
		}
		for var_option_name in var_options {
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string(option_name))) {
				continue
			}
			mut var_value := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(option_name)])
			rt.call_function('update_site_option', [rt.new_string(option_name), var_value.dup()])
		}
		rt.call_function('do_action', [rt.new_string('update_wpmu_options')])
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('updated'), rt.new_string('true'), rt.call_function('network_admin_url', [rt.new_string('settings.php')])])])
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
		rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('Settings saved.')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' }, rt.ArrayItem{ key: 'dismissible', val: true }, rt.ArrayItem{ key: 'id', val: 'message' }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('siteoptions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Operational Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Network Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Network Admin Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_site_option', [rt.new_string('admin_email')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('This address is used for admin purposes. If you change this, an email will be sent to your new address to confirm it. <strong>The new address will not become active until confirmed.</strong>')])
	// unsupported statement: Stmt_InlineHTML
	mut var_new_admin_email := rt.call_function('get_site_option', [rt.new_string('new_admin_email')])
	if rt.is_true(rt.new_bool(rt.is_true(var_new_admin_email) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_notice_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There is a pending change of the network admin email to %s.')]), '<code>' + (rt.call_function('esc_html', [var_new_admin_email.dup()])).str() + '</code>'])
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('wp_admin_notice', [var_notice_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'dismissible', val: true }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'inline' }]) }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Registration Settings')])
	// unsupported statement: Stmt_InlineHTML
	mut var_new_registrations_settings_title := rt.call_function('__', [rt.new_string('Allow new registrations')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_new_registrations_settings_title)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [rt.new_string('registration')]))))) {
		rt.call_function('update_site_option', [rt.new_string('registration'), rt.new_string('none')])
	}
	mut var_reg := rt.call_function('get_site_option', [rt.new_string('registration')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_new_registrations_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.dup(), rt.new_string('none')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Registration is disabled')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.dup(), rt.new_string('user')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('User accounts may be registered')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.dup(), rt.new_string('blog')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Logged in users may register new sites')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.dup(), rt.new_string('all')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Both sites and user accounts can be registered')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		print('<p class="description">')
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('If registration is disabled, please set %1$s in %2$s to a URL you will redirect visitors to if they visit a non-existent site.')]), rt.new_string('<code>NOBLOGREDIRECT</code>'), rt.new_string('<code>wp-config.php</code>')])
		print('</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Registration notification')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [rt.new_string('registrationnotification')]))))) {
		rt.call_function('update_site_option', [rt.new_string('registrationnotification'), rt.new_string('yes')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.call_function('get_site_option', [rt.new_string('registrationnotification')]), rt.new_string('yes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Send the network admin an email notification every time someone registers a site or user account')])
	// unsupported statement: Stmt_InlineHTML
	
}

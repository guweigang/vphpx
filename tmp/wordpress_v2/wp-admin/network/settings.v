import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php',
		'4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_network_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to access this page.'),
			]),
			rt.new_int(403),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Network Settings')])
	mut var_parent_file := 'settings.php'
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('network_admin_hash')))) {
		mut var_new_admin_details := rt.call_function('get_site_option', [
			rt.new_string('network_admin_hash'),
		])
		mut var_redirect := 'settings.php?updated=false'
		if var_new_admin_details.clone().is_array()
			&& rt.is_true(rt.call_function('hash_equals', [var_new_admin_details.array_get(rt.new_string('hash')), rt.get_superglobal('_GET').array_get(rt.new_string('network_admin_hash'))]))
			&& !(!rt.is_true(var_new_admin_details.array_get(rt.new_string('newemail')))) {
			rt.call_function('update_site_option', [rt.new_string('admin_email'),
				var_new_admin_details.array_get(rt.new_string('newemail'))])
			rt.call_function('delete_site_option', [rt.new_string('network_admin_hash')])
			rt.call_function('delete_site_option', [rt.new_string('new_admin_email')])
			var_redirect = 'settings.php?updated=true'
		}
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', [rt.new_string(var_redirect.str()).clone()]),
		])
		exit(0)
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('dismiss'))))
		&& rt.is_true(rt.identical(rt.new_string('new_network_admin_email'), rt.get_superglobal('_GET').array_get(rt.new_string('dismiss')))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('dismiss_new_network_admin_email'),
		])
		rt.call_function('delete_site_option', [rt.new_string('network_admin_hash')])
		rt.call_function('delete_site_option', [rt.new_string('new_admin_email')])
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', [
				rt.new_string('settings.php?updated=true'),
			]),
		])
		exit(0)
	}
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.new_string('network_settings_add_js')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('This screen sets and changes options for the network as a whole. The first site is the main site in the network and network options are pulled from that original site&#8217;s options.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Operational settings has fields for the network&#8217;s name and admin email.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Registration settings can disable/enable public signups. If you let others sign up for a site, install spam plugins. Spaces, not commas, should separate names banned as sites for this network.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('New site settings are defaults applied when a new site is created in the network. These include welcome email for when a new site or user account is registered, and what&#8127;s put in the first post, page, comment, comment author, and comment URL.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Upload settings control the size of the uploaded files and the amount of available upload space for each site. You can change the default value for specific sites when you edit a particular site. Allowed file types are also listed (space separated only).')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can set the language, and WordPress will automatically download and install the translation files (available if your filesystem is writable).')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Menu setting enables/disables the plugin menus from appearing for non super admins, so that only super admins, not site admins, have access to activate plugins.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Super admins can no longer be added on the Options screen. You must now go to the list of existing users on Network Admin > Users and click on Username or the Edit action link below that name. This goes to an Edit User page where you can check a box to grant super admin privileges.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/settings/">Documentation on Network Settings</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	if rt.is_true(rt.get_superglobal('_POST')) {
		rt.call_function('do_action', [rt.new_string('wpmuadminedit')])
		rt.call_function('check_admin_referer', [rt.new_string('siteoptions')])
		mut var_checked_options := {
			'menu_items':                  map[string]rt.PhpVal{}
			'registrationnotification':    rt.new_string('no')
			'upload_space_check_disabled': rt.new_int(1)
			'add_new_users':               rt.new_int(0)
		}
		for var_option_name, var_option_unchecked_value in var_checked_options {
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string(option_name))) {
				rt.get_superglobal('_POST').array_set(option_name,
					var_option_unchecked_value.clone())
			}
		}
		mut var_options := ['registrationnotification', 'registration', 'add_new_users', 'menu_items',
			'upload_space_check_disabled', 'blog_upload_space', 'upload_filetypes', 'site_name',
			'first_post', 'first_page', 'first_comment', 'first_comment_url', 'first_comment_author',
			'welcome_email', 'welcome_user_email', 'fileupload_maxk', 'illegal_names',
			'limited_email_domains', 'banned_email_domains', 'WPLANG', 'new_admin_email',
			'first_comment_email']
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG'))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')]))
			&& rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) {
			mut var_language := rt.call_function('wp_download_language_pack', [
				rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')),
			])
			if rt.is_true(var_language) {
				rt.get_superglobal('_POST').array_set('WPLANG', var_language.clone())
			}
		}
		for var_option_name in var_options {
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string(option_name))) {
				continue
			}
			mut var_value := rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string(option_name)),
			])
			rt.call_function('update_site_option', [rt.new_string(option_name),
				var_value.clone()])
		}
		rt.call_function('do_action', [rt.new_string('update_wpmu_options')])
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('updated'),
				rt.new_string('true'),
				rt.call_function('network_admin_url', [
					rt.new_string('settings.php'),
				])]),
		])
		exit(0)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Settings saved.')]),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'success' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'id', val: 'message' }]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('siteoptions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Operational Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Network Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Network Admin Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_site_option', [rt.new_string('admin_email')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This address is used for admin purposes. If you change this, an email will be sent to your new address to confirm it. <strong>The new address will not become active until confirmed.</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_new_admin_email := rt.call_function('get_site_option', [
		rt.new_string('new_admin_email'),
	])
	if rt.is_true(var_new_admin_email)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_site_option', [rt.new_string('admin_email')]), var_new_admin_email)))) {
		mut var_notice_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('There is a pending change of the network admin email to %s.'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('esc_html', [var_new_admin_email.clone()])).str() + '</code>'),
		])
		var_notice_message = rt.concat(var_notice_message, rt.call_function('sprintf', [
			rt.new_string(' <a href="%1$s">%2$s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.call_function('network_admin_url', [
						rt.new_string('settings.php?dismiss=new_network_admin_email'),
					]),
					rt.new_string('dismiss_new_network_admin_email'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Cancel'),
			]),
		]))
		rt.call_function('wp_admin_notice', [var_notice_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' },
				rt.ArrayItem{ key: 'dismissible', val: true },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'inline' },
				]) }])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Registration Settings')])
	// unsupported statement: Stmt_InlineHTML
	mut var_new_registrations_settings_title := rt.call_function('__', [
		rt.new_string('Allow new registrations'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_new_registrations_settings_title)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('registration'),
	])))))
	{
		rt.call_function('update_site_option', [rt.new_string('registration'),
			rt.new_string('none')])
	}
	mut var_reg := rt.call_function('get_site_option', [rt.new_string('registration')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_new_registrations_settings_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.clone(), rt.new_string('none')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Registration is disabled')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.clone(), rt.new_string('user')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('User accounts may be registered')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.clone(), rt.new_string('blog')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Logged in users may register new sites')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_reg.clone(), rt.new_string('all')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Both sites and user accounts can be registered'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		print('<p class="description">')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('If registration is disabled, please set %1$s in %2$s to a URL you will redirect visitors to if they visit a non-existent site.'),
			]),
			rt.new_string('<code>NOBLOGREDIRECT</code>'),
			rt.new_string('<code>wp-config.php</code>'),
		])
		print('</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Registration notification')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [
		rt.new_string('registrationnotification'),
	])))))
	{
		rt.call_function('update_site_option', [
			rt.new_string('registrationnotification'),
			rt.new_string('yes'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_function('get_site_option', [rt.new_string('registrationnotification')]),
		rt.new_string('yes'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Send the network admin an email notification every time someone registers a site or user account'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Users')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_function('get_site_option', [rt.new_string('add_new_users')]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Allow site administrators to add new users to their site via the "Users &rarr; Add User" page'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Banned Names')])
	// unsupported statement: Stmt_InlineHTML
	mut var_illegal_names := rt.call_function('get_site_option', [
		rt.new_string('illegal_names'),
	])
	if !rt.is_true(var_illegal_names) {
		var_illegal_names = rt.new_string('')
	} else if rt.is_true(rt.new_bool(var_illegal_names.clone().is_array())) {
		var_illegal_names = rt.call_function('implode', [rt.new_string(' '),
			var_illegal_names.clone()])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_illegal_names.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Users are not allowed to register these sites. Separate names by spaces.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Limited Email Registrations')])
	// unsupported statement: Stmt_InlineHTML
	mut var_limited_email_domains := rt.call_function('get_site_option', [
		rt.new_string('limited_email_domains'),
	])
	if !rt.is_true(var_limited_email_domains) {
		var_limited_email_domains = rt.new_string('')
	} else {
		var_limited_email_domains = rt.call_function('str_replace', [
			rt.new_string(' '), rt.new_string('\n'), var_limited_email_domains.clone()])
		if rt.is_true(rt.new_bool(var_limited_email_domains.clone().is_array())) {
			var_limited_email_domains = rt.call_function('implode', [
				rt.new_string('\n'), var_limited_email_domains.clone()])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [var_limited_email_domains.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you want to limit site registrations to certain domains. One domain per line.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Banned Email Domains')])
	// unsupported statement: Stmt_InlineHTML
	mut var_banned_email_domains := rt.call_function('get_site_option', [
		rt.new_string('banned_email_domains'),
	])
	if !rt.is_true(var_banned_email_domains) {
		var_banned_email_domains = rt.new_string('')
	} else if rt.is_true(rt.new_bool(var_banned_email_domains.clone().is_array())) {
		var_banned_email_domains = rt.call_function('implode', [
			rt.new_string('\n'), var_banned_email_domains.clone()])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [var_banned_email_domains.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you want to ban domains from site registrations. One domain per line.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('New Site Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Welcome Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_site_option', [rt.new_string('welcome_email')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The welcome email sent to new site owners.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Welcome User Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_site_option', [rt.new_string('welcome_user_email')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The welcome email sent to new users.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('First Post')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_site_option', [rt.new_string('first_post')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The first post on a new site.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('First Page')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_site_option', [rt.new_string('first_page')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The first page on a new site.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('First Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.call_function('get_site_option', [rt.new_string('first_comment')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The first comment on a new site.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('First Comment Author')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_site_option', [rt.new_string('first_comment_author')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The author of the first comment on a new site.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('First Comment Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_site_option', [rt.new_string('first_comment_email')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The email address of the first comment author on a new site.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('First Comment URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_site_option', [rt.new_string('first_comment_url')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The URL for the first comment on a new site.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Upload Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site upload space')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.new_bool((rt.call_function('get_site_option', [
			rt.new_string('upload_space_check_disabled'),
		])).to_bool()),
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Limit total size of files uploaded to %s MB'),
		]),
		rt.new_string(
			'</label><label><input name="blog_upload_space" type="number" min="0" style="width: 100px" id="blog_upload_space" aria-describedby="blog-upload-space-desc" value="' +
			(rt.call_function('esc_attr', [rt.call_function('get_site_option', [rt.new_string('blog_upload_space'), rt.new_int(100)])])).str() +
			'" />'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size in megabytes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Upload file types')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('get_site_option', [rt.new_string('upload_filetypes'),
			rt.new_string('jpg jpeg png gif')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Allowed file types. Separate types by spaces.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Max upload file size')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('%s KB')]),
		rt.new_string(
			'<input name="fileupload_maxk" type="number" min="0" style="width: 100px" id="fileupload_maxk" aria-describedby="fileupload-maxk-desc" value="' +
			(rt.call_function('esc_attr', [rt.call_function('get_site_option', [rt.new_string('fileupload_maxk'), rt.new_int(300)])])).str() +
			'" />')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size in kilobytes')])
	// unsupported statement: Stmt_InlineHTML
	mut var_languages := rt.call_function('get_available_languages', []rt.PhpVal{})
	mut var_translations := rt.call_function('wp_get_available_translations', []rt.PhpVal{})
	if !(!rt.is_true(var_languages)) || !(!rt.is_true(var_translations)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Language Settings')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Default Language')])
		// unsupported statement: Stmt_InlineHTML
		mut var_lang := rt.call_function('get_site_option', [
			rt.new_string('WPLANG')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_lang.clone(), var_languages.clone(), rt.new_bool(true)])))))
		{
			var_lang = rt.new_string('')
		}
		rt.call_function('wp_dropdown_languages', [
			rt.create_array([rt.ArrayItem{ key: 'name', val: 'WPLANG' },
				rt.ArrayItem{ key: 'id', val: 'WPLANG' }, rt.ArrayItem{
					key: 'selected'
					val: var_lang
				}, rt.ArrayItem{ key: 'languages', val: var_languages },
				rt.ArrayItem{ key: 'translations', val: var_translations },
				rt.ArrayItem{ key: 'show_available_translations', val:
					rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')]))
					&& rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_menu_perms := rt.call_function('get_site_option', [
		rt.new_string('menu_items'),
	])
	mut var_menu_items := rt.call_function('apply_filters', [
		rt.new_string('mu_menu_items'),
		rt.create_array([
			rt.ArrayItem{ key: 'plugins', val: rt.call_function('__', [
				rt.new_string('Plugins'),
			]) },
		]),
	])
	if rt.is_true(var_menu_items) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Menu Settings')])
		// unsupported statement: Stmt_InlineHTML
		mut var_enable_administration_menus_title := rt.call_function('__', [
			rt.new_string('Enable administration menus'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_enable_administration_menus_title)
		// unsupported statement: Stmt_InlineHTML
		print('<fieldset><legend class="screen-reader-text">' +
			var_enable_administration_menus_title.str() + '</legend>')
		mut iter_1 := rt.cast_array(var_menu_items).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_key := item_1.key
			print("<label><input type='checkbox' name='menu_items[" + var_key.str() +
				"]' value='1'" +
				(if var_menu_perms.array_isset(var_key) { rt.call_function('checked', [var_menu_perms.array_get(var_key), rt.new_string('1'), rt.new_bool(false)]) } else { rt.new_string('') }).str() +
				' /> ' + (rt.call_function('esc_html', [var_val.clone()])).str() + '</label><br/>')
		}
		print('</fieldset>')
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('wpmu_options')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

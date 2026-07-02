import rt

fn network_domain_check() bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'),
			rt.call_method(var_wpdb, 'esc_like', [rt.get_property(var_wpdb, 'site')])]),
	]))
	{
		return (rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT domain FROM '), rt.get_property(var_wpdb,
				'site')), rt.new_string(' ORDER BY id ASC LIMIT 1')),
		])).to_bool()
	}
	return false
}

fn allow_subdomain_install() bool {
	mut var_home := rt.new_null()
	mut var_domain := rt.new_null()
	var_home = rt.call_function('get_option', [rt.new_string('home')])
	var_domain = rt.call_function('parse_url', [var_home.clone(),
		rt.get_constant('PHP_URL_HOST')])
	if rt.is_true(rt.call_function('parse_url', [var_home.clone(), rt.get_constant('PHP_URL_PATH')]))
		|| rt.is_true(rt.identical(rt.new_string('localhost'), var_domain))
		|| rt.is_true(rt.call_function('preg_match', [rt.new_string('|^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+$|'), var_domain.clone()])) {
		return false
	}
	return true
}

fn allow_subdirectory_install() bool {
	mut var_wpdb := rt.new_null()
	mut var_post := rt.new_null()
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('allow_subdirectory_install'),
		rt.new_bool(false),
	]))
	{
		return true
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('ALLOW_SUBDIRECTORY_INSTALL')]))
		&& rt.is_true(rt.get_constant('ALLOW_SUBDIRECTORY_INSTALL')) {
		return true
	}
	var_post = rt.call_method(var_wpdb, 'get_row', [
		rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')),
			rt.new_string(" WHERE post_date < DATE_SUB(NOW(), INTERVAL 1 MONTH) AND post_status = 'publish'")),
	])
	if !rt.is_true(var_post) {
		return true
	}
	return false
}

fn get_clean_basedomain() bool {
	mut var_existing_domain := false
	mut var_domain := rt.new_null()
	mut var_slash := rt.new_null()
	var_existing_domain = network_domain_check()
	if var_existing_domain {
		return var_existing_domain
	}
	var_domain = rt.call_function('preg_replace', [rt.new_string('|https?://|'),
		rt.new_string(''), rt.call_function('get_option', [rt.new_string('siteurl')])])
	var_slash = rt.call_function('strpos', [var_domain.clone(),
		rt.new_string('/')])
	if rt.is_true(var_slash) {
		var_domain = rt.call_function('substr', [var_domain.clone(),
			rt.new_int(0), var_slash.clone()])
	}
	return var_domain.to_bool()
}

fn network_step1(errors bool) {
	mut var_errors := errors
	mut var_is_apache := rt.new_null()
	mut var_cannot_define_constant_message := rt.new_null()
	mut var_active_plugins := rt.new_null()
	mut var_hostname := rt.new_null()
	mut var_error_codes := rt.new_null()
	mut var_network_created_error_message := rt.new_null()
	mut var_error := rt.new_null()
	mut var_site_name := rt.new_null()
	mut var_admin_email := rt.new_null()
	mut var_subdomain_install := rt.new_null()
	mut var_got_mod_rewrite := rt.new_null()
	mut var_message_class := ''
	mut var_message := rt.new_null()
	mut var_subdirectory_warning_message := rt.new_null()
	mut var_is_www := rt.new_null()
	if rt.is_true(rt.call_function('defined', [
		rt.new_string('DO_NOT_UPGRADE_GLOBAL_TABLES'),
	]))
	{
		var_cannot_define_constant_message = rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ')
		var_cannot_define_constant_message = rt.concat(var_cannot_define_constant_message, rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The constant %s cannot be defined when creating a network.'),
			]),
			rt.new_string('<code>DO_NOT_UPGRADE_GLOBAL_TABLES</code>'),
		]))
		rt.call_function('wp_admin_notice', [var_cannot_define_constant_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			])])
		print('</div>')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		exit(0)
	}
	var_active_plugins = rt.call_function('get_option', [rt.new_string('active_plugins')])
	if !(!rt.is_true(var_active_plugins)) {
		rt.call_function('wp_admin_notice', [
			rt.new_string('<strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() +
				'</strong> ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please <a href="%s">deactivate your plugins</a> before enabling the Network feature.')]), rt.call_function('admin_url', [rt.new_string('plugins.php?plugin_status=active')])])).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'warning' },
			]),
		])
		print('<p>' +
			(rt.call_function('__', [rt.new_string('Once the network is created, you may reactivate your plugins.')])).str() +
			'</p>')
		print('</div>')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		exit(0)
	}
	var_hostname = rt.call_function('preg_replace', [rt.new_string('/(?::80|:443)$/'),
		rt.new_string(''), rt.new_bool(get_clean_basedomain())])
	print('<form method="post">')
	rt.call_function('wp_nonce_field', [rt.new_string('install-network-1')])
	var_error_codes = rt.new_array()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(errors)])) {
		var_network_created_error_message = rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ' +
			(rt.call_function('__', [rt.new_string('The network could not be created.')])).str() +
			'</p>')
		mut iter_1 :=
			rt.call_method(rt.new_bool(errors), 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error_shadow := item_1.val
			var_network_created_error_message = rt.concat(var_network_created_error_message,
				rt.new_string('<p>${var_error.to_string()}</p>'))
		}
		rt.call_function('wp_admin_notice', [var_network_created_error_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
				rt.ArrayItem{ key: 'paragraph_wrap', val: false },
			])])
		var_error_codes = rt.call_method(rt.new_bool(errors), 'get_error_codes', []rt.PhpVal{})
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('sitename'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('empty_sitename'), var_error_codes.clone(), rt.new_bool(true)]))))) {
		var_site_name = rt.get_superglobal('_POST').array_get(rt.new_string('sitename'))
	} else {
		var_site_name = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s Sites')]),
			rt.call_function('get_option', [rt.new_string('blogname')]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('email'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('invalid_email'), var_error_codes.clone(), rt.new_bool(true)]))))) {
		var_admin_email = rt.get_superglobal('_POST').array_get(rt.new_string('email'))
	} else {
		var_admin_email = rt.call_function('get_option', [rt.new_string('admin_email')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Welcome to the Network installation process!'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Fill in the information below and you&#8217;ll be on your way to creating a network of WordPress sites. Configuration files will be created in the next step.'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_POST').array_isset(rt.new_string('subdomain_install')) {
		var_subdomain_install =
			rt.new_bool((rt.get_superglobal('_POST').array_get(rt.new_string('subdomain_install'))).to_bool())
	} else if rt.is_true(rt.call_function('apache_mod_loaded', [
		rt.new_string('mod_rewrite'),
	]))
	{
		var_subdomain_install = rt.new_bool(true)
	} else if !(allow_subdirectory_install()) {
		var_subdomain_install = rt.new_bool(true)
	} else {
		var_subdomain_install = rt.new_bool(false)
		var_got_mod_rewrite = rt.call_function('got_mod_rewrite', []rt.PhpVal{})
		var_message_class = ''
		var_message = rt.new_string('')
		if rt.is_true(var_got_mod_rewrite) {
			var_message_class = 'updated'
			var_message = rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ')
			var_message = rt.concat(var_message, rt.new_string('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please make sure the Apache %s module is installed as it will be used at the end of this installation.')]), rt.new_string('<code>mod_rewrite</code>')])).str() +
				'</p>'))
		} else if rt.is_true(var_is_apache) {
			var_message_class = 'error'
			var_message = rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ')
			var_message = rt.concat(var_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('It looks like the Apache %s module is not installed.')]), rt.new_string('<code>mod_rewrite</code>')])).str() +
				'</p>'))
		}
		if rt.is_true(var_got_mod_rewrite) || rt.is_true(var_is_apache) {
			var_message = rt.concat(var_message, rt.new_string('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If %1$s is disabled, ask your administrator to enable that module, or look at the <a href="%2$s">Apache documentation</a> or <a href="%3$s">elsewhere</a> for help setting it up.')]), rt.new_string('<code>mod_rewrite</code>'), rt.new_string('https://httpd.apache.org/docs/mod/mod_rewrite.html'), rt.new_string('https://www.google.com/search?q=apache+mod_rewrite')])).str() +
				'</p>'))
			rt.call_function('wp_admin_notice', [var_message.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_message_class },
						rt.ArrayItem{ key: none, val: 'inline' },
					]) },
					rt.ArrayItem{ key: 'paragraph_wrap', val: false },
				])])
		}
	}
	if allow_subdomain_install() && allow_subdirectory_install() {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Addresses of Sites in your Network'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Please choose whether you would like sites in your WordPress network to use sub-domains or sub-directories.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('You cannot change this later.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('You will need a wildcard DNS record if you are going to use the virtual host (sub-domain) functionality.'),
		])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_subdomain_install.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sub-domains')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('_x', [
				rt.new_string('like <code>site1.%1$s</code> and <code>site2.%1$s</code>'),
				rt.new_string('subdomain examples'),
			]),
			var_hostname.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_bool(!(rt.is_true(var_subdomain_install)))])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sub-directories')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('_x', [
				rt.new_string('like <code>%1$s/site1</code> and <code>%1$s/site2</code>'),
				rt.new_string('subdirectory examples'),
			]),
			var_hostname.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_CONTENT_DIR'), (rt.get_constant('ABSPATH')).str() + 'wp-content'))))
		&& allow_subdirectory_install() || !(allow_subdomain_install()) {
		var_subdirectory_warning_message = rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ')
		var_subdirectory_warning_message = rt.concat(var_subdirectory_warning_message, rt.call_function('__', [
			rt.new_string('Subdirectory networks may not be fully compatible with custom wp-content directories.'),
		]))
		rt.call_function('wp_admin_notice', [var_subdirectory_warning_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
					rt.ArrayItem{ key: none, val: 'inline' },
				]) },
			])])
	}
	var_is_www = rt.call_function('str_starts_with', [var_hostname.clone(),
		rt.new_string('www.')])
	if rt.is_true(var_is_www) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Server Address')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('You should consider changing your site domain to %1$s before enabling the network feature. It will still be possible to visit your site using the %3$s prefix with an address like %2$s but any links will not have the %3$s prefix.'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('substr', [var_hostname.clone(), rt.new_int(4)])).str() +
				'</code>'),
			rt.new_string('<code>' + var_hostname.str() + '</code>'),
			rt.new_string('<code>www</code>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Server Address')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('The internet address of your network will be %s.'),
			]),
			rt.new_string('<code>' + var_hostname.str() + '</code>'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Network Details')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('localhost'), var_hostname)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Sub-directory Installation')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Because you are using %1$s, the sites in your WordPress network must use sub-directories. Consider using %2$s if you wish to use sub-domains.'),
			]),
			rt.new_string('<code>localhost</code>'),
			rt.new_string('<code>localhost.localdomain</code>'),
		])
		if !(allow_subdirectory_install()) {
			print(' <strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + ' ' +
				(rt.call_function('__', [rt.new_string('The main site in a sub-directory installation will need to use a modified permalink structure, potentially breaking existing links.')])).str() +
				'</strong>')
		}
		// unsupported statement: Stmt_InlineHTML
	} else if !(allow_subdomain_install()) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Sub-directory Installation')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Because your installation is in a directory, the sites in your WordPress network must use sub-directories.'),
		])
		if !(allow_subdirectory_install()) {
			print(' <strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + ' ' +
				(rt.call_function('__', [rt.new_string('The main site in a sub-directory installation will need to use a modified permalink structure, potentially breaking existing links.')])).str() +
				'</strong>')
		}
		// unsupported statement: Stmt_InlineHTML
	} else if !(allow_subdirectory_install()) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Sub-domain Installation')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Because your installation is not new, the sites in your WordPress network must use sub-domains.'),
		])
		print(' <strong>' +
			(rt.call_function('__', [rt.new_string('The main site in a sub-directory installation will need to use a modified permalink structure, potentially breaking existing links.')])).str() +
			'</strong>')
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_www)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Server Address')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('The internet address of your network will be %s.'),
			]),
			rt.new_string('<code>' + var_hostname.str() + '</code>'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Network Title')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_site_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('What would you like to call your network?')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Network Admin Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_admin_email.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Your email address.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Install')]),
		rt.new_string('primary'),
		rt.new_string('submit'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn network_step2(errors bool) {
	mut var_errors := errors
	mut var_wpdb := rt.new_null()
	mut var_is_nginx := rt.new_null()
	mut var_hostname := false
	mut var_slashed_home := rt.new_null()
	mut var_base := rt.new_null()
	mut var_document_root_fix := rt.new_null()
	mut var_abspath_fix := rt.new_null()
	mut var_home_path := rt.new_null()
	mut var_wp_siteurl_subdir := rt.new_null()
	mut var_rewrite_base := ''
	mut var_location_of_wp_config := rt.new_null()
	mut var_subdomain_install := rt.new_null()
	mut var_subdir_match := ''
	mut var_subdir_replacement_01 := ''
	mut var_subdir_replacement_12 := ''
	mut var_notice_message := rt.new_null()
	mut var_notice_args := map[string]rt.PhpVal{}
	mut var_keys_salts := rt.new_null()
	mut var_v := rt.new_null()
	mut var_c := rt.new_null()
	mut var_keys_salts_str := ''
	mut var_from_api := rt.new_null()
	mut var_num_keys_salts := i64(0)
	mut var_iis_subdir_match := rt.new_null()
	mut var_iis_rewrite_base := rt.new_null()
	mut var_iis_subdir_replacement := ''
	mut var_web_config_file := ''
	mut var_ms_files_rewriting := ''
	mut var_htaccess_file := ''
	var_hostname = get_clean_basedomain()
	var_slashed_home = rt.call_function('trailingslashit', [
		rt.call_function('get_option', [rt.new_string('home')]),
	])
	var_base = rt.call_function('parse_url', [var_slashed_home.clone(),
		rt.get_constant('PHP_URL_PATH')])
	var_document_root_fix = rt.call_function('str_replace', [
		rt.new_string('\\'), rt.new_string('/'),
		rt.call_function('realpath', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('DOCUMENT_ROOT')),
		])])
	var_abspath_fix = rt.call_function('str_replace', [rt.new_string('\\'),
		rt.new_string('/'), rt.get_constant('ABSPATH')])
	var_home_path = if rt.is_true(rt.call_function('str_starts_with', [
		var_abspath_fix.clone(), var_document_root_fix.clone()]))
	{
		var_document_root_fix.str() + var_base.str()
	} else {
		rt.call_function('get_home_path', []rt.PhpVal{})
	}
	var_wp_siteurl_subdir = rt.call_function('preg_replace', [
		rt.new_string('#^' +
			(rt.call_function('preg_quote', [var_home_path.clone(), rt.new_string('#')])).str() +
			'#'),
		rt.new_string(''),
		var_abspath_fix.clone(),
	])
	var_rewrite_base = if !(!rt.is_true(var_wp_siteurl_subdir)) { rt.call_function('trailingslashit', [
			var_wp_siteurl_subdir.clone(),
		]).to_string().trim_left(' \t\n\r') } else { '' }
	var_location_of_wp_config = var_abspath_fix.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-config.php')])))))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config.php')])) {
		var_location_of_wp_config = rt.call_function('dirname', [
			var_abspath_fix.clone()])
	}
	var_location_of_wp_config = rt.call_function('trailingslashit', [
		var_location_of_wp_config.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(errors)])) {
		rt.call_function('wp_admin_notice', [
			rt.call_method(rt.new_bool(errors), 'get_error_message', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			]),
		])
	}
	if rt.is_true(rt.get_superglobal('_POST')) {
		if rt.is_true(rt.new_bool(allow_subdomain_install())) {
			var_subdomain_install = rt.new_bool(if allow_subdirectory_install() {
				!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('subdomain_install'))))
			} else {
				true
			})
		} else {
			var_subdomain_install = rt.new_bool(false)
		}
	} else {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_subdomain_install = rt.call_function('is_subdomain_install', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('The original configuration steps are shown here for reference.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			var_subdomain_install = rt.new_bool((rt.call_method(var_wpdb, 'get_var', [
				rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb,
					'sitemeta')),
					rt.new_string(" WHERE site_id = 1 AND meta_key = 'subdomain_install'")),
			])).to_bool())
			rt.call_function('wp_admin_notice', [
				rt.new_string('<strong>' +
					(rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ' +(rt.call_function('__', [rt.new_string('An existing WordPress network was detected.')])).str()),
				rt.create_array([
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) },
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Please complete the configuration steps. To create a new network, you will need to empty or remove the network database tables.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	var_subdir_match = if rt.is_true(var_subdomain_install) { '' } else { '([_0-9a-zA-Z-]+/)?' }
	var_subdir_replacement_01 = if rt.is_true(var_subdomain_install) { '' } else { '$1' }
	var_subdir_replacement_12 = if rt.is_true(var_subdomain_install) { '$1' } else { '$2' }
	if rt.is_true(rt.get_superglobal('_POST'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Enabling the Network')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Complete the following steps to enable the features for creating a network of sites.'),
		])
		// unsupported statement: Stmt_InlineHTML
		var_notice_message = rt.new_string('<strong>' +
			(rt.call_function('__', [rt.new_string('Caution:')])).str() + '</strong> ')
		var_notice_args = {
			'type':               rt.new_string('warning')
			'additional_classes': map[string]rt.PhpVal{}
		}
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string(var_home_path.str() + '.htaccess'),
		]))
		{
			var_notice_message = rt.concat(var_notice_message, rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You should back up your existing %1$s and %2$s files.'),
				]),
				rt.new_string('<code>wp-config.php</code>'),
				rt.new_string('<code>.htaccess</code>'),
			]))
		} else if rt.is_true(rt.call_function('file_exists', [
			rt.new_string(var_home_path.str() + 'web.config'),
		]))
		{
			var_notice_message = rt.concat(var_notice_message, rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You should back up your existing %1$s and %2$s files.'),
				]),
				rt.new_string('<code>wp-config.php</code>'),
				rt.new_string('<code>web.config</code>'),
			]))
		} else {
			var_notice_message = rt.concat(var_notice_message, rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You should back up your existing %s file.'),
				]),
				rt.new_string('<code>wp-config.php</code>'),
			]))
		}
		rt.call_function('wp_admin_notice', [var_notice_message.clone(),
			rt.create_array_from_native_map(var_notice_args)])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Add the following to your %1$s file in %2$s <strong>above</strong> the line reading %3$s:'),
		]),
		rt.new_string('<code>wp-config.php</code>'),
		rt.new_string('<code>' + var_location_of_wp_config.str() + '</code>'),
		rt.new_string('<code>/* ' +
			(rt.call_function('__', [rt.new_string('That&#8217;s all, stop editing! Happy publishing.')])).str() +
			' */</code>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Network configuration rules for %s')]),
		rt.new_string('<code>wp-config.php</code>'),
	])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_subdomain_install) { 'true' } else { 'false' })
	// unsupported statement: Stmt_InlineHTML
	print(if var_hostname { '1' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_base)
	// unsupported statement: Stmt_InlineHTML
	var_keys_salts = rt.create_array([rt.ArrayItem{ key: 'AUTH_KEY', val: '' },
		rt.ArrayItem{ key: 'SECURE_AUTH_KEY', val: '' }, rt.ArrayItem{ key: 'LOGGED_IN_KEY', val: '' },
		rt.ArrayItem{ key: 'NONCE_KEY', val: '' }, rt.ArrayItem{ key: 'AUTH_SALT', val: '' },
		rt.ArrayItem{ key: 'SECURE_AUTH_SALT', val: '' }, rt.ArrayItem{
			key: 'LOGGED_IN_SALT'
			val: ''
		}, rt.ArrayItem{ key: 'NONCE_SALT', val: '' }])
	mut iter_2 := var_keys_salts.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_v_shadow := item_2.val
		mut var_c_shadow := item_2.key
		if rt.is_true(rt.call_function('defined', [var_c_shadow.clone()])) {
			var_keys_salts.array_unset(var_c_shadow)
		}
	}
	if !(!rt.is_true(var_keys_salts)) {
		var_keys_salts_str = ''
		var_from_api = rt.call_function('wp_remote_get', [
			rt.new_string('https://api.wordpress.org/secret-key/1.1/salt/'),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_from_api.clone()])) {
			mut iter_3 := var_keys_salts.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_v_shadow := item_3.val
				mut var_c_shadow := item_3.key
				var_keys_salts_str = var_keys_salts_str + "\ndefine( '${var_c.to_string()}', '" +
					(rt.call_function('wp_generate_password', [rt.new_int(64), rt.new_bool(true), rt.new_bool(true)])).str() +
					"' );"
			}
		} else {
			var_from_api = rt.call_function('explode', [rt.new_string('\n'),
				rt.call_function('wp_remote_retrieve_body', [
					var_from_api.clone()])])
			mut iter_4 := var_keys_salts.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_v_shadow := item_4.val
				mut var_c_shadow := item_4.key
				var_keys_salts_str = var_keys_salts_str + "\ndefine( '${var_c.to_string()}', '" +
					(rt.call_function('substr', [rt.call_function('array_shift', [var_from_api.clone()]), rt.new_int(28), rt.new_int(64)])).str() +
					"' );"
			}
		}
		var_num_keys_salts = var_keys_salts.clone().array_count()
		// unsupported statement: Stmt_InlineHTML
		if 1 == var_num_keys_salts {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('This unique authentication key is also missing from your %s file.'),
				]),
				rt.new_string('<code>wp-config.php</code>'),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('These unique authentication keys are also missing from your %s file.'),
				]),
				rt.new_string('<code>wp-config.php</code>'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('To make your installation more secure, you should also add:'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Network configuration authentication keys'),
		])
		// unsupported statement: Stmt_InlineHTML
		print(var_num_keys_salts.str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea',
			[rt.new_string(var_keys_salts_str.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('iis7_supports_permalinks', []rt.PhpVal{})) {
		var_iis_subdir_match = rt.new_string((var_base.clone().to_string().trim_left(' \t\n\r') +
			var_subdir_match).str())
		var_iis_rewrite_base = rt.new_string((var_base.clone().to_string().trim_left(' \t\n\r') +
			var_rewrite_base).str())
		var_iis_subdir_replacement = if rt.is_true(var_subdomain_install) { '' } else { '{R:1}' }
		var_web_config_file = '<?xml version="1.0" encoding="UTF-8"?>\n<configuration>\n    <system.webServer>\n        <rewrite>\n            <rules>\n                <rule name="WordPress Rule 1" stopProcessing="true">\n                    <match url="^index\\.php$" ignoreCase="false" />\n                    <action type="None" />\n                </rule>'
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')])) {
			var_web_config_file = var_web_config_file +
				'\n                <rule name="WordPress Rule for Files" stopProcessing="true">\n                    <match url="^' +
				var_iis_subdir_match.str() +
				'files/(.+)" ignoreCase="false" />\n                    <action type="Rewrite" url="' +
				var_iis_rewrite_base.str() +
				(rt.get_constant('WPINC')).str() + '/ms-files.php?file={R:1}" appendQueryString="false" />\n                </rule>'
		}
		var_web_config_file = var_web_config_file +
			'\n                <rule name="WordPress Rule 2" stopProcessing="true">\n                    <match url="^' +
			var_iis_subdir_match.str() +
			'wp-admin$" ignoreCase="false" />\n                    <action type="Redirect" url="' +
			var_iis_subdir_replacement +
			'wp-admin/" redirectType="Permanent" />\n                </rule>\n                <rule name="WordPress Rule 3" stopProcessing="true">\n                    <match url="^" ignoreCase="false" />\n                    <conditions logicalGrouping="MatchAny">\n                        <add input="{REQUEST_FILENAME}" matchType="IsFile" ignoreCase="false" />\n                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" />\n                    </conditions>\n                    <action type="None" />\n                </rule>\n                <rule name="WordPress Rule 4" stopProcessing="true">\n                    <match url="^' +
			var_iis_subdir_match.str() +
			'(wp-(content|admin|includes).*)" ignoreCase="false" />\n                    <action type="Rewrite" url="' +
			var_iis_rewrite_base.str() +
			'{R:1}" />\n                </rule>\n                <rule name="WordPress Rule 5" stopProcessing="true">\n                    <match url="^' +
			var_iis_subdir_match.str() +
			'([_0-9a-zA-Z-]+/)?(.*\\.php)$" ignoreCase="false" />\n                    <action type="Rewrite" url="' +
			var_iis_rewrite_base.str() +
			'{R:2}" />\n                </rule>\n                <rule name="WordPress Rule 6" stopProcessing="true">\n                    <match url="." ignoreCase="false" />\n                    <action type="Rewrite" url="index.php" />\n                </rule>\n            </rules>\n        </rewrite>\n    </system.webServer>\n</configuration>\n'
		print('<li><p id="network-webconfig-rules-description">')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Add the following to your %1$s file in %2$s, <strong>replacing</strong> other WordPress rules:'),
			]),
			rt.new_string('<code>web.config</code>'),
			rt.new_string('<code>' + var_home_path.str() + '</code>'),
		])
		print('</p>')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_subdomain_install))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_CONTENT_DIR'), (rt.get_constant('ABSPATH')).str() + 'wp-content')))) {
			print('<p><strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() +
				' ' +
				(rt.call_function('__', [rt.new_string('Subdirectory networks may not be fully compatible with custom wp-content directories.')])).str() +
				'</strong></p>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Network configuration rules for %s')]),
			rt.new_string('<code>web.config</code>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea',
			[rt.new_string(var_web_config_file.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(var_is_nginx) {
		print('<li><p>')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('It seems your network is running with Nginx web server. <a href="%s">Learn more about further configuration</a>.'),
			]),
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/advanced-administration/server/web-server/nginx/'),
			]),
		])
		print('</p></li>')
	} else {
		var_ms_files_rewriting = ''
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')])) {
			var_ms_files_rewriting = '\n# uploaded files\nRewriteRule ^'
			var_ms_files_rewriting = var_ms_files_rewriting + var_subdir_match +
				'files/(.+) ${var_rewrite_base}' +
				(rt.get_constant('WPINC')).str() + '/ms-files.php?file=${var_subdir_replacement_12} [L]' + '\n'
		}
		var_htaccess_file = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('RewriteEngine On\nRewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]\nRewriteBase '),
			var_base), rt.new_string('\nRewriteRule ^index\\.php$ - [L]\n')),
			rt.new_string(var_ms_files_rewriting.str())),
			rt.new_string('\n# add a trailing slash to /wp-admin\nRewriteRule ^')),
			rt.new_string(var_subdir_match.str())), rt.new_string('wp-admin$ ')),
			rt.new_string(var_subdir_replacement_01.str())),
			rt.new_string('wp-admin/ [R=301,L]\n\nRewriteCond %{REQUEST_FILENAME} -f [OR]\nRewriteCond %{REQUEST_FILENAME} -d\nRewriteRule ^ - [L]\nRewriteRule ^')),
			rt.new_string(var_subdir_match.str())),
			rt.new_string('(wp-(content|admin|includes).*) ')),
			rt.new_string(var_rewrite_base.str())), rt.new_string(var_subdir_replacement_12.str())),
			rt.new_string(' [L]\nRewriteRule ^')), rt.new_string(var_subdir_match.str())),
			rt.new_string('(.*\\.php)$ ')), rt.new_string(var_rewrite_base.str())),
			rt.new_string(var_subdir_replacement_12.str())),
			rt.new_string(' [L]\nRewriteRule . index.php [L]\n'))
		print('<li><p id="network-htaccess-rules-description">')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Add the following to your %1$s file in %2$s, <strong>replacing</strong> other WordPress rules:'),
			]),
			rt.new_string('<code>.htaccess</code>'),
			rt.new_string('<code>' + var_home_path.str() + '</code>'),
		])
		print('</p>')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_subdomain_install))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_CONTENT_DIR'), (rt.get_constant('ABSPATH')).str() + 'wp-content')))) {
			print('<p><strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() +
				' ' +
				(rt.call_function('__', [rt.new_string('Subdirectory networks may not be fully compatible with custom wp-content directories.')])).str() +
				'</strong></p>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Network configuration rules for %s')]),
			rt.new_string('<code>.htaccess</code>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.add(rt.call_function('substr_count', [
			rt.new_string(var_htaccess_file.str()).clone(), rt.new_string('\n')]), rt.new_int(1)))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea',
			[rt.new_string(var_htaccess_file.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Once you complete these steps, your network is enabled and configured. You will have to log in again.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wp_login_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Log In')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

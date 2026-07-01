import rt

fn network_domain_check() bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'), rt.call_method(var_wpdb, 'esc_like', [rt.get_property(var_wpdb, 'site')])])])) {
		return (rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT domain FROM '), rt.get_property(var_wpdb, 'site')), rt.new_string(' ORDER BY id ASC LIMIT 1'))])).to_bool()
	}
	return false
}

fn allow_subdomain_install() bool {
	mut var_home := rt.call_function('get_option', [rt.new_string('home')])
	mut var_domain := rt.call_function('parse_url', [var_home.dup(), rt.get_constant('PHP_URL_HOST')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('parse_url', [var_home.dup(), rt.get_constant('PHP_URL_PATH')])) || rt.is_true(rt.identical(rt.new_string('localhost'), var_domain)))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('|^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+$|'), var_domain.dup()])))) {
		return false
	}
	return true
}

fn allow_subdirectory_install() bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('allow_subdirectory_install'), rt.new_bool(false)])) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ALLOW_SUBDIRECTORY_INSTALL')])) && rt.is_true(rt.get_constant('ALLOW_SUBDIRECTORY_INSTALL')))) {
		return true
	}
	mut var_post := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_date < DATE_SUB(NOW(), INTERVAL 1 MONTH) AND post_status = \'publish\''))])
	if !rt.is_true(var_post) {
		return true
	}
	return false
}

fn get_clean_basedomain() bool {
	mut var_existing_domain := network_domain_check()
	if var_existing_domain {
		return var_existing_domain
	}
	mut var_domain := rt.call_function('preg_replace', [rt.new_string('|https?://|'), rt.new_string(''), rt.call_function('get_option', [rt.new_string('siteurl')])])
	mut var_slash := rt.call_function('strpos', [var_domain.dup(), rt.new_string('/')])
	if rt.is_true(var_slash) {
		var_domain = rt.call_function('substr', [var_domain.dup(), rt.new_int(0), var_slash.dup()])
	}
	return (var_domain).to_bool()
}

fn network_step1(errors bool) {
	mut var_is_apache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('defined', [rt.new_string('DO_NOT_UPGRADE_GLOBAL_TABLES')])) {
		mut var_cannot_define_constant_message := rt.new_string('<strong>' + (rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ')
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('wp_admin_notice', [var_cannot_define_constant_message.dup(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
		print('</div>')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		// unsupported expression: Expr_Exit
	}
	mut var_active_plugins := rt.call_function('get_option', [rt.new_string('active_plugins')])
	if !(!rt.is_true(var_active_plugins)) {
		rt.call_function('wp_admin_notice', ['<strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please <a href="%s">deactivate your plugins</a> before enabling the Network feature.')]), rt.call_function('admin_url', [rt.new_string('plugins.php?plugin_status=active')])])).str(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }])])
		print('<p>' + (rt.call_function('__', [rt.new_string('Once the network is created, you may reactivate your plugins.')])).str() + '</p>')
		print('</div>')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
		// unsupported expression: Expr_Exit
	}
	mut var_hostname := rt.call_function('preg_replace', [rt.new_string('/(?::80|:443)$/'), rt.new_string(''), rt.new_bool(get_clean_basedomain())])
	print('<form method="post">')
	rt.call_function('wp_nonce_field', [rt.new_string('install-network-1')])
	mut var_error_codes := rt.new_array()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(errors)])) {
		mut var_network_created_error_message := rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('Error:')])).str() + '</strong> ' + (rt.call_function('__', [rt.new_string('The network could not be created.')])).str() + '</p>')
		{
			mut iter_1 := rt.call_method(rt.new_bool(errors), 'get_error_messages', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_error := item_1.val
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		rt.call_function('wp_admin_notice', [var_network_created_error_message.dup(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		var_error_codes = rt.call_method(rt.new_bool(errors), 'get_error_codes', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('sitename'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('empty_sitename'), var_error_codes.dup(), rt.new_bool(true)]))))))) {
		mut var_site_name := rt.get_superglobal('_POST').array_get('sitename')
	} else {
		var_site_name = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s Sites')]), rt.call_function('get_option', [rt.new_string('blogname')])])
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('email'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('invalid_email'), var_error_codes.dup(), rt.new_bool(true)]))))))) {
		mut var_admin_email := rt.get_superglobal('_POST').array_get('email')
	} else {
		var_admin_email = rt.call_function('get_option', [rt.new_string('admin_email')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Welcome to the Network installation process!')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Fill in the information below and you&#8217;ll be on your way to creating a network of WordPress sites. Configuration files will be created in the next step.')])
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_POST').array_isset(rt.new_string('subdomain_install')) {
		mut var_subdomain_install := // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.call_function('apache_mod_loaded', [rt.new_string('mod_rewrite')])) {
		var_subdomain_install = rt.new_bool(rt.new_bool(true))
	} else if !(allow_subdirectory_install()) {
		var_subdomain_install = rt.new_bool(rt.new_bool(true))
	} else {
		var_subdomain_install = rt.new_bool(rt.new_bool(false))
		mut var_got_mod_rewrite := rt.call_function('got_mod_rewrite', []rt.PhpVal{})
		mut var_message_class := ''
		mut var_message := rt.new_string(rt.new_string(''))
		if rt.is_true(var_got_mod_rewrite) {
			var_message_class = 'updated'
			var_message = rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ')
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(var_is_apache) {
			var_message_class = 'error'
			var_message = rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ')
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_got_mod_rewrite) || rt.is_true(var_is_apache))) {
			// unsupported expression: Expr_AssignOp_Concat
			rt.call_function('wp_admin_notice', [var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: var_message_class }, rt.ArrayItem{ key: none, val: 'inline' }]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
	}
	if rt.is_true(rt.new_bool(allow_subdomain_install() && allow_subdirectory_install())) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Addresses of Sites in your Network')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Please choose whether you would like sites in your WordPress network to use sub-domains or sub-directories.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('You cannot change this later.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('You will need a wildcard DNS record if you are going to use the virtual host (sub-domain) functionality.')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_subdomain_install.dup()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sub-domains')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('_x', [rt.new_string('like <code>site1.%1$s</code> and <code>site2.%1$s</code>'), rt.new_string('subdomain examples')]), var_hostname.dup()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_bool(!(rt.is_true(var_subdomain_install)))])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sub-directories')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('_x', [rt.new_string('like <code>%1$s/site1</code> and <code>%1$s/site2</code>'), rt.new_string('subdirectory examples')]), var_hostname.dup()])
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(allow_subdirectory_install() || !(allow_subdomain_install()))))) {
		mut var_subdirectory_warning_message := rt.new_string('<strong>' + (rt.call_function('__', [rt.new_string('Warning:')])).str() + '</strong> ')
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('wp_admin_notice', [var_subdirectory_warning_message.dup(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }])])
	}
	mut var_is_www := rt.call_function('str_starts_with', [var_hostname.dup(), rt.new_string('www.')])
	if rt.is_true(var_is_www) {
		// unsupported statement: Stmt_InlineHTML
		
	}
	// unsupported statement: Stmt_InlineHTML
}



pub fn init_wp_admin_includes_network_php() {
}

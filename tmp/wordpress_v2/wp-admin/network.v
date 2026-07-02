import rt

const global_const_wp_installing_network = true

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('setup_network'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage options for this site.'),
			]),
		])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
			rt.call_function('wp_redirect', [
				rt.call_function('network_admin_url', [rt.new_string('setup.php')]),
			])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('MULTISITE'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('The Network creation panel is not for WordPress MU networks.'),
				]),
			])
		}
	}
	rt.include_file(@DIR + '/includes/network.php', '4')
	mut iter_1 := rt.call_method(var_wpdb, 'tables', [rt.new_string('ms_global')]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prefixed_table := item_1.val
		mut var_table := item_1.key
		rt.set_property(var_wpdb, '{"nodeType":"Expr_Variable","line":37,"name":"table"}',
			var_prefixed_table.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('network_domain_check', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_ALLOW_MULTISITE')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_ALLOW_MULTISITE'))))) {
		rt.call_function('wp_die', [
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('You must define the %1$s constant as true in your %2$s file to allow creation of a Network.'),
				]),
				rt.new_string('<code>WP_ALLOW_MULTISITE</code>'),
				rt.new_string('<code>wp-config.php</code>'),
			]),
		])
	}
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		mut var_title := rt.call_function('__', [rt.new_string('Network Setup')])
		mut var_parent_file := 'settings.php'
	} else {
		var_title = rt.call_function('__', [
			rt.new_string('Create a Network of WordPress Sites'),
		])
		var_parent_file = 'tools.php'
	}
	mut var_network_help := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('This screen allows you to configure a network as having subdomains (<code>site1.example.com</code>) or subdirectories (<code>example.com/site1</code>). Subdomains require wildcard subdomains to be enabled in Apache and DNS records, if your host allows it.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Choose subdomains or subdirectories; this can only be switched afterwards by reconfiguring your installation. Fill out the network details, and click Install. If this does not work, you may have to add a wildcard DNS record (for subdomains) or change to another setting in Permalinks (for subdirectories).')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('The next screen for Network Setup will give you individually-generated lines of code to add to your wp-config.php and .htaccess files. Make sure the settings of your FTP client make files starting with a dot visible, so that you can find .htaccess; you may have to create this file if it really is not there. Make backup copies of those two files.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Add the designated lines of code to wp-config.php (just before <code>/*...stop editing...*/</code>) and <code>.htaccess</code> (replacing the existing WordPress rules).')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('Once you add this code and refresh your browser, multisite should be enabled. This screen, now in the Network Admin navigation menu, will keep an archive of the added code. You can toggle between Network Admin and Site Admin by clicking on the Network Admin or an individual site name under the My Sites dropdown in the Toolbar.')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('The choice of subdirectory sites is disabled if this setup is more than a month old because of permalink problems with &#8220;/blog/&#8221; from the main site. This disabling will be addressed in a future version.')])).str() +
		'</p>' + '<p><strong>' +
		(rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' +
		'<p>' +
		(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/create-network/">Documentation on Creating a Network</a>')])).str() +
		'</p>' + '<p>' +
		(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/tools-network-screen/">Documentation on the Network Screen</a>')])).str() +
		'</p>')
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'network' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Network'),
			]) }, rt.ArrayItem{ key: 'content', val: var_network_help }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://developer.wordpress.org/advanced-administration/multisite/create-network/">Documentation on Creating a Network</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/tools-network-screen/">Documentation on the Network Screen</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_superglobal('_POST')) {
		rt.call_function('check_admin_referer', [rt.new_string('install-network-1')])
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
		rt.call_function('install_network', []rt.PhpVal{})
		mut var_base := rt.call_function('parse_url', [
			rt.call_function('trailingslashit', [
				rt.call_function('get_option', [rt.new_string('home')]),
			]),
			rt.get_constant('PHP_URL_PATH'),
		])
		mut var_subdomain_install := if rt.is_true(rt.call_function('allow_subdomain_install',
			[]rt.PhpVal{}))
		{
			!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('subdomain_install'))))
		} else {
			false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('network_domain_check',
			[]rt.PhpVal{})))))
		{
			mut var_result := rt.call_function('populate_network', [
				rt.new_int(1), rt.call_function('get_clean_basedomain', []rt.PhpVal{}),
				rt.call_function('sanitize_email',
					[rt.get_superglobal('_POST').array_get(rt.new_string('email'))]),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('sitename'))]),
				var_base.clone(), rt.new_bool(var_subdomain_install).clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				if 1 == rt.call_method(var_result, 'get_error_codes', []rt.PhpVal{}).array_count()
					&& rt.is_true(rt.identical(rt.new_string('no_wildcard_dns'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}))) {
					rt.call_function('network_step2', [var_result.clone()])
				} else {
					rt.call_function('network_step1', [var_result.clone()])
				}
			} else {
				rt.call_function('network_step2', []rt.PhpVal{})
			}
		} else {
			rt.call_function('network_step2', []rt.PhpVal{})
		}
	} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('network_domain_check', []rt.PhpVal{})) {
		rt.call_function('network_step2', []rt.PhpVal{})
	} else {
		rt.call_function('network_step1', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}

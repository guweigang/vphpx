import rt

fn ms_upload_constants() {
	rt.call_function('add_filter', [rt.new_string('default_site_option_ms_files_rewriting'), rt.new_string('__return_true')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('UPLOADBLOGSDIR')]))))) {
		rt.call_function('define', [rt.new_string('UPLOADBLOGSDIR'), rt.new_string('wp-content/blogs.dir')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('UPLOADS')]))))) {
		mut var_site_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
		rt.call_function('define', [rt.new_string('UPLOADS'), (rt.get_constant('UPLOADBLOGSDIR')).str() + '/' + (var_site_id).str() + '/files/'])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('wp-content/blogs.dir'), rt.get_constant('UPLOADBLOGSDIR'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('BLOGUPLOADDIR')]))))))) {
			rt.call_function('define', [rt.new_string('BLOGUPLOADDIR'), (rt.get_constant('WP_CONTENT_DIR')).str() + '/blogs.dir/' + (var_site_id).str() + '/files/'])
		}
	}
}

fn ms_cookie_constants() {
	mut var_current_network := rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('COOKIEPATH')]))))) {
		rt.call_function('define', [rt.new_string('COOKIEPATH'), rt.get_property(var_current_network, 'path')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SITECOOKIEPATH')]))))) {
		rt.call_function('define', [rt.new_string('SITECOOKIEPATH'), rt.get_property(var_current_network, 'path')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ADMIN_COOKIE_PATH')]))))) {
		mut var_site_path := rt.call_function('parse_url', [rt.call_function('get_option', [rt.new_string('siteurl')]), rt.get_constant('PHP_URL_PATH')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_site_path.dup().is_string())) && rt.is_true(rt.new_string(var_site_path.dup().to_string().trim_space())))))) {
			rt.call_function('define', [rt.new_string('ADMIN_COOKIE_PATH'), rt.get_constant('SITECOOKIEPATH')])
		} else {
			rt.call_function('define', [rt.new_string('ADMIN_COOKIE_PATH'), (rt.get_constant('SITECOOKIEPATH')).str() + 'wp-admin'])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('COOKIE_DOMAIN')]))))) && rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})))) {
		if !(!rt.is_true(rt.get_property(var_current_network, 'cookie_domain'))) {
			rt.call_function('define', [rt.new_string('COOKIE_DOMAIN'), '.' + (rt.get_property(var_current_network, 'cookie_domain')).str()])
		} else {
			rt.call_function('define', [rt.new_string('COOKIE_DOMAIN'), '.' + (rt.get_property(var_current_network, 'domain')).str()])
		}
	}
}

fn ms_file_constants() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_SENDFILE')]))))) {
		rt.call_function('define', [rt.new_string('WPMU_SENDFILE'), rt.new_bool(false)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_ACCEL_REDIRECT')]))))) {
		rt.call_function('define', [rt.new_string('WPMU_ACCEL_REDIRECT'), rt.new_bool(false)])
	}
}

fn ms_subdomain_constants() {
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_subdomain_error))) {
		return rt.new_null()
	}
	if var_subdomain_error {
		mut var_vhost_deprecated := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The constant %1$s <strong>is deprecated</strong>. Use the boolean constant %2$s in %3$s to enable a subdomain configuration. Use %4$s to check whether a subdomain configuration is enabled.')]), rt.new_string('<code>VHOST</code>'), rt.new_string('<code>SUBDOMAIN_INSTALL</code>'), rt.new_string('<code>wp-config.php</code>'), rt.new_string('<code>is_subdomain_install()</code>')])
		if var_subdomain_error_warn {
			rt.call_function('wp_trigger_error', [rt.new_string(@FN), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Conflicting values for the constants %1$s and %2$s.</strong> The value of %2$s will be assumed to be your subdomain configuration setting.')]), rt.new_string('<code>VHOST</code>'), rt.new_string('<code>SUBDOMAIN_INSTALL</code>')])).str() + ' ' + (var_vhost_deprecated).str(), rt.get_constant('E_USER_WARNING')])
		} else {
			rt.call_function('_deprecated_argument', [rt.new_string('define()'), rt.new_string('3.0.0'), var_vhost_deprecated.dup()])
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('SUBDOMAIN_INSTALL')])) && rt.is_true(rt.call_function('defined', [rt.new_string('VHOST')])))) {
		mut var_subdomain_error := true
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_subdomain_error_warn := true
		}
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('SUBDOMAIN_INSTALL')])) {
		var_subdomain_error = false
		rt.call_function('define', [rt.new_string('VHOST'), if rt.is_true(rt.get_constant('SUBDOMAIN_INSTALL')) { rt.new_string('yes') } else { rt.new_string('no') }])
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('VHOST')])) {
		var_subdomain_error = true
		rt.call_function('define', [rt.new_string('SUBDOMAIN_INSTALL'), rt.identical(rt.new_string('yes'), rt.get_constant('VHOST'))])
	} else {
		var_subdomain_error = false
		rt.call_function('define', [rt.new_string('SUBDOMAIN_INSTALL'), rt.new_bool(false)])
		rt.call_function('define', [rt.new_string('VHOST'), rt.new_string('no')])
	}
}



pub fn init_wp_includes_ms_default_constants_php() {
}

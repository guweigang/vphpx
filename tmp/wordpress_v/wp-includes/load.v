import rt

fn wp_get_server_protocol() rt.PhpVal {
	mut var_protocol := if !(rt.get_superglobal('_SERVER').array_get('SERVER_PROTOCOL')).is_null() { rt.get_superglobal('_SERVER').array_get('SERVER_PROTOCOL') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_protocol.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'HTTP/1.1' }, rt.ArrayItem{ key: none, val: 'HTTP/2' }, rt.ArrayItem{ key: none, val: 'HTTP/2.0' }, rt.ArrayItem{ key: none, val: 'HTTP/3' }]), rt.new_bool(true)]))))) {
		var_protocol = rt.new_string(rt.new_string('HTTP/1.0'))
	}
	return var_protocol.dup()
}

fn wp_fix_server_vars() {
	// unsupported statement: Stmt_Global
	mut var_default_server_values := { 'SERVER_SOFTWARE': '', 'REQUEST_URI': '' }
	mut var__SERVER := rt.call_function('array_merge', [var_default_server_values.dup(), rt.get_superglobal('_SERVER').dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_SERVER').array_get('REQUEST_URI')) || rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^Microsoft-IIS\\//'), rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE')])))))) {
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_ORIGINAL_URL')) {
			rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.get_superglobal('_SERVER').array_get('HTTP_X_ORIGINAL_URL'))
		} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_REWRITE_URL')) {
			rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.get_superglobal('_SERVER').array_get('HTTP_X_REWRITE_URL'))
		} else {
			if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('PATH_INFO'))) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('ORIG_PATH_INFO')) {
				rt.get_superglobal('_SERVER').array_set('PATH_INFO', rt.get_superglobal('_SERVER').array_get('ORIG_PATH_INFO'))
			}
			if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PATH_INFO')) {
				if rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get('PATH_INFO'), rt.get_superglobal('_SERVER').array_get('SCRIPT_NAME'))) {
					rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.get_superglobal('_SERVER').array_get('PATH_INFO'))
				} else {
					rt.get_superglobal('_SERVER').array_set('REQUEST_URI', (rt.get_superglobal('_SERVER').array_get('SCRIPT_NAME')).str() + (rt.get_superglobal('_SERVER').array_get('PATH_INFO')).str())
				}
			}
			if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('QUERY_STRING'))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').array_isset(rt.new_string('SCRIPT_FILENAME')) && rt.is_true(rt.call_function('str_ends_with', [rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME'), rt.new_string('php.cgi')])))) {
		rt.get_superglobal('_SERVER').array_set('SCRIPT_FILENAME', rt.get_superglobal('_SERVER').array_get('PATH_TRANSLATED'))
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').array_isset(rt.new_string('SCRIPT_NAME')) && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SCRIPT_NAME'), rt.new_string('php.cgi')])))) {
		rt.get_superglobal('_SERVER').array_unset(rt.new_string('PATH_INFO'))
	}
	mut var_PHP_SELF := rt.get_superglobal('_SERVER').array_get('PHP_SELF')
	if !rt.is_true(var_PHP_SELF) {
		rt.get_superglobal('_SERVER').array_set('PHP_SELF', rt.call_function('preg_replace', [rt.new_string('/(\\?.*)?$/'), rt.new_string(''), rt.get_superglobal('_SERVER').array_get('REQUEST_URI')]))
		var_PHP_SELF = rt.get_superglobal('_SERVER').array_get('PHP_SELF')
	}
	wp_populate_basic_auth_from_authorization_header()
}

fn wp_populate_basic_auth_from_authorization_header() {
	mut var_user := rt.new_null()
	mut var_pass := rt.new_null()
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_AUTHORIZATION'))) && !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REDIRECT_HTTP_AUTHORIZATION'))) {
		return rt.new_null()
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER')) || rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
		return rt.new_null()
	}
	mut var_header := if !(rt.get_superglobal('_SERVER').array_get('HTTP_AUTHORIZATION')).is_null() { rt.get_superglobal('_SERVER').array_get('HTTP_AUTHORIZATION') } else { rt.get_superglobal('_SERVER').array_get('REDIRECT_HTTP_AUTHORIZATION') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('%^Basic [a-z\\d/+]*={0,2}$%i'), var_header.dup()]))))) {
		return rt.new_null()
	}
	mut var_token := rt.call_function('substr', [var_header.dup(), rt.new_int(6)])
	mut var_userpass := rt.call_function('base64_decode', [var_token.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_userpass.dup(), rt.new_string(':')]))))) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_List
	rt.get_superglobal('_SERVER').array_set('PHP_AUTH_USER', var_user.dup())
	rt.get_superglobal('_SERVER').array_set('PHP_AUTH_PW', var_pass.dup())
}

fn wp_check_php_mysql_versions() {
	mut var_required_php_version := rt.new_null()
	mut var_required_php_extensions := rt.new_null()
	mut var_wp_version := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_php_version := rt.get_constant('PHP_VERSION')
	if rt.is_true(rt.call_function('version_compare', [var_required_php_version.dup(), var_php_version.dup(), rt.new_string('>')])) {
		mut var_protocol := wp_get_server_protocol()
		rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('%s 500 Internal Server Error'), var_protocol.dup()]), rt.new_bool(true), rt.new_int(500)])
		rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
		rt.call_function('printf', [rt.new_string('Your server is running PHP version %1$s but WordPress %2$s requires at least %3$s.'), var_php_version.dup(), var_wp_version.dup(), var_required_php_version.dup()])
		// unsupported expression: Expr_Exit
	}
	mut var_missing_extensions := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(var_required_php_extensions).is_null() && rt.is_true(rt.new_bool(var_required_php_extensions.dup().is_array())))) {
		{
			mut iter_1 := var_required_php_extensions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_extension := item_1.val
				if rt.is_true(rt.call_function('extension_loaded', [var_extension.dup()])) {
					continue
				}
				var_missing_extensions << rt.call_function('sprintf', [rt.new_string('WordPress %1$s requires the <code>%2$s</code> PHP extension.'), var_wp_version.dup(), var_extension.dup()])
			}
		}
	}
	if var_missing_extensions.len > 0 {
		var_protocol = wp_get_server_protocol()
		rt.call_function('header', [rt.call_function('sprintf', [rt.new_string('%s 500 Internal Server Error'), var_protocol.dup()]), rt.new_bool(true), rt.new_int(500)])
		rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
		rt.echo_val(rt.call_function('implode', [rt.new_string('<br>'), var_missing_extensions.dup()]))
		// unsupported expression: Expr_Exit
	}
	mut var_wp_content_dir := if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')])) { rt.get_constant('WP_CONTENT_DIR') } else { (rt.get_constant('ABSPATH')).str() + 'wp-content' }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('mysqli_connect')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(var_wp_content_dir).str() + '/db.php']))))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php', '4')
		wp_load_translations_early()
		mut var_message := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Your PHP installation appears to be missing the MySQL extension which is required by WordPress.')])).str() + '</p>\n')
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		mut var_args := { 'exit': rt.new_bool(false), 'code': rt.new_string('mysql_not_found') }
		rt.call_function('wp_die', [var_message.dup(), rt.call_function('__', [rt.new_string('Requirements Not Met')]), var_args.dup()])
		// unsupported expression: Expr_Exit
	}
}

fn wp_get_environment_type() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))))) && rt.is_true(var_current_env))) {
		return var_current_env.dup()
	}
	mut var_wp_environments := ['local', 'development', 'staging', 'production']
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPES')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('_deprecated_argument')])))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s constant is no longer supported.')]), rt.new_string('WP_ENVIRONMENT_TYPES')])
		} else {
			var_message = rt.call_function('sprintf', [rt.new_string('The %s constant is no longer supported.'), rt.new_string('WP_ENVIRONMENT_TYPES')])
		}
		rt.call_function('_deprecated_argument', [rt.new_string('define()'), rt.new_string('5.5.1'), var_message.dup()])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getenv')])) {
		mut var_has_env := rt.call_function('getenv', [rt.new_string('WP_ENVIRONMENT_TYPE')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_current_env := var_has_env.dup()
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPE')])) && rt.is_true(rt.get_constant('WP_ENVIRONMENT_TYPE')))) {
		var_current_env = rt.get_constant('WP_ENVIRONMENT_TYPE')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_env.dup(), var_wp_environments.dup(), rt.new_bool(true)]))))) {
		var_current_env = rt.new_string(rt.new_string('production'))
	}
	return var_current_env.dup()
}

fn wp_get_development_mode() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_current_mode.dup()
	}
	mut var_development_mode := rt.get_constant('WP_DEVELOPMENT_MODE')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])) && var_GLOBALS.array_isset(rt.new_string('_wp_tests_development_mode')))) {
		var_development_mode = var_GLOBALS.array_get('_wp_tests_development_mode')
	}
	mut var_valid_modes := ['core', 'plugin', 'theme', 'all', '']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_development_mode.dup(), var_valid_modes.dup(), rt.new_bool(true)]))))) {
		var_development_mode = rt.new_string(rt.new_string(''))
	}
	mut var_current_mode := var_development_mode.dup()
	return var_current_mode.dup()
}

fn wp_is_development_mode(var_mode rt.PhpVal) bool {
	mut var_current_mode := wp_get_development_mode()
	if !rt.is_true(var_current_mode) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('all'), var_current_mode)) {
		return true
	}
	return (rt.identical(var_mode, var_current_mode)).to_bool()
}

fn wp_favicon_request() {
	if rt.is_true(rt.identical(rt.new_string('/favicon.ico'), rt.get_superglobal('_SERVER').array_get('REQUEST_URI'))) {
		rt.call_function('header', [rt.new_string('Content-Type: image/vnd.microsoft.icon')])
		// unsupported expression: Expr_Exit
	}
}

fn wp_maintenance() {
	if !(wp_is_maintenance_mode()) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/maintenance.php'])) {
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/maintenance.php', '4')
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php', '4')
	wp_load_translations_early()
	rt.call_function('header', [rt.new_string('Retry-After: 600')])
	rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Briefly unavailable for scheduled maintenance. Check back in a minute.')]), rt.call_function('__', [rt.new_string('Maintenance')]), rt.new_int(503)])
}

fn wp_is_maintenance_mode() bool {
	mut var_upgrading := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', []))))) || rt.is_true(wp_installing(rt.new_null())))) {
		return false
	}
	rt.include_file(().str() + , '3')
	if rt.is_true(rt.greater_equal(, )) {
		return 
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	return 
}



pub fn init_wp_includes_load_php() {
}

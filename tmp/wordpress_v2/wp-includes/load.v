import rt
import crypto.md5

fn wp_get_server_protocol() rt.PhpVal {
	mut var_protocol := rt.new_null()
	var_protocol = if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PROTOCOL'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PROTOCOL'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_protocol.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'HTTP/1.1' },
			rt.ArrayItem{ key: none, val: 'HTTP/2' }, rt.ArrayItem{ key: none, val: 'HTTP/2.0' },
			rt.ArrayItem{ key: none, val: 'HTTP/3' }]),
		rt.new_bool(true)])))))
	{
		var_protocol = rt.new_string('HTTP/1.0')
	}
	return var_protocol.clone()
}

fn wp_fix_server_vars() {
	mut var_default_server_values := map[string]rt.PhpVal{}
	mut var__SERVER := rt.new_null()
	mut var_PHP_SELF := rt.new_null()
	var_default_server_values = {
		'SERVER_SOFTWARE': ''
		'REQUEST_URI':     ''
	}
	var__SERVER = rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_default_server_values),
		rt.get_superglobal('_SERVER').clone(),
	])
	if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))|| (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('cgi-fcgi'), rt.get_constant('PHP_SAPI')))))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^Microsoft-IIS\\//'), rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE'))]))) {
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_ORIGINAL_URL')) {
			rt.get_superglobal('_SERVER').array_set('REQUEST_URI',
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_ORIGINAL_URL')))
		} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_REWRITE_URL')) {
			rt.get_superglobal('_SERVER').array_set('REQUEST_URI',
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_X_REWRITE_URL')))
		} else {
			if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('PATH_INFO')))
				&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('ORIG_PATH_INFO')) {
				rt.get_superglobal('_SERVER').array_set('PATH_INFO',
					rt.get_superglobal('_SERVER').array_get(rt.new_string('ORIG_PATH_INFO')))
			}
			if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PATH_INFO')) {
				if rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO')),
					rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_NAME'))))
				{
					rt.get_superglobal('_SERVER').array_set('REQUEST_URI',
						rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO')))
				} else {
					rt.get_superglobal('_SERVER').array_set('REQUEST_URI',
						(rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_NAME'))).str() +
						(rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO'))).str())
				}
			}
			if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING')))) {
				rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')) = rt.concat(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string(
					'?' +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING'))).str()))
			}
		}
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('SCRIPT_FILENAME'))
		&& rt.is_true(rt.call_function('str_ends_with', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME')), rt.new_string('php.cgi')])) {
		rt.get_superglobal('_SERVER').array_set('SCRIPT_FILENAME',
			rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_TRANSLATED')))
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('SCRIPT_NAME'))
		&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_NAME')), rt.new_string('php.cgi')])) {
		rt.get_superglobal('_SERVER').array_unset(rt.new_string('PATH_INFO'))
	}
	var_PHP_SELF = rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF'))
	if !rt.is_true(var_PHP_SELF) {
		rt.get_superglobal('_SERVER').array_set('PHP_SELF', rt.call_function('preg_replace', [
			rt.new_string('/(\\?.*)?$/'),
			rt.new_string(''),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
		var_PHP_SELF = rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF'))
	}
	wp_populate_basic_auth_from_authorization_header()
}

fn wp_populate_basic_auth_from_authorization_header() {
	mut var_user := rt.new_null()
	mut var_pass := rt.new_null()
	mut var_header := rt.new_null()
	mut var_token := rt.new_null()
	mut var_userpass := rt.new_null()
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_AUTHORIZATION')))
		&& !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('REDIRECT_HTTP_AUTHORIZATION'))) {
		return
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER'))
		|| rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
		return
	}
	var_header = if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_AUTHORIZATION'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_AUTHORIZATION'))
	} else {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REDIRECT_HTTP_AUTHORIZATION'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('%^Basic [a-z\\d/+]*={0,2}$%i'),
		var_header.clone(),
	])))))
	{
		return
	}
	var_token = rt.call_function('substr', [var_header.clone(),
		rt.new_int(6)])
	var_userpass = rt.call_function('base64_decode', [var_token.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_userpass.clone(), rt.new_string(':')])))))
	{
		return
	}
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'),
		var_userpass.clone(), rt.new_int(2)])
	var_user = list_tmp_1.array_get(0)
	var_pass = list_tmp_1.array_get(1)
	rt.get_superglobal('_SERVER').array_set('PHP_AUTH_USER', var_user.clone())
	rt.get_superglobal('_SERVER').array_set('PHP_AUTH_PW', var_pass.clone())
}

fn wp_check_php_mysql_versions() {
	mut var_required_php_version := rt.new_null()
	mut var_required_php_extensions := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_php_version := rt.new_null()
	mut var_protocol := rt.new_null()
	mut var_missing_extensions := []rt.PhpVal{}
	mut var_extension := rt.new_null()
	mut var_wp_content_dir := rt.new_null()
	mut var_message := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	var_php_version = rt.get_constant('PHP_VERSION')
	if rt.is_true(rt.call_function('version_compare', [var_required_php_version.clone(),
		var_php_version.clone(), rt.new_string('>')]))
	{
		var_protocol = wp_get_server_protocol()
		rt.call_function('header', [
			rt.call_function('sprintf', [rt.new_string('%s 500 Internal Server Error'),
				var_protocol.clone()]),
			rt.new_bool(true),
			rt.new_int(500),
		])
		rt.call_function('header', [
			rt.new_string('Content-Type: text/html; charset=utf-8'),
		])
		rt.call_function('printf', [
			rt.new_string('Your server is running PHP version %1$s but WordPress %2$s requires at least %3$s.'),
			var_php_version.clone(),
			var_wp_version.clone(),
			var_required_php_version.clone(),
		])
		fn () {
			print((rt.new_int(1)).str())
			exit(0)
		}()
	}
	var_missing_extensions = []rt.PhpVal{}
	if !var_required_php_extensions.is_null() && var_required_php_extensions.clone().is_array() {
		mut iter_1 := var_required_php_extensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_extension_shadow := item_1.val
			if rt.is_true(rt.call_function('extension_loaded', [
				var_extension_shadow.clone()]))
			{
				continue
			}
			var_missing_extensions << rt.call_function('sprintf', [
				rt.new_string('WordPress %1$s requires the <code>%2$s</code> PHP extension.'),
				var_wp_version.clone(),
				var_extension_shadow.clone(),
			])
		}
	}
	if var_missing_extensions.len > 0 {
		var_protocol = wp_get_server_protocol()
		rt.call_function('header', [
			rt.call_function('sprintf', [rt.new_string('%s 500 Internal Server Error'),
				var_protocol.clone()]),
			rt.new_bool(true),
			rt.new_int(500),
		])
		rt.call_function('header', [
			rt.new_string('Content-Type: text/html; charset=utf-8'),
		])
		rt.echo_val(rt.call_function('implode', [rt.new_string('<br>'),
			rt.create_array_from_list(var_missing_extensions)]))
		fn () {
			print((rt.new_int(1)).str())
			exit(0)
		}()
	}
	var_wp_content_dir = if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CONTENT_DIR'),
	]))
	{ rt.get_constant('WP_CONTENT_DIR') } else { (rt.get_constant('ABSPATH')).str() + 'wp-content' }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('mysqli_connect')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(var_wp_content_dir.str() + '/db.php')]))))) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php',
			'4')
		wp_load_translations_early()
		var_message = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Your PHP installation appears to be missing the MySQL extension which is required by WordPress.')])).str() +
			'</p>\n')
		var_message = rt.concat(var_message, rt.new_string('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please check that the %s PHP extension is installed and enabled.')]), rt.new_string('<code>mysqli</code>')])).str() +
			'</p>\n'))
		var_message = rt.concat(var_message, rt.new_string('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you are unsure what these terms mean you should probably contact your host. If you still need help you can always visit the <a href="%s">WordPress support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
			'</p>\n'))
		var_args = {
			'exit': rt.new_bool(false)
			'code': rt.new_string('mysql_not_found')
		}
		rt.call_function('wp_die', [var_message.clone(),
			rt.call_function('__', [rt.new_string('Requirements Not Met')]),
			rt.create_array_from_native_map(var_args)])
		fn () {
			print((rt.new_int(1)).str())
			exit(0)
		}()
	}
}

fn wp_get_environment_type() rt.PhpVal {
	mut var_wp_environments := []rt.PhpVal{}
	mut var_message := rt.new_null()
	mut var_has_env := rt.new_null()
	mut var_current_env := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])))))
		&& rt.is_true(var_current_env) {
		return var_current_env.clone()
	}
	var_wp_environments = ['local', 'development', 'staging', 'production']
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPES')]))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('_deprecated_argument')])) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('__')])) {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s constant is no longer supported.'),
				]),
				rt.new_string('WP_ENVIRONMENT_TYPES'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.new_string('The %s constant is no longer supported.'),
				rt.new_string('WP_ENVIRONMENT_TYPES'),
			])
		}
		rt.call_function('_deprecated_argument', [rt.new_string('define()'),
			rt.new_string('5.5.1'), var_message.clone()])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('getenv')])) {
		var_has_env = rt.call_function('getenv', [rt.new_string('WP_ENVIRONMENT_TYPE')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_has_env)))) {
			var_current_env = var_has_env.clone()
		}
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_ENVIRONMENT_TYPE')]))
		&& rt.is_true(rt.get_constant('WP_ENVIRONMENT_TYPE')) {
		var_current_env = rt.get_constant('WP_ENVIRONMENT_TYPE')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_current_env.clone(), rt.create_array_from_list(var_wp_environments),
		rt.new_bool(true)])))))
	{
		var_current_env = rt.new_string('production')
	}
	return var_current_env.clone()
}

fn wp_get_development_mode() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_development_mode := rt.new_null()
	mut var_valid_modes := []rt.PhpVal{}
	mut var_current_mode := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_current_mode)))) {
		return var_current_mode.clone()
	}
	var_development_mode = rt.get_constant('WP_DEVELOPMENT_MODE')
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')]))
		&& var_GLOBALS.array_isset(rt.new_string('_wp_tests_development_mode')) {
		var_development_mode = var_GLOBALS.array_get(rt.new_string('_wp_tests_development_mode'))
	}
	var_valid_modes = ['core', 'plugin', 'theme', 'all', '']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_development_mode.clone(), rt.create_array_from_list(var_valid_modes),
		rt.new_bool(true)])))))
	{
		var_development_mode = rt.new_string('')
	}
	var_current_mode = var_development_mode.clone()
	return var_current_mode.clone()
}

fn wp_is_development_mode(var_mode rt.PhpVal) bool {
	mut var_current_mode := rt.new_null()
	var_current_mode = wp_get_development_mode()
	if !rt.is_true(var_current_mode) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('all'), var_current_mode)) {
		return true
	}
	return (rt.identical(var_mode, var_current_mode)).to_bool()
}

fn wp_favicon_request() {
	if rt.is_true(rt.identical(rt.new_string('/favicon.ico'),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))))
	{
		rt.call_function('header', [
			rt.new_string('Content-Type: image/vnd.microsoft.icon'),
		])
		exit(0)
	}
}

fn wp_maintenance() {
	if !(wp_is_maintenance_mode()) {
		return
	}
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/maintenance.php'),
	]))
	{
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/maintenance.php', '4')
		exit(0)
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php',
		'4')
	wp_load_translations_early()
	rt.call_function('header', [rt.new_string('Retry-After: 600')])
	rt.call_function('wp_die', [
		rt.call_function('__', [
			rt.new_string('Briefly unavailable for scheduled maintenance. Check back in a minute.'),
		]),
		rt.call_function('__', [
			rt.new_string('Maintenance'),
		]),
		rt.new_int(503),
	])
}

fn wp_is_maintenance_mode() bool {
	mut var_upgrading := rt.new_null()
	mut var_key := rt.new_null()
	mut var_nonce := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + '.maintenance')])))))
		|| wp_installing() {
		return false
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + '.maintenance', '3')
	if rt.is_true(rt.greater_equal(rt.sub(rt.call_function('time', []rt.PhpVal{}), var_upgrading), rt.mul(rt.new_int(10),
		rt.get_constant('MINUTE_IN_SECONDS'))))
	{
		return false
	}
	if var_upgrading.clone().is_long()
		&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_scrape_key'))
		&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_scrape_nonce')) {
		var_key = rt.call_function('stripslashes', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_scrape_key')),
		])
		var_nonce = rt.call_function('stripslashes', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_scrape_nonce')),
		])
		if rt.is_true(rt.identical(rt.new_string(md5.hexhash(var_upgrading.clone().to_string())), var_key))
			&& rt.is_true(rt.identical(rt.new_int(var_nonce.to_i64()), var_upgrading)) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_maintenance_mode'),
		rt.new_bool(true),
		var_upgrading.clone(),
	])))))
	{
		return false
	}
	return true
}

fn timer_float() rt.PhpVal {
	return rt.sub(rt.call_function('microtime', [rt.new_bool(true)]),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_TIME_FLOAT')))
}

fn timer_start() bool {
	mut var_timestart := rt.new_null()
	var_timestart = rt.call_function('microtime', [rt.new_bool(true)])
	return true
}

fn timer_stop(display i64, precision i64) rt.PhpVal {
	mut var_display := display
	mut var_precision := precision
	mut var_timestart := rt.new_null()
	mut var_timeend := rt.new_null()
	mut var_timetotal := rt.new_null()
	mut var_r := rt.new_null()
	var_timeend = rt.call_function('microtime', [rt.new_bool(true)])
	var_timetotal = rt.sub(var_timeend, var_timestart)
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('number_format_i18n'),
	]))
	{
		var_r = rt.call_function('number_format_i18n', [var_timetotal.clone(),
			rt.new_int(precision)])
	} else {
		var_r = rt.call_function('number_format', [var_timetotal.clone(),
			rt.new_int(precision)])
	}
	if var_display != 0 {
		rt.echo_val(var_r)
	}
	return var_r.clone()
}

fn wp_debug_mode() {
	mut var_log_path := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('enable_wp_debug_mode_checks'),
		rt.new_bool(true),
	])))))
	{
		return
	}
	if rt.is_true(rt.get_constant('WP_DEBUG')) {
		rt.call_function('error_reporting', [rt.get_constant('E_ALL')])
		if rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')) {
			rt.call_function('ini_set', [rt.new_string('display_errors'),
				rt.new_int(1)])
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
			rt.get_constant('WP_DEBUG_DISPLAY')))))
		{
			rt.call_function('ini_set', [rt.new_string('display_errors'),
				rt.new_int(0)])
		}
		if rt.is_true(rt.call_function('in_array', [
			rt.new_string((rt.get_constant('WP_DEBUG_LOG')).str().to_lower()),
			rt.create_array([rt.ArrayItem{ key: none, val: 'true' },
				rt.ArrayItem{ key: none, val: '1' }]),
			rt.new_bool(true),
		]))
		{
			var_log_path = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/debug.log')
		} else if rt.is_true(rt.new_bool(rt.get_constant('WP_DEBUG_LOG').is_string())) {
			var_log_path = rt.get_constant('WP_DEBUG_LOG')
		} else {
			var_log_path = rt.new_bool(false)
		}
		if rt.is_true(var_log_path) {
			rt.call_function('ini_set', [rt.new_string('log_errors'),
				rt.new_int(1)])
			rt.call_function('ini_set', [rt.new_string('error_log'),
				var_log_path.clone()])
		}
	} else {
		rt.call_function('error_reporting', [
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('E_CORE_ERROR'),
				rt.get_constant('E_CORE_WARNING')), rt.get_constant('E_COMPILE_ERROR')),
				rt.get_constant('E_ERROR')), rt.get_constant('E_WARNING')),
				rt.get_constant('E_PARSE')), rt.get_constant('E_USER_ERROR')),
				rt.get_constant('E_USER_WARNING')), rt.get_constant('E_RECOVERABLE_ERROR')),
		])
	}
	if ((rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('MS_FILES_REQUEST')]))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING')]))
		&& rt.is_true(rt.get_constant('WP_INSTALLING'))))
		|| rt.is_true(wp_doing_ajax())) || wp_is_json_request() {
		rt.call_function('ini_set', [rt.new_string('display_errors'),
			rt.new_int(0)])
	}
}

fn wp_set_lang_dir() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_LANG_DIR'),
	])))))
	{
		if (rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/languages')]))
			&& rt.is_true(rt.call_function('is_dir', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/languages')])))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/languages')]))))) {
			rt.call_function('define', [rt.new_string('WP_LANG_DIR'),
				rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/languages')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
				rt.new_string('LANGDIR'),
			])))))
			{
				rt.call_function('define', [rt.new_string('LANGDIR'),
					rt.new_string('wp-content/languages')])
			}
		} else {
			rt.call_function('define', [rt.new_string('WP_LANG_DIR'),
				rt.new_string(
					(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/languages')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
				rt.new_string('LANGDIR'),
			])))))
			{
				rt.call_function('define', [rt.new_string('LANGDIR'),
					rt.new_string((rt.get_constant('WPINC')).str() + '/languages')])
			}
		}
	}
}

fn require_wp_db() {
	mut var_dbuser := rt.new_null()
	mut var_dbpassword := rt.new_null()
	mut var_dbname := rt.new_null()
	mut var_dbhost := rt.new_null()
	mut var_wpdb := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wpdb.php',
		'4')
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php'),
	]))
	{
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php', '4')
	}
	if !var_wpdb.is_null() {
		return
	}
	var_dbuser = if rt.is_true(rt.call_function('defined', [rt.new_string('DB_USER')])) {
		rt.get_constant('DB_USER')
	} else {
		rt.new_string('')
	}
	var_dbpassword = if rt.is_true(rt.call_function('defined', [
		rt.new_string('DB_PASSWORD'),
	]))
	{ rt.get_constant('DB_PASSWORD') } else { rt.new_string('') }
	var_dbname = if rt.is_true(rt.call_function('defined', [rt.new_string('DB_NAME')])) {
		rt.get_constant('DB_NAME')
	} else {
		rt.new_string('')
	}
	var_dbhost = if rt.is_true(rt.call_function('defined', [rt.new_string('DB_HOST')])) {
		rt.get_constant('DB_HOST')
	} else {
		rt.new_string('')
	}
	var_wpdb = create_wpdb(var_dbuser.clone(), var_dbpassword.clone(), var_dbname.clone(),
		var_dbhost.clone())
}

fn wp_set_wpdb_vars() {
	mut var_wpdb := rt.new_null()
	mut var_table_prefix := rt.new_null()
	mut var_prefix := rt.new_null()
	if !(!rt.is_true(rt.get_property(var_wpdb, 'error'))) {
		rt.call_function('dead_db', []rt.PhpVal{})
	}
	rt.set_property(var_wpdb, 'field_types', rt.create_array([
		rt.ArrayItem{ key: 'post_author', val: '%d' },
		rt.ArrayItem{ key: 'post_parent', val: '%d' },
		rt.ArrayItem{ key: 'menu_order', val: '%d' },
		rt.ArrayItem{ key: 'term_id', val: '%d' },
		rt.ArrayItem{ key: 'term_group', val: '%d' },
		rt.ArrayItem{ key: 'term_taxonomy_id', val: '%d' },
		rt.ArrayItem{ key: 'parent', val: '%d' },
		rt.ArrayItem{ key: 'count', val: '%d' },
		rt.ArrayItem{ key: 'object_id', val: '%d' },
		rt.ArrayItem{ key: 'term_order', val: '%d' },
		rt.ArrayItem{ key: 'ID', val: '%d' },
		rt.ArrayItem{ key: 'comment_ID', val: '%d' },
		rt.ArrayItem{ key: 'comment_post_ID', val: '%d' },
		rt.ArrayItem{ key: 'comment_parent', val: '%d' },
		rt.ArrayItem{ key: 'user_id', val: '%d' },
		rt.ArrayItem{ key: 'link_id', val: '%d' },
		rt.ArrayItem{ key: 'link_owner', val: '%d' },
		rt.ArrayItem{ key: 'link_rating', val: '%d' },
		rt.ArrayItem{ key: 'option_id', val: '%d' },
		rt.ArrayItem{ key: 'blog_id', val: '%d' },
		rt.ArrayItem{ key: 'meta_id', val: '%d' },
		rt.ArrayItem{ key: 'post_id', val: '%d' },
		rt.ArrayItem{ key: 'user_status', val: '%d' },
		rt.ArrayItem{ key: 'umeta_id', val: '%d' },
		rt.ArrayItem{ key: 'comment_karma', val: '%d' },
		rt.ArrayItem{ key: 'comment_count', val: '%d' },
		rt.ArrayItem{ key: 'active', val: '%d' },
		rt.ArrayItem{ key: 'cat_id', val: '%d' },
		rt.ArrayItem{ key: 'deleted', val: '%d' },
		rt.ArrayItem{ key: 'lang_id', val: '%d' },
		rt.ArrayItem{ key: 'mature', val: '%d' },
		rt.ArrayItem{ key: 'public', val: '%d' },
		rt.ArrayItem{ key: 'site_id', val: '%d' },
		rt.ArrayItem{ key: 'spam', val: '%d' },
	]))
	var_prefix = var_wpdb.set_prefix(var_table_prefix.clone())
	if rt.is_true(is_wp_error(var_prefix.clone())) {
		wp_load_translations_early()
		rt.call_function('wp_die', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('<strong>Error:</strong> %1$s in %2$s can only contain numbers, letters, and underscores.'),
				]),
				rt.new_string('<code>$table_prefix</code>'),
				rt.new_string('<code>wp-config.php</code>'),
			]),
		])
	}
}

fn wp_using_ext_object_cache(var_using rt.PhpVal) rt.PhpVal {
	mut var_current_using := rt.new_null()
	mut var__wp_using_ext_object_cache := rt.new_null()
	var_current_using = var__wp_using_ext_object_cache.clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_using)))) {
		var__wp_using_ext_object_cache = var_using
	}
	return var_current_using.clone()
}

fn wp_start_object_cache() {
	mut var_wp_filter := rt.new_null()
	mut var_first_init := false
	if var_first_init
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_loading_object_cache_dropin'), rt.new_bool(true)])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_cache_init'),
		])))))
		{
			if rt.is_true(rt.call_function('file_exists', [
				rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/object-cache.php'),
			]))
			{
				rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/object-cache.php',
					'4')
				if rt.is_true(rt.call_function('function_exists', [
					rt.new_string('wp_cache_init'),
				]))
				{
					wp_using_ext_object_cache(rt.new_bool(true))
				}
				if rt.is_true(var_wp_filter) {
					mut iife_temp_0 := Class_WP_Hook{}
					mut iife_result_0 :=
						iife_temp_0.build_preinitialized_hooks(var_wp_filter.clone())
					var_wp_filter = iife_result_0
				}
			}
		} else if rt.is_true(rt.new_bool(!(rt.is_true(wp_using_ext_object_cache(rt.new_null())))))
			&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/object-cache.php')])) {
			wp_using_ext_object_cache(rt.new_bool(true))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_using_ext_object_cache(rt.new_null()))))) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/cache.php',
			'4')
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/cache-compat.php',
		'4')
	if !var_first_init
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_switch_to_blog')])) {
		rt.call_function('wp_cache_switch_to_blog', [get_current_blog_id()])
	} else if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_init'),
	]))
	{
		rt.call_function('wp_cache_init', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_add_global_groups'),
	]))
	{
		rt.call_function('wp_cache_add_global_groups', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'blog-details' },
				rt.ArrayItem{ key: none, val: 'blog-id-cache' },
				rt.ArrayItem{ key: none, val: 'blog-lookup' },
				rt.ArrayItem{ key: none, val: 'blog_meta' }, rt.ArrayItem{
					key: none
					val: 'global-posts'
				}, rt.ArrayItem{ key: none, val: 'image_editor' },
				rt.ArrayItem{ key: none, val: 'networks' }, rt.ArrayItem{
					key: none
					val: 'network-queries'
				}, rt.ArrayItem{ key: none, val: 'sites' }, rt.ArrayItem{
					key: none
					val: 'site-details'
				}, rt.ArrayItem{ key: none, val: 'site-options' },
				rt.ArrayItem{ key: none, val: 'site-queries' },
				rt.ArrayItem{ key: none, val: 'site-transient' },
				rt.ArrayItem{ key: none, val: 'theme_files' },
				rt.ArrayItem{ key: none, val: 'translation_files' },
				rt.ArrayItem{ key: none, val: 'rss' }, rt.ArrayItem{ key: none, val: 'users' },
				rt.ArrayItem{ key: none, val: 'user-queries' },
				rt.ArrayItem{ key: none, val: 'user_meta' }, rt.ArrayItem{
					key: none
					val: 'useremail'
				}, rt.ArrayItem{ key: none, val: 'userlogins' },
				rt.ArrayItem{ key: none, val: 'userslugs' }]),
		])
		rt.call_function('wp_cache_add_non_persistent_groups', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'counts' },
				rt.ArrayItem{ key: none, val: 'plugins' }, rt.ArrayItem{
					key: none
					val: 'theme_json'
				}]),
		])
	}
	var_first_init = false
}

fn wp_not_installed() {
	mut var_link := rt.new_null()
	if rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{})) || wp_installing() {
		return
	}
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(is_multisite())) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('The site you have requested is not installed properly. Please contact the system administrator.'),
			]),
		])
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/kses.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pluggable.php',
		'3')
	var_link = rt.new_string((rt.call_function('wp_guess_url', []rt.PhpVal{})).str() +
		'/wp-admin/install.php')
	rt.call_function('wp_redirect', [var_link.clone()])
	exit(0)
}

fn wp_get_mu_plugins() rt.PhpVal {
	mut var_mu_plugins := []rt.PhpVal{}
	mut var_dh := rt.new_null()
	mut var_plugin := rt.new_null()
	var_mu_plugins = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
		rt.get_constant('WPMU_PLUGIN_DIR'),
	])))))
	{
		return var_mu_plugins.clone()
	}
	var_dh = rt.call_function('opendir', [rt.get_constant('WPMU_PLUGIN_DIR')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_dh)))) {
		return var_mu_plugins.clone()
	}
	var_plugin = rt.call_function('readdir', [var_dh.clone()])
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_plugin, rt.new_bool(false))))) {
		if rt.is_true(rt.call_function('str_ends_with', [var_plugin.clone(),
			rt.new_string('.php')]))
		{
			var_mu_plugins << (rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/' + var_plugin.str()
		}
	}
	rt.call_function('closedir', [var_dh.clone()])
	rt.call_function('sort', [rt.create_array_from_list(var_mu_plugins)])
	return var_mu_plugins.clone()
}

fn wp_get_active_and_valid_plugins() rt.PhpVal {
	mut var_plugins := rt.new_null()
	mut var_active_plugins := rt.new_null()
	mut var_network_plugins := rt.new_null()
	mut var_plugin := rt.new_null()
	var_plugins = []rt.PhpVal{}
	var_active_plugins = rt.cast_array(rt.call_function('get_option', [
		rt.new_string('active_plugins'),
		[]rt.PhpVal{},
	]))
	if rt.is_true(rt.call_function('get_option', [rt.new_string('hack_file')]))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + 'my-hacks.php')])) {
		rt.call_function('_deprecated_file', [rt.new_string('my-hacks.php'),
			rt.new_string('1.5.0')])
		rt.call_function('array_unshift', [var_plugins.clone(),
			rt.new_string((rt.get_constant('ABSPATH')).str() + 'my-hacks.php')])
	}
	if !rt.is_true(var_active_plugins) || wp_installing() {
		return var_plugins.clone()
	}
	var_network_plugins = if is_multisite() {
		rt.call_function('wp_get_active_network_plugins', []rt.PhpVal{})
	} else {
		rt.new_bool(false)
	}
	mut iter_2 := var_active_plugins.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin_shadow := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_file', [var_plugin_shadow.clone()])))))
			&& rt.is_true(rt.call_function('str_ends_with', [var_plugin_shadow.clone(), rt.new_string('.php')]))
			&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_shadow.str())]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_network_plugins))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_shadow.str()), var_network_plugins.clone(), rt.new_bool(true)]))))) {
			var_plugins.array_push(
				(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_shadow.str())
		}
	}
	if rt.is_true(wp_is_recovery_mode()) {
		var_plugins = wp_skip_paused_plugins(var_plugins.clone())
	}
	return var_plugins.clone()
}

fn wp_skip_paused_plugins(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_paused_plugins := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_index := rt.new_null()
	var_paused_plugins = rt.call_method(rt.call_function('wp_paused_plugins', []rt.PhpVal{}),
		'get_all', []rt.PhpVal{})
	if !rt.is_true(var_paused_plugins) {
		return var_plugins.clone()
	}
	mut iter_3 := var_plugins.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin_shadow := item_3.val
		mut var_index_shadow := item_3.key
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string('/'),
			rt.call_function('plugin_basename', [var_plugin_shadow.clone()])])
		var_plugin_shadow = list_tmp_2.array_get(0)
		if rt.is_true(rt.new_bool(var_paused_plugins.clone().array_isset(var_plugin_shadow.clone()))) {
			var_plugins.array_unset(var_index_shadow)
			var_GLOBALS.array_get_mut('_paused_plugins').array_set(var_plugin_shadow,
				var_paused_plugins.array_get(var_plugin_shadow))
		}
	}
	return var_plugins.clone()
}

fn wp_get_active_and_valid_themes() rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	mut var_themes := rt.new_null()
	var_themes = []rt.PhpVal{}
	if wp_installing()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp-activate.php'), var_pagenow)))) {
		return var_themes.clone()
	}
	if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
		var_themes.array_push(var_wp_stylesheet_path.clone())
	}
	var_themes.array_push(var_wp_template_path.clone())
	if rt.is_true(wp_is_recovery_mode()) {
		var_themes = wp_skip_paused_themes(var_themes.clone())
		if !rt.is_true(var_themes) {
			rt.call_function('add_filter', [rt.new_string('wp_using_themes'),
				rt.new_string('__return_false')])
		}
	}
	return var_themes.clone()
}

fn wp_skip_paused_themes(var_themes rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_paused_themes := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_index := rt.new_null()
	var_paused_themes = rt.call_method(rt.call_function('wp_paused_themes', []rt.PhpVal{}),
		'get_all', []rt.PhpVal{})
	if !rt.is_true(var_paused_themes) {
		return var_themes.clone()
	}
	mut iter_4 := var_themes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_theme_shadow := item_4.val
		mut var_index_shadow := item_4.key
		var_theme_shadow = rt.call_function('basename', [var_theme_shadow.clone()])
		if rt.is_true(rt.new_bool(var_paused_themes.clone().array_isset(var_theme_shadow.clone()))) {
			var_themes.array_unset(var_index_shadow)
			var_GLOBALS.array_get_mut('_paused_themes').array_set(var_theme_shadow,
				var_paused_themes.array_get(var_theme_shadow))
		}
	}
	return var_themes.clone()
}

fn wp_is_recovery_mode() rt.PhpVal {
	return rt.call_method(rt.call_function('wp_recovery_mode', []rt.PhpVal{}), 'is_active',
		[]rt.PhpVal{})
}

fn is_protected_endpoint() bool {
	mut var_GLOBALS := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('pagenow'))
		&& rt.is_true(rt.identical(rt.new_string('wp-login.php'), var_GLOBALS.array_get(rt.new_string('pagenow')))) {
		return true
	}
	if is_admin() && rt.is_true(rt.new_bool(!(rt.is_true(wp_doing_ajax())))) {
		return true
	}
	if rt.is_true(rt.new_bool(is_protected_ajax_action())) {
		return true
	}
	return (rt.call_function('apply_filters', [rt.new_string('is_protected_endpoint'),
		rt.new_bool(false)])).to_bool()
}

fn is_protected_ajax_action() bool {
	mut var_actions_to_protect := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_doing_ajax())))) {
		return false
	}
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))) {
		return false
	}
	var_actions_to_protect = rt.create_array([
		rt.ArrayItem{ key: none, val: 'edit-theme-plugin-file' },
		rt.ArrayItem{ key: none, val: 'heartbeat' },
		rt.ArrayItem{ key: none, val: 'install-plugin' },
		rt.ArrayItem{ key: none, val: 'install-theme' },
		rt.ArrayItem{ key: none, val: 'search-plugins' },
		rt.ArrayItem{ key: none, val: 'search-install-plugins' },
		rt.ArrayItem{ key: none, val: 'update-plugin' },
		rt.ArrayItem{ key: none, val: 'update-theme' },
		rt.ArrayItem{ key: none, val: 'activate-plugin' },
	])
	var_actions_to_protect = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('wp_protected_ajax_actions'),
		var_actions_to_protect.clone(),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		var_actions_to_protect.clone(),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	return true
}

fn wp_set_internal_encoding() {
	mut var_charset := rt.new_null()
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('mb_internal_encoding'),
	]))
	{
		var_charset = rt.call_function('get_option', [rt.new_string('blog_charset')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_charset))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('mb_internal_encoding', [var_charset.clone()]))))) {
			rt.call_function('mb_internal_encoding', [rt.new_string('UTF-8')])
		}
	}
}

fn wp_magic_quotes() {
	mut var__GET := rt.new_null()
	mut var__POST := rt.new_null()
	mut var__COOKIE := rt.new_null()
	mut var__SERVER := rt.new_null()
	mut var__REQUEST := rt.new_null()
	var__GET = rt.call_function('add_magic_quotes', [rt.get_superglobal('_GET').clone()])
	var__POST = rt.call_function('add_magic_quotes', [rt.get_superglobal('_POST').clone()])
	var__COOKIE = rt.call_function('add_magic_quotes', [rt.get_superglobal('_COOKIE').clone()])
	var__SERVER = rt.call_function('add_magic_quotes', [rt.get_superglobal('_SERVER').clone()])
	var__REQUEST = rt.call_function('array_merge', [rt.get_superglobal('_GET').clone(),
		rt.get_superglobal('_POST').clone()])
}

fn shutdown_action_hook() {
	rt.call_function('do_action', [rt.new_string('shutdown')])
	rt.call_function('wp_cache_close', []rt.PhpVal{})
}

fn wp_clone(var_input_object rt.PhpVal) rt.PhpVal {
	return var_input_object.dup()
}

fn is_login() bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		rt.call_function('wp_login_url', []rt.PhpVal{}),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_NAME')),
	]))))
}

fn is_admin() bool {
	mut var_GLOBALS := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('current_screen')) {
		return (rt.call_method(var_GLOBALS.array_get(rt.new_string('current_screen')), 'in_admin',
			[]rt.PhpVal{})).to_bool()
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('WP_ADMIN')])) {
		return (rt.get_constant('WP_ADMIN')).to_bool()
	}
	return false
}

fn is_blog_admin() bool {
	mut var_GLOBALS := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('current_screen')) {
		return (rt.call_method(var_GLOBALS.array_get(rt.new_string('current_screen')), 'in_admin', [
			rt.new_string('site'),
		])).to_bool()
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('WP_BLOG_ADMIN')])) {
		return (rt.get_constant('WP_BLOG_ADMIN')).to_bool()
	}
	return false
}

fn is_network_admin() bool {
	mut var_GLOBALS := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('current_screen')) {
		return (rt.call_method(var_GLOBALS.array_get(rt.new_string('current_screen')), 'in_admin', [
			rt.new_string('network'),
		])).to_bool()
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('WP_NETWORK_ADMIN')])) {
		return (rt.get_constant('WP_NETWORK_ADMIN')).to_bool()
	}
	return false
}

fn is_user_admin() bool {
	mut var_GLOBALS := rt.new_null()
	if var_GLOBALS.array_isset(rt.new_string('current_screen')) {
		return (rt.call_method(var_GLOBALS.array_get(rt.new_string('current_screen')), 'in_admin', [
			rt.new_string('user'),
		])).to_bool()
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('WP_USER_ADMIN')])) {
		return (rt.get_constant('WP_USER_ADMIN')).to_bool()
	}
	return false
}

fn is_multisite() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')])) {
		return (rt.get_constant('MULTISITE')).to_bool()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('SUBDOMAIN_INSTALL')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('VHOST')]))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('SUNRISE')])) {
		return true
	}
	return false
}

fn absint(var_maybeint rt.PhpVal) rt.PhpVal {
	return rt.call_function('abs', [rt.new_int(var_maybeint.to_i64())])
}

fn get_current_blog_id() rt.PhpVal {
	mut var_blog_id := rt.new_null()
	return absint(var_blog_id.clone())
}

fn get_current_network_id() i64 {
	mut var_current_network := rt.new_null()
	if !(is_multisite()) {
		return 1
	}
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if !(!(rt.get_property(var_current_network, 'id')).is_null()) {
		return (rt.call_function('get_main_network_id', []rt.PhpVal{})).to_i64()
	}
	return (absint(rt.get_property(var_current_network, 'id'))).to_i64()
}

fn wp_load_translations_early() {
	mut var_wp_local_package := rt.new_null()
	mut var_loaded := false
	mut var_locales := []rt.PhpVal{}
	mut var_locations := rt.new_null()
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_location := rt.new_null()
	mut var_wp_locale := rt.new_null()
	if var_loaded {
		return
	}
	var_loaded = true
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('did_action')]))
		&& rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
		return
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pomo/mo.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/l10n/class-wp-translation-controller.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/l10n/class-wp-translations.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/l10n/class-wp-translation-file.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/l10n/class-wp-translation-file-mo.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/l10n/class-wp-translation-file-php.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/l10n.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-textdomain-registry.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-locale.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-locale-switcher.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/plugin.php', '4')
	var_locales = []rt.PhpVal{}
	var_locations = []rt.PhpVal{}
	if !(true) {
		var_wp_textdomain_registry = create_wp_textdomain_registry()
	}
	for true {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WPLANG')])) {
			if rt.is_true(rt.identical(rt.new_string(''), rt.get_constant('WPLANG'))) {
				break
			}
			var_locales << rt.get_constant('WPLANG')
		}
		if !var_wp_local_package.is_null() {
			var_locales << var_wp_local_package.clone()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_locales)))) {
			break
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_LANG_DIR')]))
			&& rt.is_true(rt.call_function('is_dir', [rt.get_constant('WP_LANG_DIR')])) {
			var_locations.array_push(rt.get_constant('WP_LANG_DIR'))
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')]))
			&& rt.is_true(rt.call_function('is_dir', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/languages')])) {
			var_locations.array_push((rt.get_constant('WP_CONTENT_DIR')).str() + '/languages')
		}
		if rt.is_true(rt.call_function('is_dir', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-content/languages'),
		]))
		{
			var_locations.array_push((rt.get_constant('ABSPATH')).str() + 'wp-content/languages')
		}
		if rt.is_true(rt.call_function('is_dir', [
			rt.new_string(
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/languages'),
		]))
		{
			var_locations.array_push(
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/languages')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_locations)))) {
			break
		}
		var_locations = rt.call_function('array_unique', [var_locations.clone()])
		for var_locale_shadow in var_locales {
			mut iter_5 := var_locations.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_location_shadow := item_5.val
				if rt.is_true(rt.call_function('file_exists', [
					rt.new_string(var_location_shadow.str() + '/' + var_locale_shadow.str() + '.mo'),
				]))
				{
					rt.call_function('load_textdomain', [rt.new_string('default'),
						rt.new_string(var_location_shadow.str() + '/' + var_locale_shadow.str() +
							'.mo'),
						var_locale_shadow.clone()])
					if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SETUP_CONFIG')]))
						&& rt.is_true(rt.call_function('file_exists', [rt.new_string(var_location_shadow.str() + '/admin-' + var_locale_shadow.str() + '.mo')])) {
						rt.call_function('load_textdomain', [
							rt.new_string('default'),
							rt.new_string(var_location_shadow.str() +
								'/admin-' + var_locale_shadow.str() + '.mo'),
							var_locale_shadow.clone()])
					}
					break
				}
			}
		}
		break
	}
	var_wp_locale = create_wp_locale()
}

fn wp_installing(var_is_installing rt.PhpVal) bool {
	mut var_installing := rt.new_null()
	mut var_old_installing := false
	if rt.is_true(rt.new_bool(var_installing.clone().is_null())) {
		var_installing = rt.new_bool(
			rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING')]))
			&& rt.is_true(rt.get_constant('WP_INSTALLING')))
	}
	if !(var_is_installing.clone().is_null()) {
		var_old_installing = var_installing.to_bool()
		var_installing = var_is_installing
		return var_old_installing
	}
	return var_installing.to_bool()
}

fn is_ssl() bool {
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTPS')) {
		if rt.is_true(rt.identical(rt.new_string('on'),
			rt.new_string(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS')).to_string().to_lower())))
		{
			return true
		}
		if rt.is_true(rt.identical(rt.new_string('1'),
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTPS'))).str()))
		{
			return true
		}
	} else if rt.get_superglobal('_SERVER').array_isset(rt.new_string('SERVER_PORT'))
		&& rt.is_true(rt.identical(rt.new_string('443'), (rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PORT'))).str())) {
		return true
	}
	return false
}

fn wp_convert_hr_to_bytes(var_value_arg rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_bytes := rt.new_null()
	var_value = var_value.trim_space().to_lower()
	var_bytes = rt.new_int(var_value.i64())
	if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_value.str()).clone(),
		rt.new_string('g')]))
	{
		var_bytes = rt.mul(var_bytes, rt.get_constant('GB_IN_BYTES'))
	} else if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_value.str()).clone(),
		rt.new_string('m')]))
	{
		var_bytes = rt.mul(var_bytes, rt.get_constant('MB_IN_BYTES'))
	} else if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_value.str()).clone(),
		rt.new_string('k')]))
	{
		var_bytes = rt.mul(var_bytes, rt.get_constant('KB_IN_BYTES'))
	}
	return rt.call_function('min', [var_bytes.clone(), rt.get_constant('PHP_INT_MAX')])
}

fn wp_is_ini_value_changeable(var_setting rt.PhpVal) bool {
	mut var_ini_all := rt.new_null()
	if !(!var_ini_all.is_null()) {
		var_ini_all = rt.new_bool(false)
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get_all')])) {
			var_ini_all = rt.call_function('ini_get_all', []rt.PhpVal{})
		}
	}
	if var_ini_all.array_get(var_setting).array_isset(rt.new_string('access'))
		&& rt.is_true(rt.identical(rt.get_constant('INI_ALL'), var_ini_all.array_get(var_setting).array_get(rt.new_string('access'))))
		|| rt.is_true(rt.identical(rt.get_constant('INI_USER'), var_ini_all.array_get(var_setting).array_get(rt.new_string('access')))) {
		return true
	}
	if !(var_ini_all.clone().is_array()) {
		return true
	}
	return false
}

fn wp_doing_ajax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_doing_ajax'),
		rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')]))
			&& rt.is_true(rt.get_constant('DOING_AJAX')))])
}

fn wp_using_themes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_using_themes'),
		rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_USE_THEMES')]))
			&& rt.is_true(rt.get_constant('WP_USE_THEMES')))])
}

fn wp_doing_cron() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_doing_cron'),
		rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_CRON')]))
			&& rt.is_true(rt.get_constant('DOING_CRON')))])
}

fn is_wp_error(var_thing rt.PhpVal) rt.PhpVal {
	mut var_is_wp_error := rt.new_null()
	var_is_wp_error = rt.new_bool(rt.instance_of(var_thing, 'WP_Error'))
	if rt.is_true(var_is_wp_error) {
		rt.call_function('do_action', [rt.new_string('is_wp_error_instance'),
			var_thing.clone()])
	}
	return var_is_wp_error.clone()
}

fn wp_is_file_mod_allowed(var_context rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('file_mod_allowed'),
		rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('DISALLOW_FILE_MODS')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('DISALLOW_FILE_MODS')))))),
		var_context.clone()])
}

fn wp_start_scraping_edited_file_errors() {
	mut var_key := rt.new_null()
	mut var_nonce := rt.new_null()
	mut var_transient := rt.new_null()
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_scrape_key')))
		|| !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('wp_scrape_nonce'))) {
		return
	}
	var_key = rt.call_function('substr', [
		rt.call_function('sanitize_key', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_scrape_key'))]),
		]),
		rt.new_int(0),
		rt.new_int(32),
	])
	var_nonce = rt.call_function('wp_unslash', [
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('wp_scrape_nonce')),
	])
	if !rt.is_true(var_key) || !rt.is_true(var_nonce) {
		return
	}
	var_transient = rt.call_function('get_transient', [
		rt.new_string('scrape_key_' + var_key.str()),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_transient)) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_transient, var_nonce)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
			rt.call_function('nocache_headers', []rt.PhpVal{})
		}
		print('###### wp_scraping_result_start:${var_key.to_string()} ######')
		rt.echo_val(rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'code', val: 'scrape_nonce_failure' },
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Scrape key check failed. Please try again.'),
				]) }]),
		]))
		print('###### wp_scraping_result_end:${var_key.to_string()} ######')
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_SANDBOX_SCRAPING'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_SANDBOX_SCRAPING'),
			rt.new_bool(true)])
	}
	rt.call_function('register_shutdown_function', [
		rt.new_string('wp_finalize_scraping_edited_file_errors'),
		var_key.clone(),
	])
}

fn wp_finalize_scraping_edited_file_errors(var_scrape_key rt.PhpVal) {
	mut var_error := rt.new_null()
	var_error = rt.call_function('error_get_last', []rt.PhpVal{})
	print('\n###### wp_scraping_result_start:${var_scrape_key.to_string()} ######\n')
	if !(!rt.is_true(var_error))
		&& rt.is_true(rt.call_function('in_array', [var_error.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: rt.get_constant('E_CORE_ERROR')
	}, rt.ArrayItem{ key: none, val: rt.get_constant('E_COMPILE_ERROR') }, rt.ArrayItem{
		key: none
		val: rt.get_constant('E_ERROR')
	}, rt.ArrayItem{ key: none, val: rt.get_constant('E_PARSE') }, rt.ArrayItem{
		key: none
		val: rt.get_constant('E_USER_ERROR')
	}, rt.ArrayItem{ key: none, val: rt.get_constant('E_RECOVERABLE_ERROR') }]), rt.new_bool(true)])) {
		var_error = rt.call_function('str_replace', [rt.get_constant('ABSPATH'),
			rt.new_string(''), var_error.clone()])
		rt.echo_val(rt.call_function('wp_json_encode', [var_error.clone()]))
	} else {
		rt.echo_val(rt.call_function('wp_json_encode', [rt.new_bool(true)]))
	}
	print('\n###### wp_scraping_result_end:${var_scrape_key.to_string()} ######\n')
}

fn wp_is_json_request() bool {
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCEPT'))
		&& rt.is_true(wp_is_json_media_type(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ACCEPT')))) {
		return true
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('CONTENT_TYPE'))
		&& rt.is_true(wp_is_json_media_type(rt.get_superglobal('_SERVER').array_get(rt.new_string('CONTENT_TYPE')))) {
		return true
	}
	return false
}

fn wp_is_jsonp_request() bool {
	mut var_jsonp_callback := rt.new_null()
	mut var_jsonp_enabled := rt.new_null()
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('_jsonp'))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_check_jsonp_callback'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php',
			'4')
	}
	var_jsonp_callback = rt.get_superglobal('_GET').array_get(rt.new_string('_jsonp'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_check_jsonp_callback', [
		var_jsonp_callback.clone(),
	])))))
	{
		return false
	}
	var_jsonp_enabled = rt.call_function('apply_filters', [
		rt.new_string('rest_jsonp_enabled'),
		rt.new_bool(true),
	])
	return var_jsonp_enabled.to_bool()
}

fn wp_is_json_media_type(var_media_type rt.PhpVal) rt.PhpVal {
	mut var_cache := rt.new_null()
	if !(var_cache.array_isset(var_media_type)) {
		var_cache.array_set(var_media_type, (rt.call_function('preg_match', [
			rt.new_string('/(^|\\s|,)application\\/([\\w!#\\$&-\\^\\.\\+]+\\+)?json(\\+oembed)?($|\\s|;|,)/i'),
			var_media_type.clone(),
		])).to_bool())
	}
	return var_cache.array_get(var_media_type)
}

fn wp_is_xml_request() bool {
	mut var_accepted := []rt.PhpVal{}
	mut var_type := rt.new_null()
	var_accepted = ['text/xml', 'application/rss+xml', 'application/atom+xml', 'application/rdf+xml',
		'text/xml+oembed', 'application/xml+oembed']
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCEPT')) {
		for var_type_shadow in var_accepted {
			if rt.is_true(rt.call_function('str_contains', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ACCEPT')),
				rt.new_string(var_type_shadow.str()).clone(),
			]))
			{
				return true
			}
		}
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('CONTENT_TYPE'))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_SERVER').array_get(rt.new_string('CONTENT_TYPE')), rt.create_array_from_list(var_accepted), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn wp_is_site_protected_by_basic_auth(context string) rt.PhpVal {
	mut var_context := context
	mut var_pagenow := rt.new_null()
	mut var_is_protected := false
	if !(var_context.len > 0 && var_context != '0') {
		if rt.is_true(rt.identical(rt.new_string('wp-login.php'), var_pagenow)) {
			var_context = 'login'
		} else if rt.is_true(rt.new_bool(is_admin())) {
			var_context = 'admin'
		} else {
			var_context = 'front'
		}
	}
	var_is_protected =
		!(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))))
		|| !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))))
	return rt.call_function('apply_filters', [
		rt.new_string('wp_is_site_protected_by_basic_auth'),
		rt.new_bool(var_is_protected).clone(),
		rt.new_string(var_context.str()),
	])
}

struct Class_wpdb {
	rt.PhpObjectBase
}

struct Class_WP_Hook {
	rt.PhpObjectBase
}

struct Class_WP_Textdomain_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Locale {
	rt.PhpObjectBase
}

fn create_wpdb(_args ...rt.PhpVal) &Class_wpdb {
	mut obj := &Class_wpdb{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_hook(_args ...rt.PhpVal) &Class_WP_Hook {
	mut obj := &Class_WP_Hook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_textdomain_registry(_args ...rt.PhpVal) &Class_WP_Textdomain_Registry {
	mut obj := &Class_WP_Textdomain_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_locale(_args ...rt.PhpVal) &Class_WP_Locale {
	mut obj := &Class_WP_Locale{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_wpdb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_wpdb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_wpdb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Hook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Hook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Hook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Textdomain_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Textdomain_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Textdomain_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Locale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Locale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Locale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

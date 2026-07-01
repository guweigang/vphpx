import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('ABSPATH'), @DIR + '/'])
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('error_reporting')])) {
		rt.call_function('error_reporting', [
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('E_CORE_ERROR'),
				rt.get_constant('E_CORE_WARNING')), rt.get_constant('E_COMPILE_ERROR')),
				rt.get_constant('E_ERROR')), rt.get_constant('E_WARNING')),
				rt.get_constant('E_PARSE')), rt.get_constant('E_USER_ERROR')),
				rt.get_constant('E_USER_WARNING')), rt.get_constant('E_RECOVERABLE_ERROR')),
		])
	}
	if rt.is_true(rt.call_function('file_exists', [
		(rt.get_constant('ABSPATH')).str() + 'wp-config.php']))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-config.php', '4')
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('file_exists', [(rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-config.php']))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() + '/wp-settings.php'])))))))
	{
		rt.include_file((rt.call_function('dirname', [rt.get_constant('ABSPATH')])).str() +
			'/wp-config.php', '4')
	} else {
		rt.call_function('define', [rt.new_string('WPINC'), rt.new_string('wp-includes')])
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php',
			'4')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/compat.php',
			'4')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/load.php',
			'4')
		rt.call_function('wp_check_php_mysql_versions', []rt.PhpVal{})
		rt.call_function('wp_fix_server_vars', []rt.PhpVal{})
		rt.call_function('define', [rt.new_string('WP_CONTENT_DIR'), 
			(rt.get_constant('ABSPATH')).str() + 'wp-content'])
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php',
			'4')
		mut var_path := rt.new_string((rt.call_function('wp_guess_url', []rt.PhpVal{})).str() +
			'/wp-admin/setup-config.php')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			rt.get_superglobal('_SERVER').array_get('REQUEST_URI'),
			rt.new_string('setup-config'),
		])))))
		{
			rt.call_function('header', ['Location: ' + var_path.str()])
			// unsupported expression: Expr_Exit
		}
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
		mut var_die := rt.new_string('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string("There doesn't seem to be a %s file. It is needed before the installation can continue.")]), rt.new_string('<code>wp-config.php</code>')])).str() +
			'</p>')
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('wp_die', [var_die.dup(),
			rt.call_function('__', [rt.new_string('WordPress &rsaquo; Error')])])
	}
}

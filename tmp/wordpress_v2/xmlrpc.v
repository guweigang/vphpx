import rt

const global_const_xmlrpc_request = true

fn logio(var_io rt.PhpVal, var_msg rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.4.0'), rt.new_string('error_log()')])
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('xmlrpc_logging')))) {
		rt.call_function('error_log', [
			rt.new_string(var_io.str() + ' - ' + var_msg.str()),
		])
	}
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var__COOKIE := rt.new_array()
	if !(!var_HTTP_RAW_POST_DATA.is_null()) {
		mut var_HTTP_RAW_POST_DATA := rt.call_function('file_get_contents', [
			rt.new_string('php://input'),
		])
	}
	var_HTTP_RAW_POST_DATA = rt.new_string(var_HTTP_RAW_POST_DATA.clone().to_string().trim_space())
	rt.include_file(@DIR + '/wp-load.php', '4')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('rsd')) {
		rt.call_function('header', [
			rt.new_string('Content-Type: text/xml; charset=' +
				(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
			rt.new_bool(true),
		])
		print('<?xml version="1.0" encoding="' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"?' + '>')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('bloginfo_rss', [rt.new_string('url')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('site_url', [rt.new_string('xmlrpc.php'),
			rt.new_string('rpc')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('site_url', [rt.new_string('xmlrpc.php'),
			rt.new_string('rpc')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('site_url', [rt.new_string('xmlrpc.php'),
			rt.new_string('rpc')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('site_url', [rt.new_string('xmlrpc.php'),
			rt.new_string('rpc')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('xmlrpc_rsd_apis')])
		// unsupported statement: Stmt_InlineHTML
		exit(0)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-IXR.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-xmlrpc-server.php',
		'4')
	mut var_post_default_title := ''
	mut var_wp_xmlrpc_server_class := rt.call_function('apply_filters', [
		rt.new_string('wp_xmlrpc_server_class'),
		rt.new_string('wp_xmlrpc_server'),
	])
	mut var_wp_xmlrpc_server := rt.create_object_dynamically(var_wp_xmlrpc_server_class,
		[]rt.PhpVal{})
	rt.call_method(var_wp_xmlrpc_server, 'serve_request', []rt.PhpVal{})
	exit(0)
}

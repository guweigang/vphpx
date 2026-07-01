import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_hook_suffix := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('in_admin_footer')])
	// unsupported statement: Stmt_InlineHTML
	mut var_text := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Thank you for creating with <a href="%s">WordPress</a>.'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('__', [rt.new_string('https://wordpress.org/')]),
		]),
	])
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('admin_footer_text'),
		'<span id="footer-thankyou">' + var_text.str() + '</span>']))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('update_footer'),
		rt.new_string('')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_footer'),
		rt.new_string('')])
	rt.call_function('do_action', [
		rt.new_string('admin_print_footer_scripts-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_print_footer_scripts')])
	rt.call_function('do_action', [
		rt.new_string('admin_footer-${var_hook_suffix.to_string()}'),
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('function_exists', [rt.new_string('get_site_option')]))
		&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_site_option', [rt.new_string('can_compress_scripts')])))))
	{
		rt.call_function('compression_test', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
}

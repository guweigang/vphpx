import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_download_url := rt.new_null()
	mut var_report_name := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.clone(), var_email.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_download_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Download your %s Report'),
				rt.new_string('woocommerce')]),
			var_report_name.clone(),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		var_email.clone()])
}

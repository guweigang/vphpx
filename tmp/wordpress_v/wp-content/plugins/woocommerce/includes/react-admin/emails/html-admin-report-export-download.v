import rt



pub fn init_wp_content_plugins_woocommerce_includes_react_admin_emails_html_admin_report_export_download_php() {
	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_download_url := rt.new_null()
	mut var_report_name := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'), var_email_heading.dup(), var_email.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_download_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Download your %s Report'), rt.new_string('woocommerce')]), var_report_name.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'), var_email.dup()])
}

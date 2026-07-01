import rt



pub fn init_wp_content_plugins_woocommerce_includes_react_admin_emails_plain_admin_report_export_download_php() {
	mut var_email_heading := rt.new_null()
	mut var_report_name := rt.new_null()
	mut var_download_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [var_email_heading.dup()])]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Download your %1$s Report: %2$s'), rt.new_string('woocommerce')]), var_report_name.dup(), var_download_url.dup()])]))
	print('\n\n----------------------------------------\n\n')
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_email_footer_text'), rt.call_function('get_option', [rt.new_string('woocommerce_email_footer_text')])])]))
}

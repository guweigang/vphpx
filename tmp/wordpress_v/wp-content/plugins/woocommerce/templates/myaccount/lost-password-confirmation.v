import rt



pub fn init_wp_content_plugins_woocommerce_templates_myaccount_lost_password_confirmation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('wc_print_notice', [rt.call_function('esc_html__', [rt.new_string('Password reset email has been sent.'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_lost_password_confirmation_message')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_lost_password_confirmation_message'), rt.call_function('esc_html__', [rt.new_string('A password reset email has been sent to the email address on file for your account, but may take several minutes to show up in your inbox. Please wait at least 10 minutes before attempting another reset.'), rt.new_string('woocommerce')])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_lost_password_confirmation_message')])
}

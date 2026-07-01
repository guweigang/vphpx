import rt

pub fn init_wp_content_plugins_woocommerce_templates_emails_customer_stock_notification_verify_php() {
	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_intro_content := rt.new_null()
	mut var_product := rt.new_null()
	mut var_notification := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_verification_link := rt.new_null()
	mut var_verification_button_text := rt.new_null()
	mut var_verification_expiration_threshold := rt.new_null()
	mut var_additional_content := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.dup(), var_email.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [var_intro_content.dup()]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		var_product.dup(),
		var_notification.dup(),
		var_plain_text.dup(),
		var_email.dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_verification_link.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_verification_button_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('This link will remain active for %s.'),
				rt.new_string('woocommerce'),
			]),
			var_verification_expiration_threshold.dup(),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('__', [
			rt.new_string("You have received this message because your e-mail address was used to sign up for stock notifications on our store. Wasn't you? Please get in touch with us if you keep receiving these messages."),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [var_additional_content.dup()]),
			]),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		var_email.dup()])
}

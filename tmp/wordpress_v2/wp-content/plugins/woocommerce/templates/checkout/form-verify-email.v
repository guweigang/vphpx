import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_verify_url := rt.new_null()
	mut var_failed_submission := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_verify_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc_verify_email'),
		rt.new_string('check_submission')])
	if rt.is_true(var_failed_submission) {
		rt.call_function('wc_print_notice', [
			rt.call_function('esc_html__', [
				rt.new_string('We were unable to verify the email address you provided. Please try again.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('error'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('To view this page, you must either %1$slogin%2$s or verify the email address associated with the order.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<a href="' +
			(rt.call_function('esc_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])).str() +
			'">'),
		rt.new_string('</a>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Email address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_wp_theme_get_element_class_name', [
			rt.new_string('button')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Verify'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

import rt

pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_customer_stock_notification_verified_php() {
	mut var_email_heading := rt.new_null()
	mut var_intro_content := rt.new_null()
	mut var_notification := rt.new_null()
	mut var_product := rt.new_null()
	mut var_email := rt.new_null()
	mut var_additional_content := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [var_email_heading.dup()]),
	]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [
			rt.call_function('wptexturize', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_email_intro_content'),
					var_intro_content.dup(),
					var_notification.dup(),
				]),
			]),
		]),
	]))
	print('\n\n----------------------------------------\n\n')
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		var_product.dup(),
		var_notification.dup(),
		rt.new_bool(true),
		var_email.dup(),
	])
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_function('wptexturize', [var_additional_content.dup()]),
			]),
		]))
		print('\n\n----------------------------------------\n\n')
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_footer_text'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_email_footer_text'),
			]),
		]),
	]))
	// unsupported statement: Stmt_Nop
}

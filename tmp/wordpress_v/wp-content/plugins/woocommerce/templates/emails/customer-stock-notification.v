import rt

pub fn init_wp_content_plugins_woocommerce_templates_emails_customer_stock_notification_php() {
	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_intro_content := rt.new_null()
	mut var_product := rt.new_null()
	mut var_notification := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_button_link := rt.new_null()
	mut var_button_text := rt.new_null()
	mut var_is_guest := rt.new_null()
	mut var_unsubscribe_link := rt.new_null()
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
	rt.echo_val(rt.call_function('esc_url', [var_button_link.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('__', [
			rt.new_string('You have received this message because your e-mail address was used to sign up for stock notifications on our store.'),
			rt.new_string('woocommerce'),
		]),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_guest)))) {
		mut var_unsubscribe_link_tag := rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" id="notification__unsubscribe_link">%2$s</a>'),
			rt.call_function('esc_url', [var_unsubscribe_link.dup()]),
			rt.call_function('_x', [rt.new_string('click here'),
				rt.new_string('unsubscribe cta for stock notifications for existing customers'),
				rt.new_string('woocommerce')]),
		])
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('To manage your notifications, %s to log in to your account.'),
					rt.new_string('woocommerce'),
				]),
				var_unsubscribe_link_tag.dup(),
			]),
		]))
	} else {
		var_unsubscribe_link_tag = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" id="notification__unsubscribe_link">%2$s</a>'),
			rt.call_function('esc_url', [var_unsubscribe_link.dup()]),
			rt.call_function('_x', [rt.new_string('click here'),
				rt.new_string('unsubscribe cta for stock notifications for guests'),
				rt.new_string('woocommerce')]),
		])
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('To stop receiving these messages, %s to unsubscribe.'),
					rt.new_string('woocommerce'),
				]),
				var_unsubscribe_link_tag.dup(),
			]),
		]))
	}
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

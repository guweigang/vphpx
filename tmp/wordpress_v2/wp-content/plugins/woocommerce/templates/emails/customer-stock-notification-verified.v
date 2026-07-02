import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_intro_content := rt.new_null()
	mut var_product := rt.new_null()
	mut var_notification := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_is_guest := rt.new_null()
	mut var_unsubscribe_link := rt.new_null()
	mut var_additional_content := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.clone(), var_email.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [var_intro_content.clone()]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_stock_notification_product'),
		var_product.clone(),
		var_notification.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You have received this message because your e-mail address was used to sign up for stock notifications on our store.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
		]),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_guest)))) {
		mut var_unsubscribe_link_tag := rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" id="notification__unsubscribe_link">%2$s</a>'),
			rt.call_function('esc_url', [var_unsubscribe_link.clone()]),
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
				var_unsubscribe_link_tag.clone(),
			]),
		]))
	} else {
		var_unsubscribe_link_tag = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" id="notification__unsubscribe_link">%2$s</a>'),
			rt.call_function('esc_url', [var_unsubscribe_link.clone()]),
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
				var_unsubscribe_link_tag.clone(),
			]),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [var_additional_content.clone()]),
			]),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		var_email.clone()])
}

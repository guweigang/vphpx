import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wp_strip_all_tags', [var_email_heading.clone()]),
	]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	print(
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Hi %s,'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{})])])).str() +
		'\n\n')
	if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
		if rt.is_true(rt.call_method(var_order, 'has_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.failed(),
		]))
		{
			print(
				(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, your order on %1$s was unsuccessful. Your order details are below, with a link to try your payment again: %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])]), rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})])])])).str() +
				'\n\n')
		} else {
			print(
				(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An order has been created for you on %1$s. Your order details are below, with a link to make payment when you’re ready: %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])]), rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})])])])).str() +
				'\n\n')
		}
	} else {
		print(
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Here are the details of your order placed on %s:'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])])).str() +
			'\n\n')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_details'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	print('\n----------------------------------------\n\n')
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_meta'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	print('\n\n----------------------------------------\n\n')
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_function('wptexturize', [var_additional_content.clone()]),
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
}

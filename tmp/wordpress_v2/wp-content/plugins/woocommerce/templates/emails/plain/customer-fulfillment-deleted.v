import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_order := rt.new_null()
	mut var_fulfillment := rt.new_null()
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
		(rt.call_function('esc_html__', [rt.new_string('We wanted to let you know that one of the previously fulfilled shipments from your order has been removed from our system. This may have been due to a correction or an update in our fulfillment records. Don’t worry — this won’t affect any items you’ve already received.'), rt.new_string('woocommerce')])).str() +
		'\n\n')
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_fulfillment_details'),
		var_order.clone(),
		var_fulfillment.clone(),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
	print('\n----------------------------------------\n\n')
	rt.call_function('do_action', [rt.new_string('woocommerce_email_fulfillment_meta'),
		var_order.clone(), var_fulfillment.clone(), var_sent_to_admin.clone(),
		var_plain_text.clone(), var_email.clone()])
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

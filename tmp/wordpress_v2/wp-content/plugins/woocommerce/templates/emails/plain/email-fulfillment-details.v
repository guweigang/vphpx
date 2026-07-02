import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_fulfillment := rt.new_null()
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_fulfillment, 'get_date_deleted',
		[]rt.PhpVal{})))
	{
		mut var_tracking_number := rt.call_method(var_fulfillment, 'get_meta', [
			rt.new_string('_tracking_number'),
			rt.new_bool(true),
		])
		mut var_tracking_url := rt.call_method(var_fulfillment, 'get_meta', [
			rt.new_string('_tracking_url'),
		])
		mut var_shipment_provider := rt.call_method(var_fulfillment, 'get_meta', [
			rt.new_string('_shipment_provider'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_number))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_tracking_url))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_shipment_provider)))) {
			rt.echo_val(rt.call_function('esc_html__', [
				rt.new_string('No tracking information available for this fulfillment at the moment.'),
				rt.new_string('woocommerce'),
			]))
			return rt.new_null()
		} else {
			print(
				(rt.call_function('esc_html__', [rt.new_string('Tracking Number'), rt.new_string('woocommerce')])).str() +
				': ' + (rt.call_function('esc_attr', [var_tracking_number.clone()])).str() + '\n')
			print(
				(rt.call_function('esc_html__', [rt.new_string('Shipment Provider'), rt.new_string('woocommerce')])).str() +
				': ' + (rt.call_function('esc_html', [var_shipment_provider.clone()])).str() + '\n')
			print(
				(rt.call_function('esc_html__', [rt.new_string('Tracking URL'), rt.new_string('woocommerce')])).str() +
				': ' + (rt.call_function('esc_html', [var_tracking_url.clone()])).str() + '\n\n')
		}
		rt.echo_val(rt.call_function('esc_html__', [
			rt.new_string('You can access to more details of your order by visiting My Account > Orders and select the order you wish to see the latest status of the delivery.'),
			rt.new_string('woocommerce'),
		]))
		print('\n\n\n')
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_before_fulfillment_table'),
		var_order.clone(),
		var_fulfillment.clone(),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('__', [rt.new_string('Fulfillment summary'),
			rt.new_string('woocommerce')]),
	]))
	print('\n\n==========\n\n')
	if rt.is_true(var_sent_to_admin) {
		mut var_before := ''
		mut var_after := rt.new_string('(' +
			(rt.call_function('esc_url', [rt.call_method(var_order, 'get_edit_order_url', []rt.PhpVal{})])).str() +
			')')
	} else {
		var_before = ''
		var_after = rt.new_string('')
	}
	mut var_order_number_string := rt.call_function('__', [rt.new_string('Order #%s'),
		rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.new_string(var_before +
			(rt.call_function('sprintf', [rt.new_string(var_order_number_string.str() +
			var_after.str() +
			' (%s)'), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])).str()),
	]))
	print('\n\n\n')
	rt.echo_val(rt.call_function('wc_get_email_fulfillment_items', [
		var_order.clone(), var_fulfillment.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'show_sku', val: var_sent_to_admin },
			rt.ArrayItem{ key: 'show_image', val: true },
			rt.ArrayItem{ key: 'image_size', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 48 },
				rt.ArrayItem{ key: none, val: 48 },
			]) },
			rt.ArrayItem{ key: 'plain_text', val: var_plain_text },
			rt.ArrayItem{ key: 'sent_to_admin', val: var_sent_to_admin },
		])]))
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_after_fulfillment_table'),
		var_order.clone(),
		var_fulfillment.clone(),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
}

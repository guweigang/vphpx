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
	mut var_text_align := if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		'right'
	} else {
		'left'
	}
	mut var_heading_class := 'email-order-detail-heading'
	mut var_order_table_class := 'email-order-details'
	mut var_order_total_text_align := 'right'
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
			print('<p>' +
				(rt.call_function('esc_html__', [rt.new_string('No tracking information available for this fulfillment at the moment.'), rt.new_string('woocommerce')])).str() +
				'</p>')
		} else {
			print('<p><strong>' +
				(rt.call_function('esc_html__', [rt.new_string('Tracking Number'), rt.new_string('woocommerce')])).str() +
				':</strong> ' +
				(rt.call_function('esc_attr', [var_tracking_number.clone()])).str() + '</p>')
			print('<p><strong>' +
				(rt.call_function('esc_html__', [rt.new_string('Shipment Provider'), rt.new_string('woocommerce')])).str() +
				':</strong> ' +
				(rt.call_function('esc_html', [var_shipment_provider.clone()])).str() + '</p>')
			print('<p><a href="' + (rt.call_function('esc_url', [var_tracking_url.clone()])).str() +
				'" target="_blank">' +
				(rt.call_function('esc_attr__', [rt.new_string('Track your shipment'), rt.new_string('woocommerce')])).str() +
				'</a></p>')
		}
		print('<br />')
		print('<p>')
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You can access more details of your order by visiting <a href="%s" target="_blank">My Account > Orders</a>, and selecting the order you wish to see the latest status for.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('site_url', [
					rt.new_string('my-account/orders/'),
				]),
			]),
		]))
		print('</p>')
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_before_fulfillment_table'),
		var_order.clone(),
		var_fulfillment.clone(),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_heading_class.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('__', [rt.new_string('Fulfillment summary'),
			rt.new_string('woocommerce')]),
	]))
	if rt.is_true(var_sent_to_admin) {
		mut var_before := rt.new_string('<a class="link" href="' +
			(rt.call_function('esc_url', [rt.call_method(var_order, 'get_edit_order_url', []rt.PhpVal{})])).str() +
			'">')
		mut var_after := '</a>'
	} else {
		var_before = rt.new_string('')
		var_after = ''
	}
	print('<br><span>')
	mut var_order_number_string := rt.call_function('__', [rt.new_string('Order #%s'),
		rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.new_string(var_before.str() +
			(rt.call_function('sprintf', [rt.new_string(var_order_number_string.str() + var_after +
			' (<time datetime="%s">%s</time>)'), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}), rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'format', [rt.new_string('c')]), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])])).str()),
	]))
	print('</span>')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_order_table_class.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
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
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_after_fulfillment_table'),
		var_order.clone(),
		var_fulfillment.clone(),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
}

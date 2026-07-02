import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_available_gateways := rt.new_null()
	mut var_order_button_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_totals := rt.call_method(var_order, 'get_order_item_totals', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Qty'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Totals'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.call_method(var_order, 'get_items', []rt.PhpVal{}).array_count() > 0 {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_order_item_visible'),
				rt.new_bool(true),
				var_item.clone(),
			])))))
			{
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_item_class'),
					rt.new_string('order_item'),
					var_item.clone(),
					var_order.clone(),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_item_name'),
					rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
					var_item.clone(),
					rt.new_bool(false),
				]),
			]))
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_item_meta_start'),
				var_item_id.clone(),
				var_item.clone(),
				var_order.clone(),
				rt.new_bool(false),
			])
			rt.call_function('wc_display_item_meta', [var_item.clone()])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_order_item_meta_end'),
				var_item_id.clone(),
				var_item.clone(),
				var_order.clone(),
				rt.new_bool(false),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_order_item_quantity_html'),
				rt.new_string(' <strong class="product-quantity">' +
					(rt.call_function('sprintf', [rt.new_string('&times;&nbsp;%s'), rt.call_function('esc_html', [rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})])])).str() +
					'</strong>'),
				var_item.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_method(var_order, 'get_formatted_line_subtotal', [
				var_item.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_totals) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_totals.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_total := item_2.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_total.array_get(rt.new_string('label')))
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_total.array_get(rt.new_string('value')))
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_pay_order_before_payment')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_available_gateways)) {
			mut iter_3 := var_available_gateways.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_gateway := item_3.val
				rt.call_function('wc_get_template', [
					rt.new_string('checkout/payment-method.php'),
					rt.create_array([rt.ArrayItem{ key: 'gateway', val: var_gateway }]),
				])
			}
		} else {
			print('<li>')
			rt.call_function('wc_print_notice', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_no_available_payment_methods_message'),
					rt.call_function('esc_html__', [
						rt.new_string('Sorry, it seems that there are no available payment methods for your location. Please contact us if you require assistance or wish to make alternate arrangements.'),
						rt.new_string('woocommerce'),
					]),
				]),
				rt.new_string('notice'),
			])
			print('</li>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_get_template', [rt.new_string('checkout/terms.php')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_pay_order_before_submit')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_pay_order_button_html'),
		rt.new_string('<button type="submit" class="button alt' +
			(rt.call_function('esc_attr', [rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' +
			(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { '' }).str())])).str() +
			'" id="place_order" value="' +
			(rt.call_function('esc_attr', [var_order_button_text.clone()])).str() +
			'" data-value="' +
			(rt.call_function('esc_attr', [var_order_button_text.clone()])).str() + '">' +
			(rt.call_function('esc_html', [var_order_button_text.clone()])).str() + '</button>'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_pay_order_after_submit')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-pay'),
		rt.new_string('woocommerce-pay-nonce')])
	// unsupported statement: Stmt_InlineHTML
}

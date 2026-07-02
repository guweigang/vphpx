import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subtotal'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_order_before_cart_contents'),
	])
	mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'get_cart', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cart_item := item_1.val
		mut var_cart_item_key := item_1.key
		mut var__product := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_item_product'),
			var_cart_item.array_get(rt.new_string('data')),
			var_cart_item.clone(),
			var_cart_item_key.clone(),
		])
		if rt.is_true(var__product)
			&& rt.is_true(rt.call_method(var__product, 'exists', []rt.PhpVal{}))
			&& rt.is_true(rt.greater(var_cart_item.array_get(rt.new_string('quantity')), rt.new_int(0)))
			&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_cart_item_visible'), rt.new_bool(true), var_cart_item.clone(), var_cart_item_key.clone()])) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_cart_item_class'),
					rt.new_string('cart_item'),
					var_cart_item.clone(),
					var_cart_item_key.clone(),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			print(
				(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_name'), rt.call_method(var__product, 'get_name', []rt.PhpVal{}), var_cart_item.clone(), var_cart_item_key.clone()])])).str() +
				'&nbsp;')
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_checkout_cart_item_quantity'),
				rt.new_string(' <strong class="product-quantity">' +
					(rt.call_function('sprintf', [rt.new_string('&times;&nbsp;%s'), var_cart_item.array_get(rt.new_string('quantity'))])).str() +
					'</strong>'),
				var_cart_item.clone(),
				var_cart_item_key.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_get_formatted_cart_item_data', [
				var_cart_item.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_item_subtotal'),
				rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
					'get_product_subtotal', [var__product.clone(),
					var_cart_item.array_get(rt.new_string('quantity'))]),
				var_cart_item.clone(),
				var_cart_item_key.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_order_after_cart_contents'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subtotal'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_cart_totals_subtotal_html', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'get_coupons', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_coupon := item_2.val
		mut var_code := item_2.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('sanitize_title', [var_code.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_cart_totals_coupon_label', [var_coupon.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_cart_totals_coupon_html', [var_coupon.clone()])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'show_shipping', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_review_order_before_shipping'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_cart_totals_shipping_html', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_review_order_after_shipping'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
		'get_fees', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_fee := item_3.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_fee, 'name')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_cart_totals_fee_html', [var_fee.clone()])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_prices_including_tax', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_total_display'),
		])))
		{
			// unsupported statement: Stmt_InlineHTML
			mut iter_4 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'get_tax_totals', []rt.PhpVal{}).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_tax := item_4.val
				mut var_code := item_4.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_function('sanitize_title', [var_code.clone()]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.get_property(var_tax, 'label'),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.get_property(var_tax, 'formatted_amount'),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
					'tax_or_vat', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_cart_totals_taxes_total_html', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_order_before_order_total'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_cart_totals_order_total_html', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_review_order_after_order_total'),
	])
	// unsupported statement: Stmt_InlineHTML
}

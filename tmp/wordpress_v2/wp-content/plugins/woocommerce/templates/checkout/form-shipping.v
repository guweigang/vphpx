import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_checkout := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_bool(true), rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'), 'needs_shipping_address', []rt.PhpVal{})))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_ship_to_different_address_checked'),
				rt.new_int(if rt.is_true(rt.identical(rt.new_string('shipping'), rt.call_function('get_option', [
					rt.new_string('woocommerce_ship_to_destination'),
				])))
				{ 1 } else { 0 }),
			]),
			rt.new_int(1),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Ship to a different address?'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_checkout_shipping_form'),
			var_checkout.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		mut var_fields := rt.call_method(var_checkout, 'get_checkout_fields', [
			rt.new_string('shipping'),
		])
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			rt.call_function('woocommerce_form_field', [var_key.clone(),
				var_field.clone(), rt.call_method(var_checkout, 'get_value', [
					var_key.clone()])])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_after_checkout_shipping_form'),
			var_checkout.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_order_notes'),
		var_checkout.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_enable_order_notes_field'),
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_enable_order_comments'),
			rt.new_string('yes'),
		])),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{})))))
			|| rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Additional information'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := rt.call_method(var_checkout, 'get_checkout_fields', [
			rt.new_string('order'),
		]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			mut var_key := item_2.key
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('woocommerce_form_field', [var_key.clone(),
				var_field.clone(), rt.call_method(var_checkout, 'get_value', [
					var_key.clone()])])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_order_notes'),
		var_checkout.clone()])
	// unsupported statement: Stmt_InlineHTML
}

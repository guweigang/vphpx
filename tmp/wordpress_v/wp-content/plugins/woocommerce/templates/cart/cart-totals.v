import rt



pub fn init_wp_content_plugins_woocommerce_templates_cart_cart_totals_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'has_calculated_shipping', []rt.PhpVal{})) { 'calculated_shipping' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart_totals')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cart totals'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Subtotal'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Subtotal'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_cart_totals_subtotal_html', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_coupons', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_coupon := item_1.val
			mut var_code := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('sanitize_title', [var_code.dup()])]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_cart_totals_coupon_label', [var_coupon.dup()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_cart_totals_coupon_label', [var_coupon.dup(), rt.new_bool(false)])]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_cart_totals_coupon_html', [var_coupon.dup()])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{})) && rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'show_shipping', []rt.PhpVal{})))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_cart_totals_before_shipping')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_cart_totals_shipping_html', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_cart_totals_after_shipping')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_shipping_calc')]))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_shipping_calculator', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_fees', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fee := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_fee, 'name')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_fee, 'name')]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_cart_totals_fee_html', [var_fee.dup()])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_prices_including_tax', []rt.PhpVal{}))))))) {
		mut var_taxable_address := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_taxable_address', []rt.PhpVal{})
		mut var_estimated_text := rt.new_string(rt.new_string(''))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'is_customer_outside_base', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'has_calculated_shipping', []rt.PhpVal{}))))))) {
			var_estimated_text = rt.call_function('sprintf', [' <small>' + (rt.call_function('esc_html__', [rt.new_string('(estimated for %s)'), rt.new_string('woocommerce')])).str() + '</small>', rt.concat(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'estimated_for_prefix', [var_taxable_address.array_get(0)]), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'countries').array_get(var_taxable_address.array_get(0)))])
		}
		if rt.is_true(rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_total_display')]))) {
			{
				mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_tax_totals', []rt.PhpVal{}).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_tax := item_1.val
					mut var_code := item_1.key
					// unsupported statement: Stmt_Nop
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.call_function('sanitize_title', [var_code.dup()])]))
					// unsupported statement: Stmt_InlineHTML
					print((rt.call_function('esc_html', [rt.get_property(var_tax, 'label')])).str() + (var_estimated_text).str())
					// unsupported statement: Stmt_Nop
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_tax, 'label')]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('wp_kses_post', [rt.get_property(var_tax, 'formatted_amount')]))
					// unsupported statement: Stmt_InlineHTML
				}
			}
		} else {
			// unsupported statement: Stmt_InlineHTML
			print((rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'tax_or_vat', []rt.PhpVal{})])).str() + (var_estimated_text).str())
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'tax_or_vat', []rt.PhpVal{})]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_cart_totals_taxes_total_html', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_totals_before_order_total')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Total'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_cart_totals_order_total_html', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_totals_after_order_total')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_proceed_to_checkout')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_cart_totals')])
	// unsupported statement: Stmt_InlineHTML
}

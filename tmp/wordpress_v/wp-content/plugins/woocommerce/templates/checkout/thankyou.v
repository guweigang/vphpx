import rt



pub fn init_wp_content_plugins_woocommerce_templates_checkout_thankyou_php() {
	mut var_order := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_order) {
		rt.call_function('do_action', [rt.new_string('woocommerce_before_thankyou'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_order, 'has_status', [rt.new_string('failed')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Unfortunately your order cannot be processed as the originating bank/merchant has declined your transaction. Please attempt your purchase again.'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Pay'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('My account'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_get_template', [rt.new_string('checkout/order-received.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }])])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Order number:'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Date:'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})]))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}), rt.call_function('get_current_user_id', []rt.PhpVal{}))))) && rt.is_true(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Email:'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Total:'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_method(var_order, 'get_formatted_order_total', []rt.PhpVal{}))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Payment method:'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{})]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', ['woocommerce_thankyou_' + (rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{})).str(), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_thankyou'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_get_template', [rt.new_string('checkout/order-received.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: false }])])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

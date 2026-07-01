import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_email_addresses_php() {
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	print('\n' + (rt.call_function('esc_html', [rt.call_function('wc_strtoupper', [rt.call_function('esc_html__', [rt.new_string('Billing address'), rt.new_string('woocommerce')])])])).str() + '\n\n')
	print((rt.call_function('preg_replace', [rt.new_string('#<br\\s*/?>#i'), rt.new_string('\n'), rt.call_method(var_order, 'get_formatted_billing_address', []rt.PhpVal{})])).str() + '\n')
	if rt.is_true(rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})) {
		print((rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})).str() + '\n')
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})) {
		print((rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})).str() + '\n')
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_address_section'), rt.new_string('billing'), var_order.dup(), var_sent_to_admin.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{}))))) && rt.is_true(rt.call_method(var_order, 'needs_shipping_address', []rt.PhpVal{})))) {
		mut var_shipping := rt.call_method(var_order, 'get_formatted_shipping_address', []rt.PhpVal{})
		if rt.is_true(var_shipping) {
			print('\n' + (rt.call_function('esc_html', [rt.call_function('wc_strtoupper', [rt.call_function('esc_html__', [rt.new_string('Shipping address'), rt.new_string('woocommerce')])])])).str() + '\n\n')
			print((rt.call_function('preg_replace', [rt.new_string('#<br\\s*/?>#i'), rt.new_string('\n'), var_shipping.dup()])).str() + '\n')
			if rt.is_true(rt.call_method(var_order, 'get_shipping_phone', []rt.PhpVal{})) {
				print((rt.call_method(var_order, 'get_shipping_phone', []rt.PhpVal{})).str() + '\n')
				// unsupported statement: Stmt_Nop
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_address_section'), rt.new_string('shipping'), var_order.dup(), var_sent_to_admin.dup(), rt.new_bool(true)])
		}
	}
}

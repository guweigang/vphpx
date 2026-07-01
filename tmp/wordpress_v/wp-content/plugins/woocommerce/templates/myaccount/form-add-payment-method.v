import rt



pub fn init_wp_content_plugins_woocommerce_templates_myaccount_form_add_payment_method_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	if rt.is_true(var_available_gateways) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_int(var_available_gateways.dup().array_count())) {
			rt.call_method(rt.call_function('current', [var_available_gateways.dup()]), 'set_current', []rt.PhpVal{})
		}
		{
			mut iter_1 := var_available_gateways.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_gateway := item_1.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('checked', [rt.get_property(var_gateway, 'chosen'), rt.new_bool(true)])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_method(var_gateway, 'get_title', []rt.PhpVal{})]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_method(var_gateway, 'get_icon', []rt.PhpVal{})]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_gateway, 'has_fields', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_gateway, 'get_description', []rt.PhpVal{})))) {
					print('<div class="woocommerce-PaymentBox woocommerce-PaymentBox--' + (rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')])).str() + ' payment_box payment_method_' + (rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')])).str() + '" style="display: none;">')
					rt.call_method(var_gateway, 'payment_fields', []rt.PhpVal{})
					print('</div>')
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_add_payment_method_form_bottom')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-add-payment-method'), rt.new_string('woocommerce-add-payment-method-nonce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Add payment method'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add payment method'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_print_notice', [rt.call_function('esc_html__', [rt.new_string('New payment methods can only be added during checkout. Please contact us if you require assistance.'), rt.new_string('woocommerce')]), rt.new_string('notice')])
	}
}

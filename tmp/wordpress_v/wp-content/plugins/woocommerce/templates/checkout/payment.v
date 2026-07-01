import rt



pub fn init_wp_content_plugins_woocommerce_templates_checkout_payment_php() {
	mut var_available_gateways := rt.new_null()
	mut var_order_button_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_review_order_before_payment')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')) && rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_payment', []rt.PhpVal{})))) {
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_available_gateways)) {
			{
				mut iter_1 := var_available_gateways.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_gateway := item_1.val
					rt.call_function('wc_get_template', [rt.new_string('checkout/payment-method.php'), rt.create_array([rt.ArrayItem{ key: 'gateway', val: var_gateway }])])
				}
			}
		} else {
			print('<li>')
			rt.call_function('wc_print_notice', [rt.call_function('apply_filters', [rt.new_string('woocommerce_no_available_payment_methods_message'), if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_billing_country', []rt.PhpVal{})) { rt.call_function('esc_html__', [rt.new_string('Sorry, it seems that there are no available payment methods. Please contact us if you require assistance or wish to make alternate arrangements.'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_html__', [rt.new_string('Please fill in your details above to see available payment methods.'), rt.new_string('woocommerce')]) }]), rt.new_string('notice')])
			print('</li>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Since your browser does not support JavaScript, or it is disabled, please ensure you click the %1$sUpdate Totals%2$s button before placing your order. You may be charged more than the amount stated above if you fail to do so.'), rt.new_string('woocommerce')]), rt.new_string('<em>'), rt.new_string('</em>')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update totals'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update totals'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_get_template', [rt.new_string('checkout/terms.php')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_review_order_before_submit')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_button_html'), '<button type="submit" class="button alt' + (rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }])).str() + '" name="woocommerce_checkout_place_order" id="place_order" value="' + (rt.call_function('esc_attr', [var_order_button_text.dup()])).str() + '" data-value="' + (rt.call_function('esc_attr', [var_order_button_text.dup()])).str() + '">' + (rt.call_function('esc_html', [var_order_button_text.dup()])).str() + '</button>']))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_review_order_after_submit')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-process_checkout'), rt.new_string('woocommerce-process-checkout-nonce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_review_order_after_payment')])
	}
}

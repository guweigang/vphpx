import rt



pub fn init_wp_content_plugins_woocommerce_templates_cart_shipping_calculator_php() {
	mut var_button_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_shipping_calculator')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="#" class="shipping-calculator-button" aria-expanded="false" aria-controls="shipping-calculator-form" role="button">%s</a>'), rt.call_function('esc_html', [if !(!rt.is_true(var_button_text)) { var_button_text } else { rt.call_function('__', [rt.new_string('Calculate shipping'), rt.new_string('woocommerce')]) }])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_calculator_enable_country'), rt.new_bool(true)])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Country / region'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Select a country / region&hellip;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '"' + (rt.call_function('selected', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_shipping_country', []rt.PhpVal{}), rt.call_function('esc_attr', [var_key.dup()]), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [var_value.dup()])).str() + '</option>')
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_calculator_enable_state'), rt.new_bool(true)])) {
		// unsupported statement: Stmt_InlineHTML
		mut var_current_cc := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_shipping_country', []rt.PhpVal{})
		mut var_current_r := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_shipping_state', []rt.PhpVal{})
		mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', [var_current_cc.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_states.dup().is_array())) && !rt.is_true(var_states))) {
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.new_bool(var_states.dup().is_array())) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('State / County'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Select an option&hellip;'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			{
				mut iter_1 := var_states.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_cvalue := item_1.val
					mut var_ckey := item_1.key
					print('<option value="' + (rt.call_function('esc_attr', [var_ckey.dup()])).str() + '" ' + (rt.call_function('selected', [var_current_r.dup(), var_ckey.dup(), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [var_cvalue.dup()])).str() + '</option>')
				}
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('State / County'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_current_r.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_calculator_enable_city'), rt.new_bool(true)])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('City:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_shipping_city', []rt.PhpVal{})]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_calculator_enable_postcode'), rt.new_bool(true)])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Postcode / ZIP:'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_shipping_postcode', []rt.PhpVal{})]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-shipping-calculator'), rt.new_string('woocommerce-shipping-calculator-nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_shipping_calculator')])
}

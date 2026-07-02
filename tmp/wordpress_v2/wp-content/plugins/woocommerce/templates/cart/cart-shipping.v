import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_package := rt.new_null()
	mut var_package_name := rt.new_null()
	mut var_available_methods := rt.new_null()
	mut var_index := rt.new_null()
	mut var_chosen_method := rt.new_null()
	mut var_show_package_details := rt.new_null()
	mut var_package_details := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	mut var_formatted_destination := if !(var_formatted_destination).is_null() { var_formatted_destination } else { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [var_package.array_get(rt.new_string('destination')), rt.new_string(', ')]) }
	mut var_has_calculated_shipping := !(!(var_has_calculated_shipping))
	mut var_show_shipping_calculator := !(!(var_show_shipping_calculator))
	mut var_calculator_text := rt.new_string('')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_package_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_package_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_available_methods)) && var_available_methods.clone().is_array() {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_available_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			// unsupported statement: Stmt_InlineHTML
			if 1 < var_available_methods.clone().array_count() {
				rt.call_function('printf', [rt.new_string('<input type="radio" name="shipping_method[%1$d]" data-index="%1$d" id="shipping_method_%1$d_%2$s" value="%3$s" class="shipping_method" %4$s />'), var_index.clone(), rt.call_function('esc_attr', [rt.call_function('sanitize_title', [rt.get_property(var_method, 'id')])]), rt.call_function('esc_attr', [rt.get_property(var_method, 'id')]), rt.call_function('checked', [rt.get_property(var_method, 'id'), var_chosen_method.clone(), rt.new_bool(false)])])
			} else {
				rt.call_function('printf', [rt.new_string('<input type="hidden" name="shipping_method[%1$d]" data-index="%1$d" id="shipping_method_%1$d_%2$s" value="%3$s" class="shipping_method" />'), var_index.clone(), rt.call_function('esc_attr', [rt.call_function('sanitize_title', [rt.get_property(var_method, 'id')])]), rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])])
			}
			rt.call_function('printf', [rt.new_string('<label for="shipping_method_%1$s_%2$s">%3$s</label>'), var_index.clone(), rt.call_function('esc_attr', [rt.call_function('sanitize_title', [rt.get_property(var_method, 'id')])]), rt.call_function('wc_cart_totals_shipping_method_label', [var_method.clone()])])
			rt.call_function('do_action', [rt.new_string('woocommerce_after_shipping_rate'), var_method.clone(), var_index.clone()])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_formatted_destination) {
				rt.call_function('printf', [rt.new_string((rt.call_function('esc_html__', [rt.new_string('Shipping to %s.'), rt.new_string('woocommerce')])).str() + ' '), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_formatted_destination.clone()])).str() + '</strong>')])
			var_calculator_text = rt.call_function('esc_html__', [rt.new_string('Change address'), rt.new_string('woocommerce')])
			} else {
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_estimate_html'), rt.call_function('__', [rt.new_string('Shipping options will be updated during checkout.'), rt.new_string('woocommerce')])])]))
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if !(var_has_calculated_shipping) || rt.is_true(rt.new_bool(!(rt.is_true(var_formatted_destination)))) {
		if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_shipping_calc')]))) {
			rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_not_enabled_on_cart_html'), rt.call_function('__', [rt.new_string('Shipping costs are calculated during checkout.'), rt.new_string('woocommerce')])])]))
		} else {
			rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_may_be_available_html'), rt.call_function('__', [rt.new_string('Enter your address to view shipping options.'), rt.new_string('woocommerce')])])]))
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))))) {
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_no_shipping_available_html'), rt.call_function('__', [rt.new_string('There are no shipping options available. Please ensure that your address has been entered correctly, or contact us if you need any help.'), rt.new_string('woocommerce')])])]))
	} else {
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_no_shipping_available_html'), rt.call_function('sprintf', [rt.new_string((rt.call_function('esc_html__', [rt.new_string('No shipping options were found for %s.'), rt.new_string('woocommerce')])).str() + ' '), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_formatted_destination.clone()])).str() + '</strong>')]), var_formatted_destination.clone()])]))
	var_calculator_text = rt.call_function('esc_html__', [rt.new_string('Enter a different address'), rt.new_string('woocommerce')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_show_package_details) {
		// unsupported statement: Stmt_InlineHTML
		print('<p class="woocommerce-shipping-contents"><small>' + (rt.call_function('esc_html', [var_package_details.clone()])).str() + '</small></p>')
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_show_shipping_calculator {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_shipping_calculator', [var_calculator_text.clone()])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

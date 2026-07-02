import rt
import crypto.md5

fn wc_protected_product_add_to_cart(var_passed_arg rt.PhpVal, var_product_id rt.PhpVal) bool {
	mut var_passed := var_passed_arg
	if rt.is_true(rt.call_function('post_password_required', [var_product_id.clone()])) {
		var_passed = false
		rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('This product is protected and cannot be purchased.'), rt.new_string('woocommerce')]), rt.new_string('error')])
	}
	return var_passed
}

fn wc_empty_cart() {
	if !(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null()) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'))) {
		rt.set_property(rt.call_function('WC', []rt.PhpVal{}), 'cart', create_wc_cart())
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart', [rt.new_bool(false)])
}

fn wc_get_raw_referer() bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_raw_referer')])) {
		return (rt.call_function('wp_get_raw_referer', []rt.PhpVal{})).to_bool()
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')))) {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer'))])).to_bool()
	} else if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')))) {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER'))])).to_bool()
	}
	return false
}

fn wc_add_to_cart_message(var_products_arg rt.PhpVal, show_qty bool, return bool) rt.PhpVal {
	mut var_show_qty := show_qty
	mut var_return := return
	mut var_products := var_products_arg
	mut var_titles := rt.new_null()
	mut var_count := i64(0)
	mut var_product_id := rt.new_null()
	mut var_qty := rt.new_null()
	mut var_title := rt.new_null()
	mut var_added_text := rt.new_null()
	mut var_wp_button_class := rt.new_null()
	mut var_return_to := rt.new_null()
	mut var_message := rt.new_null()
	var_titles = rt.new_array()
	var_count = 0
	if !(var_products.clone().is_array()) {
	var_products = rt.create_array([rt.ArrayItem{ key: var_products, val: 1 }])
	var_show_qty = false
	}
	if !(var_show_qty) {
	var_products = rt.call_function('array_fill_keys', [rt.func_array_keys(var_products.clone()), rt.new_int(1)])
	}
	var_product_id = rt.new_null()
	mut iter_1 := var_products.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_qty_shadow := item_1.val
		mut var_product_id_shadow := item_1.key
		var_title = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_qty_html'), rt.new_string((if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_qty_shadow)))) { (rt.call_function('wc_stock_amount', [var_qty_shadow.clone()])).str() + ' &times; ' } else { '' }).str()), var_product_id_shadow.clone()])
		var_title = rt.concat(var_title, rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_item_name_in_quotes'), rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('&ldquo;%s&rdquo;'), rt.new_string('Item name in quotes'), rt.new_string('woocommerce')]), rt.call_function('wp_strip_all_tags', [rt.call_function('get_the_title', [var_product_id_shadow.clone()])])]), var_product_id_shadow.clone()]))
		var_titles.array_push(var_title.clone())
		var_count = var_count + (var_qty_shadow).to_i64()
	}
	var_titles = rt.call_function('array_filter', [var_titles.clone()])
	var_added_text = rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s has been added to your cart.'), rt.new_string('%s have been added to your cart.'), rt.new_int(var_count).clone(), rt.new_string('woocommerce')]), rt.new_string(wc_format_list_of_items(var_titles.clone()))])
	var_wp_button_class = rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { '' }).str())
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_cart_redirect_after_add')]))) {
	var_return_to = rt.call_function('apply_filters', [rt.new_string('woocommerce_continue_shopping_redirect'), if wc_get_raw_referer() { rt.call_function('wp_validate_redirect', [rt.new_bool(wc_get_raw_referer()), rt.new_bool(false)]) } else { rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]) }])
	var_message = rt.call_function('sprintf', [rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'), rt.call_function('esc_html', [var_added_text.clone()]), rt.call_function('esc_url', [var_return_to.clone()]), rt.call_function('esc_attr', [var_wp_button_class.clone()]), rt.call_function('esc_html__', [rt.new_string('Continue shopping'), rt.new_string('woocommerce')])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_0 := iife_temp_0.has_cart_page()
	} else if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
	var_message = rt.call_function('sprintf', [rt.new_string('%s'), rt.call_function('esc_html', [var_added_text.clone()])])
	} else {
	var_message = rt.call_function('sprintf', [rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'), rt.call_function('esc_html', [var_added_text.clone()]), rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})]), rt.call_function('esc_attr', [var_wp_button_class.clone()]), rt.call_function('esc_html__', [rt.new_string('View cart'), rt.new_string('woocommerce')])])
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('wc_add_to_cart_message')])) {
		rt.call_function('wc_deprecated_function', [rt.new_string('The wc_add_to_cart_message filter'), rt.new_string('3.0'), rt.new_string('wc_add_to_cart_message_html')])
	var_message = rt.call_function('apply_filters', [rt.new_string('wc_add_to_cart_message'), var_message.clone(), var_product_id.clone()])
	}
	var_message = rt.call_function('apply_filters', [rt.new_string('wc_add_to_cart_message_html'), var_message.clone(), var_products.clone(), rt.new_bool(var_show_qty)])
	if var_return {
		return var_message.clone()
	} else {
		rt.call_function('wc_add_notice', [var_message.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_notice_type'), rt.new_string('success')])])
	}
	return rt.new_null()
}

fn wc_format_list_of_items(var_items rt.PhpVal) string {
	mut var_item_string := ''
	mut var_item := rt.new_null()
	mut var_key := rt.new_null()
	var_item_string = ''
	mut iter_2 := var_items.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item_shadow := item_2.val
		mut var_key_shadow := item_2.key
		var_item_string = var_item_string + (var_item_shadow).str()
		if rt.is_true(rt.identical(rt.new_int(var_items.clone().array_count()), rt.add(var_key_shadow, rt.new_int(2)))) {
			var_item_string = var_item_string + ' ' + (rt.call_function('__', [rt.new_string('and'), rt.new_string('woocommerce')])).str() + ' '
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_items.clone().array_count()), rt.add(var_key_shadow, rt.new_int(1)))))) {
			var_item_string = var_item_string + ', '
		}
	}
	return var_item_string
}

fn wc_clear_cart_after_payment() {
	mut var_wp := rt.new_null()
	mut var_should_clear_cart_after_payment := rt.new_null()
	mut var_after_payment := false
	mut var_order_id := rt.new_null()
	mut var_order_key := rt.new_null()
	mut var_order := rt.new_null()
	var_should_clear_cart_after_payment = rt.new_bool(false)
	var_after_payment = false
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-received')))) {
		var_order_id = rt.call_function('absint', [rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-received'))])
		var_order_key = if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('key'))])]) } else { rt.new_string('') }
		if rt.is_true(rt.greater(var_order_id, rt.new_int(0))) {
			var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) && rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()])) {
			var_should_clear_cart_after_payment = rt.new_bool(true)
			var_after_payment = true
			}
		}
	}
	if rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session').is_object() && rt.is_true(rt.greater(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'order_awaiting_payment'), rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_clear_cart_after_payment)))) {
		var_order = rt.call_function('wc_get_order', [rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'order_awaiting_payment')])
		if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) && rt.is_true(rt.greater(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.new_int(0))) {
		var_should_clear_cart_after_payment = rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() }])]))))
		var_after_payment = true
		}
	}
	if !(var_after_payment) {
		return
	}
	var_should_clear_cart_after_payment = rt.call_function('apply_filters', [rt.new_string('woocommerce_should_clear_cart_after_payment'), var_should_clear_cart_after_payment.clone()])
	if rt.is_true(var_should_clear_cart_after_payment) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart', []rt.PhpVal{})
	}
}

fn wc_cart_totals_subtotal_html() {
	rt.echo_val(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_subtotal', []rt.PhpVal{}))
}

fn wc_cart_totals_shipping_html() {
	mut var_packages := rt.new_null()
	mut var_first := false
	mut var_package := map[string]rt.PhpVal{}
	mut var_i := rt.new_null()
	mut var_chosen_method := rt.new_null()
	mut var_product_names := rt.new_null()
	mut var_values := map[string]rt.PhpVal{}
	mut var_item_id := rt.new_null()
	var_packages = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
	var_first = true
	mut iter_3 := var_packages.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_package_shadow := item_3.val
		mut var_i_shadow := item_3.key
		var_chosen_method = if rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'chosen_shipping_methods').array_isset(var_i_shadow) { rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'chosen_shipping_methods').array_get(var_i_shadow) } else { rt.new_string('') }
		var_product_names = rt.new_array()
		if var_packages.clone().array_count() > 1 {
			mut iter_4 := var_package_shadow['contents'].iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_values_shadow := item_4.val
				mut var_item_id_shadow := item_4.key
				var_product_names.array_set(var_item_id_shadow, (rt.call_method(var_values_shadow['data'], 'get_name', []rt.PhpVal{})).str() + ' &times;' + (var_values_shadow['quantity']).str())
			}
		var_product_names = rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_package_details_array'), var_product_names.clone(), var_package_shadow.clone()])
		}
		rt.call_function('wc_get_template', [rt.new_string('cart/cart-shipping.php'), rt.create_array([rt.ArrayItem{ key: 'package', val: var_package_shadow }, rt.ArrayItem{ key: 'available_methods', val: var_package_shadow['rates'] }, rt.ArrayItem{ key: 'show_package_details', val: rt.new_bool(var_packages.clone().array_count() > 1) }, rt.ArrayItem{ key: 'show_shipping_calculator', val: rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_show_shipping_calculator'), rt.new_bool(var_first).clone(), var_i_shadow.clone(), var_package_shadow.clone()])) }, rt.ArrayItem{ key: 'package_details', val: rt.call_function('implode', [rt.new_string(', '), var_product_names.clone()]) }, rt.ArrayItem{ key: 'package_name', val: var_package_shadow['package_name'] }, rt.ArrayItem{ key: 'index', val: var_i_shadow }, rt.ArrayItem{ key: 'chosen_method', val: var_chosen_method }, rt.ArrayItem{ key: 'formatted_destination', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [var_package_shadow['destination'], rt.new_string(', ')]) }, rt.ArrayItem{ key: 'has_calculated_shipping', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'has_calculated_shipping', []rt.PhpVal{}) }])])
	var_first = false
	}
}

fn wc_cart_totals_taxes_total_html() {
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_taxes_total_html'), rt.call_function('wc_price', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_taxes_total', []rt.PhpVal{})])]))
}

fn wc_cart_totals_coupon_label(var_coupon_arg rt.PhpVal, echo bool) rt.PhpVal {
	mut var_echo := echo
	mut var_coupon := var_coupon_arg
	mut var_label := rt.new_null()
	if rt.is_true(rt.new_bool(var_coupon.is_string())) {
	var_coupon = create_wc_coupon(var_coupon)
	}
	var_label = rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_coupon_label'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Coupon: %s'), rt.new_string('woocommerce')]), var_coupon.get_code()]), var_coupon])
	if var_echo {
		rt.echo_val(var_label)
	} else {
		return var_label.clone()
	}
	return rt.new_null()
}

fn wc_cart_totals_coupon_html(var_coupon_arg rt.PhpVal) {
	mut var_coupon := var_coupon_arg
	mut var_amount := rt.new_null()
	mut var_discount_amount_html := rt.new_null()
	mut var_coupon_html := rt.new_null()
	if rt.is_true(rt.new_bool(var_coupon.is_string())) {
	var_coupon = create_wc_coupon(var_coupon)
	}
	var_amount = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_coupon_discount_amount', [var_coupon.get_code(), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_cart_ex_tax')])
	var_discount_amount_html = rt.new_string('-' + (rt.call_function('wc_price', [var_amount.clone()])).str())
	if rt.is_true(var_coupon.get_free_shipping()) && !rt.is_true(var_amount) {
	var_discount_amount_html = rt.call_function('__', [rt.new_string('Free shipping coupon'), rt.new_string('woocommerce')])
	}
	var_discount_amount_html = rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_discount_amount_html'), var_discount_amount_html.clone(), var_coupon])
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.is_defined(rt.new_string('WOOCOMMERCE_CHECKOUT'))
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.is_defined(rt.new_string('WOOCOMMERCE_CHECKOUT'))
	var_coupon_html = rt.new_string((var_discount_amount_html).str() + ' <a role="button" aria-label="' + (rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Remove %s coupon'), rt.new_string('woocommerce')]), var_coupon.get_code()])])).str() + '" href="' + (rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('remove_coupon'), rt.call_function('rawurlencode', [var_coupon.get_code()]), if rt.is_true(iife_result_1) { rt.call_function('wc_get_checkout_url', []rt.PhpVal{}) } else { rt.call_function('wc_get_cart_url', []rt.PhpVal{}) }])])).str() + '" class="woocommerce-remove-coupon" data-coupon="' + (rt.call_function('esc_attr', [var_coupon.get_code()])).str() + '">' + (rt.call_function('__', [rt.new_string('[Remove]'), rt.new_string('woocommerce')])).str() + '</a>')
	rt.echo_val(rt.call_function('wp_kses', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_coupon_html'), var_coupon_html.clone(), var_coupon, var_discount_amount_html.clone()]), rt.call_function('array_replace_recursive', [rt.call_function('wp_kses_allowed_html', [rt.new_string('post')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'data-coupon', val: true }]) }])])]))
}

fn wc_cart_totals_order_total_html() {
	mut var_value := rt.new_null()
	mut var_tax_string_array := []rt.PhpVal{}
	mut var_cart_tax_totals := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_code := rt.new_null()
	mut var_taxable_address := rt.new_null()
	mut var_country := rt.new_null()
	mut var_tax_text := rt.new_null()
	var_value = rt.new_string('<strong>' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_total', []rt.PhpVal{})).str() + '</strong> ')
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_prices_including_tax', []rt.PhpVal{})) {
		var_tax_string_array = rt.new_array()
		var_cart_tax_totals = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_tax_totals', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_tax_total_display')]), rt.new_string('itemized'))) {
			mut iter_5 := var_cart_tax_totals.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_tax_shadow := item_5.val
				mut var_code_shadow := item_5.key
				var_tax_string_array << rt.call_function('sprintf', [rt.new_string('%s %s'), rt.get_property(var_tax_shadow, 'formatted_amount'), rt.get_property(var_tax_shadow, 'label')])
			}
		} else if !(!rt.is_true(var_cart_tax_totals)) {
			var_tax_string_array << rt.call_function('sprintf', [rt.new_string('%s %s'), rt.call_function('wc_price', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_taxes_total', [rt.new_bool(true), rt.new_bool(true)])]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'tax_or_vat', []rt.PhpVal{})])
		}
		if !(!rt.is_true(var_tax_string_array)) {
			var_taxable_address = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_taxable_address', []rt.PhpVal{})
			if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'is_customer_outside_base', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'has_calculated_shipping', []rt.PhpVal{}))))) {
			var_country = rt.new_string((rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'estimated_for_prefix', [var_taxable_address.array_get(rt.new_int(0))])).str() + (rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'countries').array_get(var_taxable_address.array_get(rt.new_int(0)))).str())
			var_tax_text = rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(includes %1$s estimated for %2$s)'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_tax_string_array)]), var_country.clone()])])
			} else {
			var_tax_text = rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('(includes %s)'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_tax_string_array)])])])
			}
			var_value = rt.concat(var_value, rt.new_string('<small class="includes_tax">' + (var_tax_text).str() + '</small>'))
		}
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_order_total_html'), var_value.clone()]))
}

fn wc_cart_totals_fee_html(var_fee rt.PhpVal) {
	mut var_cart_totals_fee_html := rt.new_null()
	var_cart_totals_fee_html = if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_prices_including_tax', []rt.PhpVal{})) { rt.call_function('wc_price', [rt.add(rt.get_property(var_fee, 'total'), rt.get_property(var_fee, 'tax'))]) } else { rt.call_function('wc_price', [rt.get_property(var_fee, 'total')]) }
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_fee_html'), var_cart_totals_fee_html.clone(), var_fee.clone()]))
}

fn wc_cart_totals_shipping_method_label(var_method rt.PhpVal) rt.PhpVal {
	mut var_label := rt.new_null()
	mut var_has_cost := false
	mut var_hide_cost := false
	var_label = rt.call_method(var_method, 'get_label', []rt.PhpVal{})
	var_has_cost = (rt.less(rt.new_int(0), rt.get_property(var_method, 'cost'))).to_bool()
	var_hide_cost = !(var_has_cost) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_method, 'get_method_id', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'free_shipping' }, rt.ArrayItem{ key: none, val: 'local_pickup' }]), rt.new_bool(true)]))
	if var_has_cost && !(var_hide_cost) {
		if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_prices_including_tax', []rt.PhpVal{})) {
			var_label = rt.concat(var_label, rt.new_string(': ' + (rt.call_function('wc_price', [rt.add(rt.get_property(var_method, 'cost'), rt.call_method(var_method, 'get_shipping_tax', []rt.PhpVal{}))])).str()))
			if rt.is_true(rt.greater(rt.call_method(var_method, 'get_shipping_tax', []rt.PhpVal{}), rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))))) {
				var_label = rt.concat(var_label, rt.new_string(' <small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})).str() + '</small>'))
			}
		} else {
			var_label = rt.concat(var_label, rt.new_string(': ' + (rt.call_function('wc_price', [rt.get_property(var_method, 'cost')])).str()))
			if rt.is_true(rt.greater(rt.call_method(var_method, 'get_shipping_tax', []rt.PhpVal{}), rt.new_int(0))) && rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
				var_label = rt.concat(var_label, rt.new_string(' <small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() + '</small>'))
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_shipping_method_full_label'), var_label.clone(), var_method.clone()])
}

fn wc_cart_round_discount(var_value rt.PhpVal, var_precision rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_round_discount', [var_value.clone(), var_precision.clone()])
}

fn wc_get_chosen_shipping_method_ids() rt.PhpVal {
	mut var_chosen_methods := rt.new_null()
	mut var_method_ids := []rt.PhpVal{}
	mut var_chosen_method := rt.new_null()
	if !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session') }, rt.ArrayItem{ key: none, val: 'get' }])])) {
		return rt.new_array()
	}
	var_chosen_methods = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])
	var_method_ids = rt.new_array()
	mut iter_6 := var_chosen_methods.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_chosen_method_shadow := item_6.val
		if !(var_chosen_method_shadow.clone().is_string()) {
			continue
		}
		var_chosen_method_shadow = rt.call_function('explode', [rt.new_string(':'), var_chosen_method_shadow.clone()])
		var_method_ids << rt.call_function('current', [var_chosen_method_shadow.clone()])
	}
	return var_method_ids.clone()
}

fn wc_get_chosen_shipping_method_for_package(var_key rt.PhpVal, var_package rt.PhpVal) bool {
	mut var_chosen_methods := rt.new_null()
	mut var_chosen_method := rt.new_null()
	mut var_changed := rt.new_null()
	mut var_method_counts := rt.new_null()
	mut var_method_count := rt.new_null()
	if !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session') }, rt.ArrayItem{ key: none, val: 'get' }])])) {
		return false
	}
	var_chosen_methods = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])
	var_chosen_method = if var_chosen_methods.array_isset(var_key) { var_chosen_methods.array_get(var_key) } else { rt.new_bool(false) }
	var_changed = rt.new_bool(wc_shipping_methods_have_changed(var_key.clone(), rt.create_array_from_native_map(var_package)))
	var_method_counts = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('shipping_method_counts')])
	if !(!rt.is_true(var_method_counts.array_get(var_key))) {
	var_method_count = rt.call_function('absint', [var_method_counts.array_get(var_key)])
	} else {
	var_method_count = rt.new_int(0)
	}
	if !(var_package.array_isset(rt.new_string('rates'))) || !(var_package['rates'].is_array()) {
		var_package['rates'] = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_chosen_method)))) || rt.is_true(var_changed) || !(var_package['rates'].array_isset(var_chosen_method)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_package['rates'].array_count()), var_method_count)))) {
		var_chosen_method = rt.new_string(wc_get_default_shipping_method_for_package(var_key.clone(), rt.create_array_from_native_map(var_package), var_chosen_method.clone()))
		var_chosen_methods.array_set(var_key, var_chosen_method.clone())
		var_method_counts.array_set(var_key, var_package['rates'].array_count())
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('chosen_shipping_methods'), var_chosen_methods.clone()])
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('shipping_method_counts'), var_method_counts.clone()])
		rt.call_function('do_action', [rt.new_string('woocommerce_shipping_method_chosen'), var_chosen_method.clone()])
	}
	return (var_chosen_method).to_bool()
}

fn wc_get_default_shipping_method_for_package(var_key rt.PhpVal, var_package rt.PhpVal, var_chosen_method rt.PhpVal) string {
	mut var_rate_keys := rt.new_null()
	mut var_local_pickup_method_ids := rt.new_null()
	mut var_default := rt.new_null()
	mut var_rate_key := rt.new_null()
	mut var_rate_method_id := rt.new_null()
	mut var_chosen_method_id := rt.new_null()
	mut var_chosen_method_exists := rt.new_null()
	mut var_is_local_pickup_chosen := rt.new_null()
	mut var_coupons := rt.new_null()
	mut var_coupon := rt.new_null()
	var_rate_keys = rt.func_array_keys(var_package['rates'])
	mut iife_temp_3 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_3 := iife_temp_3.get_local_pickup_method_ids()
	var_local_pickup_method_ids = iife_result_3
	if rt.is_true(rt.identical(rt.new_string('shortcode'), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'cart_context'))) {
	var_default = rt.call_function('current', [var_rate_keys.clone()])
	} else {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
		mut iife_result_4 := iife_temp_4.shipping_methods_exist()
		var_default = if rt.is_true(iife_result_4) { rt.new_string('') } else { rt.call_function('current', [var_rate_keys.clone()]) }
		mut iter_7 := var_rate_keys.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_rate_key_shadow := item_7.val
			var_rate_method_id = rt.call_function('current', [rt.call_function('explode', [rt.new_string(':'), var_rate_key_shadow.clone()])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_rate_method_id.clone(), var_local_pickup_method_ids.clone(), rt.new_bool(true)]))))) {
				var_default = var_rate_key_shadow
				break
			}
		}
	}
	var_chosen_method_id = rt.call_function('current', [rt.call_function('explode', [rt.new_string(':'), var_chosen_method.clone()])])
	var_chosen_method_exists = rt.call_function('in_array', [var_chosen_method.clone(), var_rate_keys.clone(), rt.new_bool(true)])
	var_is_local_pickup_chosen = rt.call_function('in_array', [var_chosen_method_id.clone(), var_local_pickup_method_ids.clone(), rt.new_bool(true)])
	if rt.is_true(var_chosen_method_exists) && rt.is_true(var_is_local_pickup_chosen) {
	var_default = var_chosen_method.clone()
	} else {
		var_coupons = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_coupons', []rt.PhpVal{})
		mut iter_8 := var_coupons.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_coupon_shadow := item_8.val
			if rt.is_true(var_coupon_shadow.get_free_shipping()) {
				mut iter_9 := var_rate_keys.iterator()
				for {
					item_9 := iter_9.next() or { break }
					mut var_rate_key_shadow := item_9.val
					if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_rate_key_shadow.clone(), rt.new_string('free_shipping')]))) {
						var_default = var_rate_key_shadow
						break
					}
				}
				break
			}
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_chosen_method'), var_default.clone(), var_package['rates'], var_chosen_method.clone()])).str()
}

fn wc_shipping_methods_have_changed(var_key rt.PhpVal, var_package rt.PhpVal) bool {
	mut var_previous_shipping_methods := rt.new_null()
	mut var_new_rates := rt.new_null()
	mut var_prev_rates := rt.new_null()
	if !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session') }, rt.ArrayItem{ key: none, val: 'get' }])])) {
		return false
	}
	var_previous_shipping_methods = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('previous_shipping_methods')])
	var_new_rates = rt.func_array_keys(var_package['rates'])
	var_prev_rates = if var_previous_shipping_methods.array_isset(var_key) { var_previous_shipping_methods.array_get(var_key) } else { rt.new_bool(false) }
	var_previous_shipping_methods.array_set(var_key, var_new_rates.clone())
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('previous_shipping_methods'), var_previous_shipping_methods.clone()])
	return rt.new_bool(!rt.is_true(rt.identical(var_new_rates, var_prev_rates)))
}

fn wc_get_cart_item_data_hash(var_product rt.PhpVal) string {
	return md5.hexhash(rt.call_function('wp_json_encode', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_data_to_validate'), rt.create_array([rt.ArrayItem{ key: 'type', val: rt.call_method(var_product, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'attributes', val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) { rt.call_method(var_product, 'get_variation_attributes', []rt.PhpVal{}) } else { rt.new_string('') } }]), var_product.clone()])]).to_string())
}

struct Class_WC_Cart {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

fn create_wc_cart(_args ...rt.PhpVal) &Class_WC_Cart {
	mut obj := &Class_WC_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.call_function('add_filter', [rt.new_string('woocommerce_add_to_cart_validation'), rt.new_string('wc_protected_product_add_to_cart'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_clear_cart_after_payment'), rt.new_int(20)])
}

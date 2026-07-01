import rt

fn wc_protected_product_add_to_cart(var_passed rt.PhpVal, var_product_id rt.PhpVal) bool {
	if rt.is_true(rt.call_function('post_password_required', [var_product_id.dup()])) {
		var_passed = false
		rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('This product is protected and cannot be purchased.'), rt.new_string('woocommerce')]), rt.new_string('error')])
	}
	return var_passed
}

fn wc_empty_cart() {
	if rt.is_true(rt.new_bool(!(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null()) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'))))) {
		rt.set_property(rt.call_function('WC', []rt.PhpVal{}), 'cart', create_wc_cart())
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart', [rt.new_bool(false)])
}

fn wc_get_raw_referer() bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_raw_referer')])) {
		return (rt.call_function('wp_get_raw_referer', []rt.PhpVal{})).to_bool()
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wp_http_referer'))) {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('_wp_http_referer')])).to_bool()
		// unsupported statement: Stmt_Nop
	} else if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('HTTP_REFERER'))) {
		return (rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_REFERER')])).to_bool()
		// unsupported statement: Stmt_Nop
	}
	return false
}

fn wc_add_to_cart_message(var_products rt.PhpVal, show_qty bool, return bool) rt.PhpVal {
	mut var_titles := rt.new_array()
	mut var_count := 0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_products.dup().is_array()))))) {
		var_products = rt.create_array([rt.ArrayItem{ key: var_products, val: 1 }])
		show_qty = false
	}
	if !(var_show_qty) {
		var_products = rt.call_function('array_fill_keys', [rt.func_array_keys(var_products.dup()), rt.new_int(1)])
	}
	mut var_product_id := rt.new_null()
	{
		mut iter_1 := var_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_qty := item_1.val
			mut var_product_id_shadow := item_1.key
			mut var_title := rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_qty_html'), if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { (rt.call_function('wc_stock_amount', [var_qty.dup()])).str() + ' &times; ' } else { rt.new_string('') }, var_product_id_shadow.dup()])
			// unsupported expression: Expr_AssignOp_Concat
			var_titles.array_push(var_title.dup())
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	var_titles = rt.call_function('array_filter', [var_titles.dup()])
	mut var_added_text := rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s has been added to your cart.'), rt.new_string('%s have been added to your cart.'), rt.new_int(var_count).dup(), rt.new_string('woocommerce')]), rt.new_string(wc_format_list_of_items(var_titles.dup()))])
	mut var_wp_button_class := rt.new_string(if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') })
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_cart_redirect_after_add')]))) {
		mut var_return_to := rt.call_function('apply_filters', [rt.new_string('woocommerce_continue_shopping_redirect'), if wc_get_raw_referer() { rt.call_function('wp_validate_redirect', [rt.new_bool(wc_get_raw_referer()), rt.new_bool(false)]) } else { rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]) }])
		mut var_message := rt.call_function('sprintf', [rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'), rt.call_function('esc_html', [var_added_text.dup()]), rt.call_function('esc_url', [var_return_to.dup()]), rt.call_function('esc_attr', [var_wp_button_class.dup()]), rt.call_function('esc_html__', [rt.new_string('Continue shopping'), rt.new_string('woocommerce')])])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.has_cart_page() }())))) {
		var_message = rt.call_function('sprintf', [rt.new_string('%s'), rt.call_function('esc_html', [var_added_text.dup()])])
	} else {
		var_message = rt.call_function('sprintf', [rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'), rt.call_function('esc_html', [var_added_text.dup()]), rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})]), rt.call_function('esc_attr', [var_wp_button_class.dup()]), rt.call_function('esc_html__', [rt.new_string('View cart'), rt.new_string('woocommerce')])])
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('wc_add_to_cart_message')])) {
		rt.call_function('wc_deprecated_function', [rt.new_string('The wc_add_to_cart_message filter'), rt.new_string('3.0'), rt.new_string('wc_add_to_cart_message_html')])
		var_message = rt.call_function('apply_filters', [rt.new_string('wc_add_to_cart_message'), var_message.dup(), var_product_id.dup()])
	}
	var_message = rt.call_function('apply_filters', [rt.new_string('wc_add_to_cart_message_html'), var_message.dup(), var_products.dup(), rt.new_bool(show_qty)])
	if var_return {
		return var_message.dup()
	} else {
		rt.call_function('wc_add_notice', [var_message.dup(), rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_notice_type'), rt.new_string('success')])])
	}
	return rt.new_null()
}

fn wc_format_list_of_items(var_items rt.PhpVal) string {
	mut var_item_string := ''
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.identical(rt.new_int(var_items.dup().array_count()), rt.add(var_key, rt.new_int(2)))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_item_string
}

fn wc_clear_cart_after_payment() {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_should_clear_cart_after_payment := rt.new_bool(rt.new_bool(false))
	mut var_after_payment := false
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('order-received'))) {
		mut var_order_id := rt.call_function('absint', [rt.get_property(var_wp, 'query_vars').array_get('order-received')])
		mut var_order_key := if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('key')])]) } else { rt.new_string('') }
		if rt.is_true(rt.greater(var_order_id, rt.new_int(0))) {
			mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) && rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.dup()])))) {
				var_should_clear_cart_after_payment = rt.new_bool(rt.new_bool(true))
				var_after_payment = true
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session').is_object())) && rt.is_true(rt.greater(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'order_awaiting_payment'), rt.new_int(0))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_clear_cart_after_payment)))))) {
		var_order = rt.call_function('wc_get_order', [rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'order_awaiting_payment')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) && rt.is_true(rt.greater(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.new_int(0))))) {
			var_should_clear_cart_after_payment = rt.new_bool(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() }])])))))
			var_after_payment = true
		}
	}
	if !(var_after_payment) {
		return rt.new_null()
	}
	var_should_clear_cart_after_payment = rt.call_function('apply_filters', [rt.new_string('woocommerce_should_clear_cart_after_payment'), var_should_clear_cart_after_payment.dup()])
	if rt.is_true(var_should_clear_cart_after_payment) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart', []rt.PhpVal{})
	}
}

fn wc_cart_totals_subtotal_html() {
	rt.echo_val(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_subtotal', []rt.PhpVal{}))
	// unsupported statement: Stmt_Nop
}

fn wc_cart_totals_shipping_html() {
	mut var_packages := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
	mut var_first := true
	{
		mut iter_1 := var_packages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package := item_1.val
			mut var_i := item_1.key
			mut var_chosen_method := if rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'chosen_shipping_methods').array_isset(var_i) { rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'chosen_shipping_methods').array_get(var_i) } else { rt.new_string('') }
			mut var_product_names := rt.new_array()
			if var_packages.dup().array_count() > 1 {
				{
					mut iter_2 := var_package.array_get('contents').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_values := item_2.val
						mut var_item_id := item_2.key
						var_product_names.array_set(var_item_id, (rt.call_method(var_values.array_get('data'), 'get_name', []rt.PhpVal{})).str() + ' &times;' + (var_values.array_get('quantity')).str())
					}
				}
				var_product_names = rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_package_details_array'), var_product_names.dup(), var_package.dup()])
			}
			rt.call_function('wc_get_template', [rt.new_string('cart/cart-shipping.php'), rt.create_array([rt.ArrayItem{ key: 'package', val: var_package }, rt.ArrayItem{ key: 'available_methods', val: var_package.array_get('rates') }, rt.ArrayItem{ key: 'show_package_details', val: rt.new_bool(var_packages.dup().array_count() > 1) }, rt.ArrayItem{ key: 'show_shipping_calculator', val: rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_show_shipping_calculator'), rt.new_bool(var_first).dup(), var_i.dup(), var_package.dup()])) }, rt.ArrayItem{ key: 'package_details', val: rt.call_function('implode', [rt.new_string(', '), var_product_names.dup()]) }, rt.ArrayItem{ key: 'package_name', val: var_package.array_get('package_name') }, rt.ArrayItem{ key: 'index', val: var_i }, rt.ArrayItem{ key: 'chosen_method', val: var_chosen_method }, rt.ArrayItem{ key: 'formatted_destination', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [var_package.array_get('destination'), rt.new_string(', ')]) }, rt.ArrayItem{ key: 'has_calculated_shipping', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'has_calculated_shipping', []rt.PhpVal{}) }])])
			var_first = false
		}
	}
}

fn wc_cart_totals_taxes_total_html() {
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_taxes_total_html'), rt.call_function('wc_price', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_taxes_total', []rt.PhpVal{})])]))
	// unsupported statement: Stmt_Nop
}

fn wc_cart_totals_coupon_label(var_coupon rt.PhpVal, echo bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_coupon.is_string())) {
		var_coupon = create_wc_coupon(var_coupon.dup())
	}
	mut var_label := rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_coupon_label'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Coupon: %s'), rt.new_string('woocommerce')]), var_coupon.get_code()]), var_coupon])
	if var_echo {
		rt.echo_val(var_label)
		// unsupported statement: Stmt_Nop
	} else {
		return var_label.dup()
	}
	return rt.new_null()
}

fn wc_cart_totals_coupon_html(var_coupon rt.PhpVal) {
	if rt.is_true(rt.new_bool(var_coupon.is_string())) {
		var_coupon = create_wc_coupon(var_coupon.dup())
	}
	mut var_amount := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_coupon_discount_amount', [var_coupon.get_code(), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'display_cart_ex_tax')])
	mut var_discount_amount_html := rt.new_string('-' + (rt.call_function('wc_price', [var_amount.dup()])).str())
	if rt.is_true(rt.new_bool(rt.is_true(var_coupon.get_free_shipping()) && !rt.is_true(var_amount))) {
		var_discount_amount_html = rt.call_function('__', [rt.new_string('Free shipping coupon'), rt.new_string('woocommerce')])
	}
	var_discount_amount_html = rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_discount_amount_html'), var_discount_amount_html.dup(), var_coupon])
	mut var_coupon_html := rt.new_string( + )
	rt.echo_val(rt.call_function('wp_kses', [, ]))
	// unsupported statement: Stmt_Nop
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

fn create_wc_cart() &Class_WC_Cart {
	mut obj := &Class_WC_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils() &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon() &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_cart_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_filter', [rt.new_string('woocommerce_add_to_cart_validation'), rt.new_string('wc_protected_product_add_to_cart'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_clear_cart_after_payment'), rt.new_int(20)])
}

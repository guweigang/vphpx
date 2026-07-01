import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) load_cart()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_load_cart_from_session')]))))) {
		rt.call_function('wc_load_cart', []rt.PhpVal{})
	}
	mut var_cart := this.get_cart_instance()
	rt.set_property(var_cart, 'cart_context', rt.new_string('store-api'))
	rt.call_method(var_cart, 'get_cart', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) normalize_cart()  {
	mut var_quantity_limits := create_automattic_woocommerce_storeapi_utilities_quantitylimits()
	mut var_cart_items := this.get_cart_items(rt.new_null())
	{
		mut iter_1 := var_cart_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cart_item := item_1.val
			mut var_normalized_qty := var_quantity_limits.normalize_cart_item_quantity(var_cart_item.array_get('quantity'), var_cart_item.dup())
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.set_cart_item_quantity(var_cart_item.array_get('key'), (var_normalized_qty).to_i64())
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				unsafe { goto end_label_1 }

catch_label_1:
				mut var_e_1 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
					mut var_e := var_e_1.dup()
					continue
					unsafe { goto end_label_1 }
				}
				else {
					rt.throw_exception(var_e_1)
					unsafe { goto end_label_1 }
				}

end_label_1:
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_for_response() rt.PhpVal {
	return if rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_calculate_totals')])) { this.get_cart_instance() } else { this.calculate_totals() }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) calculate_totals() rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	rt.call_method(var_cart, 'get_cart', []rt.PhpVal{})
	rt.call_method(var_cart, 'calculate_fees', []rt.PhpVal{})
	rt.call_method(var_cart, 'calculate_totals', []rt.PhpVal{})
	return var_cart.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) add_to_cart(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_cart := this.get_cart_instance()
	var_request_mutated = rt.call_function('wp_parse_args', [var_request_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'quantity', val: 1 }, rt.ArrayItem{ key: 'variation', val: rt.new_array() }, rt.ArrayItem{ key: 'cart_item_data', val: rt.new_array() }])])
	var_request_mutated = this.filter_request_data(this.parse_variation_data(var_request_mutated.dup()))
	mut var_product := this.get_product_for_cart(var_request_mutated.dup())
	mut var_cart_id := rt.call_method(var_cart, 'generate_cart_id', [this.get_product_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)), this.get_variation_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)), var_request_mutated.array_get('variation'), var_request_mutated.array_get('cart_item_data')])
	mut var_quantity_limits := create_automattic_woocommerce_storeapi_utilities_quantitylimits()
	if rt.is_true(rt.identical(rt.new_null(), var_request_mutated.array_get('quantity'))) {
		var_request_mutated.array_set('quantity', var_quantity_limits.get_add_to_cart_limits(var_product.dup()).array_get('minimum'))
	}
	this.validate_add_to_cart(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product), var_request_mutated.dup())
	mut var_existing_cart_id := rt.call_method(var_cart, 'find_product_in_cart', [var_cart_id.dup()])
	mut var_request_quantity := rt.call_function('wc_stock_amount', [var_request_mutated.array_get('quantity')])
	if rt.is_true(var_existing_cart_id) {
		mut var_cart_item := rt.get_property(var_cart, 'cart_contents').array_get(var_existing_cart_id)
		mut var_updated_quantity := rt.add(var_request_quantity, var_cart_item.array_get('quantity'))
		mut var_quantity_validation := var_quantity_limits.validate_cart_item_quantity(var_updated_quantity.dup(), var_cart_item.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_quantity_validation.dup()])) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.call_function('esc_html', [rt.call_method(var_quantity_validation, 'get_error_code', []rt.PhpVal{})]), rt.call_function('esc_html', [rt.call_method(var_quantity_validation, 'get_error_message', []rt.PhpVal{})]), rt.new_int(400))))
		}
		rt.call_method(var_cart, 'set_quantity', [var_existing_cart_id.dup(), var_updated_quantity.dup(), rt.new_bool(true)])
		return var_existing_cart_id.dup()
	}
	mut var_add_to_cart_limits := var_quantity_limits.get_add_to_cart_limits(var_product.dup())
	if rt.is_true(var_add_to_cart_limits.array_get('maximum')) {
		var_request_quantity = rt.call_function('min', [var_request_quantity.dup(), var_add_to_cart_limits.array_get('maximum')])
	}
	var_request_quantity = rt.call_function('max', [var_request_quantity.dup(), var_add_to_cart_limits.array_get('minimum')])
	var_request_quantity = var_quantity_limits.limit_to_multiple(var_request_quantity.dup(), var_add_to_cart_limits.array_get('multiple_of'))
	rt.get_property(var_cart, 'cart_contents').array_set(var_cart_id, rt.call_function('apply_filters', [rt.new_string('woocommerce_add_cart_item'), rt.call_function('array_merge', [var_request_mutated.array_get('cart_item_data'), rt.create_array([rt.ArrayItem{ key: 'key', val: var_cart_id }, rt.ArrayItem{ key: 'product_id', val: this.get_product_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)) }, rt.ArrayItem{ key: 'variation_id', val: this.get_variation_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)) }, rt.ArrayItem{ key: 'variation', val: var_request_mutated.array_get('variation') }, rt.ArrayItem{ key: 'quantity', val: var_request_quantity }, rt.ArrayItem{ key: 'data', val: var_product }, rt.ArrayItem{ key: 'data_hash', val: rt.call_function('wc_get_cart_item_data_hash', [var_product.dup()]) }])]), var_cart_id.dup()]))
	rt.set_property(var_cart, 'cart_contents', rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_contents_changed'), rt.get_property(var_cart, 'cart_contents')]))
	rt.call_function('do_action', [rt.new_string('woocommerce_add_to_cart'), var_cart_id.dup(), this.get_product_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)), var_request_quantity.dup(), this.get_variation_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)), var_request_mutated.array_get('variation'), var_request_mutated.array_get('cart_item_data')])
	return var_cart_id.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) set_cart_item_quantity(var_item_id rt.PhpVal, quantity i64)  {
	mut var_cart_item := this.get_cart_item(var_item_id.dup())
	if !rt.is_true(var_cart_item) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_invalid_key'), rt.call_function('esc_html__', [rt.new_string('Cart item does not exist.'), rt.new_string('woocommerce')]), rt.new_int(409))))
	}
	mut var_product := if !(var_cart_item.array_get('data')).is_null() { var_cart_item.array_get('data') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_StoreApi_Utilities_WC_Product')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_invalid_product'), rt.call_function('esc_html__', [rt.new_string('Cart item is invalid.'), rt.new_string('woocommerce')]), rt.new_int(404))))
	}
	mut var_quantity_validation := rt.call_method(create_automattic_woocommerce_storeapi_utilities_quantitylimits(), 'validate_cart_item_quantity', [rt.new_int(quantity), var_cart_item.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_quantity_validation.dup()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.call_method(var_quantity_validation, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_quantity_validation, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
		// unsupported statement: Stmt_Nop
	}
	mut var_cart := this.get_cart_instance()
	rt.call_method(var_cart, 'set_quantity', [var_item_id.dup(), rt.new_int(quantity)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_add_to_cart(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product, var_request rt.PhpVal)  {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_purchasable', []rt.PhpVal{}))))) {
		this.throw_default_product_exception(mut var_product_mutated)
	}
	if var_request_mutated.array_get('quantity').to_f64() <= 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_invalid_quantity'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You cannot add &quot;%s&quot; with a quantity less than or equal to 0 to the cart.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{})])]), rt.new_int(400))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_out_of_stock'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You cannot add &quot;%s&quot; to the cart because the product is out of stock.'), rt.new_string('woocommerce')]), rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{})]), rt.new_int(400))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product_mutated, 'managing_stock', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'backorders_allowed', []rt.PhpVal{}))))))) {
		mut var_request_quantity := rt.call_function('wc_stock_amount', [var_request_mutated.array_get('quantity')])
		mut var_qty_remaining := this.get_remaining_stock_for_product(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Product', []string{}, var_product_mutated))
		mut var_qty_in_cart := this.get_product_quantity_in_cart(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Product', []string{}, var_product_mutated))
		if rt.is_true(rt.less(var_qty_remaining, rt.add(var_qty_in_cart, var_request_quantity))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_partially_out_of_stock'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('You cannot add that amount of &quot;%1$s&quot; to the cart because there is not enough stock (%2$s remaining).'), rt.new_string('woocommerce')]), rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}), rt.call_function('wc_format_stock_quantity_for_display', [var_qty_remaining.dup(), var_product_mutated.dup()])]), rt.new_int(400))))
		}
	}
	mut var_passed_validation := rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_validation'), rt.new_bool(true), this.get_product_id(mut var_product_mutated), var_request_mutated.array_get('quantity'), this.get_variation_id(mut var_product_mutated), var_request_mutated.array_get('variation'), var_request_mutated.array_get('cart_item_data')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_passed_validation)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{}; return temp.convert_notices_to_exceptions(arg_0) }(rt.new_string('woocommerce_rest_add_to_cart_error'))
		this.throw_default_product_exception(mut var_product_mutated)
	}
	rt.call_function('wc_do_deprecated_action', [rt.new_string('wooocommerce_store_api_validate_add_to_cart'), rt.create_array([rt.ArrayItem{ key: none, val: var_product_mutated }, rt.ArrayItem{ key: none, val: var_request_mutated }]), rt.new_string('7.1.0'), rt.new_string('woocommerce_store_api_validate_add_to_cart'), rt.new_string('This action was deprecated in WooCommerce Blocks version 7.1.0. Please use woocommerce_store_api_validate_add_to_cart instead.')])
	rt.call_function('do_action', [rt.new_string('woocommerce_store_api_validate_add_to_cart'), var_product_mutated.dup(), var_request_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) add_product_names_to_message(var_singular rt.PhpVal, var_plural rt.PhpVal, var_items rt.PhpVal) rt.PhpVal {
	mut var_product_names := rt.call_function('wc_list_pluck', [var_items.dup(), rt.new_string('getProductName')])
	mut var_message := if var_items.dup().array_count() > 1 { var_plural } else { var_singular }
	return rt.call_function('sprintf', [var_message.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{}; return temp.natural_language_join(arg_0, arg_1) }(var_product_names.dup(), rt.new_bool(true))])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_error_message_for_stock_exception_type(var_exception_type rt.PhpVal, var_singular_or_plural rt.PhpVal) rt.PhpVal {
	mut var_stock_error_messages := rt.create_array([rt.ArrayItem{ key: 'out_of_stock', val: rt.create_array([rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [rt.new_string('%s is out of stock and cannot be purchased. Please remove it from your cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [rt.new_string('%s are out of stock and cannot be purchased. Please remove them from your cart.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'not_purchasable', val: rt.create_array([rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [rt.new_string('%s cannot be purchased. Please remove it from your cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [rt.new_string('%s cannot be purchased. Please remove them from your cart.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'too_many_in_cart', val: rt.create_array([rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [rt.new_string('There are too many %s in the cart. Only 1 can be purchased. Please reduce the quantity in your cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [rt.new_string('There are too many %s in the cart. Only 1 of each can be purchased. Please reduce the quantities in your cart.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'partial_out_of_stock', val: rt.create_array([rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [rt.new_string('There is not enough %s in stock. Please reduce the quantity in your cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [rt.new_string('There are not enough %s in stock. Please reduce the quantities in your cart.'), rt.new_string('woocommerce')]) }]) }])
	if var_stock_error_messages.array_isset(var_exception_type) && var_stock_error_messages.array_get(var_exception_type).array_isset(var_singular_or_plural) {
		return var_stock_error_messages.array_get(var_exception_type).array_get(var_singular_or_plural)
	}
	return rt.call_function('esc_html__', [rt.new_string('There was an error with an item in your cart.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart()  {
	this.validate_cart_items()
	this.validate_cart_coupons()
	mut var_cart := this.get_cart_instance()
	mut var_cart_errors := create_wp_error()
	rt.call_function('do_action', [rt.new_string('woocommerce_store_api_cart_errors'), var_cart_errors.dup(), var_cart.dup()])
	if rt.is_true(rt.call_method(var_cart_errors, 'has_errors', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException', []string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_cart_error'), var_cart_errors.dup(), rt.new_int(409))))
	}
	rt.call_function('remove_action', [rt.new_string('woocommerce_check_cart_items'), rt.create_array([rt.ArrayItem{ key: none, val: var_cart }, rt.ArrayItem{ key: none, val: 'check_cart_items' }]), rt.new_int(1)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_check_cart_items'), rt.create_array([rt.ArrayItem{ key: none, val: var_cart }, rt.ArrayItem{ key: none, val: 'check_cart_coupons' }]), rt.new_int(1)])
	mut var_previous_notices := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices')])
	rt.call_function('do_action', [rt.new_string('woocommerce_check_cart_items')])
	var_cart_errors = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{}; return temp.convert_notices_to_wp_errors(arg_0) }(rt.new_string('woocommerce_rest_cart_item_error'))
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), var_previous_notices.dup()])
	if rt.is_true(rt.call_method(var_cart_errors, 'has_errors', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException', []string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(, .dup(), )))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_not_empty()  {
	mut var_cart_items := this.get_cart_items(rt.new_null())
	if !rt.is_true(var_cart_items) {
		
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_items()  {
	
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) stock_exceptions_to_wp_errors(var_too_many_in_cart_products rt.PhpVal, var_not_purchasable_products rt.PhpVal, var_partial_out_of_stock_products rt.PhpVal, var_out_of_stock_products rt.PhpVal) rt.PhpVal {
	mut var_too_many_in_cart_products_mutated := var_too_many_in_cart_products
	mut var_not_purchasable_products_mutated := var_not_purchasable_products
	mut var_partial_out_of_stock_products_mutated := var_partial_out_of_stock_products
	mut var_out_of_stock_products_mutated := var_out_of_stock_products
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_item(var_cart_item rt.PhpVal)  {
	mut var_cart_item_mutated := var_cart_item
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_coupons()  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_errors() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_instance() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_item(var_item_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_items(var_callback rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_hashes() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) empty_cart()  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) has_coupon(var_coupon_code rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_coupons(var_callback rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_shipping_packages(calculate_rates bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) select_shipping_rate(var_package_id rt.PhpVal, var_rate_id rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) apply_coupon(var_coupon_code rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_coupon(mut var_coupon Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon)  {
	mut var_coupon_mutated := var_coupon
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_quantity_in_cart(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_remaining_stock_for_product(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_for_cart(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_id(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_variation_id(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_name(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) string {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) throw_default_product_exception(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) filter_request_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) parse_variation_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_variation_id_from_variation_data(var_request rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_product_mutated := var_product
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) sanitize_variation_data(var_variation_data rt.PhpVal, var_variable_product_attributes rt.PhpVal) rt.PhpVal {
	mut var_variable_product_attributes_mutated := var_variable_product_attributes
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_variable_product_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_quantitylimits() &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_noticehandler() &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_arrayutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_invalidcartexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load_cart' {
			this.load_cart()
			return rt.new_null()
		}
		'normalize_cart' {
			this.normalize_cart()
			return rt.new_null()
		}
		'get_cart_for_response' {
			return this.get_cart_for_response()
		}
		'calculate_totals' {
			return this.calculate_totals()
		}
		'add_to_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_to_cart(dispatch_arg_0)
		}
		'set_cart_item_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.set_cart_item_quantity(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_add_to_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_add_to_cart(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_product_names_to_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_product_names_to_message(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_error_message_for_stock_exception_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_error_message_for_stock_exception_type(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_cart' {
			this.validate_cart()
			return rt.new_null()
		}
		'validate_cart_not_empty' {
			this.validate_cart_not_empty()
			return rt.new_null()
		}
		'validate_cart_items' {
			this.validate_cart_items()
			return rt.new_null()
		}
		'stock_exceptions_to_wp_errors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.stock_exceptions_to_wp_errors(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'validate_cart_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.validate_cart_item(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_cart_coupons' {
			this.validate_cart_coupons()
			return rt.new_null()
		}
		'get_cart_errors' {
			return this.get_cart_errors()
		}
		'get_cart_instance' {
			return this.get_cart_instance()
		}
		'get_cart_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_item(dispatch_arg_0)
		}
		'get_cart_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_items(dispatch_arg_0)
		}
		'get_cart_hashes' {
			return this.get_cart_hashes()
		}
		'empty_cart' {
			this.empty_cart()
			return rt.new_null()
		}
		'has_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has_coupon(dispatch_arg_0)
		}
		'get_cart_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_coupons(dispatch_arg_0)
		}
		'get_shipping_packages' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_shipping_packages(dispatch_arg_0)
		}
		'select_shipping_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.select_shipping_rate(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.apply_coupon(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_cart_coupon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_cart_coupon(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_quantity_in_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_quantity_in_cart(dispatch_arg_0)
		}
		'get_remaining_stock_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_remaining_stock_for_product(dispatch_arg_0)
		}
		'get_product_for_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_for_cart(dispatch_arg_0)
		}
		'get_product_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_product_id(mut dispatch_arg_0)
		}
		'get_variation_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_variation_id(mut dispatch_arg_0)
		}
		'get_product_name' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_product_name(mut dispatch_arg_0))
		}
		'throw_default_product_exception' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.throw_default_product_exception(mut dispatch_arg_0)
			return rt.new_null()
		}
		'filter_request_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_request_data(dispatch_arg_0)
		}
		'parse_variation_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_variation_data(dispatch_arg_0)
		}
		'get_variation_id_from_variation_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_variation_id_from_variation_data(dispatch_arg_0, dispatch_arg_1)
		}
		'sanitize_variation_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_variation_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_variable_product_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_variable_product_attributes(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_cartcontroller_php() {
}

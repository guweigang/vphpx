import rt
import crypto.md5

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) load_cart() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('woocommerce_load_cart_from_session'),
	])))))
	{
		rt.call_function('wc_load_cart', []rt.PhpVal{})
	}
	mut var_cart := this.get_cart_instance()
	rt.set_property(var_cart, 'cart_context', rt.new_string('store-api'))
	rt.call_method(var_cart, 'get_cart', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) normalize_cart() {
	mut var_quantity_limits := create_automattic_woocommerce_storeapi_utilities_quantitylimits()
	mut var_cart_items := this.get_cart_items(rt.new_null())
	mut iter_1 := var_cart_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cart_item := item_1.val
		mut var_normalized_qty := var_quantity_limits.normalize_cart_item_quantity(var_cart_item.array_get(rt.new_string('quantity')),
			var_cart_item.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_normalized_qty,
			var_cart_item.array_get(rt.new_string('quantity'))))))
		{
			this.set_cart_item_quantity(var_cart_item.array_get(rt.new_string('key')),
				var_normalized_qty.to_i64())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			unsafe {
				goto end_label_1
			}
			catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
				mut var_e := var_e_1.clone()
				continue
				unsafe {
					goto end_label_1
				}
			} else {
				rt.throw_exception(var_e_1)
				unsafe {
					goto end_label_1
				}
			}

			end_label_1:
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_for_response() rt.PhpVal {
	return if rt.is_true(rt.call_function('did_action', [
		rt.new_string('woocommerce_after_calculate_totals'),
	]))
	{ this.get_cart_instance() } else { this.calculate_totals() }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) calculate_totals() rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	rt.call_method(var_cart, 'get_cart', []rt.PhpVal{})
	rt.call_method(var_cart, 'calculate_fees', []rt.PhpVal{})
	rt.call_method(var_cart, 'calculate_totals', []rt.PhpVal{})
	return var_cart.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) add_to_cart(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_cart := this.get_cart_instance()
	var_request_mutated = rt.call_function('wp_parse_args', [
		var_request_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 0 },
			rt.ArrayItem{ key: 'quantity', val: 1 }, rt.ArrayItem{
				key: 'variation'
				val: rt.new_array()
			}, rt.ArrayItem{ key: 'cart_item_data', val: rt.new_array() }])])
	var_request_mutated =
		this.filter_request_data(this.parse_variation_data(var_request_mutated.clone()))
	mut var_product := this.get_product_for_cart(var_request_mutated.clone())
	mut var_cart_id := rt.call_method(var_cart, 'generate_cart_id', [
		this.get_product_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)),
		this.get_variation_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)),
		var_request_mutated.array_get(rt.new_string('variation')),
		var_request_mutated.array_get(rt.new_string('cart_item_data')),
	])
	mut var_quantity_limits := create_automattic_woocommerce_storeapi_utilities_quantitylimits()
	if rt.is_true(rt.identical(rt.new_null(),
		var_request_mutated.array_get(rt.new_string('quantity'))))
	{
		var_request_mutated.array_set('quantity',
			var_quantity_limits.get_add_to_cart_limits(var_product.clone()).array_get(rt.new_string('minimum')))
	}
	this.validate_add_to_cart(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product),
		var_request_mutated.clone())
	mut var_existing_cart_id := rt.call_method(var_cart, 'find_product_in_cart', [
		var_cart_id.clone(),
	])
	mut var_request_quantity := rt.call_function('wc_stock_amount', [
		var_request_mutated.array_get(rt.new_string('quantity')),
	])
	if rt.is_true(var_existing_cart_id) {
		mut var_cart_item :=
			rt.get_property(var_cart, 'cart_contents').array_get(var_existing_cart_id)
		mut var_updated_quantity := rt.add(var_request_quantity,
			var_cart_item.array_get(rt.new_string('quantity')))
		mut var_quantity_validation := var_quantity_limits.validate_cart_item_quantity(var_updated_quantity.clone(),
			var_cart_item.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_quantity_validation.clone()])) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.call_function('esc_html', [
				rt.call_method(var_quantity_validation, 'get_error_code', []rt.PhpVal{}),
			]), rt.call_function('esc_html', [
				rt.call_method(var_quantity_validation, 'get_error_message', []rt.PhpVal{}),
			]), rt.new_int(400))))
		}
		rt.call_method(var_cart, 'set_quantity', [var_existing_cart_id.clone(),
			var_updated_quantity.clone(), rt.new_bool(true)])
		return var_existing_cart_id.clone()
	}
	mut var_add_to_cart_limits := var_quantity_limits.get_add_to_cart_limits(var_product.clone())
	if rt.is_true(var_add_to_cart_limits.array_get(rt.new_string('maximum'))) {
		var_request_quantity = rt.call_function('min', [var_request_quantity.clone(),
			var_add_to_cart_limits.array_get(rt.new_string('maximum'))])
	}
	var_request_quantity = rt.call_function('max', [var_request_quantity.clone(),
		var_add_to_cart_limits.array_get(rt.new_string('minimum'))])
	var_request_quantity = var_quantity_limits.limit_to_multiple(var_request_quantity.clone(),
		var_add_to_cart_limits.array_get(rt.new_string('multiple_of')))
	rt.get_property(var_cart, 'cart_contents').array_set(var_cart_id, rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_cart_item'),
		rt.call_function('array_merge', [var_request_mutated.array_get(rt.new_string('cart_item_data')),
			rt.create_array([rt.ArrayItem{ key: 'key', val: var_cart_id },
				rt.ArrayItem{
					key: 'product_id'
					val: this.get_product_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product))
				}, rt.ArrayItem{
					key: 'variation_id'
					val: this.get_variation_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product))
				}, rt.ArrayItem{
					key: 'variation'
					val: var_request_mutated.array_get(rt.new_string('variation'))
				}, rt.ArrayItem{ key: 'quantity', val: var_request_quantity },
				rt.ArrayItem{ key: 'data', val: var_product },
				rt.ArrayItem{ key: 'data_hash', val: rt.call_function('wc_get_cart_item_data_hash', [
					var_product.clone(),
				]) }])]),
		var_cart_id.clone(),
	]))
	rt.set_property(var_cart, 'cart_contents', rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_contents_changed'),
		rt.get_property(var_cart, 'cart_contents'),
	]))
	rt.call_function('do_action', [rt.new_string('woocommerce_add_to_cart'),
		var_cart_id.clone(),
		this.get_product_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)),
		var_request_quantity.clone(),
		this.get_variation_id(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product)),
		var_request_mutated.array_get(rt.new_string('variation')),
		var_request_mutated.array_get(rt.new_string('cart_item_data'))])
	return var_cart_id.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) set_cart_item_quantity(var_item_id rt.PhpVal, quantity i64) {
	mut var_cart_item := this.get_cart_item(var_item_id.clone())
	if !rt.is_true(var_cart_item) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_invalid_key'), rt.call_function('esc_html__', [
			rt.new_string('Cart item does not exist.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(409))))
	}
	mut var_product := if !(var_cart_item.array_get(rt.new_string('data'))).is_null() {
		var_cart_item.array_get(rt.new_string('data'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_StoreApi_Utilities_WC_Product'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_invalid_product'), rt.call_function('esc_html__', [
			rt.new_string('Cart item is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))))
	}
	mut var_quantity_validation := rt.call_method(create_automattic_woocommerce_storeapi_utilities_quantitylimits(),
		'validate_cart_item_quantity', [rt.new_int(quantity),
		var_cart_item.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_quantity_validation.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.call_method(var_quantity_validation,
			'get_error_code', []rt.PhpVal{}), rt.call_method(var_quantity_validation,
			'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
	}
	mut var_cart := this.get_cart_instance()
	rt.call_method(var_cart, 'set_quantity', [var_item_id.clone(),
		rt.new_int(quantity)])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_add_to_cart(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product, var_request rt.PhpVal) {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_purchasable',
		[]rt.PhpVal{})))))
	{
		this.throw_default_product_exception(mut var_product_mutated)
	}
	if var_request_mutated.array_get(rt.new_string('quantity')).to_f64() <= 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_invalid_quantity'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('You cannot add &quot;%s&quot; with a quantity less than or equal to 0 to the cart.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}),
			]),
		]), rt.new_int(400))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_in_stock',
		[]rt.PhpVal{})))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_out_of_stock'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('You cannot add &quot;%s&quot; to the cart because the product is out of stock.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}),
		]), rt.new_int(400))))
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'managing_stock', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'backorders_allowed', []rt.PhpVal{}))))) {
		mut var_request_quantity := rt.call_function('wc_stock_amount', [
			var_request_mutated.array_get(rt.new_string('quantity')),
		])
		mut var_qty_remaining := this.get_remaining_stock_for_product(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Product',
			[]string{}, var_product_mutated))
		mut var_qty_in_cart := this.get_product_quantity_in_cart(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Product',
			[]string{}, var_product_mutated))
		if rt.is_true(rt.less(var_qty_remaining, rt.add(var_qty_in_cart, var_request_quantity))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_partially_out_of_stock'), rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('You cannot add that amount of &quot;%1$s&quot; to the cart because there is not enough stock (%2$s remaining).'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}),
				rt.call_function('wc_format_stock_quantity_for_display', [
					var_qty_remaining.clone(),
					var_product_mutated,
				]),
			]), rt.new_int(400))))
		}
	}
	mut var_passed_validation := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_to_cart_validation'),
		rt.new_bool(true),
		this.get_product_id(mut var_product_mutated),
		var_request_mutated.array_get(rt.new_string('quantity')),
		this.get_variation_id(mut var_product_mutated),
		var_request_mutated.array_get(rt.new_string('variation')),
		var_request_mutated.array_get(rt.new_string('cart_item_data')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_passed_validation)))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{}
		mut iife_result_0 :=
			iife_temp_0.convert_notices_to_exceptions(rt.new_string('woocommerce_rest_add_to_cart_error'))
		this.throw_default_product_exception(mut var_product_mutated)
	}
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('wooocommerce_store_api_validate_add_to_cart'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_mutated },
			rt.ArrayItem{ key: none, val: var_request_mutated }]),
		rt.new_string('7.1.0'),
		rt.new_string('woocommerce_store_api_validate_add_to_cart'),
		rt.new_string('This action was deprecated in WooCommerce Blocks version 7.1.0. Please use woocommerce_store_api_validate_add_to_cart instead.'),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_store_api_validate_add_to_cart'),
		var_product_mutated,
		var_request_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) add_product_names_to_message(var_singular rt.PhpVal, var_plural rt.PhpVal, var_items rt.PhpVal) rt.PhpVal {
	mut var_product_names := rt.call_function('wc_list_pluck', [
		var_items.clone(), rt.new_string('getProductName')])
	mut var_message := if var_items.clone().array_count() > 1 { var_plural } else { var_singular }
	mut iife_temp_1 := Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{}
	mut iife_result_1 := iife_temp_1.natural_language_join(var_product_names.clone(),
		rt.new_bool(true))
	return rt.call_function('sprintf', [var_message.clone(), iife_result_1])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_error_message_for_stock_exception_type(var_exception_type rt.PhpVal, var_singular_or_plural rt.PhpVal) rt.PhpVal {
	mut var_stock_error_messages := rt.create_array([
		rt.ArrayItem{ key: 'out_of_stock', val: rt.create_array([
			rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [
				rt.new_string('%s is out of stock and cannot be purchased. Please remove it from your cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [
				rt.new_string('%s are out of stock and cannot be purchased. Please remove them from your cart.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'not_purchasable', val: rt.create_array([
			rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [
				rt.new_string('%s cannot be purchased. Please remove it from your cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [
				rt.new_string('%s cannot be purchased. Please remove them from your cart.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'too_many_in_cart', val: rt.create_array([
			rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [
				rt.new_string('There are too many %s in the cart. Only 1 can be purchased. Please reduce the quantity in your cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [
				rt.new_string('There are too many %s in the cart. Only 1 of each can be purchased. Please reduce the quantities in your cart.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'partial_out_of_stock', val: rt.create_array([
			rt.ArrayItem{ key: 'singular', val: rt.call_function('esc_html__', [
				rt.new_string('There is not enough %s in stock. Please reduce the quantity in your cart.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'plural', val: rt.call_function('esc_html__', [
				rt.new_string('There are not enough %s in stock. Please reduce the quantities in your cart.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	if var_stock_error_messages.array_isset(var_exception_type)
		&& var_stock_error_messages.array_get(var_exception_type).array_isset(var_singular_or_plural) {
		return var_stock_error_messages.array_get(var_exception_type).array_get(var_singular_or_plural)
	}
	return rt.call_function('esc_html__', [
		rt.new_string('There was an error with an item in your cart.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart() {
	this.validate_cart_items()
	this.validate_cart_coupons()
	mut var_cart := this.get_cart_instance()
	mut var_cart_errors := create_wp_error()
	rt.call_function('do_action', [rt.new_string('woocommerce_store_api_cart_errors'),
		var_cart_errors.clone(), var_cart.clone()])
	if rt.is_true(rt.call_method(var_cart_errors, 'has_errors', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_cart_error'),
			var_cart_errors.clone(), rt.new_int(409))))
	}
	rt.call_function('remove_action', [rt.new_string('woocommerce_check_cart_items'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
			rt.ArrayItem{ key: none, val: 'check_cart_items' }]),
		rt.new_int(1)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_check_cart_items'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_cart },
			rt.ArrayItem{ key: none, val: 'check_cart_coupons' }]),
		rt.new_int(1)])
	mut var_previous_notices := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'session'), 'get', [rt.new_string('wc_notices')])
	rt.call_function('do_action', [rt.new_string('woocommerce_check_cart_items')])
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{}
	mut iife_result_2 :=
		iife_temp_2.convert_notices_to_wp_errors(rt.new_string('woocommerce_rest_cart_item_error'))
	var_cart_errors = iife_result_2
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('wc_notices'),
		var_previous_notices.clone(),
	])
	if rt.is_true(rt.call_method(var_cart_errors, 'has_errors', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_cart_error'),
			var_cart_errors.clone(), rt.new_int(409))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_not_empty() {
	mut var_cart_items := this.get_cart_items(rt.new_null())
	if !rt.is_true(var_cart_items) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_cart_error'), create_wp_error(rt.new_string('woocommerce_rest_cart_empty'), rt.call_function('esc_html__', [
			rt.new_string('Cannot place an order, your cart is empty.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400)), rt.new_int(400))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_items() {
	mut var_cart_items := this.get_cart_items(rt.new_null())
	mut var_errors := rt.new_array()
	mut var_out_of_stock_products := rt.new_array()
	mut var_too_many_in_cart_products := rt.new_array()
	mut var_partial_out_of_stock_products := rt.new_array()
	mut var_not_purchasable_products := rt.new_array()
	mut iter_2 := var_cart_items.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_cart_item := item_2.val
		this.validate_cart_item(var_cart_item.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
			mut var_error := var_e_2.clone()
			var_errors.array_push(create_wp_error(rt.call_method(var_error, 'getErrorCode',
				[]rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), rt.call_method(var_error,
				'getAdditionalData', []rt.PhpVal{})))
			unsafe {
				goto end_label_2
			}
		} else if rt.instance_of(var_e_2,
			'Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException')
		{
			var_error = var_e_2.clone()
			var_too_many_in_cart_products.array_push(var_error.clone())
			unsafe {
				goto end_label_2
			}
		} else if rt.instance_of(var_e_2,
			'Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException')
		{
			var_error = var_e_2.clone()
			var_not_purchasable_products.array_push(var_error.clone())
			unsafe {
				goto end_label_2
			}
		} else if rt.instance_of(var_e_2,
			'Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException')
		{
			var_error = var_e_2.clone()
			var_partial_out_of_stock_products.array_push(var_error.clone())
			unsafe {
				goto end_label_2
			}
		} else if rt.instance_of(var_e_2,
			'Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException')
		{
			var_error = var_e_2.clone()
			var_out_of_stock_products.array_push(var_error.clone())
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	}
	if var_errors.clone().array_count() > 0 {
		mut var_error := create_wp_error()
		mut iter_3 := var_errors.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_wp_error := item_3.val
			rt.call_method(var_error, 'merge_from', [var_wp_error.clone()])
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_cart_error'),
			var_error.clone(), rt.new_int(409))))
	}
	var_error = this.stock_exceptions_to_wp_errors(var_too_many_in_cart_products.clone(),
		var_not_purchasable_products.clone(), var_partial_out_of_stock_products.clone(),
		var_out_of_stock_products.clone())
	if rt.is_true(rt.call_method(var_error, 'has_errors', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_stock_availability_error'),
			var_error.clone(), rt.new_int(409))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) stock_exceptions_to_wp_errors(var_too_many_in_cart_products rt.PhpVal, var_not_purchasable_products rt.PhpVal, var_partial_out_of_stock_products rt.PhpVal, var_out_of_stock_products rt.PhpVal) rt.PhpVal {
	mut var_too_many_in_cart_products_mutated := var_too_many_in_cart_products
	mut var_not_purchasable_products_mutated := var_not_purchasable_products
	mut var_partial_out_of_stock_products_mutated := var_partial_out_of_stock_products
	mut var_out_of_stock_products_mutated := var_out_of_stock_products
	mut var_error := create_wp_error()
	if var_out_of_stock_products_mutated.clone().array_count() > 0 {
		mut var_singular_error := this.get_error_message_for_stock_exception_type(rt.new_string('out_of_stock'),
			rt.new_string('singular'))
		mut var_plural_error := this.get_error_message_for_stock_exception_type(rt.new_string('out_of_stock'),
			rt.new_string('plural'))
		rt.call_method(var_error, 'add', [
			rt.new_string('woocommerce_rest_product_out_of_stock'),
			this.add_product_names_to_message(var_singular_error.clone(), var_plural_error.clone(),
				var_out_of_stock_products_mutated.clone()),
		])
	}
	if var_not_purchasable_products_mutated.clone().array_count() > 0 {
		var_singular_error = this.get_error_message_for_stock_exception_type(rt.new_string('not_purchasable'),
			rt.new_string('singular'))
		var_plural_error = this.get_error_message_for_stock_exception_type(rt.new_string('not_purchasable'),
			rt.new_string('plural'))
		rt.call_method(var_error, 'add', [
			rt.new_string('woocommerce_rest_product_not_purchasable'),
			this.add_product_names_to_message(var_singular_error.clone(), var_plural_error.clone(),
				var_not_purchasable_products_mutated.clone()),
		])
	}
	if var_too_many_in_cart_products_mutated.clone().array_count() > 0 {
		var_singular_error = this.get_error_message_for_stock_exception_type(rt.new_string('too_many_in_cart'),
			rt.new_string('singular'))
		var_plural_error = this.get_error_message_for_stock_exception_type(rt.new_string('too_many_in_cart'),
			rt.new_string('plural'))
		rt.call_method(var_error, 'add', [
			rt.new_string('woocommerce_rest_product_too_many_in_cart'),
			this.add_product_names_to_message(var_singular_error.clone(), var_plural_error.clone(),
				var_too_many_in_cart_products_mutated.clone()),
		])
	}
	if var_partial_out_of_stock_products_mutated.clone().array_count() > 0 {
		var_singular_error = this.get_error_message_for_stock_exception_type(rt.new_string('partial_out_of_stock'),
			rt.new_string('singular'))
		var_plural_error = this.get_error_message_for_stock_exception_type(rt.new_string('partial_out_of_stock'),
			rt.new_string('plural'))
		rt.call_method(var_error, 'add', [
			rt.new_string('woocommerce_rest_product_partially_out_of_stock'),
			this.add_product_names_to_message(var_singular_error.clone(), var_plural_error.clone(),
				var_partial_out_of_stock_products_mutated.clone()),
		])
	}
	return var_error.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_item(var_cart_item rt.PhpVal) {
	mut var_cart_item_mutated := var_cart_item
	mut var_product := if !(var_cart_item_mutated.array_get(rt.new_string('data'))).is_null() {
		var_cart_item_mutated.array_get(rt.new_string('data'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_StoreApi_Utilities_WC_Product'))))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_purchasable',
		[]rt.PhpVal{})))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_notpurchasableexception(rt.new_string('woocommerce_rest_product_not_purchasable'), rt.call_method(var_product,
			'get_name', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{}))
		&& rt.is_true(rt.greater(var_cart_item_mutated.array_get(rt.new_string('quantity')), rt.new_int(1))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_toomanyincartexception(rt.new_string('woocommerce_rest_product_too_many_in_cart'), rt.call_method(var_product,
			'get_name', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_outofstockexception(rt.new_string('woocommerce_rest_product_out_of_stock'), rt.call_method(var_product,
			'get_name', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{}))))) {
		mut var_qty_remaining := this.get_remaining_stock_for_product(var_product.clone())
		mut var_qty_in_cart := this.get_product_quantity_in_cart(var_product.clone())
		if rt.is_true(rt.less(var_qty_remaining, var_qty_in_cart)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_partialoutofstockexception(rt.new_string('woocommerce_rest_product_partially_out_of_stock'), rt.call_method(var_product,
				'get_name', []rt.PhpVal{}))))
		}
	}
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('wooocommerce_store_api_validate_cart_item'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product },
			rt.ArrayItem{ key: none, val: var_cart_item_mutated }]),
		rt.new_string('7.1.0'),
		rt.new_string('woocommerce_store_api_validate_cart_item'),
		rt.new_string('This action was deprecated in WooCommerce Blocks version 7.1.0. Please use woocommerce_store_api_validate_cart_item instead.'),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_store_api_validate_cart_item'),
		var_product.clone(),
		var_cart_item_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_coupons() {
	mut var_cart_coupons := this.get_cart_coupons(rt.new_null())
	mut var_errors := rt.new_array()
	mut iter_4 := var_cart_coupons.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_code := item_4.val
		mut var_coupon :=
			create_automattic_woocommerce_storeapi_utilities_wc_coupon(var_code.clone())
		this.validate_cart_coupon(mut var_coupon)
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		unsafe {
			goto end_label_3
		}
		catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
			mut var_error := var_e_3.clone()
			var_errors.array_push(create_wp_error(rt.call_method(var_error, 'getErrorCode',
				[]rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), rt.call_method(var_error,
				'getAdditionalData', []rt.PhpVal{})))
			unsafe {
				goto end_label_3
			}
		} else {
			rt.throw_exception(var_e_3)
			unsafe {
				goto end_label_3
			}
		}

		end_label_3:
	}
	if !(!rt.is_true(var_errors)) {
		mut var_error := create_wp_error()
		mut iter_5 := var_errors.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_wp_error := item_5.val
			rt.call_method(var_error, 'merge_from', [var_wp_error.clone()])
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(rt.new_string('woocommerce_coupons_error'),
			var_error.clone(), rt.new_int(409))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_errors() rt.PhpVal {
	mut var_errors := create_wp_error()
	this.validate_cart()
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
		mut var_error := var_e_4.clone()
		rt.call_method(var_errors, 'add', [
			rt.call_method(var_error, 'getErrorCode', []rt.PhpVal{}),
			rt.call_method(var_error, 'getMessage', []rt.PhpVal{}),
			rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}),
		])
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4,
		'Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException')
	{
		var_error = var_e_4.clone()
		rt.call_method(var_errors, 'merge_from', [
			rt.call_method(var_error, 'getError', []rt.PhpVal{}),
		])
		unsafe {
			goto end_label_4
		}
	} else if rt.instance_of(var_e_4, 'Automattic_WooCommerce_StoreApi_Utilities_Exception') {
		var_error = var_e_4.clone()
		rt.call_method(var_errors, 'add', [
			rt.call_method(var_error, 'getCode', []rt.PhpVal{}),
			rt.call_method(var_error, 'getMessage', []rt.PhpVal{}),
		])
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	return var_errors.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_instance() rt.PhpVal {
	mut var_cart := rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cart))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_cart, 'Automattic_WooCommerce_StoreApi_Utilities_WC_Cart')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_error'), rt.call_function('esc_html__', [
			rt.new_string('Unable to retrieve cart.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))))
	}
	return var_cart.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_item(var_item_id rt.PhpVal) rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	return if rt.get_property(var_cart, 'cart_contents').array_isset(var_item_id) {
		rt.get_property(var_cart, 'cart_contents').array_get(var_item_id)
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_items(var_callback rt.PhpVal) rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	return if rt.is_true(var_callback) { rt.call_function('array_filter', [
			rt.call_method(var_cart, 'get_cart', []rt.PhpVal{}),
			var_callback.clone(),
		]) } else { rt.call_function('array_filter', [
			rt.call_method(var_cart, 'get_cart', []rt.PhpVal{}),
		]) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_hashes() rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	return rt.create_array([
		rt.ArrayItem{ key: 'line_items', val: rt.call_method(var_cart, 'get_cart_hash',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'shipping', val: md5.hexhash(rt.call_function('wp_json_encode', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_method(var_cart, 'get_shipping_methods',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: none, val: rt.call_method(rt.get_property(rt.call_function('wc',
					[]rt.PhpVal{}), 'session'), 'get', [
					rt.new_string('chosen_shipping_methods'),
				]) },
			]),
		]).to_string()) },
		rt.ArrayItem{ key: 'fees', val: md5.hexhash(rt.call_function('wp_json_encode', [
			rt.call_method(var_cart, 'get_fees', []rt.PhpVal{}),
		]).to_string()) },
		rt.ArrayItem{ key: 'coupons', val: md5.hexhash(rt.call_function('wp_json_encode', [
			rt.call_method(var_cart, 'get_applied_coupons', []rt.PhpVal{}),
		]).to_string()) },
		rt.ArrayItem{ key: 'taxes', val: md5.hexhash(rt.call_function('wp_json_encode', [
			rt.call_method(var_cart, 'get_taxes', []rt.PhpVal{}),
		]).to_string()) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) empty_cart() {
	mut var_cart := this.get_cart_instance()
	rt.call_method(var_cart, 'empty_cart', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) has_coupon(var_coupon_code rt.PhpVal) rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	return rt.call_method(var_cart, 'has_discount', [var_coupon_code.clone()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_cart_coupons(var_callback rt.PhpVal) rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	return if rt.is_true(var_callback) { rt.call_function('array_filter', [
			rt.call_method(var_cart, 'get_applied_coupons', []rt.PhpVal{}),
			var_callback.clone(),
		]) } else { rt.call_function('array_filter', [
			rt.call_method(var_cart, 'get_applied_coupons', []rt.PhpVal{}),
		]) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_shipping_packages(calculate_rates bool) rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cart, 'needs_shipping', []rt.PhpVal{}))))) {
		return rt.new_array()
	}
	mut var_packages := rt.call_method(var_cart, 'get_shipping_packages', []rt.PhpVal{})
	if !rt.is_true(var_packages) {
		return rt.new_array()
	}
	return if var_calculate_rates { rt.call_method(rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'calculate_shipping', [
			var_packages.clone(),
		]) } else { var_packages }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) select_shipping_rate(var_package_id rt.PhpVal, var_rate_id rt.PhpVal) {
	if !(var_rate_id.clone().is_string()) {
		return
	}
	mut var_cart := this.get_cart_instance()
	mut var_session_data := if rt.is_true(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'), 'get', [
		rt.new_string('chosen_shipping_methods'),
	]))
	{ rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('chosen_shipping_methods'),
		]) } else { rt.new_array() }
	var_session_data.array_set(var_package_id, var_rate_id.clone())
	rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('chosen_shipping_methods'),
		var_session_data.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) apply_coupon(var_coupon_code rt.PhpVal) {
	mut var_cart := this.get_cart_instance()
	mut var_applied_coupons := this.get_cart_coupons(rt.new_null())
	mut var_coupon :=
		create_automattic_woocommerce_storeapi_utilities_wc_coupon(var_coupon_code.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_same_coupon', [
		var_coupon.get_code(),
		var_coupon_code.clone(),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_error'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('"%s" is an invalid coupon code.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_coupon_code.clone(),
			]),
		]), rt.new_int(400))))
	}
	if rt.is_true(this.has_coupon(var_coupon_code.clone())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_error'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Coupon code "%s" has already been applied.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_coupon.get_code(),
			]),
		]), rt.new_int(400))))
	}
	mut var_discounts :=
		create_automattic_woocommerce_storeapi_utilities_wc_discounts(this.get_cart_instance())
	mut var_valid := var_discounts.is_coupon_valid(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon',
		[]string{}, var_coupon))
	if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_error'), rt.call_function('esc_html', [
			rt.call_function('wp_strip_all_tags', [
				rt.call_method(var_valid, 'get_error_message', []rt.PhpVal{}),
			]),
		]), rt.new_int(400), rt.call_method(var_valid, 'get_error_data', []rt.PhpVal{}))))
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_code := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_coupon :=
			create_automattic_woocommerce_storeapi_utilities_wc_coupon(var_code.clone())
		return
	}
	mut var_individual_use_coupons := this.get_cart_coupons(rt.new_closure(closure_4_fn))
	mut iter_6 := var_individual_use_coupons.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_code := item_6.val
		mut var_individual_use_coupon :=
			create_automattic_woocommerce_storeapi_utilities_wc_coupon(var_code.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [
			rt.new_string('woocommerce_apply_with_individual_use_coupon'),
			rt.new_bool(false),
			var_coupon,
			var_individual_use_coupon,
			var_applied_coupons.clone(),
		])))
		{
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_error'), rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('"%s" has already been applied and cannot be used in conjunction with other coupons.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					var_individual_use_coupon.get_code(),
				]),
			]), rt.new_int(400))))
		}
	}
	if rt.is_true(var_coupon.get_individual_use()) {
		mut var_coupons_to_remove := rt.call_function('array_diff', [
			var_applied_coupons.clone(),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_apply_individual_use_coupon'),
				rt.new_array(),
				var_coupon,
				var_applied_coupons.clone(),
			])])
		mut iter_7 := var_coupons_to_remove.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_code := item_7.val
			rt.call_method(var_cart, 'remove_coupon', [var_code.clone()])
		}
		var_applied_coupons = rt.call_function('array_diff', [
			var_applied_coupons.clone(), var_coupons_to_remove.clone()])
	}
	var_applied_coupons.array_push(var_coupon_code.clone())
	rt.call_method(var_cart, 'set_applied_coupons', [var_applied_coupons.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_applied_coupon'),
		var_coupon_code.clone()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) validate_cart_coupon(mut var_coupon Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon) {
	mut var_coupon_mutated := var_coupon
	if rt.is_true(rt.new_bool(!(rt.is_true(var_coupon_mutated.is_valid())))) {
		mut var_cart := this.get_cart_instance()
		rt.call_method(var_cart, 'remove_coupon', [var_coupon_mutated.get_code()])
		rt.call_method(var_cart, 'calculate_totals', []rt.PhpVal{})
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_error'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('The "%1$s" coupon has been removed from your cart: %2$s'),
				rt.new_string('woocommerce'),
			]),
			var_coupon_mutated.get_code(),
			rt.call_function('wp_strip_all_tags', [
				var_coupon_mutated.get_error_message(),
			]),
		]), rt.new_int(409))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_quantity_in_cart(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_cart := this.get_cart_instance()
	mut var_product_quantities := rt.call_method(var_cart, 'get_cart_item_quantities',
		[]rt.PhpVal{})
	mut var_product_id := rt.call_method(var_product_mutated, 'get_stock_managed_by_id',
		[]rt.PhpVal{})
	return if var_product_quantities.array_isset(var_product_id) {
		var_product_quantities.array_get(var_product_id)
	} else {
		rt.new_int(0)
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_remaining_stock_for_product(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_reserve_stock := create_automattic_woocommerce_checkout_helpers_reservestock()
	mut var_qty_reserved := var_reserve_stock.get_reserved_stock(var_product_mutated.clone(),
		this.get_draft_order_id())
	return rt.sub(rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{}),
		var_qty_reserved)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_for_cart(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_product := rt.call_function('wc_get_product', [
		var_request_mutated.array_get(rt.new_string('id')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), rt.call_method(var_product, 'get_status', []rt.PhpVal{}))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_invalid_product'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Product with ID "%s" was not found and cannot be added to the cart.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_request_mutated.array_get(rt.new_string('id')),
			]),
		]), rt.new_int(400))))
	}
	return var_product.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_id(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	return if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{})
	} else {
		rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_variation_id(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	return if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{ rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) } else { rt.new_int(0) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_product_name(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) string {
	mut var_product_mutated := var_product
	if rt.is_true(rt.identical(rt.call_method(var_product_mutated, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Enums_ProductStatus.draft()))
		|| rt.is_true(rt.identical(rt.call_method(var_product_mutated, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Enums_ProductStatus.private())) {
		return ''
	}
	return (rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) throw_default_product_exception(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) {
	mut var_product_mutated := var_product
	mut var_product_name := rt.new_string(this.get_product_name(mut var_product_mutated))
	if !rt.is_true(var_product_name) {
		mut var_message := rt.call_function('__', [
			rt.new_string('This item is not available for purchase.'),
			rt.new_string('woocommerce'),
		])
	} else {
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('&quot;%s&quot; is not available for purchase.'),
				rt.new_string('woocommerce'),
			]),
			var_product_name.clone(),
		])
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
		[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_not_purchasable'), rt.call_function('esc_html', [
		var_message.clone(),
	]), rt.new_int(400))))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) filter_request_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_product_id := var_request_mutated.array_get(rt.new_string('id'))
	mut var_variation_id := rt.new_int(0)
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		var_product_id = rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
		var_variation_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	}
	var_request_mutated.array_set('cart_item_data', rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_cart_item_data'),
		var_request_mutated.array_get(rt.new_string('cart_item_data')),
		var_product_id.clone(),
		var_variation_id.clone(),
		var_request_mutated.array_get(rt.new_string('quantity')),
	])))
	if rt.is_true(rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{})) {
		var_request_mutated.array_set('quantity', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_sold_individually_quantity'),
			rt.new_int(1),
			var_request_mutated.array_get(rt.new_string('quantity')),
			var_product_id.clone(),
			var_variation_id.clone(),
			var_request_mutated.array_get(rt.new_string('cart_item_data')),
		]))
	}
	return var_request_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) parse_variation_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_product := this.get_product_for_cart(var_request_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variation() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variable() },
		]),
	])))))
	{
		var_request_mutated.array_set('variation', rt.new_array())
		return var_request_mutated.clone()
	}
	mut var_variable_product_attributes := this.get_variable_product_attributes(var_product.clone())
	var_request_mutated.array_set('variation', this.sanitize_variation_data(rt.call_function('wp_list_pluck', [
		var_request_mutated.array_get(rt.new_string('variation')),
		rt.new_string('value'),
		rt.new_string('attribute'),
	]), var_variable_product_attributes.clone()))
	if rt.is_true(rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variable(),
	]))
	{
		var_request_mutated.array_set('id', this.get_variation_id_from_variation_data(var_request_mutated.clone(),
			var_product.clone()))
	}
	mut var_expected_attributes := rt.call_function('wc_get_product_variation_attributes', [
		var_request_mutated.array_get(rt.new_string('id')),
	])
	mut var_missing_attributes := rt.new_array()
	mut iter_8 := var_variable_product_attributes.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_attribute := item_8.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute.array_get(rt.new_string('is_variation')))))) {
			continue
		}
		mut var_prefixed_attribute_name :=
			rt.new_string('attribute_' +(rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])).str())
		mut var_expected_value := if var_expected_attributes.array_isset(var_prefixed_attribute_name) {
			var_expected_attributes.array_get(var_prefixed_attribute_name)
		} else {
			rt.new_string('')
		}
		mut var_attribute_label := rt.call_function('wc_attribute_label', [
			var_attribute.array_get(rt.new_string('name')),
		])
		if var_request_mutated.array_get(rt.new_string('variation')).array_isset(rt.call_function('wc_variation_attribute_name', [
			var_attribute.array_get(rt.new_string('name')),
		]))
		{
			mut var_given_value := var_request_mutated.array_get(rt.new_string('variation')).array_get(rt.call_function('wc_variation_attribute_name', [
				var_attribute.array_get(rt.new_string('name')),
			]))
			if rt.is_true(rt.identical(var_expected_value, var_given_value)) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string(''), var_expected_value))
				&& rt.is_true(rt.call_function('in_array', [var_given_value.clone(), rt.call_method(var_attribute, 'get_slugs', []rt.PhpVal{}), rt.new_bool(true)])) {
				continue
			}
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_variation_data'), rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Invalid value posted for %1$s. Allowed values: %2$s'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					var_attribute_label.clone(),
				]),
				rt.call_function('esc_html', [
					rt.call_function('implode', [rt.new_string(', '),
						rt.call_method(var_attribute, 'get_slugs', []rt.PhpVal{})]),
				]),
			]), rt.new_int(400))))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_expected_value))))
			&& !(var_request_mutated.array_get(rt.new_string('variation')).array_isset(rt.call_function('wc_variation_attribute_name', [var_attribute.array_get(rt.new_string('name'))]))) {
			var_request_mutated.array_get_mut('variation').array_set(rt.call_function('wc_variation_attribute_name', [
				var_attribute.array_get(rt.new_string('name')),
			]), var_expected_value.clone())
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_expected_value)) {
			var_missing_attributes.array_push(var_attribute_label.clone())
		}
	}
	if !(!rt.is_true(var_missing_attributes)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_missing_variation_data'),
			(rt.call_function('esc_html__', [rt.new_string('Missing variation data for variable product.'), rt.new_string('woocommerce')])).str() +
			' ' +(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s is a required field'), rt.new_string('%s are required fields'), rt.new_int(var_missing_attributes.clone().array_count()), rt.new_string('woocommerce')]), rt.call_function('wc_format_list_of_items', [var_missing_attributes.clone()])])])).str(),
			rt.new_int(400))))
	}
	rt.call_function('ksort', [var_request_mutated.array_get(rt.new_string('variation'))])
	return var_request_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_variation_id_from_variation_data(var_request rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_product_mutated := var_product
	mut iife_temp_4 := Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('product'))
	mut var_data_store := iife_result_4
	mut var_match_attributes := var_request_mutated.array_get(rt.new_string('variation'))
	mut var_variation_id := rt.call_method(var_data_store, 'find_matching_product_variation', [
		var_product_mutated.clone(),
		var_match_attributes.clone(),
	])
	if !rt.is_true(var_variation_id) {
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{})
		}
		mut var_required_attributes := rt.call_function('array_filter', [
			rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}),
			rt.new_closure(closure_6_fn),
		])
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value))))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value)))))
		}
		mut var_selected_attributes := rt.call_function('array_filter', [
			var_match_attributes.clone(), rt.new_closure(closure_7_fn)])
		if var_selected_attributes.clone().array_count() < var_required_attributes.clone().array_count() {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_missing_attributes'), rt.call_function('esc_html__', [
				rt.new_string('Missing attributes for variable product.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_variation_id_from_variation_data'), rt.call_function('esc_html__', [
			rt.new_string('No matching variation found.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	return var_variation_id.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) sanitize_variation_data(var_variation_data rt.PhpVal, var_variable_product_attributes rt.PhpVal) rt.PhpVal {
	mut var_variable_product_attributes_mutated := var_variable_product_attributes
	mut var_return := rt.new_array()
	mut iter_9 := var_variable_product_attributes_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_attribute := item_9.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute.array_get(rt.new_string('is_variation')))))) {
			continue
		}
		mut var_variation_attribute_name := rt.call_function('wc_variation_attribute_name', [
			var_attribute.array_get(rt.new_string('name')),
		])
		if var_variation_data.array_isset(var_variation_attribute_name) {
			var_return.array_set(var_variation_attribute_name, if rt.is_true(var_attribute.array_get(rt.new_string('is_taxonomy'))) { rt.call_function('sanitize_title', [
					var_variation_data.array_get(var_variation_attribute_name),
				]) } else { rt.call_function('html_entity_decode', [
					rt.call_function('wc_clean', [
						var_variation_data.array_get(var_variation_attribute_name),
					]),
					rt.get_constant('ENT_QUOTES'),
					rt.call_function('get_bloginfo', [
						rt.new_string('charset'),
					]),
				]) })
			continue
		}
		mut var_attribute_label := rt.call_function('wc_attribute_label', [
			var_attribute.array_get(rt.new_string('name')),
		])
		mut var_lowercase_attribute_label :=
			rt.new_string(var_attribute_label.clone().to_string().to_lower())
		if var_variation_data.array_isset(var_attribute_label)
			|| var_variation_data.array_isset(var_lowercase_attribute_label) {
			var_attribute_label = if var_variation_data.array_isset(var_attribute_label) {
				var_attribute_label
			} else {
				var_lowercase_attribute_label
			}
			var_return.array_set(var_variation_attribute_name, if rt.is_true(var_attribute.array_get(rt.new_string('is_taxonomy'))) { rt.call_function('sanitize_title', [
					var_variation_data.array_get(var_attribute_label),
				]) } else { rt.call_function('html_entity_decode', [
					rt.call_function('wc_clean', [var_variation_data.array_get(var_attribute_label)]),
					rt.get_constant('ENT_QUOTES'),
					rt.call_function('get_bloginfo', [rt.new_string('charset')]),
				]) })
			continue
		}
		if var_variation_data.array_isset(var_attribute.array_get(rt.new_string('name'))) {
			var_return.array_set(var_variation_attribute_name, if rt.is_true(var_attribute.array_get(rt.new_string('is_taxonomy'))) { rt.call_function('sanitize_title', [
					var_variation_data.array_get(var_attribute.array_get(rt.new_string('name'))),
				]) } else { rt.call_function('html_entity_decode', [
					rt.call_function('wc_clean', [
						var_variation_data.array_get(var_attribute.array_get(rt.new_string('name'))),
					]),
					rt.get_constant('ENT_QUOTES'),
					rt.call_function('get_bloginfo', [
						rt.new_string('charset'),
					]),
				]) })
		}
	}
	return var_return.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) get_variable_product_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		var_product_mutated = rt.call_function('wc_get_product', [
			rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_mutated))))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), rt.call_method(var_product_mutated, 'get_status', []rt.PhpVal{}))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_invalid_parent_product'), rt.call_function('esc_html__', [
			rt.new_string('This product cannot be added to the cart.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	return rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{})
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

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Discounts {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_quantitylimits(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_noticehandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_NoticeHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_arrayutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_invalidcartexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_notpurchasableexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_toomanyincartexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_outofstockexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_partialoutofstockexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_coupon(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_discounts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Discounts {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_checkout_helpers_reservestock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			return this.stock_exceptions_to_wp_errors(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_product_id(mut dispatch_arg_0)
		}
		'get_variation_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_variation_id(mut dispatch_arg_0)
		}
		'get_product_name' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_product_name(mut dispatch_arg_0))
		}
		'throw_default_product_exception' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_NotPurchasableException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_TooManyInCartException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_PartialOutOfStockException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

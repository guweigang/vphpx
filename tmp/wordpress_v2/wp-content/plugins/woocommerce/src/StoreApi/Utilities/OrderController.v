import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
pub mut:
	additional_fields_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_0 := iife_temp_0.container()
	this.additional_fields_controller = rt.call_method(iife_result_0, 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) create_order_from_cart() rt.PhpVal {
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'),
		'is_empty', []rt.PhpVal{}))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_empty'), rt.call_function('__', [
			rt.new_string('Cannot create order from empty cart.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_default_order_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'default_order_status' },
		])])
	mut var_order := create_automattic_woocommerce_storeapi_utilities_wc_order()
	rt.call_method(var_order, 'set_status', [rt.new_string('checkout-draft')])
	rt.call_method(var_order, 'set_created_via', [rt.new_string('store-api')])
	this.update_order_from_cart(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](var_order),
		false)
	rt.call_function('remove_filter', [rt.new_string('woocommerce_default_order_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'default_order_status' },
		])])
	return var_order.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) update_order_from_cart(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, update_totals bool) {
	mut var_order_mutated := var_order
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer').is_null()) {
			mut var_taxable_address := rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_taxable_address', []rt.PhpVal{})
			var_location = rt.create_array([
				rt.ArrayItem{ key: 'country', val: var_taxable_address.array_get(rt.new_int(0)) },
				rt.ArrayItem{ key: 'state', val: var_taxable_address.array_get(rt.new_int(1)) },
				rt.ArrayItem{ key: 'postcode', val: var_taxable_address.array_get(rt.new_int(2)) },
				rt.ArrayItem{ key: 'city', val: var_taxable_address.array_get(rt.new_int(3)) },
			])
		}
		return
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_get_tax_location'),
		rt.new_closure(closure_2_fn)])
	if var_update_totals {
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'),
			'calculate_totals', []rt.PhpVal{})
	}
	this.update_line_items_from_cart(mut var_order_mutated)
	this.update_addresses_from_cart(mut var_order_mutated)
	rt.call_method(var_order_mutated, 'set_currency', [
		rt.call_function('get_woocommerce_currency', []rt.PhpVal{}),
	])
	rt.call_method(var_order_mutated, 'set_prices_include_tax', [
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_prices_include_tax'),
		])),
	])
	rt.call_method(var_order_mutated, 'set_customer_id', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	mut iife_temp_2 := Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation{}
	mut iife_result_2 := iife_temp_2.get_ip_address()
	rt.call_method(var_order_mutated, 'set_customer_ip_address', [iife_result_2])
	rt.call_method(var_order_mutated, 'set_customer_user_agent', [
		rt.call_function('wc_get_user_agent', []rt.PhpVal{}),
	])
	mut iife_temp_3 := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{}
	mut iife_result_3 := iife_temp_3.get_default_payment_method()
	rt.call_method(var_order_mutated, 'set_payment_method', [iife_result_3])
	rt.call_method(var_order_mutated, 'update_meta_data', [
		rt.new_string('is_vat_exempt'),
		rt.call_function('wc_bool_to_string', [
			rt.call_method(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
				'cart'), 'get_customer', []rt.PhpVal{}), 'get_is_vat_exempt', []rt.PhpVal{}),
		]),
	])
	rt.call_method(var_order_mutated, 'calculate_totals', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) sync_customer_data_with_order(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})) {
		mut var_customer := create_automattic_woocommerce_storeapi_utilities_wc_customer(rt.call_method(var_order_mutated,
			'get_customer_id', []rt.PhpVal{}))
		var_customer.set_props(rt.create_array([
			rt.ArrayItem{ key: 'billing_first_name', val: rt.call_method(var_order_mutated,
				'get_billing_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_last_name', val: rt.call_method(var_order_mutated,
				'get_billing_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_company', val: rt.call_method(var_order_mutated,
				'get_billing_company', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_address_1', val: rt.call_method(var_order_mutated,
				'get_billing_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_address_2', val: rt.call_method(var_order_mutated,
				'get_billing_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_city', val: rt.call_method(var_order_mutated,
				'get_billing_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_state', val: rt.call_method(var_order_mutated,
				'get_billing_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_postcode', val: rt.call_method(var_order_mutated,
				'get_billing_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_country', val: rt.call_method(var_order_mutated,
				'get_billing_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_email', val: rt.call_method(var_order_mutated,
				'get_billing_email', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_phone', val: rt.call_method(var_order_mutated,
				'get_billing_phone', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_first_name', val: rt.call_method(var_order_mutated,
				'get_shipping_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_last_name', val: rt.call_method(var_order_mutated,
				'get_shipping_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_company', val: rt.call_method(var_order_mutated,
				'get_shipping_company', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_address_1', val: rt.call_method(var_order_mutated,
				'get_shipping_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_address_2', val: rt.call_method(var_order_mutated,
				'get_shipping_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_city', val: rt.call_method(var_order_mutated,
				'get_shipping_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_state', val: rt.call_method(var_order_mutated,
				'get_shipping_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_postcode', val: rt.call_method(var_order_mutated,
				'get_shipping_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_country', val: rt.call_method(var_order_mutated,
				'get_shipping_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_phone', val: rt.call_method(var_order_mutated,
				'get_shipping_phone', []rt.PhpVal{}) },
		]))
		rt.call_method(this.additional_fields_controller,
			'sync_customer_additional_fields_with_order', [var_order_mutated, var_customer])
		var_customer.save()
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_order_before_payment(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_needs_shipping := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
		'cart'), 'needs_shipping', []rt.PhpVal{})
	mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('wc',
		[]rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'),
		rt.new_array()])
	this.validate_coupons(mut var_order_mutated, false)
	this.validate_email(mut var_order_mutated)
	this.validate_selected_shipping_methods(var_needs_shipping.clone(),
		var_chosen_shipping_methods.clone())
	this.validate_addresses(mut var_order_mutated, var_needs_shipping.to_bool())
	this.perform_custom_order_validation(mut var_order_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_existing_order_before_payment(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_needs_shipping := rt.call_method(var_order_mutated, 'needs_shipping', []rt.PhpVal{})
	this.validate_coupons(mut var_order_mutated, true)
	this.validate_email(mut var_order_mutated)
	this.validate_addresses(mut var_order_mutated, var_needs_shipping.to_bool())
	this.perform_custom_order_validation(mut var_order_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) perform_custom_order_validation(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_validation_errors := create_automattic_woocommerce_storeapi_utilities_wp_error()
	rt.call_function('do_action', [
		rt.new_string('woocommerce_checkout_validate_order_before_payment'),
		var_order_mutated,
		var_validation_errors,
	])
	if rt.is_true(var_validation_errors.has_errors()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_checkout_custom_validation_error'), rt.call_function('esc_html', [
			rt.call_function('implode',
				[rt.new_string(' '), var_validation_errors.get_error_messages()]),
		]), rt.new_int(400))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_coupon(var_coupon_code rt.PhpVal) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon', []string{},
		create_automattic_woocommerce_storeapi_utilities_wc_coupon(var_coupon_code.clone()))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_coupons(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, use_order_data bool) {
	mut var_order_mutated := var_order
	mut var_coupon_codes := rt.call_method(var_order_mutated, 'get_coupon_codes', []rt.PhpVal{})
	mut var_coupons := rt.call_function('array_filter', [
		rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_coupon' },
			]),
			var_coupon_codes.clone(),
		]),
	])
	mut var_validators := rt.create_array([
		rt.ArrayItem{ key: none, val: 'validate_coupon_email_restriction' },
		rt.ArrayItem{ key: none, val: 'validate_coupon_usage_limit' },
	])
	mut var_coupon_errors := rt.new_array()
	mut iter_1 := var_coupons.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_coupon := item_1.val
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_validator := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_index := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut var_params := if args.len > 2 { args[2].clone() } else { rt.new_null() }
			rt.call_function('call_user_func_array', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: var_validator },
				]),
				var_params.clone(),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			return rt.new_null()
		}
		rt.call_function('array_walk', [var_validators.clone(),
			rt.new_closure(closure_5_fn),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_coupon },
				rt.ArrayItem{ key: none, val: var_order_mutated },
			])])
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
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_error := var_e_1.clone()
			var_coupon_errors.array_set(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}), rt.call_method(var_error,
				'getMessage', []rt.PhpVal{}))
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
	if rt.is_true(var_coupon_errors) {
		if var_use_order_data {
			mut var_error_code := rt.new_string('woocommerce_rest_order_coupon_errors')
			mut iter_2 := var_coupon_errors.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_message := item_2.val
				mut var_coupon_code := item_2.key
				rt.call_method(var_order_mutated, 'remove_coupon', [
					var_coupon_code.clone()])
			}
			rt.call_method(var_order_mutated, 'calculate_totals', []rt.PhpVal{})
		} else {
			var_error_code = rt.new_string('woocommerce_rest_cart_coupon_errors')
			mut iter_3 := var_coupon_errors.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_message := item_3.val
				mut var_coupon_code := item_3.key
				rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'),
					'remove_coupon', [var_coupon_code.clone()])
			}
			rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'),
				'calculate_totals', []rt.PhpVal{})
			this.update_order_from_cart(mut var_order_mutated, false)
		}
		if 1 == var_coupon_errors.clone().array_count() && var_use_order_data {
			mut var_error_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('"%1$s" was removed from the order. %2$s'),
					rt.new_string('woocommerce'),
				]),
				rt.func_array_keys(var_coupon_errors.clone()).array_get(rt.new_int(0)),
				rt.call_function('array_values', [
					var_coupon_errors.clone(),
				]).array_get(rt.new_int(0)),
			])
		} else if 1 == var_coupon_errors.clone().array_count() {
			var_error_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('"%1$s" was removed from the cart. %2$s'),
					rt.new_string('woocommerce'),
				]),
				rt.func_array_keys(var_coupon_errors.clone()).array_get(rt.new_int(0)),
				rt.call_function('array_values', [
					var_coupon_errors.clone(),
				]).array_get(rt.new_int(0)),
			])
		} else if var_use_order_data {
			var_error_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Invalid coupons were removed from the order: "%s"'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('implode', [
					rt.new_string('", "'),
					rt.func_array_keys(var_coupon_errors.clone()),
				]),
			])
		} else {
			var_error_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Invalid coupons were removed from the cart: "%s"'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('implode', [
					rt.new_string('", "'),
					rt.func_array_keys(var_coupon_errors.clone()),
				]),
			])
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(var_error_code.clone(),
			var_error_message.clone(), rt.new_int(409), rt.create_array([
			rt.ArrayItem{ key: 'removed_coupons', val: var_coupon_errors },
		]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_email(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	if !rt.is_true(var_email) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_missing_email_address'), rt.call_function('__', [
			rt.new_string('A valid email address is required'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_email.clone()])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_email_address'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The provided email address (%s) is not valid—please provide a valid email address'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_email.clone(),
			]),
		]), rt.new_int(400))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_addresses(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, needs_shipping bool) {
	mut var_order_mutated := var_order
	mut needs_shipping_mutated := needs_shipping
	mut var_errors := create_automattic_woocommerce_storeapi_utilities_wp_error()
	mut var_billing_country := rt.call_method(var_order_mutated, 'get_billing_country',
		[]rt.PhpVal{})
	mut var_shipping_country := rt.call_method(var_order_mutated, 'get_shipping_country',
		[]rt.PhpVal{})
	if rt.is_true(rt.new_bool(needs_shipping_mutated)) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
		mut iife_result_5 := iife_temp_5.get_local_pickup_method_ids()
		mut var_local_pickup_method_ids := iife_result_5
		mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_ShippingUtil{}
		mut iife_result_6 := iife_temp_6.get_selected_shipping_rates_from_packages(rt.call_method(rt.call_method(rt.call_function('WC',
			[]rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{}))
		mut var_selected_shipping_rates := iife_result_6
		closure_8_fn := fn [var_local_pickup_method_ids] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_rate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_8 := iife_temp_8.array_all(var_selected_shipping_rates.clone(),
			rt.new_closure(closure_8_fn))
		mut var_selected_shipping_rates_are_all_local_pickup := iife_result_8
		if rt.is_true(rt.new_bool(!(rt.is_true(var_selected_shipping_rates_are_all_local_pickup))))
			&& !(this.validate_allowed_country(var_shipping_country.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](rt.cast_array(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}))))) {
			mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})
			mut var_shipping_country_name := if !(var_countries.array_get(var_shipping_country)).is_null() {
				var_countries.array_get(var_shipping_country)
			} else {
				var_shipping_country
			}
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_address_country'), rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, we do not ship orders to the provided country (%s)'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					var_shipping_country_name.clone(),
				]),
			]), rt.new_int(400), rt.create_array([
				rt.ArrayItem{ key: 'allowed_countries', val: rt.call_function('array_map', [
					rt.new_string('esc_html'),
					rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('wc',
						[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})),
				]) },
			]))))
		}
	}
	if !(this.validate_allowed_country(var_billing_country.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](rt.cast_array(rt.call_method(rt.get_property(rt.call_function('wc',
		[]rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{}))))) {
		var_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_countries', []rt.PhpVal{})
		mut var_billing_country_name := if !(var_countries.array_get(var_billing_country)).is_null() {
			var_countries.array_get(var_billing_country)
		} else {
			var_billing_country
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_address_country'), rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, we do not allow orders from the provided country (%s)'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_billing_country_name.clone(),
			]),
		]), rt.new_int(400), rt.create_array([
			rt.ArrayItem{ key: 'allowed_countries', val: rt.call_function('array_map', [
				rt.new_string('esc_html'),
				rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('wc',
					[]rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})),
			]) },
		]))))
	}
	if rt.is_true(rt.new_bool(needs_shipping_mutated)) {
		this.validate_address_fields(mut var_order_mutated, rt.new_string('shipping'), mut
			var_errors)
	}
	this.validate_address_fields(mut var_order_mutated, rt.new_string('billing'), mut var_errors)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_errors.has_errors())))) {
		return
	}
	mut var_errors_by_code := rt.new_array()
	mut var_error_codes := var_errors.get_error_codes()
	mut iter_4 := var_error_codes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_code := item_4.val
		var_errors_by_code.array_set(var_code, var_errors.get_error_messages(var_code.clone()))
	}
	mut iter_5 := var_errors_by_code.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_error_messages := item_5.val
		mut var_code := item_5.key
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_address'), rt.call_function('sprintf', [
			rt.new_string(
				(rt.call_function('esc_html__', [rt.new_string('There was a problem with the provided %s:'), rt.new_string('woocommerce')])).str() +
				' ' +(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(', '), var_error_messages.clone()])])).str()),
			if rt.is_true(rt.identical(rt.new_string('shipping'), var_code)) { rt.call_function('esc_html__', [
					rt.new_string('shipping address'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('esc_html__', [
					rt.new_string('billing address'),
					rt.new_string('woocommerce'),
				]) },
		]), rt.new_int(400), rt.create_array([
			rt.ArrayItem{ key: 'errors', val: var_errors_by_code },
		]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_allowed_country(var_country rt.PhpVal, mut var_allowed_countries Class_Automattic_WooCommerce_StoreApi_Utilities_array) bool {
	return var_allowed_countries.array_isset(var_country.clone())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_address_fields(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, var_address_type rt.PhpVal, mut var_errors Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) {
	mut var_order_mutated := var_order
	mut var_errors_mutated := var_errors
	mut var_all_locales := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
		'countries'), 'get_country_locale', []rt.PhpVal{})
	mut var_address := rt.call_method(var_order_mutated, 'get_address', [
		var_address_type.clone()])
	mut var_current_locale := if !(var_all_locales.array_get(var_address.array_get(rt.new_string('country')))).is_null() {
		var_all_locales.array_get(var_address.array_get(rt.new_string('country')))
	} else {
		rt.new_array()
	}
	mut iter_6 := var_all_locales.array_get(rt.new_string('default')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		var_current_locale.array_set(var_key, if !(!rt.is_true(var_current_locale.array_get(var_key))) { rt.call_function('wp_parse_args', [
				var_current_locale.array_get(var_key),
				var_value.clone(),
			]) } else { var_value })
	}
	mut var_additional_fields := rt.call_method(this.additional_fields_controller,
		'get_all_fields_from_object', [var_order_mutated, var_address_type.clone()])
	var_address = rt.call_function('array_merge', [var_address.clone(),
		var_additional_fields.clone()])
	mut iter_7 := var_current_locale.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_address_field := item_7.val
		mut var_address_field_key := item_7.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [if !(var_address_field.array_get(rt.new_string('required'))).is_null() { var_address_field.array_get(rt.new_string('required')) } else { rt.new_bool(false) }])))))
			|| rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [if !(var_address_field.array_get(rt.new_string('hidden'))).is_null() { var_address_field.array_get(rt.new_string('hidden')) } else { rt.new_bool(false) }]))) {
			continue
		}
		mut var_is_empty := rt.new_bool(!(var_address.array_isset(var_address_field_key))
			|| (var_address.array_get(var_address_field_key).is_string()
			&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_address.array_get(var_address_field_key).to_string().trim_space()))))
			|| var_address.array_get(var_address_field_key).is_array()
			&& 0 == var_address.array_get(var_address_field_key).array_count())
		if rt.is_true(var_is_empty) {
			var_errors_mutated.add(var_address_type.clone(), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s is required'),
					rt.new_string('woocommerce')]),
				var_address_field.array_get(rt.new_string('label')),
			]), var_address_field_key.clone())
		}
	}
	mut var_result := rt.call_method(this.additional_fields_controller,
		'validate_fields_for_location', [var_address.clone(),
		rt.new_string('address'), var_address_type.clone()])
	if rt.is_true(rt.call_method(var_result, 'has_errors', []rt.PhpVal{})) {
		mut iter_8 := rt.call_method(var_result, 'get_error_codes', []rt.PhpVal{}).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_code := item_8.val
			var_errors_mutated.add(var_address_type.clone(), rt.call_method(var_result,
				'get_error_message', [var_code.clone()]), var_code.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_coupon_email_restriction(mut var_coupon Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon, mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_restrictions := var_coupon.get_email_restrictions()
	if !rt.is_true(var_restrictions) {
		return
	}
	mut var_check_emails := rt.new_array()
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_current_user, 'exists', []rt.PhpVal{})) {
		mut var_user_email := rt.new_string(rt.call_function('sanitize_email', [
			rt.get_property(var_current_user, 'user_email'),
		]).to_string().trim_space())
		if !(!rt.is_true(var_user_email)) {
			var_check_emails.array_push(var_user_email.clone().to_string().to_lower())
		}
	}
	mut var_billing_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	if !(!rt.is_true(var_billing_email)) {
		var_billing_email = rt.new_string(rt.call_function('sanitize_email', [
			var_billing_email.clone()]).to_string().trim_space())
		if !(!rt.is_true(var_billing_email)) {
			var_check_emails.array_push(var_billing_email.clone().to_string().to_lower())
		}
	}
	var_check_emails = rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_check_emails.clone()]),
	])
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_DiscountsUtil{}
	mut iife_result_9 := iife_temp_9.is_coupon_emails_allowed(var_check_emails.clone(),
		var_restrictions.clone())
	if !(!rt.is_true(var_check_emails)) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_9)))) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(var_coupon.get_coupon_error(Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon.e_wc_coupon_not_yours_removed()))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_coupon_usage_limit(mut var_coupon Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon, mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_coupon_usage_limit := var_coupon.get_usage_limit_per_user()
	if rt.is_true(rt.identical(rt.new_int(0), var_coupon_usage_limit)) {
		return
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})) {
		mut var_usage_count := this.get_usage_per_aliases(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon',
			[]string{}, var_coupon), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_billing_email',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_customer_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: this.get_email_from_user_id(rt.call_method(var_order_mutated,
				'get_customer_id', []rt.PhpVal{})) },
		]))
	} else {
		mut var_user_ids := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Customers_SearchService.class(),
		]), 'find_user_ids_by_billing_email_for_coupons_usage_lookup', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated,
					'get_billing_email', []rt.PhpVal{}) },
			]),
		])
		mut var_user_emails := rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_email_from_user_id' },
			]),
			var_user_ids.clone(),
		])
		mut var_found_user := rt.call_function('get_user_by', [
			rt.new_string('email'),
			rt.call_method(var_order_mutated, 'get_billing_email',
				[]rt.PhpVal{})])
		if rt.is_true(var_found_user) {
			var_user_ids.array_push(rt.get_property(var_found_user, 'ID'))
			var_user_emails.array_push(rt.get_property(var_found_user, 'user_email'))
			var_user_emails.array_push(rt.call_function('get_user_meta', [
				rt.get_property(var_found_user, 'ID'),
				rt.new_string('billing_email'),
				rt.new_bool(true),
			]))
		}
		var_usage_count = this.get_usage_per_aliases(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon',
			[]string{}, var_coupon), rt.call_function('array_merge', [
			var_user_emails.clone(), var_user_ids.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated,
					'get_billing_email', []rt.PhpVal{}) },
			])]))
	}
	if rt.is_true(rt.greater_equal(var_usage_count, var_coupon_usage_limit)) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(var_coupon.get_coupon_error(Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon.e_wc_coupon_usage_limit_reached()))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_email_from_user_id(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user_data := rt.call_function('get_userdata', [var_user_id.clone()])
	return if rt.is_true(var_user_data) {
		rt.get_property(var_user_data, 'user_email')
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_usage_per_aliases(var_coupon rt.PhpVal, var_aliases rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_aliases_mutated := var_aliases
	var_aliases_mutated = rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_aliases_mutated.clone()]),
	])
	mut var_aliases_string := rt.new_string("('" +
		(rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_aliases_mutated.clone()])])).str() +
		"')")
	mut var_usage_count := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT( meta_id ) FROM '), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" WHERE post_id = %d AND meta_key = '_used_by' AND meta_value IN ")),
				var_aliases_string), rt.new_string(';')),
			rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}),
		]),
	])
	mut var_data_store := rt.call_method(var_coupon, 'get_data_store', []rt.PhpVal{})
	mut var_tentative_usage_count := rt.call_method(var_data_store,
		'get_tentative_usages_for_user', [
		rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}),
		var_aliases_mutated.clone(),
	])
	return rt.add(var_tentative_usage_count, var_usage_count)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_selected_shipping_methods(var_needs_shipping rt.PhpVal, var_chosen_shipping_methods rt.PhpVal) {
	mut var_needs_shipping_mutated := var_needs_shipping
	mut var_chosen_shipping_methods_mutated := var_chosen_shipping_methods
	if rt.is_true(rt.new_bool(!(rt.is_true(var_needs_shipping_mutated)))) {
		return
	}
	mut var_exception := create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_shipping_option'), rt.call_function('__', [
		rt.new_string('Sorry, this order requires a shipping option.'),
		rt.new_string('woocommerce'),
	]), rt.new_int(400), rt.new_array())
	if !(var_chosen_shipping_methods_mutated.clone().is_array())
		|| !rt.is_true(var_chosen_shipping_methods_mutated) {
		rt.throw_exception(var_exception)
	}
	mut var_packages := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
	mut iter_9 := var_packages.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_package := item_9.val
		mut var_package_id := item_9.key
		mut var_chosen_rate_for_package :=
			var_chosen_shipping_methods_mutated.array_get(var_package_id)
		mut var_valid_rate_ids_for_package := rt.call_function('wp_list_pluck', [
			var_package.array_get(rt.new_string('rates')),
			rt.new_string('id'),
		])
		mut iife_temp_10 := Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{}
		mut iife_result_10 := iife_temp_10.string_contains_array(var_chosen_rate_for_package.clone(),
			var_valid_rate_ids_for_package.clone())
		if !(var_chosen_rate_for_package.clone().is_string())
			|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_10)))) {
			rt.throw_exception(var_exception)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_order_key(var_order_id rt.PhpVal, var_order_key rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_order_key))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_order_id))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_order'), rt.call_function('__', [
			rt.new_string('Invalid order ID or key provided.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(401))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_failed_order_stock_error(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [
		rt.call_function('wc_get_is_pending_statuses', []rt.PhpVal{}),
	])))))
	{
		mut var_quantities := rt.new_array()
		mut iter_10 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_item := item_10.val
			mut var_item_key := item_10.key
			if rt.is_true(var_item)
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: var_item
			}, rt.ArrayItem{ key: none, val: 'get_product' }])]) {
				mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
					continue
				}
				var_quantities.array_set(rt.call_method(var_product, 'get_stock_managed_by_id',
					[]rt.PhpVal{}), if var_quantities.array_isset(rt.call_method(var_product,
					'get_stock_managed_by_id', []rt.PhpVal{}))
				{
					rt.add(var_quantities.array_get(rt.call_method(var_product,
						'get_stock_managed_by_id', []rt.PhpVal{})), rt.call_method(var_item,
						'get_quantity', []rt.PhpVal{}))
				} else {
					rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
				})
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_order,
			'get_data_store', []rt.PhpVal{}), 'get_stock_reduced', [
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		])))))
		{
			mut iter_11 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_item := item_11.val
				mut var_item_key := item_11.key
				if rt.is_true(var_item)
					&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
					key: none
					val: var_item
				}, rt.ArrayItem{ key: none, val: 'get_product' }])]) {
					mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
					if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
						continue
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
						rt.new_string('woocommerce_pay_order_product_in_stock'),
						rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{}),
						var_product.clone(),
						var_order.clone(),
					])))))
					{
						return rt.create_array([
							rt.ArrayItem{ key: 'code', val: 'woocommerce_rest_out_of_stock' },
							rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('Sorry, "%s" is no longer in stock so this order cannot be paid for. We apologize for any inconvenience caused.'),
									rt.new_string('woocommerce'),
								]),
								rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
							]) },
						])
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})))))
						|| rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})) {
						continue
					}
					mut var_held_stock := rt.call_function('wc_get_held_stock_quantity', [
						var_product.clone(),
						rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
					])
					mut var_required_stock := var_quantities.array_get(rt.call_method(var_product,
						'get_stock_managed_by_id', []rt.PhpVal{}))
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
						rt.new_string('woocommerce_pay_order_product_has_enough_stock'),
						rt.greater_equal(rt.call_method(var_product, 'get_stock_quantity',
							[]rt.PhpVal{}), rt.add(var_held_stock, var_required_stock)),
						var_product.clone(),
						var_order.clone(),
					])))))
					{
						return rt.create_array([
							rt.ArrayItem{ key: 'code', val: 'woocommerce_rest_out_of_stock' },
							rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('Sorry, we do not have enough "%1$s" in stock to fulfill your order (%2$s available). We apologize for any inconvenience caused.'),
									rt.new_string('woocommerce'),
								]),
								rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
								rt.call_function('wc_format_stock_quantity_for_display', [
									rt.sub(rt.call_method(var_product, 'get_stock_quantity',
										[]rt.PhpVal{}), var_held_stock),
									var_product.clone(),
								]),
							]) },
						])
					}
				}
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) default_order_status() string {
	return 'checkout-draft'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) update_line_items_from_cart(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	mut var_cart_controller := create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	mut var_cart := var_cart_controller.get_cart_instance()
	mut var_cart_hashes := var_cart_controller.get_cart_hashes()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_cart_hash', []rt.PhpVal{}), var_cart_hashes.array_get(rt.new_string('line_items'))))))
	{
		rt.call_method(var_order_mutated, 'set_cart_hash', [
			var_cart_hashes.array_get(rt.new_string('line_items')),
		])
		rt.call_method(var_order_mutated, 'remove_order_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
		])
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'checkout'),
			'create_order_line_items', [var_order_mutated, var_cart.clone()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_meta', [rt.new_string('_shipping_hash')]),
		var_cart_hashes.array_get(rt.new_string('shipping'))))))
	{
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('_shipping_hash'),
			var_cart_hashes.array_get(rt.new_string('shipping')),
		])
		rt.call_method(var_order_mutated, 'remove_order_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.shipping(),
		])
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'checkout'),
			'create_order_shipping_lines', [var_order_mutated,
			rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'),
				'get', [rt.new_string('chosen_shipping_methods')]),
			rt.call_method(rt.call_method(rt.call_function('wc', []rt.PhpVal{}), 'shipping',
				[]rt.PhpVal{}), 'get_packages', []rt.PhpVal{})])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_meta', [rt.new_string('_coupons_hash')]),
		var_cart_hashes.array_get(rt.new_string('coupons'))))))
	{
		rt.call_method(var_order_mutated, 'remove_order_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.coupon(),
		])
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('_coupons_hash'),
			var_cart_hashes.array_get(rt.new_string('coupons')),
		])
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'checkout'),
			'create_order_coupon_lines', [var_order_mutated, var_cart.clone()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_meta', [rt.new_string('_fees_hash')]),
		var_cart_hashes.array_get(rt.new_string('fees'))))))
	{
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('_fees_hash'),
			var_cart_hashes.array_get(rt.new_string('fees')),
		])
		rt.call_method(var_order_mutated, 'remove_order_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.fee(),
		])
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'checkout'),
			'create_order_fee_lines', [var_order_mutated, var_cart.clone()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_meta', [rt.new_string('_taxes_hash')]),
		var_cart_hashes.array_get(rt.new_string('taxes'))))))
	{
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('_taxes_hash'),
			var_cart_hashes.array_get(rt.new_string('taxes')),
		])
		rt.call_method(var_order_mutated, 'remove_order_items', [
			Class_Automattic_WooCommerce_Enums_OrderItemType.tax(),
		])
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'checkout'),
			'create_order_tax_lines', [var_order_mutated, var_cart.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) update_addresses_from_cart(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) {
	mut var_order_mutated := var_order
	rt.call_method(var_order_mutated, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'billing_first_name', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_last_name', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_company', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_company', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_address_1', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_address_2', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_city', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_state', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_postcode', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_country', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_email', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_email', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'billing_phone', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_billing_phone', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_first_name', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_last_name', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_company', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_company', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_address_1', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_address_2', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_city', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_state', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_postcode', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_country', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'shipping_phone', val: rt.call_method(rt.get_property(rt.call_function('wc',
				[]rt.PhpVal{}), 'customer'), 'get_shipping_phone', []rt.PhpVal{}) },
		]),
	])
	rt.call_method(this.additional_fields_controller, 'sync_order_additional_fields_with_customer', [
		var_order_mutated,
		rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'),
	])
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase:                rt.PhpObjectBase{}
		additional_fields_controller: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
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

fn create_automattic_woocommerce_storeapi_utilities_wc_order(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_geolocation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_paymentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_customer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error{
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

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_shippingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ShippingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_discountsutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_DiscountsUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_arrayutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ArrayUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'create_order_from_cart' {
			return this.create_order_from_cart()
		}
		'update_order_from_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_order_from_cart(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sync_customer_data_with_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.sync_customer_data_with_order(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_order_before_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.validate_order_before_payment(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_existing_order_before_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.validate_existing_order_before_payment(mut dispatch_arg_0)
			return rt.new_null()
		}
		'perform_custom_order_validation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.perform_custom_order_validation(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupon(dispatch_arg_0)
		}
		'validate_coupons' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.validate_coupons(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.validate_email(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_addresses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.validate_addresses(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_allowed_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.validate_allowed_country(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_address_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.validate_address_fields(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'validate_coupon_email_restriction' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.validate_coupon_email_restriction(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'validate_coupon_usage_limit' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.validate_coupon_usage_limit(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_email_from_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_from_user_id(dispatch_arg_0)
		}
		'get_usage_per_aliases' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_usage_per_aliases(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_selected_shipping_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_selected_shipping_methods(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_order_key(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_failed_order_stock_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_failed_order_stock_error(dispatch_arg_0)
		}
		'default_order_status' {
			return rt.new_string(this.default_order_status())
		}
		'update_line_items_from_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.update_line_items_from_cart(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_addresses_from_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.update_addresses_from_cart(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'additional_fields_controller' { return this.additional_fields_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'additional_fields_controller' {
			this.additional_fields_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

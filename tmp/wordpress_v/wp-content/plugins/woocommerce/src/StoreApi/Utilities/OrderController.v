import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
pub mut:
		additional_fields_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) construct()  {
	this.additional_fields_controller = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields.class()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) create_order_from_cart() rt.PhpVal {
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_empty'), rt.call_function('__', [rt.new_string('Cannot create order from empty cart.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_default_order_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'default_order_status' }])])
	mut var_order := create_automattic_woocommerce_storeapi_utilities_wc_order()
	rt.call_method(var_order, 'set_status', [rt.new_string('checkout-draft')])
	rt.call_method(var_order, 'set_created_via', [rt.new_string('store-api')])
	this.update_order_from_cart(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](var_order), false)
	rt.call_function('remove_filter', [rt.new_string('woocommerce_default_order_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'default_order_status' }])])
	return var_order.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) update_order_from_cart(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, update_totals bool)  {
	mut var_order_mutated := var_order
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_location := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer').is_null()))))) {
		mut var_taxable_address := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'), 'get_taxable_address', []rt.PhpVal{})
		var_location = rt.create_array([rt.ArrayItem{ key: 'country', val: var_taxable_address.array_get(0) }, rt.ArrayItem{ key: 'state', val: var_taxable_address.array_get(1) }, rt.ArrayItem{ key: 'postcode', val: var_taxable_address.array_get(2) }, rt.ArrayItem{ key: 'city', val: var_taxable_address.array_get(3) }])
	}
	return var_location.dup()
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_get_tax_location'), rt.new_closure(closure_1_fn)])
	if var_update_totals {
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'calculate_totals', []rt.PhpVal{})
	}
	this.update_line_items_from_cart(mut var_order_mutated)
	this.update_addresses_from_cart(mut var_order_mutated)
	rt.call_method(var_order_mutated, 'set_currency', [rt.call_function('get_woocommerce_currency', []rt.PhpVal{})])
	rt.call_method(var_order_mutated, 'set_prices_include_tax', [rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')]))])
	rt.call_method(var_order_mutated, 'set_customer_id', [rt.call_function('get_current_user_id', []rt.PhpVal{})])
	rt.call_method(var_order_mutated, 'set_customer_ip_address', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation{}; return temp.get_ip_address() }()])
	rt.call_method(var_order_mutated, 'set_customer_user_agent', [rt.call_function('wc_get_user_agent', []rt.PhpVal{})])
	rt.call_method(var_order_mutated, 'set_payment_method', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{}; return temp.get_default_payment_method() }()])
	rt.call_method(var_order_mutated, 'update_meta_data', [rt.new_string('is_vat_exempt'), rt.call_function('wc_bool_to_string', [rt.call_method(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'get_customer', []rt.PhpVal{}), 'get_is_vat_exempt', []rt.PhpVal{})])])
	rt.call_method(var_order_mutated, 'calculate_totals', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) sync_customer_data_with_order(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})) {
		mut var_customer := create_automattic_woocommerce_storeapi_utilities_wc_customer(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}))
		var_customer.set_props(rt.create_array([rt.ArrayItem{ key: 'billing_first_name', val: rt.call_method(var_order_mutated, 'get_billing_first_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_last_name', val: rt.call_method(var_order_mutated, 'get_billing_last_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_company', val: rt.call_method(var_order_mutated, 'get_billing_company', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_address_1', val: rt.call_method(var_order_mutated, 'get_billing_address_1', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_address_2', val: rt.call_method(var_order_mutated, 'get_billing_address_2', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_city', val: rt.call_method(var_order_mutated, 'get_billing_city', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_state', val: rt.call_method(var_order_mutated, 'get_billing_state', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_postcode', val: rt.call_method(var_order_mutated, 'get_billing_postcode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_country', val: rt.call_method(var_order_mutated, 'get_billing_country', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_email', val: rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'billing_phone', val: rt.call_method(var_order_mutated, 'get_billing_phone', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_first_name', val: rt.call_method(var_order_mutated, 'get_shipping_first_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_last_name', val: rt.call_method(var_order_mutated, 'get_shipping_last_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_company', val: rt.call_method(var_order_mutated, 'get_shipping_company', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_address_1', val: rt.call_method(var_order_mutated, 'get_shipping_address_1', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_address_2', val: rt.call_method(var_order_mutated, 'get_shipping_address_2', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_city', val: rt.call_method(var_order_mutated, 'get_shipping_city', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_state', val: rt.call_method(var_order_mutated, 'get_shipping_state', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_postcode', val: rt.call_method(var_order_mutated, 'get_shipping_postcode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_country', val: rt.call_method(var_order_mutated, 'get_shipping_country', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_phone', val: rt.call_method(var_order_mutated, 'get_shipping_phone', []rt.PhpVal{}) }]))
		rt.call_method(this.additional_fields_controller, 'sync_customer_additional_fields_with_order', [var_order_mutated.dup(), var_customer])
		var_customer.save()
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_order_before_payment(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
	mut var_needs_shipping := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{})
	mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])
	this.validate_coupons(mut var_order_mutated, false)
	this.validate_email(mut var_order_mutated)
	this.validate_selected_shipping_methods(var_needs_shipping.dup(), var_chosen_shipping_methods.dup())
	this.validate_addresses(mut var_order_mutated, (var_needs_shipping).to_bool())
	this.perform_custom_order_validation(mut var_order_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_existing_order_before_payment(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
	mut var_needs_shipping := rt.call_method(var_order_mutated, 'needs_shipping', []rt.PhpVal{})
	this.validate_coupons(mut var_order_mutated, true)
	this.validate_email(mut var_order_mutated)
	this.validate_addresses(mut var_order_mutated, (var_needs_shipping).to_bool())
	this.perform_custom_order_validation(mut var_order_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) perform_custom_order_validation(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
	mut var_validation_errors := create_automattic_woocommerce_storeapi_utilities_wp_error()
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_validate_order_before_payment'), var_order_mutated.dup(), var_validation_errors])
	if rt.is_true(var_validation_errors.has_errors()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_checkout_custom_validation_error'), rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(' '), var_validation_errors.get_error_messages()])]), rt.new_int(400))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_coupon(var_coupon_code rt.PhpVal) rt.PhpVal {
	return create_automattic_woocommerce_storeapi_utilities_wc_coupon(var_coupon_code.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_coupons(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, use_order_data bool)  {
	mut var_order_mutated := var_order
	mut var_coupon_codes := rt.call_method(var_order_mutated, 'get_coupon_codes', []rt.PhpVal{})
	mut var_coupons := rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_coupon' }]), var_coupon_codes.dup()])])
	mut var_validators := rt.create_array([rt.ArrayItem{ key: none, val: 'validate_coupon_email_restriction' }, rt.ArrayItem{ key: none, val: 'validate_coupon_usage_limit' }])
	mut var_coupon_errors := rt.new_array()
	{
		mut iter_1 := var_coupons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_coupon := item_1.val
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_validator := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_index := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_params := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_OrderController', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_validator }]), var_params.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.new_null()
	}
			rt.call_function('array_walk', [var_validators.dup(), rt.new_closure(closure_2_fn), rt.create_array([rt.ArrayItem{ key: none, val: var_coupon }, rt.ArrayItem{ key: none, val: var_order_mutated }])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_error := var_e_1.dup()
				var_coupon_errors.array_set(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}))
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	if rt.is_true(var_coupon_errors) {
		if var_use_order_data {
			mut var_error_code := rt.new_string(rt.new_string('woocommerce_rest_order_coupon_errors'))
			{
				mut iter_1 := var_coupon_errors.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_message := item_1.val
					mut var_coupon_code := item_1.key
					rt.call_method(var_order_mutated, 'remove_coupon', [var_coupon_code.dup()])
				}
			}
			rt.call_method(var_order_mutated, 'calculate_totals', []rt.PhpVal{})
		} else {
			var_error_code = rt.new_string(rt.new_string('woocommerce_rest_cart_coupon_errors'))
			{
				mut iter_1 := var_coupon_errors.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_message := item_1.val
					mut var_coupon_code := item_1.key
					rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'remove_coupon', [var_coupon_code.dup()])
				}
			}
			rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'calculate_totals', []rt.PhpVal{})
			this.update_order_from_cart(mut var_order_mutated, false)
		}
		if 1 == var_coupon_errors.dup().array_count() && var_use_order_data {
			mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('"%1$s" was removed from the order. %2$s'), rt.new_string('woocommerce')]), rt.func_array_keys(var_coupon_errors.dup()).array_get(0), rt.call_function('array_values', [var_coupon_errors.dup()]).array_get(0)])
		} else if 1 == var_coupon_errors.dup().array_count() {
			var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('"%1$s" was removed from the cart. %2$s'), rt.new_string('woocommerce')]), rt.func_array_keys(var_coupon_errors.dup()).array_get(0), rt.call_function('array_values', [var_coupon_errors.dup()]).array_get(0)])
		} else if var_use_order_data {
			var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid coupons were removed from the order: "%s"'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string('", "'), rt.func_array_keys(var_coupon_errors.dup())])])
		} else {
			var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid coupons were removed from the cart: "%s"'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string('", "'), rt.func_array_keys(var_coupon_errors.dup())])])
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(var_error_code.dup(), var_error_message.dup(), rt.new_int(409), rt.create_array([rt.ArrayItem{ key: 'removed_coupons', val: var_coupon_errors }]))))
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_email(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
	mut var_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	if !rt.is_true(var_email) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_missing_email_address'), rt.call_function('__', [rt.new_string('A valid email address is required'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email.dup()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_email_address'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The provided email address (%s) is not valid—please provide a valid email address'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_email.dup()])]), rt.new_int(400))))
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_addresses(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, needs_shipping bool)  {
	mut var_order_mutated := var_order
	mut needs_shipping_mutated := needs_shipping
	mut var_errors := create_automattic_woocommerce_storeapi_utilities_wp_error()
	mut var_billing_country := rt.call_method(var_order_mutated, 'get_billing_country', []rt.PhpVal{})
	mut var_shipping_country := rt.call_method(var_order_mutated, 'get_shipping_country', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(needs_shipping_mutated)) {
		mut var_local_pickup_method_ids := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.get_local_pickup_method_ids() }()
		mut var_selected_shipping_rates := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ShippingUtil{}; return temp.get_selected_shipping_rates_from_packages(arg_0) }(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{}))
		closure_3_fn := fn [var_local_pickup_method_ids] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_rate := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('in_array', [rt.call_method(var_rate, 'get_method_id', []rt.PhpVal{}), var_local_pickup_method_ids.dup(), rt.new_bool(true)])
	}
		mut var_selected_shipping_rates_are_all_local_pickup := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.array_all(arg_0, arg_1) }(var_selected_shipping_rates.dup(), rt.new_closure(closure_3_fn))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_selected_shipping_rates_are_all_local_pickup)))) && !(this.validate_allowed_country(var_shipping_country.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](rt.cast_array(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}))))))) {
			mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})
			mut var_shipping_country_name := if !(var_countries.array_get(var_shipping_country)).is_null() { var_countries.array_get(var_shipping_country) } else { var_shipping_country }
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_address_country'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Sorry, we do not ship orders to the provided country (%s)'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_shipping_country_name.dup()])]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: 'allowed_countries', val: rt.call_function('array_map', [rt.new_string('esc_html'), rt.func_array_keys()]) }]))))
		}
	}
	if !(this.validate_allowed_country(var_billing_country.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](rt.cast_array(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{}))))) {
		var_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})
		mut var_billing_country_name := if !(var_countries.array_get(var_billing_country)).is_null() { var_countries.array_get(var_billing_country) } else { var_billing_country }
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_address_country'), rt.call_function('sprintf', [, ]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: , val:  }]))))
	}
	if rt.is_true(rt.new_bool(needs_shipping_mutated)) {
		this.validate_address_fields(mut var_order_mutated, rt.new_string('shipping'), mut var_errors)
	}
	this.validate_address_fields(mut var_order_mutated, rt.new_string('billing'), mut var_errors)
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return rt.new_null()
	}
	
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_allowed_country(var_country rt.PhpVal, mut var_allowed_countries Class_Automattic_WooCommerce_StoreApi_Utilities_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_address_fields(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order, var_address_type rt.PhpVal, mut var_errors Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error)  {
	mut var_order_mutated := var_order
	mut var_errors_mutated := var_errors
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_coupon_email_restriction(mut var_coupon Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon, mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_coupon_usage_limit(mut var_coupon Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon, mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_email_from_user_id(var_user_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_usage_per_aliases(var_coupon rt.PhpVal, var_aliases rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_aliases_mutated := var_aliases
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_selected_shipping_methods(var_needs_shipping rt.PhpVal, var_chosen_shipping_methods rt.PhpVal)  {
	mut var_needs_shipping_mutated := var_needs_shipping
	mut var_chosen_shipping_methods_mutated := var_chosen_shipping_methods
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) validate_order_key(var_order_id rt.PhpVal, var_order_key rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) get_failed_order_stock_error(var_order_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) default_order_status() string {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) update_line_items_from_cart(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) update_addresses_from_cart(mut var_order Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order)  {
	mut var_order_mutated := var_order
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

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase: rt.PhpObjectBase{}
		additional_fields_controller: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
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

fn create_automattic_woocommerce_storeapi_utilities_wc_order() &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_geolocation() &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_paymentutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_PaymentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_customer() &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wp_error() &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wc_coupon() &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils() &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_shippingutil() &Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ShippingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_order_from_cart(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sync_customer_data_with_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.sync_customer_data_with_order(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_order_before_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_order_before_payment(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_existing_order_before_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_existing_order_before_payment(mut dispatch_arg_0)
			return rt.new_null()
		}
		'perform_custom_order_validation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.perform_custom_order_validation(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupon(dispatch_arg_0)
		}
		'validate_coupons' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.validate_coupons(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.validate_email(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_addresses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.validate_addresses(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_allowed_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.validate_allowed_country(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_address_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error](if args.len > 2 { args[2] } else { rt.new_null() })
			this.validate_address_fields(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'validate_coupon_email_restriction' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.validate_coupon_email_restriction(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'validate_coupon_usage_limit' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.update_line_items_from_cart(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_addresses_from_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.update_addresses_from_cart(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
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
		'additional_fields_controller' { this.additional_fields_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_ordercontroller_php() {
	// unsupported statement: Stmt_Declare
}

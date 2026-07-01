import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.get_shared_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Line items to add to the cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'minimum', val: 1 }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'quantity' }]) }]) }]) }, rt.ArrayItem{ key: 'buyer', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Buyer information.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('First name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Last name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Email address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'email' }]) }, rt.ArrayItem{ key: 'phone_number', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Phone number.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'fulfillment_address', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Fulfillment/shipping address.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Full name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'line_one', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 1.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'line_two', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Address line 2.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('City.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('State/province.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Country code (ISO 3166-1 alpha-2).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'postal_code', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Postal/ZIP code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'line_one' }, rt.ArrayItem{ key: none, val: 'city' }, rt.ArrayItem{ key: none, val: 'country' }, rt.ArrayItem{ key: none, val: 'postal_code' }]) }]) }])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.add_items_to_cart(var_items rt.PhpVal, var_cart_controller rt.PhpVal, var_messages rt.PhpVal) rt.PhpVal {
	mut var_messages_mutated := var_messages
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_index := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_digit', [var_item.array_get('id')]))))) {
				return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.invalid_request(arg_0, arg_1, arg_2) }(rt.new_string('invalid_product_id'), rt.call_function('__', [rt.new_string('Product ID must be numeric.'), rt.new_string('woocommerce')]), rt.new_string('$.items[' + (var_item_index).str() + '].id'))
			}
			mut var_product_id := // unsupported expression: Expr_Cast_Int
			mut var_quantity := // unsupported expression: Expr_Cast_Int
			rt.call_method(var_cart_controller, 'add_to_cart', [rt.create_array([rt.ArrayItem{ key: 'id', val: var_product_id }, rt.ArrayItem{ key: 'quantity', val: var_quantity }])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
				mut var_exception := var_e_1.dup()
				mut var_message := rt.call_function('wp_specialchars_decode', [rt.call_method(var_exception, 'getMessage', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES')])
				mut var_param := rt.new_string('$.items[' + (var_item_index).str() + ']')
				mut var_message_error := rt.new_null()
				mut switch_val_1 := rt.call_method(var_exception, 'getErrorCode', []rt.PhpVal{})
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_rest_product_out_of_stock'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_rest_product_partially_out_of_stock'))) {
					var_message_error = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError{}; return temp.out_of_stock(arg_0, arg_1) }(var_message.dup(), var_param.dup())
				}
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.call_method(var_messages_mutated, 'add', [var_message_error.dup()])
				} else {
					return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.invalid_request(arg_0, arg_1, arg_2) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup(), var_param.dup())
				}
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.set_buyer_data(var_buyer rt.PhpVal, var_customer rt.PhpVal)  {
	if var_buyer.array_isset(rt.new_string('first_name')) {
		mut var_first_name := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_buyer.array_get('first_name')])])
		rt.call_method(var_customer, 'set_billing_first_name', [var_first_name.dup()])
		rt.call_method(var_customer, 'set_shipping_first_name', [var_first_name.dup()])
	}
	if var_buyer.array_isset(rt.new_string('last_name')) {
		mut var_last_name := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_buyer.array_get('last_name')])])
		rt.call_method(var_customer, 'set_billing_last_name', [var_last_name.dup()])
		rt.call_method(var_customer, 'set_shipping_last_name', [var_last_name.dup()])
	}
	if var_buyer.array_isset(rt.new_string('email')) {
		mut var_email := rt.call_function('sanitize_email', [rt.call_function('wp_unslash', [var_buyer.array_get('email')])])
		if rt.is_true(rt.call_function('is_email', [var_email.dup()])) {
			rt.call_method(var_customer, 'set_billing_email', [var_email.dup()])
		}
	}
	if var_buyer.array_isset(rt.new_string('phone_number')) {
		mut var_phone := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_buyer.array_get('phone_number')])])
		rt.call_method(var_customer, 'set_billing_phone', [var_phone.dup()])
	}
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.set_fulfillment_address(var_address rt.PhpVal, var_customer rt.PhpVal)  {
	if !(!rt.is_true(var_address.array_get('name'))) {
		mut var_name := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_address.array_get('name')])])
		mut var_name_parts := rt.call_function('explode', [rt.new_string(' '), var_name.dup(), rt.new_int(2)])
		mut var_first_name := var_name_parts.array_get(0)
		mut var_last_name := if var_name_parts.array_isset(rt.new_int(1)) { var_name_parts.array_get(1) } else { rt.new_string('') }
		rt.call_method(var_customer, 'set_shipping_first_name', [var_first_name.dup()])
		rt.call_method(var_customer, 'set_shipping_last_name', [var_last_name.dup()])
	} else {
		var_first_name = rt.call_method(var_customer, 'get_shipping_first_name', []rt.PhpVal{})
		var_last_name = rt.call_method(var_customer, 'get_shipping_last_name', []rt.PhpVal{})
	}
	mut var_line_one := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('line_one')).is_null() { var_address.array_get('line_one') } else { rt.new_string('') }])])
	mut var_line_two := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('line_two')).is_null() { var_address.array_get('line_two') } else { rt.new_string('') }])])
	mut var_city := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('city')).is_null() { var_address.array_get('city') } else { rt.new_string('') }])])
	mut var_state := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('state')).is_null() { var_address.array_get('state') } else { rt.new_string('') }])])
	mut var_postal_code := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('postal_code')).is_null() { var_address.array_get('postal_code') } else { rt.new_string('') }])])
	mut var_country := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('country')).is_null() { var_address.array_get('country') } else { rt.new_string('') }])])
	rt.call_method(var_customer, 'set_shipping_address_1', [var_line_one.dup()])
	rt.call_method(var_customer, 'set_shipping_address_2', [var_line_two.dup()])
	rt.call_method(var_customer, 'set_shipping_city', [var_city.dup()])
	rt.call_method(var_customer, 'set_shipping_state', [var_state.dup()])
	rt.call_method(var_customer, 'set_shipping_postcode', [var_postal_code.dup()])
	rt.call_method(var_customer, 'set_shipping_country', [var_country.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_billing_address_1', []rt.PhpVal{}))))) {
		if !(!rt.is_true(var_address.array_get('name'))) {
			rt.call_method(var_customer, 'set_billing_first_name', [var_first_name.dup()])
			rt.call_method(var_customer, 'set_billing_last_name', [var_last_name.dup()])
		}
		rt.call_method(var_customer, 'set_billing_address_1', [var_line_one.dup()])
		rt.call_method(var_customer, 'set_billing_address_2', [var_line_two.dup()])
		rt.call_method(var_customer, 'set_billing_city', [var_city.dup()])
		rt.call_method(var_customer, 'set_billing_state', [var_state.dup()])
		rt.call_method(var_customer, 'set_billing_postcode', [var_postal_code.dup()])
		rt.call_method(var_customer, 'set_billing_country', [var_country.dup()])
	}
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.clear_fulfillment_address(var_customer rt.PhpVal)  {
	rt.call_method(var_customer, 'set_shipping_first_name', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_last_name', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_address_1', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_address_2', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_city', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_state', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_postcode', [rt.new_string('')])
	rt.call_method(var_customer, 'set_shipping_country', [rt.new_string('')])
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.set_billing_address(var_address rt.PhpVal, var_customer rt.PhpVal)  {
	if !(!rt.is_true(var_address.array_get('name'))) {
		mut var_name := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_address.array_get('name')])])
		mut var_name_parts := rt.call_function('explode', [rt.new_string(' '), var_name.dup(), rt.new_int(2)])
		mut var_first_name := var_name_parts.array_get(0)
		mut var_last_name := if var_name_parts.array_isset(rt.new_int(1)) { var_name_parts.array_get(1) } else { rt.new_string('') }
		rt.call_method(var_customer, 'set_billing_first_name', [var_first_name.dup()])
		rt.call_method(var_customer, 'set_billing_last_name', [var_last_name.dup()])
	}
	mut var_line_one := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('line_one')).is_null() { var_address.array_get('line_one') } else { rt.new_string('') }])])
	mut var_line_two := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('line_two')).is_null() { var_address.array_get('line_two') } else { rt.new_string('') }])])
	mut var_city := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('city')).is_null() { var_address.array_get('city') } else { rt.new_string('') }])])
	mut var_state := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('state')).is_null() { var_address.array_get('state') } else { rt.new_string('') }])])
	mut var_postal_code := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('postal_code')).is_null() { var_address.array_get('postal_code') } else { rt.new_string('') }])])
	mut var_country := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_address.array_get('country')).is_null() { var_address.array_get('country') } else { rt.new_string('') }])])
	rt.call_method(var_customer, 'set_billing_address_1', [var_line_one.dup()])
	rt.call_method(var_customer, 'set_billing_address_2', [var_line_two.dup()])
	rt.call_method(var_customer, 'set_billing_city', [var_city.dup()])
	rt.call_method(var_customer, 'set_billing_state', [var_state.dup()])
	rt.call_method(var_customer, 'set_billing_postcode', [var_postal_code.dup()])
	rt.call_method(var_customer, 'set_billing_country', [var_country.dup()])
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.add_protocol_headers(mut var_response Class_Automattic_WooCommerce_StoreApi_Utilities_WP_REST_Response, mut var_request Class_Automattic_WooCommerce_StoreApi_Utilities_WP_REST_Request) rt.PhpVal {
	mut var_idempotency_key := var_request.get_header(rt.new_string('Idempotency-Key'))
	if rt.is_true(var_idempotency_key) {
		.header(rt.new_string(), .dup())
	}
	mut var_request_id := 
	if rt.is_true() {
	}
	return rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WP_REST_Response', []string{}, )
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.validate_jetpack_request() bool {
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.validate(mut var_checkout_session Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession)  {
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.calculate_status(mut var_checkout_session Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) string {
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.get_agentic_commerce_gateway(var_available_gateways rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.is_agentic_commerce_session() bool {
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_agenticcheckoututils() &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_error() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_messages_messageerror() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_shared_params' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.get_shared_params()
		}
		'add_items_to_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.add_items_to_cart(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_buyer_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.set_buyer_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_fulfillment_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.set_fulfillment_address(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'clear_fulfillment_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.clear_fulfillment_address(dispatch_arg_0)
			return rt.new_null()
		}
		'set_billing_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.set_billing_address(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_protocol_headers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WP_REST_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.add_protocol_headers(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validate_jetpack_request' {
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.validate_jetpack_request())
		}
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.validate(mut dispatch_arg_0)
			return rt.new_null()
		}
		'calculate_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.calculate_status(mut dispatch_arg_0))
		}
		'get_agentic_commerce_gateway' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.get_agentic_commerce_gateway(dispatch_arg_0)
		}
		'is_agentic_commerce_session' {
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils.is_agentic_commerce_session())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Messages_MessageError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_agenticcheckoututils_php() {
	// unsupported statement: Stmt_Declare
}

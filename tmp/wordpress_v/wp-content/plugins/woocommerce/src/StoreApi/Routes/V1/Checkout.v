import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.identifier() string {
	return 'checkout'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.schema_type() string {
	return 'checkout'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout {
	rt.PhpObjectBase
pub mut:
		order rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.get_path_regex() string {
	return '/checkout'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) requires_nonce(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) bool {
	return !(rt.is_true(this.has_cart_token(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'payment_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Data to pass through to the payment method when processing payment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'boolean' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'customer_password', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customer password for new accounts, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema'), 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()])]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'additional_fields', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Additional fields related to the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }]) }, rt.ArrayItem{ key: 'payment_method', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selected payment method for the order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'order_notes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order notes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema'), 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.editable()])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([rt.ArrayItem{ key: 'v1', val: true }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	this.load_cart_session(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
	mut var_response := rt.new_null()
	mut var_nonce_check := if this.requires_nonce(mut var_request) { this.check_nonce(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request)) } else { rt.new_null() }
	if rt.is_true(rt.call_function('is_wp_error', [var_nonce_check.dup()])) {
		var_response = var_nonce_check.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response)))) {
		var_response = this.get_response_by_request_method(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_InvalidCartException') {
			mut var_error := var_e_1.dup()
			var_response = this.get_route_error_response_from_object(rt.call_method(var_error, 'getError', []rt.PhpVal{}), (rt.call_method(var_error, 'getCode', []rt.PhpVal{})).to_i64(), rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}))
			unsafe { goto end_label_1 }
		}
		else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
			mut var_error := var_e_1.dup()
			var_response = this.get_route_error_response(rt.call_method(var_error, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), (rt.call_method(var_error, 'getCode', []rt.PhpVal{})).to_i64(), rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}))
			unsafe { goto end_label_1 }
		}
		else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Exception') {
			mut var_error := var_e_1.dup()
			var_response = this.get_route_error_response(rt.new_string('woocommerce_rest_unknown_server_error'), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), 500, rt.new_null())
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		var_response = this.error_to_response(var_response.dup())
		if rt.is_true(this.order) {
			rt.call_function('wc_release_stock_for_order', [this.order])
			rt.call_function('wc_release_coupons_for_order', [this.order])
		}
		if rt.is_true(rt.identical(var_request.get_method(), Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable())) {
			rt.call_function('wc_log_order_step', [rt.new_string('[Store API #FAIL] Placing Order failed'), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_response, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_response, 'get_data', []rt.PhpVal{}) }]), rt.new_bool(true)])
		}
	}
	return this.add_response_headers(var_response.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	this.create_or_update_draft_order(mut var_request)
	return this.prepare_item_for_response(// unsupported expression: Expr_Cast_Object, rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) validate_callback(var_request rt.PhpVal) bool {
	mut var_validate_contexts := rt.create_array([rt.ArrayItem{ key: 'shipping_address', val: rt.create_array([rt.ArrayItem{ key: 'group', val: 'shipping' }, rt.ArrayItem{ key: 'location', val: 'address' }, rt.ArrayItem{ key: 'param', val: 'shipping_address' }]) }, rt.ArrayItem{ key: 'billing_address', val: rt.create_array([rt.ArrayItem{ key: 'group', val: 'billing' }, rt.ArrayItem{ key: 'location', val: 'address' }, rt.ArrayItem{ key: 'param', val: 'billing_address' }]) }, rt.ArrayItem{ key: 'contact', val: rt.create_array([rt.ArrayItem{ key: 'group', val: 'other' }, rt.ArrayItem{ key: 'location', val: 'contact' }, rt.ArrayItem{ key: 'param', val: 'additional_fields' }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'group', val: 'other' }, rt.ArrayItem{ key: 'location', val: 'order' }, rt.ArrayItem{ key: 'param', val: 'additional_fields' }]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{}))))) {
		var_validate_contexts.array_unset(rt.new_string('shipping_address'))
	}
	mut var_invalid_groups := rt.new_array()
	mut var_invalid_details := rt.new_array()
	mut var_is_partial := rt.call_function('in_array', [rt.call_method(var_request, 'get_method', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'PUT' }, rt.ArrayItem{ key: none, val: 'PATCH' }]), rt.new_bool(true)])
	{
		mut iter_1 := var_validate_contexts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_context_data := item_1.val
			mut var_context := item_1.key
			mut var_errors := create_automattic_woocommerce_storeapi_routes_v1_wp_error()
			mut var_document_object := this.get_document_object_from_rest_request(var_request.dup())
			rt.call_method(var_document_object, 'set_context', [var_context.dup()])
			mut var_additional_fields := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'additional_fields_controller'), 'get_contextual_fields_for_location', [var_context_data.array_get('location'), var_document_object.dup()])
			mut var_field_values := if !(rt.cast_array(rt.call_method(var_request, 'get_param', [var_context_data.array_get('param')]))).is_null() { rt.cast_array(rt.call_method(var_request, 'get_param', [var_context_data.array_get('param')])) } else { rt.new_array() }
			{
				mut iter_2 := var_additional_fields.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_field := item_2.val
					mut var_field_key := item_2.key
					if rt.is_true(rt.new_bool(!(var_field_values.array_isset(var_field_key)) && rt.is_true(rt.new_bool(rt.is_true(var_is_partial) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
						continue
					}
					mut var_field_value := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_field_values.array_get(var_field_key)).is_null() { var_field_values.array_get(var_field_key) } else { rt.new_string('') }])])
					if !rt.is_true(var_field_value) {
						if rt.is_true(rt.identical(rt.new_bool(true), var_field.array_get('required'))) {
							mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is required'), rt.new_string('woocommerce')]), var_field.array_get('label')])
							if rt.is_true(rt.identical(rt.new_string('shipping_address'), var_context)) {
								var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was a problem with the provided shipping address: %s'), rt.new_string('woocommerce')]), var_error_message.dup()])
							} else if rt.is_true(rt.identical(rt.new_string('billing_address'), var_context)) {
								var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was a problem with the provided billing address: %s'), rt.new_string('woocommerce')]), var_error_message.dup()])
							}
							var_errors.add(rt.new_string('woocommerce_required_checkout_field'), var_error_message.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: var_field_key }]))
						}
						continue
					}
					mut var_valid_check := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'additional_fields_controller'), 'validate_field', [var_field.dup(), var_field_value.dup()])
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_valid_check.dup()])) && rt.is_true(rt.call_method(var_valid_check, 'has_errors', []rt.PhpVal{})))) {
						{
							mut iter_3 := rt.call_method(var_valid_check, 'get_error_codes', []rt.PhpVal{}).iterator()
							for {
								item_3 := iter_3.next() or { break }
								mut var_code := item_3.val
								rt.call_method(var_valid_check, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'location', val: var_context_data.array_get('location') }, rt.ArrayItem{ key: 'key', val: var_field_key }]), var_code.dup()])
							}
						}
						var_errors.merge_from(var_valid_check.dup())
						continue
					}
				}
			}
			mut var_valid_location_check := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'additional_fields_controller'), 'validate_fields_for_location', [var_field_values.dup(), var_context_data.array_get('location'), var_context_data.array_get('group')])
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_valid_location_check.dup()])) && rt.is_true(rt.call_method(var_valid_location_check, 'has_errors', []rt.PhpVal{})))) {
				{
					mut iter_2 := rt.call_method(var_valid_location_check, 'get_error_codes', []rt.PhpVal{}).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_code := item_2.val
						rt.call_method(var_valid_location_check, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'location', val: var_context_data.array_get('location') }]), var_code.dup()])
					}
				}
				var_errors.merge_from(var_valid_location_check.dup())
			}
			if rt.is_true(var_errors.has_errors()) {
				var_invalid_groups.array_set(var_context_data.array_get('param'), var_errors.get_error_message())
				var_invalid_details.array_set(var_context_data.array_get('param'), rt.call_method(rt.call_function('rest_convert_error_to_response', [var_errors]), 'get_data', []rt.PhpVal{}))
			}
		}
	}
	if rt.is_true(var_invalid_groups) {
		return (create_automattic_woocommerce_storeapi_routes_v1_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid parameter(s): %s'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(var_invalid_groups.dup())])])]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }, rt.ArrayItem{ key: 'params', val: var_invalid_groups }, rt.ArrayItem{ key: 'details', val: var_invalid_details }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_route_update_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_validation_callback := rt.new_bool(this.validate_callback(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request)))
	if rt.is_true(rt.call_function('is_wp_error', [var_validation_callback.dup()])) {
		return var_validation_callback.dup()
	}
	this.create_or_update_draft_order(mut var_request)
	this.update_order_from_request(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
	if rt.is_true(var_request.get_param(rt.new_string('__experimental_calc_totals'))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'cart_controller'), 'calculate_totals', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'cart_controller'), 'validate_cart_not_empty', []rt.PhpVal{})
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'cart_controller'), 'validate_cart', []rt.PhpVal{})
	}
	rt.call_method(this.order, 'save', []rt.PhpVal{})
	return this.prepare_item_for_response(// unsupported expression: Expr_Cast_Object, rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #1] Place Order flow initiated'), rt.new_null(), rt.new_bool(false), rt.new_bool(true)])
	mut var_validation_callback := rt.new_bool(this.validate_callback(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request)))
	if rt.is_true(rt.call_function('is_wp_error', [var_validation_callback.dup()])) {
		return var_validation_callback.dup()
	}
	this.validate_user_can_place_order()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'cart_controller'), 'calculate_totals', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'cart_controller'), 'validate_cart_not_empty', []rt.PhpVal{})
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #2] Cart validated')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'cart_controller'), 'validate_cart', []rt.PhpVal{})
	this.update_customer_from_request(mut var_request)
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #3] Updated customer data from request')])
	this.create_or_update_draft_order(mut var_request)
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #4] Created/Updated draft order'), rt.create_array([rt.ArrayItem{ key: 'order_object', val: this.order }])])
	this.update_order_from_request(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #5] Updated order with posted data'), rt.create_array([rt.ArrayItem{ key: 'order_object', val: this.order }])])
	this.process_customer(mut var_request)
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #6] Created and/or persisted customer data from order'), rt.create_array([rt.ArrayItem{ key: 'order_object', val: this.order }])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Checkout', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'order_controller'), 'validate_order_before_payment', [this.order])
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #7] Validated order data'), rt.create_array([rt.ArrayItem{ key: 'order_object', val: this.order }])])
	rt.call_method(this.order, 'hold_applied_coupons', [rt.call_method(this.order, 'get_billing_email', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_StoreApi_Routes_V1_Exception') {
		mut var_e := var_e_2.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_coupon_reserve_failed'), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.new_int(400))))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	rt.call_function('wc_reserve_stock_for_order', [this.order])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Checkout_Helpers_ReserveStockException') {
		mut var_e := var_e_3.dup()
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.call_function('esc_html', [rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{})]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.call_function('esc_html', [rt.call_method(var_e, 'getCode', []rt.PhpVal{})]))))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	rt.call_function('wc_log_order_step', [rt.new_string('[Store API #8] Reserved stock for order'), rt.create_array([rt.ArrayItem{ key: 'order_object', val: this.order }])])
	rt.call_function('wc_do_deprecated_action', [rt.new_string('__experimental_woocommerce_blocks_checkout_order_processed'), rt.create_array([rt.ArrayItem{ key: none, val: this.order }]), rt.new_string('6.3.0'), rt.new_string('woocommerce_store_api_checkout_order_processed'), rt.new_string('This action was deprecated in WooCommerce Blocks version 6.3.0. Please use woocommerce_store_api_checkout_order_processed instead.')])
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_blocks_checkout_order_processed'), rt.create_array([rt.ArrayItem{ key: none, val: this.order }]), rt.new_string('7.2.0'), rt.new_string('woocommerce_store_api_checkout_order_processed'), rt.new_string('This action was deprecated in WooCommerce Blocks version 7.2.0. Please use woocommerce_store_api_checkout_order_processed instead.')])
	rt.call_method(this.order, 'update_status', [rt.new_string('pending')])
	rt.call_function('do_action', [, ])
	
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_route_error_response(var_error_code rt.PhpVal, var_error_message rt.PhpVal, http_status_code i64, var_additional_data rt.PhpVal) rt.PhpVal {
	mut var_error_message_mutated := var_error_message
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_route_error_response_from_object(var_error_object rt.PhpVal, http_status_code i64, var_additional_data rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) add_data_to_error_object(var_error rt.PhpVal, var_data rt.PhpVal, var_http_status_code rt.PhpVal, include_cart bool) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) create_or_update_draft_order(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) update_customer_address_field(var_customer rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal, var_address_type rt.PhpVal)  {
	mut var_customer_mutated := var_customer
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) update_customer_from_request(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) get_request_payment_method(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) process_customer(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) should_create_customer_account(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) bool {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) validate_user_can_place_order()  {
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_checkout() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
		order: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_wp_error() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout.get_path_regex())
		}
		'requires_nonce' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.requires_nonce(mut dispatch_arg_0))
		}
		'get_args' {
			return this.get_args()
		}
		'get_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_response(mut dispatch_arg_0)
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_response(mut dispatch_arg_0)
		}
		'validate_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_callback(dispatch_arg_0))
		}
		'get_route_update_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_update_response(mut dispatch_arg_0)
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		'get_route_error_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_route_error_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_route_error_response_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_route_error_response_from_object(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_data_to_error_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.add_data_to_error_object(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'create_or_update_draft_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.create_or_update_draft_order(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_customer_address_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.update_customer_address_field(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'update_customer_from_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.update_customer_from_request(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_request_payment_method' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_request_payment_method(mut dispatch_arg_0)
		}
		'process_customer' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_customer(mut dispatch_arg_0)
			return rt.new_null()
		}
		'should_create_customer_account' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.should_create_customer_account(mut dispatch_arg_0))
		}
		'validate_user_can_place_order' {
			this.validate_user_can_place_order()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order' { return this.order }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order' { this.order = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_checkout_php() {
	// unsupported statement: Stmt_Declare
}

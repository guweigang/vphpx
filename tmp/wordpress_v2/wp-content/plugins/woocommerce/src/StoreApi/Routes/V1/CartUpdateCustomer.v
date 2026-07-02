import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.identifier() string {
	return 'cart-update-customer'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.get_path_regex() string {
	return '/cart/update-customer'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'billing_address', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Billing address.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.call_method(rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
						'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
					], &this), 'schema'), 'billing_address_schema'), 'get_properties',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() },
				]) },
				rt.ArrayItem{ key: 'shipping_address', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Shipping address.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.call_method(rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
						'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
					], &this), 'schema'), 'shipping_address_schema'), 'get_properties',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
		rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
			rt.ArrayItem{ key: 'v1', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) validate_address_params(var_request rt.PhpVal, var_billing rt.PhpVal, var_shipping rt.PhpVal) bool {
	mut var_billing_mutated := var_billing
	mut var_shipping_mutated := var_shipping
	mut var_posted_billing := rt.new_bool(var_request.array_isset(rt.new_string('billing_address')))
	mut var_posted_shipping :=
		rt.new_bool(var_request.array_isset(rt.new_string('shipping_address')))
	mut var_invalid_params := rt.new_array()
	mut var_invalid_details := rt.new_array()
	if rt.is_true(var_posted_billing) {
		mut var_billing_validation_check := rt.call_method(rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'billing_address_schema'), 'validate_callback', [
			var_billing_mutated.clone(),
			var_request.clone(),
			rt.new_string('billing_address'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_billing_validation_check)) {
			var_invalid_params.array_set('billing_address', rt.call_function('__', [
				rt.new_string('Invalid parameter.'),
				rt.new_string('woocommerce'),
			]))
		} else if rt.is_true(rt.call_function('is_wp_error', [
			var_billing_validation_check.clone()]))
		{
			var_invalid_params.array_set('billing_address', rt.call_function('implode', [
				rt.new_string(' '),
				rt.call_method(var_billing_validation_check, 'get_error_messages', []rt.PhpVal{}),
			]))
			var_invalid_details.array_set('billing_address', rt.call_method(rt.call_function('rest_convert_error_to_response', [
				var_billing_validation_check.clone(),
			]), 'get_data', []rt.PhpVal{}))
		}
	}
	if rt.is_true(var_posted_shipping) {
		mut var_shipping_validation_check := rt.call_method(rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'shipping_address_schema'), 'validate_callback', [
			var_shipping_mutated.clone(),
			var_request.clone(),
			rt.new_string('shipping_address'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_shipping_validation_check)) {
			var_invalid_params.array_set('shipping_address', rt.call_function('__', [
				rt.new_string('Invalid parameter.'),
				rt.new_string('woocommerce'),
			]))
		} else if rt.is_true(rt.call_function('is_wp_error', [
			var_shipping_validation_check.clone()]))
		{
			var_invalid_params.array_set('shipping_address', rt.call_function('implode', [
				rt.new_string(' '),
				rt.call_method(var_shipping_validation_check, 'get_error_messages', []rt.PhpVal{}),
			]))
			var_invalid_details.array_set('shipping_address', rt.call_method(rt.call_function('rest_convert_error_to_response', [
				var_shipping_validation_check.clone(),
			]), 'get_data', []rt.PhpVal{}))
		}
	}
	if rt.is_true(var_invalid_params) {
		return (create_automattic_woocommerce_storeapi_routes_v1_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Invalid parameter(s): %s'),
				rt.new_string('woocommerce')]),
			rt.call_function('implode', [rt.new_string(', '),
				rt.func_array_keys(var_invalid_params.clone())]),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 },
			rt.ArrayItem{ key: 'params', val: var_invalid_params },
			rt.ArrayItem{ key: 'details', val: var_invalid_details }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_cart := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'get_cart_instance', []rt.PhpVal{})
	mut var_customer := rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer')
	mut var_billing := rt.call_function('wp_parse_args', [if !(var_request.array_get(rt.new_string('billing_address'))).is_null() {
		var_request.array_get(rt.new_string('billing_address'))
	} else {
		rt.new_array()
	},
		this.get_customer_billing_address(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Customer](var_customer))])
	mut var_shipping := rt.call_function('wp_parse_args', [if !(var_request.array_get(rt.new_string('shipping_address'))).is_null() {
		var_request.array_get(rt.new_string('shipping_address'))
	} else {
		rt.new_array()
	},
		this.get_customer_shipping_address(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Customer](var_customer))])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cart, 'needs_shipping', []rt.PhpVal{})))))
		&& !(var_request.array_isset(rt.new_string('shipping_address'))) {
		var_shipping = var_billing.clone()
	}
	var_billing = rt.call_method(rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'schema'), 'billing_address_schema'), 'sanitize_callback', [
		var_billing.clone(), var_request, rt.new_string('billing_address')])
	var_shipping = rt.call_method(rt.get_property(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'schema'), 'shipping_address_schema'), 'sanitize_callback', [
		var_shipping.clone(), var_request, rt.new_string('shipping_address')])
	mut var_validation_check := rt.new_bool(this.validate_address_params(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
		[]string{}, var_request), var_billing.clone(), var_shipping.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_validation_check.clone()])) {
		return rt.call_function('rest_ensure_response', [var_validation_check.clone()])
	}
	rt.call_method(var_customer, 'set_props', [
		rt.create_array([
			rt.ArrayItem{
				key: 'billing_first_name'
				val: if !(var_billing.array_get(rt.new_string('first_name'))).is_null() {
					var_billing.array_get(rt.new_string('first_name'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_last_name'
				val: if !(var_billing.array_get(rt.new_string('last_name'))).is_null() {
					var_billing.array_get(rt.new_string('last_name'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_company'
				val: if !(var_billing.array_get(rt.new_string('company'))).is_null() {
					var_billing.array_get(rt.new_string('company'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_address_1'
				val: if !(var_billing.array_get(rt.new_string('address_1'))).is_null() {
					var_billing.array_get(rt.new_string('address_1'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_address_2'
				val: if !(var_billing.array_get(rt.new_string('address_2'))).is_null() {
					var_billing.array_get(rt.new_string('address_2'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_city'
				val: if !(var_billing.array_get(rt.new_string('city'))).is_null() {
					var_billing.array_get(rt.new_string('city'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_state'
				val: if !(var_billing.array_get(rt.new_string('state'))).is_null() {
					var_billing.array_get(rt.new_string('state'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_postcode'
				val: if !(var_billing.array_get(rt.new_string('postcode'))).is_null() {
					var_billing.array_get(rt.new_string('postcode'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_country'
				val: if !(var_billing.array_get(rt.new_string('country'))).is_null() {
					var_billing.array_get(rt.new_string('country'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_phone'
				val: if !(var_billing.array_get(rt.new_string('phone'))).is_null() {
					var_billing.array_get(rt.new_string('phone'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'billing_email'
				val: if !(var_billing.array_get(rt.new_string('email'))).is_null() {
					var_billing.array_get(rt.new_string('email'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_first_name'
				val: if !(var_shipping.array_get(rt.new_string('first_name'))).is_null() {
					var_shipping.array_get(rt.new_string('first_name'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_last_name'
				val: if !(var_shipping.array_get(rt.new_string('last_name'))).is_null() {
					var_shipping.array_get(rt.new_string('last_name'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_company'
				val: if !(var_shipping.array_get(rt.new_string('company'))).is_null() {
					var_shipping.array_get(rt.new_string('company'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_address_1'
				val: if !(var_shipping.array_get(rt.new_string('address_1'))).is_null() {
					var_shipping.array_get(rt.new_string('address_1'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_address_2'
				val: if !(var_shipping.array_get(rt.new_string('address_2'))).is_null() {
					var_shipping.array_get(rt.new_string('address_2'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_city'
				val: if !(var_shipping.array_get(rt.new_string('city'))).is_null() {
					var_shipping.array_get(rt.new_string('city'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_state'
				val: if !(var_shipping.array_get(rt.new_string('state'))).is_null() {
					var_shipping.array_get(rt.new_string('state'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_postcode'
				val: if !(var_shipping.array_get(rt.new_string('postcode'))).is_null() {
					var_shipping.array_get(rt.new_string('postcode'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_country'
				val: if !(var_shipping.array_get(rt.new_string('country'))).is_null() {
					var_shipping.array_get(rt.new_string('country'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'shipping_phone'
				val: if !(var_shipping.array_get(rt.new_string('phone'))).is_null() {
					var_shipping.array_get(rt.new_string('phone'))
				} else {
					rt.new_null()
				}
			},
		]),
	])
	mut var_core_fields := rt.func_array_keys(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'additional_fields_controller'), 'get_core_fields', []rt.PhpVal{}))
	mut var_additional_shipping_values := rt.call_function('array_diff_key', [
		var_shipping.clone(), rt.call_function('array_flip', [
			var_core_fields.clone()])])
	mut var_additional_billing_values := rt.call_function('array_diff_key', [
		var_billing.clone(), rt.call_function('array_flip', [var_core_fields.clone()])])
	mut iter_1 := var_additional_shipping_values.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'additional_fields_controller'), 'persist_field_for_customer', [
			var_key.clone(),
			var_value.clone(),
			var_customer.clone(),
			rt.new_string('shipping'),
		])
	}
	mut iter_2 := var_additional_billing_values.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'additional_fields_controller'), 'persist_field_for_customer', [
			var_key.clone(),
			var_value.clone(),
			var_customer.clone(),
			rt.new_string('billing'),
		])
	}
	rt.call_function('wc_do_deprecated_action', [
		rt.new_string('woocommerce_blocks_cart_update_customer_from_request'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_customer },
			rt.ArrayItem{ key: none, val: var_request }]),
		rt.new_string('7.2.0'),
		rt.new_string('woocommerce_store_api_cart_update_customer_from_request'),
		rt.new_string('This action was deprecated in WooCommerce Blocks version 7.2.0. Please use woocommerce_store_api_cart_update_customer_from_request instead.'),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_store_api_cart_update_customer_from_request'),
		var_customer.clone(),
		var_request,
	])
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'calculate_totals', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'get_item_response', [
			var_cart.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) get_customer_billing_address(mut var_customer Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Customer) rt.PhpVal {
	mut var_customer_mutated := var_customer
	mut var_additional_fields := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'additional_fields_controller'), 'get_all_fields_from_object', [
		var_customer_mutated,
		rt.new_string('billing'),
	])
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_customer_mutated,
				'get_billing_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_customer_mutated,
				'get_billing_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'company', val: rt.call_method(var_customer_mutated,
				'get_billing_company', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_1', val: rt.call_method(var_customer_mutated,
				'get_billing_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_2', val: rt.call_method(var_customer_mutated,
				'get_billing_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'city', val: rt.call_method(var_customer_mutated,
				'get_billing_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'state', val: rt.call_method(var_customer_mutated,
				'get_billing_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_customer_mutated,
				'get_billing_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'country', val: rt.call_method(var_customer_mutated,
				'get_billing_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'phone', val: rt.call_method(var_customer_mutated,
				'get_billing_phone', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'email', val: rt.call_method(var_customer_mutated,
				'get_billing_email', []rt.PhpVal{}) },
		]),
		var_additional_fields.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) get_customer_shipping_address(mut var_customer Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Customer) rt.PhpVal {
	mut var_customer_mutated := var_customer
	mut var_additional_fields := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'additional_fields_controller'), 'get_all_fields_from_object', [
		var_customer_mutated,
		rt.new_string('shipping'),
	])
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_customer_mutated,
				'get_shipping_first_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_customer_mutated,
				'get_shipping_last_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'company', val: rt.call_method(var_customer_mutated,
				'get_shipping_company', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_1', val: rt.call_method(var_customer_mutated,
				'get_shipping_address_1', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'address_2', val: rt.call_method(var_customer_mutated,
				'get_shipping_address_2', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'city', val: rt.call_method(var_customer_mutated,
				'get_shipping_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'state', val: rt.call_method(var_customer_mutated,
				'get_shipping_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_customer_mutated,
				'get_shipping_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'country', val: rt.call_method(var_customer_mutated,
				'get_shipping_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'phone', val: rt.call_method(var_customer_mutated,
				'get_shipping_phone', []rt.PhpVal{}) },
		]),
		var_additional_fields.clone(),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_cartupdatecustomer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'validate_address_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.validate_address_params(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		'get_customer_billing_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Customer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_customer_billing_address(mut dispatch_arg_0)
		}
		'get_customer_shipping_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Customer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_customer_shipping_address(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateCustomer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}

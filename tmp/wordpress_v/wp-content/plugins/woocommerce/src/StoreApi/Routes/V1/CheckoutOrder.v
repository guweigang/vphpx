import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.identifier() string {
	return 'checkout-order'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.schema_type() string {
	return 'checkout-order'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder {
	rt.PhpObjectBase
pub mut:
		order rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.get_path_regex() string {
	return '/checkout/(?P<id>[\\d]+)'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'is_authorized' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'payment_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Data to pass through to the payment method when processing payment.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'boolean' }]) }]) }]) }]) }]) }]), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema'), 'get_endpoint_args_for_item_schema', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([rt.ArrayItem{ key: 'v1', val: true }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.call_function('absint', [var_request.array_get('id')])
	this.order = rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.order, 'needs_payment', []rt.PhpVal{}))))))) {
		return create_automattic_woocommerce_storeapi_routes_v1_wp_error(rt.new_string('invalid_order_update_status'), rt.call_function('__', [rt.new_string('This order cannot be paid for.'), rt.new_string('woocommerce')]))
	}
	this.update_billing_address(mut var_request)
	this.update_order_from_request(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
	this.process_customer(mut var_request)
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'order_controller'), 'validate_existing_order_before_payment', [this.order])
	rt.call_function('do_action', [rt.new_string('woocommerce_store_api_checkout_order_processed'), this.order])
	mut var_payment_result := create_automattic_woocommerce_storeapi_payments_paymentresult()
	if rt.is_true(rt.call_method(this.order, 'needs_payment', []rt.PhpVal{})) {
		this.process_payment(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request), rt.new_object('Automattic_WooCommerce_StoreApi_Payments_PaymentResult', []string{}, var_payment_result))
	} else {
		this.process_without_payment(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request), rt.new_object('Automattic_WooCommerce_StoreApi_Payments_PaymentResult', []string{}, var_payment_result))
	}
	return this.prepare_item_for_response(// unsupported expression: Expr_Cast_Object, rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) cart_updated(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) update_billing_address(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
	mut var_customer := rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer')
	mut var_billing := var_request.array_get('billing_address')
	mut var_shipping := var_request.array_get('shipping_address')
	{
		mut iter_1 := var_billing.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: "set_billing_${var_key.to_string()}" }])])) {
				rt.call_method(var_customer, "set_billing_${var_key.to_string()}", [var_value.dup()])
			}
		}
	}
	mut var_shipping_address_values := if !(var_shipping).is_null() { var_shipping } else { var_billing }
	{
		mut iter_1 := var_shipping_address_values.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: "set_shipping_${var_key.to_string()}" }])])) {
				rt.call_method(var_customer, "set_shipping_${var_key.to_string()}", [var_value.dup()])
			} else if rt.is_true(rt.identical(rt.new_string('phone'), var_key)) {
				rt.call_method(var_customer, 'update_meta_data', [rt.new_string('shipping_phone'), var_value.dup()])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_store_api_checkout_update_customer_from_request'), var_customer.dup(), var_request])
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
	rt.call_method(this.order, 'set_billing_address', [var_billing.dup()])
	rt.call_method(this.order, 'set_shipping_address', [var_shipping.dup()])
	rt.call_method(this.order, 'save', []rt.PhpVal{})
	rt.call_method(this.order, 'calculate_totals', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) get_request_payment_method(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_available_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})
	mut var_request_payment_method := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(var_request.array_get('payment_method')).is_null() { var_request.array_get('payment_method') } else { rt.new_string('') }])])
	mut var_requires_payment_method := rt.call_method(this.order, 'needs_payment', []rt.PhpVal{})
	if !rt.is_true(var_request_payment_method) {
		if rt.is_true(var_requires_payment_method) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_checkout_missing_payment_method'), rt.call_function('__', [rt.new_string('No payment method provided.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		}
		return rt.new_null()
	}
	if !(var_available_gateways.array_isset(var_request_payment_method)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_checkout_payment_method_disabled'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s payment gateway is not available.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_request_payment_method.dup()])]), rt.new_int(400))))
	}
	return var_available_gateways.array_get(var_request_payment_method)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) process_customer(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request)  {
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'order_controller'), 'sync_customer_data_with_order', [this.order])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_checkoutorder() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder{
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

fn create_automattic_woocommerce_storeapi_payments_paymentresult() &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		'cart_updated' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.cart_updated(mut dispatch_arg_0)
			return rt.new_null()
		}
		'update_billing_address' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			this.update_billing_address(mut dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order' { return this.order }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CheckoutOrder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_checkoutorder_php() {
}

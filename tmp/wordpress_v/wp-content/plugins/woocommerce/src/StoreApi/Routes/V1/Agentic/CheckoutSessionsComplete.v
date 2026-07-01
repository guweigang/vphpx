import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.identifier() string {
	return 'agentic-checkout-sessions-complete'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.schema_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Agentic_CheckoutSessionSchema.identifier()
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete {
	rt.PhpObjectBase
pub mut:
		order_controller rt.PhpVal = rt.new_null()
		cart_controller rt.PhpVal = rt.new_null()
		order rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) construct(var_schema_controller rt.PhpVal, var_schema rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute.construct(var_schema_controller.dup(), var_schema.dup())
	this.order_controller = create_automattic_woocommerce_storeapi_utilities_ordercontroller()
	this.cart_controller = create_automattic_woocommerce_storeapi_utilities_cartcontroller()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.get_path_regex() string {
	return '/checkout_sessions/(?P<checkout_session_id>[a-zA-Z0-9._-]+)/complete'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'checkout_session_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The checkout session ID (Cart-Token JWT).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this) }, rt.ArrayItem{ key: none, val: 'is_authorized' }]) }, rt.ArrayItem{ key: 'args', val: this.get_complete_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) get_complete_params() rt.PhpVal {
	mut var_shared_params := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.get_shared_params() }()
	return rt.create_array([rt.ArrayItem{ key: 'buyer', val: var_shared_params.array_get('buyer') }, rt.ArrayItem{ key: 'payment_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment data including token and provider.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'token', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment token from the payment provider.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'provider', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment provider identifier.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'stripe' }]) }]) }, rt.ArrayItem{ key: 'billing_address', val: var_shared_params.array_get('fulfillment_address') }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'token' }, rt.ArrayItem{ key: none, val: 'provider' }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) is_authorized(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) bool {
	mut var_auth_check := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.validate_jetpack_request() }()
	if rt.is_true(rt.call_function('is_wp_error', [var_auth_check.dup()])) {
		return (var_auth_check).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.has_cart_token(mut var_request))))) {
		return (create_automattic_woocommerce_storeapi_routes_v1_agentic_wp_error(rt.new_string('woocommerce_rest_invalid_checkout_session'), rt.call_function('__', [rt.new_string('Invalid or expired checkout session ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) has_cart_token(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_session_id := var_request.get_param(rt.new_string('checkout_session_id'))
	if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'has_cart_token').is_null())) {
		this.dispatch_set_prop('has_cart_token', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.validate_cart_token(arg_0) }(var_session_id.dup()))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'has_cart_token'))) {
		var_request.set_header(rt.new_string('Cart-Token'), var_session_id.dup())
		rt.get_superglobal('_SERVER').array_set('HTTP_CART_TOKEN', var_session_id.dup())
	}
	return rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'has_cart_token')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) requires_nonce(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_checkout_session := create_automattic_woocommerce_storeapi_routes_v1_agentic_agenticcheckoutsession(rt.call_method(this.cart_controller, 'get_cart_instance', []rt.PhpVal{}))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.validate(arg_0) }(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession', []string{}, var_checkout_session))
	mut var_current_status := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.calculate_status(arg_0) }(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession', []string{}, var_checkout_session))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Checkout session is not ready for payment. Current status: %s'), rt.new_string('woocommerce')]), var_current_status.dup()])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.invalid_request(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
	}
	mut var_buyer := var_request.get_param(rt.new_string('buyer'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.set_buyer_data(arg_0, arg_1) }(var_buyer.dup(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	}
	mut var_payment_data := var_request.get_param(rt.new_string('payment_data'))
	if var_payment_data.array_isset(rt.new_string('billing_address')) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.set_billing_address(arg_0, arg_1) }(var_payment_data.array_get('billing_address'), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
	}
	rt.call_method(this.cart_controller, 'calculate_totals', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(this.cart_controller, 'validate_cart_not_empty', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(this.cart_controller, 'validate_cart', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Exception') {
		mut var_e := var_e_1.dup()
		var_message = rt.call_function('wp_specialchars_decode', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES')])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.processing_error(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.order = this.get_draft_order()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.order)))) {
		this.order = rt.call_method(this.order_controller, 'create_order_from_cart', []rt.PhpVal{})
	} else {
		rt.call_method(this.order_controller, 'update_order_from_cart', [this.order, rt.new_bool(true)])
	}
	rt.call_method(this.order, 'update_meta_data', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey.agentic_checkout_session_id(), var_request.get_param(rt.new_string('checkout_session_id'))])
	rt.call_method(this.order, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(this.order_controller, 'validate_order_before_payment', [this.order])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Exception') {
		mut var_e := var_e_2.dup()
		var_message = rt.call_function('wp_specialchars_decode', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES')])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.invalid_request(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
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
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Exception') {
		mut var_e := var_e_3.dup()
		var_message = rt.call_function('wp_specialchars_decode', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES')])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.invalid_request(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	rt.call_method(this.order, 'update_status', [rt.new_string('pending')])
	mut var_payment_result := create_automattic_woocommerce_storeapi_payments_paymentresult()
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_payment_in_progress(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'save_data', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	this.process_payment(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request', []string{}, var_request), rt.new_object('Automattic_WooCommerce_StoreApi_Payments_PaymentResult', []string{}, var_payment_result))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto finally_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Exception') {
		mut var_e := var_e_4.dup()
		var_message = rt.call_function('wp_specialchars_decode', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES')])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.processing_error(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
		unsafe { goto finally_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto finally_label_4 }
	}

finally_label_4:
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_payment_in_progress(), rt.new_bool(false)])
	if rt.has_exception() { return rt.new_null() }

end_label_4:
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('failure'), rt.get_property(var_payment_result, 'status'))) || rt.is_true(rt.identical(rt.new_string('error'), rt.get_property(var_payment_result, 'status'))))) {
		var_message = if !(rt.get_property(var_payment_result, 'message')).is_null() { rt.get_property(var_payment_result, 'message') } else { rt.call_function('__', [rt.new_string('Payment was declined.'), rt.new_string('woocommerce')]) }
		var_message = rt.call_function('wp_specialchars_decode', [var_message.dup(), rt.get_constant('ENT_QUOTES')])
		return rt.call_method(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error{}; return temp.processing_error(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.payment_declined(), var_message.dup()), 'to_rest_response', []rt.PhpVal{})
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_completed_order_id(), rt.call_method(this.order, 'get_id', []rt.PhpVal{})])
	mut var_response_data := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute'], &this), 'schema'), 'get_item_response', [var_checkout_session])
	mut var_response := rt.call_function('rest_ensure_response', [var_response_data.dup()])
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.add_protocol_headers(arg_0, arg_1) }(var_response.dup(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request', []string{}, var_request))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) get_request_payment_data(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_payment_data := rt.new_array()
	mut var_agentic_data := var_request.get_param(rt.new_string('payment_data'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_agentic_data)))) {
		return var_payment_data.dup()
	}
	if var_agentic_data.array_isset(rt.new_string('token')) {
		var_payment_data.array_set('wc-agentic_commerce-token', rt.call_function('wc_clean', [var_agentic_data.array_get('token')]))
	}
	if var_agentic_data.array_isset(rt.new_string('provider')) {
		var_payment_data.array_set('wc-agentic_commerce-provider', rt.call_function('wc_clean', [var_agentic_data.array_get('provider')]))
	}
	return var_payment_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) get_request_payment_method_id(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request) rt.PhpVal {
	mut var_available_gateways := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'get_available_payment_gateways', []rt.PhpVal{})
	if !rt.is_true(var_available_gateways) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_checkout_session_no_payment_gateway_available'), rt.call_function('esc_html__', [rt.new_string('No payment gateway available.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	mut var_gateway := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{}; return temp.get_agentic_commerce_gateway(arg_0) }(var_available_gateways.dup())
	if rt.is_true(rt.identical(rt.new_null(), var_gateway)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_checkout_session_no_agentic_payment_gateway_available'), rt.call_function('esc_html__', [rt.new_string('No agentic-supported payment gateway available.'), rt.new_string('woocommerce')]), rt.new_int(400))))
	}
	return rt.get_property(var_gateway, 'id')
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Payments_PaymentResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_checkoutsessionscomplete(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete{
		PhpObjectBase: rt.PhpObjectBase{}
		order_controller: rt.new_null()
		cart_controller: rt.new_null()
		order: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_agenticcheckoututils() &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_wp_error() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_agenticcheckoutsession() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_complete_params' {
			return this.get_complete_params()
		}
		'is_authorized' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_authorized(mut dispatch_arg_0))
		}
		'has_cart_token' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.has_cart_token(mut dispatch_arg_0)
		}
		'requires_nonce' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.requires_nonce(mut dispatch_arg_0))
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		'get_request_payment_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_request_payment_data(mut dispatch_arg_0)
		}
		'get_request_payment_method_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_request_payment_method_id(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_controller' { return this.order_controller }
		'cart_controller' { return this.cart_controller }
		'order' { return this.order }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_CheckoutSessionsComplete) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_controller' { this.order_controller = val; return true }
		'cart_controller' { this.cart_controller = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_AgenticCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_AgenticCheckoutSession) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_agentic_checkoutsessionscomplete_php() {
	// unsupported statement: Stmt_Declare
}

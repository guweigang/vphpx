import rt

struct Class_WC_REST_Paypal_Buttons_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('paypal-buttons')
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/create-order', rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Buttons_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_order' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Buttons_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'validate_create_order_request' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/cancel-payment', rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Buttons_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'cancel_payment' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Buttons_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'validate_cancel_payment_request' }]) }])])
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) validate_create_order_request(mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(var_request.get_header(rt.new_string('Nonce'))) {
		mut var_nonce := var_request.get_header(rt.new_string('Nonce'))
		return (rt.call_function('wp_verify_nonce', [var_nonce.dup(), rt.new_string('wc_gateway_paypal_standard_create_order')])).to_bool()
	}
	return false
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) validate_cancel_payment_request(mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(var_request.get_header(rt.new_string('Nonce'))) {
		mut var_nonce := var_request.get_header(rt.new_string('Nonce'))
		return (rt.call_function('wp_verify_nonce', [var_nonce.dup(), rt.new_string('wc_gateway_paypal_standard_cancel_payment')])).to_bool()
	}
	return false
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) create_order(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_data := var_request.get_json_params()
	if !rt.is_true(var_data.array_get('order_id')) || !rt.is_true(var_data.array_get('order_key')) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Invalid request' }]), rt.new_int(400))
	}
	mut var_payment_source := if var_data.array_isset(rt.new_string('payment_source')) { rt.call_function('sanitize_text_field', [var_data.array_get('payment_source')]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(var_payment_source) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_payment_source.dup(), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_payment_sources(), rt.new_bool(true)]))))))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Missing/Invalid payment source: ' + (rt.call_function('esc_html', [var_payment_source.dup()])).str() }]), rt.new_int(400))
	}
	mut var_order_id := var_data.array_get('order_id')
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Order not found' }]), rt.new_int(404))
	}
	mut var_order_key := var_data.array_get('order_key')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order_key)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_order_key.dup()]))))))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Order not found' }]), rt.new_int(404))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_order, 'get_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.checkout_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }]), rt.new_bool(true)]))))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Invalid order status' }]), rt.new_int(409))
	}
	mut var_gateway := fn () rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.get_instance() }()
	rt.call_method(var_order, 'set_payment_method', [rt.get_property(var_gateway, 'id')])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	mut var_paypal_request := create_automattic_woocommerce_gateways_paypal_request(var_gateway.dup())
	mut var_paypal_order := var_paypal_request.create_paypal_order(var_order.dup(), var_payment_source.dup(), rt.create_array([rt.ArrayItem{ key: 'is_js_sdk_flow', val: true }, rt.ArrayItem{ key: 'app_switch_request_origin', val: if !(var_data.array_get('app_switch_request_origin')).is_null() { var_data.array_get('app_switch_request_origin') } else { rt.new_string('') } }]))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order)))) || !rt.is_true(var_paypal_order.array_get('id')))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Failed to create PayPal order' }]), rt.new_int(400))
	}
	rt.call_method(var_order, 'update_meta_data', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(), var_paypal_order.array_get('id')])
	rt.call_method(var_order, 'update_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.pending()])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'paypal_order_id', val: if !(var_paypal_order.array_get('id')).is_null() { var_paypal_order.array_get('id') } else { rt.new_null() } }, rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'return_url', val: rt.call_function('esc_url_raw', [rt.call_function('add_query_arg', [rt.new_string('utm_nooverride'), rt.new_string('1'), rt.call_method(var_gateway, 'get_return_url', [var_order.dup()])])]) }]), rt.new_int(200))
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) cancel_payment(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_data := var_request.get_json_params()
	mut var_order_id := if var_data.array_isset(rt.new_string('order_id')) { rt.call_function('absint', [var_data.array_get('order_id')]) } else { rt.new_int(0) }
	mut var_paypal_order_id := if var_data.array_isset(rt.new_string('paypal_order_id')) { rt.call_function('wc_clean', [var_data.array_get('paypal_order_id')]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) || rt.is_true(rt.identical(rt.new_string(''), var_paypal_order_id)))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Invalid request' }]), rt.new_int(400))
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Order not found' }]), rt.new_int(404))
	}
	mut var_paypal_order_id_from_meta := rt.call_method(var_order, 'get_meta', [rt.new_string('_paypal_order_id')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Invalid PayPal order' }]), rt.new_int(404))
	}
	if rt.is_true(rt.call_method(var_order, 'has_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.checkout_draft()])) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'success', val: true }]), rt.new_int(200))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.pending()]))))) {
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: 'Order is not pending' }]), rt.new_int(409))
	}
	rt.call_method(var_order, 'update_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.checkout_draft()])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'success', val: true }]), rt.new_int(200))
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
}

fn create_wc_rest_paypal_buttons_controller() &Class_WC_REST_Paypal_Buttons_Controller {
	mut obj := &Class_WC_REST_Paypal_Buttons_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('paypal-buttons')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal() &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_request() &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'validate_create_order_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_create_order_request(mut dispatch_arg_0))
		}
		'validate_cancel_payment_request' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_cancel_payment_request(mut dispatch_arg_0))
		}
		'create_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create_order(mut dispatch_arg_0)
		}
		'cancel_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.cancel_payment(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Paypal_Buttons_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Paypal_Buttons_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_paypal_buttons_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Constants')]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/gateways/paypal/includes/class-wc-gateway-paypal-constants.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Request')]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/gateways/paypal/includes/class-wc-gateway-paypal-request.php', '4')
	}
}

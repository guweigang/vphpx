import rt

struct Class_WC_REST_Paypal_Webhooks_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('paypal-webhooks')
}

fn (mut this Class_WC_REST_Paypal_Webhooks_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Webhooks_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'process_webhook' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Paypal_Webhooks_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'validate_webhook' }]) }])])
}

fn (mut this Class_WC_REST_Paypal_Webhooks_Controller) validate_webhook(mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('Automattic\\Jetpack\\Connection\\REST_Authentication')])) && rt.is_true(rt.call_function('method_exists', [rt.new_string('Automattic\\Jetpack\\Connection\\REST_Authentication'), rt.new_string('is_signed_with_blog_token')])))) {
		return (fn () rt.PhpVal { mut temp := Class_Automattic_Jetpack_Connection_REST_Authentication{}; return temp.is_signed_with_blog_token() }()).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return false
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.new_string('REST authentication method not available. Webhook data: ' + (rt.call_function('wc_print_r', [var_request.get_json_params(), rt.new_bool(true)])).str()), rt.new_string('error'))
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return false
}

fn (mut this Class_WC_REST_Paypal_Webhooks_Controller) process_webhook(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_webhook_handler := create_automattic_woocommerce_gateways_paypal_webhookhandler()
	var_webhook_handler.process_webhook(rt.new_object('WP_REST_Request', []string{}, var_request))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'message', val: 'Webhook processed successfully' }]), rt.new_int(200))
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.dup()
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Error processing webhook: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
		return create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('__', [rt.new_string('Webhook processing failed.'), rt.new_string('woocommerce')]) }]), rt.new_int(500))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_REST_Authentication {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wc_rest_paypal_webhooks_controller() &Class_WC_REST_Paypal_Webhooks_Controller {
	mut obj := &Class_WC_REST_Paypal_Webhooks_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('paypal-webhooks')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_rest_authentication() &Class_Automattic_Jetpack_Connection_REST_Authentication {
	mut obj := &Class_Automattic_Jetpack_Connection_REST_Authentication{
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

fn create_automattic_woocommerce_gateways_paypal_webhookhandler() &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler{
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

fn (mut this Class_WC_REST_Paypal_Webhooks_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'validate_webhook' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_webhook(mut dispatch_arg_0))
		}
		'process_webhook' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.process_webhook(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Paypal_Webhooks_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Paypal_Webhooks_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Jetpack_Connection_REST_Authentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_REST_Authentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_REST_Authentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_paypal_webhooks_controller_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

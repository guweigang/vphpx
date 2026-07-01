import rt

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_endpoint_api_version() string {
	return '2'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_rest_base() string {
	return 'transact/paypal_standard/proxy'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_order_endpoint() string {
	return 'order'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_payment_capture_endpoint() string {
	return 'payment/capture'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_payment_authorize_endpoint() string {
	return 'payment/authorize'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_payment_capture_auth_endpoint() string {
	return 'payment/capture_auth'
}
pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_client_id_endpoint() string {
	return 'client_id'
}
struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
pub mut:
		gateway rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) construct(mut var_gateway Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal)  {
	this.gateway = var_gateway.dup()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) create_paypal_order(mut var_order Class_WC_Order, payment_source string, mut var_js_sdk_params Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut payment_source_mutated := payment_source
	mut var_paypal_debug_id := rt.new_null()
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paylater(), rt.new_string(payment_source_mutated))) {
		payment_source_mutated = (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paypal()).str()
	}
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }, rt.ArrayItem{ key: 'order', val: this.get_paypal_create_order_request_params(mut var_order, payment_source_mutated, mut var_js_sdk_params) }])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response := this.send_wpcom_proxy_request('POST', (Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_order_endpoint()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal order creation failed. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.dup().is_array()))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('PayPal order creation failed. Invalid response type.'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.dup(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response_array := if rt.is_true(rt.new_bool(var_response_data.dup().is_array())) { var_response_data } else { rt.new_array() }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_paypal_standard_order_created_response'), var_http_code.dup(), var_response_array.dup(), var_order])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_http_code.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 200 }, rt.ArrayItem{ key: none, val: 201 }]), rt.new_bool(true)]))))) {
		var_paypal_debug_id = if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get('debug_id') } else { rt.new_null() }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal order creation failed. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str())))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_redirect_url := rt.new_null()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !rt.is_true(var_js_sdk_params.array_get('is_js_sdk_flow')) {
		var_redirect_url = rt.new_string(this.get_approve_link(var_http_code.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_response_data)))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !rt.is_true(var_redirect_url) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('PayPal order creation failed. Missing approval link.'))))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(), var_response_data.array_get('id'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), var_response_data.array_get('status'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_payment_source(), rt.new_string(payment_source_mutated))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.save()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: var_response_data.array_get('id') }, rt.ArrayItem{ key: 'redirect_url', val: var_redirect_url }])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(var_paypal_debug_id) {
			var_order.add_order_note(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('PayPal order creation failed. PayPal debug ID: %1$s'), rt.new_string('woocommerce')]), var_paypal_debug_id.dup()]))
		}
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_details(paypal_order_id string) rt.PhpVal {
	mut paypal_order_id_mutated := paypal_order_id
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }])
	mut var_response := this.send_wpcom_proxy_request('GET', (Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_order_endpoint()).str() + '/' + paypal_order_id_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal order details request failed: ' + (rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])).str())))
	}
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.dup()])
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.dup()])
	mut var_response_data := rt.call_function('json_decode', [var_body.dup(), rt.new_bool(true)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_debug_id := if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get('debug_id') } else { rt.new_null() }
		mut var_message := rt.new_string('PayPal order details request failed. HTTP ' + (// unsupported expression: Expr_Cast_Int).str() + if rt.is_true(var_debug_id) { '. Debug ID: ' + (var_debug_id).str() } else { '' })
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [var_message.dup()]))))
	}
	return var_response_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) authorize_or_capture_payment(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order, mut var_action_url Class_Automattic_WooCommerce_Gateways_PayPal_?string, action string, is_retry bool)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Order not found to authorize or capture payment.'))
		return rt.new_null()
	}
	mut var_paypal_debug_id := rt.new_null()
	mut var_paypal_order_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order_id)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal order ID not found. Cannot ' + action + ' payment.'))
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_action_url)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [var_action_url, rt.get_constant('FILTER_VALIDATE_URL')]))))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Invalid or missing action URL. Cannot ' + action + ' payment.'))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), rt.new_bool(true)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal payment is already captured. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_capture(), rt.new_string(action))) {
		mut var_endpoint := Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_payment_capture_endpoint()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'capture_url', val: var_action_url }, rt.ArrayItem{ key: 'paypal_order_id', val: var_paypal_order_id }, rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		var_endpoint = Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_payment_authorize_endpoint()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_request_body = rt.create_array([rt.ArrayItem{ key: 'authorize_url', val: var_action_url }, rt.ArrayItem{ key: 'paypal_order_id', val: var_paypal_order_id }, rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_response := this.send_wpcom_proxy_request('POST', (var_endpoint).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal ' + action + ' payment request failed. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.dup(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_issue := if var_response_data.array_get('details').array_get(0).array_isset(rt.new_string('issue')) { var_response_data.array_get('details').array_get(0).array_get('issue') } else { rt.new_string('') }
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_duplicate_invoice_id := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_int(422), var_http_code)) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_duplicate_invoice_id(), var_issue))))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(rt.is_true(var_duplicate_invoice_id) && !(var_is_retry))) {
		this.handle_duplicate_invoice_id(mut var_order, (var_paypal_order_id).str(), var_action_url, action)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_paypal_debug_id = if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get('debug_id') } else { rt.new_null() }
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal ' + action + ' payment failed. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str())))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		mut var_note_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('PayPal %1$s payment failed. PayPal Order ID: %2$s'), rt.new_string('woocommerce')]), rt.new_string(action), var_paypal_order_id.dup()])
		if rt.is_true(var_paypal_debug_id) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_order.add_order_note(var_note_message.dup())
		var_order.update_status(Class_Automattic_WooCommerce_Enums_OrderStatus.failed())
		var_order.save()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) capture_authorized_payment(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Order not found to capture authorized payment.'))
		return rt.new_null()
	}
	mut var_paypal_order_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order_id)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal Order ID not found to capture authorized payment. Order ID: ' + (var_order.get_id()).str()))
		return rt.new_null()
	}
	mut var_capture_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(), rt.new_bool(true))
	if rt.is_true(var_capture_id) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal payment is already captured. PayPal capture ID: ' + (var_capture_id).str() + '. Order ID: ' + (var_order.get_id()).str()))
		return rt.new_null()
	}
	mut var_paypal_status := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), rt.new_bool(true))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured(), var_paypal_status)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), var_paypal_status)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal payment is already captured. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_payer_action_required(), var_paypal_status)) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal payment requires payer action. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.voided(), var_paypal_status)) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal payment voided. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return rt.new_null()
	}
	mut var_authorization_id := rt.new_string(this.get_authorization_id_for_capture(mut var_order))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_authorization_id)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string( + ().str()))
		return rt.new_null()
	}
	mut var_paypal_debug_id := 
	
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) handle_duplicate_invoice_id(mut var_order Class_WC_Order, paypal_order_id string, action_url string, action string)  {
	mut paypal_order_id_mutated := paypal_order_id
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) generate_paypal_invoice_id_with_unique_suffix(mut var_order Class_WC_Order) string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_authorization_id_for_capture(mut var_order Class_WC_Order) string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_latest_transaction_data(mut var_items Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut var_items_mutated := var_items
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_approve_link(var_http_code rt.PhpVal, mut var_response_data Class_Automattic_WooCommerce_Gateways_PayPal_array) string {
	mut var_http_code_mutated := var_http_code
	mut var_response_data_mutated := var_response_data
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_create_order_request_params(mut var_order Class_WC_Order, payment_source string, mut var_js_sdk_params Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut payment_source_mutated := payment_source
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_purchase_unit_amount(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_custom_id(mut var_order Class_WC_Order) string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_items(mut var_order Class_WC_Order) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_items_subtotal(mut var_order Class_WC_Order) f64 {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_item_amount(mut var_order Class_WC_Order, mut var_item Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item) f64 {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_intent() string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_shipping_preference(mut var_order Class_WC_Order) string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_shipping(mut var_order Class_WC_Order) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) generate_shipping_callback_token(mut var_order Class_WC_Order) string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) normalize_paypal_order_shipping_country_code(country_code string) string {
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) normalize_url_for_paypal(url string) string {
	mut url_mutated := url
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) fetch_paypal_client_id() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) send_wpcom_proxy_request(method string, endpoint string, mut var_request_body Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut endpoint_mutated := endpoint
	mut var_request_body_mutated := var_request_body
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) limit_length(text string, limit i64) string {
	mut text_mutated := text
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_gateways_paypal_request(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		gateway: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_wc_gateway_paypal() &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'create_paypal_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.create_paypal_order(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_paypal_order_details' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_paypal_order_details(dispatch_arg_0)
		}
		'authorize_or_capture_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.authorize_or_capture_payment(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'capture_authorized_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.capture_authorized_payment(mut dispatch_arg_0)
			return rt.new_null()
		}
		'handle_duplicate_invoice_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.handle_duplicate_invoice_id(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'generate_paypal_invoice_id_with_unique_suffix' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_paypal_invoice_id_with_unique_suffix(mut dispatch_arg_0))
		}
		'get_authorization_id_for_capture' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_authorization_id_for_capture(mut dispatch_arg_0))
		}
		'get_latest_transaction_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_latest_transaction_data(mut dispatch_arg_0)
		}
		'get_approve_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get_approve_link(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_paypal_create_order_request_params' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_paypal_create_order_request_params(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_paypal_order_purchase_unit_amount' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_paypal_order_purchase_unit_amount(mut dispatch_arg_0)
		}
		'get_paypal_order_custom_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_paypal_order_custom_id(mut dispatch_arg_0))
		}
		'get_paypal_order_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_paypal_order_items(mut dispatch_arg_0)
		}
		'get_paypal_order_items_subtotal' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_float(this.get_paypal_order_items_subtotal(mut dispatch_arg_0))
		}
		'get_paypal_order_item_amount' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_float(this.get_paypal_order_item_amount(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_paypal_order_intent' {
			return rt.new_string(this.get_paypal_order_intent())
		}
		'get_paypal_shipping_preference' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_paypal_shipping_preference(mut dispatch_arg_0))
		}
		'get_paypal_order_shipping' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_paypal_order_shipping(mut dispatch_arg_0)
		}
		'generate_shipping_callback_token' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_shipping_callback_token(mut dispatch_arg_0))
		}
		'normalize_paypal_order_shipping_country_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_paypal_order_shipping_country_code(dispatch_arg_0))
		}
		'normalize_url_for_paypal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_url_for_paypal(dispatch_arg_0))
		}
		'fetch_paypal_client_id' {
			return rt.new_string(this.fetch_paypal_client_id())
		}
		'send_wpcom_proxy_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.send_wpcom_proxy_request(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'limit_length' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.limit_length(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'gateway' { return this.gateway }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'gateway' { this.gateway = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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
		else { return none }
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
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_gateways_paypal_request_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

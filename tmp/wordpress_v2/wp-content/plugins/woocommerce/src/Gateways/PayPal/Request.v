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

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) construct(mut var_gateway Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) {
	this.gateway = var_gateway
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
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal order creation failed. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_response.clone().is_array()) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('PayPal order creation failed. Invalid response type.'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.clone(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response_array := if var_response_data.clone().is_array() { var_response_data } else { rt.new_array() }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_paypal_standard_order_created_response'), var_http_code.clone(), var_response_array.clone(), var_order])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_http_code.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 200 }, rt.ArrayItem{ key: none, val: 201 }]), rt.new_bool(true)]))))) {
		var_paypal_debug_id = if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get(rt.new_string('debug_id')) } else { rt.new_null() }
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal order creation failed. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str())))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_redirect_url := rt.new_null()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !rt.is_true(var_js_sdk_params.array_get(rt.new_string('is_js_sdk_flow'))) {
		var_redirect_url = rt.new_string(this.get_approve_link(var_http_code.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_response_data)))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !rt.is_true(var_redirect_url) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('PayPal order creation failed. Missing approval link.'))))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(), var_response_data.array_get(rt.new_string('id')))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), var_response_data.array_get(rt.new_string('status')))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_payment_source(), rt.new_string(payment_source_mutated))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.save()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: var_response_data.array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'redirect_url', val: var_redirect_url }])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_0 := iife_temp_0.log(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(var_paypal_debug_id) {
			var_order.add_order_note(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('PayPal order creation failed. PayPal debug ID: %1$s'), rt.new_string('woocommerce')]), var_paypal_debug_id.clone()]))
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
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal order details request failed: ' + (rt.call_function('esc_html', [rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])).str())))
	}
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	mut var_response_data := rt.call_function('json_decode', [var_body.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_http_code)))) {
		mut var_debug_id := if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get(rt.new_string('debug_id')) } else { rt.new_null() }
		mut var_message := rt.new_string('PayPal order details request failed. HTTP ' + rt.new_int((var_http_code).to_i64()).str() + if rt.is_true(var_debug_id) { '. Debug ID: ' + (var_debug_id).str() } else { '' })
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [var_message.clone()]))))
	}
	return var_response_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) authorize_or_capture_payment(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order, mut var_action_url Class_Automattic_WooCommerce_Gateways_PayPal_?string, action string, is_retry bool) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_1 := iife_temp_1.log(rt.new_string('Order not found to authorize or capture payment.'))
		return
	}
	mut var_paypal_debug_id := rt.new_null()
	mut var_paypal_order_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order_id)))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_2 := iife_temp_2.log(rt.new_string('PayPal order ID not found. Cannot ' + action + ' payment.'))
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action_url)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [var_action_url, rt.get_constant('FILTER_VALIDATE_URL')]))))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_3 := iife_temp_3.log(rt.new_string('Invalid or missing action URL. Cannot ' + action + ' payment.'))
		return
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), rt.new_bool(true)))) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_4 := iife_temp_4.log(rt.new_string('PayPal payment is already captured. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return
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
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal ' + action + ' payment request failed. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.clone(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_issue := if var_response_data.array_get(rt.new_string('details')).array_get(rt.new_int(0)).array_isset(rt.new_string('issue')) { var_response_data.array_get(rt.new_string('details')).array_get(rt.new_int(0)).array_get(rt.new_string('issue')) } else { rt.new_string('') }
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_duplicate_invoice_id := rt.new_bool(rt.is_true(rt.identical(rt.new_int(422), var_http_code)) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_duplicate_invoice_id(), var_issue)))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(var_duplicate_invoice_id) && !(var_is_retry) {
		this.handle_duplicate_invoice_id(mut var_order, (var_paypal_order_id).str(), var_action_url, action)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_http_code)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(201), var_http_code)))) {
		var_paypal_debug_id = if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get(rt.new_string('debug_id')) } else { rt.new_null() }
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal ' + action + ' payment failed. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str())))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		mut iife_temp_5 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_5 := iife_temp_5.log(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		mut var_note_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('PayPal %1$s payment failed. PayPal Order ID: %2$s'), rt.new_string('woocommerce')]), rt.new_string(action), var_paypal_order_id.clone()])
		if rt.is_true(var_paypal_debug_id) {
			var_note_message = rt.concat(var_note_message, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('. PayPal debug ID: %s'), rt.new_string('woocommerce')]), var_paypal_debug_id.clone()]))
		}
		var_order.add_order_note(var_note_message.clone())
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

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) capture_authorized_payment(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_6 := iife_temp_6.log(rt.new_string('Order not found to capture authorized payment.'))
		return
	}
	mut var_paypal_order_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order_id)))) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_7 := iife_temp_7.log(rt.new_string('PayPal Order ID not found to capture authorized payment. Order ID: ' + (var_order.get_id()).str()))
		return
	}
	mut var_capture_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(), rt.new_bool(true))
	if rt.is_true(var_capture_id) {
		mut iife_temp_8 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_8 := iife_temp_8.log(rt.new_string('PayPal payment is already captured. PayPal capture ID: ' + (var_capture_id).str() + '. Order ID: ' + (var_order.get_id()).str()))
		return
	}
	mut var_paypal_status := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), rt.new_bool(true))
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured(), var_paypal_status)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), var_paypal_status)) {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_9 := iife_temp_9.log(rt.new_string('PayPal payment is already captured. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_payer_action_required(), var_paypal_status)) {
		mut iife_temp_10 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_10 := iife_temp_10.log(rt.new_string('PayPal payment requires payer action. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.voided(), var_paypal_status)) {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_11 := iife_temp_11.log(rt.new_string('PayPal payment voided. Skipping capture. Order ID: ' + (var_order.get_id()).str()))
		return
	}
	mut var_authorization_id := rt.new_string(this.get_authorization_id_for_capture(mut var_order))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_authorization_id)))) {
		mut iife_temp_12 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_12 := iife_temp_12.log(rt.new_string('Authorization ID not found to capture authorized payment. Order ID: ' + (var_order.get_id()).str()))
		return
	}
	mut var_paypal_debug_id := rt.new_null()
	mut var_http_code := rt.new_null()
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }, rt.ArrayItem{ key: 'authorization_id', val: var_authorization_id }, rt.ArrayItem{ key: 'paypal_order_id', val: var_paypal_order_id }])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_response := this.send_wpcom_proxy_request('POST', (Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_payment_capture_auth_endpoint()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal capture payment request failed. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_http_code = rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.clone(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_issue := if var_response_data.array_get(rt.new_string('details')).array_get(rt.new_int(0)).array_isset(rt.new_string('issue')) { var_response_data.array_get(rt.new_string('details')).array_get(rt.new_int(0)).array_get(rt.new_string('issue')) } else { rt.new_string('') }
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_auth_already_captured := rt.new_bool(rt.is_true(rt.identical(rt.new_int(422), var_http_code)) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_authorization_already_captured(), var_issue)))
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_http_code)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(201), var_http_code)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_auth_already_captured)))) {
		var_paypal_debug_id = if var_response_data.array_isset(rt.new_string('debug_id')) { var_response_data.array_get(rt.new_string('debug_id')) } else { rt.new_null() }
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal capture payment failed. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str())))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_order.save()
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		mut iife_temp_13 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_13 := iife_temp_13.log(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		mut var_note_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('PayPal capture authorized payment failed'), rt.new_string('woocommerce')])])
		if rt.is_true(rt.identical(rt.new_int(404), var_http_code)) {
			mut var_paypal_dashboard_url := rt.new_string((if rt.is_true(rt.get_property(this.gateway, 'testmode')) { 'https://www.sandbox.paypal.com/unifiedtransactions' } else { 'https://www.paypal.com/unifiedtransactions' }).str())
			var_note_message = rt.concat(var_note_message, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('. Authorization ID: %1$s not found. Please log into your %2$sPayPal account%3$s to capture the payment'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_authorization_id.clone()]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_paypal_dashboard_url.clone()])).str() + '" target="_blank">'), rt.new_string('</a>')]))
			var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_checked(), rt.new_string('yes'))
		}
		if rt.is_true(var_paypal_debug_id) {
			var_note_message = rt.concat(var_note_message, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('. PayPal debug ID: %s'), rt.new_string('woocommerce')]), var_paypal_debug_id.clone()]))
		}
		var_order.add_order_note(var_note_message.clone())
		var_order.save()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) handle_duplicate_invoice_id(mut var_order Class_WC_Order, paypal_order_id string, action_url string, action string) {
	mut paypal_order_id_mutated := paypal_order_id
	mut var_new_invoice_id := rt.new_string(this.generate_paypal_invoice_id_with_unique_suffix(mut var_order))
	mut iife_temp_14 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
	mut iife_result_14 := iife_temp_14.log(rt.new_string('Attempting to patch PayPal order invoice_id. PayPal Order ID: ' + paypal_order_id_mutated + '. New invoice_id: ' + (var_new_invoice_id).str() + '. Order ID: ' + (var_order.get_id()).str()))
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'op', val: 'replace' }, rt.ArrayItem{ key: 'path', val: '/purchase_units/@reference_id==\'default\'/invoice_id' }, rt.ArrayItem{ key: 'value', val: var_new_invoice_id }]) }]) }])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_response := this.send_wpcom_proxy_request('PATCH', (Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_order_endpoint()).str() + '/' + paypal_order_id_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('PayPal patch invoice_id request failed. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.clone(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_http_code)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(204), var_http_code)))) {
		mut iife_temp_15 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_15 := iife_temp_15.log(rt.new_string('PayPal patch invoice_id failed. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str()))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Failed to patch PayPal order invoice_id. Response status: ' + (var_http_code).str())))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut iife_temp_16 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
	mut iife_result_16 := iife_temp_16.log(rt.new_string('Successfully patched PayPal order invoice_id. PayPal Order ID: ' + paypal_order_id_mutated + '. New invoice_id: ' + (var_new_invoice_id).str() + '. Order ID: ' + (var_order.get_id()).str()))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	var_order.add_order_note(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('PayPal order Invoice ID updated to %1$s to ensure uniqueness.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_new_invoice_id.clone()])]))
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	var_order.save()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	this.authorize_or_capture_payment(mut var_order, mut action_url, action, true)
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		mut iife_temp_17 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_17 := iife_temp_17.log(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))))
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) generate_paypal_invoice_id_with_unique_suffix(mut var_order Class_WC_Order) string {
	mut var_prefix := rt.call_method(this.gateway, 'get_option', [rt.new_string('invoice_prefix')])
	mut var_order_number := var_order.get_order_number()
	mut var_base_invoice_id := rt.new_string((var_prefix).str() + (var_order_number).str())
	mut var_unique_id := rt.call_function('bin2hex', [rt.call_function('random_bytes', [rt.new_int(6)])])
	mut var_invoice_id := rt.new_string(this.limit_length((var_base_invoice_id).str() + '-' + (var_unique_id).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_invoice_id_max_length()).to_i64()))
	return (var_invoice_id).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_authorization_id_for_capture(mut var_order Class_WC_Order) string {
	mut var_paypal_order_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(), rt.new_bool(true))
	mut var_authorization_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_id(), rt.new_bool(true))
	mut var_capture_id := var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order_id)))) || !(!rt.is_true(var_capture_id)) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), var_order.get_meta(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_checked(), rt.new_bool(true)))) {
		return (rt.new_null()).str()
	}
	if !rt.is_true(var_authorization_id) {
		mut iife_temp_18 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_18 := iife_temp_18.log(rt.new_string('Authorization ID not found, trying to retrieve from PayPal order details as a fallback for backwards compatibility. Order ID: ' + (var_order.get_id()).str()))
		mut var_order_data := this.get_paypal_order_details((var_paypal_order_id).str())
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		unsafe { goto end_label_5 }

catch_label_5:
		mut var_e_5 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_5, 'Exception') {
			mut var_e := var_e_5.clone()
			mut iife_temp_19 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			mut iife_result_19 := iife_temp_19.log(rt.new_string('Error retrieving PayPal order details. Order ID: ' + (var_order.get_id()).str() + '. Error: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.new_string('HTTP 404')]))))) {
				var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_checked(), rt.new_string('yes'))
				var_order.save()
			}
			return (rt.new_null()).str()
			unsafe { goto end_label_5 }
		}
		else {
			rt.throw_exception(var_e_5)
			unsafe { goto end_label_5 }
		}

end_label_5:
		mut var_authorization_data := this.get_latest_transaction_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if !(var_order_data.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('payments')).array_get(rt.new_string('authorizations'))).is_null() { var_order_data.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('payments')).array_get(rt.new_string('authorizations')) } else { rt.new_array() }))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		mut var_capture_data := this.get_latest_transaction_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if !(var_order_data.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('payments')).array_get(rt.new_string('captures'))).is_null() { var_order_data.array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('payments')).array_get(rt.new_string('captures')) } else { rt.new_array() }))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		if rt.is_true(var_capture_data) && var_capture_data.array_isset(rt.new_string('id')) {
			var_capture_id = var_capture_data.array_get(rt.new_string('id'))
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(), var_capture_id.clone())
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), if !(var_capture_data.array_get(rt.new_string('status'))).is_null() { var_capture_data.array_get(rt.new_string('status')) } else { Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured() })
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.save()
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			mut iife_temp_20 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			mut iife_result_20 := iife_temp_20.log(rt.new_string('Storing capture ID from Paypal. Order ID: ' + (var_order.get_id()).str() + '; capture ID: ' + (var_capture_id).str()))
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			return (rt.new_null()).str()
		}
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		if rt.is_true(var_authorization_data) && var_authorization_data.array_isset(rt.new_string('id')) && var_authorization_data.array_isset(rt.new_string('status')) {
			if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured(), var_authorization_data.array_get(rt.new_string('status')))) {
				var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured())
				if rt.has_exception() { unsafe { goto catch_label_6 } }
				var_order.save()
				if rt.has_exception() { unsafe { goto catch_label_6 } }
				return (rt.new_null()).str()
			}
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_authorization_id = var_authorization_data.array_get(rt.new_string('id'))
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_id(), var_authorization_id.clone())
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_authorized())
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			mut iife_temp_21 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			mut iife_result_21 := iife_temp_21.log(rt.new_string('Storing authorization ID from Paypal. Order ID: ' + (var_order.get_id()).str() + '; authorization ID: ' + (var_authorization_id).str()))
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.save()
			if rt.has_exception() { unsafe { goto catch_label_6 } }
		} else {
			mut iife_temp_22 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			mut iife_result_22 := iife_temp_22.log(rt.new_string('Authorization ID not found in PayPal order details. Order ID: ' + (var_order.get_id()).str()))
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_checked(), rt.new_string('yes'))
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_order.save()
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			return (rt.new_null()).str()
		}
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		unsafe { goto end_label_6 }

catch_label_6:
		mut var_e_6 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_6, 'Exception') {
			var_e = var_e_6.clone()
			mut iife_temp_23 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			mut iife_result_23 := iife_temp_23.log(rt.new_string('Error retrieving authorization ID from PayPal order details. Order ID: ' + (var_order.get_id()).str() + '. Error: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()))
			return (rt.new_null()).str()
			unsafe { goto end_label_6 }
		}
		else {
			rt.throw_exception(var_e_6)
			unsafe { goto end_label_6 }
		}

end_label_6:
	}
	return (var_authorization_id).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_latest_transaction_data(mut var_items Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut var_items_mutated := var_items
	if !rt.is_true(var_items_mutated) {
		return rt.new_null()
	}
	mut var_latest_item := rt.new_null()
	mut var_latest_time := rt.new_null()
	mut iter_1 := var_items_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if !rt.is_true(var_item.array_get(rt.new_string('update_time'))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_null(), var_latest_time)) || rt.is_true(rt.greater(var_item.array_get(rt.new_string('update_time')), var_latest_time)) {
		var_latest_time = var_item.array_get(rt.new_string('update_time'))
		var_latest_item = var_item
		}
	}
	return var_latest_item.clone()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_approve_link(var_http_code rt.PhpVal, mut var_response_data Class_Automattic_WooCommerce_Gateways_PayPal_array) string {
	mut var_http_code_mutated := var_http_code
	mut var_response_data_mutated := var_response_data
	if var_response_data_mutated.array_isset(rt.new_string('status')) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_payer_action_required(), var_response_data_mutated.array_get(rt.new_string('status')))) {
	mut var_rel := rt.new_string('payer-action')
	} else {
	var_rel = rt.new_string('approve')
	}
	mut iter_2 := var_response_data_mutated.array_get(rt.new_string('links')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_link := item_2.val
		if rt.is_true(rt.identical(var_rel, var_link.array_get(rt.new_string('rel')))) && rt.is_true(rt.identical(rt.new_string('GET'), var_link.array_get(rt.new_string('method')))) && rt.is_true(rt.call_function('filter_var', [var_link.array_get(rt.new_string('href')), rt.get_constant('FILTER_VALIDATE_URL')])) {
			return (rt.call_function('esc_url_raw', [var_link.array_get(rt.new_string('href'))])).str()
		}
	}
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_create_order_request_params(mut var_order Class_WC_Order, payment_source string, mut var_js_sdk_params Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut payment_source_mutated := payment_source
	mut var_payee_email := rt.call_function('sanitize_email', [rt.new_string((rt.call_method(this.gateway, 'get_option', [rt.new_string('email')])).str())])
	mut var_shipping_preference := rt.new_string(this.get_paypal_shipping_preference(mut var_order))
	mut var_supported_currencies := rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_supported_currencies'), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_currencies()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_order.get_currency().to_string().to_upper()), var_supported_currencies.clone(), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Currency is not supported by PayPal. Order ID: ' + (rt.call_function('esc_html', [rt.new_string((var_order.get_id()).str())])).str())))
	}
	mut var_purchase_unit_amount := this.get_paypal_order_purchase_unit_amount(mut var_order)
	if rt.is_true(rt.less_equal(var_purchase_unit_amount.array_get(rt.new_string('value')), rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Cannot build PayPal order purchase unit amount. Order total is not valid. Order ID: ' + (rt.call_function('esc_html', [rt.new_string((var_order.get_id()).str())])).str() + ', Total: ' + (rt.call_function('esc_html', [rt.new_string((var_purchase_unit_amount.array_get(rt.new_string('value'))).str())])).str())))
	}
	mut var_order_items := this.get_paypal_order_items(mut var_order)
	mut var_src_locale := rt.call_function('get_locale', []rt.PhpVal{})
	if rt.is_true(rt.greater(rt.new_int(var_src_locale.clone().to_string().len), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_locale_max_length())) {
		mut var_locale_parts := rt.call_function('explode', [rt.new_string('_'), var_src_locale.clone()])
		if var_locale_parts.clone().array_count() > 2 {
		var_src_locale = rt.new_string((var_locale_parts.array_get(rt.new_int(0))).str() + '_' + (var_locale_parts.array_get(rt.new_int(1))).str())
		}
	}
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'intent', val: this.get_paypal_order_intent() }, rt.ArrayItem{ key: 'payment_source', val: rt.create_array([rt.ArrayItem{ key: payment_source_mutated, val: rt.create_array([rt.ArrayItem{ key: 'experience_context', val: rt.create_array([rt.ArrayItem{ key: 'user_action', val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.user_action_pay_now() }, rt.ArrayItem{ key: 'shipping_preference', val: var_shipping_preference }, rt.ArrayItem{ key: 'return_url', val: this.normalize_url_for_paypal((rt.call_function('add_query_arg', [rt.new_string('utm_nooverride'), rt.new_string('1'), rt.call_method(this.gateway, 'get_return_url', [var_order])])).str()) }, rt.ArrayItem{ key: 'cancel_url', val: this.normalize_url_for_paypal((rt.call_function('wc_get_checkout_url', []rt.PhpVal{})).str()) }, rt.ArrayItem{ key: 'locale', val: rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_src_locale.clone()]) }, rt.ArrayItem{ key: 'app_switch_preference', val: rt.create_array([rt.ArrayItem{ key: 'launch_paypal_app', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'purchase_units', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'custom_id', val: this.get_paypal_order_custom_id(mut var_order) }, rt.ArrayItem{ key: 'amount', val: var_purchase_unit_amount }, rt.ArrayItem{ key: 'invoice_id', val: this.limit_length((rt.call_method(this.gateway, 'get_option', [rt.new_string('invoice_prefix')])).str() + (var_order.get_order_number()).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_invoice_id_max_length()).to_i64()) }, rt.ArrayItem{ key: 'items', val: var_order_items }, rt.ArrayItem{ key: 'payee', val: rt.create_array([rt.ArrayItem{ key: 'email_address', val: var_payee_email }]) }]) }]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_shipping_preference.clone(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_no_shipping() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_set_provided_address() }]), rt.new_bool(true)]))))) {
		mut var_shipping_callback_token := rt.new_string(this.generate_shipping_callback_token(mut var_order))
		mut var_callback_url := rt.call_function('add_query_arg', [rt.new_string('token'), var_shipping_callback_token.clone(), rt.call_function('rest_url', [rt.new_string('wc/v3/paypal-standard/update-shipping')])])
		var_params.array_get_mut('payment_source').array_get_mut(payment_source_mutated).array_get_mut('experience_context').array_set('order_update_callback_config', rt.create_array([rt.ArrayItem{ key: 'callback_events', val: rt.create_array([rt.ArrayItem{ key: none, val: 'SHIPPING_ADDRESS' }, rt.ArrayItem{ key: none, val: 'SHIPPING_OPTIONS' }]) }, rt.ArrayItem{ key: 'callback_url', val: this.normalize_url_for_paypal((var_callback_url).str()) }]))
	}
	if !(!rt.is_true(var_js_sdk_params.array_get(rt.new_string('is_js_sdk_flow')))) && !(!rt.is_true(var_js_sdk_params.array_get(rt.new_string('app_switch_request_origin')))) {
		mut var_request_origin := var_js_sdk_params.array_get(rt.new_string('app_switch_request_origin'))
		mut var_origin_parts := rt.call_function('wp_parse_url', [var_request_origin.clone()])
		mut var_site_parts := rt.call_function('wp_parse_url', [rt.call_function('get_site_url', []rt.PhpVal{})])
		mut var_is_valid_url := rt.call_function('filter_var', [var_request_origin.clone(), rt.get_constant('FILTER_VALIDATE_URL')])
		mut var_is_expected_scheme := rt.new_bool(var_origin_parts.array_isset(rt.new_string('scheme')) && var_site_parts.array_isset(rt.new_string('scheme')) && rt.is_true(rt.identical(rt.call_function('strcasecmp', [var_origin_parts.array_get(rt.new_string('scheme')), var_site_parts.array_get(rt.new_string('scheme'))]), rt.new_int(0))))
		mut var_is_expected_host := rt.new_bool(var_origin_parts.array_isset(rt.new_string('host')) && var_site_parts.array_isset(rt.new_string('host')) && rt.is_true(rt.identical(rt.call_function('strcasecmp', [var_origin_parts.array_get(rt.new_string('host')), var_site_parts.array_get(rt.new_string('host'))]), rt.new_int(0))))
		if rt.is_true(var_is_valid_url) && rt.is_true(var_is_expected_scheme) && rt.is_true(var_is_expected_host) {
			mut var_cancel_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order.get_id() }]), var_request_origin.clone()])
			var_params.array_get_mut('payment_source').array_get_mut(payment_source_mutated).array_get_mut('experience_context').array_set('cancel_url', this.normalize_url_for_paypal((var_cancel_url).str()))
		}
	}
	mut var_shipping := this.get_paypal_order_shipping(mut var_order)
	if rt.is_true(var_shipping) {
		var_params.array_get_mut('purchase_units').array_get_mut(0).array_set('shipping', var_shipping.clone())
	} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_set_provided_address(), var_shipping_preference)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Shipping address is required for PayPal create-order request. Order ID: ' + (rt.call_function('esc_html', [rt.new_string((var_order.get_id()).str())])).str())))
	}
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_purchase_unit_amount(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_?WC_Order) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_array()
	}
	mut var_currency := var_order.get_currency()
	return rt.create_array([rt.ArrayItem{ key: 'currency_code', val: var_currency }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [var_order.get_total(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'breakdown', val: rt.create_array([rt.ArrayItem{ key: 'item_total', val: rt.create_array([rt.ArrayItem{ key: 'currency_code', val: var_currency }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [rt.new_float(this.get_paypal_order_items_subtotal(mut var_order)), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) }]) }, rt.ArrayItem{ key: 'shipping', val: rt.create_array([rt.ArrayItem{ key: 'currency_code', val: var_currency }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [var_order.get_shipping_total(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) }]) }, rt.ArrayItem{ key: 'tax_total', val: rt.create_array([rt.ArrayItem{ key: 'currency_code', val: var_currency }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [var_order.get_total_tax(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) }]) }, rt.ArrayItem{ key: 'discount', val: rt.create_array([rt.ArrayItem{ key: 'currency_code', val: var_currency }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [var_order.get_discount_total(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_custom_id(mut var_order Class_WC_Order) string {
	mut iife_temp_24 := Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{}
	mut iife_result_24 := iife_temp_24.get_option(rt.new_string('id'))
	mut var_custom_id := rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order.get_id() }, rt.ArrayItem{ key: 'order_key', val: var_order.get_order_key() }, rt.ArrayItem{ key: 'site_url', val: rt.call_function('home_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'site_id', val: if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Jetpack_Options')])) { iife_result_24 } else { rt.new_null() } }, rt.ArrayItem{ key: 'v', val: if rt.is_true(rt.call_function('defined', [rt.new_string('WC_VERSION')])) { rt.get_constant('WC_VERSION') } else { rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version') } }])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_custom_id)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Failed to encode custom ID.'))))
	}
	if var_custom_id.clone().to_string().len > 255 {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('PayPal order custom ID is too long. Max length is 255 chars.'))))
	}
	return (if rt.is_true(var_custom_id) { var_custom_id } else { rt.new_string('') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_items(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_items := rt.new_array()
	mut iter_3 := var_order.get_items(rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.line_item() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.fee() }])).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		mut var_item_amount := rt.new_float(this.get_paypal_order_item_amount(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item](var_item)))
		if rt.is_true(rt.less(var_item_amount, rt.new_int(0))) {
			return rt.new_array()
		}
		mut var_quantity := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
		if !(var_quantity.clone().is_long() || var_quantity.clone().is_double()) || rt.is_true(rt.less_equal(var_quantity, rt.new_int(0))) || rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('floor', [var_quantity.clone()]), var_quantity)))) {
			return rt.new_array()
		}
		var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: this.limit_length((rt.call_method(var_item, 'get_name', []rt.PhpVal{})).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_item_name_max_length()).to_i64()) }, rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'unit_amount', val: rt.create_array([rt.ArrayItem{ key: 'currency_code', val: var_order.get_currency() }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [var_item_amount.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) }]) }]))
	}
	return var_items.clone()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_items_subtotal(mut var_order Class_WC_Order) f64 {
	mut var_total := rt.new_int(0)
	mut iter_4 := var_order.get_items(rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.line_item() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderItemType.fee() }])).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_item := item_4.val
		var_total = rt.add(var_total, rt.call_function('wc_add_number_precision', [rt.new_float(this.get_paypal_order_item_amount(mut var_order, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item](var_item)) * rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})), rt.new_bool(false)]))
	}
	return (rt.call_function('wc_remove_number_precision', [var_total.clone()])).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_item_amount(mut var_order Class_WC_Order, mut var_item Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item) f64 {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderItemType.fee(), var_item.get_type())) && rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item', []string{}, var_item), 'Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item_Fee'))) {
		return rt.new_float((var_item.get_amount()).to_f64())
	}
	mut var_include_tax := rt.new_bool(false)
	mut var_rounding_enabled := rt.new_bool(false)
	return rt.new_float((var_order.get_item_subtotal(rt.new_object('Automattic_WooCommerce_Gateways_PayPal_WC_Order_Item', []string{}, var_item), var_include_tax, var_rounding_enabled)).to_f64())
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_intent() string {
	mut var_payment_action := rt.call_method(this.gateway, 'get_option', [rt.new_string('paymentaction')])
	if rt.is_true(rt.identical(rt.new_string('authorization'), var_payment_action)) {
		return (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_authorize()).str()
	}
	return (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_capture()).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_shipping_preference(mut var_order Class_WC_Order) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order.needs_shipping())))) {
		return (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_no_shipping()).str()
	}
	mut var_address_override := rt.identical(rt.call_method(this.gateway, 'get_option', [rt.new_string('address_override')]), rt.new_string('yes'))
	return (if rt.is_true(var_address_override) { Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_set_provided_address() } else { Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_get_from_file() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) get_paypal_order_shipping(mut var_order Class_WC_Order) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order.needs_shipping())))) {
		return rt.new_null()
	}
	mut var_address_type := rt.new_string((if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_method(this.gateway, 'get_option', [rt.new_string('send_shipping')]))) { 'shipping' } else { 'billing' }).str())
	mut var_full_name := rt.new_string(rt.call_method(var_order, "get_formatted_${var_address_type.to_string()}_full_name", []rt.PhpVal{}).to_string().trim_space())
	mut var_address_line_1 := rt.new_string(rt.call_method(var_order, "get_${var_address_type.to_string()}_address_1", []rt.PhpVal{}).to_string().trim_space())
	mut var_address_line_2 := rt.new_string(rt.call_method(var_order, "get_${var_address_type.to_string()}_address_2", []rt.PhpVal{}).to_string().trim_space())
	mut var_state := rt.new_string(rt.call_method(var_order, "get_${var_address_type.to_string()}_state", []rt.PhpVal{}).to_string().trim_space())
	mut var_city := rt.new_string(rt.call_method(var_order, "get_${var_address_type.to_string()}_city", []rt.PhpVal{}).to_string().trim_space())
	mut var_postcode := rt.new_string(rt.call_method(var_order, "get_${var_address_type.to_string()}_postcode", []rt.PhpVal{}).to_string().trim_space())
	mut var_country := rt.new_string(rt.call_method(var_order, "get_${var_address_type.to_string()}_country", []rt.PhpVal{}).to_string().trim_space())
	if !rt.is_true(var_country) {
		return rt.new_null()
	}
	mut var_raw_country := var_country.clone()
	var_country = rt.new_string(this.normalize_paypal_order_shipping_country_code((var_raw_country).str()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_country)))) {
		mut iife_temp_25 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_25 := iife_temp_25.log(rt.call_function('sprintf', [rt.new_string('Could not identify a correct country code. Raw value: %s'), var_raw_country.clone()]), rt.new_string('error'))
		return rt.new_null()
	}
	mut iife_temp_26 := Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]}{}
	mut iife_result_26 := iife_temp_26.instance()
	mut var_address_requirements := iife_result_26
	if !rt.is_true(var_city) && rt.is_true(rt.call_method(var_address_requirements, 'country_requires_city', [var_country.clone()])) {
		mut iife_temp_27 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_27 := iife_temp_27.log(rt.call_function('sprintf', [rt.new_string('City is required for country: %s'), var_country.clone()]), rt.new_string('error'))
		return rt.new_null()
	}
	if !rt.is_true(var_postcode) && rt.is_true(rt.call_method(var_address_requirements, 'country_requires_postal_code', [var_country.clone()])) {
		mut iife_temp_28 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_28 := iife_temp_28.log(rt.call_function('sprintf', [rt.new_string('Postal code is required for country: %s'), var_country.clone()]), rt.new_string('error'))
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'full_name', val: var_full_name }]) }, rt.ArrayItem{ key: 'address', val: rt.create_array([rt.ArrayItem{ key: 'address_line_1', val: this.limit_length((var_address_line_1).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_address_line_max_length()).to_i64()) }, rt.ArrayItem{ key: 'address_line_2', val: this.limit_length((var_address_line_2).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_address_line_max_length()).to_i64()) }, rt.ArrayItem{ key: 'admin_area_1', val: this.limit_length((var_state).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_state_max_length()).to_i64()) }, rt.ArrayItem{ key: 'admin_area_2', val: this.limit_length((var_city).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_city_max_length()).to_i64()) }, rt.ArrayItem{ key: 'postal_code', val: this.limit_length((var_postcode).str(), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_postal_code_max_length()).to_i64()) }, rt.ArrayItem{ key: 'country_code', val: var_country.clone().to_string().to_upper() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) generate_shipping_callback_token(mut var_order Class_WC_Order) string {
	mut var_token := rt.call_function('bin2hex', [rt.call_function('random_bytes', [rt.new_int(32)])])
	var_order.update_meta_data(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_shipping_callback_token(), var_token.clone())
	var_order.save()
	return (var_token).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) normalize_paypal_order_shipping_country_code(country_code string) string {
	mut var_code := rt.new_string(country_code.trim_space().to_upper())
	if rt.is_true(rt.identical(rt.new_int(var_code.clone().to_string().len), Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_country_code_length())) {
		mut iife_temp_29 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		mut iife_result_29 := iife_temp_29.is_country_supported_by_paypal(var_code.clone())
		if rt.is_true(iife_result_29) {
			return (var_code).str()
		}
		mut iife_temp_30 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_30 := iife_temp_30.log(rt.call_function('sprintf', [rt.new_string('Invalid country code: %s'), var_code.clone()]))
		return (rt.new_null()).str()
	}
	mut iife_temp_31 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
	mut iife_result_31 := iife_temp_31.log(rt.call_function('sprintf', [rt.new_string('Unexpected country code length (%d) for country: %s'), rt.new_int(var_code.clone().to_string().len), var_code.clone()]))
	mut var_max_country_code_length := rt.add(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_country_code_length(), rt.new_int(1))
	if rt.is_true(rt.greater(rt.new_int(var_code.clone().to_string().len), var_max_country_code_length)) {
	var_code = rt.call_function('substr', [var_code.clone(), rt.new_int(0), var_max_country_code_length.clone()])
	}
	mut var_alpha2 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_from_alpha_3_code', [var_code.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_alpha2)) {
		mut iife_temp_32 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_32 := iife_temp_32.log(rt.call_function('sprintf', [rt.new_string('Invalid alpha-3 country code: %s'), var_code.clone()]), rt.new_string('error'))
		return (rt.new_null()).str()
	}
	mut iife_temp_33 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_33 := iife_temp_33.is_country_supported_by_paypal(var_alpha2.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_33)))) {
		mut iife_temp_34 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_34 := iife_temp_34.log(rt.call_function('sprintf', [rt.new_string('Country not supported by PayPal: %s (resolved from alpha-3: %s)'), var_alpha2.clone(), var_code.clone()]))
		return (rt.new_null()).str()
	}
	return (var_alpha2).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) normalize_url_for_paypal(url string) string {
	mut url_mutated := url
	url_mutated = (rt.call_function('str_replace', [rt.new_string('&#038;'), rt.new_string('&'), rt.new_string(url_mutated).clone()])).str()
	if rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(url_mutated).clone(), rt.call_function('home_url', []rt.PhpVal{})]), rt.new_int(0))) {
		return (rt.call_function('esc_url_raw', [rt.new_string(url_mutated).clone()])).str()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(url_mutated).clone(), rt.new_string('://')]), rt.new_bool(false))))) {
		return (rt.call_function('esc_url_raw', [rt.new_string(url_mutated).clone()])).str()
	}
	mut var_home_url := rt.call_function('untrailingslashit', [rt.call_function('home_url', []rt.PhpVal{})])
	if rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(url_mutated).clone(), rt.new_string('/')]), rt.new_int(0))) {
		return (rt.call_function('esc_url_raw', [rt.new_string((var_home_url).str() + url_mutated)])).str()
	}
	return (rt.call_function('esc_url_raw', [rt.new_string((var_home_url).str() + '/' + url_mutated)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) fetch_paypal_client_id() string {
	mut var_request_body := rt.create_array([rt.ArrayItem{ key: 'test_mode', val: rt.get_property(this.gateway, 'testmode') }])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_response := this.send_wpcom_proxy_request('GET', (Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_client_id_endpoint()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_request_body))
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Failed to fetch the client ID. Response error: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str())))
		if rt.has_exception() { unsafe { goto catch_label_7 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_http_code := rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_response_data := rt.call_function('json_decode', [var_body.clone(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_http_code)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception('Failed to fetch the client ID. Response status: ' + (var_http_code).str() + '. Response body: ' + (var_body).str())))
		if rt.has_exception() { unsafe { goto catch_label_7 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	return (if !(var_response_data.array_get(rt.new_string('client_id'))).is_null() { var_response_data.array_get(rt.new_string('client_id')) } else { rt.new_null() }).str()
	unsafe { goto end_label_7 }

catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Exception') {
		mut var_e := var_e_7.clone()
		mut iife_temp_35 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_35 := iife_temp_35.log(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
		return (rt.new_null()).str()
		unsafe { goto end_label_7 }
	}
	else {
		rt.throw_exception(var_e_7)
		unsafe { goto end_label_7 }
	}

end_label_7:
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) send_wpcom_proxy_request(method string, endpoint string, mut var_request_body Class_Automattic_WooCommerce_Gateways_PayPal_array) rt.PhpVal {
	mut endpoint_mutated := endpoint
	mut var_request_body_mutated := var_request_body
	mut iife_temp_36 := Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{}
	mut iife_result_36 := iife_temp_36.get_option(rt.new_string('id'))
	mut var_site_id := iife_result_36
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
		mut iife_temp_37 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_37 := iife_temp_37.log(rt.call_function('sprintf', [rt.new_string('Site ID not found. Cannot send request to %s.'), rt.new_string(endpoint_mutated).clone()]))
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Site ID not found. Cannot send proxy request.'))))
	}
	if rt.is_true(rt.identical(rt.new_string('GET'), rt.new_string(method))) {
		endpoint_mutated = endpoint_mutated + '?' + (rt.call_function('http_build_query', [var_request_body_mutated])).str()
	}
	mut iife_temp_38 := Class_Automattic_Jetpack_Connection_Client{}
	mut iife_result_38 := iife_temp_38.wpcom_json_api_request_as_blog(rt.call_function('sprintf', [rt.new_string('/sites/%d/%s/%s'), var_site_id.clone(), Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_rest_base(), rt.new_string(endpoint_mutated).clone()]), Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Request.wpcom_proxy_endpoint_api_version(), rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }, rt.ArrayItem{ key: 'User-Agent', val: 'TransactGateway/woocommerce/' + (rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() }]) }, rt.ArrayItem{ key: 'method', val: method }, rt.ArrayItem{ key: 'timeout', val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.wpcom_proxy_request_timeout() }]), if rt.is_true(rt.identical(rt.new_string('GET'), rt.new_string(method))) { rt.new_null() } else { rt.call_function('wp_json_encode', [var_request_body_mutated]) }, rt.new_string('wpcom'))
	mut var_response := iife_result_38
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) limit_length(text string, limit i64) string {
	mut text_mutated := text
	mut var_str_limit := rt.new_int(limit - 3)
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strimwidth')])) {
		if rt.is_true(rt.greater(rt.call_function('mb_strlen', [rt.new_string(text_mutated).clone()]), rt.new_int(limit))) {
		text_mutated = (rt.call_function('mb_strimwidth', [rt.new_string(text_mutated).clone(), rt.new_int(0), var_str_limit.clone()])).str() + '...'
		}
	} else if text_mutated.len > limit {
	text_mutated = (rt.call_function('substr', [rt.new_string(text_mutated).clone(), rt.new_int(0), var_str_limit.clone()])).str() + '...'
	}
	return text_mutated
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

struct Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Client {
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

fn create_automattic_woocommerce_gateways_paypal_wc_gateway_paypal(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_jetpack_options(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_{"nodetype":"expr_methodcall","line":1002,"var":{"nodetype":"expr_funccall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodetype":"arg","line":1002,"name":null,"expr":{"nodetype":"expr_classconstfetch","line":1002,"class":"paypaladdressrequirements","name":"class"},"byref":"false","unpack":"false"}]}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]} {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_client(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Client {
	mut obj := &Class_Automattic_Jetpack_Connection_Client{
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


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_{"nodeType":"Expr_MethodCall","line":1002,"var":{"nodeType":"Expr_FuncCall","line":1002,"name":"wc_get_container","args":[]},"name":"get","args":[{"nodeType":"Arg","line":1002,"name":null,"expr":{"nodeType":"Expr_ClassConstFetch","line":1002,"class":"PayPalAddressRequirements","name":"class"},"byRef":"false","unpack":"false"}]}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}

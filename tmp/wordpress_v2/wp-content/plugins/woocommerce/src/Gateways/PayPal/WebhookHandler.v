import rt

struct Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_webhook(mut var_request Class_Automattic_WooCommerce_Gateways_PayPal_WP_REST_Request) {
	mut var_data := var_request.get_json_params()
	if !(var_data.clone().is_array())
		|| !rt.is_true(var_data.array_get(rt.new_string('event_type')))
		|| !rt.is_true(var_data.array_get(rt.new_string('resource'))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_0 := iife_temp_0.log(rt.new_string('Invalid PayPal webhook payload: ' +
			(rt.call_function('wc_print_r', [var_data.clone(), rt.new_bool(true)])).str()))
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_1 := iife_temp_1.redact_data(var_data.clone())
	mut iife_temp_2 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_2 := iife_temp_2.redact_data(var_data.clone())
	mut iife_temp_3 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
	mut iife_result_3 := iife_temp_3.log(rt.new_string('Webhook received: ' +
		(rt.call_function('wc_print_r', [iife_result_1, rt.new_bool(true)])).str()))
	mut switch_val_1 := var_data.array_get(rt.new_string('event_type'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('CHECKOUT.ORDER.APPROVED'))) {
		this.process_checkout_order_approved(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PAYMENT.CAPTURE.PENDING'))) {
		this.process_payment_capture_pending(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PAYMENT.CAPTURE.COMPLETED'))) {
		this.process_payment_capture_completed(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PAYMENT.AUTHORIZATION.CREATED'))) {
		this.process_payment_authorization_created(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		mut iife_result_4 := iife_temp_4.redact_data(var_data.clone())
		mut iife_temp_5 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		mut iife_result_5 := iife_temp_5.redact_data(var_data.clone())
		mut iife_temp_6 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_6 := iife_temp_6.log(rt.new_string('Unhandled PayPal webhook event: ' +
			(rt.call_function('wc_print_r', [iife_result_4, rt.new_bool(true)])).str()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_checkout_order_approved(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('custom_id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('purchase_units')).array_get(rt.new_int(0)).array_get(rt.new_string('custom_id'))
	} else {
		rt.new_string('')
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_7 := iife_temp_7.get_wc_order_from_paypal_custom_id(var_custom_id.clone())
	mut var_order := iife_result_7
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_8 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_8 := iife_temp_8.log(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.clone(), rt.new_bool(true)])).str()))
		return
	}
	mut var_paypal_status := rt.call_method(var_order, 'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('in_array', [var_paypal_status.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_approved()
			},
		]),
		rt.new_bool(true)]))
	{
		return
	}
	mut var_status := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status'))
	} else {
		rt.new_null()
	}
	mut var_paypal_order_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_approved(),
		var_status))
	{
		mut iife_temp_9 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_9 := iife_temp_9.log(rt.new_string('PayPal payment approved. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()))
		rt.call_method(var_order, 'update_meta_data', [
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
			var_status.clone(),
		])
		rt.call_method(var_order, 'update_meta_data', [
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_shipping_callback_token(),
			rt.new_string(''),
		])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		rt.call_method(var_order, 'add_order_note', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('PayPal payment approved. PayPal Order ID: %1$s'),
					rt.new_string('woocommerce'),
				]),
				var_paypal_order_id.clone(),
			]),
		])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		mut iife_temp_10 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		mut iife_result_10 := iife_temp_10.update_addresses_in_order(var_order.clone(),
			var_event.array_get(rt.new_string('resource')))
		mut var_paypal_intent := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('intent'))).is_null() {
			var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('intent'))
		} else {
			rt.new_null()
		}
		mut var_action := if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_capture(),
			var_paypal_intent))
		{
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_capture()
		} else {
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_authorize()
		}
		mut var_links := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('links'))).is_null() {
			var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('links'))
		} else {
			rt.new_array()
		}
		if !(var_links.clone().is_array()) {
			var_links = rt.new_array()
		}
		this.authorize_or_capture_payment(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order](var_order), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_links),
			var_action.str())
	} else {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_11 := iife_temp_11.log(rt.new_string(
			'PayPal payment approval failed. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() + ' Status: ' +
			var_status.str()))
		rt.call_method(var_order, 'add_order_note', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('PayPal payment approval failed. PayPal Order ID: %1$s. Status: %2$s'),
					rt.new_string('woocommerce'),
				]),
				var_paypal_order_id.clone(),
				var_status.clone(),
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_payment_capture_completed(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('custom_id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('custom_id'))
	} else {
		rt.new_string('')
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_12 := iife_temp_12.get_wc_order_from_paypal_custom_id(var_custom_id.clone())
	mut var_order := iife_result_12
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_13 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_13 := iife_temp_13.log(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.clone(), rt.new_bool(true)])).str()))
		return
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])))
	{
		return
	}
	mut var_transaction_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))
	} else {
		rt.new_null()
	}
	mut var_status := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status'))
	} else {
		rt.new_null()
	}
	rt.call_method(var_order, 'set_transaction_id', [var_transaction_id.clone()])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(),
		var_transaction_id.clone(),
	])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		var_status.clone(),
	])
	rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
	rt.call_method(var_order, 'add_order_note', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('PayPal payment captured. Transaction ID: %1$s.'),
				rt.new_string('woocommerce'),
			]),
			var_transaction_id.clone(),
		]),
	])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_payment_capture_pending(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('custom_id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('custom_id'))
	} else {
		rt.new_string('')
	}
	mut iife_temp_14 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_14 := iife_temp_14.get_wc_order_from_paypal_custom_id(var_custom_id.clone())
	mut var_order := iife_result_14
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_15 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_15 := iife_temp_15.log(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.clone(), rt.new_bool(true)])).str()))
		return
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])))
	{
		return
	}
	mut var_transaction_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))
	} else {
		rt.new_null()
	}
	mut var_status := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status'))
	} else {
		rt.new_null()
	}
	mut var_reason := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status_details')).array_get(rt.new_string('reason'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('status_details')).array_get(rt.new_string('reason'))
	} else {
		rt.new_string('Unknown')
	}
	rt.call_method(var_order, 'set_transaction_id', [var_transaction_id.clone()])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(),
		var_transaction_id.clone(),
	])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		var_status.clone(),
	])
	rt.call_method(var_order, 'update_status', [
		Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Payment pending (reason: %s).'),
				rt.new_string('woocommerce')]),
			var_reason.clone(),
		]),
	])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_payment_authorization_created(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('custom_id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('custom_id'))
	} else {
		rt.new_string('')
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_16 := iife_temp_16.get_wc_order_from_paypal_custom_id(var_custom_id.clone())
	mut var_order := iife_result_16
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		mut iife_temp_17 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_17 := iife_temp_17.log(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.clone(), rt.new_bool(true)])).str()))
		return
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])))
	{
		return
	}
	mut var_transaction_id := if !(var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))).is_null() {
		var_event.array_get(rt.new_string('resource')).array_get(rt.new_string('id'))
	} else {
		rt.new_null()
	}
	rt.call_method(var_order, 'set_transaction_id', [var_transaction_id.clone()])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_id(),
		var_transaction_id.clone(),
	])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_authorized(),
	])
	rt.call_method(var_order, 'add_order_note', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('PayPal payment authorized. Transaction ID: %1$s. Change payment status to processing or complete to capture funds.'),
				rt.new_string('woocommerce'),
			]),
			var_transaction_id.clone(),
		]),
	])
	rt.call_method(var_order, 'update_status', [
		Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
	])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) authorize_or_capture_payment(mut var_order Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order, mut var_links Class_Automattic_WooCommerce_Gateways_PayPal_array, action string) {
	mut var_order_mutated := var_order
	mut var_links_mutated := var_links
	mut action_mutated := action
	mut var_action_url := rt.new_string(this.get_action_url(mut var_links_mutated, action_mutated))
	mut var_payment_gateways := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	if !(var_payment_gateways.array_isset(rt.new_string('paypal'))) {
		mut iife_temp_18 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		mut iife_result_18 := iife_temp_18.log(rt.new_string('PayPal gateway is not available.'))
		return
	}
	mut var_gateway := var_payment_gateways.array_get(rt.new_string('paypal'))
	mut var_paypal_request :=
		create_automattic_woocommerce_gateways_paypal_request(var_gateway.clone())
	var_paypal_request.authorize_or_capture_payment(rt.new_object('Automattic_WooCommerce_Gateways_PayPal_WC_Order',
		[]string{}, var_order_mutated), var_action_url.clone(), rt.new_string(action_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) get_action_url(mut var_links Class_Automattic_WooCommerce_Gateways_PayPal_array, action string) string {
	mut var_links_mutated := var_links
	mut action_mutated := action
	mut var_action_url := rt.new_null()
	mut iter_1 := var_links_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_link := item_1.val
		if rt.is_true(rt.identical(rt.new_string(action_mutated), var_link.array_get(rt.new_string('rel'))))
			&& rt.is_true(rt.identical(rt.new_string('POST'), var_link.array_get(rt.new_string('method'))))
			&& rt.is_true(rt.call_function('filter_var', [var_link.array_get(rt.new_string('href')), rt.get_constant('FILTER_VALIDATE_URL')])) {
			var_action_url = rt.call_function('esc_url_raw', [
				var_link.array_get(rt.new_string('href')),
			])
			break
		}
	}
	return var_action_url.str()
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_gateways_paypal_webhookhandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_wc_gateway_paypal(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{
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

fn create_automattic_woocommerce_gateways_paypal_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process_webhook' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_webhook(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_checkout_order_approved' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_checkout_order_approved(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_payment_capture_completed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_payment_capture_completed(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_payment_capture_pending' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_payment_capture_pending(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_payment_authorization_created' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_payment_authorization_created(mut dispatch_arg_0)
			return rt.new_null()
		}
		'authorize_or_capture_payment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.authorize_or_capture_payment(mut dispatch_arg_0, mut dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'get_action_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_action_url(mut dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}

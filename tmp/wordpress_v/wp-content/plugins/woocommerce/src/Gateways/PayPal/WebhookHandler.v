import rt

struct Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_webhook(mut var_request Class_Automattic_WooCommerce_Gateways_PayPal_WP_REST_Request) {
	mut var_data := var_request.get_json_params()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array())))))
		|| !rt.is_true(var_data.array_get('event_type'))))
		|| !rt.is_true(var_data.array_get('resource'))))
	{
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('Invalid PayPal webhook payload: ' +
			(rt.call_function('wc_print_r', [var_data.dup(), rt.new_bool(true)])).str()))
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
		return temp.log(arg_0)
	}(rt.new_string('Webhook received: ' +(rt.call_function('wc_print_r', [fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		return temp.redact_data(arg_0)
	}(var_data.dup()), rt.new_bool(true)])).str()))
	mut switch_val_1 := var_data.array_get('event_type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('CHECKOUT.ORDER.APPROVED'))) {
		this.process_checkout_order_approved(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PAYMENT.CAPTURE.PENDING'))) {
		this.process_payment_capture_pending(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PAYMENT.CAPTURE.COMPLETED'))) {
		this.process_payment_capture_completed(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PAYMENT.AUTHORIZATION.CREATED'))) {
		this.process_payment_authorization_created(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_data))
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('Unhandled PayPal webhook event: ' +(rt.call_function('wc_print_r', [fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
			return temp.redact_data(arg_0)
		}(var_data.dup()), rt.new_bool(true)])).str()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_checkout_order_approved(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get('resource').array_get('purchase_units').array_get(0).array_get('custom_id')).is_null() {
		var_event.array_get('resource').array_get('purchase_units').array_get(0).array_get('custom_id')
	} else {
		rt.new_string('')
	}
	mut var_order := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		return temp.get_wc_order_from_paypal_custom_id(arg_0)
	}(var_custom_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.dup(), rt.new_bool(true)])).str()))
		return rt.new_null()
	}
	mut var_paypal_status := rt.call_method(var_order, 'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('in_array', [var_paypal_status.dup(),
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
		return rt.new_null()
	}
	mut var_status := if !(var_event.array_get('resource').array_get('status')).is_null() {
		var_event.array_get('resource').array_get('status')
	} else {
		rt.new_null()
	}
	mut var_paypal_order_id := if !(var_event.array_get('resource').array_get('id')).is_null() {
		var_event.array_get('resource').array_get('id')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_approved(),
		var_status))
	{
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('PayPal payment approved. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()))
		rt.call_method(var_order, 'update_meta_data', [
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
			var_status.dup(),
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
				var_paypal_order_id.dup(),
			]),
		])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
			return temp.update_addresses_in_order(arg_0, arg_1)
		}(var_order.dup(), var_event.array_get('resource'))
		mut var_paypal_intent := if !(var_event.array_get('resource').array_get('intent')).is_null() {
			var_event.array_get('resource').array_get('intent')
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
		mut var_links := if !(var_event.array_get('resource').array_get('links')).is_null() {
			var_event.array_get('resource').array_get('links')
		} else {
			rt.new_array()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_links.dup().is_array()))))) {
			var_links = rt.new_array()
		}
		this.authorize_or_capture_payment(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_WC_Order](var_order), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](var_links),
			var_action.str())
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('PayPal payment approval failed. Order ID: ' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() + ' Status: ' +
			var_status.str()))
		rt.call_method(var_order, 'add_order_note', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('PayPal payment approval failed. PayPal Order ID: %1$s. Status: %2$s'),
					rt.new_string('woocommerce'),
				]),
				var_paypal_order_id.dup(),
				var_status.dup(),
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_payment_capture_completed(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get('resource').array_get('custom_id')).is_null() {
		var_event.array_get('resource').array_get('custom_id')
	} else {
		rt.new_string('')
	}
	mut var_order := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		return temp.get_wc_order_from_paypal_custom_id(arg_0)
	}(var_custom_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.dup(), rt.new_bool(true)])).str()))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])))
	{
		return rt.new_null()
	}
	mut var_transaction_id := if !(var_event.array_get('resource').array_get('id')).is_null() {
		var_event.array_get('resource').array_get('id')
	} else {
		rt.new_null()
	}
	mut var_status := if !(var_event.array_get('resource').array_get('status')).is_null() {
		var_event.array_get('resource').array_get('status')
	} else {
		rt.new_null()
	}
	rt.call_method(var_order, 'set_transaction_id', [var_transaction_id.dup()])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(),
		var_transaction_id.dup(),
	])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		var_status.dup(),
	])
	rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
	rt.call_method(var_order, 'add_order_note', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('PayPal payment captured. Transaction ID: %1$s.'),
				rt.new_string('woocommerce'),
			]),
			var_transaction_id.dup(),
		]),
	])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_payment_capture_pending(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get('resource').array_get('custom_id')).is_null() {
		var_event.array_get('resource').array_get('custom_id')
	} else {
		rt.new_string('')
	}
	mut var_order := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		return temp.get_wc_order_from_paypal_custom_id(arg_0)
	}(var_custom_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.dup(), rt.new_bool(true)])).str()))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])))
	{
		return rt.new_null()
	}
	mut var_transaction_id := if !(var_event.array_get('resource').array_get('id')).is_null() {
		var_event.array_get('resource').array_get('id')
	} else {
		rt.new_null()
	}
	mut var_status := if !(var_event.array_get('resource').array_get('status')).is_null() {
		var_event.array_get('resource').array_get('status')
	} else {
		rt.new_null()
	}
	mut var_reason := if !(var_event.array_get('resource').array_get('status_details').array_get('reason')).is_null() {
		var_event.array_get('resource').array_get('status_details').array_get('reason')
	} else {
		rt.new_string('Unknown')
	}
	rt.call_method(var_order, 'set_transaction_id', [var_transaction_id.dup()])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_capture_id(),
		var_transaction_id.dup(),
	])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		var_status.dup(),
	])
	rt.call_method(var_order, 'update_status', [
		Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Payment pending (reason: %s).'),
				rt.new_string('woocommerce')]),
			var_reason.dup(),
		]),
	])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) process_payment_authorization_created(mut var_event Class_Automattic_WooCommerce_Gateways_PayPal_array) {
	mut var_custom_id := if !(var_event.array_get('resource').array_get('custom_id')).is_null() {
		var_event.array_get('resource').array_get('custom_id')
	} else {
		rt.new_string('')
	}
	mut var_order := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
		return temp.get_wc_order_from_paypal_custom_id(arg_0)
	}(var_custom_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('Invalid order. Custom ID: ' +
			(rt.call_function('wc_print_r', [var_custom_id.dup(), rt.new_bool(true)])).str()))
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed(), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	])))
	{
		return rt.new_null()
	}
	mut var_transaction_id := if !(var_event.array_get('resource').array_get('id')).is_null() {
		var_event.array_get('resource').array_get('id')
	} else {
		rt.new_null()
	}
	rt.call_method(var_order, 'set_transaction_id', [var_transaction_id.dup()])
	rt.call_method(var_order, 'update_meta_data', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_authorization_id(),
		var_transaction_id.dup(),
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
			var_transaction_id.dup(),
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
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			return temp.log(arg_0)
		}(rt.new_string('PayPal gateway is not available.'))
		return rt.new_null()
	}
	mut var_gateway := var_payment_gateways.array_get('paypal')
	mut var_paypal_request :=
		create_automattic_woocommerce_gateways_paypal_request(var_gateway.dup())
	var_paypal_request.authorize_or_capture_payment(rt.new_object('Automattic_WooCommerce_Gateways_PayPal_WC_Order',
		[]string{}, var_order_mutated), var_action_url.dup(), rt.new_string(action_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) get_action_url(mut var_links Class_Automattic_WooCommerce_Gateways_PayPal_array, action string) string {
	mut var_links_mutated := var_links
	mut action_mutated := action
	mut var_action_url := rt.new_null()
	{
		mut iter_1 := var_links_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_link := item_1.val
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(action_mutated), var_link.array_get('rel')))
				&& rt.is_true(rt.identical(rt.new_string('POST'), var_link.array_get('method')))))
				&& rt.is_true(rt.call_function('filter_var', [var_link.array_get('href'), rt.get_constant('FILTER_VALIDATE_URL')]))))
			{
				var_action_url = rt.call_function('esc_url_raw', [
					var_link.array_get('href')])
				break
			}
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

fn create_automattic_woocommerce_gateways_paypal_webhookhandler() &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_wc_gateway_paypal() &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_helper() &Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Helper{
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

pub fn init_wp_content_plugins_woocommerce_src_gateways_paypal_webhookhandler_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}

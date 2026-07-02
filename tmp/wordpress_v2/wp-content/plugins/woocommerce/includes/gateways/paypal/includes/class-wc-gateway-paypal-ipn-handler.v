import rt

struct Class_WC_Gateway_Paypal_IPN_Handler {
	rt.PhpObjectBase
pub mut:
	receiver_email rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) construct(sandbox bool, receiver_email string) {
	rt.call_function('add_action', [rt.new_string('woocommerce_api_wc_gateway_paypal'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal_IPN_Handler', [
				'WC_Gateway_Paypal_Response',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_response' },
		])])
	rt.call_function('add_action', [rt.new_string('valid-paypal-standard-ipn-request'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal_IPN_Handler', [
				'WC_Gateway_Paypal_Response',
			], &this) },
			rt.ArrayItem{ key: none, val: 'valid_response' },
		])])
	this.receiver_email = rt.new_string(receiver_email)
	this.dispatch_set_prop('sandbox', rt.new_bool(sandbox))
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) check_response() {
	if !(!rt.is_true(rt.get_superglobal('_POST'))) && this.validate_ipn() {
		mut var_posted := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()])
		rt.call_function('do_action', [
			rt.new_string('valid-paypal-standard-ipn-request'),
			var_posted.clone(),
		])
		exit(0)
	}
	rt.call_function('wp_die', [rt.new_string('PayPal IPN Request Failure'),
		rt.new_string('PayPal IPN'), rt.create_array([
			rt.ArrayItem{ key: 'response', val: 500 },
		])])
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) valid_response(var_posted rt.PhpVal) {
	mut var_posted_mutated := var_posted
	mut var_order := if !(!rt.is_true(var_posted_mutated.array_get(rt.new_string('custom')))) {
		this.get_paypal_order(var_posted_mutated.array_get(rt.new_string('custom')))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(var_order) {
		var_posted_mutated.array_set('payment_status',
			var_posted_mutated.array_get(rt.new_string('payment_status')).to_string().to_lower())
		mut iife_temp_0 := Class_WC_Gateway_Paypal{}
		mut iife_result_0 := iife_temp_0.log(rt.new_string('Found order #' +
			(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()))
		mut iife_temp_1 := Class_WC_Gateway_Paypal{}
		mut iife_result_1 := iife_temp_1.log(rt.new_string('Payment status: ' +
			(var_posted_mutated.array_get(rt.new_string('payment_status'))).str()))
		if rt.is_true(rt.call_function('method_exists', [
			rt.new_object('WC_Gateway_Paypal_IPN_Handler', [
				'WC_Gateway_Paypal_Response',
			], &this),
			rt.new_string('payment_status_' +
				(var_posted_mutated.array_get(rt.new_string('payment_status'))).str()),
		]))
		{
			rt.call_function('call_user_func', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal_IPN_Handler', [
						'WC_Gateway_Paypal_Response',
					], &this) },
					rt.ArrayItem{ key: none, val: 'payment_status_' +
						(var_posted_mutated.array_get(rt.new_string('payment_status'))).str() },
				]),
				var_order.clone(),
				var_posted_mutated.clone(),
			])
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) validate_ipn() bool {
	mut iife_temp_2 := Class_WC_Gateway_Paypal{}
	mut iife_result_2 := iife_temp_2.log(rt.new_string('Checking IPN response is valid'))
	mut var_validate_ipn := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()])
	var_validate_ipn.array_set('cmd', '_notify-validate')
	mut var_params := {
		'body':        var_validate_ipn
		'timeout':     rt.new_int(60)
		'httpversion': rt.new_string('1.1')
		'compress':    rt.new_bool(false)
		'decompress':  rt.new_bool(false)
		'user-agent':  'WooCommerce/' +
			(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str()
	}
	mut var_response := rt.call_function('wp_safe_remote_post', [
		rt.new_string((if rt.is_true(rt.get_property(rt.new_object('WC_Gateway_Paypal_IPN_Handler', [
			'WC_Gateway_Paypal_Response',
		], &this), 'sandbox'))
		{
			'https://www.sandbox.paypal.com/cgi-bin/webscr'
		} else {
			'https://www.paypal.com/cgi-bin/webscr'
		}).str()),
		rt.create_array_from_native_map(var_params),
	])
	mut iife_temp_3 := Class_WC_Gateway_Paypal{}
	mut iife_result_3 := iife_temp_3.log(rt.new_string('IPN Response: ' +
		(rt.call_function('wc_print_r', [var_response.clone(), rt.new_bool(true)])).str()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])))))
		&& rt.is_true(rt.greater_equal(var_response.array_get(rt.new_string('response')).array_get(rt.new_string('code')), rt.new_int(200)))
		&& rt.is_true(rt.less(var_response.array_get(rt.new_string('response')).array_get(rt.new_string('code')), rt.new_int(300)))
		&& rt.is_true(rt.call_function('strstr', [var_response.array_get(rt.new_string('body')), rt.new_string('VERIFIED')])) {
		mut iife_temp_4 := Class_WC_Gateway_Paypal{}
		mut iife_result_4 :=
			iife_temp_4.log(rt.new_string('Received valid response from PayPal IPN'))
		return true
	}
	mut iife_temp_5 := Class_WC_Gateway_Paypal{}
	mut iife_result_5 := iife_temp_5.log(rt.new_string('Received invalid response from PayPal IPN'))
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		mut iife_temp_6 := Class_WC_Gateway_Paypal{}
		mut iife_result_6 := iife_temp_6.log(rt.new_string('Error response: ' +
			(rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str()))
	}
	return false
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) validate_transaction_type(var_txn_type rt.PhpVal) {
	mut var_accepted_types := ['cart', 'instant', 'express_checkout', 'web_accept', 'masspay',
		'send_money', 'paypal_here']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(var_txn_type.clone().to_string().to_lower()),
		rt.create_array_from_list(var_accepted_types),
		rt.new_bool(true),
	])))))
	{
		mut iife_temp_7 := Class_WC_Gateway_Paypal{}
		mut iife_result_7 := iife_temp_7.log(rt.new_string('Aborting, Invalid type:' +
			var_txn_type.str()))
		exit(0)
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) validate_currency(var_order rt.PhpVal, var_currency rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_currency', []rt.PhpVal{}), var_currency))))
	{
		mut iife_temp_8 := Class_WC_Gateway_Paypal{}
		mut iife_result_8 := iife_temp_8.log(rt.new_string(
			'Payment error: Currencies do not match (sent "' + (rt.call_method(var_order_mutated, 'get_currency', []rt.PhpVal{})).str() +
			'" | returned "' + var_currency.str() + '")'))
		rt.call_method(var_order_mutated, 'update_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Validation error: PayPal currencies do not match (code %s).'),
					rt.new_string('woocommerce'),
				]),
				var_currency.clone(),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) validate_amount(var_order rt.PhpVal, var_amount rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('number_format', [
		rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}),
		rt.new_int(2),
		rt.new_string('.'),
		rt.new_string(''),
	]), rt.call_function('number_format', [var_amount.clone(),
		rt.new_int(2), rt.new_string('.'), rt.new_string('')])))))
	{
		mut iife_temp_9 := Class_WC_Gateway_Paypal{}
		mut iife_result_9 := iife_temp_9.log(rt.new_string(
			'Payment error: Amounts do not match (gross ' + var_amount.str() + ')'))
		rt.call_method(var_order_mutated, 'update_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Validation error: PayPal amounts do not match (gross %s).'),
					rt.new_string('woocommerce'),
				]),
				var_amount.clone(),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) validate_receiver_email(var_order rt.PhpVal, var_receiver_email rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strcasecmp', [
		rt.new_string(var_receiver_email.clone().to_string().trim_space()),
		rt.new_string(this.receiver_email.to_string().trim_space()),
	]), rt.new_int(0)))))
	{
		mut iife_temp_10 := Class_WC_Gateway_Paypal{}
		mut iife_result_10 := iife_temp_10.log(rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('IPN Response is for another account: '),
			var_receiver_email), rt.new_string('. Your email is ')), this.receiver_email)).str()))
		rt.call_method(var_order_mutated, 'update_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Validation error: PayPal IPN response from a different email address (%s).'),
					rt.new_string('woocommerce'),
				]),
				var_receiver_email.clone(),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_completed(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
		rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{}),
	]))
	{
		mut iife_temp_11 := Class_WC_Gateway_Paypal{}
		mut iife_result_11 := iife_temp_11.log(rt.new_string('Aborting, Order #' +
			(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str() +
			' is already complete.'))
		exit(0)
	}
	this.validate_transaction_type(var_posted_mutated.array_get(rt.new_string('txn_type')))
	this.validate_currency(var_order_mutated.clone(),
		var_posted_mutated.array_get(rt.new_string('mc_currency')))
	this.validate_amount(var_order_mutated.clone(),
		var_posted_mutated.array_get(rt.new_string('mc_gross')))
	this.validate_receiver_email(var_order_mutated.clone(),
		var_posted_mutated.array_get(rt.new_string('receiver_email')))
	this.save_paypal_meta_data(var_order_mutated.clone(), var_posted_mutated.clone())
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.completed(),
		var_posted_mutated.array_get(rt.new_string('payment_status'))))
	{
		if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled(),
		]))
		{
			this.payment_status_paid_cancelled_order(var_order_mutated.clone(),
				var_posted_mutated.clone())
		}
		if !(!rt.is_true(var_posted_mutated.array_get(rt.new_string('mc_fee')))) {
			rt.call_method(var_order_mutated, 'add_meta_data', [
				rt.new_string('PayPal Transaction Fee'),
				rt.call_function('wc_clean',
					[var_posted_mutated.array_get(rt.new_string('mc_fee'))]),
			])
		}
		this.payment_complete(var_order_mutated.clone(), if !(!rt.is_true(var_posted_mutated.array_get(rt.new_string('txn_id')))) { rt.call_function('wc_clean', [
				var_posted_mutated.array_get(rt.new_string('txn_id')),
			]) } else { rt.new_string('') }, rt.call_function('__', [
			rt.new_string('IPN payment completed'),
			rt.new_string('woocommerce'),
		]))
	} else {
		if rt.is_true(rt.identical(rt.new_string('authorization'),
			var_posted_mutated.array_get(rt.new_string('pending_reason'))))
		{
			this.payment_on_hold(var_order_mutated.clone(), rt.call_function('__', [
				rt.new_string('Payment authorized. Change payment status to processing or complete to capture funds.'),
				rt.new_string('woocommerce'),
			]))
		} else {
			this.payment_on_hold(var_order_mutated.clone(), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Payment pending (%s).'),
					rt.new_string('woocommerce')]),
				var_posted_mutated.array_get(rt.new_string('pending_reason')),
			]))
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_pending(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	this.payment_status_completed(var_order_mutated.clone(), var_posted_mutated.clone())
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_failed(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	rt.call_method(var_order_mutated, 'update_status', [
		Class_Automattic_WooCommerce_Enums_OrderStatus.failed(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Payment %s via IPN.'),
				rt.new_string('woocommerce')]),
			rt.call_function('wc_clean',
				[var_posted_mutated.array_get(rt.new_string('payment_status'))]),
		]),
	])
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_denied(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	this.payment_status_failed(var_order_mutated.clone(), var_posted_mutated.clone())
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_expired(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	this.payment_status_failed(var_order_mutated.clone(), var_posted_mutated.clone())
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_voided(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	this.payment_status_failed(var_order_mutated.clone(), var_posted_mutated.clone())
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_paid_cancelled_order(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	this.send_ipn_email_notification(rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Payment for cancelled order %s received'),
			rt.new_string('woocommerce')]),
		rt.new_string('<a class="link" href="' +
			(rt.call_function('esc_url', [rt.call_method(var_order_mutated, 'get_edit_order_url', []rt.PhpVal{})])).str() +
			'">' + (rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{})).str() +
			'</a>'),
	]), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Order #%s has been marked paid by PayPal IPN, but was previously cancelled. Admin handling required.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{}),
	]))
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_refunded(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	if rt.is_true(rt.identical(rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}), rt.call_function('wc_format_decimal', [
		rt.mul(var_posted_mutated.array_get(rt.new_string('mc_gross')), -1),
		rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
	])))
	{
		rt.call_method(var_order_mutated, 'update_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.refunded(),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Payment %s via IPN.'),
					rt.new_string('woocommerce')]),
				rt.new_string(var_posted_mutated.array_get(rt.new_string('payment_status')).to_string().to_lower()),
			]),
		])
		this.send_ipn_email_notification(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Payment for order %s refunded'),
				rt.new_string('woocommerce')]),
			rt.new_string('<a class="link" href="' +
				(rt.call_function('esc_url', [rt.call_method(var_order_mutated, 'get_edit_order_url', []rt.PhpVal{})])).str() +
				'">' +
				(rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{})).str() +
				'</a>'),
		]), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Order #%1$s has been marked as refunded - PayPal reason code: %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{}),
			var_posted_mutated.array_get(rt.new_string('reason_code')),
		]))
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_reversed(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	rt.call_method(var_order_mutated, 'update_status', [
		Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Payment %s via IPN.'),
				rt.new_string('woocommerce')]),
			rt.call_function('wc_clean',
				[var_posted_mutated.array_get(rt.new_string('payment_status'))]),
		]),
	])
	this.send_ipn_email_notification(rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Payment for order %s reversed'),
			rt.new_string('woocommerce')]),
		rt.new_string('<a class="link" href="' +
			(rt.call_function('esc_url', [rt.call_method(var_order_mutated, 'get_edit_order_url', []rt.PhpVal{})])).str() +
			'">' + (rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{})).str() +
			'</a>'),
	]), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Order #%1$s has been marked on-hold due to a reversal - PayPal reason code: %2$s'),
			rt.new_string('woocommerce'),
		]),
		rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{}),
		rt.call_function('wc_clean', [
			var_posted_mutated.array_get(rt.new_string('reason_code')),
		]),
	]))
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) payment_status_canceled_reversal(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	this.send_ipn_email_notification(rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Reversal cancelled for order #%s'),
			rt.new_string('woocommerce')]),
		rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{}),
	]), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Order #%1$s has had a reversal cancelled. Please check the status of payment and update the order status accordingly here: %2$s'),
			rt.new_string('woocommerce'),
		]),
		rt.call_method(var_order_mutated, 'get_order_number', []rt.PhpVal{}),
		rt.call_function('esc_url', [
			rt.call_method(var_order_mutated, 'get_edit_order_url', []rt.PhpVal{}),
		]),
	]))
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) save_paypal_meta_data(var_order rt.PhpVal, var_posted rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_posted_mutated := var_posted
	if !(!rt.is_true(var_posted_mutated.array_get(rt.new_string('payment_type')))) {
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('Payment type'),
			rt.call_function('wc_clean',
				[var_posted_mutated.array_get(rt.new_string('payment_type'))]),
		])
	}
	if !(!rt.is_true(var_posted_mutated.array_get(rt.new_string('txn_id')))) {
		rt.call_method(var_order_mutated, 'set_transaction_id', [
			rt.call_function('wc_clean', [var_posted_mutated.array_get(rt.new_string('txn_id'))]),
		])
	}
	if !(!rt.is_true(var_posted_mutated.array_get(rt.new_string('payment_status')))) {
		rt.call_method(var_order_mutated, 'update_meta_data', [
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
			rt.call_function('wc_clean',
				[var_posted_mutated.array_get(rt.new_string('payment_status'))]),
		])
	}
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) send_ipn_email_notification(var_subject rt.PhpVal, var_message rt.PhpVal) {
	mut var_message_mutated := var_message
	mut var_new_order_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_new_order_settings'),
		rt.new_array(),
	])
	mut var_mailer := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{})
	var_message_mutated = rt.call_method(var_mailer, 'wrap_message', [
		var_subject.clone(), var_message_mutated.clone()])
	mut var_woocommerce_paypal_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_paypal_settings'),
	])
	if !(!rt.is_true(var_woocommerce_paypal_settings.array_get(rt.new_string('ipn_notification'))))
		&& rt.is_true(rt.identical(rt.new_string('no'), var_woocommerce_paypal_settings.array_get(rt.new_string('ipn_notification')))) {
		return
	}
	rt.call_method(var_mailer, 'send', [if !(!rt.is_true(var_new_order_settings.array_get(rt.new_string('recipient')))) { var_new_order_settings.array_get(rt.new_string('recipient')) } else { rt.call_function('get_option', [
			rt.new_string('admin_email'),
		]) }, rt.call_function('strip_tags', [
		var_subject.clone(),
	]),
		var_message_mutated.clone()])
}

struct Class_WC_Gateway_Paypal_Response {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_ipn_handler(sandbox bool, receiver_email string) &Class_WC_Gateway_Paypal_IPN_Handler {
	mut obj := &Class_WC_Gateway_Paypal_IPN_Handler{
		PhpObjectBase:  rt.PhpObjectBase{}
		receiver_email: rt.new_null()
	}
	obj.construct(sandbox, receiver_email)
	return obj
}

fn create_wc_gateway_paypal_response(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_Response {
	mut obj := &Class_WC_Gateway_Paypal_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'check_response' {
			this.check_response()
			return rt.new_null()
		}
		'valid_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.valid_response(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_ipn' {
			return rt.new_bool(this.validate_ipn())
		}
		'validate_transaction_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.validate_transaction_type(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_currency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_currency(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_amount(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'validate_receiver_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.validate_receiver_email(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_completed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_completed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_pending' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_pending(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_failed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_failed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_denied' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_denied(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_expired' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_expired(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_voided' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_voided(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_paid_cancelled_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_paid_cancelled_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_refunded(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_reversed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_reversed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'payment_status_canceled_reversal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.payment_status_canceled_reversal(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_paypal_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_paypal_meta_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'send_ipn_email_notification' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.send_ipn_email_notification(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_IPN_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'receiver_email' { return this.receiver_email }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'receiver_email' {
			this.receiver_email = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/class-wc-gateway-paypal-response.php', '4')
}

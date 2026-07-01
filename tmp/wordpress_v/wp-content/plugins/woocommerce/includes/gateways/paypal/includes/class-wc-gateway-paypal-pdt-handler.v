import rt

struct Class_WC_Gateway_Paypal_PDT_Handler {
	rt.PhpObjectBase
pub mut:
		identity_token rt.PhpVal = rt.new_null()
		receiver_email rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) construct(sandbox bool, identity_token string)  {
	rt.call_function('add_action', [rt.new_string('woocommerce_thankyou_paypal'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal_PDT_Handler', ['WC_Gateway_Paypal_Response'], &this) }, rt.ArrayItem{ key: none, val: 'check_response_for_order' }])])
	this.identity_token = rt.new_string(identity_token).dup()
	this.dispatch_set_prop('sandbox', rt.new_bool(sandbox))
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) set_receiver_email(receiver_email string)  {
	this.receiver_email = rt.new_string(receiver_email).dup()
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) validate_transaction(var_transaction rt.PhpVal) rt.PhpVal {
	mut var_transaction_mutated := var_transaction
	mut var_pdt := { 'body': { 'cmd': rt.new_string('_notify-synch'), 'tx': var_transaction_mutated, 'at': this.identity_token }, 'timeout': rt.new_int(60), 'httpversion': rt.new_string('1.1'), 'user-agent': 'WooCommerce/' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))).str() }
	mut var_response := rt.call_function('wp_safe_remote_post', [if rt.is_true(rt.get_property(rt.new_object('WC_Gateway_Paypal_PDT_Handler', ['WC_Gateway_Paypal_Response'], &this), 'sandbox')) { rt.new_string('https://www.sandbox.paypal.com/cgi-bin/webscr') } else { rt.new_string('https://www.paypal.com/cgi-bin/webscr') }, var_pdt.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_bool(false)
	}
	mut var_transaction_result := rt.call_function('array_map', [rt.new_string('wc_clean'), rt.call_function('array_map', [rt.new_string('urldecode'), rt.call_function('explode', [rt.new_string('\n'), var_response.array_get('body')])])])
	mut var_transaction_results := rt.new_array()
	{
		mut iter_1 := var_transaction_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			var_line = rt.call_function('explode', [rt.new_string('='), var_line.dup()])
			var_transaction_results.array_set(var_line.array_get(0), if var_line.array_isset(rt.new_int(1)) { var_line.array_get(1) } else { rt.new_string('') })
		}
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_transaction_results.array_get('charset'))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('iconv')])))) {
		{
			mut iter_1 := var_transaction_results.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				var_transaction_results.array_set(var_key, rt.call_function('iconv', [var_transaction_results.array_get('charset'), rt.new_string('utf-8'), var_value.dup()]))
			}
		}
	}
	return var_transaction_results.dup()
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) check_response()  {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_id := rt.call_function('apply_filters', [rt.new_string('woocommerce_thankyou_order_id'), rt.call_function('absint', [rt.get_property(var_wp, 'query_vars').array_get('order-received')])])
	this.check_response_for_order(var_order_id.dup())
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) check_response_for_order(var_wc_order_id rt.PhpVal)  {
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('tx')) {
		return rt.new_null()
	}
	mut var_wc_order := rt.call_function('wc_get_order', [var_wc_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wc_order, 'needs_payment', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_transaction := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('tx')])])
	mut var_transaction_result := this.validate_transaction(var_transaction.dup())
	if rt.is_true(var_transaction_result) {
		mut var_status := rt.new_string(rt.new_string(var_transaction_result.array_get('payment_status').to_string().to_lower()))
		mut var_amount := if var_transaction_result.array_isset(rt.new_string('mc_gross')) { var_transaction_result.array_get('mc_gross') } else { rt.new_int(0) }
		mut var_order := this.get_paypal_order(var_transaction_result.array_get('custom'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			return rt.new_null()
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Received PDT notification for order %1$d on endpoint for order %2$d.'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_wc_order_id.dup()]), rt.new_string('error'))
			return rt.new_null()
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Received PDT notification for another account: %1$s. Order ID: %2$d.'), rt.new_string('woocommerce')]), var_transaction_result.array_get('receiver_email'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})]), rt.new_string('error'))
			return rt.new_null()
		}
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PDT Transaction Status: ' + (rt.call_function('wc_print_r', [var_status.dup(), rt.new_bool(true)])).str()))
		rt.call_method(var_order, 'add_meta_data', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), var_status.dup()])
		rt.call_method(var_order, 'set_transaction_id', [var_transaction.dup()])
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.completed(), var_status)) {
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0, arg_1) }(rt.new_string('Payment error: Amounts do not match (amt ' + (var_amount).str() + ')'), rt.new_string('error'))
				this.payment_on_hold(var_order.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Validation error: PayPal amounts do not match (amt %s).'), rt.new_string('woocommerce')]), var_amount.dup()]))
			} else {
				if !(!rt.is_true(var_transaction_result.array_get('mc_fee'))) {
					rt.call_method(var_order, 'add_meta_data', [rt.new_string('PayPal Transaction Fee'), rt.call_function('wc_clean', [var_transaction_result.array_get('mc_fee')])])
				}
				if !(!rt.is_true(var_transaction_result.array_get('payment_type'))) {
					rt.call_method(var_order, 'add_meta_data', [rt.new_string('Payment type'), rt.call_function('wc_clean', [var_transaction_result.array_get('payment_type')])])
				}
				this.payment_complete(var_order.dup(), var_transaction.dup(), rt.call_function('__', [rt.new_string('PDT payment completed'), rt.new_string('woocommerce')]))
			}
		} else {
			if rt.is_true(rt.identical(rt.new_string('authorization'), var_transaction_result.array_get('pending_reason'))) {
				this.payment_on_hold(var_order.dup(), rt.call_function('__', [rt.new_string('Payment authorized. Change payment status to processing or complete to capture funds.'), rt.new_string('woocommerce')]))
			} else {
				this.payment_on_hold(var_order.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Payment pending (%s).'), rt.new_string('woocommerce')]), var_transaction_result.array_get('pending_reason')]))
			}
		}
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Received invalid response from PayPal PDT'))
	}
}

struct Class_WC_Gateway_Paypal_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_pdt_handler(sandbox bool, identity_token string) &Class_WC_Gateway_Paypal_PDT_Handler {
	mut obj := &Class_WC_Gateway_Paypal_PDT_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
		identity_token: rt.new_null()
		receiver_email: rt.new_null()
	}
	obj.construct(sandbox, identity_token)
	return obj
}

fn create_wc_gateway_paypal_response() &Class_WC_Gateway_Paypal_Response {
	mut obj := &Class_WC_Gateway_Paypal_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_receiver_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_receiver_email(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_transaction' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate_transaction(dispatch_arg_0)
		}
		'check_response' {
			this.check_response()
			return rt.new_null()
		}
		'check_response_for_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.check_response_for_order(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Gateway_Paypal_PDT_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'identity_token' { return this.identity_token }
		'receiver_email' { return this.receiver_email }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'identity_token' { this.identity_token = val; return true }
		'receiver_email' { this.receiver_email = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_includes_class_wc_gateway_paypal_pdt_handler_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/class-wc-gateway-paypal-response.php', '4')
}

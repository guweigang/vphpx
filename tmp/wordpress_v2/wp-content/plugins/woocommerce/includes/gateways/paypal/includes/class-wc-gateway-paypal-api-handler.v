import rt

struct Class_WC_Gateway_Paypal_API_Handler {
	rt.PhpObjectBase
}

fn init_static_wc_gateway_paypal_api_handler() {
	rt.init_static_prop('WC_Gateway_Paypal_API_Handler', 'api_username', rt.new_null())
	rt.init_static_prop('WC_Gateway_Paypal_API_Handler', 'api_password', rt.new_null())
	rt.init_static_prop('WC_Gateway_Paypal_API_Handler', 'api_signature', rt.new_null())
	rt.init_static_prop('WC_Gateway_Paypal_API_Handler', 'sandbox', rt.new_bool(false))
}

fn Class_WC_Gateway_Paypal_API_Handler.get_capture_request(var_order rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_request := {
		'VERSION':         rt.new_string('84.0')
		'SIGNATURE':       rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'api_signature')
		'USER':            rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'api_username')
		'PWD':             rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'api_password')
		'METHOD':          rt.new_string('DoCapture')
		'AUTHORIZATIONID': rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{})
		'AMT':             rt.call_function('number_format', [if var_amount.clone().is_null() {
			rt.call_method(var_order, 'get_total', []rt.PhpVal{})
		} else {
			var_amount
		}, rt.new_int(2), rt.new_string('.'), rt.new_string('')])
		'CURRENCYCODE':    rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
		'COMPLETETYPE':    rt.new_string('Complete')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_paypal_capture_request'),
		rt.create_array_from_native_map(var_request),
		var_order.clone(),
		var_amount.clone(),
	])
}

fn Class_WC_Gateway_Paypal_API_Handler.get_refund_request(var_order rt.PhpVal, var_amount rt.PhpVal, reason string) rt.PhpVal {
	mut var_request := {
		'VERSION':       rt.new_string('84.0')
		'SIGNATURE':     rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'api_signature')
		'USER':          rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'api_username')
		'PWD':           rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'api_password')
		'METHOD':        rt.new_string('RefundTransaction')
		'TRANSACTIONID': rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{})
		'NOTE':          rt.call_function('html_entity_decode', [
			rt.call_function('wc_trim_string', [rt.new_string(reason),
				rt.new_int(255)]),
			rt.get_constant('ENT_NOQUOTES'),
			rt.new_string('UTF-8'),
		])
		'REFUNDTYPE':    rt.new_string('Full')
	}
	if !(var_amount.clone().is_null()) {
		var_request['AMT'] = rt.call_function('number_format', [
			var_amount.clone(), rt.new_int(2), rt.new_string('.'),
			rt.new_string('')])
		var_request['CURRENCYCODE'] = rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
		var_request['REFUNDTYPE'] = rt.new_string('Partial')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_paypal_refund_request'),
		rt.create_array_from_native_map(var_request),
		var_order.clone(),
		var_amount.clone(),
		rt.new_string(reason),
	])
}

fn Class_WC_Gateway_Paypal_API_Handler.do_capture(var_order rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_response := rt.new_null()
	mut var_raw_response := rt.call_function('wp_safe_remote_post', [
		rt.new_string((if rt.is_true(rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'sandbox')) {
			'https://api-3t.sandbox.paypal.com/nvp'
		} else {
			'https://api-3t.paypal.com/nvp'
		}).str()),
		rt.create_array([rt.ArrayItem{ key: 'method', val: 'POST' },
			rt.ArrayItem{ key: 'body', val: Class_WC_Gateway_Paypal_API_Handler.get_capture_request(var_order.clone(),
				var_amount.clone()) }, rt.ArrayItem{ key: 'timeout', val: 70 },
			rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
				(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() },
			rt.ArrayItem{ key: 'httpversion', val: '1.1' }]),
	])
	mut iife_temp_0 := Class_WC_Gateway_Paypal{}
	mut iife_result_0 := iife_temp_0.log(rt.new_string('DoCapture Response: ' +
		(rt.call_function('wc_print_r', [var_raw_response.clone(), rt.new_bool(true)])).str()))
	if rt.is_true(rt.call_function('is_wp_error', [var_raw_response.clone()])) {
		return var_raw_response.clone()
	} else if !rt.is_true(var_raw_response.array_get(rt.new_string('body'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('paypal-api'),
			rt.new_string('Empty Response')))
	}
	rt.call_function('parse_str', [var_raw_response.array_get(rt.new_string('body')),
		var_response.clone()])
	return rt.new_object('stdClass', []string{}, rt.array_to_object(var_response))
}

fn Class_WC_Gateway_Paypal_API_Handler.refund_transaction(var_order rt.PhpVal, var_amount rt.PhpVal, reason string) rt.PhpVal {
	mut var_response := rt.new_null()
	mut var_raw_response := rt.call_function('wp_safe_remote_post', [
		rt.new_string((if rt.is_true(rt.get_static_prop('WC_Gateway_Paypal_API_Handler', 'sandbox')) {
			'https://api-3t.sandbox.paypal.com/nvp'
		} else {
			'https://api-3t.paypal.com/nvp'
		}).str()),
		rt.create_array([rt.ArrayItem{ key: 'method', val: 'POST' },
			rt.ArrayItem{ key: 'body', val: Class_WC_Gateway_Paypal_API_Handler.get_refund_request(var_order.clone(),
				var_amount.str(), rt.new_string(reason)) }, rt.ArrayItem{ key: 'timeout', val: 70 },
			rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
				(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() },
			rt.ArrayItem{ key: 'httpversion', val: '1.1' }]),
	])
	mut iife_temp_1 := Class_WC_Gateway_Paypal{}
	mut iife_result_1 := iife_temp_1.log(rt.new_string('Refund Response: ' +
		(rt.call_function('wc_print_r', [var_raw_response.clone(), rt.new_bool(true)])).str()))
	if rt.is_true(rt.call_function('is_wp_error', [var_raw_response.clone()])) {
		return var_raw_response.clone()
	} else if !rt.is_true(var_raw_response.array_get(rt.new_string('body'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('paypal-api'),
			rt.new_string('Empty Response')))
	}
	rt.call_function('parse_str', [var_raw_response.array_get(rt.new_string('body')),
		var_response.clone()])
	return rt.new_object('stdClass', []string{}, rt.array_to_object(var_response))
}

struct Class_WC_Gateway_Paypal_Refund {
	rt.PhpObjectBase
}

fn Class_WC_Gateway_Paypal_Refund.get_request(var_order rt.PhpVal, var_amount rt.PhpVal, reason string) rt.PhpVal {
	mut iife_temp_2 := Class_WC_Gateway_Paypal_Refund{}
	mut iife_result_2 := iife_temp_2.get_refund_request(var_order.clone(), var_amount.str(),
		rt.new_string(reason))
	return iife_result_2
}

fn Class_WC_Gateway_Paypal_Refund.refund_order(var_order rt.PhpVal, var_amount rt.PhpVal, reason string, sandbox bool) rt.PhpVal {
	if var_sandbox {
		rt.set_static_prop('WC_Gateway_Paypal_Refund', 'sandbox', rt.new_bool(sandbox))
	}
	mut iife_temp_3 := Class_WC_Gateway_Paypal_Refund{}
	mut iife_result_3 := iife_temp_3.refund_transaction(var_order.clone(), var_amount.str(),
		rt.new_string(reason))
	mut var_result := iife_result_3
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.clone()
	} else {
		return rt.cast_array(var_result)
	}
	return rt.new_null()
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_api_handler(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_API_Handler {
	mut obj := &Class_WC_Gateway_Paypal_API_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal_refund(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_Refund {
	mut obj := &Class_WC_Gateway_Paypal_Refund{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_API_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_capture_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Gateway_Paypal_API_Handler.get_capture_request(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_refund_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_WC_Gateway_Paypal_API_Handler.get_refund_request(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'do_capture' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Gateway_Paypal_API_Handler.do_capture(dispatch_arg_0, dispatch_arg_1)
		}
		'refund_transaction' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_WC_Gateway_Paypal_API_Handler.refund_transaction(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_API_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_API_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Gateway_Paypal_Refund) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_WC_Gateway_Paypal_Refund.get_request(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'refund_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_WC_Gateway_Paypal_Refund.refund_order(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_Refund) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_Refund) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

import rt

pub fn Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.known_card_brands() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'amex' }, rt.ArrayItem{ key: none, val: 'diners' }, rt.ArrayItem{ key: none, val: 'discover' }, rt.ArrayItem{ key: none, val: 'interac' }, rt.ArrayItem{ key: none, val: 'jcb' }, rt.ArrayItem{ key: none, val: 'mastercard' }, rt.ArrayItem{ key: none, val: 'visa' }])
}
struct Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_info(mut var_order Class_WC_Abstract_Order) rt.PhpVal {
	mut var_method := var_order.get_payment_method()
	mut var_info := rt.call_function('apply_filters', [rt.new_string('wc_order_payment_card_info'), rt.new_array(), var_order])
	if !(var_info.clone().is_array()) {
	var_info = rt.new_array()
	}
	if !rt.is_true(var_info) && rt.is_true(rt.identical(rt.new_string('woocommerce_payments'), var_method)) {
	var_info = Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_wcpay_card_info(mut var_order)
	}
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'payment_method', val: var_method }, rt.ArrayItem{ key: 'brand', val: '' }, rt.ArrayItem{ key: 'icon', val: '' }, rt.ArrayItem{ key: 'last4', val: '' }])
	var_info = rt.call_function('wp_parse_args', [var_info.clone(), var_defaults.clone()])
	if !rt.is_true(var_info.array_get(rt.new_string('icon'))) {
		var_info.array_set('icon', Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_icon(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?string](var_info.array_get(rt.new_string('brand')))))
	}
	return var_info.clone()
}

fn Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_icon(mut var_brand Class_Automattic_WooCommerce_Internal_Orders_?string) string {
	mut var_brand_mutated := var_brand
	var_brand_mutated = rt.new_string((var_brand_mutated).str().to_lower())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_brand_mutated, Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_PaymentInfo.known_card_brands(), rt.new_bool(true)]))))) {
	var_brand_mutated = rt.new_string('unknown')
	}
	return (rt.call_function('base64_encode', [rt.call_function('file_get_contents', [rt.new_string(@DIR + "/CardIcons/${var_brand.to_string()}.svg")])])).str()
}

fn Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_wcpay_card_info(mut var_order Class_WC_Abstract_Order) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_payments'), var_order.get_payment_method())))) {
		return rt.new_array()
	}
	mut var_cache_meta_key := rt.new_string('_wcpay_raw_payment_method_details')
	mut var_payment_details := rt.new_null()
	mut var_stored_payment_details := var_order.get_meta(var_cache_meta_key.clone())
	if var_stored_payment_details.clone().is_string() && var_stored_payment_details.clone().to_string().len > 0 {
	var_payment_details = rt.call_function('json_decode', [var_stored_payment_details.clone(), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_details)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_Orders_WC_Payments.class()]))))) {
			return rt.new_array()
		}
		mut var_payment_method_id := var_order.get_meta(rt.new_string('_payment_method_id'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_method_id)))) {
			return rt.new_array()
		}
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Orders_WC_Payments{}
		mut iife_result_0 := iife_temp_0.get_payments_api_client()
		var_payment_details = rt.call_method(iife_result_0, 'get_payment_method', [var_payment_method_id.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Orders_Throwable') {
			mut var_ex := var_e_1.clone()
			mut var_order_id := var_order.get_id()
			mut var_message := rt.call_method(var_ex, 'getMessage', []rt.PhpVal{})
			mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
			mut iife_result_1 := iife_temp_1.class_name_without_namespace(Class_Automattic_WooCommerce_Internal_Orders_static.class())
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('%s - retrieving info for payment method %s for order %s: %s'), iife_result_1, var_payment_method_id.clone(), var_order_id.clone(), var_message.clone()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'payment-info' }])])
			return rt.new_array()
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		var_order.update_meta_data(var_cache_meta_key.clone(), rt.call_function('wp_json_encode', [var_payment_details.clone()]))
		var_order.save_meta_data()
	}
	mut var_card_info := rt.new_array()
	if var_payment_details.array_isset(rt.new_string('type')) && var_payment_details.array_isset(var_payment_details.array_get(rt.new_string('type'))) {
		mut var_details := var_payment_details.array_get(var_payment_details.array_get(rt.new_string('type')))
		mut switch_val_1 := var_payment_details.array_get(rt.new_string('type'))
		if true {
			var_card_info.array_set('brand', if !(var_details.array_get(rt.new_string('brand'))).is_null() { var_details.array_get(rt.new_string('brand')) } else { rt.new_string('') })
			var_card_info.array_set('last4', if !(var_details.array_get(rt.new_string('last4'))).is_null() { var_details.array_get(rt.new_string('last4')) } else { rt.new_string('') })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('card_present'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('interac_present'))) {
			var_card_info.array_set('brand', if !(var_details.array_get(rt.new_string('brand'))).is_null() { var_details.array_get(rt.new_string('brand')) } else { rt.new_string('') })
			var_card_info.array_set('last4', if !(var_details.array_get(rt.new_string('last4'))).is_null() { var_details.array_get(rt.new_string('last4')) } else { rt.new_string('') })
			var_card_info.array_set('account_type', if !(var_details.array_get(rt.new_string('receipt')).array_get(rt.new_string('account_type'))).is_null() { var_details.array_get(rt.new_string('receipt')).array_get(rt.new_string('account_type')) } else { rt.new_string('') })
			var_card_info.array_set('aid', if !(var_details.array_get(rt.new_string('receipt')).array_get(rt.new_string('dedicated_file_name'))).is_null() { var_details.array_get(rt.new_string('receipt')).array_get(rt.new_string('dedicated_file_name')) } else { rt.new_string('') })
			var_card_info.array_set('app_name', if !(var_details.array_get(rt.new_string('receipt')).array_get(rt.new_string('application_preferred_name'))).is_null() { var_details.array_get(rt.new_string('receipt')).array_get(rt.new_string('application_preferred_name')) } else { rt.new_string('') })
		}
	}
	return rt.call_function('array_map', [rt.new_string('sanitize_text_field'), var_card_info.clone()])
}

struct Class_Automattic_WooCommerce_Internal_Orders_WC_Payments {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_paymentinfo(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_wc_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_WC_Payments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_WC_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_card_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_info(mut dispatch_arg_0)
		}
		'get_card_icon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_icon(mut dispatch_arg_0))
		}
		'get_wcpay_card_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_wcpay_card_info(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Orders_WC_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_WC_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_WC_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

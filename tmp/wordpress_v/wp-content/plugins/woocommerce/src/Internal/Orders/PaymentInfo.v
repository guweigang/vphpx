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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_info.dup().is_array()))))) {
		var_info = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_info) && rt.is_true(rt.identical(rt.new_string('woocommerce_payments'), var_method)))) {
		var_info = Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_wcpay_card_info(mut var_order)
	}
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'payment_method', val: var_method }, rt.ArrayItem{ key: 'brand', val: '' }, rt.ArrayItem{ key: 'icon', val: '' }, rt.ArrayItem{ key: 'last4', val: '' }])
	var_info = rt.call_function('wp_parse_args', [var_info.dup(), var_defaults.dup()])
	if !rt.is_true(var_info.array_get('icon')) {
		var_info.array_set('icon', Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_icon(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?string](var_info.array_get('brand'))))
	}
	return var_info.dup()
}

fn Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_card_icon(mut var_brand Class_Automattic_WooCommerce_Internal_Orders_?string) string {
	mut var_brand_mutated := var_brand
	var_brand_mutated = rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_lower()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_brand_mutated.dup(), Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_PaymentInfo.known_card_brands(), rt.new_bool(true)]))))) {
		var_brand_mutated = rt.new_string(rt.new_string('unknown'))
	}
	return (rt.call_function('base64_encode', [rt.call_function('file_get_contents', [@DIR + "/CardIcons/${var_brand.to_string()}.svg"])])).str()
}

fn Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo.get_wcpay_card_info(mut var_order Class_WC_Abstract_Order) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_array()
	}
	mut var_cache_meta_key := rt.new_string(rt.new_string('_wcpay_raw_payment_method_details'))
	mut var_payment_details := rt.new_null()
	mut var_stored_payment_details := var_order.get_meta(var_cache_meta_key.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_stored_payment_details.dup().is_string())) && var_stored_payment_details.dup().to_string().len > 0)) {
		var_payment_details = rt.call_function('json_decode', [var_stored_payment_details.dup(), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_details)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_Orders_WC_Payments.class()]))))) {
			return rt.new_array()
		}
		mut var_payment_method_id := var_order.get_meta(rt.new_string('_payment_method_id'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_method_id)))) {
			return rt.new_array()
		}
		var_payment_details = rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Orders_WC_Payments{}; return temp.get_payments_api_client() }(), 'get_payment_method', [var_payment_method_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Orders_Throwable') {
			mut var_ex := var_e_1.dup()
			mut var_order_id := var_order.get_id()
			mut var_message := rt.call_method(var_ex, 'getMessage', []rt.PhpVal{})
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('%s - retrieving info for payment method %s for order %s: %s'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.class_name_without_namespace(arg_0) }(Class_Automattic_WooCommerce_Internal_Orders_static.class()), var_payment_method_id.dup(), var_order_id.dup(), var_message.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'payment-info' }])])
			return rt.new_array()
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		var_order.update_meta_data(var_cache_meta_key.dup(), rt.call_function('wp_json_encode', [var_payment_details.dup()]))
		var_order.save_meta_data()
	}
	mut var_card_info := rt.new_array()
	if var_payment_details.array_isset(rt.new_string('type')) && var_payment_details.array_isset(var_payment_details.array_get('type')) {
		mut var_details := var_payment_details.array_get(var_payment_details.array_get('type'))
		mut switch_val_1 := var_payment_details.array_get('type')
		if true {
			var_card_info.array_set('brand', if !(var_details.array_get('brand')).is_null() { var_details.array_get('brand') } else { rt.new_string('') })
			var_card_info.array_set('last4', if !(var_details.array_get('last4')).is_null() { var_details.array_get('last4') } else { rt.new_string('') })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('card_present'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('interac_present'))) {
			var_card_info.array_set('brand', if !(var_details.array_get('brand')).is_null() { var_details.array_get('brand') } else { rt.new_string('') })
			var_card_info.array_set('last4', if !(var_details.array_get('last4')).is_null() { var_details.array_get('last4') } else { rt.new_string('') })
			var_card_info.array_set('account_type', if !(var_details.array_get('receipt').array_get('account_type')).is_null() { var_details.array_get('receipt').array_get('account_type') } else { rt.new_string('') })
			var_card_info.array_set('aid', if !(var_details.array_get('receipt').array_get('dedicated_file_name')).is_null() { var_details.array_get('receipt').array_get('dedicated_file_name') } else { rt.new_string('') })
			var_card_info.array_set('app_name', if !(var_details.array_get('receipt').array_get('application_preferred_name')).is_null() { var_details.array_get('receipt').array_get('application_preferred_name') } else { rt.new_string('') })
		}
	}
	return rt.call_function('array_map', [rt.new_string('sanitize_text_field'), var_card_info.dup()])
}

struct Class_Automattic_WooCommerce_Internal_Orders_WC_Payments {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_paymentinfo() &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_wc_payments() &Class_Automattic_WooCommerce_Internal_Orders_WC_Payments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_WC_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_orders_paymentinfo_php() {
	// unsupported statement: Stmt_Declare
}

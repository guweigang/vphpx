import rt

pub fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.open_order_interval_days() i64 {
	return 30
}
struct Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_mobile_message(mut var_order Class_WC_Order, mut var_blog_id Class_Automattic_WooCommerce_Internal_Orders_?int, mut var_now Class_DateTime, domain string) string {
	mut var_last_mobile_used := Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_closer_mobile_usage_date()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_used_app_in_last_month := rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last_mobile_used)))) && rt.is_true(rt.less_equal(rt.get_property(rt.call_method(var_last_mobile_used, 'diff', [var_now]), 'days'), Class_Automattic_WooCommerce_Internal_Orders_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.open_order_interval_days())))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_has_jetpack := rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_blog_id)))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Orders_IppFunctions{}
	mut iife_result_0 := iife_temp_0.is_store_in_person_payment_eligible()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Orders_IppFunctions{}
	mut iife_result_1 := iife_temp_1.is_order_in_person_payment_eligible(rt.new_object('WC_Order', []string{}, var_order))
	if rt.is_true(iife_result_0) && rt.is_true(iife_result_1) {
		return (Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.accept_payment_message(mut var_blog_id, rt.new_string(domain))).str()
	} else {
		if rt.is_true(var_used_app_in_last_month) && rt.is_true(var_has_jetpack) {
			return (Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.manage_order_message(var_blog_id, (var_order.get_id()).to_i64(), domain)).str()
		} else {
			return (Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.no_app_message(mut var_blog_id, domain)).str()
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return (rt.new_null()).str()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return ''
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_closer_mobile_usage_date() rt.PhpVal {
	mut iife_temp_2 := Class_WC_Tracker{}
	mut iife_result_2 := iife_temp_2.get_woocommerce_mobile_usage()
	mut var_mobile_usage := iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(var_mobile_usage)))) {
		return rt.new_null()
	}
	mut var_last_ios_used := Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_last_used_or_null('ios', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](var_mobile_usage))
	mut var_last_android_used := Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_last_used_or_null('android', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](var_mobile_usage))
	return rt.call_function('max', [var_last_android_used.clone(), var_last_ios_used.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_last_used_or_null(platform string, mut var_mobile_usage Class_Automattic_WooCommerce_Internal_Orders_array) rt.PhpVal {
	mut var_mobile_usage_mutated := var_mobile_usage
	if rt.is_true(rt.new_bool(var_mobile_usage_mutated.array_isset(rt.new_string(platform)))) {
		return create_datetime(var_mobile_usage_mutated.array_get(rt.new_string(platform)).array_get(rt.new_string('last_used')))
	} else {
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.accept_payment_message(mut var_blog_id Class_Automattic_WooCommerce_Internal_Orders_?int, var_domain rt.PhpVal) string {
	mut var_deep_link_url := rt.call_function('add_query_arg', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: rt.call_function('absint', [var_blog_id]) }]), Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_utm_parameters('deeplinks_payments', mut var_blog_id, (var_domain).str())]), rt.new_string('https://woocommerce.com/mobile/payments')])
	return (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$sCollect payments easily%2$s from your customers anywhere with our mobile app.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_deep_link_url.clone()])).str() + '">'), rt.new_string('</a>')])).str()
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.manage_order_message(blog_id i64, order_id i64, domain string) string {
	mut var_deep_link_url := rt.call_function('add_query_arg', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: rt.call_function('absint', [rt.new_int(blog_id)]) }, rt.ArrayItem{ key: 'order_id', val: rt.call_function('absint', [rt.new_int(order_id)]) }]), Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_utm_parameters('deeplinks_orders_details', mut blog_id, domain)]), rt.new_string('https://woocommerce.com/mobile/orders/details')])
	return (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$sManage the order%2$s with the app.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_deep_link_url.clone()])).str() + '">'), rt.new_string('</a>')])).str()
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.no_app_message(mut var_blog_id Class_Automattic_WooCommerce_Internal_Orders_?int, domain string) string {
	mut var_deep_link_url := rt.call_function('add_query_arg', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: rt.call_function('absint', [var_blog_id]) }]), Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_utm_parameters('deeplinks_promote_app', mut var_blog_id, domain)]), rt.new_string('https://woocommerce.com/mobile')])
	return (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Process your orders on the go. %1$sGet the app%2$s.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_deep_link_url.clone()])).str() + '">'), rt.new_string('</a>')])).str()
}

fn Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_utm_parameters(campaign string, mut var_blog_id Class_Automattic_WooCommerce_Internal_Orders_?int, domain string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'utm_campaign', val: campaign }, rt.ArrayItem{ key: 'utm_medium', val: 'email' }, rt.ArrayItem{ key: 'utm_source', val: domain }, rt.ArrayItem{ key: 'utm_term', val: rt.call_function('absint', [var_blog_id]) }])
}

struct Class_Automattic_WooCommerce_Internal_Orders_IppFunctions {
	rt.PhpObjectBase
}

struct Class_WC_Tracker {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_mobilemessaginghandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_ippfunctions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_IppFunctions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_IppFunctions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracker(_args ...rt.PhpVal) &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_mobile_message' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_mobile_message(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3))
		}
		'get_closer_mobile_usage_date' {
			return Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_closer_mobile_usage_date()
		}
		'get_last_used_or_null' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.get_last_used_or_null(dispatch_arg_0, mut dispatch_arg_1)
		}
		'accept_payment_message' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.accept_payment_message(mut dispatch_arg_0, dispatch_arg_1))
		}
		'manage_order_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.manage_order_message(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'no_app_message' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.no_app_message(mut dispatch_arg_0, dispatch_arg_1))
		}
		'prepare_utm_parameters' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler.prepare_utm_parameters(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_MobileMessagingHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Orders_IppFunctions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_IppFunctions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_IppFunctions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

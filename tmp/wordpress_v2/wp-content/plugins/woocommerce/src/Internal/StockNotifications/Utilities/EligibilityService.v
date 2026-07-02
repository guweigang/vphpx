import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService.spam_threshold() i64 {
	return 60 * 60 * 24
}
struct Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService {
	rt.PhpObjectBase
pub mut:
		stock_management_helper rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) init(mut var_stock_management_helper Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper) {
	this.stock_management_helper = var_stock_management_helper
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) is_product_eligible(mut var_product Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_?WC_Product) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Utilities_?WC_Product', []string{}, var_product), 'WC_Product')))))) {
		return false
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_0 := iife_temp_0.get_supported_product_types()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product.is_type(iife_result_0))))) {
		return false
	}
	if rt.is_true(rt.call_function('in_array', [var_product.get_status(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.trash() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.future() }]), rt.new_bool(true)])) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_stock_notifications_product_is_valid'), rt.new_bool(true), var_product])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) product_allows_signups(mut var_product Class_WC_Product) bool {
	if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variation())) {
		mut var_parent_product := rt.call_function('wc_get_product', [var_product.get_parent_id()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parent_product, 'WC_Product')))))) {
			return false
		}
		return this.product_allows_signups(mut rt.cast_object_ptr[Class_WC_Product](var_parent_product))
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_1 := iife_temp_1.get_product_signups_meta_key()
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), var_product.get_meta(iife_result_1))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) is_stock_status_eligible(stock_status string) bool {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_2 := iife_temp_2.get_eligible_stock_statuses()
	return (rt.call_function('in_array', [rt.new_string(stock_status), iife_result_2, rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) has_active_notifications(mut var_product Class_WC_Product) bool {
	mut var_lookup_ids := this.get_target_product_ids(mut var_product)
	if !rt.is_true(var_lookup_ids) {
		return false
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
	mut iife_result_3 := iife_temp_3.product_has_active_notifications(var_lookup_ids.clone())
	return (iife_result_3).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) get_target_product_ids(mut var_product Class_WC_Product) rt.PhpVal {
	mut var_lookup_ids := rt.create_array([rt.ArrayItem{ key: none, val: var_product.get_id() }])
	if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variable())) {
	mut var_children_ids := rt.call_method(this.stock_management_helper, 'get_managed_variations', [var_product])
	var_lookup_ids = rt.call_function('array_merge', [var_lookup_ids.clone(), var_children_ids.clone()])
	}
	return var_lookup_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) should_skip_notification(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification, mut var_product Class_WC_Product) bool {
	mut var_is_throttled := rt.new_bool(this.is_notification_throttled(mut var_notification))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_4 := iife_temp_4.get_supported_product_statuses()
	mut var_is_product_published := rt.call_function('in_array', [var_product.get_status(), iife_result_4, rt.new_bool(true)])
	mut var_should_skip := rt.new_bool(rt.is_true(var_is_throttled) || rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_published)))))
	if rt.is_true(var_should_skip) {
		mut var_user_id := var_notification.get_user_id()
		if rt.is_true(var_user_id) {
			mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.clone()])
			if rt.is_true(var_user) && rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('manage_woocommerce')])) || rt.is_true(rt.call_function('user_can', [var_user.clone(), rt.new_string('manage_options')])) {
			var_should_skip = rt.new_bool(false)
			}
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_stock_notification_should_skip_sending'), var_should_skip.clone(), var_notification.get_id()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) is_notification_throttled(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) bool {
	mut var_threshold := rt.new_int((rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_stock_notification_throttle_threshold'), Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService.spam_threshold()])).to_i64())
	if rt.is_true(rt.less_equal(var_threshold, rt.new_int(0))) {
		return false
	}
	mut var_last_notified := var_notification.get_date_notified()
	mut var_is_throttled := rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_last_notified, 'Automattic_WooCommerce_Internal_StockNotifications_Utilities_WC_DateTime'))) && rt.is_true(rt.greater(rt.call_method(var_last_notified, 'getTimestamp', []rt.PhpVal{}), rt.sub(rt.call_function('time', []rt.PhpVal{}), var_threshold))))
	return (var_is_throttled).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_utilities_eligibilityservice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService{
		PhpObjectBase: rt.PhpObjectBase{}
		stock_management_helper: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_config(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_notificationquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_StockManagementHelper](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_product_eligible' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_?WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_product_eligible(mut dispatch_arg_0))
		}
		'product_allows_signups' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.product_allows_signups(mut dispatch_arg_0))
		}
		'is_stock_status_eligible' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_stock_status_eligible(dispatch_arg_0))
		}
		'has_active_notifications' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.has_active_notifications(mut dispatch_arg_0))
		}
		'get_target_product_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_target_product_ids(mut dispatch_arg_0)
		}
		'should_skip_notification' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.should_skip_notification(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'is_notification_throttled' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_notification_throttled(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stock_management_helper' { return this.stock_management_helper }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stock_management_helper' { this.stock_management_helper = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

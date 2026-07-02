import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.daily_task_hook() string {
	return 'customer_stock_notifications_daily'
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) construct() {
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.daily_task_hook(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'do_wc_customer_stock_notifications_daily' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_customer_stock_notifications_unverified_deletions_days_threshold'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'schedule_or_unschedule_daily_task' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('add_option_woocommerce_customer_stock_notifications_unverified_deletions_days_threshold'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'schedule_or_unschedule_daily_task' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('register_deactivation_hook', [rt.get_constant('WC_PLUGIN_FILE'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clear_daily_task' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) on_woo_install_or_update() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_0 := iife_temp_0.get_unverified_deletion_days_threshold()
	this.schedule_or_unschedule_daily_task(rt.new_null(), iife_result_0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) schedule_or_unschedule_daily_task(var_unused rt.PhpVal, var_new_option_value rt.PhpVal) {
	if !(var_new_option_value.clone().is_long() || var_new_option_value.clone().is_double())
		|| !rt.is_true(var_new_option_value) {
		this.clear_daily_task()
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.daily_task_hook(),
	])))))
	{
		rt.call_function('wp_schedule_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)),
			rt.new_string('daily'),
			Class_Automattic_WooCommerce_Internal_StockNotifications_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.daily_task_hook(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) clear_daily_task() {
	rt.call_function('wp_clear_scheduled_hook', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController.daily_task_hook(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) do_wc_customer_stock_notifications_daily() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_1 := iife_temp_1.get_unverified_deletion_days_threshold()
	mut var_time_threshold := iife_result_1
	if rt.is_true(rt.identical(rt.new_int(0), var_time_threshold)) {
		return
	}
	mut var_overdue_threshold := rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(var_time_threshold,
		rt.get_constant('DAY_IN_SECONDS')))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
	mut iife_result_2 := iife_temp_2.get_notifications(rt.create_array([
		rt.ArrayItem{
			key: 'status'
			val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()
		},
		rt.ArrayItem{ key: 'end_date', val: rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			var_overdue_threshold.clone(),
		]) },
	]))
	mut var_overdue_notifications := iife_result_2
	mut iter_1 := var_overdue_notifications.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_notification_id := item_1.val
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
		mut iife_result_3 := iife_temp_3.get_notification(var_notification_id.clone())
		mut var_notification := iife_result_3
		rt.call_method(var_notification, 'delete', []rt.PhpVal{})
	}
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_dataretentioncontroller() &Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
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

fn create_automattic_woocommerce_internal_stocknotifications_factory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'on_woo_install_or_update' {
			this.on_woo_install_or_update()
			return rt.new_null()
		}
		'schedule_or_unschedule_daily_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.schedule_or_unschedule_daily_task(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'clear_daily_task' {
			this.clear_daily_task()
			return rt.new_null()
		}
		'do_wc_customer_stock_notifications_daily' {
			this.do_wc_customer_stock_notifications_daily()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_DataRetentionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor.batch_size() i64 {
	return 50
}
struct Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor {
	rt.PhpObjectBase
pub mut:
		email_manager rt.PhpVal = rt.new_null()
		logger rt.PhpVal = rt.new_null()
		eligibility_service rt.PhpVal = rt.new_null()
		job_manager rt.PhpVal = rt.new_null()
		cycle_state_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService, mut var_job_manager Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager, mut var_cycle_state_service Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService, mut var_email_manager Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager) {
	this.eligibility_service = var_eligibility_service
	this.job_manager = var_job_manager
	this.cycle_state_service = var_cycle_state_service
	this.email_manager = var_email_manager
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) construct() {
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_batch' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) get_batch_size() i64 {
	return rt.new_int((rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_stock_notifications_batch_size'), Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor.batch_size()])).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) parse_args(var_product_id rt.PhpVal) i64 {
	mut var_product_id_mutated := var_product_id
	if !rt.is_true(var_product_id_mutated) || !(var_product_id_mutated.clone().is_long() || var_product_id_mutated.clone().is_double()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception', []string{}, create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.new_string('Invalid arguments.'))))
	}
	var_product_id_mutated = rt.new_int((var_product_id_mutated).to_i64())
	if rt.is_true(rt.less_equal(var_product_id_mutated, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception', []string{}, create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.new_string('Product ID is required.'))))
	}
	return (var_product_id_mutated).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) parse_product(product_id i64) rt.PhpVal {
	mut product_id_mutated := product_id
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(product_id_mutated).clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception', []string{}, create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.call_function('sprintf', [rt.new_string('Product %d not found.'), rt.call_function('absint', [rt.new_int(product_id_mutated).clone()])]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service, 'is_product_eligible', [var_product.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception', []string{}, create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.call_function('sprintf', [rt.new_string('Product %d is not eligible for notifications.'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service, 'is_stock_status_eligible', [rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{})]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception', []string{}, create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(rt.call_function('sprintf', [rt.new_string('Product %d stock status is not eligible for notifications (i.e. not in stock).'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))))
	}
	return var_product.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) process_batch(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	var_product_id_mutated = rt.new_int(this.parse_args(var_product_id_mutated.clone()))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_cycle_state := rt.call_method(this.cycle_state_service, 'get_or_initialize_cycle_state', [var_product_id_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_product := this.parse_product((var_product_id_mutated).to_i64())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Throwable') {
		mut var_e := var_e_1.clone()
		var_product_id_mutated = rt.new_int(if !(rt.new_int((var_product_id_mutated).to_i64())).is_null() { rt.new_int((var_product_id_mutated).to_i64()) } else { rt.new_int(0) })
		rt.call_method(this.logger, 'error', [rt.call_function('sprintf', [rt.new_string('Background process for product %s terminated. Reason: %s'), var_product_id_mutated.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' }, rt.ArrayItem{ key: 'product_id', val: var_product_id_mutated }, rt.ArrayItem{ key: 'exception', val: rt.call_function('get_class', [var_e.clone()]) }])])
		if !(var_cycle_state).is_null() {
			rt.call_method(this.cycle_state_service, 'complete_cycle', [var_product_id_mutated.clone(), var_cycle_state.clone()])
		}
		return
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	var_cycle_state.array_set('product_ids', rt.call_method(this.eligibility_service, 'get_target_product_ids', [var_product.clone()]))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery{}
	mut iife_result_0 := iife_temp_0.get_notifications(rt.create_array([rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active() }, rt.ArrayItem{ key: 'product_id', val: var_cycle_state.array_get(rt.new_string('product_ids')) }, rt.ArrayItem{ key: 'last_attempt_limit', val: rt.new_int((var_cycle_state.array_get(rt.new_string('cycle_start_time'))).to_i64()) }, rt.ArrayItem{ key: 'return', val: 'ids' }, rt.ArrayItem{ key: 'limit', val: this.get_batch_size() }, rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'order', val: 'ASC' }]))
	mut var_notifications := iife_result_0
	if !rt.is_true(var_notifications) {
		rt.call_method(this.cycle_state_service, 'complete_cycle', [var_product_id_mutated.clone(), var_cycle_state.clone()])
		return
	}
	mut iter_1 := var_notifications.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_notification_id := item_1.val
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
		mut iife_result_1 := iife_temp_1.get_notification(var_notification_id.clone())
		mut var_notification := iife_result_1
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_notification, 'Automattic_WooCommerce_Internal_StockNotifications_Notification')))))) {
			rt.call_method(this.logger, 'error', [rt.call_function('sprintf', [rt.new_string('Failed to get notification ID: %d'), var_notification_id.clone()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' }])])
			continue
		}
		rt.call_method(var_notification, 'set_date_last_attempt', [rt.call_function('time', []rt.PhpVal{})])
		rt.pre_inc(var_cycle_state.array_get(rt.new_string('total_count')))
		if rt.is_true(rt.call_method(this.eligibility_service, 'should_skip_notification', [var_notification.clone(), var_product.clone()])) {
			rt.pre_inc(var_cycle_state.array_get(rt.new_string('skipped_count')))
			rt.call_method(var_notification, 'save', []rt.PhpVal{})
			continue
		}
		mut var_is_sent := rt.new_bool(true)
		rt.call_method(this.email_manager, 'send_stock_notification_email', [var_notification.clone()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Throwable') {
			var_e = var_e_2.clone()
			var_is_sent = rt.new_bool(false)
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		if rt.is_true(var_is_sent) {
			rt.call_method(var_notification, 'set_date_notified', [rt.call_function('time', []rt.PhpVal{})])
			rt.call_method(var_notification, 'set_status', [Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent()])
			rt.pre_inc(var_cycle_state.array_get(rt.new_string('sent_count')))
		} else {
			rt.call_method(var_notification, 'set_status', [Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled()])
			rt.call_method(var_notification, 'set_cancellation_source', [Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.system()])
			rt.pre_inc(var_cycle_state.array_get(rt.new_string('failed_count')))
		}
		rt.call_method(var_notification, 'save', []rt.PhpVal{})
	}
	if var_notifications.clone().array_count() == this.get_batch_size() {
		rt.call_method(this.cycle_state_service, 'save_cycle_state', [var_product_id_mutated.clone(), var_cycle_state.clone()])
		rt.call_method(this.job_manager, 'schedule_next_batch_for_product', [var_product_id_mutated.clone()])
		return
	}
	rt.call_method(this.cycle_state_service, 'complete_cycle', [var_product_id_mutated.clone(), var_cycle_state.clone()])
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_NotificationQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_asynctasks_notificationsprocessor() &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		email_manager: rt.new_null()
		logger: rt.new_null()
		eligibility_service: rt.new_null()
		job_manager: rt.new_null()
		cycle_state_service: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_asynctasks_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception{
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

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_CycleStateService](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_EmailManager](if args.len > 3 { args[3] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_batch_size' {
			return rt.new_int(this.get_batch_size())
		}
		'parse_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.parse_args(dispatch_arg_0))
		}
		'parse_product' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.parse_product(dispatch_arg_0)
		}
		'process_batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.process_batch(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_manager' { return this.email_manager }
		'logger' { return this.logger }
		'eligibility_service' { return this.eligibility_service }
		'job_manager' { return this.job_manager }
		'cycle_state_service' { return this.cycle_state_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_NotificationsProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_manager' { this.email_manager = val; return true }
		'logger' { this.logger = val; return true }
		'eligibility_service' { this.eligibility_service = val; return true }
		'job_manager' { this.job_manager = val; return true }
		'cycle_state_service' { this.cycle_state_service = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

import rt

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications() string {
	return 'wc_send_stock_notifications_batch'
}

pub fn Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_group() string {
	return 'wc-stock-notifications'
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager {
	rt.PhpObjectBase
pub mut:
	logger rt.PhpVal = rt.new_null()
	queue  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) construct() {
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	this.queue = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) schedule_initial_job_for_product(product_id i64) bool {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'product_id', val: product_id }])
	if rt.is_true(rt.call_method(this.queue, 'get_next', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications(),
		var_args.clone(),
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_group(),
	]))
	{
		return false
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_delay := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_first_batch_delay'),
		rt.get_constant('MINUTE_IN_SECONDS'),
		rt.new_int(product_id),
	])).to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_delay = rt.call_function('max', [rt.new_int(0), var_delay.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_action_id := rt.call_method(this.queue, 'schedule_single', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), var_delay),
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications(),
		var_args.clone(),
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_group(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action_id)))) {
		return false
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(this.logger, 'info', [
		rt.call_function('sprintf', [
			rt.new_string('Scheduled stock notification for product %d'),
			rt.new_int(product_id),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' },
		]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return true
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_method(this.logger, 'error', [
			rt.call_function('sprintf', [
				rt.new_string('Failed to schedule stock notification for product %d: %s'),
				rt.new_int(product_id),
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' },
			]),
		])
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) schedule_next_batch_for_product(product_id i64) bool {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'product_id', val: product_id }])
	if rt.is_true(rt.call_method(this.queue, 'get_next', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications(),
		var_args.clone(),
		Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_group(),
	]))
	{
		return false
	}
	mut var_delay := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_next_batch_delay'),
		rt.new_int(0),
		rt.new_int(product_id),
	])).to_i64())
	var_delay = rt.call_function('max', [rt.new_int(0), var_delay.clone()])
	if rt.is_true(rt.identical(rt.new_int(0), var_delay)) {
		mut var_action_id := rt.call_method(this.queue, 'add', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications(),
			var_args.clone(),
			Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_group(),
		])
	} else {
		var_action_id = rt.call_method(this.queue, 'schedule_single', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), var_delay),
			Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_send_stock_notifications(),
			var_args.clone(),
			Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager.as_job_group(),
		])
	}
	return !(!rt.is_true(var_action_id))
}

fn create_automattic_woocommerce_internal_stocknotifications_asynctasks_jobmanager() &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager{
		PhpObjectBase: rt.PhpObjectBase{}
		logger:        rt.new_null()
		queue:         rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'schedule_initial_job_for_product' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.schedule_initial_job_for_product(dispatch_arg_0))
		}
		'schedule_next_batch_for_product' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.schedule_next_batch_for_product(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		'queue' { return this.queue }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' {
			this.logger = val
			return true
		}
		'queue' {
			this.queue = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

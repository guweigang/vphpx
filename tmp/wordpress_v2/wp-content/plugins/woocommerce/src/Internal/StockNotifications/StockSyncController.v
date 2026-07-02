import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController {
	rt.PhpObjectBase
pub mut:
	queue               rt.PhpVal = rt.new_array()
	eligibility_service rt.PhpVal = rt.new_null()
	job_manager         rt.PhpVal = rt.new_null()
	logger              rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService, mut var_job_manager Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager) {
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	this.eligibility_service = var_eligibility_service
	this.job_manager = var_job_manager
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) construct() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_set_stock_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockSyncController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_product_stock_status_change' },
		]),
		rt.new_int(100),
		rt.new_int(3),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_variation_set_stock_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockSyncController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_product_stock_status_change' },
		]),
		rt.new_int(100),
		rt.new_int(3),
	])
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockSyncController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'process_queue' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_StockSyncController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_admin_notice' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) handle_product_stock_status_change(var_product_id rt.PhpVal, var_stock_status rt.PhpVal, var_product rt.PhpVal) {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'is_stock_status_eligible', [var_stock_status.clone()])))))
	{
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.identical(rt.new_null(), var_product_mutated)) {
		var_product_mutated = rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product_mutated.clone(), rt.new_string('WC_Product')])))))
	{
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'is_product_eligible', [var_product_mutated.clone()])))))
	{
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.eligibility_service,
		'has_active_notifications', [var_product_mutated.clone()])))))
	{
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_target_product_ids := rt.call_method(this.eligibility_service,
		'get_target_product_ids', [var_product_mutated.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iter_1 := var_target_product_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_target_product_id := item_1.val
		this.queue.array_set(var_target_product_id, true)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.store_admin_notice(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_Throwable') {
		mut var_e := var_e_1.clone()
		rt.call_method(this.logger, 'error', [
			rt.call_function('sprintf', [
				rt.new_string('StockSyncController: Failed to process product %d: %s'),
				var_product_id.clone(),
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc-customer-stock-notifications' },
			]),
		])
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
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) process_queue() {
	if !rt.is_true(this.queue) || !(this.queue.is_array()) {
		this.queue = rt.new_array()
		return
	}
	mut var_product_ids := rt.call_function('array_filter', [
		rt.func_array_keys(this.queue),
	])
	if !rt.is_true(var_product_ids) {
		return
	}
	mut iter_2 := var_product_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_id := item_2.val
		rt.call_method(this.job_manager, 'schedule_initial_job_for_product', [
			var_product_id.clone()])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_customer_stock_notifications_product_sync'),
		var_product_ids.clone(),
	])
	this.queue = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) store_admin_notice(var_product_id rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_admin_notice')]))))) {
		return
	}
	mut var_notice_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Back-in-stock notifications for this product are now being processed. Subscribed customers will receive these emails over the next few minutes. You can monitor or manage individual subscriptions on the <a href="%s">Stock Notifications page</a>.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('sprintf', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-customer-stock-notifications&customer_stock_notifications_product_filter=%d&status=active_customer_stock_notifications&filter_action=Filter'),
			]),
			var_product_id.clone(),
		]),
	])
	rt.call_function('update_option', [
		rt.new_string('wc_customer_stock_notifications_product_sync_notice'),
		var_notice_message.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) output_admin_notice() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_admin_notice'),
	])))))
	{
		return
	}
	mut var_notice_message := rt.call_function('get_option', [
		rt.new_string('wc_customer_stock_notifications_product_sync_notice'),
	])
	if !rt.is_true(var_notice_message) {
		return
	}
	rt.call_function('wp_admin_notice', [var_notice_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
			rt.ArrayItem{
				key: 'id'
				val: 'woocommerce_customer_stock_notifications_product_sync_notice'
			}, rt.ArrayItem{ key: 'dismissible', val: false }])])
	rt.call_function('delete_option', [
		rt.new_string('wc_customer_stock_notifications_product_sync_notice'),
	])
}

fn create_automattic_woocommerce_internal_stocknotifications_stocksynccontroller() &Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController{
		PhpObjectBase:       rt.PhpObjectBase{}
		queue:               rt.new_array()
		eligibility_service: rt.new_null()
		job_manager:         rt.new_null()
		logger:              rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_AsyncTasks_JobManager](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'handle_product_stock_status_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.handle_product_stock_status_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'process_queue' {
			this.process_queue()
			return rt.new_null()
		}
		'store_admin_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.store_admin_notice(dispatch_arg_0)
			return rt.new_null()
		}
		'output_admin_notice' {
			this.output_admin_notice()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queue' { return this.queue }
		'eligibility_service' { return this.eligibility_service }
		'job_manager' { return this.job_manager }
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_StockSyncController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queue' {
			this.queue = val
			return true
		}
		'eligibility_service' {
			this.eligibility_service = val
			return true
		}
		'job_manager' {
			this.job_manager = val
			return true
		}
		'logger' {
			this.logger = val
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

import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option() string {
	return 'woocommerce_admin_scheduler_last_processed_order_modified_date'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_id_option() string {
	return 'woocommerce_admin_scheduler_last_processed_order_id'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option() string {
	return 'woocommerce_analytics_scheduled_import'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.legacy_immediate_import_option() string {
	return 'woocommerce_analytics_immediate_import'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value() string {
	return 'no'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action() string {
	return 'process_pending_batch'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_schedulers_ordersscheduler() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler', 'name',
		rt.new_string('orders'))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.init() {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order{}
	mut iife_result_0 := iife_temp_0.add_filters()
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund{}
	mut iife_result_1 := iife_temp_1.add_filters()
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled()) {
		rt.call_function('add_action', [
			rt.new_string('action_scheduler_ensure_recurring_actions'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'schedule_recurring_batch_processor' }]),
		])
	} else {
		rt.call_function('add_action', [rt.new_string('woocommerce_update_order'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
		rt.call_function('add_filter', [rt.new_string('woocommerce_create_order'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_refund_created'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_schedule_import'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_2 := iife_temp_2.is_enabled(rt.new_string('analytics-scheduled-import'))
	if rt.is_true(iife_result_2) {
		rt.call_function('add_action', [
			rt.new_string('add_option_' +(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option()).str()),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'handle_scheduled_import_option_added' }]),
			rt.new_int(10),
			rt.new_int(2),
		])
		rt.call_function('add_action', [
			rt.new_string('update_option_' +(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option()).str()),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'handle_scheduled_import_option_change' }]),
			rt.new_int(10),
			rt.new_int(2),
		])
		rt.call_function('add_action', [rt.new_string('delete_option'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'handle_scheduled_import_option_before_delete' }]),
			rt.new_int(10), rt.new_int(1)])
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_3 := iife_temp_3.init()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}
	mut iife_result_4 := iife_temp_4.init()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_5 := iife_temp_5.init()
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_6 := iife_temp_6.init()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_7 := iife_temp_7.init()
	this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.init()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_dependencies() rt.PhpVal {
	mut iife_temp_8 :=
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler{}
	mut iife_result_8 := iife_temp_8.get_action(rt.new_string('import_batch_init'))
	return rt.create_array([rt.ArrayItem{ key: 'import_batch_init', val: iife_result_8 }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_scheduler_actions() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_scheduler_actions(),
		rt.create_array([
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action()
				val: 'wc-admin_process_pending_orders_batch'
			},
		])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_batch_sizes() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_batch_sizes(),
		rt.create_array([
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action()
				val: 100
			},
		])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items(limit i64, page i64, days bool, skip_existing bool) rt.PhpVal {
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_9 := iife_temp_9.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_9) {
		return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_orders_table(rt.new_int(limit),
			rt.new_int(page), rt.new_bool(days), rt.new_bool(skip_existing))
	} else {
		return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_posts_table(rt.new_int(limit),
			rt.new_int(page), rt.new_bool(days), rt.new_bool(skip_existing))
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_posts_table(var_limit rt.PhpVal, var_page rt.PhpVal, var_days rt.PhpVal, var_skip_existing rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_where_clause := rt.new_string('')
	mut var_offset := if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		rt.mul(rt.sub(var_page, rt.new_int(1)), var_limit)
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(var_days.clone().is_long())) {
		mut var_days_ago := rt.call_function('gmdate', [rt.new_string('Y-m-d 00:00:00'),
			rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'),
				var_days))])
		var_where_clause = rt.concat(var_where_clause,
			rt.new_string(" AND post_date_gmt >= '${var_days_ago.to_string()}'"))
	}
	if rt.is_true(var_skip_existing) {
		var_where_clause = rt.concat(var_where_clause, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND NOT EXISTS (\n\t\t\t\tSELECT 1 FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats\n\t\t\t\tWHERE ')), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats.order_id = ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID\n\t\t\t)')))
	}
	mut var_count := rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string("\n\t\t\tWHERE post_type IN ( 'shop_order', 'shop_order_refund' )\n\t\t\tAND post_status NOT IN ( 'wc-auto-draft', 'auto-draft', 'trash' )\n\t\t\t")),
			var_where_clause),
	])
	mut var_order_ids := if rt.is_true(rt.greater(rt.call_function('absint', [
		var_count.clone()]), rt.new_int(0)))
	{ rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string("\n\t\t\t\tWHERE post_type IN ( 'shop_order', 'shop_order_refund' )\n\t\t\t\tAND post_status NOT IN ( 'wc-auto-draft', 'auto-draft', 'trash' )\n\t\t\t\t")), var_where_clause), rt.new_string('\n\t\t\t\tORDER BY post_date_gmt ASC\n\t\t\t\tLIMIT %d\n\t\t\t\tOFFSET %d')),
				var_limit.clone(),
				var_offset.clone(),
			]),
		]) } else { rt.new_array() }
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'total', val: rt.call_function('absint', [
			var_count.clone()]) },
		rt.ArrayItem{ key: 'ids', val: var_order_ids },
	]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_orders_table(var_limit rt.PhpVal, var_page rt.PhpVal, var_days rt.PhpVal, var_skip_existing rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_where_clause := rt.new_string('')
	mut var_offset := if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		rt.mul(rt.sub(var_page, rt.new_int(1)), var_limit)
	} else {
		rt.new_int(0)
	}
	mut iife_temp_10 :=
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_10 := iife_temp_10.get_orders_table_name()
	mut var_order_table := iife_result_10
	if rt.is_true(rt.new_bool(var_days.clone().is_long())) {
		mut var_days_ago := rt.call_function('gmdate', [rt.new_string('Y-m-d 00:00:00'),
			rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'),
				var_days))])
		var_where_clause = rt.concat(var_where_clause,
			rt.new_string(" AND orders.date_created_gmt >= '${var_days_ago.to_string()}'"))
	}
	if rt.is_true(var_skip_existing) {
		var_where_clause = rt.concat(var_where_clause, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('AND NOT EXiSTS (\n\t\t\t\t\tSELECT 1 FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats\n\t\t\t\t\tWHERE ')), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats.order_id = orders.id\n\t\t\t\t\t)\n\t\t\t\t')))
	}
	mut var_count := rt.call_method(var_wpdb, 'get_var', [
		rt.new_string("\nSELECT COUNT(*) FROM ${var_order_table.to_string()} AS orders\nWHERE type in ( 'shop_order', 'shop_order_refund' )\nAND status NOT IN ( 'wc-auto-draft', 'trash', 'auto-draft' )\n${var_where_clause.to_string()}\n"),
	])
	mut var_order_ids := if rt.is_true(rt.greater(rt.call_function('absint', [
		var_count.clone()]), rt.new_int(0)))
	{ rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string("SELECT id FROM ${var_order_table.to_string()} AS orders\n\t\t\t\tWHERE type IN ( 'shop_order', 'shop_order_refund' )\n\t\t\t\tAND status NOT IN ( 'wc-auto-draft', 'auto-draft', 'trash' )\n\t\t\t\t${var_where_clause.to_string()}\n\t\t\t\tORDER BY date_created_gmt ASC\n\t\t\t\tLIMIT %d\n\t\t\t\tOFFSET %d"),
				var_limit.clone(),
				var_offset.clone(),
			]),
		]) } else { rt.new_array() }
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'total', val: rt.call_function('absint', [
			var_count.clone()]) },
		rt.ArrayItem{ key: 'ids', val: var_order_ids },
	]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_total_imported() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats')),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.possibly_schedule_import(var_order_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled()) {
		return var_order_id.clone()
	}
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_11 := iife_temp_11.is_order(var_order_id.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'shop_order' },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_refund_created'), rt.call_function('current_filter', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_schedule_import'), rt.call_function('current_filter', []rt.PhpVal{}))))) {
		return var_order_id.clone()
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
	mut iife_result_12 := iife_temp_12.schedule_action(rt.new_string('import'), rt.create_array([
		rt.ArrayItem{ key: none, val: var_order_id },
	]))
	return var_order_id.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.import(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return
	}
	mut var_type := rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), var_type))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order_refund'), var_type)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_test_order(var_order.clone())) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [
			rt.call_function('sprintf', [
				rt.new_string('Skipping test order #%d from analytics import.'),
				var_order_id.clone(),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc-analytics-order-import' },
			]),
		])
		return
	}
	mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_13 := iife_temp_13.sync_order(var_order_id.clone())
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}
	mut iife_result_14 := iife_temp_14.sync_order_products(var_order_id.clone())
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}
	mut iife_result_15 := iife_temp_15.sync_order_coupons(var_order_id.clone())
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}
	mut iife_result_16 := iife_temp_16.sync_order_taxes(var_order_id.clone())
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_17 := iife_temp_17.sync_order_customer(var_order_id.clone())
	mut var_results := rt.create_array([rt.ArrayItem{ key: none, val: iife_result_13 },
		rt.ArrayItem{ key: none, val: iife_result_14 }, rt.ArrayItem{ key: none, val: iife_result_15 },
		rt.ArrayItem{ key: none, val: iife_result_16 }, rt.ArrayItem{ key: none, val: iife_result_17 }])
	if rt.is_true(rt.identical(rt.new_string('shop_order'), var_type)) {
		mut var_order_refunds := rt.call_method(var_order, 'get_refunds', []rt.PhpVal{})
		mut iter_1 := var_order_refunds.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_refund := item_1.val
			mut iife_temp_18 :=
				Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
			mut iife_result_18 := iife_temp_18.sync_order(rt.call_method(var_refund, 'get_id',
				[]rt.PhpVal{}))
		}
	}
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_19 := iife_temp_19.invalidate()
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_scheduler_after_import_order'),
		var_order_id.clone(),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.schedule_recurring_batch_processor() {
	mut iife_temp_20 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
	mut iife_result_20 :=
		iife_temp_20.get_action(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
	mut var_action_hook := iife_result_20
	if rt.is_true(rt.identical(rt.new_null(), var_action_hook)) {
		return
	}
	mut var_has_scheduled_action := rt.new_string((if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('as_has_scheduled_action'),
	]))
	{ 'as_has_scheduled_action' } else { 'as_next_scheduled_action' }).str())
	if rt.is_true(rt.call_function('call_user_func', [var_has_scheduled_action.clone(),
		var_action_hook.clone()]))
	{
		return
	}
	mut var_interval :=
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_import_interval()
	rt.call_function('as_schedule_recurring_action', [
		rt.call_function('time', []rt.PhpVal{}),
		var_interval.clone(),
		var_action_hook.clone(),
		rt.new_array(),
		if !(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler',
			'group')).is_null() {
			rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler',
				'group')
		} else {
			rt.new_string('')
		},
		rt.new_bool(true),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(var_old_value rt.PhpVal, var_new_value rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('yes'), var_old_value))
		&& rt.is_true(rt.identical(rt.new_string('no'), var_new_value)) {
		mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
		mut iife_result_21 :=
			iife_temp_21.get_action(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
		mut var_action_hook := iife_result_21
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_action_hook)))) {
			rt.call_function('as_unschedule_all_actions', [var_action_hook.clone(),
				rt.new_array(), if !(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler',
					'group')).is_null() {
					rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler',
						'group')
				} else {
					rt.new_string('')
				}])
		}
		mut iife_temp_22 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
		mut iife_result_22 := iife_temp_22.schedule_action(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action(), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_null() },
			rt.ArrayItem{ key: none, val: rt.new_null() },
		]))
	} else if rt.is_true(rt.identical(rt.new_string('no'), var_old_value))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_new_value)) {
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(),
			rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
				rt.sub(rt.call_function('time', []rt.PhpVal{}),
					rt.get_constant('MINUTE_IN_SECONDS'))]),
		])
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_id_option(),
			rt.new_int(0),
		])
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.schedule_recurring_batch_processor()
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_added(var_option_name rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option(),
		var_option_name))))
	{
		return
	}
	Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value(),
		var_value_mutated.clone())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_before_delete(var_option_name rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option(),
		var_option_name))))
	{
		return
	}
	Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option(),
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value(),
	]),
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_batch(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal) {
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut var_context := rt.create_array([
		rt.ArrayItem{ key: 'source', val: 'wc-analytics-order-import' },
	])
	mut iife_temp_23 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
	mut iife_result_23 := iife_temp_23.is_importing()
	if rt.is_true(iife_result_23) {
		rt.call_method(var_logger, 'info', [
			rt.new_string('Import is already in progress, skipping batch import.'),
			var_context.clone(),
		])
		return
	}
	mut var_default_cursor_date := rt.call_function('gmdate', [
		rt.new_string('Y-m-d H:i:s'),
		rt.call_function('strtotime', [rt.new_string('-24 hours')]),
	])
	var_cursor_date_mutated = if !var_cursor_date_mutated.is_null() { var_cursor_date_mutated } else { rt.call_function('get_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(),
			var_default_cursor_date.clone(),
		]) }
	var_cursor_id_mutated = if !var_cursor_id_mutated.is_null() { var_cursor_id_mutated } else { rt.new_int((rt.call_function('get_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_id_option(),
			rt.new_int(0),
		])).to_i64()) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cursor_date_mutated))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strtotime', [var_cursor_date_mutated.clone()]))))) {
		rt.call_method(var_logger, 'error', [
			rt.new_string('Invalid cursor date: ' + var_cursor_date_mutated.str()),
			var_context.clone(),
		])
		var_cursor_date_mutated = var_default_cursor_date.clone()
	}
	mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
	mut iife_result_24 :=
		iife_temp_24.get_batch_size(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
	mut var_batch_size := iife_result_24
	rt.call_method(var_logger, 'info', [
		rt.call_function('sprintf', [
			rt.new_string('Starting batch import. Cursor: %s (ID: %d), batch size: %d'),
			var_cursor_date_mutated.clone(),
			var_cursor_id_mutated.clone(),
			var_batch_size.clone(),
		]),
		var_context.clone(),
	])
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	mut var_orders := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since(var_cursor_date_mutated.clone(),
		var_cursor_id_mutated.clone(), var_batch_size.clone())
	if !rt.is_true(var_orders) {
		rt.call_method(var_logger, 'info', [rt.new_string('No orders to process'),
			var_context.clone()])
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(),
			rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
				rt.new_int(var_start_time.to_i64())]),
			rt.new_bool(false),
		])
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_id_option(),
			rt.new_int(0),
			rt.new_bool(false),
		])
		return
	}
	mut var_processed_count := rt.new_int(0)
	mut iter_2 := var_orders.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_order := item_2.val
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.import
		(rt.get_property(var_order, 'id'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.pre_inc(var_processed_count)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_cursor_date_mutated = rt.get_property(var_order, 'date_updated_gmt')
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_cursor_id_mutated = rt.get_property(var_order, 'id')
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
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Schedulers_Exception') {
			mut var_e := var_e_1.clone()
			rt.call_method(var_logger, 'error', [
				rt.call_function('sprintf', [
					rt.new_string('Failed to import order %d: %s'),
					rt.get_property(var_order, 'id'),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]),
				var_context.clone(),
			])
			break
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
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(),
		var_cursor_date_mutated.clone(),
		rt.new_bool(false),
	])
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_id_option(),
		var_cursor_id_mutated.clone(),
		rt.new_bool(false),
	])
	mut var_elapsed_time := rt.sub(rt.call_function('microtime', [
		rt.new_bool(true)]), var_start_time)
	rt.call_method(var_logger, 'info', [
		rt.call_function('sprintf', [
			rt.new_string('Batch import completed. Processed: %d orders in %.2f seconds. Cursor: %s (ID: %d)'),
			var_processed_count.clone(),
			var_elapsed_time.clone(),
			var_cursor_date_mutated.clone(),
			var_cursor_id_mutated.clone(),
		]),
		var_context.clone(),
	])
	if rt.is_true(rt.identical(var_processed_count, var_batch_size)) {
		rt.call_method(var_logger, 'info', [
			rt.new_string('Full batch processed, scheduling next batch'),
			var_context.clone(),
		])
		mut iife_temp_25 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
		mut iife_result_25 := iife_temp_25.schedule_action(rt.new_string('process_pending_batch'), rt.create_array([
			rt.ArrayItem{ key: none, val: var_cursor_date_mutated },
			rt.ArrayItem{ key: none, val: var_cursor_id_mutated },
		]))
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_import_interval() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_import_interval'),
		rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	mut iife_temp_26 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_26 := iife_temp_26.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_26) {
		return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_orders_table(var_cursor_date_mutated.clone(),
			var_cursor_id_mutated.clone(), var_limit.clone())
	} else {
		return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_posts_table(var_cursor_date_mutated.clone(),
			var_cursor_id_mutated.clone(), var_limit.clone())
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_orders_table(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	mut iife_temp_27 :=
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_27 := iife_temp_27.get_orders_table_name()
	mut var_orders_table := iife_result_27
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT id, date_updated_gmt\n\t\t\t\tFROM ${var_orders_table.to_string()}\n\t\t\t\tWHERE type IN ('shop_order', 'shop_order_refund')\n\t\t\t\tAND status NOT IN ('wc-auto-draft', 'auto-draft', 'trash')\n\t\t\t\tAND (\n\t\t\t\t\tdate_updated_gmt > %s\n\t\t\t\t\tOR (date_updated_gmt = %s AND id > %d)\n\t\t\t\t)\n\t\t\t\tORDER BY date_updated_gmt ASC, id ASC\n\t\t\t\tLIMIT %d"),
			var_cursor_date_mutated.clone(),
			var_cursor_date_mutated.clone(),
			var_cursor_id_mutated.clone(),
			var_limit.clone(),
		]),
	])
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_posts_table(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT ID as id, post_modified_gmt as date_updated_gmt\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string("\n\t\t\t\tWHERE post_type IN ('shop_order', 'shop_order_refund')\n\t\t\t\tAND post_status NOT IN ('wc-auto-draft', 'auto-draft', 'trash')\n\t\t\t\tAND (\n\t\t\t\t\tpost_modified_gmt > %s\n\t\t\t\t\tOR (post_modified_gmt = %s AND ID > %d)\n\t\t\t\t)\n\t\t\t\tORDER BY post_modified_gmt ASC, ID ASC\n\t\t\t\tLIMIT %d")),
			var_cursor_date_mutated.clone(),
			var_cursor_date_mutated.clone(),
			var_cursor_id_mutated.clone(),
			var_limit.clone(),
		]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_test_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated,
		'Automattic_WooCommerce_Internal_Admin_Schedulers_WC_Abstract_Order'))))))
	{
		return false
	}
	mut var_check_order := var_order_mutated.clone()
	if rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_order_mutated,
		'get_type', []rt.PhpVal{})))
	{
		var_check_order = rt.call_function('wc_get_order', [
			rt.call_method(var_order_mutated, 'get_parent_id', []rt.PhpVal{}),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_check_order,
			'Automattic_WooCommerce_Internal_Admin_Schedulers_WC_Abstract_Order'))))))
		{
			return false
		}
	}
	mut var_is_test := rt.identical(rt.new_string('test'), rt.call_method(var_check_order,
		'get_meta', [rt.new_string('_wcpay_mode')]))
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_is_test_order'),
		var_is_test.clone(),
		var_check_order.clone(),
	])).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.delete(var_batch_size rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_batch_size_mutated := var_batch_size
	mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT order_id FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_order_stats ORDER BY order_id ASC LIMIT %d')),
			var_batch_size_mutated.clone(),
		]),
	])
	mut iter_3 := var_order_ids.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_order_id := item_3.val
		mut iife_temp_28 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
		mut iife_result_28 := iife_temp_28.delete_order(var_order_id.clone())
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled() bool {
	mut iife_temp_29 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_29 := iife_temp_29.is_enabled(rt.new_string('analytics-scheduled-import'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_29)))) {
		return false
	}
	mut var_value := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option(),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
		return (rt.identical(rt.new_string('yes'), var_value)).to_bool()
	}
	mut var_legacy_value := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.legacy_immediate_import_option(),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_legacy_value)))) {
		return (rt.identical(rt.new_string('no'), var_legacy_value)).to_bool()
	}
	return false
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_importscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_automattic_woocommerce_admin_overrides_order(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_automattic_woocommerce_admin_overrides_orderrefund(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_products_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_taxes_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_automattic_woocommerce_internal_admin_schedulers_customersscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.init()
			return rt.new_null()
		}
		'get_dependencies' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_dependencies()
		}
		'get_scheduler_actions' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_scheduler_actions()
		}
		'get_batch_sizes' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_batch_sizes()
		}
		'get_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_items_from_posts_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_posts_table(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_items_from_orders_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_orders_table(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_total_imported' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_total_imported()
		}
		'possibly_schedule_import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.possibly_schedule_import(dispatch_arg_0)
		}
		'import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.import
			dispatch_arg_0
			return rt.new_null()
		}
		'schedule_recurring_batch_processor' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.schedule_recurring_batch_processor()
			return rt.new_null()
		}
		'handle_scheduled_import_option_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'handle_scheduled_import_option_added' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_added(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'handle_scheduled_import_option_before_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_before_delete(dispatch_arg_0)
			return rt.new_null()
		}
		'process_pending_batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_batch(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'get_import_interval' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_import_interval()
		}
		'get_orders_since' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'get_orders_since_from_orders_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_orders_table(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'get_orders_since_from_posts_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_posts_table(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'is_test_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_test_order(dispatch_arg_0))
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.delete(dispatch_arg_0)
			return rt.new_null()
		}
		'is_scheduled_import_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

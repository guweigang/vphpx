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
pub mut:
		name rt.PhpVal = rt.new_string('orders')
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.init()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order{}; return temp.add_filters() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund{}; return temp.add_filters() }()
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled()) {
		rt.call_function('add_action', [rt.new_string('action_scheduler_ensure_recurring_actions'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'schedule_recurring_batch_processor' }])])
	} else {
		rt.call_function('add_action', [rt.new_string('woocommerce_update_order'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
		rt.call_function('add_filter', [rt.new_string('woocommerce_create_order'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_refund_created'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
		rt.call_function('add_action', [rt.new_string('woocommerce_schedule_import'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'possibly_schedule_import' }])])
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('analytics-scheduled-import'))) {
		rt.call_function('add_action', ['add_option_' + (Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option()).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_scheduled_import_option_added' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', ['update_option_' + (Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option()).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_scheduled_import_option_change' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', [rt.new_string('delete_option'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_scheduled_import_option_before_delete' }]), rt.new_int(10), rt.new_int(1)])
	}
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}; return temp.init() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.init() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}; return temp.init() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.init() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}; return temp.init() }()
	this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.init()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_dependencies() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'import_batch_init', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler{}; return temp.get_action(arg_0) }(rt.new_string('import_batch_init')) }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_scheduler_actions() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_scheduler_actions(), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action(), val: 'wc-admin_process_pending_orders_batch' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_batch_sizes() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.get_batch_sizes(), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action(), val: 100 }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items(limit i64, page i64, days bool, skip_existing bool) rt.PhpVal {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()) {
		return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_orders_table(rt.new_int(limit), rt.new_int(page), rt.new_bool(days), rt.new_bool(skip_existing))
	} else {
		return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_posts_table(rt.new_int(limit), rt.new_int(page), rt.new_bool(days), rt.new_bool(skip_existing))
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_posts_table(var_limit rt.PhpVal, var_page rt.PhpVal, var_days rt.PhpVal, var_skip_existing rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_where_clause := rt.new_string(rt.new_string(''))
	mut var_offset := if rt.is_true(rt.greater(var_page, rt.new_int(1))) { rt.mul(rt.sub(var_page, rt.new_int(1)), var_limit) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(var_days.dup().is_long())) {
		mut var_days_ago := rt.call_function('gmdate', [rt.new_string('Y-m-d 00:00:00'), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'), var_days))])
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(var_skip_existing) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_count := rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\tWHERE post_type IN ( \'shop_order\', \'shop_order_refund\' )\n\t\t\tAND post_status NOT IN ( \'wc-auto-draft\', \'auto-draft\', \'trash\' )\n\t\t\t')), var_where_clause)])
	mut var_order_ids := if rt.is_true(rt.greater(rt.call_function('absint', [var_count.dup()]), rt.new_int(0))) { rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_type IN ( \'shop_order\', \'shop_order_refund\' )\n\t\t\t\tAND post_status NOT IN ( \'wc-auto-draft\', \'auto-draft\', \'trash\' )\n\t\t\t\t')), var_where_clause), rt.new_string('\n\t\t\t\tORDER BY post_date_gmt ASC\n\t\t\t\tLIMIT %d\n\t\t\t\tOFFSET %d')), var_limit.dup(), var_offset.dup()])]) } else { rt.new_array() }
	return // unsupported expression: Expr_Cast_Object
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_orders_table(var_limit rt.PhpVal, var_page rt.PhpVal, var_days rt.PhpVal, var_skip_existing rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_where_clause := rt.new_string(rt.new_string(''))
	mut var_offset := if rt.is_true(rt.greater(var_page, rt.new_int(1))) { rt.mul(rt.sub(var_page, rt.new_int(1)), var_limit) } else { rt.new_int(0) }
	mut var_order_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}; return temp.get_orders_table_name() }()
	if rt.is_true(rt.new_bool(var_days.dup().is_long())) {
		mut var_days_ago := rt.call_function('gmdate', [rt.new_string('Y-m-d 00:00:00'), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'), var_days))])
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(var_skip_existing) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_count := rt.call_method(var_wpdb, 'get_var', [rt.new_string("\nSELECT COUNT(*) FROM ${var_order_table.to_string()} AS orders\nWHERE type in ( 'shop_order', 'shop_order_refund' )\nAND status NOT IN ( 'wc-auto-draft', 'trash', 'auto-draft' )\n${var_where_clause.to_string()}\n")])
	mut var_order_ids := if rt.is_true(rt.greater(rt.call_function('absint', [var_count.dup()]), rt.new_int(0))) { rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT id FROM ${var_order_table.to_string()} AS orders\n\t\t\t\tWHERE type IN ( 'shop_order', 'shop_order_refund' )\n\t\t\t\tAND status NOT IN ( 'wc-auto-draft', 'auto-draft', 'trash' )\n\t\t\t\t${var_where_clause.to_string()}\n\t\t\t\tORDER BY date_created_gmt ASC\n\t\t\t\tLIMIT %d\n\t\t\t\tOFFSET %d"), var_limit.dup(), var_offset.dup()])]) } else { rt.new_array() }
	return // unsupported expression: Expr_Cast_Object
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_total_imported() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats'))])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.possibly_schedule_import(var_order_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled()) {
		return var_order_id.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.is_order(arg_0, arg_1) }(var_order_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'shop_order' }])))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_order_id.dup()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.schedule_action(arg_0, arg_1) }(rt.new_string('import'), rt.create_array([rt.ArrayItem{ key: none, val: var_order_id }]))
	return var_order_id.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.import(var_order_id rt.PhpVal)  {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_null()
	}
	mut var_type := rt.call_method(var_order, 'get_type', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_test_order(var_order.dup())) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'debug', [rt.call_function('sprintf', [rt.new_string('Skipping test order #%d from analytics import.'), var_order_id.dup()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-analytics-order-import' }])])
		return rt.new_null()
	}
	mut var_results := rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}; return temp.sync_order(arg_0) }(var_order_id.dup()) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{}; return temp.sync_order_products(arg_0) }(var_order_id.dup()) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{}; return temp.sync_order_coupons(arg_0) }(var_order_id.dup()) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{}; return temp.sync_order_taxes(arg_0) }(var_order_id.dup()) }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}; return temp.sync_order_customer(arg_0) }(var_order_id.dup()) }])
	if rt.is_true(rt.identical(rt.new_string('shop_order'), var_type)) {
		mut var_order_refunds := rt.call_method(var_order, 'get_refunds', []rt.PhpVal{})
		{
			mut iter_1 := var_order_refunds.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_refund := item_1.val
				fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}; return temp.sync_order(arg_0) }(rt.call_method(var_refund, 'get_id', []rt.PhpVal{}))
			}
		}
	}
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}; return temp.invalidate() }()
	rt.call_function('do_action', [rt.new_string('woocommerce_order_scheduler_after_import_order'), var_order_id.dup()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.schedule_recurring_batch_processor()  {
	mut var_action_hook := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.get_action(arg_0) }(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
	if rt.is_true(rt.identical(rt.new_null(), var_action_hook)) {
		return rt.new_null()
	}
	mut var_has_scheduled_action := rt.new_string(if rt.is_true(rt.call_function('function_exists', [rt.new_string('as_has_scheduled_action')])) { rt.new_string('as_has_scheduled_action') } else { rt.new_string('as_next_scheduled_action') })
	if rt.is_true(rt.call_function('call_user_func', [var_has_scheduled_action.dup(), var_action_hook.dup()])) {
		return rt.new_null()
	}
	mut var_interval := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_import_interval()
	rt.call_function('as_schedule_recurring_action', [rt.call_function('time', []rt.PhpVal{}), var_interval.dup(), var_action_hook.dup(), rt.new_array(), if !(// unsupported expression: Expr_StaticPropertyFetch).is_null() { // unsupported expression: Expr_StaticPropertyFetch } else { rt.new_string('') }, rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(var_old_value rt.PhpVal, var_new_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), var_old_value)) && rt.is_true(rt.identical(rt.new_string('no'), var_new_value)))) {
		mut var_action_hook := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.get_action(arg_0) }(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action())
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('as_unschedule_all_actions', [var_action_hook.dup(), rt.new_array(), if !(// unsupported expression: Expr_StaticPropertyFetch).is_null() { // unsupported expression: Expr_StaticPropertyFetch } else { rt.new_string('') }])
		}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.schedule_action(arg_0, arg_1) }(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_orders_batch_action(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }]))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('no'), var_old_value)) && rt.is_true(rt.identical(rt.new_string('yes'), var_new_value)))) {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('MINUTE_IN_SECONDS'))])])
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_id_option(), rt.new_int(0)])
		Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.schedule_recurring_batch_processor()
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_added(var_option_name rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value(), var_value_mutated.dup())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_before_delete(var_option_name rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option(), Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value()]), Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.scheduled_import_option_default_value())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_batch(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal)  {
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut var_context := rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-analytics-order-import' }])
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.is_importing() }()) {
		rt.call_method(var_logger, 'info', [rt.new_string('Import is already in progress, skipping batch import.'), var_context.dup()])
		return rt.new_null()
	}
	mut var_default_cursor_date := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_function('strtotime', [rt.new_string('-24 hours')])])
	var_cursor_date_mutated = if !(var_cursor_date_mutated).is_null() { var_cursor_date_mutated } else { rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.last_processed_order_date_option(), var_default_cursor_date.dup()]) }
	var_cursor_id_mutated = if !(var_cursor_id_mutated).is_null() { var_cursor_id_mutated } else { // unsupported expression: Expr_Cast_Int }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_cursor_date_mutated)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strtotime', [var_cursor_date_mutated.dup()]))))))) {
		rt.call_method(var_logger, 'error', ['Invalid cursor date: ' + (var_cursor_date_mutated).str(), var_context.dup()])
		var_cursor_date_mutated = var_default_cursor_date.dup()
	}
	mut var_batch_size := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}; return temp.get_batch_size(arg_0) }()
	rt.call_method(, 'info', [, .dup()])
	
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_import_interval() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_orders_table(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_posts_table(var_cursor_date rt.PhpVal, var_cursor_id rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_cursor_date_mutated := var_cursor_date
	mut var_cursor_id_mutated := var_cursor_id
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_test_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.delete(var_batch_size rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_batch_size_mutated := var_batch_size
}

fn Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.is_scheduled_import_enabled() bool {
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

fn create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_string('orders')
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_importscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_automattic_woocommerce_admin_overrides_order() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_automattic_woocommerce_admin_overrides_orderrefund() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Admin_Overrides_OrderRefund{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_products_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_taxes_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_automattic_woocommerce_internal_admin_schedulers_customersscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache() &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
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
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_items_from_posts_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_posts_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_items_from_orders_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_items_from_orders_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.import(dispatch_arg_0)
			return rt.new_null()
		}
		'schedule_recurring_batch_processor' {
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.schedule_recurring_batch_processor()
			return rt.new_null()
		}
		'handle_scheduled_import_option_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_change(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_scheduled_import_option_added' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.handle_scheduled_import_option_added(dispatch_arg_0, dispatch_arg_1)
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
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.process_pending_batch(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_import_interval' {
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_import_interval()
		}
		'get_orders_since' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_orders_since_from_orders_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_orders_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_orders_since_from_posts_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler.get_orders_since_from_posts_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_schedulers_ordersscheduler_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

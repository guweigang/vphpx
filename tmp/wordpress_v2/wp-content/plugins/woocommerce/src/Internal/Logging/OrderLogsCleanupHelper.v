import rt

pub fn Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper.max_files_per_run() i64 {
	return 100
}

pub fn Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper.max_orders_per_run() i64 {
	return 100
}

struct Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper {
	rt.PhpObjectBase
pub mut:
	hpos_in_use       rt.PhpVal = rt.new_bool(false)
	cpt_in_use        bool
	data_synchronizer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) init(mut var_hpos_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController, mut var_data_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) {
	this.hpos_in_use = var_hpos_controller.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hpos_in_use)))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store{}
		mut iife_result_0 := iife_temp_0.load(rt.new_string('order'))
		this.cpt_in_use = rt.identical(Class_Automattic_WooCommerce_Internal_Logging_WC_Order_Data_Store_CPT.class(), rt.call_method(iife_result_0,
			'get_current_class_name', []rt.PhpVal{}))
	}
	this.data_synchronizer = var_data_synchronizer
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) get_max_age_in_seconds() i64 {
	return (rt.call_function('absint', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cleanup_order_debug_logs_max_age'),
			rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS')),
		]),
	])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) cleanup() {
	mut var_max_age := rt.new_int(this.get_max_age_in_seconds())
	if rt.is_true(rt.identical(rt.new_int(0), var_max_age)) {
		return
	}
	mut var_dangling_orders := this.get_dangling_orders(var_max_age.to_i64())
	this.clear_logs_and_delete_meta(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](var_dangling_orders))
	this.cleanup_old_log_files(var_max_age.to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) cleanup_old_log_files(max_age i64) {
	mut max_age_mutated := max_age
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_1 := iife_temp_1.get_default_handler()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1,
		Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Admin_Logging_LogHandlerFileV2.class()))))
	{
		return
	}
	mut var_file_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileController.class(),
	])
	mut var_files := rt.call_method(var_file_controller, 'get_files', [
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'place-order-debug' },
			rt.ArrayItem{ key: 'date_filter', val: 'modified' },
			rt.ArrayItem{ key: 'date_start', val: 1 }, rt.ArrayItem{ key: 'date_end', val: rt.sub(rt.call_function('time',
				[]rt.PhpVal{}), rt.new_int(max_age_mutated)) },
			rt.ArrayItem{
				key: 'per_page'
				val: Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper.max_files_per_run()
			}]),
	])
	if !(var_files.clone().is_array()) {
		return
	}
	mut iter_1 := var_files.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_file := item_1.val
		rt.call_method(var_file, 'delete', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) clear_logs_and_delete_meta(mut var_items Class_Automattic_WooCommerce_Internal_Logging_array) {
	if !rt.is_true(var_items) {
		return
	}
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.instance_of(var_logger, 'WC_Logger'))) {
		mut iter_2 := var_items.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_source := item_2.val
			rt.call_method(var_logger, 'clear', [var_source.clone()])
		}
	}
	mut var_order_ids := rt.func_array_keys(var_items)
	this.delete_debug_log_meta_entries(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](var_order_ids))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) get_dangling_orders(max_age i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut max_age_mutated := max_age
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hpos_in_use)))) && !(this.cpt_in_use) {
		return rt.new_array()
	}
	mut var_cutoff_date := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
		rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.new_int(max_age_mutated))])
	mut var_meta_table := if rt.is_true(this.hpos_in_use) {
		rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_orders_meta'))
	} else {
		rt.get_property(var_wpdb, 'postmeta')
	}
	mut var_order_table := if rt.is_true(this.hpos_in_use) {
		rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_orders'))
	} else {
		rt.get_property(var_wpdb, 'posts')
	}
	mut var_id_column := rt.new_string((if rt.is_true(this.hpos_in_use) {
		'order_id'
	} else {
		'post_id'
	}).str())
	mut var_type_column := rt.new_string((if rt.is_true(this.hpos_in_use) {
		'type'
	} else {
		'post_type'
	}).str())
	mut var_date_column := rt.new_string((if rt.is_true(this.hpos_in_use) {
		'date_created_gmt'
	} else {
		'post_date_gmt'
	}).str())
	mut var_rows := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT m.${var_id_column.to_string()} as order_id, m.meta_value\n\t\t\t\t FROM ${var_meta_table.to_string()} m\n\t\t\t\t INNER JOIN ${var_order_table.to_string()} o ON m.${var_id_column.to_string()} = o.id\n\t\t\t\t WHERE m.meta_key = %s\n\t\t\t\t AND o.${var_type_column.to_string()} = %s\n\t\t\t\t AND o.${var_date_column.to_string()} < %s\n\t\t\t\t LIMIT %d'),
			rt.new_string('_debug_log_source'),
			rt.new_string('shop_order'),
			var_cutoff_date.clone(),
			Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper.max_orders_per_run(),
		]),
		rt.get_constant('ARRAY_A'),
	])
	return rt.call_function('array_column', [var_rows.clone(),
		rt.new_string('meta_value'), rt.new_string('order_id')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) delete_debug_log_meta_entries(mut var_order_ids Class_Automattic_WooCommerce_Internal_Logging_array) {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_tables := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'table'
				val: if rt.is_true(this.hpos_in_use) {
					rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_orders_meta'))
				} else {
					rt.get_property(var_wpdb, 'postmeta')
				}
			},
			rt.ArrayItem{
				key: 'id_column'
				val: if rt.is_true(this.hpos_in_use) { 'order_id' } else { 'post_id' }
			},
		]) },
	])
	if rt.is_true(rt.call_method(this.data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) {
		var_tables.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'table'
				val: if rt.is_true(this.hpos_in_use) {
					rt.get_property(var_wpdb, 'postmeta')
				} else {
					rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_orders_meta'))
				}
			},
			rt.ArrayItem{
				key: 'id_column'
				val: if rt.is_true(this.hpos_in_use) { 'post_id' } else { 'order_id' }
			},
		]))
	}
	mut var_id_placeholders := rt.call_function('implode', [rt.new_string(','),
		rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_ids_mutated.array_count()),
			rt.new_string('%d')])])
	mut iter_3 := var_tables.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_table_config := item_3.val
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '),
					var_table_config.array_get(rt.new_string('table'))),
					rt.new_string('\n\t\t\t\t\t WHERE ')),
					var_table_config.array_get(rt.new_string('id_column'))), rt.new_string(' IN (')),
					var_id_placeholders), rt.new_string(')\n\t\t\t\t\t AND meta_key IN (%s, %s)')),
				rt.call_function('array_merge', [var_order_ids_mutated,
					rt.create_array([rt.ArrayItem{ key: none, val: '_debug_log_source' },
						rt.ArrayItem{ key: none, val: '_debug_log_source_pending_deletion' }])]),
			]),
		])
	}
}

struct Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_logging_orderlogscleanuphelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper{
		PhpObjectBase:     rt.PhpObjectBase{}
		hpos_in_use:       rt.new_bool(false)
		cpt_in_use:        false
		data_synchronizer: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_automattic_woocommerce_utilities_loggingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_max_age_in_seconds' {
			return rt.new_int(this.get_max_age_in_seconds())
		}
		'cleanup' {
			this.cleanup()
			return rt.new_null()
		}
		'cleanup_old_log_files' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.cleanup_old_log_files(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_logs_and_delete_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.clear_logs_and_delete_meta(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_dangling_orders' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_dangling_orders(dispatch_arg_0)
		}
		'delete_debug_log_meta_entries' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.delete_debug_log_meta_entries(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hpos_in_use' { return this.hpos_in_use }
		'cpt_in_use' { return rt.new_bool(this.cpt_in_use) }
		'data_synchronizer' { return this.data_synchronizer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hpos_in_use' {
			this.hpos_in_use = val
			return true
		}
		'cpt_in_use' {
			this.cpt_in_use = val.to_bool()
			return true
		}
		'data_synchronizer' {
			this.data_synchronizer = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

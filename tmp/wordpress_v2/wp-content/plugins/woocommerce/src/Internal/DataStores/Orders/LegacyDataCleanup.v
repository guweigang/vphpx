import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.option_name() string {
	return 'woocommerce_hpos_legacy_data_cleanup_in_progress'
}

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.batch_size() i64 {
	return 25
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup {
	rt.PhpObjectBase
pub mut:
	batch_processing  rt.PhpVal = rt.new_null()
	legacy_handler    rt.PhpVal = rt.new_null()
	data_synchronizer rt.PhpVal = rt.new_null()
	error_logger      rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) init(mut var_batch_processing Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController, mut var_legacy_handler Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler, mut var_data_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) {
	this.legacy_handler = var_legacy_handler
	this.data_synchronizer = var_data_synchronizer
	this.batch_processing = var_batch_processing
	this.error_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) get_name() string {
	return 'Order legacy data cleanup'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) get_description() string {
	return 'Cleans up order data from legacy tables.'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) get_total_pending_count() i64 {
	return (if this.can_run() {
		rt.call_method(this.legacy_handler, 'count_orders_for_cleanup', []rt.PhpVal{})
	} else {
		rt.new_int(0)
	}).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) get_next_batch_to_process(size i64) rt.PhpVal {
	return if this.can_run() {
		rt.call_function('array_map', [rt.new_string('absint'),
			rt.call_method(this.legacy_handler, 'get_orders_for_cleanup', [
				rt.new_array(),
				rt.new_int(size),
			])])
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) process_batch(mut var_batch Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	if !(this.can_run()) {
		this.toggle_flag(false)
		return
	}
	mut var_batch_failed := rt.new_bool(true)
	mut iter_1 := var_batch.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order_id := item_1.val
		rt.call_method(this.legacy_handler, 'cleanup_post_data', [
			rt.call_function('absint', [var_order_id.clone()]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_batch_failed = rt.new_bool(false)
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
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_DataStores_Orders_Exception') {
			mut var_e := var_e_1.clone()
			rt.call_method(this.error_logger, 'error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Order %1$d legacy data could not be cleaned up during batch process. Error: %2$s'),
						rt.new_string('woocommerce'),
					]),
					var_order_id.clone(),
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
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
	if rt.is_true(var_batch_failed) {
		rt.call_method(this.error_logger, 'error', [
			rt.call_function('__', [
				rt.new_string('Order legacy cleanup failed for an entire batch of orders. Aborting cleanup.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if !(this.orders_pending()) || rt.is_true(var_batch_failed) {
		this.toggle_flag(false)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) get_default_batch_size() i64 {
	return (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.batch_size()).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) can_run() bool {
	return
		rt.is_true(rt.call_method(this.data_synchronizer, 'custom_orders_table_is_authoritative', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.batch_processing, 'is_enqueued', [rt.call_function('get_class', [this.data_synchronizer])])))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) is_flag_set() rt.PhpVal {
	return rt.call_method(this.batch_processing, 'is_enqueued', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) toggle_flag(enabled bool) bool {
	if var_enabled && this.can_run() {
		rt.call_method(this.batch_processing, 'enqueue_processor', [
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.class(),
		])
		return true
	} else {
		rt.call_method(this.batch_processing, 'remove_processor', [
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.class(),
		])
		return if var_enabled { false } else { true }
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) get_tools_entries() rt.PhpVal {
	mut var_orders_for_cleanup_exist := rt.new_bool(!(!rt.is_true(rt.call_method(this.legacy_handler,
		'get_orders_for_cleanup', [rt.new_array(), rt.new_int(1)]))))
	mut var_entry_id := rt.new_string((if rt.is_true(this.is_flag_set()) {
		'hpos_legacy_cleanup_cancel'
	} else {
		'hpos_legacy_cleanup'
	}).str())
	mut var_entry := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Clean up order data from legacy tables'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
			rt.new_string('This tool will clear the data from legacy order tables in WooCommerce.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'requires_refresh', val: true },
		rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
			rt.new_string('Clear data'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'disabled', val: !(this.can_run()
			&& rt.is_true(var_orders_for_cleanup_exist)
			|| rt.is_true(this.is_flag_set())) },
	])
	if !(this.can_run()) {
		var_entry.array_get(rt.new_string('desc')) = rt.concat(var_entry.array_get(rt.new_string('desc')),
			rt.new_string('<br />'))
		var_entry.array_get(rt.new_string('desc')) = rt.concat(var_entry.array_get(rt.new_string('desc')), rt.call_function('sprintf', [
			rt.new_string('<strong class="red">%1$s</strong> %2$s'),
			rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]),
			rt.call_function('__', [
				rt.new_string('Only available when HPOS is authoritative and compatibility mode is disabled.'),
				rt.new_string('woocommerce'),
			]),
		]))
	} else {
		if rt.is_true(this.is_flag_set()) {
			var_entry.array_set('status_text', rt.call_function('sprintf', [
				rt.new_string('%1$s %2$s'),
				rt.new_string('<span class="dashicons dashicons-update spin"></span>'),
				rt.call_function('__', [rt.new_string('Clearing data...'),
					rt.new_string('woocommerce')]),
			]))
			var_entry.array_set('button', rt.call_function('__', [
				rt.new_string('Cancel'),
				rt.new_string('woocommerce'),
			]))
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				this.toggle_flag(false)
				return rt.call_function('__', [
					rt.new_string('Order legacy data cleanup has been canceled.'),
					rt.new_string('woocommerce'),
				])
			}
			var_entry.array_set('callback', rt.new_closure(closure_1_fn))
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_orders_for_cleanup_exist)))) {
			var_entry.array_set('button', rt.call_function('__', [
				rt.new_string('No orders in need of cleanup'),
				rt.new_string('woocommerce'),
			]))
		} else {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				this.toggle_flag(true)
				return rt.call_function('__', [
					rt.new_string('Order legacy data cleanup process has been started.'),
					rt.new_string('woocommerce'),
				])
			}
			var_entry.array_set('callback', rt.new_closure(closure_2_fn))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: var_entry_id, val: var_entry }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) orders_pending() bool {
	return !(!rt.is_true(this.get_next_batch_to_process(1)))
}

fn create_automattic_woocommerce_internal_datastores_orders_legacydatacleanup(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup{
		PhpObjectBase:     rt.PhpObjectBase{}
		batch_processing:  rt.new_null()
		legacy_handler:    rt.new_null()
		data_synchronizer: rt.new_null()
		error_logger:      rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_total_pending_count' {
			return rt.new_int(this.get_total_pending_count())
		}
		'get_next_batch_to_process' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_next_batch_to_process(dispatch_arg_0)
		}
		'process_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_batch_size' {
			return rt.new_int(this.get_default_batch_size())
		}
		'can_run' {
			return rt.new_bool(this.can_run())
		}
		'is_flag_set' {
			return this.is_flag_set()
		}
		'toggle_flag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.toggle_flag(dispatch_arg_0))
		}
		'get_tools_entries' {
			return this.get_tools_entries()
		}
		'orders_pending' {
			return rt.new_bool(this.orders_pending())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'batch_processing' { return this.batch_processing }
		'legacy_handler' { return this.legacy_handler }
		'data_synchronizer' { return this.data_synchronizer }
		'error_logger' { return this.error_logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'batch_processing' {
			this.batch_processing = val
			return true
		}
		'legacy_handler' {
			this.legacy_handler = val
			return true
		}
		'data_synchronizer' {
			this.data_synchronizer = val
			return true
		}
		'error_logger' {
			this.error_logger = val
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

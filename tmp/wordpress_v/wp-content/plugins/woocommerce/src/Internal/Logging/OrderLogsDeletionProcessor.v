import rt

pub fn Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor.default_batch_size() i64 {
	return 1000
}
struct Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor {
	rt.PhpObjectBase
pub mut:
		hpos_in_use rt.PhpVal = rt.new_bool(false)
		cpt_in_use bool
		legacy_proxy rt.PhpVal = rt.new_null()
		order_logs_cleanup_helper rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) init(mut var_hpos_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController, mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy, mut var_order_logs_cleanup_helper Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper)  {
	this.hpos_in_use = var_hpos_controller.custom_orders_table_usage_is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hpos_in_use)))) {
		this.cpt_in_use = rt.identical(Class_Automattic_WooCommerce_Internal_Logging_WC_Order_Data_Store_CPT.class(), rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order')), 'get_current_class_name', []rt.PhpVal{}))
	}
	this.legacy_proxy = var_legacy_proxy.dup()
	this.order_logs_cleanup_helper = var_order_logs_cleanup_helper.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_name() string {
	return 'Order logs deletion process'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_description() string {
	return 'Deletes debug logs of completed orders.'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_default_batch_size() i64 {
	return (Class_Automattic_WooCommerce_Internal_Logging_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor.default_batch_size()).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_total_pending_count() i64 {
	if rt.is_true(this.hpos_in_use) {
		return this.get_total_pending_count_hpos()
	} else if rt.is_true(this.cpt_in_use) {
		return this.get_total_pending_count_cpt()
	} else {
		this.throw_doing_it_wrong((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.class_name_without_namespace(arg_0) }(rt.new_string(@STRUCT))).str() + '::' + @FN)
		return 0
	}
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_total_pending_count_hpos() i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_total_pending_count_cpt() i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_next_batch_to_process(size i64) rt.PhpVal {
	if rt.is_true(this.hpos_in_use) {
		return this.get_next_batch_to_process_hpos(size)
	} else if rt.is_true(this.cpt_in_use) {
		return this.get_next_batch_to_process_cpt(size)
	} else {
		this.throw_doing_it_wrong((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.class_name_without_namespace(arg_0) }(rt.new_string(@STRUCT))).str() + '::' + @FN)
		return rt.new_array()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_next_batch_to_process_hpos(size i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT order_id, meta_value\n                 FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_orders_meta\n                 WHERE meta_key = %s\n                 ORDER BY order_id\n                 LIMIT %d')), rt.new_string('_debug_log_source_pending_deletion'), rt.new_int(size)]), rt.get_constant('ARRAY_A')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) get_next_batch_to_process_cpt(size i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT p.ID as order_id, pm.meta_value\n                 FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm\n                 INNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' p ON pm.post_id = p.ID\n                 WHERE pm.meta_key = %s\n                 AND p.post_type = \'shop_order\'\n                 ORDER BY p.ID\n                 LIMIT %d')), rt.new_string('_debug_log_source_pending_deletion'), rt.new_int(size)]), rt.get_constant('ARRAY_A')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) process_batch(mut var_batch Class_Automattic_WooCommerce_Internal_Logging_array)  {
	if !rt.is_true(var_batch) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.hpos_in_use)))) && rt.is_true(rt.new_bool(!(rt.is_true(this.cpt_in_use)))))) {
		this.throw_doing_it_wrong((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.class_name_without_namespace(arg_0) }(rt.new_string(@STRUCT))).str() + '::' + @FN)
		return rt.new_null()
	}
	mut var_items := rt.new_array()
	{
		mut iter_1 := var_batch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_item.dup().is_array()))))) || !(var_item.array_isset(rt.new_string('meta_value'))))) || !(var_item.array_isset(rt.new_string('order_id'))))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Logging_Exception', []string{}, create_automattic_woocommerce_internal_logging_exception(rt.new_string('$batch must be an array of arrays, each having a \'meta_value\' key and an \'order_id\' key'))))
			}
			var_items.array_set(var_item.array_get('order_id'), var_item.array_get('meta_value'))
		}
	}
	rt.call_method(this.order_logs_cleanup_helper, 'clear_logs_and_delete_meta', [var_items.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) throw_doing_it_wrong(function_name string)  {
	rt.call_method(this.legacy_proxy, 'call_function', [rt.new_string('wc_doing_it_wrong'), rt.new_string(function_name), rt.new_string('This processor shouldn\'t be enqueued when the orders data store in use is neither the HPOS one nor the CPT one. Just delete the order debug logs directly.'), rt.new_string('10.3.0')])
}

struct Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_logging_orderlogsdeletionprocessor() &Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		hpos_in_use: rt.new_bool(false)
		cpt_in_use: false
		legacy_proxy: rt.new_null()
		order_logs_cleanup_helper: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_wc_data_store() &Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_exception() &Class_Automattic_WooCommerce_Internal_Logging_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_default_batch_size' {
			return rt.new_int(this.get_default_batch_size())
		}
		'get_total_pending_count' {
			return rt.new_int(this.get_total_pending_count())
		}
		'get_total_pending_count_hpos' {
			return rt.new_int(this.get_total_pending_count_hpos())
		}
		'get_total_pending_count_cpt' {
			return rt.new_int(this.get_total_pending_count_cpt())
		}
		'get_next_batch_to_process' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_next_batch_to_process(dispatch_arg_0)
		}
		'get_next_batch_to_process_hpos' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_next_batch_to_process_hpos(dispatch_arg_0)
		}
		'get_next_batch_to_process_cpt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_next_batch_to_process_cpt(dispatch_arg_0)
		}
		'process_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Logging_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'throw_doing_it_wrong' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.throw_doing_it_wrong(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hpos_in_use' { return this.hpos_in_use }
		'cpt_in_use' { return rt.new_bool(this.cpt_in_use) }
		'legacy_proxy' { return this.legacy_proxy }
		'order_logs_cleanup_helper' { return this.order_logs_cleanup_helper }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hpos_in_use' { this.hpos_in_use = val; return true }
		'cpt_in_use' { this.cpt_in_use = (val).to_bool(); return true }
		'legacy_proxy' { this.legacy_proxy = val; return true }
		'order_logs_cleanup_helper' { this.order_logs_cleanup_helper = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_logging_orderlogsdeletionprocessor_php() {
	// unsupported statement: Stmt_Declare
}

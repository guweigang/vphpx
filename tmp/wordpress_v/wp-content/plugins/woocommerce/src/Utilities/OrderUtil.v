import rt

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_admin_screen() string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'get_order_admin_screen', []rt.PhpVal{})).str()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.custom_orders_table_usage_is_enabled() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.custom_orders_table_datastore_cache_enabled() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()]), 'hpos_data_caching_is_enabled', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.orders_cache_usage_is_enabled() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caches_OrderCacheController.class()]), 'orders_cache_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.is_custom_order_tables_in_sync() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'is_custom_order_tables_in_sync', []rt.PhpVal{})).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_post_or_object_meta(mut var_post Class_Automattic_WooCommerce_Utilities_?WP_Post, mut var_data Class_Automattic_WooCommerce_Utilities_?WC_Data, key string, single bool) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'get_post_or_object_meta', [var_post, var_data, rt.new_string(key), rt.new_bool(single)])
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.init_theorder_object(var_post_or_order_object rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'init_theorder_object', [var_post_or_order_object.dup()])
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_post_or_order_id(var_post_or_order_object rt.PhpVal) i64 {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'get_post_or_order_id', [var_post_or_order_object.dup()])).to_i64()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.is_order(var_order_id rt.PhpVal, var_types rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'is_order', [var_order_id.dup(), var_types.dup()])
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_type(var_order_id rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'get_order_type', [var_order_id.dup()])
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_admin_edit_url(order_id i64) string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'get_edit_url', [rt.new_int(order_id)])).str()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_admin_new_url() string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'get_new_page_url', []rt.PhpVal{})).str()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.is_order_list_table_screen(order_type string) bool {
	mut order_type_mutated := order_type
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'is_order_screen', [rt.new_string(order_type_mutated).dup(), rt.new_string('list')])).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.is_order_edit_screen(order_type string) bool {
	mut order_type_mutated := order_type
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'is_order_screen', [rt.new_string(order_type_mutated).dup(), rt.new_string('edit')])).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.is_new_order_screen(order_type string) bool {
	mut order_type_mutated := order_type
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController.class()]), 'is_order_screen', [rt.new_string(order_type_mutated).dup(), rt.new_string('new')])).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_table_for_orders() rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'get_table_for_orders', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_table_for_order_meta() rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil.class()]), 'get_table_for_order_meta', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.get_count_for_type(var_order_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_type_mutated := var_order_type
	// unsupported statement: Stmt_Global
	var_order_type_mutated = // unsupported expression: Expr_Cast_String
	mut var_order_count_cache := create_automattic_woocommerce_caches_ordercountcache()
	mut var_count_per_status := var_order_count_cache.get(var_order_type_mutated.dup())
	if rt.is_true(rt.identical(rt.new_null(), var_count_per_status)) {
		if rt.is_true(Class_Automattic_WooCommerce_Utilities_OrderUtil.custom_orders_table_usage_is_enabled()) {
			mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', ['SELECT `status`, COUNT(*) AS `count` FROM ' + (Class_Automattic_WooCommerce_Utilities_OrderUtil.get_table_for_orders()).str() + ' WHERE `type` = %s GROUP BY `status`', var_order_type_mutated.dup()]), rt.get_constant('ARRAY_A')])
			var_count_per_status = rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_column', [var_results.dup(), rt.new_string('count'), rt.new_string('status')])])
		} else {
			var_count_per_status = rt.cast_array(rt.call_function('wp_count_posts', [var_order_type_mutated.dup()]))
		}
		var_count_per_status = rt.call_function('array_merge', [rt.call_function('array_fill_keys', [rt.call_function('array_merge', [rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])]), rt.new_int(0)]), var_count_per_status.dup()])
		var_order_count_cache.set_multiple(var_order_type_mutated.dup(), var_count_per_status.dup())
	}
	return var_count_per_status.dup()
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.remove_status_prefix(status string) string {
	mut status_mutated := status
	if rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(status_mutated).dup(), rt.new_string('wc-')]), rt.new_int(0))) {
		status_mutated = (rt.call_function('substr', [rt.new_string(status_mutated).dup(), rt.new_int(3)])).str()
	}
	return status_mutated
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.uses_new_full_refund_data() bool {
	mut var_db_version := rt.call_function('get_option', [rt.new_string('woocommerce_db_version'), rt.new_null()])
	mut var_uses_old_full_refund_data := rt.call_function('get_option', [rt.new_string('woocommerce_analytics_uses_old_full_refund_data'), rt.new_string('no')])
	if rt.is_true(rt.identical(rt.new_null(), var_db_version)) {
		return (rt.identical(rt.new_string('no'), var_uses_old_full_refund_data)).to_bool()
	}
	return rt.is_true(rt.call_function('version_compare', [var_db_version.dup(), rt.new_string('10.2.0'), rt.new_string('>=')])) && rt.is_true(rt.identical(rt.new_string('no'), var_uses_old_full_refund_data))
}

fn Class_Automattic_WooCommerce_Utilities_OrderUtil.unknown_orders_data_store_in_use() bool {
	return rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Utilities_OrderUtil.custom_orders_table_usage_is_enabled())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

struct Class_Automattic_WooCommerce_Caches_OrderCountCache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_caches_ordercountcache() &Class_Automattic_WooCommerce_Caches_OrderCountCache {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCountCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_order_admin_screen' {
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_admin_screen())
		}
		'custom_orders_table_usage_is_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.custom_orders_table_usage_is_enabled())
		}
		'custom_orders_table_datastore_cache_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.custom_orders_table_datastore_cache_enabled())
		}
		'orders_cache_usage_is_enabled' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.orders_cache_usage_is_enabled())
		}
		'is_custom_order_tables_in_sync' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.is_custom_order_tables_in_sync())
		}
		'get_post_or_object_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_?WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_?WC_Data](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.get_post_or_object_meta(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'init_theorder_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.init_theorder_object(dispatch_arg_0)
		}
		'get_post_or_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Utilities_OrderUtil.get_post_or_order_id(dispatch_arg_0))
		}
		'is_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.is_order(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_type(dispatch_arg_0)
		}
		'get_order_admin_edit_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_admin_edit_url(dispatch_arg_0))
		}
		'get_order_admin_new_url' {
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_OrderUtil.get_order_admin_new_url())
		}
		'is_order_list_table_screen' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.is_order_list_table_screen(dispatch_arg_0))
		}
		'is_order_edit_screen' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.is_order_edit_screen(dispatch_arg_0))
		}
		'is_new_order_screen' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.is_new_order_screen(dispatch_arg_0))
		}
		'get_table_for_orders' {
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.get_table_for_orders()
		}
		'get_table_for_order_meta' {
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.get_table_for_order_meta()
		}
		'get_count_for_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Utilities_OrderUtil.get_count_for_type(dispatch_arg_0)
		}
		'remove_status_prefix' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_OrderUtil.remove_status_prefix(dispatch_arg_0))
		}
		'uses_new_full_refund_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.uses_new_full_refund_data())
		}
		'unknown_orders_data_store_in_use' {
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_OrderUtil.unknown_orders_data_store_in_use())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_utilities_orderutil_php() {
	// unsupported statement: Stmt_Declare
}

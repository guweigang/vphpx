import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil {
	rt.PhpObjectBase
pub mut:
		table_controller rt.PhpVal = rt.new_null()
		data_synchronizer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) init(mut var_table_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController, mut var_data_synchronizer Class_Automattic_WooCommerce_Internal_Utilities_DataSynchronizer) {
	this.table_controller = var_table_controller
	this.data_synchronizer = var_data_synchronizer
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) get_order_admin_screen() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Utilities_Exception', []string{}, create_automattic_woocommerce_internal_utilities_exception(rt.new_string('This function should only be called in admin.'))))
	}
	return (if this.custom_orders_table_usage_is_enabled() && rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_page_screen_id')])) { rt.call_function('wc_get_page_screen_id', [rt.new_string('shop-order')]) } else { rt.new_string('shop_order') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) custom_orders_table_usage_is_enabled() bool {
	return (rt.call_method(this.table_controller, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) is_custom_order_tables_in_sync() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{}))))) {
		return false
	}
	return !(rt.is_true(rt.call_method(this.data_synchronizer, 'has_orders_pending_sync', []rt.PhpVal{})))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) get_post_or_object_meta(mut var_post Class_Automattic_WooCommerce_Internal_Utilities_?WP_Post, mut var_data Class_Automattic_WooCommerce_Internal_Utilities_?WC_Data, key string, single bool) rt.PhpVal {
	if !(var_data).is_null() {
		if rt.is_true(rt.call_function('method_exists', [var_data, rt.new_string("get${var_key}")])) {
			return rt.call_method(var_data, "get${var_key}", []rt.PhpVal{})
		}
		return var_data.get_meta(rt.new_string(key), rt.new_bool(single))
	} else {
		return if !(rt.get_property(var_post, 'ID')).is_null() { rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string(key), rt.new_bool(single)]) } else { rt.new_bool(false) }
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) init_theorder_object(var_post_or_order_object rt.PhpVal) rt.PhpVal {
	mut var_theorder := rt.get_superglobal('theorder')
	if rt.is_true(rt.new_bool(rt.instance_of(var_theorder, 'WC_Order'))) {
		return var_theorder.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_order_object, 'WC_Order'))) {
	var_theorder = var_post_or_order_object
	} else {
	var_theorder = rt.call_function('wc_get_order', [rt.get_property(var_post_or_order_object, 'ID')])
	}
	return var_theorder.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) get_post_or_order_id(var_post_or_order_object rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(var_post_or_order_object.clone().is_long() || var_post_or_order_object.clone().is_double())) {
		return rt.new_int((var_post_or_order_object).to_i64())
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_order_object, 'WC_Order'))) {
		return (rt.call_method(var_post_or_order_object, 'get_id', []rt.PhpVal{})).to_i64()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_post_or_order_object, 'WP_Post'))) {
		return (rt.get_property(var_post_or_order_object, 'ID')).to_i64()
	}
	return 0
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) is_order(var_order_id rt.PhpVal, mut var_types Class_Automattic_WooCommerce_Internal_Utilities_array) bool {
	mut var_order_id_mutated := var_order_id
	var_order_id_mutated = rt.new_int(this.get_post_or_order_id(var_order_id_mutated.clone()))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('order'))
	mut var_order_data_store := iife_result_0
	return (rt.call_function('in_array', [rt.call_method(var_order_data_store, 'get_order_type', [var_order_id_mutated.clone()]), var_types, rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) get_order_type(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
	var_order_id_mutated = rt.new_int(this.get_post_or_order_id(var_order_id_mutated.clone()))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('order'))
	mut var_order_data_store := iife_result_1
	return rt.call_method(var_order_data_store, 'get_order_type', [var_order_id_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) get_table_for_orders() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if this.custom_orders_table_usage_is_enabled() {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore{}
	mut iife_result_2 := iife_temp_2.get_orders_table_name()
	mut var_table_name := iife_result_2
	} else {
	var_table_name = rt.get_property(var_wpdb, 'posts')
	}
	return var_table_name.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) get_table_for_order_meta() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if this.custom_orders_table_usage_is_enabled() {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore{}
	mut iife_result_3 := iife_temp_3.get_meta_table_name()
	mut var_table_name := iife_result_3
	} else {
	var_table_name = rt.get_property(var_wpdb, 'postmeta')
	}
	return var_table_name.clone()
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_cotmigrationutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil{
		PhpObjectBase: rt.PhpObjectBase{}
		table_controller: rt.new_null()
		data_synchronizer: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_DataSynchronizer](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_admin_screen' {
			return rt.new_string(this.get_order_admin_screen())
		}
		'custom_orders_table_usage_is_enabled' {
			return rt.new_bool(this.custom_orders_table_usage_is_enabled())
		}
		'is_custom_order_tables_in_sync' {
			return rt.new_bool(this.is_custom_order_tables_in_sync())
		}
		'get_post_or_object_meta' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?WC_Data](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_post_or_object_meta(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'init_theorder_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.init_theorder_object(dispatch_arg_0)
		}
		'get_post_or_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_post_or_order_id(dispatch_arg_0))
		}
		'is_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.is_order(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_order_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_type(dispatch_arg_0)
		}
		'get_table_for_orders' {
			return this.get_table_for_orders()
		}
		'get_table_for_order_meta' {
			return this.get_table_for_order_meta()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_controller' { return this.table_controller }
		'data_synchronizer' { return this.data_synchronizer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_COTMigrationUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_controller' { this.table_controller = val; return true }
		'data_synchronizer' { this.data_synchronizer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
}

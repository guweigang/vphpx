import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) get_cache_group() string {
	return 'orders_meta'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) get_table_name() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}; return temp.get_meta_table_name() }()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) get_object_id_field() string {
	return 'order_id'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) delete_meta(var_object rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_successful := this.Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore.delete_meta(var_object.dup(), var_meta.dup())
	if rt.is_true(var_successful) {
		this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }])))
	}
	return (var_successful).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) add_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_insert_id := this.Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore.add_meta(var_object.dup(), var_meta.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }])))
	}
	return var_insert_id.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) update_meta(var_object rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_is_successful := this.Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore.update_meta(var_object.dup(), var_meta.dup())
	if rt.is_true(var_is_successful) {
		this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }])))
	}
	return (var_is_successful).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) get_meta_data_for_object_ids(mut var_object_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_object_ids_mutated := var_object_ids
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_datastore_cache_enabled() }())))) {
		return this.Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore.get_meta_data_for_object_ids(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_object_ids_mutated))
	}
	mut var_meta_data := this.get_meta_data_for_object_ids_from_cache(mut var_object_ids_mutated)
	var_object_ids_mutated = rt.call_function('array_diff', [var_object_ids_mutated.dup(), rt.func_array_keys(var_meta_data.dup())])
	if !rt.is_true(var_object_ids_mutated) {
		return var_meta_data.dup()
	}
	mut var_db_meta_data := this.Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore.get_meta_data_for_object_ids(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_object_ids_mutated))
	this.set_meta_data_for_objects_in_cache(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_db_meta_data))
	return rt.add(var_db_meta_data, var_meta_data)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) get_meta_data_for_object_ids_from_cache(mut var_object_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_object_ids_mutated := var_object_ids
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	mut var_meta_data := rt.call_method(var_cache_engine, 'get_cached_objects', [var_object_ids_mutated.dup(), this.get_cache_group()])
	return rt.call_function('array_filter', [var_meta_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) set_meta_data_for_objects_in_cache(mut var_meta_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_meta_data_mutated := var_meta_data
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	rt.call_method(var_cache_engine, 'cache_objects', [var_meta_data_mutated.dup(), rt.new_int(0), this.get_cache_group()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) clear_cached_data(mut var_object_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_object_ids_mutated := var_object_ids
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_datastore_cache_enabled() }())))) {
		return rt.call_function('array_fill_keys', [var_object_ids_mutated.dup(), rt.new_bool(true)])
	}
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	mut var_return_values := rt.new_array()
	{
		mut iter_1 := var_object_ids_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_object_id := item_1.val
			var_return_values.array_set(var_object_id, rt.call_method(var_cache_engine, 'delete_cached_object', [var_object_id.dup(), this.get_cache_group()]))
		}
	}
	return var_return_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) clear_all_cached_data() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_datastore_cache_enabled() }())))) {
		return true
	}
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	return (rt.call_method(var_cache_engine, 'delete_cache_group', [this.get_cache_group()])).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastoremeta() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_custommetadatastore() &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore{
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

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_cache_group' {
			return rt.new_string(this.get_cache_group())
		}
		'get_table_name' {
			return this.get_table_name()
		}
		'get_object_id_field' {
			return rt.new_string(this.get_object_id_field())
		}
		'delete_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.delete_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'add_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'get_meta_data_for_object_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_meta_data_for_object_ids(mut dispatch_arg_0)
		}
		'get_meta_data_for_object_ids_from_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_meta_data_for_object_ids_from_cache(mut dispatch_arg_0)
		}
		'set_meta_data_for_objects_in_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_meta_data_for_objects_in_cache(mut dispatch_arg_0)
			return rt.new_null()
		}
		'clear_cached_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.clear_cached_data(mut dispatch_arg_0)
		}
		'clear_all_cached_data' {
			return rt.new_bool(this.clear_all_cached_data())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_orderstabledatastoremeta_php() {
}

import rt

fn wc_add_order_item(var_order_id_arg rt.PhpVal, var_item_array_arg rt.PhpVal) bool {
	mut var_order_id := var_order_id_arg
	mut var_item_array := var_item_array_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_data_store := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_item := rt.new_null()
	var_order_id = rt.call_function('absint', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return false
	}
	var_defaults = {
		'order_item_name': ''
		'order_item_type': 'line_item'
	}
	var_item_array = rt.call_function('wp_parse_args', [var_item_array.clone(),
		rt.create_array_from_native_map(var_defaults)])
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('order-item'))
	var_data_store = iife_result_0
	var_item_id = rt.call_method(var_data_store, 'add_order_item', [
		var_order_id.clone(), var_item_array.clone()])
	mut iife_temp_1 := Class_WC_Order_Factory{}
	mut iife_result_1 := iife_temp_1.get_order_item(var_item_id.clone())
	var_item = iife_result_1
	rt.call_function('do_action', [rt.new_string('woocommerce_new_order_item'),
		var_item_id.clone(), var_item.clone(), var_order_id.clone()])
	return var_item_id.to_bool()
}

fn wc_update_order_item(var_item_id rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_data_store := rt.new_null()
	mut var_update := rt.new_null()
	mut iife_temp_2 := Class_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('order-item'))
	var_data_store = iife_result_2
	var_update = rt.call_method(var_data_store, 'update_order_item', [
		var_item_id.clone(), var_args.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_update)) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order_item'),
		var_item_id.clone(), var_args.clone()])
	return true
}

fn wc_delete_order_item(var_item_id_arg rt.PhpVal) bool {
	mut var_item_id := var_item_id_arg
	mut var_data_store := rt.new_null()
	var_item_id = rt.call_function('absint', [var_item_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item_id)))) {
		return false
	}
	mut iife_temp_3 := Class_WC_Data_Store{}
	mut iife_result_3 := iife_temp_3.load(rt.new_string('order-item'))
	var_data_store = iife_result_3
	rt.call_function('do_action', [rt.new_string('woocommerce_before_delete_order_item'),
		var_item_id.clone()])
	rt.call_method(var_data_store, 'delete_order_item', [var_item_id.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_order_item'),
		var_item_id.clone()])
	return true
}

fn wc_update_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) bool {
	mut var_prev_value := prev_value
	mut var_data_store := rt.new_null()
	mut iife_temp_4 := Class_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('order-item'))
	var_data_store = iife_result_4
	if rt.is_true(rt.call_method(var_data_store, 'update_metadata', [
		var_item_id.clone(), var_meta_key.clone(), var_meta_value.clone(),
		rt.new_string(prev_value)]))
	{
		mut iife_temp_5 := Class_WC_Cache_Helper{}
		mut iife_result_5 := iife_temp_5.invalidate_cache_group(rt.new_string('object_' +
			var_item_id.str()))
		return true
	}
	return false
}

fn wc_add_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) i64 {
	mut var_unique := unique
	mut var_data_store := rt.new_null()
	mut var_meta_id := rt.new_null()
	mut iife_temp_6 := Class_WC_Data_Store{}
	mut iife_result_6 := iife_temp_6.load(rt.new_string('order-item'))
	var_data_store = iife_result_6
	var_meta_id = rt.call_method(var_data_store, 'add_metadata', [
		var_item_id.clone(), var_meta_key.clone(), var_meta_value.clone(),
		rt.new_bool(unique)])
	if rt.is_true(var_meta_id) {
		mut iife_temp_7 := Class_WC_Cache_Helper{}
		mut iife_result_7 := iife_temp_7.invalidate_cache_group(rt.new_string('object_' +
			var_item_id.str()))
		return var_meta_id.to_i64()
	}
	return 0
}

fn wc_delete_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string, delete_all bool) bool {
	mut var_meta_value := meta_value
	mut var_delete_all := delete_all
	mut var_data_store := rt.new_null()
	mut iife_temp_8 := Class_WC_Data_Store{}
	mut iife_result_8 := iife_temp_8.load(rt.new_string('order-item'))
	var_data_store = iife_result_8
	if rt.is_true(rt.call_method(var_data_store, 'delete_metadata', [
		var_item_id.clone(), var_meta_key.clone(), rt.new_string(meta_value),
		rt.new_bool(delete_all)]))
	{
		mut iife_temp_9 := Class_WC_Cache_Helper{}
		mut iife_result_9 := iife_temp_9.invalidate_cache_group(rt.new_string('object_' +
			var_item_id.str()))
		return true
	}
	return false
}

fn wc_get_order_item_meta(var_item_id rt.PhpVal, var_key rt.PhpVal, single bool) rt.PhpVal {
	mut var_single := single
	mut var_data_store := rt.new_null()
	mut iife_temp_10 := Class_WC_Data_Store{}
	mut iife_result_10 := iife_temp_10.load(rt.new_string('order-item'))
	var_data_store = iife_result_10
	return rt.call_method(var_data_store, 'get_metadata', [var_item_id.clone(),
		var_key.clone(), rt.new_bool(single)])
}

fn wc_get_order_id_by_order_item_id(var_item_id rt.PhpVal) rt.PhpVal {
	mut var_data_store := rt.new_null()
	mut iife_temp_11 := Class_WC_Data_Store{}
	mut iife_result_11 := iife_temp_11.load(rt.new_string('order-item'))
	var_data_store = iife_result_11
	return rt.call_method(var_data_store, 'get_order_id_by_order_item_id', [
		var_item_id.clone()])
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_factory(_args ...rt.PhpVal) &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

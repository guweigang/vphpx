import rt

fn wc_add_order_item(var_order_id rt.PhpVal, var_item_array rt.PhpVal) bool {
	var_order_id = rt.call_function('absint', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return false
	}
	mut var_defaults := { 'order_item_name': '', 'order_item_type': 'line_item' }
	var_item_array = rt.call_function('wp_parse_args', [var_item_array.dup(), var_defaults.dup()])
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	mut var_item_id := rt.call_method(var_data_store, 'add_order_item', [var_order_id.dup(), var_item_array.dup()])
	mut var_item := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Order_Factory{}; return temp.get_order_item(arg_0) }(var_item_id.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_new_order_item'), var_item_id.dup(), var_item.dup(), var_order_id.dup()])
	return (var_item_id).to_bool()
}

fn wc_update_order_item(var_item_id rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	mut var_update := rt.call_method(var_data_store, 'update_order_item', [var_item_id.dup(), var_args.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_update)) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order_item'), var_item_id.dup(), var_args.dup()])
	return true
}

fn wc_delete_order_item(var_item_id rt.PhpVal) bool {
	var_item_id = rt.call_function('absint', [var_item_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item_id)))) {
		return false
	}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_delete_order_item'), var_item_id.dup()])
	rt.call_method(var_data_store, 'delete_order_item', [var_item_id.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_order_item'), var_item_id.dup()])
	return true
}

fn wc_update_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) bool {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	if rt.is_true(rt.call_method(var_data_store, 'update_metadata', [var_item_id.dup(), var_meta_key.dup(), var_meta_value.dup(), rt.new_string(prev_value)])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.invalidate_cache_group(arg_0) }(rt.new_string('object_' + (var_item_id).str()))
		return true
	}
	return false
}

fn wc_add_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) i64 {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	mut var_meta_id := rt.call_method(var_data_store, 'add_metadata', [var_item_id.dup(), var_meta_key.dup(), var_meta_value.dup(), rt.new_bool(unique)])
	if rt.is_true(var_meta_id) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.invalidate_cache_group(arg_0) }(rt.new_string('object_' + (var_item_id).str()))
		return (var_meta_id).to_i64()
	}
	return 0
}

fn wc_delete_order_item_meta(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string, delete_all bool) bool {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	if rt.is_true(rt.call_method(var_data_store, 'delete_metadata', [var_item_id.dup(), var_meta_key.dup(), rt.new_string(meta_value), rt.new_bool(delete_all)])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.invalidate_cache_group(arg_0) }(rt.new_string('object_' + (var_item_id).str()))
		return true
	}
	return false
}

fn wc_get_order_item_meta(var_item_id rt.PhpVal, var_key rt.PhpVal, single bool) rt.PhpVal {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	return rt.call_method(var_data_store, 'get_metadata', [var_item_id.dup(), var_key.dup(), rt.new_bool(single)])
}

fn wc_get_order_id_by_order_item_id(var_item_id rt.PhpVal) rt.PhpVal {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-item'))
	return rt.call_method(var_data_store, 'get_order_id_by_order_item_id', [var_item_id.dup()])
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

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_factory() &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_order_item_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

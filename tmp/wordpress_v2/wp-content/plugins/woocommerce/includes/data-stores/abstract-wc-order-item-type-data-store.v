import rt

struct Class_Abstract_WC_Order_Item_Type_Data_Store {
	rt.PhpObjectBase
pub mut:
	meta_type                rt.PhpVal = rt.new_string('order_item')
	object_id_field_for_meta rt.PhpVal = rt.new_string('order_item_id')
	cogs_is_enabled          rt.PhpVal = rt.new_null()
	order_item_data_store    rt.PhpVal = rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) construct() {
	this.cogs_is_enabled = this.cogs_is_enabled()
	if rt.is_true(this.cogs_is_enabled) {
		mut iife_temp_0 := Class_WC_Data_Store{}
		mut iife_result_0 := iife_temp_0.load(rt.new_string('order-item'))
		this.order_item_data_store = iife_result_0
	}
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) create(var_item rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items'),
		rt.create_array([
			rt.ArrayItem{ key: 'order_item_name', val: rt.call_method(var_item, 'get_name',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'order_item_type', val: rt.call_method(var_item, 'get_type',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_item, 'get_order_id',
				[]rt.PhpVal{}) },
		]),
	])
	rt.call_method(var_item, 'set_id', [rt.get_property(var_wpdb, 'insert_id')])
	this.save_item_data(var_item.clone())
	rt.call_method(var_item, 'save_meta_data', []rt.PhpVal{})
	if rt.is_true(this.cogs_is_enabled)
		&& rt.is_true(rt.call_method(var_item, 'has_cogs', []rt.PhpVal{})) {
		this.save_cogs_data(mut rt.cast_object_ptr[Class_WC_Order_Item](var_item))
	}
	rt.call_method(var_item, 'apply_changes', []rt.PhpVal{})
	this.clear_cache(var_item.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_new_order_item'),
		rt.call_method(var_item, 'get_id', []rt.PhpVal{}), var_item.clone(),
		rt.call_method(var_item, 'get_order_id', []rt.PhpVal{})])
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) update(var_item rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_changes := rt.call_method(var_item, 'get_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('array_intersect', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'order_id' }]),
		rt.func_array_keys(var_changes.clone()),
	]))
	{
		rt.call_method(var_wpdb, 'update', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items'),
			rt.create_array([
				rt.ArrayItem{ key: 'order_item_name', val: rt.call_method(var_item, 'get_name',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'order_item_type', val: rt.call_method(var_item, 'get_type',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_item, 'get_order_id',
					[]rt.PhpVal{}) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'order_item_id', val: rt.call_method(var_item, 'get_id',
					[]rt.PhpVal{}) },
			]),
		])
	}
	this.save_item_data(var_item.clone())
	rt.call_method(var_item, 'save_meta_data', []rt.PhpVal{})
	if rt.is_true(this.cogs_is_enabled)
		&& rt.is_true(rt.call_method(var_item, 'has_cogs', []rt.PhpVal{})) {
		this.save_cogs_data(mut rt.cast_object_ptr[Class_WC_Order_Item](var_item))
	}
	rt.call_method(var_item, 'apply_changes', []rt.PhpVal{})
	this.clear_cache(var_item.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order_item'),
		rt.call_method(var_item, 'get_id', []rt.PhpVal{}), var_item.clone(),
		rt.call_method(var_item, 'get_order_id', []rt.PhpVal{})])
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) delete(var_item rt.PhpVal, var_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_method(var_item, 'get_id', []rt.PhpVal{})) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_delete_order_item'),
			rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
		])
		rt.call_method(var_wpdb, 'delete', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items'),
			rt.create_array([
				rt.ArrayItem{ key: 'order_item_id', val: rt.call_method(var_item, 'get_id',
					[]rt.PhpVal{}) },
			]),
		])
		rt.call_method(var_wpdb, 'delete', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_itemmeta'),
			rt.create_array([
				rt.ArrayItem{ key: 'order_item_id', val: rt.call_method(var_item, 'get_id',
					[]rt.PhpVal{}) },
			]),
		])
		rt.call_function('do_action', [rt.new_string('woocommerce_delete_order_item'),
			rt.call_method(var_item, 'get_id', []rt.PhpVal{})])
		this.clear_cache(var_item.clone())
	}
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) read(var_item rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_item, 'set_defaults', []rt.PhpVal{})
	mut var_data := rt.call_function('wp_cache_get', [
		rt.new_string('item-' + (rt.call_method(var_item, 'get_id', []rt.PhpVal{})).str()),
		rt.new_string('order-items'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
		var_data = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT order_id, order_item_name FROM '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('woocommerce_order_items WHERE order_item_id = %d LIMIT 1;')),
				rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_cache_set', [
			rt.new_string('item-' + (rt.call_method(var_item, 'get_id', []rt.PhpVal{})).str()),
			var_data.clone(),
			rt.new_string('order-items'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid order item.'),
			rt.new_string('woocommerce'),
		]))))
	}
	rt.call_method(var_item, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'order_id', val: rt.get_property(var_data, 'order_id') },
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_data, 'order_item_name') },
		]),
	])
	rt.call_method(var_item, 'read_meta_data', []rt.PhpVal{})
	if rt.is_true(this.cogs_is_enabled)
		&& rt.is_true(rt.call_method(var_item, 'has_cogs', []rt.PhpVal{})) {
		mut var_cogs_metadata := rt.call_method(this.order_item_data_store, 'get_metadata', [
			rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
			rt.new_string('_cogs_value'),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_cogs_metadata))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cogs_metadata)))) {
			mut var_cogs_value := rt.new_float(var_cogs_metadata.to_f64())
			var_cogs_value = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_load_order_item_cogs_value'),
				var_cogs_value.clone(),
				var_item.clone(),
			])
			rt.call_method(var_item, 'set_cogs_value', [
				rt.new_float(var_cogs_value.to_f64()),
			])
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) save_item_data(var_item rt.PhpVal) {
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) clear_cache(var_item rt.PhpVal) {
	rt.call_function('wp_cache_delete', [
		rt.new_string('item-' + (rt.call_method(var_item, 'get_id', []rt.PhpVal{})).str()),
		rt.new_string('order-items'),
	])
	rt.call_function('wp_cache_delete', [
		rt.new_string('order-items-' +
			(rt.call_method(var_item, 'get_order_id', []rt.PhpVal{})).str()),
		rt.new_string('orders'),
	])
	rt.call_function('wp_cache_delete', [
		rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
		rt.new_string((this.meta_type).str() + '_meta'),
	])
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) save_cogs_data(mut var_item Class_WC_Order_Item) {
	mut var_cogs_value := var_item.get_cogs_value()
	var_cogs_value = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_save_order_item_cogs_value'),
		var_cogs_value.clone(),
		var_item,
	])
	if rt.is_true(rt.new_bool(var_cogs_value.clone().is_null())) {
		return
	}
	var_cogs_value = rt.new_float(var_cogs_value.to_f64())
	if rt.is_true(rt.identical(rt.new_float(0), var_cogs_value)) {
		rt.call_method(this.order_item_data_store, 'delete_metadata', [
			var_item.get_id(), rt.new_string('_cogs_value'), rt.new_string('')])
	} else {
		rt.call_method(this.order_item_data_store, 'update_metadata', [
			var_item.get_id(), rt.new_string('_cogs_value'), var_cogs_value.clone()])
	}
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_abstract_wc_order_item_type_data_store() &Class_Abstract_WC_Order_Item_Type_Data_Store {
	mut obj := &Class_Abstract_WC_Order_Item_Type_Data_Store{
		PhpObjectBase:            rt.PhpObjectBase{}
		meta_type:                rt.new_string('order_item')
		object_id_field_for_meta: rt.new_string('order_item_id')
		cogs_is_enabled:          rt.new_null()
		order_item_data_store:    rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'save_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_item_data(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'save_cogs_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.save_cogs_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Abstract_WC_Order_Item_Type_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_type' { return this.meta_type }
		'object_id_field_for_meta' { return this.object_id_field_for_meta }
		'cogs_is_enabled' { return this.cogs_is_enabled }
		'order_item_data_store' { return this.order_item_data_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_type' {
			this.meta_type = val
			return true
		}
		'object_id_field_for_meta' {
			this.object_id_field_for_meta = val
			return true
		}
		'cogs_is_enabled' {
			this.cogs_is_enabled = val
			return true
		}
		'order_item_data_store' {
			this.order_item_data_store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}

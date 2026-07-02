import rt

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

fn Class_WC_Order_Factory.get_order(order_id bool) bool {
	mut order_id_mutated := order_id
	order_id_mutated =
		(Class_WC_Order_Factory.get_order_id(rt.new_bool(order_id_mutated))).to_bool()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(order_id_mutated))))) {
		return false
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.orders_cache_usage_is_enabled()
	mut var_use_orders_cache := iife_result_0
	if rt.is_true(var_use_orders_cache) {
		mut var_order_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()])
		mut var_order := rt.call_method(var_order_cache, 'get', [
			rt.new_bool(order_id_mutated).clone()])
		if !(var_order.clone().is_null()) {
			return (if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_order, 'get_id',
				[]rt.PhpVal{})))
			{
				rt.new_bool(false)
			} else {
				var_order
			}).to_bool()
		}
	}
	mut var_classname :=
		Class_WC_Order_Factory.get_class_name_for_order_id(rt.new_bool(order_id_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_classname)))) {
		return false
	}
	var_order = rt.create_object_dynamically(var_classname, [
		rt.new_bool(order_id_mutated).clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_use_orders_cache)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Abstract_Legacy_Order'))) {
		rt.call_method(var_order_cache, 'set', [var_order.clone(),
			rt.new_bool(order_id_mutated).clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_order.to_bool()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('wc_caught_exception', [var_e.clone(),
			rt.new_string(@FN), rt.create_array([
				rt.ArrayItem{ key: none, val: order_id_mutated },
			])])
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_function('sprintf', [rt.new_string('Exception caught in %s: %s'),
				rt.new_string(@FN), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'get_order' },
				rt.ArrayItem{ key: 'order_id', val: order_id_mutated },
				rt.ArrayItem{ key: 'exception', val: var_e }]),
		])
		return false
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
	return false
}

fn Class_WC_Order_Factory.get_orders(var_order_ids rt.PhpVal, skip_invalid bool) rt.PhpVal {
	mut var_order_ids_mutated := var_order_ids
	if !rt.is_true(var_order_ids_mutated) {
		return rt.new_array()
	}
	var_order_ids_mutated = rt.call_function('array_filter', [
		rt.call_function('array_map', [
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_order_id' }]),
			var_order_ids_mutated.clone(),
		]),
	])
	mut var_result := rt.new_array()
	mut var_original_order_sort := var_order_ids_mutated.clone()
	mut var_order_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()])
	mut var_already_cached_orders := rt.new_array()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.orders_cache_usage_is_enabled()
	mut var_use_orders_cache := iife_result_1
	if rt.is_true(var_use_orders_cache) {
		mut var_uncached_order_ids := rt.new_array()
		mut iter_1 := var_order_ids_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_id := item_1.val
			mut var_cached_order := rt.call_method(var_order_cache, 'get', [
				rt.call_function('absint', [var_order_id.clone()]),
			])
			if rt.is_true(rt.new_bool(rt.instance_of(var_cached_order, 'WC_Abstract_Legacy_Order'))) {
				var_already_cached_orders.array_set(var_order_id, var_cached_order.clone())
			} else {
				var_uncached_order_ids << var_order_id.clone()
			}
		}
		var_order_ids_mutated = var_uncached_order_ids.clone()
	}
	if !(!rt.is_true(var_order_ids_mutated)) {
		rt.call_function('_prime_post_caches', [var_order_ids_mutated.clone(),
			rt.new_bool(false), rt.new_bool(true)])
	}
	mut var_order_list_by_class := rt.new_array()
	mut var_order_id_classnames :=
		Class_WC_Order_Factory.get_class_names_for_order_ids(var_order_ids_mutated.clone())
	mut iter_2 := var_order_id_classnames.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_classname := item_2.val
		mut var_order_id := item_2.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_classname)))) && !var_skip_invalid {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Could not find classname for order ID %d'),
					rt.new_string('woocommerce'),
				]),
				var_order_id.clone(),
			]))))
		}
		if !(var_order_list_by_class.array_isset(var_classname)) {
			var_order_list_by_class.array_set(var_classname, rt.new_array())
		}
		mut var_obj := rt.create_object_dynamically(var_classname, []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_obj, 'set_defaults', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_obj, 'set_id', [var_order_id.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		var_order_list_by_class.array_get_mut(var_classname).array_set(var_order_id,
			var_obj.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Exception') {
			mut var_e := var_e_2.clone()
			rt.call_function('wc_caught_exception', [var_e.clone(),
				rt.new_string(@FN), rt.create_array([
					rt.ArrayItem{ key: none, val: var_order_id },
				])])
			if !var_skip_invalid {
				rt.throw_exception(var_e)
			}
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	}
	mut iter_3 := var_order_list_by_class.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_order_list := item_3.val
		mut var_classname := item_3.key
		mut var_data_store := rt.call_method(rt.create_object_dynamically(var_classname,
			[]rt.PhpVal{}), 'get_data_store', []rt.PhpVal{})
		rt.call_method(var_data_store, 'read_multiple', [var_order_list.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		unsafe {
			goto end_label_3
		}
		catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Exception') {
			mut var_e := var_e_3.clone()
			rt.call_function('wc_caught_exception', [var_e.clone(),
				rt.new_string(@FN), var_order_ids_mutated.clone()])
			if !var_skip_invalid {
				rt.throw_exception(var_e)
			}
			unsafe {
				goto end_label_3
			}
		} else {
			rt.throw_exception(var_e_3)
			unsafe {
				goto end_label_3
			}
		}

		end_label_3:
		mut iter_4 := var_order_list.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_order := item_4.val
			var_result.array_set(rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
				var_order.clone())
		}
	}
	if rt.is_true(var_use_orders_cache) {
		mut iter_5 := var_result.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_order := item_5.val
			mut var_order_id := item_5.key
			rt.call_method(var_order_cache, 'set', [var_order.clone(),
				rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
		}
		var_result = rt.call_function('array_replace', [var_result.clone(),
			var_already_cached_orders.clone()])
	}
	var_result = rt.call_function('array_values', [
		rt.call_function('array_replace', [
			rt.call_function('array_flip', [var_original_order_sort.clone()]),
			var_result.clone(),
		]),
	])
	return var_result.clone()
}

fn Class_WC_Order_Factory.get_order_item(item_id i64) bool {
	if rt.is_true(rt.new_bool(rt.new_int(item_id).is_long() || rt.new_int(item_id).is_double())) {
		mut iife_temp_2 := Class_WC_Data_Store{}
		mut iife_result_2 := iife_temp_2.load(rt.new_string('order-item'))
		mut var_item_type := rt.call_method(iife_result_2, 'get_order_item_type', [
			rt.new_int(item_id),
		])
		mut var_id := rt.new_int(item_id)
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(item_id), 'WC_Order_Item'))) {
		var_item_type = rt.call_method(rt.new_int(item_id), 'get_type', []rt.PhpVal{})
		var_id = rt.call_method(rt.new_int(item_id), 'get_id', []rt.PhpVal{})
	} else if rt.new_int(item_id).is_object()
		&& !(!rt.is_true(rt.get_property(rt.new_int(item_id), 'order_item_type'))) {
		var_id = rt.get_property(rt.new_int(item_id), 'order_item_id')
		var_item_type = rt.get_property(rt.new_int(item_id), 'order_item_type')
	} else {
		var_item_type = rt.new_bool(false)
		var_id = rt.new_bool(false)
	}
	if rt.is_true(var_id) && rt.is_true(var_item_type) {
		mut var_classname := rt.new_bool(false)
		mut switch_val_1 := var_item_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('line_item')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
			var_classname = rt.new_string('WC_Order_Item_Product')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon'))) {
			var_classname = rt.new_string('WC_Order_Item_Coupon')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fee'))) {
			var_classname = rt.new_string('WC_Order_Item_Fee')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping'))) {
			var_classname = rt.new_string('WC_Order_Item_Shipping')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax'))) {
			var_classname = rt.new_string('WC_Order_Item_Tax')
		}
		var_classname = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_order_item_classname'),
			var_classname.clone(),
			var_item_type.clone(),
			var_id.clone(),
		])
		if rt.is_true(var_classname)
			&& rt.is_true(rt.call_function('class_exists', [var_classname.clone()])) {
			return (rt.create_object_dynamically(var_classname, [
				var_id.clone()])).to_bool()
			unsafe {
				goto end_label_4
			}
			catch_label_4:
			mut var_e_4 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_4, 'Exception') {
				mut var_e := var_e_4.clone()
				return false
				unsafe {
					goto end_label_4
				}
			} else {
				rt.throw_exception(var_e_4)
				unsafe {
					goto end_label_4
				}
			}

			end_label_4:
		}
	}
	return false
}

fn Class_WC_Order_Factory.get_order_id(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	if rt.is_true(rt.identical(rt.new_bool(false), var_order_mutated)) {
		return (Class_WC_Order_Factory.get_global_order_id()).to_bool()
	} else if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long()
		|| var_order_mutated.clone().is_double()))
	{
		return var_order_mutated.to_bool()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Abstract_Order'))) {
		return (rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).to_bool()
	} else if !(!rt.is_true(rt.get_property(var_order_mutated, 'ID'))) {
		return (rt.get_property(var_order_mutated, 'ID')).to_bool()
	} else {
		return false
	}
	return false
}

fn Class_WC_Order_Factory.get_global_order_id() bool {
	mut var_post := rt.new_null()
	mut var_theorder := rt.new_null()
	if !(!var_theorder.is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theorder, 'WC_Abstract_Order')))))) {
		if !(!var_post.is_null())
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shop_order'), rt.get_property(var_post, 'post_type'))))) {
			return false
		} else {
			mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
			mut iife_result_3 := iife_temp_3.init_theorder_object(var_post.clone())
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_theorder, 'WC_Order'))) {
		return (rt.call_method(var_theorder, 'get_id', []rt.PhpVal{})).to_bool()
	} else if rt.is_true(rt.call_function('is_a', [var_post.clone(), rt.new_string('WP_Post')]))
		&& rt.is_true(rt.identical(rt.new_string('shop_order'), rt.call_function('get_post_type', [var_post.clone()]))) {
		return (rt.call_function('absint', [rt.get_property(var_post, 'ID')])).to_bool()
	} else {
		return false
	}
	return false
}

fn Class_WC_Order_Factory.get_class_names_for_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_order_ids_mutated := var_order_ids
	mut iife_temp_4 := Class_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('order'))
	mut var_order_data_store := iife_result_4
	if rt.is_true(rt.call_method(var_order_data_store, 'has_callable', [
		rt.new_string('get_orders_type'),
	]))
	{
		mut var_order_types := rt.call_method(var_order_data_store, 'get_orders_type', [
			var_order_ids_mutated.clone(),
		])
	} else {
		var_order_types = rt.new_array()
		mut iter_6 := var_order_ids_mutated.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_order_id := item_6.val
			var_order_types.array_set(var_order_id, rt.call_method(var_order_data_store,
				'get_order_type', [var_order_id.clone()]))
		}
	}
	mut var_order_class_names := rt.new_array()
	mut iter_7 := var_order_types.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_order_type := item_7.val
		mut var_order_id := item_7.key
		mut var_order_type_data := rt.call_function('wc_get_order_type', [
			var_order_type.clone()])
		if rt.is_true(var_order_type_data) {
			var_order_class_names.array_set(var_order_id,
				var_order_type_data.array_get(rt.new_string('class_name')))
		} else {
			var_order_class_names.array_set(var_order_id, false)
		}
		var_order_class_names.array_set(var_order_id, rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_class'),
			var_order_class_names.array_get(var_order_id),
			var_order_type.clone(),
			var_order_id.clone(),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
			var_order_class_names.array_get(var_order_id),
		])))))
		{
			var_order_class_names.array_set(var_order_id, false)
		}
	}
	return var_order_class_names.clone()
}

fn Class_WC_Order_Factory.get_class_name_for_order_id(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
	mut var_classname := Class_WC_Order_Factory.get_class_names_for_order_ids(rt.create_array([
		rt.ArrayItem{ key: none, val: var_order_id_mutated },
	]))
	return if !(var_classname.array_get(var_order_id_mutated)).is_null() {
		var_classname.array_get(var_order_id_mutated)
	} else {
		rt.new_bool(false)
	}
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
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

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_order_factory(_args ...rt.PhpVal) &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_WC_Order_Factory.get_order(dispatch_arg_0))
		}
		'get_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Order_Factory.get_orders(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_item' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Order_Factory.get_order_item(dispatch_arg_0))
		}
		'get_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Order_Factory.get_order_id(dispatch_arg_0))
		}
		'get_global_order_id' {
			return rt.new_bool(Class_WC_Order_Factory.get_global_order_id())
		}
		'get_class_names_for_order_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Order_Factory.get_class_names_for_order_ids(dispatch_arg_0)
		}
		'get_class_name_for_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Order_Factory.get_class_name_for_order_id(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Order_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_factory()
		return rt.new_object('WC_Order_Factory', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_OrderUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_orderutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_OrderUtil', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

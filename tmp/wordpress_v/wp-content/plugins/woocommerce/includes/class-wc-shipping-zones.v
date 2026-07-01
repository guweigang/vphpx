import rt
import crypto.md5

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

fn Class_WC_Shipping_Zones.get_zones(context string) rt.PhpVal {
	mut var_zone_objects := Class_WC_Shipping_Zones.get_shipping_zones()
	mut var_zones := rt.new_array()
	{
		mut iter_1 := var_zone_objects.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_zone_object := item_1.val
			var_zones.array_set(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{}), rt.call_method(var_zone_object, 'get_data', []rt.PhpVal{}))
			var_zones.array_get_mut(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{})).array_set('zone_id', rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{}))
			var_zones.array_get_mut(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{})).array_set('formatted_zone_location', rt.call_method(var_zone_object, 'get_formatted_location', []rt.PhpVal{}))
			var_zones.array_get_mut(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{})).array_set('shipping_methods', rt.call_method(var_zone_object, 'get_shipping_methods', [rt.new_bool(false), rt.new_string(context)]))
		}
	}
	return var_zones.dup()
}

fn Class_WC_Shipping_Zones.get_shipping_zones(mut var_zone_ids Class_?array) rt.PhpVal {
	mut var_zone_ids_mutated := var_zone_ids
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('shipping-zone'))
	if rt.is_true(rt.identical(rt.new_null(), var_zone_ids_mutated)) {
		mut var_raw_zones := rt.call_method(var_data_store, 'get_zones', []rt.PhpVal{})
		var_zone_ids_mutated = rt.call_function('array_column', [var_raw_zones.dup(), rt.new_string('zone_id')])
	} else if !rt.is_true(var_zone_ids_mutated) {
		return rt.new_array()
	}
	mut var_zones := rt.new_array()
	{
		mut iter_1 := var_zone_ids_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_zone_id := item_1.val
			mut var_zone := create_wc_shipping_zone()
			var_zone.set_object_read(rt.new_bool(false))
			var_zone.set_id(var_zone_id.dup())
			var_zones.array_set(var_zone_id, var_zone.dup())
		}
	}
	if !(!rt.is_true(var_zones)) {
		rt.call_method(var_data_store, 'read_multiple', [var_zones.dup()])
	}
	return var_zones.dup()
}

fn Class_WC_Shipping_Zones.get_zone(var_zone_id rt.PhpVal) rt.PhpVal {
	mut var_zone_id_mutated := var_zone_id
	return Class_WC_Shipping_Zones.get_zone_by('zone_id', (var_zone_id_mutated).to_i64())
}

fn Class_WC_Shipping_Zones.get_zone_by(by string, id i64) bool {
	mut var_zone_id := rt.new_bool(rt.new_bool(false))
	mut switch_val_1 := rt.new_string(by)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('zone_id'))) {
		var_zone_id = rt.new_int(rt.new_int(id))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('instance_id'))) {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('shipping-zone'))
		var_zone_id = rt.call_method(var_data_store, 'get_zone_id_by_instance_id', [rt.new_int(id)])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (create_wc_shipping_zone(var_zone_id.dup())).to_bool()
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.dup()
			return false
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	return false
}

fn Class_WC_Shipping_Zones.get_shipping_method(var_instance_id rt.PhpVal) bool {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('shipping-zone'))
	mut var_raw_shipping_method := rt.call_method(var_data_store, 'get_method', [var_instance_id.dup()])
	mut var_wc_shipping := fn () rt.PhpVal { mut temp := Class_WC_Shipping{}; return temp.instance() }()
	mut var_allowed_classes := rt.call_method(var_wc_shipping, 'get_shipping_method_class_names', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_raw_shipping_method)) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_raw_shipping_method, 'method_id'), rt.func_array_keys(var_allowed_classes.dup()), rt.new_bool(true)])))) {
		mut var_class_name := var_allowed_classes.array_get(rt.get_property(var_raw_shipping_method, 'method_id'))
		if rt.is_true(rt.new_bool(var_class_name.dup().is_object())) {
			var_class_name = rt.call_function('get_class', [var_class_name.dup()])
		}
		mut var_instance := rt.create_object_dynamically(var_class_name, [rt.get_property(var_raw_shipping_method, 'instance_id')])
		rt.set_property(var_instance, 'enabled', if rt.is_true(rt.get_property(var_raw_shipping_method, 'is_enabled')) { rt.new_string('yes') } else { rt.new_string('no') })
		rt.set_property(var_instance, 'method_order', // unsupported expression: Expr_Cast_Int)
		return (var_instance).to_bool()
	}
	return false
}

fn Class_WC_Shipping_Zones.delete_zone(var_zone_id rt.PhpVal)  {
	mut var_zone_id_mutated := var_zone_id
	mut var_zone := create_wc_shipping_zone(var_zone_id_mutated.dup())
	var_zone.delete()
}

fn Class_WC_Shipping_Zones.get_zone_matching_package(var_package rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_string(rt.new_string(rt.call_function('wc_clean', [var_package.array_get('destination').array_get('country')]).to_string().to_upper()))
	mut var_state := rt.new_string(rt.new_string(rt.call_function('wc_clean', [var_package.array_get('destination').array_get('state')]).to_string().to_upper()))
	mut var_postcode := rt.call_function('wc_normalize_postcode', [rt.call_function('wc_clean', [var_package.array_get('destination').array_get('postcode')])])
	mut var_cache_key := rt.new_string((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('shipping_zones'))).str() + 'wc_shipping_zone_' + md5.hexhash(rt.call_function('sprintf', [rt.new_string('%s+%s+%s'), var_country.dup(), var_state.dup(), var_postcode.dup()]).to_string()))
	mut var_matching_zone_id := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('shipping_zones')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_matching_zone_id)) {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('shipping-zone'))
		var_matching_zone_id = rt.call_method(var_data_store, 'get_zone_id_from_package', [var_package.dup()])
		rt.call_function('wp_cache_set', [var_cache_key.dup(), var_matching_zone_id.dup(), rt.new_string('shipping_zones')])
	}
	return create_wc_shipping_zone(if rt.is_true(var_matching_zone_id) { var_matching_zone_id } else { rt.new_int(0) })
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WC_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_shipping_zones() &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zone() &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping() &Class_WC_Shipping {
	mut obj := &Class_WC_Shipping{
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

fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_zones' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_Shipping_Zones.get_zones(dispatch_arg_0)
		}
		'get_shipping_zones' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_Shipping_Zones.get_shipping_zones(mut dispatch_arg_0)
		}
		'get_zone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shipping_Zones.get_zone(dispatch_arg_0)
		}
		'get_zone_by' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Shipping_Zones.get_zone_by(dispatch_arg_0, dispatch_arg_1))
		}
		'get_shipping_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Shipping_Zones.get_shipping_method(dispatch_arg_0))
		}
		'delete_zone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shipping_Zones.delete_zone(dispatch_arg_0)
			return rt.new_null()
		}
		'get_zone_matching_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shipping_Zones.get_zone_matching_package(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
	rt.register_class_factory('WC_Shipping_Zones', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_zones()
		return rt.new_object('WC_Shipping_Zones', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping_Zone', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_zone()
		return rt.new_object('WC_Shipping_Zone', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping()
		return rt.new_object('WC_Shipping', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_shipping_zones_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

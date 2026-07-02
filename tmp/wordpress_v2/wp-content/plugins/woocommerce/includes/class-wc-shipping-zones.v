import rt
import crypto.md5

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

fn Class_WC_Shipping_Zones.get_zones(context string) rt.PhpVal {
	mut var_zone_objects := Class_WC_Shipping_Zones.get_shipping_zones()
	mut var_zones := rt.new_array()
	mut iter_1 := var_zone_objects.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_zone_object := item_1.val
		var_zones.array_set(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{}), rt.call_method(var_zone_object, 'get_data', []rt.PhpVal{}))
		var_zones.array_get_mut(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{})).array_set('zone_id', rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{}))
		var_zones.array_get_mut(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{})).array_set('formatted_zone_location', rt.call_method(var_zone_object, 'get_formatted_location', []rt.PhpVal{}))
		var_zones.array_get_mut(rt.call_method(var_zone_object, 'get_id', []rt.PhpVal{})).array_set('shipping_methods', rt.call_method(var_zone_object, 'get_shipping_methods', [rt.new_bool(false), rt.new_string(context)]))
	}
	return var_zones.clone()
}

fn Class_WC_Shipping_Zones.get_shipping_zones(mut var_zone_ids Class_?array) rt.PhpVal {
	mut var_zone_ids_mutated := var_zone_ids
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('shipping-zone'))
	mut var_data_store := iife_result_0
	if rt.is_true(rt.identical(rt.new_null(), var_zone_ids_mutated)) {
	mut var_raw_zones := rt.call_method(var_data_store, 'get_zones', []rt.PhpVal{})
	var_zone_ids_mutated = rt.call_function('array_column', [var_raw_zones.clone(), rt.new_string('zone_id')])
	} else if !rt.is_true(var_zone_ids_mutated) {
		return rt.new_array()
	}
	mut var_zones := rt.new_array()
	mut iter_2 := var_zone_ids_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_zone_id := item_2.val
		mut var_zone := create_wc_shipping_zone()
		var_zone.set_object_read(rt.new_bool(false))
		var_zone.set_id(var_zone_id.clone())
		var_zones.array_set(var_zone_id, var_zone)
	}
	if !(!rt.is_true(var_zones)) {
		rt.call_method(var_data_store, 'read_multiple', [var_zones.clone()])
	}
	return var_zones.clone()
}

fn Class_WC_Shipping_Zones.get_zone(var_zone_id rt.PhpVal) rt.PhpVal {
	mut var_zone_id_mutated := var_zone_id
	return Class_WC_Shipping_Zones.get_zone_by('zone_id', (var_zone_id_mutated).to_i64())
}

fn Class_WC_Shipping_Zones.get_zone_by(by string, id i64) bool {
	mut var_zone_id := rt.new_bool(false)
	mut switch_val_1 := rt.new_string(by)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('zone_id'))) {
	var_zone_id = rt.new_int(id)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('instance_id'))) {
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('shipping-zone'))
	mut var_data_store := iife_result_1
	var_zone_id = rt.call_method(var_data_store, 'get_zone_id_by_instance_id', [rt.new_int(id)])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_zone_id)))) {
		return (create_wc_shipping_zone(var_zone_id.clone())).to_bool()
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
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
	mut iife_temp_2 := Class_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('shipping-zone'))
	mut var_data_store := iife_result_2
	mut var_raw_shipping_method := rt.call_method(var_data_store, 'get_method', [var_instance_id.clone()])
	mut iife_temp_3 := Class_WC_Shipping{}
	mut iife_result_3 := iife_temp_3.instance()
	mut var_wc_shipping := iife_result_3
	mut var_allowed_classes := rt.call_method(var_wc_shipping, 'get_shipping_method_class_names', []rt.PhpVal{})
	if !(!rt.is_true(var_raw_shipping_method)) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_raw_shipping_method, 'method_id'), rt.func_array_keys(var_allowed_classes.clone()), rt.new_bool(true)])) {
		mut var_class_name := var_allowed_classes.array_get(rt.get_property(var_raw_shipping_method, 'method_id'))
		if rt.is_true(rt.new_bool(var_class_name.clone().is_object())) {
		var_class_name = rt.call_function('get_class', [var_class_name.clone()])
		}
		mut var_instance := rt.create_object_dynamically(var_class_name, [rt.get_property(var_raw_shipping_method, 'instance_id')])
		rt.set_property(var_instance, 'enabled', if rt.is_true(rt.get_property(var_raw_shipping_method, 'is_enabled')) { 'yes' } else { 'no' })
		rt.set_property(var_instance, 'method_order', rt.new_int((rt.get_property(var_raw_shipping_method, 'method_order')).to_i64()))
		return (var_instance).to_bool()
	}
	return false
}

fn Class_WC_Shipping_Zones.delete_zone(var_zone_id rt.PhpVal) {
	mut var_zone_id_mutated := var_zone_id
	mut var_zone := create_wc_shipping_zone(var_zone_id_mutated.clone())
	var_zone.delete()
}

fn Class_WC_Shipping_Zones.get_zone_matching_package(var_package rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_string(rt.call_function('wc_clean', [var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country'))]).to_string().to_upper())
	mut var_state := rt.new_string(rt.call_function('wc_clean', [var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('state'))]).to_string().to_upper())
	mut var_postcode := rt.call_function('wc_normalize_postcode', [rt.call_function('wc_clean', [var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('postcode'))])])
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.get_cache_prefix(rt.new_string('shipping_zones'))
	mut var_cache_key := rt.new_string((iife_result_4).str() + 'wc_shipping_zone_' + md5.hexhash(rt.call_function('sprintf', [rt.new_string('%s+%s+%s'), var_country.clone(), var_state.clone(), var_postcode.clone()]).to_string()))
	mut var_matching_zone_id := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('shipping_zones')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_matching_zone_id)) {
		mut iife_temp_5 := Class_WC_Data_Store{}
		mut iife_result_5 := iife_temp_5.load(rt.new_string('shipping-zone'))
		mut var_data_store := iife_result_5
		var_matching_zone_id = rt.call_method(var_data_store, 'get_zone_id_from_package', [var_package.clone()])
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_matching_zone_id.clone(), rt.new_string('shipping_zones')])
	}
	return rt.new_object('WC_Shipping_Zone', []string{}, create_wc_shipping_zone(if rt.is_true(var_matching_zone_id) { var_matching_zone_id } else { rt.new_int(0) }))
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

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
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

fn create_wc_shipping_zone(_args ...rt.PhpVal) &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping(_args ...rt.PhpVal) &Class_WC_Shipping {
	mut obj := &Class_WC_Shipping{
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


fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}

import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_settings(context string) rt.PhpVal {
	mut var_pickup_location_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_pickup_location_settings'),
		rt.create_array([rt.ArrayItem{ key: 'enabled', val: 'no' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Pickup'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'cost', val: '' }, rt.ArrayItem{
				key: 'tax_status'
				val: 'taxable'
			}]),
	])
	if !rt.is_true(var_pickup_location_settings.array_get(rt.new_string('title'))) {
		var_pickup_location_settings.array_set('title', rt.call_function('__', [
			rt.new_string('Pickup'),
			rt.new_string('woocommerce'),
		]))
	}
	if !rt.is_true(var_pickup_location_settings.array_get(rt.new_string('enabled'))) {
		var_pickup_location_settings.array_set('enabled', 'no')
	}
	if !(var_pickup_location_settings.array_isset(rt.new_string('cost'))) {
		var_pickup_location_settings.array_set('cost', '')
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), rt.new_string(context))) {
		return var_pickup_location_settings.clone()
	}
	var_pickup_location_settings.array_set('enabled', rt.call_function('wc_string_to_bool', [
		var_pickup_location_settings.array_get(rt.new_string('enabled')),
	]))
	var_pickup_location_settings.array_set('title', rt.call_function('wc_clean', [
		var_pickup_location_settings.array_get(rt.new_string('title')),
	]))
	return var_pickup_location_settings.clone()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.is_local_pickup_enabled() rt.PhpVal {
	mut var_pickup_location_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_pickup_location_settings'),
		rt.create_array([rt.ArrayItem{ key: 'enabled', val: 'no' }]),
	])
	if !rt.is_true(var_pickup_location_settings.array_get(rt.new_string('enabled'))) {
		var_pickup_location_settings.array_set('enabled', 'no')
	}
	return rt.call_function('wc_string_to_bool',
		[var_pickup_location_settings.array_get(rt.new_string('enabled'))])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_method_ids() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_methods := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_method := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.call_method(var_method, 'supports', [
			rt.new_string('local-pickup'),
		]))
		{
			var_methods.array_push(rt.get_property(var_method, 'id'))
		}
		return var_methods.clone()
	}
	mut var_all_methods_supporting_local_pickup := rt.call_function('array_reduce', [
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
			[]rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{}),
		rt.new_closure(closure_1_fn),
		rt.create_array([rt.ArrayItem{ key: none, val: 'local_pickup' }]),
	])
	return rt.call_function('array_values', [
		rt.call_function('array_unique', [var_all_methods_supporting_local_pickup.clone()]),
	])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.is_local_pickup_method(var_method_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_method_id.clone(),
		Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_method_ids(),
		rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_method_locations() rt.PhpVal {
	mut var_builtin_locations := rt.call_function('get_option', [
		rt.new_string('pickup_location_pickup_locations'),
		rt.new_array(),
	])
	mut iter_1 := var_builtin_locations.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_location := item_1.val
		mut var_index := item_1.key
		var_builtin_locations.array_get_mut(var_index).array_set('method_id', 'pickup_location')
	}
	mut var_shipping_methods := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{})
	mut var_base_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_base_state := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_base_state', []rt.PhpVal{})
	mut var_custom_method_locations := rt.new_array()
	mut iter_2 := var_shipping_methods.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [
			rt.new_string('local-pickup'),
		])))))
		{
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('pickup_location'), rt.get_property(var_method,
			'id')))
		{
			continue
		}
		var_custom_method_locations.array_push(rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_method, 'get_method_title',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'enabled', val: true },
			rt.ArrayItem{ key: 'address', val: rt.create_array([
				rt.ArrayItem{ key: 'address_1', val: '123 Main Street' },
				rt.ArrayItem{ key: 'city', val: 'Sample City' },
				rt.ArrayItem{ key: 'state', val: var_base_state },
				rt.ArrayItem{ key: 'postcode', val: '12345' },
				rt.ArrayItem{ key: 'country', val: var_base_country },
			]) },
			rt.ArrayItem{ key: 'details', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Pickup location for %s'),
					rt.new_string('woocommerce')]),
				rt.call_method(var_method, 'get_method_title', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_method, 'id') },
		]))
	}
	return rt.call_function('array_merge', [var_builtin_locations.clone(),
		var_custom_method_locations.clone()])
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_local_pickup_settings' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_settings(dispatch_arg_0)
		}
		'is_local_pickup_enabled' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.is_local_pickup_enabled()
		}
		'get_local_pickup_method_ids' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_method_ids()
		}
		'is_local_pickup_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.is_local_pickup_method(dispatch_arg_0)
		}
		'get_local_pickup_method_locations' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils.get_local_pickup_method_locations()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

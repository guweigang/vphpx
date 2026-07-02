import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) get_sorted_shipping_zones() rt.PhpVal {
	mut iife_temp_0 := Class_WC_Shipping_Zones{}
	mut iife_result_0 := iife_temp_0.get_zones()
	mut var_zones := iife_result_0
	mut iife_temp_1 := Class_WC_Shipping_Zones{}
	mut iife_result_1 := iife_temp_1.get_zone_by(rt.new_string('zone_id'), rt.new_int(0))
	mut var_rest_of_the_world := iife_result_1
	mut var_rest_data := rt.call_method(var_rest_of_the_world, 'get_data', []rt.PhpVal{})
	var_rest_data.array_set('zone_id', rt.call_method(var_rest_of_the_world, 'get_id',
		[]rt.PhpVal{}))
	var_rest_data.array_set('formatted_zone_location', rt.new_array())
	var_rest_data.array_set('shipping_methods', rt.call_method(var_rest_of_the_world,
		'get_shipping_methods', [rt.new_bool(false), rt.new_string('admin')]))
	var_zones.array_set(0, var_rest_data.clone())
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
	}
	rt.call_function('uasort', [var_zones.clone(), rt.new_closure(closure_3_fn)])
	return var_zones.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) create_shipping_zone(var_params rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
	mut var_zone := create_wc_shipping_zone(rt.new_null())
	mut var_result := this.update_shipping_zone(var_zone.clone(), var_params_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.clone()
	}
	return var_zone.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) update_shipping_zone(var_zone rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_zone_mutated := var_zone
	mut var_params_mutated := var_params
	var_params_mutated = rt.call_function('wp_parse_args', [var_params_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'name', val: rt.new_null() },
			rt.ArrayItem{ key: 'order', val: rt.new_null() },
			rt.ArrayItem{ key: 'locations', val: rt.new_null() }])])
	mut var_is_rest_of_world := rt.identical(rt.new_int(0), rt.call_method(var_zone_mutated,
		'get_id', []rt.PhpVal{}))
	if !(var_params_mutated.array_get(rt.new_string('name')).is_null()) {
		if rt.is_true(var_is_rest_of_world) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_edit_zone'), rt.call_function('__', [
				rt.new_string('Cannot change name of "Rest of the World" zone.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
			])))
		}
		mut var_name :=
			rt.new_string(var_params_mutated.array_get(rt.new_string('name')).to_string().trim_space())
		if rt.is_true(rt.identical(rt.new_string(''), var_name)) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_zone_name'), rt.call_function('__', [
				rt.new_string('Zone name cannot be empty.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
			])))
		}
		rt.call_method(var_zone_mutated, 'set_zone_name', [var_name.clone()])
	}
	if !(var_params_mutated.array_get(rt.new_string('order')).is_null()) {
		if rt.is_true(var_is_rest_of_world) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_edit_zone'), rt.call_function('__', [
				rt.new_string('Cannot change order of "Rest of the World" zone.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
			])))
		}
		rt.call_method(var_zone_mutated, 'set_zone_order', [
			var_params_mutated.array_get(rt.new_string('order')),
		])
	}
	mut var_locations_being_cleared := rt.new_bool(false)
	if !(var_params_mutated.array_get(rt.new_string('locations')).is_null()) {
		if rt.is_true(var_is_rest_of_world) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_edit_zone'), rt.call_function('__', [
				rt.new_string('Cannot change locations of "Rest of the World" zone.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() },
			])))
		}
		mut var_raw_locations := var_params_mutated.array_get(rt.new_string('locations'))
		mut var_locations := rt.new_array()
		mut iter_1 := rt.cast_array(var_raw_locations).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_raw_location := item_1.val
			var_locations_being_cleared = rt.new_bool(false)
			if !rt.is_true(var_raw_location.array_get(rt.new_string('code'))) {
				continue
			}
			mut var_type := if !(!rt.is_true(var_raw_location.array_get(rt.new_string('type')))) {
				var_raw_location.array_get(rt.new_string('type'))
			} else {
				rt.new_string('country')
			}
			if rt.is_true(rt.identical(rt.new_string('country:state'), var_type)) {
				var_type = rt.new_string('state')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_zone_mutated,
				'is_valid_location_type', [var_type.clone()])))))
			{
				continue
			}
			var_locations.array_push(rt.create_array([
				rt.ArrayItem{ key: 'code', val: var_raw_location.array_get(rt.new_string('code')) },
				rt.ArrayItem{ key: 'type', val: var_type },
			]))
		}
		var_locations_being_cleared = rt.new_bool(!rt.is_true(var_locations))
		rt.call_method(var_zone_mutated, 'set_locations', [var_locations.clone()])
	}
	rt.call_method(var_zone_mutated, 'save', []rt.PhpVal{})
	if rt.is_true(var_locations_being_cleared) {
		mut iife_temp_3 := Class_WC_Shipping_Zones{}
		mut iife_result_3 := iife_temp_3.get_zone(rt.call_method(var_zone_mutated, 'get_id',
			[]rt.PhpVal{}))
		var_zone_mutated = iife_result_3
	}
	return var_zone_mutated.clone()
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzones_shippingzoneservice(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_sorted_shipping_zones' {
			return this.get_sorted_shipping_zones()
		}
		'create_shipping_zone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_shipping_zone(dispatch_arg_0)
		}
		'update_shipping_zone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_shipping_zone(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema.identifier() string {
	return 'shipping_zone'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the shipping zone.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping zone name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'required', val: true },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		]) },
		rt.ArrayItem{ key: 'order', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping zone order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'default', val: 0 },
		]) },
		rt.ArrayItem{ key: 'locations', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Array of locations for this zone. Omit or pass an empty array for an "Everywhere" zone.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'code', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Shipping zone location code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Shipping zone location type.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'default', val: 'country' },
					]) },
					rt.ArrayItem{ key: 'name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Shipping zone location name (readonly, auto-generated from code).'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'methods', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping methods for this zone.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'instance_id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Shipping method instance ID.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
					]) },
					rt.ArrayItem{ key: 'title', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Shipping method title.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: 'enabled', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether the shipping method is enabled.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'method_id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Shipping method ID (e.g., flat_rate, free_shipping).'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: 'settings', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Raw shipping method settings for frontend processing.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
			]) },
		]) },
	])
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) get_item_response(var_zone rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_array) rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'order', val: rt.call_method(var_zone, 'get_zone_order', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'locations'
			val: this.get_formatted_zone_locations(mut rt.cast_object_ptr[Class_WC_Shipping_Zone](var_zone))
		},
		rt.ArrayItem{ key: 'methods', val: this.get_formatted_zone_methods(var_zone.clone()) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) get_formatted_zone_locations(mut var_zone Class_WC_Shipping_Zone) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_int(0), var_zone.get_id())) {
		return rt.new_array()
	}
	mut var_locations := var_zone.get_zone_locations()
	mut var_formatted_locations := rt.new_array()
	mut iter_1 := var_locations.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_location := item_1.val
		var_formatted_locations.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'code'
				val: if !(rt.get_property(var_location, 'code')).is_null() {
					rt.get_property(var_location, 'code')
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'type'
				val: if !(rt.get_property(var_location, 'type')).is_null() {
					rt.get_property(var_location, 'type')
				} else {
					rt.new_string('country')
				}
			},
			rt.ArrayItem{ key: 'name', val: this.get_location_name(var_location.clone()) },
		]))
	}
	return var_formatted_locations.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) get_formatted_zone_methods(var_zone rt.PhpVal) rt.PhpVal {
	mut var_methods := rt.call_method(var_zone, 'get_shipping_methods', [
		rt.new_bool(false),
		rt.new_string('json'),
	])
	mut var_formatted_methods := rt.new_array()
	mut iter_2 := var_methods.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		mut var_formatted_method := rt.create_array([
			rt.ArrayItem{ key: 'instance_id', val: rt.get_property(var_method, 'instance_id') },
			rt.ArrayItem{ key: 'title', val: rt.get_property(var_method, 'title') },
			rt.ArrayItem{ key: 'enabled', val: rt.identical(rt.new_string('yes'), rt.get_property(var_method,
				'enabled')) },
			rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_method, 'id') },
			rt.ArrayItem{ key: 'settings', val: this.get_method_settings(var_method.clone()) },
		])
		var_formatted_methods.array_push(var_formatted_method.clone())
	}
	return var_formatted_methods.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) get_method_settings(var_method rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.new_array()
	mut var_common_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'cost' },
		rt.ArrayItem{ key: none, val: 'min_amount' }, rt.ArrayItem{ key: none, val: 'requires' },
		rt.ArrayItem{ key: none, val: 'class_cost' }, rt.ArrayItem{ key: none, val: 'no_class_cost' }])
	mut iter_3 := var_common_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		if !(rt.get_property(var_method, '{"nodeType":"Expr_Variable","line":196,"name":"field"}')).is_null() {
			var_settings.array_set(var_field, rt.get_property(var_method,
				'{"nodeType":"Expr_Variable","line":197,"name":"field"}'))
		}
	}
	if !(rt.get_property(var_method, 'instance_settings')).is_null()
		&& rt.get_property(var_method, 'instance_settings').is_array() {
		var_settings = rt.call_function('array_merge', [var_settings.clone(),
			rt.get_property(var_method, 'instance_settings')])
	}
	return var_settings.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) get_location_name(var_location rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := rt.get_property(var_location, 'type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('continent'))) {
		mut var_continents := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_continents', []rt.PhpVal{})
		return if var_continents.array_isset(rt.get_property(var_location, 'code')) {
			var_continents.array_get(rt.get_property(var_location, 'code')).array_get(rt.new_string('name'))
		} else {
			rt.get_property(var_location, 'code')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('country'))) {
		mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_countries', []rt.PhpVal{})
		return if var_countries.array_isset(rt.get_property(var_location, 'code')) {
			var_countries.array_get(rt.get_property(var_location, 'code'))
		} else {
			rt.get_property(var_location, 'code')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('state')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('country:state'))) {
		mut var_parts := rt.call_function('explode', [rt.new_string(':'),
			rt.get_property(var_location, 'code')])
		if var_parts.clone().array_count() == 2 {
			mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'countries'), 'get_states', [var_parts.array_get(rt.new_int(0))])
			return if var_states.array_isset(var_parts.array_get(rt.new_int(1))) {
				var_states.array_get(var_parts.array_get(rt.new_int(1)))
			} else {
				rt.get_property(var_location, 'code')
			}
		}
		return rt.get_property(var_location, 'code')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('postcode'))) {
		return rt.get_property(var_location, 'code')
	} else {
		return rt.get_property(var_location, 'code')
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_shippingzones_shippingzoneschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_formatted_zone_locations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Shipping_Zone](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_formatted_zone_locations(mut dispatch_arg_0)
		}
		'get_formatted_zone_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_zone_methods(dispatch_arg_0)
		}
		'get_method_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_method_settings(dispatch_arg_0)
		}
		'get_location_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_location_name(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_ShippingZoneSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

import rt

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
pub mut:
	id          rt.PhpVal = rt.new_null()
	object_type rt.PhpVal = rt.new_string('shipping_zone')
	data        rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Shipping_Zone) construct(var_zone rt.PhpVal) {
	if var_zone.clone().is_long() || var_zone.clone().is_double() && !(!rt.is_true(var_zone)) {
		this.set_id(var_zone.clone())
	} else if rt.is_true(rt.new_bool(var_zone.clone().is_object())) {
		this.set_id(rt.get_property(var_zone, 'zone_id'))
	} else if rt.is_true(rt.identical(rt.new_int(0), var_zone))
		|| rt.is_true(rt.identical(rt.new_string('0'), var_zone)) {
		this.set_id(rt.new_int(0))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('shipping-zone'))
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(rt.identical(rt.new_bool(false), this.get_object_read())) {
		rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
			'WC_Legacy_Shipping_Zone',
		], &this), 'data_store'), 'read', [
			rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
		])
	}
}

fn (mut this Class_WC_Shipping_Zone) get_zone_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('zone_name'), rt.new_string(context))
}

fn (mut this Class_WC_Shipping_Zone) get_zone_order(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('zone_order'), rt.new_string(context))
}

fn (mut this Class_WC_Shipping_Zone) get_zone_locations(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('zone_locations'), rt.new_string(context))
}

fn (mut this Class_WC_Shipping_Zone) get_formatted_location(max i64, context string) rt.PhpVal {
	mut var_location_parts := rt.new_array()
	mut var_all_continents := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_continents', []rt.PhpVal{})
	mut var_all_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_countries', []rt.PhpVal{})
	mut var_all_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_states', []rt.PhpVal{})
	mut var_locations := this.get_zone_locations(context)
	mut var_continents := rt.call_function('array_filter', [var_locations.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Zone', [
				'WC_Legacy_Shipping_Zone',
			], &this) },
			rt.ArrayItem{ key: none, val: 'location_is_continent' },
		])])
	mut var_countries := rt.call_function('array_filter', [var_locations.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Zone', [
				'WC_Legacy_Shipping_Zone',
			], &this) },
			rt.ArrayItem{ key: none, val: 'location_is_country' },
		])])
	mut var_states := rt.call_function('array_filter', [var_locations.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Zone', [
				'WC_Legacy_Shipping_Zone',
			], &this) },
			rt.ArrayItem{ key: none, val: 'location_is_state' },
		])])
	mut var_postcodes := rt.call_function('array_filter', [var_locations.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Zone', [
				'WC_Legacy_Shipping_Zone',
			], &this) },
			rt.ArrayItem{ key: none, val: 'location_is_postcode' },
		])])
	mut iter_1 := var_continents.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_location := item_1.val
		var_location_parts.array_push(var_all_continents.array_get(rt.get_property(var_location,
			'code')).array_get(rt.new_string('name')))
	}
	mut iter_2 := var_countries.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_location := item_2.val
		var_location_parts.array_push(var_all_countries.array_get(rt.get_property(var_location,
			'code')))
	}
	mut iter_3 := var_states.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_location := item_3.val
		mut var_location_codes := rt.call_function('explode', [
			rt.new_string(':'), rt.get_property(var_location, 'code')])
		var_location_parts.array_push(var_all_states.array_get(var_location_codes.array_get(rt.new_int(0))).array_get(var_location_codes.array_get(rt.new_int(1))))
	}
	mut iter_4 := var_postcodes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_location := item_4.val
		var_location_parts.array_push(rt.get_property(var_location, 'code'))
	}
	var_location_parts = rt.call_function('array_map', [
		rt.new_string('html_entity_decode'),
		var_location_parts.clone(),
	])
	if var_location_parts.clone().array_count() > max {
		mut var_remaining := rt.new_int(var_location_parts.clone().array_count() - max)
		return rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s and %d other region'),
				rt.new_string('%s and %d other regions'), var_remaining.clone(),
				rt.new_string('woocommerce')]),
			rt.call_function('implode', [rt.new_string(', '),
				rt.call_function('array_splice', [var_location_parts.clone(),
					rt.new_int(0), rt.new_int(max)])]),
			var_remaining.clone(),
		])
	} else if !(!rt.is_true(var_location_parts)) {
		return rt.call_function('implode', [rt.new_string(', '),
			var_location_parts.clone()])
	} else {
		return rt.call_function('__', [rt.new_string('Everywhere'),
			rt.new_string('woocommerce')])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Shipping_Zone) get_shipping_methods(enabled_only bool, context string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.get_id())) {
		return rt.new_array()
	}
	mut var_raw_methods := rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
		'WC_Legacy_Shipping_Zone',
	], &this), 'data_store'), 'get_methods', [this.get_id(), rt.new_bool(enabled_only)])
	mut iife_temp_1 := Class_WC_Shipping{}
	mut iife_result_1 := iife_temp_1.instance()
	mut var_wc_shipping := iife_result_1
	mut var_allowed_classes := rt.call_method(var_wc_shipping, 'get_shipping_method_class_names',
		[]rt.PhpVal{})
	mut var_methods := rt.new_array()
	mut iter_5 := var_raw_methods.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_raw_method := item_5.val
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_raw_method, 'method_id'),
			rt.func_array_keys(var_allowed_classes.clone()),
			rt.new_bool(true),
		]))
		{
			mut var_class_name := var_allowed_classes.array_get(rt.get_property(var_raw_method,
				'method_id'))
			mut var_instance_id := rt.get_property(var_raw_method, 'instance_id')
			if rt.is_true(rt.new_bool(var_class_name.clone().is_object())) {
				mut var_class_name_of_instance := rt.call_function('get_class', [
					var_class_name.clone(),
				])
				var_methods.array_set(var_instance_id, rt.create_object_dynamically(var_class_name_of_instance, [
					var_instance_id.clone(),
				]))
			} else {
				if var_class_name.clone().is_string()
					&& rt.is_true(rt.call_function('class_exists', [var_class_name.clone()])) {
					var_methods.array_set(var_instance_id, rt.create_object_dynamically(var_class_name, [
						var_instance_id.clone(),
					]))
				}
			}
			if rt.is_true(rt.new_bool(var_methods.array_get(var_instance_id).is_object())) {
				rt.set_property(var_methods.array_get(var_instance_id), 'method_order', rt.call_function('absint', [
					rt.get_property(var_raw_method, 'method_order'),
				]))
				rt.set_property(var_methods.array_get(var_instance_id), 'enabled', if rt.is_true(rt.get_property(var_raw_method,
					'is_enabled'))
				{
					'yes'
				} else {
					'no'
				})
				rt.set_property(var_methods.array_get(var_instance_id), 'has_settings', rt.call_method(var_methods.array_get(var_instance_id),
					'has_settings', []rt.PhpVal{}))
				rt.set_property(var_methods.array_get(var_instance_id), 'settings_html', if rt.is_true(rt.call_method(var_methods.array_get(var_instance_id),
					'supports', [rt.new_string('instance-settings-modal')]))
				{
					rt.call_method(var_methods.array_get(var_instance_id),
						'get_admin_options_html', []rt.PhpVal{})
				} else {
					rt.new_bool(false)
				})
				rt.set_property(var_methods.array_get(var_instance_id), 'method_description', rt.call_function('wp_kses_post', [
					rt.call_function('wpautop', [
						rt.get_property(var_methods.array_get(var_instance_id),
							'method_description'),
					]),
				]))
			}
			if rt.is_true(rt.identical(rt.new_string('json'), rt.new_string(context))) {
				var_methods.array_set(var_instance_id, rt.array_to_object(rt.call_function('get_object_vars', [
					var_methods.array_get(var_instance_id),
				])))
				rt.get_property(var_methods.array_get(var_instance_id), 'instance_form_fields') =
					rt.new_null()
				rt.get_property(var_methods.array_get(var_instance_id), 'form_fields') =
					rt.new_null()
			}
		}
	}
	rt.call_function('uasort', [var_methods.clone(),
		rt.new_string('wc_shipping_zone_method_order_uasort_comparison')])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_zone_shipping_methods'),
		var_methods.clone(),
		var_raw_methods.clone(),
		var_allowed_classes.clone(),
		rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
	])
}

fn (mut this Class_WC_Shipping_Zone) set_zone_name(var_set rt.PhpVal) {
	this.set_prop(rt.new_string('zone_name'), rt.call_function('wc_clean', [
		var_set.clone()]))
}

fn (mut this Class_WC_Shipping_Zone) set_zone_order(var_set rt.PhpVal) {
	this.set_prop(rt.new_string('zone_order'), rt.call_function('absint', [
		var_set.clone()]))
}

fn (mut this Class_WC_Shipping_Zone) set_zone_locations(var_locations rt.PhpVal) {
	mut var_locations_mutated := var_locations
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), this.get_id())))) {
		this.set_prop(rt.new_string('zone_locations'), var_locations_mutated.clone())
	}
}

fn (mut this Class_WC_Shipping_Zone) save() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_zone_name(''))))) {
		this.set_zone_name(this.generate_zone_name())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Shipping_Zone', [
		'WC_Legacy_Shipping_Zone',
	], &this), 'data_store')))))
	{
		return this.get_id()
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_' + (this.object_type).str() + '_object_save'),
		rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
		rt.get_property(rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
			'data_store'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.get_id())))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
			'WC_Legacy_Shipping_Zone',
		], &this), 'data_store'), 'update', [
			rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
		])
	} else {
		rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
			'WC_Legacy_Shipping_Zone',
		], &this), 'data_store'), 'create', [
			rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
		])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_' + (this.object_type).str() + '_object_save'),
		rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
		rt.get_property(rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], &this),
			'data_store'),
	])
	return this.get_id()
}

fn (mut this Class_WC_Shipping_Zone) generate_zone_name() rt.PhpVal {
	mut var_zone_name := this.get_formatted_location(0, '')
	if !rt.is_true(var_zone_name) {
		var_zone_name = rt.call_function('__', [rt.new_string('Zone'),
			rt.new_string('woocommerce')])
	}
	return var_zone_name.clone()
}

fn (mut this Class_WC_Shipping_Zone) location_is_continent(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	return rt.identical(rt.new_string('continent'), rt.get_property(var_location_mutated, 'type'))
}

fn (mut this Class_WC_Shipping_Zone) location_is_country(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	return rt.identical(rt.new_string('country'), rt.get_property(var_location_mutated, 'type'))
}

fn (mut this Class_WC_Shipping_Zone) location_is_state(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	return rt.identical(rt.new_string('state'), rt.get_property(var_location_mutated, 'type'))
}

fn (mut this Class_WC_Shipping_Zone) location_is_postcode(var_location rt.PhpVal) rt.PhpVal {
	mut var_location_mutated := var_location
	return rt.identical(rt.new_string('postcode'), rt.get_property(var_location_mutated, 'type'))
}

fn (mut this Class_WC_Shipping_Zone) is_valid_location_type(var_type rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_type.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_valid_location_types'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'postcode' },
				rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'country' },
				rt.ArrayItem{ key: none, val: 'continent' }]),
		]),
		rt.new_bool(true)])
}

fn (mut this Class_WC_Shipping_Zone) add_location(var_code rt.PhpVal, var_type rt.PhpVal) {
	mut var_code_mutated := var_code
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), this.get_id()))))
		&& rt.is_true(this.is_valid_location_type(var_type.clone())) {
		if rt.is_true(rt.identical(rt.new_string('postcode'), var_type)) {
			var_code_mutated = rt.new_string(rt.call_function('str_replace', [
				rt.new_string((rt.call_function('chr', [rt.new_int(226)])).str() +
					(rt.call_function('chr', [rt.new_int(128)])).str() +
					(rt.call_function('chr', [rt.new_int(166)])).str()),
				rt.new_string('...'),
				var_code_mutated.clone(),
			]).to_string().to_upper().trim_space())
		}
		mut var_location := {
			'code': rt.call_function('wc_clean', [var_code_mutated.clone()])
			'type': rt.call_function('wc_clean', [var_type.clone()])
		}
		mut var_zone_locations := this.get_prop(rt.new_string('zone_locations'),
			rt.new_string('edit'))
		var_zone_locations.array_push(rt.array_to_object(var_location))
		this.set_prop(rt.new_string('zone_locations'), var_zone_locations.clone())
	}
}

fn (mut this Class_WC_Shipping_Zone) clear_locations(var_types rt.PhpVal) {
	mut var_types_mutated := var_types
	if !(var_types_mutated.clone().is_array()) {
		var_types_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_types_mutated },
		])
	}
	mut var_zone_locations := this.get_prop(rt.new_string('zone_locations'), rt.new_string('edit'))
	mut iter_6 := var_zone_locations.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_values := item_6.val
		mut var_key := item_6.key
		if rt.is_true(rt.call_function('in_array', [rt.get_property(var_values, 'type'),
			var_types_mutated.clone(), rt.new_bool(true)]))
		{
			var_zone_locations.array_unset(var_key)
		}
	}
	var_zone_locations = rt.call_function('array_values', [var_zone_locations.clone()])
	this.set_prop(rt.new_string('zone_locations'), var_zone_locations.clone())
}

fn (mut this Class_WC_Shipping_Zone) set_locations(var_locations rt.PhpVal) {
	mut var_locations_mutated := var_locations
	this.clear_locations(rt.new_null())
	mut iter_7 := var_locations_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_location := item_7.val
		this.add_location(var_location.array_get(rt.new_string('code')),
			var_location.array_get(rt.new_string('type')))
	}
}

fn (mut this Class_WC_Shipping_Zone) add_shipping_method(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.get_id())) {
		this.save()
	}
	mut var_instance_id := rt.new_int(0)
	mut iife_temp_2 := Class_WC_Shipping{}
	mut iife_result_2 := iife_temp_2.instance()
	mut var_wc_shipping := iife_result_2
	mut var_allowed_classes := rt.call_method(var_wc_shipping, 'get_shipping_method_class_names',
		[]rt.PhpVal{})
	mut var_count := rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
		'WC_Legacy_Shipping_Zone',
	], &this), 'data_store'), 'get_method_count', [this.get_id()])
	if rt.is_true(rt.call_function('in_array', [var_type.clone(),
		rt.func_array_keys(var_allowed_classes.clone()), rt.new_bool(true)]))
	{
		var_instance_id = rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
			'WC_Legacy_Shipping_Zone',
		], &this), 'data_store'), 'add_method', [this.get_id(),
			var_type.clone(), rt.add(var_count, rt.new_int(1))])
	}
	if rt.is_true(var_instance_id) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_shipping_zone_method_added'),
			var_instance_id.clone(),
			var_type.clone(),
			this.get_id(),
		])
	}
	mut iife_temp_3 := Class_WC_Cache_Helper{}
	mut iife_result_3 := iife_temp_3.get_transient_version(rt.new_string('shipping'),
		rt.new_bool(true))
	return var_instance_id.clone()
}

fn (mut this Class_WC_Shipping_Zone) delete_shipping_method(var_instance_id rt.PhpVal) bool {
	mut var_instance_id_mutated := var_instance_id
	if rt.is_true(rt.identical(rt.new_null(), this.get_id())) {
		return false
	}
	mut var_method := rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
		'WC_Legacy_Shipping_Zone',
	], &this), 'data_store'), 'get_method', [var_instance_id_mutated.clone()])
	if rt.is_true(var_method) {
		rt.call_method(rt.get_property(rt.new_object('WC_Shipping_Zone', [
			'WC_Legacy_Shipping_Zone',
		], &this), 'data_store'), 'delete_method', [var_instance_id_mutated.clone()])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_shipping_zone_method_deleted'),
			var_instance_id_mutated.clone(),
			rt.get_property(var_method, 'method_id'),
			this.get_id(),
		])
	}
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.get_transient_version(rt.new_string('shipping'),
		rt.new_bool(true))
	return true
}

struct Class_WC_Legacy_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_shipping_zone(arg_0 rt.PhpVal) &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		object_type:   rt.new_string('shipping_zone')
		data:          rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_legacy_shipping_zone(_args ...rt.PhpVal) &Class_WC_Legacy_Shipping_Zone {
	mut obj := &Class_WC_Legacy_Shipping_Zone{
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

fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_zone_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_zone_name(dispatch_arg_0)
		}
		'get_zone_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_zone_order(dispatch_arg_0)
		}
		'get_zone_locations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_zone_locations(dispatch_arg_0)
		}
		'get_formatted_location' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_formatted_location(dispatch_arg_0, dispatch_arg_1)
		}
		'get_shipping_methods' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_shipping_methods(dispatch_arg_0, dispatch_arg_1)
		}
		'set_zone_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_zone_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_zone_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_zone_order(dispatch_arg_0)
			return rt.new_null()
		}
		'set_zone_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_zone_locations(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			return this.save()
		}
		'generate_zone_name' {
			return this.generate_zone_name()
		}
		'location_is_continent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.location_is_continent(dispatch_arg_0)
		}
		'location_is_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.location_is_country(dispatch_arg_0)
		}
		'location_is_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.location_is_state(dispatch_arg_0)
		}
		'location_is_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.location_is_postcode(dispatch_arg_0)
		}
		'is_valid_location_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_valid_location_type(dispatch_arg_0)
		}
		'add_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_location(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'clear_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_locations(dispatch_arg_0)
			return rt.new_null()
		}
		'set_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_locations(dispatch_arg_0)
			return rt.new_null()
		}
		'add_shipping_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_shipping_method(dispatch_arg_0)
		}
		'delete_shipping_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_shipping_method(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'object_type' { return this.object_type }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'object_type' {
			this.object_type = val
			return true
		}
		'data' {
			this.data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Legacy_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Legacy_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.register_class_factory('WC_Shipping_Zone', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wc_shipping_zone(c_arg_0)
		return rt.new_object('WC_Shipping_Zone', ['WC_Legacy_Shipping_Zone'], obj)
	})
	rt.register_class_factory('WC_Legacy_Shipping_Zone', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_legacy_shipping_zone()
		return rt.new_object('WC_Legacy_Shipping_Zone', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping()
		return rt.new_object('WC_Shipping', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn (args []rt.PhpVal) rt.PhpVal {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.include_file(@DIR + '/legacy/class-wc-legacy-shipping-zone.php', '4')
}

import rt

struct Class_WC_Shipping_Zone_Data_Store {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) create(var_zone rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_shipping_zones'),
		rt.create_array([
			rt.ArrayItem{ key: 'zone_name', val: rt.call_method(var_zone, 'get_zone_name',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'zone_order', val: rt.call_method(var_zone, 'get_zone_order',
				[]rt.PhpVal{}) },
		]),
	])
	rt.call_method(var_zone, 'set_id', [rt.get_property(var_wpdb, 'insert_id')])
	rt.call_method(var_zone, 'save_meta_data', []rt.PhpVal{})
	this.save_locations(var_zone.clone())
	rt.call_method(var_zone, 'apply_changes', []rt.PhpVal{})
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.invalidate_cache_group(rt.new_string('shipping_zones'))
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.get_transient_version(rt.new_string('shipping'),
		rt.new_bool(true))
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) update(var_zone rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_method(var_zone, 'get_id', []rt.PhpVal{})) {
		rt.call_method(var_wpdb, 'update', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_shipping_zones'),
			rt.create_array([
				rt.ArrayItem{ key: 'zone_name', val: rt.call_method(var_zone, 'get_zone_name',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'zone_order', val: rt.call_method(var_zone, 'get_zone_order',
					[]rt.PhpVal{}) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
			]),
		])
	}
	rt.call_method(var_zone, 'save_meta_data', []rt.PhpVal{})
	this.save_locations(var_zone.clone())
	rt.call_method(var_zone, 'apply_changes', []rt.PhpVal{})
	mut iife_temp_2 := Class_WC_Cache_Helper{}
	mut iife_result_2 := iife_temp_2.invalidate_cache_group(rt.new_string('shipping_zones'))
	mut iife_temp_3 := Class_WC_Cache_Helper{}
	mut iife_result_3 := iife_temp_3.get_transient_version(rt.new_string('shipping'),
		rt.new_bool(true))
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) read(var_zone rt.PhpVal) {
	mut var_zones := rt.create_array([
		rt.ArrayItem{ key: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}), val: var_zone },
	])
	this.read_multiple(mut rt.cast_object_ptr[Class_array](var_zones))
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) read_multiple(mut var_zones Class_array) {
	mut var_zones_mutated := var_zones
	mut var_zone_ids := rt.func_array_keys(var_zones_mutated)
	mut var_zone_data :=
		this.get_zone_data_for_ids(mut rt.cast_object_ptr[Class_array](var_zone_ids))
	mut iter_1 := var_zones_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_zone := item_1.val
		mut var_zone_id := item_1.key
		if rt.is_true(rt.identical(rt.new_int(0), var_zone_id))
			|| rt.is_true(rt.identical(rt.new_string('0'), var_zone_id)) {
			rt.call_method(var_zone, 'set_zone_name', [
				rt.call_function('__', [
					rt.new_string('Locations not covered by your other zones'),
					rt.new_string('woocommerce'),
				]),
			])
		} else {
			if !(var_zone_data.array_isset(var_zone_id)) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
					rt.new_string('Invalid data store.'),
					rt.new_string('woocommerce'),
				]))))
			}
			rt.call_method(var_zone, 'set_zone_name', [
				rt.get_property(var_zone_data.array_get(var_zone_id), 'zone_name'),
			])
			rt.call_method(var_zone, 'set_zone_order', [
				rt.get_property(var_zone_data.array_get(var_zone_id), 'zone_order'),
			])
		}
	}
	mut var_zone_locations :=
		this.get_zone_locations_for_ids(mut rt.cast_object_ptr[Class_array](var_zone_ids))
	mut iter_2 := var_zone_locations.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_zone_location := item_2.val
		if var_zones_mutated.array_isset(rt.get_property(var_zone_location, 'zone_id')) {
			rt.call_method(var_zones_mutated.array_get(rt.get_property(var_zone_location, 'zone_id')),
				'add_location', [rt.get_property(var_zone_location, 'location_code'),
				rt.get_property(var_zone_location, 'location_type')])
		}
	}
	mut iter_3 := var_zones_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_zone := item_3.val
		mut var_zone_id := item_3.key
		rt.call_method(var_zone, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_loaded'),
			var_zone.clone()])
	}
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_zone_data_for_ids(mut var_ids Class_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_ids)
		|| rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{
		key: none
		val: '0'
	}]), var_ids))
		|| rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 0 }]), var_ids)) {
		return rt.new_array()
	}
	mut var_zone_ids := rt.call_function('array_map', [rt.new_string('absint'), var_ids])
	return rt.call_method(var_wpdb, 'get_results', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('SELECT zone_id, zone_name, zone_order FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones ')) +
			'WHERE zone_id IN ( ' + (rt.call_function('implode', [rt.new_string(','), var_zone_ids.clone()])).str() +
			' ) ').str()),
		rt.get_constant('OBJECT_K'),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_zone_locations_for_ids(mut var_ids Class_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_ids)
		|| rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{
		key: none
		val: '0'
	}]), var_ids))
		|| rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 0 }]), var_ids)) {
		return rt.new_array()
	}
	mut var_zone_ids := rt.call_function('array_map', [rt.new_string('absint'), var_ids])
	return rt.call_method(var_wpdb, 'get_results', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('SELECT zone_id, location_code, location_type FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_locations ')) +
			'WHERE zone_id IN ( ' + (rt.call_function('implode', [rt.new_string(','), var_zone_ids.clone()])).str() +
			' ) ').str()),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) delete(var_zone rt.PhpVal, var_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_zone_id := rt.call_method(var_zone, 'get_id', []rt.PhpVal{})
	if rt.is_true(var_zone_id) {
		mut var_methods := this.get_methods(var_zone_id.clone(), rt.new_bool(false))
		if rt.is_true(var_methods) {
			mut iter_4 := var_methods.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_method := item_4.val
				this.delete_method(rt.get_property(var_method, 'instance_id'))
			}
		}
		rt.call_method(var_wpdb, 'delete', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
				'woocommerce_shipping_zone_locations'),
			rt.create_array([rt.ArrayItem{ key: 'zone_id', val: var_zone_id }]),
		])
		rt.call_method(var_wpdb, 'delete', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_shipping_zones'),
			rt.create_array([rt.ArrayItem{ key: 'zone_id', val: var_zone_id }]),
		])
		rt.call_method(var_zone, 'set_id', [rt.new_null()])
		mut iife_temp_4 := Class_WC_Cache_Helper{}
		mut iife_result_4 := iife_temp_4.invalidate_cache_group(rt.new_string('shipping_zones'))
		mut iife_temp_5 := Class_WC_Cache_Helper{}
		mut iife_result_5 := iife_temp_5.get_transient_version(rt.new_string('shipping'),
			rt.new_bool(true))
		rt.call_function('do_action', [rt.new_string('woocommerce_delete_shipping_zone'),
			var_zone_id.clone()])
	}
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_methods(var_zone_id rt.PhpVal, var_enabled_only rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_zone_id_mutated := var_zone_id
	if rt.is_true(var_enabled_only) {
		mut var_raw_methods_sql := rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT method_id, method_order, instance_id, is_enabled FROM '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('woocommerce_shipping_zone_methods WHERE zone_id = %d AND is_enabled = 1'))).str())
	} else {
		var_raw_methods_sql = rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT method_id, method_order, instance_id, is_enabled FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('woocommerce_shipping_zone_methods WHERE zone_id = %d'))).str())
	}
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [var_raw_methods_sql.clone(),
			var_zone_id_mutated.clone()]),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_method_count(var_zone_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_zone_id_mutated := var_zone_id
	return rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_shipping_zone_methods WHERE zone_id = %d')),
			var_zone_id_mutated.clone(),
		]),
	])
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) add_method(var_zone_id rt.PhpVal, var_type rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_zone_id_mutated := var_zone_id
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_shipping_zone_methods'),
		rt.create_array([rt.ArrayItem{ key: 'method_id', val: var_type },
			rt.ArrayItem{ key: 'zone_id', val: var_zone_id_mutated },
			rt.ArrayItem{ key: 'method_order', val: var_order }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%d' }]),
	])
	return rt.get_property(var_wpdb, 'insert_id')
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) delete_method(var_instance_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_method := this.get_method(var_instance_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_method)))) {
		return
	}
	rt.call_function('delete_option', [
		rt.new_string('woocommerce_' + (rt.get_property(var_method, 'method_id')).str() + '_' +
			var_instance_id.str() + '_settings'),
	])
	rt.call_method(var_wpdb, 'delete', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_shipping_zone_methods'),
		rt.create_array([rt.ArrayItem{ key: 'instance_id', val: var_instance_id }]),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_delete_shipping_zone_method'),
		var_instance_id.clone(),
	])
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_method(var_instance_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT zone_id, method_id, instance_id, method_order, is_enabled FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_shipping_zone_methods WHERE instance_id = %d LIMIT 1;')),
			var_instance_id.clone(),
		]),
	])
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_zone_id_from_package(var_package rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_country := rt.new_string(rt.call_function('wc_clean', [
		var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country')),
	]).to_string().to_upper())
	mut var_state := rt.new_string(rt.call_function('wc_clean', [
		var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('state')),
	]).to_string().to_upper())
	mut var_continent := rt.new_string(rt.call_function('wc_clean', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
			'get_continent_code_for_country', [var_country.clone()]),
	]).to_string().to_upper())
	mut var_postcode := rt.call_function('wc_normalize_postcode', [
		rt.call_function('wc_clean',
			[var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('postcode'))]),
	])
	mut var_criteria := rt.new_array()
	var_criteria.array_push(rt.call_method(var_wpdb, 'prepare', [
		rt.new_string("( ( location_type = 'country' AND location_code = %s )"),
		var_country.clone(),
	]))
	var_criteria.array_push(rt.call_method(var_wpdb, 'prepare', [
		rt.new_string("OR ( location_type = 'state' AND location_code = %s )"),
		rt.new_string(var_country.str() + ':' + var_state.str()),
	]))
	var_criteria.array_push(rt.call_method(var_wpdb, 'prepare', [
		rt.new_string("OR ( location_type = 'continent' AND location_code = %s )"),
		var_continent.clone(),
	]))
	var_criteria.array_push('OR ( location_type IS NULL ) )')
	mut var_postcode_locations := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT zone_id, location_code FROM '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_shipping_zone_locations WHERE location_type = 'postcode';")),
	])
	if rt.is_true(var_postcode_locations) {
		mut var_zone_ids_with_postcode_rules := rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.call_function('wp_list_pluck', [var_postcode_locations.clone(),
				rt.new_string('zone_id')]),
		])
		mut var_matches := rt.call_function('wc_postcode_location_matcher', [
			var_postcode.clone(), var_postcode_locations.clone(),
			rt.new_string('zone_id'), rt.new_string('location_code'),
			var_country.clone()])
		mut var_do_not_match := rt.call_function('array_unique', [
			rt.call_function('array_diff', [var_zone_ids_with_postcode_rules.clone(),
				rt.func_array_keys(var_matches.clone())]),
		])
		if !(!rt.is_true(var_do_not_match)) {
			var_criteria.array_push(
				'AND zones.zone_id NOT IN (' + (rt.call_function('implode', [rt.new_string(','), var_do_not_match.clone()])).str() +
				')')
		}
	}
	var_criteria = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_zone_criteria'),
		var_criteria.clone(),
		var_package.clone(),
		var_postcode_locations.clone(),
	])
	return rt.call_method(var_wpdb, 'get_var', [
		rt.new_string((
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT zones.zone_id FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones as zones\n\t\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string("woocommerce_shipping_zone_locations as locations ON zones.zone_id = locations.zone_id AND location_type != 'postcode'\n\t\t\tWHERE ")) +
			(rt.call_function('implode', [rt.new_string(' '), var_criteria.clone()])).str() +
			' ORDER BY zone_order ASC, zones.zone_id ASC LIMIT 1').str()),
	])
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_zones() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT zone_id, zone_name, zone_order FROM '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('woocommerce_shipping_zones order by zone_order ASC, zone_id ASC;')),
	])
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) get_zone_id_by_instance_id(var_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT zone_id FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_shipping_zone_methods as methods WHERE methods.instance_id = %d LIMIT 1;')),
			var_id.clone(),
		]),
	])
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) save_locations(var_zone rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_changed_props := rt.func_array_keys(rt.call_method(var_zone, 'get_changes',
		[]rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('zone_locations'),
		var_changed_props.clone(),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	rt.call_method(var_wpdb, 'delete', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_shipping_zone_locations'),
		rt.create_array([
			rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
		]),
	])
	mut iter_5 := rt.call_method(var_zone, 'get_zone_locations', [
		rt.new_string('edit')]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_location := item_5.val
		rt.call_method(var_wpdb, 'insert', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
				'woocommerce_shipping_zone_locations'),
			rt.create_array([
				rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'location_code', val: rt.get_property(var_location, 'code') },
				rt.ArrayItem{ key: 'location_type', val: rt.get_property(var_location, 'type') },
			]),
		])
	}
	return false
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) read_meta(var_zone rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) delete_meta(var_zone rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
		rt.new_string('Attempted to delete meta from a shipping zone, but shipping zones do not support meta data.'),
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'shipping_zone_data_store' },
			rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'backtrace', val: true }]),
	])
	return rt.new_array()
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) add_meta(var_zone rt.PhpVal, var_meta rt.PhpVal) i64 {
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
		rt.new_string('Attempted to add meta to a shipping zone, but shipping zones do not support meta data.'),
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'shipping_zone_data_store' },
			rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'key'
				val: if !(rt.get_property(var_meta, 'key')).is_null() {
					rt.get_property(var_meta, 'key')
				} else {
					rt.new_string('')
				}
			}, rt.ArrayItem{ key: 'backtrace', val: true }]),
	])
	return 0
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) update_meta(var_zone rt.PhpVal, var_meta rt.PhpVal) bool {
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
		rt.new_string('Attempted to update meta on a shipping zone, but shipping zones do not support meta data.'),
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'shipping_zone_data_store' },
			rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'key'
				val: if !(rt.get_property(var_meta, 'key')).is_null() {
					rt.get_property(var_meta, 'key')
				} else {
					rt.new_string('')
				}
			}, rt.ArrayItem{ key: 'backtrace', val: true }]),
	])
	return false
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
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

fn create_wc_shipping_zone_data_store(_args ...rt.PhpVal) &Class_WC_Shipping_Zone_Data_Store {
	mut obj := &Class_WC_Shipping_Zone_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
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

fn (mut this Class_WC_Shipping_Zone_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'read_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.read_multiple(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_zone_data_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_zone_data_for_ids(mut dispatch_arg_0)
		}
		'get_zone_locations_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_zone_locations_for_ids(mut dispatch_arg_0)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_methods(dispatch_arg_0, dispatch_arg_1)
		}
		'get_method_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_method_count(dispatch_arg_0)
		}
		'add_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_method(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_method(dispatch_arg_0)
			return rt.new_null()
		}
		'get_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_method(dispatch_arg_0)
		}
		'get_zone_id_from_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_zone_id_from_package(dispatch_arg_0)
		}
		'get_zones' {
			return this.get_zones()
		}
		'get_zone_id_by_instance_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_zone_id_by_instance_id(dispatch_arg_0)
		}
		'save_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.save_locations(dispatch_arg_0))
		}
		'read_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_meta(dispatch_arg_0)
		}
		'delete_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.delete_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'add_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.add_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_meta(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Zone_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

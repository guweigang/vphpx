import rt

fn get_network(var_network_arg rt.PhpVal) rt.PhpVal {
	mut var_network := var_network_arg
	mut var_current_site := rt.new_null()
	mut var__network := rt.new_null()
	if !rt.is_true(var_network) && !var_current_site.is_null() {
		var_network = var_current_site
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_network, 'WP_Network'))) {
		var__network = var_network.clone()
	} else if rt.is_true(rt.new_bool(var_network.clone().is_object())) {
		var__network = create_wp_network(var_network.clone())
	} else {
		mut iife_temp_0 := Class_WP_Network{}
		mut iife_result_0 := iife_temp_0.get_instance(var_network.clone())
		var__network = iife_result_0
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__network)))) {
		return rt.new_null()
	}
	var__network = rt.call_function('apply_filters', [rt.new_string('get_network'),
		var__network.clone()])
	return var__network.clone()
}

fn get_networks(var_args rt.PhpVal) rt.PhpVal {
	mut var_query := rt.new_null()
	var_query = create_wp_network_query()
	return var_query.query(var_args.clone())
}

fn clean_network_cache(var_ids rt.PhpVal) {
	mut var__wp_suspend_cache_invalidation := rt.new_null()
	mut var_network_ids := rt.new_null()
	mut var_id := rt.new_null()
	if !(!rt.is_true(var__wp_suspend_cache_invalidation)) {
		return
	}
	var_network_ids = rt.cast_array(var_ids)
	rt.call_function('wp_cache_delete_multiple', [var_network_ids.clone(),
		rt.new_string('networks')])
	mut iter_1 := var_network_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_id_shadow := item_1.val
		rt.call_function('do_action', [rt.new_string('clean_network_cache'),
			var_id_shadow.clone()])
	}
	rt.call_function('wp_cache_set_last_changed', [rt.new_string('networks')])
}

fn update_network_cache(var_networks rt.PhpVal) {
	mut var_data := rt.new_null()
	mut var_network := rt.new_null()
	var_data = rt.new_array()
	mut iter_2 := rt.cast_array(var_networks).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_network_shadow := item_2.val
		var_data.array_set(rt.get_property(var_network_shadow, 'id'), var_network_shadow.clone())
	}
	rt.call_function('wp_cache_add_multiple', [var_data.clone(),
		rt.new_string('networks')])
}

fn _prime_network_caches(var_network_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_non_cached_ids := rt.new_null()
	mut var_fresh_networks := rt.new_null()
	var_non_cached_ids = rt.call_function('_get_non_cached_ids', [
		var_network_ids.clone(), rt.new_string('networks')])
	if !(!rt.is_true(var_non_cached_ids)) {
		var_fresh_networks = rt.call_method(var_wpdb, 'get_results', [
			rt.call_function('sprintf', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), rt.get_property(var_wpdb,
					'site')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'site')),
					rt.new_string(' WHERE id IN (%s)')),
				rt.call_function('implode', [rt.new_string(','),
					rt.call_function('array_map', [rt.new_string('intval'),
						var_non_cached_ids.clone()])]),
			]),
		])
		update_network_cache(var_fresh_networks.clone())
	}
}

struct Class_WP_Network {
	rt.PhpObjectBase
}

struct Class_WP_Network_Query {
	rt.PhpObjectBase
}

fn create_wp_network(_args ...rt.PhpVal) &Class_WP_Network {
	mut obj := &Class_WP_Network{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_network_query(_args ...rt.PhpVal) &Class_WP_Network_Query {
	mut obj := &Class_WP_Network_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Network) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Network) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Network) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Network_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Network_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Network_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

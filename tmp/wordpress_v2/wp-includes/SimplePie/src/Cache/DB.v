import rt

struct Class_SimplePie_Cache_DB {
	rt.PhpObjectBase
}

fn Class_SimplePie_Cache_DB.prepare_simplepie_object_for_cache(mut var_data Class_SimplePie_Cache_SimplePie_SimplePie) rt.PhpVal {
	mut var_items := var_data.get_items()
	mut var_items_by_id := rt.new_array()
	if !(!rt.is_true(var_items)) {
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			var_items_by_id.array_set(rt.call_method(var_item, 'get_id', []rt.PhpVal{}),
				var_item.clone())
		}
		if rt.is_true(rt.new_bool(var_items_by_id.clone().array_count() != var_items.clone().array_count())) {
			var_items_by_id = rt.new_array()
			mut iter_2 := var_items.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_item := item_2.val
				var_items_by_id.array_set(rt.call_method(var_item, 'get_id', [
					rt.new_bool(true),
				]), var_item.clone())
			}
		}
		if rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_isset(rt.new_int(0)) {
			mut var_channel :=
				rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_get(rt.new_int(0))
		} else if rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_isset(rt.new_int(0)) {
			var_channel =
				rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_get(rt.new_int(0))
		} else if rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_isset(rt.new_int(0)) {
			var_channel =
				rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0))
		} else if rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('channel')).array_isset(rt.new_int(0)) {
			var_channel =
				rt.get_property(var_data, 'data').array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('channel')).array_get(rt.new_int(0))
		} else {
			var_channel = rt.new_null()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_channel, rt.new_null())))) {
			if var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_isset(rt.new_string('entry')) {
				var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_unset(rt.new_string('entry'))
			}
			if var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_03()).array_isset(rt.new_string('entry')) {
				var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_03()).array_unset(rt.new_string('entry'))
			}
			if var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_10()).array_isset(rt.new_string('item')) {
				var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_10()).array_unset(rt.new_string('item'))
			}
			if var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_090()).array_isset(rt.new_string('item')) {
				var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_090()).array_unset(rt.new_string('item'))
			}
			if var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_isset(rt.new_string('item')) {
				var_channel.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_unset(rt.new_string('item'))
			}
		}
		if rt.get_property(var_data, 'data').array_isset(rt.new_string('items')) {
			rt.get_property(var_data, 'data').array_unset(rt.new_string('items'))
		}
		if rt.get_property(var_data, 'data').array_isset(rt.new_string('ordered_items')) {
			rt.get_property(var_data, 'data').array_unset(rt.new_string('ordered_items'))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('serialize', [
			rt.get_property(var_data, 'data'),
		]) },
		rt.ArrayItem{ key: none, val: var_items_by_id },
	])
}

fn create_simplepie_cache_db(_args ...rt.PhpVal) &Class_SimplePie_Cache_DB {
	mut obj := &Class_SimplePie_Cache_DB{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Cache_DB) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_simplepie_object_for_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Cache_SimplePie_SimplePie](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_SimplePie_Cache_DB.prepare_simplepie_object_for_cache(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Cache_DB) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_DB) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\DB'),
		rt.new_string('SimplePie_Cache_DB')])
}

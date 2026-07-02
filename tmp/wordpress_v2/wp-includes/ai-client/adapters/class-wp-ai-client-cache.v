import rt

pub fn Class_WP_AI_Client_Cache.cache_group() string {
	return 'wp_ai_client'
}

struct Class_WP_AI_Client_Cache {
	rt.PhpObjectBase
}

fn (mut this Class_WP_AI_Client_Cache) get(var_key rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_found := rt.new_bool(false)
	mut var_value := rt.call_function('wp_cache_get', [var_key.clone(),
		rt.new_string(Class_WP_AI_Client_Cache.cache_group()),
		rt.new_bool(false), var_found.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		return var_default_value.clone()
	}
	return var_value.clone()
}

fn (mut this Class_WP_AI_Client_Cache) set(var_key rt.PhpVal, var_value rt.PhpVal, var_ttl rt.PhpVal) bool {
	mut var_value_mutated := var_value
	mut var_expire := rt.new_int(this.ttl_to_seconds(var_ttl.clone()))
	return (rt.call_function('wp_cache_set', [var_key.clone(),
		var_value_mutated.clone(), rt.new_string(Class_WP_AI_Client_Cache.cache_group()),
		var_expire.clone()])).to_bool()
}

fn (mut this Class_WP_AI_Client_Cache) delete(var_key rt.PhpVal) bool {
	return (rt.call_function('wp_cache_delete', [var_key.clone(),
		rt.new_string(Class_WP_AI_Client_Cache.cache_group())])).to_bool()
}

fn (mut this Class_WP_AI_Client_Cache) clear() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_cache_supports', [rt.new_string('flush_group')]))))) {
		return false
	}
	return (rt.call_function('wp_cache_flush_group', [
		rt.new_string(Class_WP_AI_Client_Cache.cache_group()),
	])).to_bool()
}

fn (mut this Class_WP_AI_Client_Cache) getmultiple(var_keys rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_keys_array := this.iterable_to_array(var_keys.clone())
	mut var_values := rt.call_function('wp_cache_get_multiple', [
		var_keys_array.clone(), rt.new_string(Class_WP_AI_Client_Cache.cache_group())])
	mut var_result := rt.new_array()
	mut iter_1 := var_keys_array.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if rt.is_true(rt.identical(rt.new_bool(false), var_values.array_get(var_key))) {
			var_result.array_set(var_key, this.get(var_key.clone(), var_default_value.clone()))
		} else {
			var_result.array_set(var_key, var_values.array_get(var_key))
		}
	}
	return var_result.clone()
}

fn (mut this Class_WP_AI_Client_Cache) setmultiple(var_values rt.PhpVal, var_ttl rt.PhpVal) bool {
	mut var_values_mutated := var_values
	mut var_values_array := this.iterable_to_array(var_values_mutated.clone())
	mut var_expire := rt.new_int(this.ttl_to_seconds(var_ttl.clone()))
	mut var_results := rt.call_function('wp_cache_set_multiple', [
		var_values_array.clone(), rt.new_string(Class_WP_AI_Client_Cache.cache_group()),
		var_expire.clone()])
	return !(rt.is_true(rt.call_function('in_array', [rt.new_bool(false),
		var_results.clone(), rt.new_bool(true)])))
}

fn (mut this Class_WP_AI_Client_Cache) deletemultiple(var_keys rt.PhpVal) bool {
	mut var_keys_array := this.iterable_to_array(var_keys.clone())
	mut var_results := rt.call_function('wp_cache_delete_multiple', [
		var_keys_array.clone(), rt.new_string(Class_WP_AI_Client_Cache.cache_group())])
	return !(rt.is_true(rt.call_function('in_array', [rt.new_bool(false),
		var_results.clone(), rt.new_bool(true)])))
}

fn (mut this Class_WP_AI_Client_Cache) has(var_key rt.PhpVal) bool {
	mut var_found := rt.new_bool(false)
	rt.call_function('wp_cache_get', [var_key.clone(),
		rt.new_string(Class_WP_AI_Client_Cache.cache_group()),
		rt.new_bool(false), var_found.clone()])
	return var_found.to_bool()
}

fn (mut this Class_WP_AI_Client_Cache) ttl_to_seconds(var_ttl rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.new_null(), var_ttl)) {
		return 0
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_ttl, 'DateInterval'))) {
		mut var_now := create_datetime()
		mut var_end := rt.call_method(var_now.dup(), 'add', [
			var_ttl.clone()])
		return (rt.sub(rt.call_method(var_end, 'getTimestamp', []rt.PhpVal{}),
			var_now.gettimestamp())).to_i64()
	}
	return (rt.call_function('max', [rt.new_int(0), rt.new_int(var_ttl.to_i64())])).to_i64()
}

fn (mut this Class_WP_AI_Client_Cache) iterable_to_array(var_items rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_items.clone().is_array())) {
		return var_items.clone()
	}
	return rt.call_function('iterator_to_array', [var_items.clone()])
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wp_ai_client_cache(_args ...rt.PhpVal) &Class_WP_AI_Client_Cache {
	mut obj := &Class_WP_AI_Client_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_AI_Client_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'clear' {
			return rt.new_bool(this.clear())
		}
		'getMultiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.getmultiple(dispatch_arg_0, dispatch_arg_1)
		}
		'setMultiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.setmultiple(dispatch_arg_0, dispatch_arg_1))
		}
		'deleteMultiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.deletemultiple(dispatch_arg_0))
		}
		'has' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has(dispatch_arg_0))
		}
		'ttl_to_seconds' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.ttl_to_seconds(dispatch_arg_0))
		}
		'iterable_to_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.iterable_to_array(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_AI_Client_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

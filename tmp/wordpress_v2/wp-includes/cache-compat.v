import rt

fn wp_cache_add_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_group := group
	mut var_expire := expire
	mut var_values := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	var_values = rt.new_array()
	mut iter_1 := var_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_key_shadow := item_1.key
		var_values.array_set(var_key_shadow, rt.call_function('wp_cache_add', [
			var_key_shadow.clone(),
			var_value_shadow.clone(),
			rt.new_string(group),
			rt.new_int(expire),
		]))
	}
	return var_values.clone()
}

fn wp_cache_set_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_group := group
	mut var_expire := expire
	mut var_values := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	var_values = rt.new_array()
	mut iter_2 := var_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value_shadow := item_2.val
		mut var_key_shadow := item_2.key
		var_values.array_set(var_key_shadow, rt.call_function('wp_cache_set', [
			var_key_shadow.clone(),
			var_value_shadow.clone(),
			rt.new_string(group),
			rt.new_int(expire),
		]))
	}
	return var_values.clone()
}

fn wp_cache_get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut var_group := group
	mut var_force := force
	mut var_values := rt.new_null()
	mut var_key := rt.new_null()
	var_values = rt.new_array()
	mut iter_3 := var_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key_shadow := item_3.val
		var_values.array_set(var_key_shadow, rt.call_function('wp_cache_get', [
			var_key_shadow.clone(),
			rt.new_string(group),
			rt.new_bool(force),
		]))
	}
	return var_values.clone()
}

fn wp_cache_delete_multiple(var_keys rt.PhpVal, group string) rt.PhpVal {
	mut var_group := group
	mut var_values := rt.new_null()
	mut var_key := rt.new_null()
	var_values = rt.new_array()
	mut iter_4 := var_keys.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key_shadow := item_4.val
		var_values.array_set(var_key_shadow, rt.call_function('wp_cache_delete', [
			var_key_shadow.clone(),
			rt.new_string(group),
		]))
	}
	return var_values.clone()
}

fn wp_cache_flush_runtime() bool {
	if !(wp_cache_supports('flush_runtime')) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Your object cache implementation does not support flushing the in-memory runtime cache.'),
			]),
			rt.new_string('6.1.0')])
		return false
	}
	return (rt.call_function('wp_cache_flush', []rt.PhpVal{})).to_bool()
}

fn wp_cache_flush_group(var_group rt.PhpVal) bool {
	mut var_wp_object_cache := rt.new_null()
	if !(wp_cache_supports('flush_group')) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Your object cache implementation does not support flushing individual groups.'),
			]),
			rt.new_string('6.1.0')])
		return false
	}
	return (rt.call_method(var_wp_object_cache, 'flush_group', [
		var_group.clone()])).to_bool()
}

fn wp_cache_supports(var_feature rt.PhpVal) bool {
	return false
}

fn wp_cache_get_salted(var_cache_key rt.PhpVal, var_group rt.PhpVal, var_salt_arg rt.PhpVal) bool {
	mut var_salt := var_salt_arg
	mut var_cache := rt.new_null()
	var_salt = if var_salt.clone().is_array() { rt.call_function('implode', [
			rt.new_string(':'),
			var_salt.clone(),
		]) } else { var_salt }
	var_cache = rt.call_function('wp_cache_get', [var_cache_key.clone(),
		var_group.clone()])
	if !(var_cache.clone().is_array()) {
		return false
	}
	if !(var_cache.array_isset(rt.new_string('salt')))
		|| !(var_cache.array_isset(rt.new_string('data')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_salt, var_cache.array_get(rt.new_string('salt')))))) {
		return false
	}
	return (var_cache.array_get(rt.new_string('data'))).to_bool()
}

fn wp_cache_set_salted(var_cache_key rt.PhpVal, var_data rt.PhpVal, var_group rt.PhpVal, var_salt_arg rt.PhpVal, expire i64) rt.PhpVal {
	mut var_expire := expire
	mut var_salt := var_salt_arg
	var_salt = if var_salt.clone().is_array() { rt.call_function('implode', [
			rt.new_string(':'),
			var_salt.clone(),
		]) } else { var_salt }
	return rt.call_function('wp_cache_set', [var_cache_key.clone(),
		rt.create_array([rt.ArrayItem{ key: 'data', val: var_data },
			rt.ArrayItem{ key: 'salt', val: var_salt }]),
		var_group.clone(), rt.new_int(expire)])
}

fn wp_cache_get_multiple_salted(var_cache_keys rt.PhpVal, var_group rt.PhpVal, var_salt_arg rt.PhpVal) rt.PhpVal {
	mut var_salt := var_salt_arg
	mut var_cache := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	var_salt = if var_salt.clone().is_array() { rt.call_function('implode', [
			rt.new_string(':'),
			var_salt.clone(),
		]) } else { var_salt }
	var_cache = wp_cache_get_multiple(var_cache_keys.clone(), var_group.clone(), false)
	mut iter_5 := var_cache.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value_shadow := item_5.val
		mut var_key_shadow := item_5.key
		if !(var_value_shadow.clone().is_array()) {
			var_cache.array_set(var_key_shadow, false)
			continue
		}
		if (!(var_value_shadow.array_isset(rt.new_string('salt'))
			&& var_value_shadow.array_isset(rt.new_string('data'))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_salt, var_value_shadow['salt'])))) {
			var_cache.array_set(var_key_shadow, false)
			continue
		}
		var_cache.array_set(var_key_shadow, var_value_shadow['data'])
	}
	return var_cache.clone()
}

fn wp_cache_set_multiple_salted(var_data rt.PhpVal, var_group rt.PhpVal, var_salt_arg rt.PhpVal, expire i64) rt.PhpVal {
	mut var_expire := expire
	mut var_salt := var_salt_arg
	mut var_new_cache := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	var_salt = if var_salt.clone().is_array() { rt.call_function('implode', [
			rt.new_string(':'),
			var_salt.clone(),
		]) } else { var_salt }
	var_new_cache = rt.new_array()
	mut iter_6 := var_data.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value_shadow := item_6.val
		mut var_key_shadow := item_6.key
		var_new_cache.array_set(var_key_shadow, rt.create_array([
			rt.ArrayItem{ key: 'data', val: var_value_shadow },
			rt.ArrayItem{ key: 'salt', val: var_salt },
		]))
	}
	return wp_cache_set_multiple(var_new_cache.clone(), var_group.clone(), expire)
}

fn wp_cache_switch_to_blog(var_blog_id rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	if var_wp_object_cache.clone().is_object()
		&& rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.clone(), rt.new_string('switch_to_blog')])) {
		rt.call_method(var_wp_object_cache, 'switch_to_blog', [
			var_blog_id.clone()])
		return
	}
	rt.call_function('wp_cache_switch_to_blog_fallback', []rt.PhpVal{})
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_add_multiple'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_set_multiple'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_get_multiple'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_delete_multiple'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_flush_runtime'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_flush_group'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_supports'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_get_salted'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_set_salted'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_get_multiple_salted'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_set_multiple_salted'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_cache_switch_to_blog'),
	])))))
	{
	}
}

import rt

fn wp_cache_add_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_values.array_set(var_key, rt.call_function('wp_cache_add', [var_key.dup(), var_value.dup(), rt.new_string(group), rt.new_int(expire)]))
		}
	}
	return var_values.dup()
}

fn wp_cache_set_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_values.array_set(var_key, rt.call_function('wp_cache_set', [var_key.dup(), var_value.dup(), rt.new_string(group), rt.new_int(expire)]))
		}
	}
	return var_values.dup()
}

fn wp_cache_get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_values.array_set(var_key, rt.call_function('wp_cache_get', [var_key.dup(), rt.new_string(group), rt.new_bool(force)]))
		}
	}
	return var_values.dup()
}

fn wp_cache_delete_multiple(var_keys rt.PhpVal, group string) rt.PhpVal {
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_values.array_set(var_key, rt.call_function('wp_cache_delete', [var_key.dup(), rt.new_string(group)]))
		}
	}
	return var_values.dup()
}

fn wp_cache_flush_runtime() bool {
	if !(wp_cache_supports('flush_runtime')) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Your object cache implementation does not support flushing the in-memory runtime cache.')]), rt.new_string('6.1.0')])
		return false
	}
	return (rt.call_function('wp_cache_flush', []rt.PhpVal{})).to_bool()
}

fn wp_cache_flush_group(var_group rt.PhpVal) bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(wp_cache_supports('flush_group')) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Your object cache implementation does not support flushing individual groups.')]), rt.new_string('6.1.0')])
		return false
	}
	return (rt.call_method(var_wp_object_cache, 'flush_group', [var_group.dup()])).to_bool()
}

fn wp_cache_supports(var_feature rt.PhpVal) bool {
	return false
}

fn wp_cache_get_salted(var_cache_key rt.PhpVal, var_group rt.PhpVal, var_salt rt.PhpVal) bool {
	var_salt = if rt.is_true(rt.new_bool(var_salt.dup().is_array())) { rt.call_function('implode', [rt.new_string(':'), var_salt.dup()]) } else { var_salt }
	mut var_cache := rt.call_function('wp_cache_get', [var_cache_key.dup(), var_group.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache.dup().is_array()))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(var_cache.array_isset(rt.new_string('salt'))) || !(var_cache.array_isset(rt.new_string('data'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return (var_cache.array_get('data')).to_bool()
}

fn wp_cache_set_salted(var_cache_key rt.PhpVal, var_data rt.PhpVal, var_group rt.PhpVal, var_salt rt.PhpVal, expire i64) rt.PhpVal {
	var_salt = if rt.is_true(rt.new_bool(var_salt.dup().is_array())) { rt.call_function('implode', [rt.new_string(':'), var_salt.dup()]) } else { var_salt }
	return rt.call_function('wp_cache_set', [var_cache_key.dup(), rt.create_array([rt.ArrayItem{ key: 'data', val: var_data }, rt.ArrayItem{ key: 'salt', val: var_salt }]), var_group.dup(), rt.new_int(expire)])
}

fn wp_cache_get_multiple_salted(var_cache_keys rt.PhpVal, var_group rt.PhpVal, var_salt rt.PhpVal) rt.PhpVal {
	var_salt = if rt.is_true(rt.new_bool(var_salt.dup().is_array())) { rt.call_function('implode', [rt.new_string(':'), var_salt.dup()]) } else { var_salt }
	mut var_cache := wp_cache_get_multiple(var_cache_keys.dup(), var_group.dup(), false)
	{
		mut iter_1 := var_cache.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
				var_cache.array_set(var_key, false)
				continue
			}
			if rt.is_true(rt.new_bool(!(var_value.array_isset(rt.new_string('salt')) && var_value.array_isset(rt.new_string('data'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_cache.array_set(var_key, false)
				continue
			}
			var_cache.array_set(var_key, var_value.array_get('data'))
		}
	}
	return var_cache.dup()
}

fn wp_cache_set_multiple_salted(var_data rt.PhpVal, var_group rt.PhpVal, var_salt rt.PhpVal, expire i64) rt.PhpVal {
	var_salt = if rt.is_true(rt.new_bool(var_salt.dup().is_array())) { rt.call_function('implode', [rt.new_string(':'), var_salt.dup()]) } else { var_salt }
	mut var_new_cache := rt.new_array()
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_new_cache.array_set(var_key, rt.create_array([rt.ArrayItem{ key: 'data', val: var_value }, rt.ArrayItem{ key: 'salt', val: var_salt }]))
		}
	}
	return wp_cache_set_multiple(var_new_cache.dup(), var_group.dup(), expire)
}

fn wp_cache_switch_to_blog(var_blog_id rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_object_cache.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.dup(), rt.new_string('switch_to_blog')])))) {
		rt.call_method(var_wp_object_cache, 'switch_to_blog', [var_blog_id.dup()])
		return rt.new_null()
	}
	rt.call_function('wp_cache_switch_to_blog_fallback', []rt.PhpVal{})
}



pub fn init_wp_includes_cache_compat_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_add_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_set_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_delete_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_flush_runtime')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_flush_group')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get_salted')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_set_salted')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get_multiple_salted')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_set_multiple_salted')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_switch_to_blog')]))))) {
	}
}

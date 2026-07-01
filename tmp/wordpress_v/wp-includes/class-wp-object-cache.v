import rt

struct Class_WP_Object_Cache {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_array()
		cache_hits rt.PhpVal = rt.new_int(0)
		cache_misses rt.PhpVal = rt.new_int(0)
		global_groups rt.PhpVal = rt.new_array()
		blog_prefix rt.PhpVal = rt.new_null()
		multisite rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Object_Cache) construct()  {
	this.multisite = rt.call_function('is_multisite', []rt.PhpVal{})
	this.blog_prefix = if rt.is_true(this.multisite) { (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str() + ':' } else { rt.new_string('') }
}

fn (mut this Class_WP_Object_Cache) magic_get(var_name rt.PhpVal) rt.PhpVal {
	return rt.get_property(rt.new_object('WP_Object_Cache', []string{}, &this), '{"nodeType":"Expr_Variable","line":94,"name":"name"}')
}

fn (mut this Class_WP_Object_Cache) magic_set(var_name rt.PhpVal, var_value rt.PhpVal)  {
	this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":106,"name":"name"}', var_value.dup())
}

fn (mut this Class_WP_Object_Cache) magic_isset(var_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(rt.get_property(rt.new_object('WP_Object_Cache', []string{}, &this), '{"nodeType":"Expr_Variable","line":118,"name":"name"}')).is_null())
}

fn (mut this Class_WP_Object_Cache) magic_unset(var_name rt.PhpVal)  {
	rt.get_property(rt.new_object('WP_Object_Cache', []string{}, &this), '{"nodeType":"Expr_Variable","line":129,"name":"name"}') = rt.new_null()
}

fn (mut this Class_WP_Object_Cache) is_valid_key(var_key rt.PhpVal) bool {
	mut var_key_mutated := var_key
	if rt.is_true(rt.new_bool(var_key_mutated.dup().is_long())) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_key_mutated.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return true
	}
	mut var_type := rt.call_function('gettype', [var_key_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('__')]))))) {
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	}
	mut var_message := if rt.is_true(rt.new_bool(var_key_mutated.dup().is_string())) { rt.call_function('__', [rt.new_string('Cache key must not be an empty string.')]) } else { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cache key must be an integer or a non-empty string, %s given.')]), var_type.dup()]) }
	rt.call_function('_doing_it_wrong', [rt.call_function('sprintf', [rt.new_string('%s::%s'), rt.new_string(@STRUCT), rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(2)]).array_get(1).array_get('function')]), var_message.dup(), rt.new_string('6.1.0')])
	return false
}

fn (mut this Class_WP_Object_Cache) _exists(var_key rt.PhpVal, var_group rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut var_group_mutated := var_group
	return this.cache.array_isset(var_group_mutated) && rt.is_true(rt.new_bool(this.cache.array_get(var_group_mutated).array_isset(var_key_mutated) || rt.is_true(rt.new_bool(this.cache.array_get(var_group_mutated).array_isset(var_key_mutated.dup())))))
}

fn (mut this Class_WP_Object_Cache) add(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_key_mutated := var_key
	mut var_data_mutated := var_data
	mut group_mutated := group
	if rt.is_true(rt.call_function('wp_suspend_cache_addition', []rt.PhpVal{})) {
		return false
	}
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	mut var_id := var_key_mutated.dup()
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_id = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if this._exists(var_id.dup(), rt.new_string(group_mutated)) {
		return false
	}
	return this.set(var_key_mutated.dup(), var_data_mutated.dup(), group_mutated, (// unsupported expression: Expr_Cast_Int).to_i64())
}

fn (mut this Class_WP_Object_Cache) add_multiple(mut var_data Class_array, group string, expire i64) rt.PhpVal {
	mut var_data_mutated := var_data
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_values.array_set(var_key, this.add(var_key.dup(), var_value.dup(), group_mutated, expire))
		}
	}
	return var_values.dup()
}

fn (mut this Class_WP_Object_Cache) replace(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_key_mutated := var_key
	mut var_data_mutated := var_data
	mut group_mutated := group
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	mut var_id := var_key_mutated.dup()
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_id = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if !(this._exists(var_id.dup(), rt.new_string(group_mutated))) {
		return false
	}
	return this.set(var_key_mutated.dup(), var_data_mutated.dup(), group_mutated, (// unsupported expression: Expr_Cast_Int).to_i64())
}

fn (mut this Class_WP_Object_Cache) set(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_key_mutated := var_key
	mut var_data_mutated := var_data
	mut group_mutated := group
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_key_mutated = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if rt.is_true(rt.new_bool(var_data_mutated.dup().is_object())) {
		var_data_mutated = // unsupported expression: Expr_Clone
	}
	this.cache.array_get_mut(group_mutated).array_set(var_key_mutated, var_data_mutated.dup())
	return true
}

fn (mut this Class_WP_Object_Cache) set_multiple(mut var_data Class_array, group string, expire i64) rt.PhpVal {
	mut var_data_mutated := var_data
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_values.array_set(var_key, this.set(var_key.dup(), var_value.dup(), group_mutated, expire))
		}
	}
	return var_values.dup()
}

fn (mut this Class_WP_Object_Cache) get(var_key rt.PhpVal, group string, force bool, var_found rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut group_mutated := group
	mut var_found_mutated := var_found
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_key_mutated = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if this._exists(var_key_mutated.dup(), rt.new_string(group_mutated)) {
		var_found_mutated = rt.new_bool(rt.new_bool(true))
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.new_bool(this.cache.array_get(group_mutated).array_get(var_key_mutated).is_object())) {
			return (// unsupported expression: Expr_Clone).to_bool()
		} else {
			return (this.cache.array_get(group_mutated).array_get(var_key_mutated)).to_bool()
		}
	}
	var_found_mutated = rt.new_bool(rt.new_bool(false))
	// unsupported expression: Expr_AssignOp_Plus
	return false
}

fn (mut this Class_WP_Object_Cache) get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_values.array_set(var_key, this.get(var_key.dup(), group_mutated, force, rt.new_null()))
		}
	}
	return var_values.dup()
}

fn (mut this Class_WP_Object_Cache) delete(var_key rt.PhpVal, group string, deprecated bool) bool {
	mut var_key_mutated := var_key
	mut group_mutated := group
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_key_mutated = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if !(this._exists(var_key_mutated.dup(), rt.new_string(group_mutated))) {
		return false
	}
	this.cache.array_get(group_mutated).array_unset(var_key_mutated)
	return true
}

fn (mut this Class_WP_Object_Cache) delete_multiple(mut var_keys Class_array, group string) rt.PhpVal {
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_values.array_set(var_key, this.delete(var_key.dup(), group_mutated, false))
		}
	}
	return var_values.dup()
}

fn (mut this Class_WP_Object_Cache) incr(var_key rt.PhpVal, offset i64, group string) bool {
	mut var_key_mutated := var_key
	mut offset_mutated := offset
	mut group_mutated := group
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_key_mutated = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if !(this._exists(var_key_mutated.dup(), rt.new_string(group_mutated))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.cache.array_get(group_mutated).array_get(var_key_mutated).is_long() || this.cache.array_get(group_mutated).array_get(var_key_mutated).is_double()))))) {
		this.cache.array_get_mut(group_mutated).array_set(var_key_mutated, 0)
	}
	offset_mutated = (// unsupported expression: Expr_Cast_Int).to_i64()
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.less(this.cache.array_get(group_mutated).array_get(var_key_mutated), rt.new_int(0))) {
		this.cache.array_get_mut(group_mutated).array_set(var_key_mutated, 0)
	}
	return (this.cache.array_get(group_mutated).array_get(var_key_mutated)).to_bool()
}

fn (mut this Class_WP_Object_Cache) decr(var_key rt.PhpVal, offset i64, group string) bool {
	mut var_key_mutated := var_key
	mut offset_mutated := offset
	mut group_mutated := group
	if !(this.is_valid_key(var_key_mutated.dup())) {
		return false
	}
	if group_mutated == '' {
		group_mutated = 'default'
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && !(this.global_groups.array_isset(rt.new_string(group_mutated))))) {
		var_key_mutated = rt.new_string(rt.concat(this.blog_prefix, var_key_mutated))
	}
	if !(this._exists(var_key_mutated.dup(), rt.new_string(group_mutated))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.cache.array_get(group_mutated).array_get(var_key_mutated).is_long() || this.cache.array_get(group_mutated).array_get(var_key_mutated).is_double()))))) {
		this.cache.array_get_mut(group_mutated).array_set(var_key_mutated, 0)
	}
	offset_mutated = (// unsupported expression: Expr_Cast_Int).to_i64()
	// unsupported expression: Expr_AssignOp_Minus
	if rt.is_true(rt.less(this.cache.array_get(group_mutated).array_get(var_key_mutated), rt.new_int(0))) {
		this.cache.array_get_mut(group_mutated).array_set(var_key_mutated, 0)
	}
	return (this.cache.array_get(group_mutated).array_get(var_key_mutated)).to_bool()
}

fn (mut this Class_WP_Object_Cache) flush() bool {
	this.cache = rt.new_array()
	return true
}

fn (mut this Class_WP_Object_Cache) flush_group(var_group rt.PhpVal) bool {
	mut var_group_mutated := var_group
	this.cache.array_unset(var_group_mutated)
	return true
}

fn (mut this Class_WP_Object_Cache) add_global_groups(var_groups rt.PhpVal)  {
	mut var_groups_mutated := var_groups
	var_groups_mutated = rt.cast_array(var_groups_mutated)
	var_groups_mutated = rt.call_function('array_fill_keys', [var_groups_mutated.dup(), rt.new_bool(true)])
	this.global_groups = rt.call_function('array_merge', [this.global_groups, var_groups_mutated.dup()])
}

fn (mut this Class_WP_Object_Cache) switch_to_blog(var_blog_id rt.PhpVal)  {
	mut var_blog_id_mutated := var_blog_id
	var_blog_id_mutated = // unsupported expression: Expr_Cast_Int
	this.blog_prefix = if rt.is_true(this.multisite) { (var_blog_id_mutated).str() + ':' } else { rt.new_string('') }
}

fn (mut this Class_WP_Object_Cache) reset()  {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.new_string('WP_Object_Cache::switch_to_blog()')])
	{
		mut iter_1 := rt.func_array_keys(this.cache).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			if !(this.global_groups.array_isset(var_group)) {
				this.cache.array_unset(var_group)
			}
		}
	}
}

fn (mut this Class_WP_Object_Cache) stats()  {
	print('<p>')
	print(rt.concat(rt.concat(, ), ))
	print()
	print('</p>')
}

fn create_wp_object_cache() &Class_WP_Object_Cache {
	mut obj := &Class_WP_Object_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_array()
		cache_hits: rt.new_int(0)
		cache_misses: rt.new_int(0)
		global_groups: rt.new_array()
		blog_prefix: rt.new_null()
		multisite: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Object_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'is_valid_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_key(dispatch_arg_0))
		}
		'_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._exists(dispatch_arg_0, dispatch_arg_1))
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'add_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.add_multiple(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'replace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.replace(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'set_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.set_multiple(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.get(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_multiple(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'delete_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.delete_multiple(mut dispatch_arg_0, dispatch_arg_1)
		}
		'incr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.incr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'decr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.decr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'flush' {
			return rt.new_bool(this.flush())
		}
		'flush_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.flush_group(dispatch_arg_0))
		}
		'add_global_groups' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_global_groups(dispatch_arg_0)
			return rt.new_null()
		}
		'switch_to_blog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.switch_to_blog(dispatch_arg_0)
			return rt.new_null()
		}
		'reset' {
			this.reset()
			return rt.new_null()
		}
		'stats' {
			this.stats()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Object_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		'cache_hits' { return this.cache_hits }
		'cache_misses' { return this.cache_misses }
		'global_groups' { return this.global_groups }
		'blog_prefix' { return this.blog_prefix }
		'multisite' { return this.multisite }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Object_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' { this.cache = val; return true }
		'cache_hits' { this.cache_hits = val; return true }
		'cache_misses' { this.cache_misses = val; return true }
		'global_groups' { this.global_groups = val; return true }
		'blog_prefix' { this.blog_prefix = val; return true }
		'multisite' { this.multisite = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_object_cache_php() {
}

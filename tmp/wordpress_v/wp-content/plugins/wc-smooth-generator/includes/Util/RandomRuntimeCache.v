import rt

struct Class_WC_SmoothGenerator_Util_RandomRuntimeCache {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_array()
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.exists(group string) bool {
	mut group_mutated := group
	return // unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(group_mutated).dup())
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get(group string, limit i64) rt.PhpVal {
	mut group_mutated := group
	mut var_all_items := Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(group_mutated)
	if limit <= 0 || var_all_items.dup().array_count() <= limit {
		return var_all_items.dup()
	}
	mut var_items := rt.call_function('array_slice', [var_all_items.dup(), rt.new_int(0), rt.new_int(limit)])
	return var_items.dup()
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.extract(group string, limit i64) rt.PhpVal {
	mut group_mutated := group
	mut var_all_items := Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(group_mutated)
	if limit <= 0 || var_all_items.dup().array_count() <= limit {
		Class_WC_SmoothGenerator_Util_RandomRuntimeCache.clear(group_mutated)
		return var_all_items.dup()
	}
	mut var_items := rt.call_function('array_slice', [var_all_items.dup(), rt.new_int(0), rt.new_int(limit)])
	mut var_remaining_items := rt.call_function('array_slice', [var_all_items.dup(), rt.new_int(limit)])
	Class_WC_SmoothGenerator_Util_RandomRuntimeCache.set(group_mutated, mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Util_array](var_remaining_items))
	return var_items.dup()
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.add(group string, mut var_items Class_WC_SmoothGenerator_Util_array)  {
	mut group_mutated := group
	mut var_items_mutated := var_items
	mut var_existing_items := Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(group_mutated)
	Class_WC_SmoothGenerator_Util_RandomRuntimeCache.set(group_mutated, mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Util_array](rt.call_function('array_merge', [var_existing_items.dup(), var_items_mutated.dup()])))
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.set(group string, mut var_items Class_WC_SmoothGenerator_Util_array)  {
	mut group_mutated := group
	mut var_items_mutated := var_items
	// unsupported expression: Expr_StaticPropertyFetch.array_set(group_mutated, var_items_mutated.dup())
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.count(group string) i64 {
	mut group_mutated := group
	group_mutated = (Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(group_mutated)).str()
	return rt.new_string(group_mutated).dup().array_count()
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.shuffle(group string)  {
	mut group_mutated := group
	Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(group_mutated)
	rt.call_function('shuffle', [// unsupported expression: Expr_StaticPropertyFetch.array_get(group_mutated)])
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.clear(group string)  {
	mut group_mutated := group
	// unsupported expression: Expr_StaticPropertyFetch.array_unset(rt.new_string(group_mutated))
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.reset()  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(group string) rt.PhpVal {
	mut group_mutated := group
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_SmoothGenerator_Util_RandomRuntimeCache.exists(group_mutated))))) {
		Class_WC_SmoothGenerator_Util_RandomRuntimeCache.set(group_mutated, mut rt.cast_object_ptr[Class_WC_SmoothGenerator_Util_array](rt.new_array()))
	}
	return // unsupported expression: Expr_StaticPropertyFetch.array_get(group_mutated)
}

fn create_wc_smoothgenerator_util_randomruntimecache() &Class_WC_SmoothGenerator_Util_RandomRuntimeCache {
	mut obj := &Class_WC_SmoothGenerator_Util_RandomRuntimeCache{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Util_RandomRuntimeCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'exists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WC_SmoothGenerator_Util_RandomRuntimeCache.exists(dispatch_arg_0))
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get(dispatch_arg_0, dispatch_arg_1)
		}
		'extract' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Util_RandomRuntimeCache.extract(dispatch_arg_0, dispatch_arg_1)
		}
		'add' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Util_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WC_SmoothGenerator_Util_RandomRuntimeCache.add(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Util_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WC_SmoothGenerator_Util_RandomRuntimeCache.set(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(Class_WC_SmoothGenerator_Util_RandomRuntimeCache.count(dispatch_arg_0))
		}
		'shuffle' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_SmoothGenerator_Util_RandomRuntimeCache.shuffle(dispatch_arg_0)
			return rt.new_null()
		}
		'clear' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_SmoothGenerator_Util_RandomRuntimeCache.clear(dispatch_arg_0)
			return rt.new_null()
		}
		'reset' {
			Class_WC_SmoothGenerator_Util_RandomRuntimeCache.reset()
			return rt.new_null()
		}
		'get_group' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Util_RandomRuntimeCache.get_group(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Util_RandomRuntimeCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_SmoothGenerator_Util_RandomRuntimeCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' { this.cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_wc_smooth_generator_includes_util_randomruntimecache_php() {
}

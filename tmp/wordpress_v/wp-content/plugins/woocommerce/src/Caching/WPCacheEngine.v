import rt

struct Class_Automattic_WooCommerce_Caching_WPCacheEngine {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) get_cached_object(key string, group string) rt.PhpVal {
	mut var_prefixed_key := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Caching_WPCacheEngine{}; return temp.get_prefixed_key(arg_0, arg_1) }(rt.new_string(key), rt.new_string(group))
	mut var_value := rt.call_function('wp_cache_get', [var_prefixed_key.dup(), rt.new_string(group)])
	return if rt.is_true(rt.identical(rt.new_bool(false), var_value)) { rt.new_null() } else { var_value }
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) get_cached_objects(mut var_keys Class_Automattic_WooCommerce_Caching_array, group string) rt.PhpVal {
	mut var_prefix := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Caching_WPCacheEngine{}; return temp.get_cache_prefix(arg_0) }(rt.new_string(group))
	closure_2_fn := fn [var_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string((var_prefix).str() + var_key)
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string((var_prefix).str() + var_key)
	}
	mut var_key_map := rt.call_function('array_combine', [var_keys, rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_keys])])
	mut var_cached_values := rt.call_function('wp_cache_get_multiple', [rt.call_function('array_values', [var_key_map.dup()]), rt.new_string(group)])
	mut var_return_values := rt.new_array()
	{
		mut iter_1 := var_key_map.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prefixed_key := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_cached_values.array_isset(var_prefixed_key) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_return_values.array_set(var_key, var_cached_values.array_get(var_prefixed_key))
			} else {
				var_return_values.array_set(var_key, rt.new_null())
			}
		}
	}
	return var_return_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) cache_object(key string, var_object rt.PhpVal, expiration i64, group string) bool {
	mut var_prefixed_key := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Caching_WPCacheEngine{}; return temp.get_prefixed_key(arg_0, arg_1) }(rt.new_string(key), rt.new_string(group))
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) cache_objects(mut var_objects Class_Automattic_WooCommerce_Caching_array, expiration i64, group string) rt.PhpVal {
	mut var_objects_mutated := var_objects
	mut var_prefix := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Caching_WPCacheEngine{}; return temp.get_cache_prefix(arg_0) }(rt.new_string(group))
	closure_6_fn := fn [var_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string((var_prefix).str() + var_key)
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string((var_prefix).str() + var_key)
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string((var_prefix).str() + var_key)
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string((var_prefix).str() + var_key)
	}
	var_objects_mutated = rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_closure(closure_3_fn), rt.func_array_keys(var_objects_mutated.dup())]), var_objects_mutated.dup()])
	return rt.call_function('wp_cache_set_multiple', [var_objects_mutated.dup(), rt.new_string(group), rt.new_int(expiration)])
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) delete_cached_object(key string, group string) bool {
	mut var_prefixed_key := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Caching_WPCacheEngine{}; return temp.get_prefixed_key(arg_0, arg_1) }(rt.new_string(key), rt.new_string(group))
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) is_cached(key string, group string) bool {
	mut var_prefixed_key := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Caching_WPCacheEngine{}; return temp.get_prefixed_key(arg_0, arg_1) }(rt.new_string(key), rt.new_string(group))
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) delete_cache_group(group string) bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn create_automattic_woocommerce_caching_wpcacheengine() &Class_Automattic_WooCommerce_Caching_WPCacheEngine {
	mut obj := &Class_Automattic_WooCommerce_Caching_WPCacheEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_cached_object' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_cached_object(dispatch_arg_0, dispatch_arg_1)
		}
		'get_cached_objects' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caching_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_cached_objects(mut dispatch_arg_0, dispatch_arg_1)
		}
		'cache_object' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_bool(this.cache_object(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'cache_objects' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caching_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.cache_objects(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete_cached_object' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete_cached_object(dispatch_arg_0, dispatch_arg_1))
		}
		'is_cached' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_cached(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_cache_group' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete_cache_group(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Caching_WPCacheEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caching_WPCacheEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_caching_wpcacheengine_php() {
}

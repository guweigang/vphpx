import rt

struct Class_Automattic_WooCommerce_Caches_OrderCountCache {
	rt.PhpObjectBase
pub mut:
		cache_prefix rt.PhpVal = rt.new_string('order-count')
		expiration rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) get_saved_statuses_for_type(order_type string) rt.PhpVal {
	mut order_type_mutated := order_type
	mut var_statuses := rt.call_function('wp_cache_get', [rt.new_string(this.get_saved_statuses_cache_key(order_type_mutated))])
	if !(var_statuses.clone().is_array()) {
	var_statuses = rt.new_array()
	}
	return var_statuses.clone()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) ensure_statuses_for_type(order_type string, mut var_order_statuses Class_Automattic_WooCommerce_Caches_array) {
	mut order_type_mutated := order_type
	mut var_order_statuses_mutated := var_order_statuses
	if !rt.is_true(var_order_statuses_mutated) {
		return
	}
	mut var_existing := this.get_saved_statuses_for_type(order_type_mutated)
	mut var_new_statuses := rt.call_function('array_diff', [var_order_statuses_mutated, var_existing.clone()])
	if !rt.is_true(var_new_statuses) {
		return
	}
	mut var_merged := rt.call_function('array_unique', [rt.call_function('array_merge', [var_existing.clone(), var_new_statuses.clone()])])
	rt.call_function('wp_cache_set', [rt.new_string(this.get_saved_statuses_cache_key(order_type_mutated)), var_merged.clone(), rt.new_string(''), this.expiration])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) get_default_statuses() rt.PhpVal {
	return rt.call_function('array_merge', [rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) get_cache_key(var_order_type rt.PhpVal, var_order_status rt.PhpVal) string {
	mut var_order_type_mutated := var_order_type
	mut var_order_status_mutated := var_order_status
	return (this.cache_prefix).str() + '_' + (var_order_type_mutated).str() + '_' + (var_order_status_mutated).str()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) get_saved_statuses_cache_key(order_type string) string {
	mut order_type_mutated := order_type
	return (this.cache_prefix).str() + '_' + order_type_mutated + '_statuses'
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) is_cached(var_order_type rt.PhpVal, var_order_status rt.PhpVal) bool {
	mut var_order_type_mutated := var_order_type
	mut var_order_status_mutated := var_order_status
	mut var_cache_key := rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), var_order_status_mutated.clone()))
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_cache_get', [var_cache_key.clone()]), rt.new_bool(false))))
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) set(var_order_type rt.PhpVal, var_order_status rt.PhpVal, value i64) bool {
	mut var_order_type_mutated := var_order_type
	mut var_order_status_mutated := var_order_status
	this.ensure_statuses_for_type((var_order_type_mutated).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_array](rt.create_array([rt.ArrayItem{ key: none, val: (var_order_status_mutated).str() }])))
	mut var_cache_key := rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), var_order_status_mutated.clone()))
	return (rt.call_function('wp_cache_set', [var_cache_key.clone(), rt.new_int(value), rt.new_string(''), this.expiration])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) set_multiple(order_type string, mut var_counts Class_Automattic_WooCommerce_Caches_array) rt.PhpVal {
	mut order_type_mutated := order_type
	if !rt.is_true(var_counts) {
		return rt.new_array()
	}
	this.ensure_statuses_for_type(order_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_array](rt.func_array_keys(var_counts)))
	mut var_mapped_counts := rt.new_array()
	mut iter_1 := var_counts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_count := item_1.val
		mut var_status := item_1.key
		var_mapped_counts.array_set(this.get_cache_key(rt.new_string(order_type_mutated), var_status.clone()), rt.new_int((var_count).to_i64()))
	}
	return rt.call_function('wp_cache_set_multiple', [var_mapped_counts.clone(), rt.new_string(''), this.expiration])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) get(var_order_type rt.PhpVal, var_order_statuses rt.PhpVal) rt.PhpVal {
	mut var_order_type_mutated := var_order_type
	mut var_order_statuses_mutated := var_order_statuses
	var_order_type_mutated = rt.new_string((var_order_type_mutated).str())
	if !rt.is_true(var_order_statuses_mutated) {
		var_order_statuses_mutated = this.get_saved_statuses_for_type((var_order_type_mutated).str())
		if !rt.is_true(var_order_statuses_mutated) {
			return rt.new_null()
		}
	}
	closure_1_fn := fn [var_order_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_statuses := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), var_order_statuses_mutated.clone()))
		}
	closure_2_fn := fn [var_order_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_statuses := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), var_order_statuses_mutated.clone()))
		}
	mut var_cache_keys := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_order_statuses_mutated.clone()])
	mut var_cache_values := rt.call_function('wp_cache_get_multiple', [var_cache_keys.clone()])
	mut var_status_values := rt.new_array()
	mut iter_2 := var_cache_values.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.identical(var_value, rt.new_bool(false))) {
			return rt.new_null()
		}
		mut var_order_status := rt.call_function('str_replace', [rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), rt.new_string(''))), rt.new_string(''), var_key.clone()])
		var_status_values.array_set(var_order_status, var_value.clone())
	}
	return var_status_values.clone()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) increment(var_order_type rt.PhpVal, var_order_status rt.PhpVal, offset i64) rt.PhpVal {
	mut var_order_type_mutated := var_order_type
	mut var_order_status_mutated := var_order_status
	mut var_cache_key := rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), var_order_status_mutated.clone()))
	return rt.call_function('wp_cache_incr', [var_cache_key.clone(), rt.new_int(offset)])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) decrement(var_order_type rt.PhpVal, var_order_status rt.PhpVal, offset i64) rt.PhpVal {
	mut var_order_type_mutated := var_order_type
	mut var_order_status_mutated := var_order_status
	mut var_cache_key := rt.new_string(this.get_cache_key(var_order_type_mutated.clone(), var_order_status_mutated.clone()))
	return rt.call_function('wp_cache_decr', [var_cache_key.clone(), rt.new_int(offset)])
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) flush(order_type string, var_order_statuses rt.PhpVal) {
	mut order_type_mutated := order_type
	mut var_order_statuses_mutated := var_order_statuses
	order_type_mutated = order_type_mutated
	mut var_flush_saved_statuses := rt.new_bool(false)
	if !rt.is_true(var_order_statuses_mutated) {
	var_order_statuses_mutated = this.get_saved_statuses_for_type(order_type_mutated)
	var_flush_saved_statuses = rt.new_bool(true)
	}
	closure_3_fn := fn [var_order_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_statuses := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	closure_4_fn := fn [var_order_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_statuses := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	mut var_cache_keys := rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_order_statuses_mutated.clone()])
	if rt.is_true(var_flush_saved_statuses) {
		var_cache_keys.array_push(this.get_saved_statuses_cache_key(order_type_mutated))
	}
	rt.call_function('wp_cache_delete_multiple', [var_cache_keys.clone()])
}

fn create_automattic_woocommerce_caches_ordercountcache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Caches_OrderCountCache {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCountCache{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_prefix: rt.new_string('order-count')
		expiration: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_saved_statuses_for_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_saved_statuses_for_type(dispatch_arg_0)
		}
		'ensure_statuses_for_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.ensure_statuses_for_type(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_default_statuses' {
			return this.get_default_statuses()
		}
		'get_cache_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_cache_key(dispatch_arg_0, dispatch_arg_1))
		}
		'get_saved_statuses_cache_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_saved_statuses_cache_key(dispatch_arg_0))
		}
		'is_cached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_cached(dispatch_arg_0, dispatch_arg_1))
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'set_multiple' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.set_multiple(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'increment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.increment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'decrement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.decrement(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'flush' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.flush(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_prefix' { return this.cache_prefix }
		'expiration' { return this.expiration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache_prefix' { this.cache_prefix = val; return true }
		'expiration' { this.expiration = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}

import rt

pub fn Class_Automattic_WooCommerce_Caching_ObjectCache.default_expiration() rt.PhpVal {
	return // unsupported expression: Expr_UnaryMinus
}
pub fn Class_Automattic_WooCommerce_Caching_ObjectCache.max_expiration() rt.PhpVal {
	return rt.get_constant('MONTH_IN_SECONDS')
}
struct Class_Automattic_WooCommerce_Caching_ObjectCache {
	rt.PhpObjectBase
pub mut:
		object_type rt.PhpVal = rt.new_null()
		default_expiration rt.PhpVal = rt.new_null()
		last_cached_data rt.PhpVal = rt.new_null()
		cache_engine rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_object_type() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) construct()  {
	this.object_type = this.get_object_type()
	if !rt.is_true(this.object_type) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception('Class ' + (rt.call_function('get_class', [rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this)])).str() + ' returns an empty value for get_object_type', rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup())))
	}
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_default_expiration_value() i64 {
	return (this.default_expiration).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_cache_engine() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.cache_engine)) {
		mut var_engine := this.get_cache_engine_instance()
		this.cache_engine = rt.call_function('apply_filters', [rt.new_string('wc_object_cache_get_engine'), var_engine.dup(), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this)])
	}
	return this.cache_engine
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) set(var_object rt.PhpVal, var_id rt.PhpVal, expiration i64) bool {
	mut var_object_mutated := var_object
	mut var_id_mutated := var_id
	if rt.is_true(rt.identical(rt.new_null(), var_object_mutated)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Can\'t cache a null value'), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup(), var_id_mutated.dup())))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_object_mutated.dup().is_array()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_object_mutated.dup().is_object()))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Can\'t cache a non-object, non-array value'), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup(), var_id_mutated.dup())))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_id_mutated.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_id_mutated.dup().is_long()))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_id_mutated.dup().is_null()))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Object id must be an int, a string, or null for \'set\''), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup(), var_id_mutated.dup())))
	}
	this.verify_expiration_value(expiration)
	mut var_errors := this.validate(var_object_mutated.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_errors.dup().is_null()))))) {
		var_id_mutated = this.get_id_from_object_if_null(var_object_mutated.dup(), var_id_mutated.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Caching_Throwable') {
			mut var_ex := var_e_1.dup()
			// unsupported statement: Stmt_Nop
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		if var_errors.dup().array_count() == 1 {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception('Object validation/serialization failed: ' + (var_errors.array_get(0)).str(), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup(), var_id_mutated.dup(), var_errors.dup())))
		} else if !(!rt.is_true(var_errors)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Object validation/serialization failed'), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup(), var_id_mutated.dup(), var_errors.dup())))
		}
	}
	var_id_mutated = this.get_id_from_object_if_null(var_object_mutated.dup(), var_id_mutated.dup())
	this.last_cached_data = var_object_mutated.dup()
	return (rt.call_method(this.get_cache_engine(), 'cache_object', [var_id_mutated.dup(), var_object_mutated.dup(), if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Caching_Automattic_WooCommerce_Caching_ObjectCache.default_expiration(), rt.new_int(expiration))) { this.default_expiration } else { rt.new_int(expiration) }, this.get_object_type()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) update_if_cached(var_object rt.PhpVal, var_id rt.PhpVal, expiration i64) bool {
	mut var_object_mutated := var_object
	mut var_id_mutated := var_id
	var_id_mutated = this.get_id_from_object_if_null(var_object_mutated.dup(), var_id_mutated.dup())
	if !(this.is_cached(var_id_mutated.dup())) {
		return false
	}
	return this.set(var_object_mutated.dup(), var_id_mutated.dup(), expiration)
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_id_from_object_if_null(var_object rt.PhpVal, var_id rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_id_mutated := var_id
	if rt.is_true(rt.identical(rt.new_null(), var_id_mutated)) {
		var_id_mutated = this.get_object_id(var_object_mutated.dup())
		if rt.is_true(rt.identical(rt.new_null(), var_id_mutated)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Null id supplied and the cache class doesn\'t implement get_object_id'), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup())))
		}
	}
	return var_id_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) verify_expiration_value(expiration i64)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(expiration < 1 || rt.is_true(rt.greater(rt.new_int(expiration), Class_Automattic_WooCommerce_Caching_Automattic_WooCommerce_Caching_ObjectCache.max_expiration())))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Invalid expiration value, must be ObjectCache::DEFAULT_EXPIRATION or a value between 1 and ObjectCache::MAX_EXPIRATION'), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup())))
	}
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get(var_id rt.PhpVal, expiration i64, mut var_get_from_datastore_callback Class_Automattic_WooCommerce_Caching_?callable) rt.PhpVal {
	mut var_id_mutated := var_id
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_id_mutated.dup().is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_id_mutated.dup().is_long()))))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Caching_CacheException', []string{}, create_automattic_woocommerce_caching_cacheexception(rt.new_string('Object id must be an int or a string for \'get\''), rt.new_object('Automattic_WooCommerce_Caching_ObjectCache', []string{}, &this).dup())))
	}
	this.verify_expiration_value(expiration)
	mut var_data := rt.call_method(this.get_cache_engine(), 'get_cached_object', [var_id_mutated.dup(), this.get_object_type()])
	if rt.is_true(rt.identical(rt.new_null(), var_data)) {
		mut var_object := rt.new_null()
		if rt.is_true(var_get_from_datastore_callback) {
			var_object = rt.call_callable(var_get_from_datastore_callback, [var_id_mutated.dup()])
		}
		if rt.is_true(rt.identical(rt.new_null(), var_object)) {
			return rt.new_null()
		}
		this.set(var_object.dup(), var_id_mutated.dup(), expiration)
		var_data = this.last_cached_data
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) remove(var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
	return (rt.call_method(this.get_cache_engine(), 'delete_cached_object', [var_id_mutated.dup(), this.get_object_type()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) flush() bool {
	return (rt.call_method(this.get_cache_engine(), 'delete_cache_group', [this.get_object_type()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) is_cached(var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
	return (rt.call_method(this.get_cache_engine(), 'is_cached', [var_id_mutated.dup(), this.get_object_type()])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_object_id(var_object rt.PhpVal)  {
	mut var_object_mutated := var_object
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) validate(var_object rt.PhpVal)  {
	mut var_object_mutated := var_object
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_cache_engine_instance() rt.PhpVal {
	return rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) get_random_string() string {
	return (rt.call_function('dechex', [rt.mul(rt.call_function('microtime', [rt.new_bool(true)]), rt.new_int(1000))])).str() + (rt.call_function('bin2hex', [rt.call_function('random_bytes', [rt.new_int(8)])])).str()
}

struct Class_Automattic_WooCommerce_Caching_CacheException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_caching_objectcache() &Class_Automattic_WooCommerce_Caching_ObjectCache {
	mut obj := &Class_Automattic_WooCommerce_Caching_ObjectCache{
		PhpObjectBase: rt.PhpObjectBase{}
		object_type: rt.new_null()
		default_expiration: rt.new_null()
		last_cached_data: rt.new_null()
		cache_engine: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_caching_cacheexception() &Class_Automattic_WooCommerce_Caching_CacheException {
	mut obj := &Class_Automattic_WooCommerce_Caching_CacheException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_object_type' {
			return rt.new_string(this.get_object_type())
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_default_expiration_value' {
			return rt.new_int(this.get_default_expiration_value())
		}
		'get_cache_engine' {
			return this.get_cache_engine()
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'update_if_cached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.update_if_cached(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_id_from_object_if_null' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_id_from_object_if_null(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_expiration_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.verify_expiration_value(dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caching_?callable](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove(dispatch_arg_0))
		}
		'flush' {
			return rt.new_bool(this.flush())
		}
		'is_cached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_cached(dispatch_arg_0))
		}
		'get_object_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_object_id(dispatch_arg_0)
			return rt.new_null()
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.validate(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cache_engine_instance' {
			return this.get_cache_engine_instance()
		}
		'get_random_string' {
			return rt.new_string(this.get_random_string())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Caching_ObjectCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object_type' { return this.object_type }
		'default_expiration' { return this.default_expiration }
		'last_cached_data' { return this.last_cached_data }
		'cache_engine' { return this.cache_engine }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object_type' { this.object_type = val; return true }
		'default_expiration' { this.default_expiration = val; return true }
		'last_cached_data' { this.last_cached_data = val; return true }
		'cache_engine' { this.cache_engine = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Caching_CacheException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_caching_objectcache_php() {
}

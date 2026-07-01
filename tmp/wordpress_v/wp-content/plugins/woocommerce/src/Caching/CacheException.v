import rt

struct Class_Automattic_WooCommerce_Caching_CacheException {
	rt.PhpObjectBase
pub mut:
		errors rt.PhpVal = rt.new_null()
		thrower rt.PhpVal = rt.new_null()
		cached_id rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) construct(message string, mut var_thrower Class_Automattic_WooCommerce_Caching_ObjectCache, var_cached_id rt.PhpVal, mut var_errors Class_Automattic_WooCommerce_Caching_?array, code i64, mut var_previous Class_Automattic_WooCommerce_Caching_?Throwable)  {
	this.errors = if !(var_errors).is_null() { var_errors } else { rt.new_array() }
	this.thrower = var_thrower.dup()
	this.cached_id = var_cached_id.dup()
	this.Class_Automattic_WooCommerce_Caching_Exception.construct(rt.new_string(message), rt.new_int(code), rt.new_object('Automattic_WooCommerce_Caching_?Throwable', []string{}, var_previous))
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) magic_tostring() string {
	mut var_cached_id_part := rt.new_string(if rt.is_true(this.cached_id) { rt.concat(rt.new_string(', id: '), this.cached_id) } else { rt.new_string('') })
	return rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CacheException: ['), rt.call_method(this.thrower, 'get_object_type', []rt.PhpVal{})), var_cached_id_part), rt.new_string(']: ')), rt.get_property(rt.new_object('Automattic_WooCommerce_Caching_CacheException', ['Automattic_WooCommerce_Caching_Exception'], &this), 'message'))
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) get_errors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) get_thrower() rt.PhpVal {
	return this.thrower
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) get_cached_id() rt.PhpVal {
	return this.cached_id
}

struct Class_Automattic_WooCommerce_Caching_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_caching_cacheexception(message string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, code i64, arg_5 rt.PhpVal) &Class_Automattic_WooCommerce_Caching_CacheException {
	mut obj := &Class_Automattic_WooCommerce_Caching_CacheException{
		PhpObjectBase: rt.PhpObjectBase{}
		errors: rt.new_null()
		thrower: rt.new_null()
		cached_id: rt.new_null()
	}
	obj.construct(message, arg_1, arg_2, arg_3, code, arg_5)
	return obj
}

fn create_automattic_woocommerce_caching_exception() &Class_Automattic_WooCommerce_Caching_Exception {
	mut obj := &Class_Automattic_WooCommerce_Caching_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caching_ObjectCache](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caching_?array](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caching_?Throwable](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_errors' {
			return this.get_errors()
		}
		'get_thrower' {
			return this.get_thrower()
		}
		'get_cached_id' {
			return this.get_cached_id()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Caching_CacheException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'errors' { return this.errors }
		'thrower' { return this.thrower }
		'cached_id' { return this.cached_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Caching_CacheException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'errors' { this.errors = val; return true }
		'thrower' { this.thrower = val; return true }
		'cached_id' { this.cached_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Caching_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Caching_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caching_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_caching_cacheexception_php() {
}

import rt

struct Class_SimplePie_Cache_BaseDataCache {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) construct(mut var_cache Class_SimplePie_Cache_Base) {
	this.cache = var_cache
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) get_data(key string, var_default rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_method(this.cache, 'load', []rt.PhpVal{})
	if !(var_data.clone().is_array()) {
		return var_default.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.clone().array_isset(rt.new_string('__cache_expiration_time'))))))) {
		return var_default.clone()
	}
	if rt.is_true(rt.less(var_data.array_get(rt.new_string('__cache_expiration_time')), rt.call_function('time', []rt.PhpVal{}))) {
		return var_default.clone()
	}
	var_data.array_unset(rt.new_string('__cache_expiration_time'))
	return var_data.clone()
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) set_data(key string, mut var_value Class_SimplePie_Cache_array, mut var_ttl Class_SimplePie_Cache_?int) bool {
	mut var_value_mutated := var_value
	mut var_ttl_mutated := var_ttl
	if rt.is_true(rt.identical(var_ttl_mutated, rt.new_null())) {
	var_ttl_mutated = rt.new_int(3600)
	}
	var_value_mutated.array_set('__cache_expiration_time', rt.add(rt.call_function('time', []rt.PhpVal{}), var_ttl_mutated))
	return (rt.call_method(this.cache, 'save', [var_value_mutated])).to_bool()
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) delete_data(key string) bool {
	return (rt.call_method(this.cache, 'unlink', []rt.PhpVal{})).to_bool()
}

fn create_simplepie_cache_basedatacache(arg_0 rt.PhpVal) &Class_SimplePie_Cache_BaseDataCache {
	mut obj := &Class_SimplePie_Cache_BaseDataCache{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Cache_Base](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_data(dispatch_arg_0, dispatch_arg_1)
		}
		'set_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_Cache_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_Cache_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.set_data(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'delete_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete_data(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Cache_BaseDataCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' { this.cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}

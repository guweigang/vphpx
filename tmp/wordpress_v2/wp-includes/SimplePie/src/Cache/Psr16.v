import rt

struct Class_SimplePie_Cache_Psr16 {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_Psr16) construct(mut var_cache Class_Psr_SimpleCache_CacheInterface) {
	this.cache = var_cache
}

fn (mut this Class_SimplePie_Cache_Psr16) get_data(key string, var_default rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_method(this.cache, 'get', [rt.new_string(key), var_default.clone()])
	if !(var_data.clone().is_array()) || rt.is_true(rt.identical(var_data, var_default)) {
		return var_default.clone()
	}
	return var_data.clone()
}

fn (mut this Class_SimplePie_Cache_Psr16) set_data(key string, mut var_value Class_SimplePie_Cache_array, mut var_ttl Class_SimplePie_Cache_?int) bool {
	return (rt.call_method(this.cache, 'set', [rt.new_string(key), var_value, var_ttl])).to_bool()
}

fn (mut this Class_SimplePie_Cache_Psr16) delete_data(key string) bool {
	return (rt.call_method(this.cache, 'delete', [rt.new_string(key)])).to_bool()
}

fn create_simplepie_cache_psr16(arg_0 rt.PhpVal) &Class_SimplePie_Cache_Psr16 {
	mut obj := &Class_SimplePie_Cache_Psr16{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_SimplePie_Cache_Psr16) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_SimpleCache_CacheInterface](if args.len > 0 { args[0] } else { rt.new_null() })
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

fn (this &Class_SimplePie_Cache_Psr16) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_Psr16) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

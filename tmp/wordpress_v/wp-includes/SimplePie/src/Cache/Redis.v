import rt

struct Class_SimplePie_Cache_Redis {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_Redis) construct(location string, name string, var_options rt.PhpVal)  {
	mut var_parsed := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_Cache_SimplePie_Cache{}; return temp.parse_url(arg_0) }(rt.new_string(location))
	mut var_redis := create_redis()
	var_redis.connect(var_parsed.array_get('host'), var_parsed.array_get('port'))
	if var_parsed.array_isset(rt.new_string('pass')) {
		var_redis.auth(var_parsed.array_get('pass'))
	}
	if var_parsed.array_isset(rt.new_string('path')) {
		var_redis.select(// unsupported expression: Expr_Cast_Int)
	}
	this.cache = var_redis.dup()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_options.dup().is_null()))))) && rt.is_true(rt.new_bool(var_options.dup().is_array())))) {
		this.options = var_options.dup()
	} else {
		this.options = rt.create_array([rt.ArrayItem{ key: 'prefix', val: 'rss:simple_primary:' }, rt.ArrayItem{ key: 'expire', val: 0 }])
	}
	this.name = (this.options.array_get('prefix')).str() + name
}

fn (mut this Class_SimplePie_Cache_Redis) setredisclient(mut var_cache Class_Redis)  {
	this.cache = var_cache.dup()
}

fn (mut this Class_SimplePie_Cache_Redis) save(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'SimplePie_Cache_SimplePie_SimplePie'))) {
		var_data_mutated = rt.get_property(var_data_mutated, 'data')
	}
	mut var_response := rt.call_method(this.cache, 'set', [this.name, rt.call_function('serialize', [var_data_mutated.dup()])])
	if rt.is_true(this.options.array_get('expire')) {
		rt.call_method(this.cache, 'expire', [this.name, this.options.array_get('expire')])
	}
	return var_response.dup()
}

fn (mut this Class_SimplePie_Cache_Redis) load() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('unserialize', [var_data.dup()])).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Redis) mtime() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('time', []rt.PhpVal{})).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Redis) touch() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_return := rt.call_method(this.cache, 'set', [this.name, var_data.dup()])
		if rt.is_true(this.options.array_get('expire')) {
			return (rt.call_method(this.cache, 'expire', [this.name, this.options.array_get('expire')])).to_bool()
		}
		return (var_return).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Redis) unlink() rt.PhpVal {
	return rt.call_method(this.cache, 'set', [this.name, rt.new_null()])
}

struct Class_SimplePie_Cache_SimplePie_Cache {
	rt.PhpObjectBase
}

struct Class_Redis {
	rt.PhpObjectBase
}

fn create_simplepie_cache_redis(location string, name string, arg_2 rt.PhpVal) &Class_SimplePie_Cache_Redis {
	mut obj := &Class_SimplePie_Cache_Redis{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_null()
		options: rt.new_null()
		name: rt.new_null()
	}
	obj.construct(location, name, arg_2)
	return obj
}

fn create_simplepie_cache_simplepie_cache() &Class_SimplePie_Cache_SimplePie_Cache {
	mut obj := &Class_SimplePie_Cache_SimplePie_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_redis() &Class_Redis {
	mut obj := &Class_Redis{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Cache_Redis) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'setRedisClient' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Redis](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setredisclient(mut dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save(dispatch_arg_0)
		}
		'load' {
			return rt.new_bool(this.load())
		}
		'mtime' {
			return rt.new_bool(this.mtime())
		}
		'touch' {
			return rt.new_bool(this.touch())
		}
		'unlink' {
			return this.unlink()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Cache_Redis) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		'options' { return this.options }
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_Redis) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' { this.cache = val; return true }
		'options' { this.options = val; return true }
		'name' { this.name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_SimplePie_Cache_SimplePie_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_SimplePie_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_SimplePie_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Redis) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Redis) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Redis) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_cache_redis_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\Redis'), rt.new_string('SimplePie_Cache_Redis')])
}

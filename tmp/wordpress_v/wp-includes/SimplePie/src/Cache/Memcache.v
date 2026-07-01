import rt
import crypto.md5

struct Class_SimplePie_Cache_Memcache {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_Memcache) construct(location string, name string, var_type rt.PhpVal)  {
	this.options = rt.create_array([rt.ArrayItem{ key: 'host', val: '127.0.0.1' }, rt.ArrayItem{ key: 'port', val: 11211 }, rt.ArrayItem{ key: 'extras', val: rt.create_array([rt.ArrayItem{ key: 'timeout', val: 3600 }, rt.ArrayItem{ key: 'prefix', val: 'simplepie_' }]) }])
	this.options = rt.call_function('array_replace_recursive', [this.options, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_Cache_SimplePie_Cache{}; return temp.parse_url(arg_0) }(rt.new_string(location))])
	this.name = (this.options.array_get('extras').array_get('prefix')).str() + md5.hexhash("${var_name}:${var_type.to_string()}")
	this.cache = create_memcache()
	rt.call_method(this.cache, 'addServer', [this.options.array_get('host'), // unsupported expression: Expr_Cast_Int])
}

fn (mut this Class_SimplePie_Cache_Memcache) save(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'SimplePie_Cache_SimplePie_SimplePie'))) {
		var_data_mutated = rt.get_property(var_data_mutated, 'data')
	}
	return rt.call_method(this.cache, 'set', [this.name, rt.call_function('serialize', [var_data_mutated.dup()]), rt.get_constant('MEMCACHE_COMPRESSED'), // unsupported expression: Expr_Cast_Int])
}

fn (mut this Class_SimplePie_Cache_Memcache) load() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('unserialize', [var_data.dup()])).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Memcache) mtime() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('time', []rt.PhpVal{})).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Memcache) touch() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_method(this.cache, 'set', [this.name, var_data.dup(), rt.get_constant('MEMCACHE_COMPRESSED'), // unsupported expression: Expr_Cast_Int])).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Memcache) unlink() rt.PhpVal {
	return rt.call_method(this.cache, 'delete', [this.name, rt.new_int(0)])
}

struct Class_SimplePie_Cache_SimplePie_Cache {
	rt.PhpObjectBase
}

struct Class_Memcache {
	rt.PhpObjectBase
}

fn create_simplepie_cache_memcache(location string, name string, arg_2 rt.PhpVal) &Class_SimplePie_Cache_Memcache {
	mut obj := &Class_SimplePie_Cache_Memcache{
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

fn create_memcache() &Class_Memcache {
	mut obj := &Class_Memcache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Cache_Memcache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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

fn (this &Class_SimplePie_Cache_Memcache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		'options' { return this.options }
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_Memcache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Memcache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Memcache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Memcache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_cache_memcache_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\Memcache'), rt.new_string('SimplePie_Cache_Memcache')])
}

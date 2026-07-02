import rt
import crypto.md5

struct Class_SimplePie_Cache_Memcached {
	rt.PhpObjectBase
pub mut:
	cache   rt.PhpVal = rt.new_null()
	options rt.PhpVal = rt.new_null()
	name    rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_Memcached) construct(location string, name string, var_type rt.PhpVal) {
	this.options = rt.create_array([rt.ArrayItem{ key: 'host', val: '127.0.0.1' },
		rt.ArrayItem{ key: 'port', val: 11211 }, rt.ArrayItem{ key: 'extras', val: rt.create_array([
			rt.ArrayItem{ key: 'timeout', val: 3600 },
			rt.ArrayItem{ key: 'prefix', val: 'simplepie_' },
		]) }])
	mut iife_temp_0 := Class_SimplePie_Cache_SimplePie_Cache{}
	mut iife_result_0 := iife_temp_0.parse_url(rt.new_string(location))
	this.options = rt.call_function('array_replace_recursive', [this.options, iife_result_0])
	this.name =
		(this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() +
		md5.hexhash('${var_name}:${var_type.to_string()}')
	this.cache = create_memcached()
	rt.call_method(this.cache, 'addServer', [this.options.array_get(rt.new_string('host')),
		rt.new_int((this.options.array_get(rt.new_string('port'))).to_i64())])
}

fn (mut this Class_SimplePie_Cache_Memcached) save(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated,
		'SimplePie_Cache_SimplePie_SimplePie')))
	{
		var_data_mutated = rt.get_property(var_data_mutated, 'data')
	}
	return rt.new_bool(this.setdata(rt.call_function('serialize', [
		var_data_mutated.clone()])))
}

fn (mut this Class_SimplePie_Cache_Memcached) load() bool {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data, rt.new_bool(false))))) {
		return (rt.call_function('unserialize', [var_data.clone()])).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_Memcached) mtime() i64 {
	mut var_data := rt.call_method(this.cache, 'get', [
		rt.new_string((this.name).str() + '_mtime'),
	])
	return rt.new_int(var_data.to_i64())
}

fn (mut this Class_SimplePie_Cache_Memcached) touch() rt.PhpVal {
	mut var_data := rt.call_method(this.cache, 'get', [this.name])
	return rt.new_bool(this.setdata(var_data.clone()))
}

fn (mut this Class_SimplePie_Cache_Memcached) unlink() rt.PhpVal {
	return rt.call_method(this.cache, 'delete', [this.name, rt.new_int(0)])
}

fn (mut this Class_SimplePie_Cache_Memcached) setdata(var_data rt.PhpVal) bool {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data_mutated, rt.new_bool(false))))) {
		rt.call_method(this.cache, 'set', [rt.new_string((this.name).str() + '_mtime'),
			rt.call_function('time', []rt.PhpVal{}),
			rt.new_int((this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('timeout'))).to_i64())])
		return (rt.call_method(this.cache, 'set', [this.name, var_data_mutated.clone(),
			rt.new_int((this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('timeout'))).to_i64())])).to_bool()
	}
	return false
}

struct Class_SimplePie_Cache_SimplePie_Cache {
	rt.PhpObjectBase
}

struct Class_Memcached {
	rt.PhpObjectBase
}

fn create_simplepie_cache_memcached(location string, name string, arg_2 rt.PhpVal) &Class_SimplePie_Cache_Memcached {
	mut obj := &Class_SimplePie_Cache_Memcached{
		PhpObjectBase: rt.PhpObjectBase{}
		cache:         rt.new_null()
		options:       rt.new_null()
		name:          rt.new_null()
	}
	obj.construct(location, name, arg_2)
	return obj
}

fn create_simplepie_cache_simplepie_cache(_args ...rt.PhpVal) &Class_SimplePie_Cache_SimplePie_Cache {
	mut obj := &Class_SimplePie_Cache_SimplePie_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_memcached(_args ...rt.PhpVal) &Class_Memcached {
	mut obj := &Class_Memcached{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Cache_Memcached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return rt.new_int(this.mtime())
		}
		'touch' {
			return this.touch()
		}
		'unlink' {
			return this.unlink()
		}
		'setData' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.setdata(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Cache_Memcached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		'options' { return this.options }
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_Memcached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' {
			this.cache = val
			return true
		}
		'options' {
			this.options = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Memcached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Memcached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Memcached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\Memcached'),
		rt.new_string('SimplePie_Cache_Memcached')])
}

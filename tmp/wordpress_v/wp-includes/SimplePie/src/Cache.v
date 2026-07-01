import rt

struct Class_SimplePie_Cache {
	rt.PhpObjectBase
pub mut:
		handlers rt.PhpVal = rt.new_array()
}

fn (mut this Class_SimplePie_Cache) construct()  {
}

fn Class_SimplePie_Cache.get_handler(location string, filename string, var_extension rt.PhpVal) rt.PhpVal {
	mut var_type := rt.call_function('explode', [rt.new_string(':'), rt.new_string(location), rt.new_int(2)])
	var_type = var_type.array_get(0)
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_type))) {
		mut var_class := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_type)
		return rt.create_object_dynamically(var_class, [rt.new_string(location), rt.new_string(filename), var_extension.dup()])
	}
	return create_simplepie_simplepie_cache_file(rt.new_string(location).dup(), rt.new_string(filename).dup(), var_extension.dup())
}

fn (mut this Class_SimplePie_Cache) create(location string, filename string, var_extension rt.PhpVal) rt.PhpVal {
	rt.call_function('trigger_error', [rt.new_string('Cache::create() has been replaced with Cache::get_handler() since SimplePie 1.3.1, use the registry system instead.'), rt.get_constant('E_USER_DEPRECATED')])
	return Class_SimplePie_Cache.get_handler(location, filename, var_extension.dup())
}

fn Class_SimplePie_Cache.register(type string, var_class rt.PhpVal)  {
	mut type_mutated := type
	mut var_class_mutated := var_class
	// unsupported expression: Expr_StaticPropertyFetch.array_set(type_mutated, var_class_mutated.dup())
}

fn Class_SimplePie_Cache.parse_url(url string) rt.PhpVal {
	mut var_parsedUrl := rt.call_function('parse_url', [rt.new_string(url)])
	if rt.is_true(rt.identical(var_parsedUrl, rt.new_bool(false))) {
		return rt.new_array()
	}
	mut var_params := rt.call_function('array_merge', [var_parsedUrl.dup(), rt.create_array([rt.ArrayItem{ key: 'extras', val: rt.new_array() }])])
	if var_params.array_isset(rt.new_string('query')) {
		rt.call_function('parse_str', [var_params.array_get('query'), var_params.array_get('extras')])
	}
	return var_params.dup()
}

struct Class_SimplePie_SimplePie_Cache_File {
	rt.PhpObjectBase
}

fn create_simplepie_cache() &Class_SimplePie_Cache {
	mut obj := &Class_SimplePie_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
		handlers: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_simplepie_simplepie_cache_file() &Class_SimplePie_SimplePie_Cache_File {
	mut obj := &Class_SimplePie_SimplePie_Cache_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_handler' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_SimplePie_Cache.get_handler(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'create' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.create(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_SimplePie_Cache.register(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_URL' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_SimplePie_Cache.parse_url(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'handlers' { return this.handlers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'handlers' { this.handlers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_SimplePie_SimplePie_Cache_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_Cache_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_Cache_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('SimplePie_Cache', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_simplepie_cache()
		return rt.new_object('SimplePie_Cache', []string{}, obj)
	})
	rt.register_class_factory('SimplePie_SimplePie_Cache_File', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_simplepie_simplepie_cache_file()
		return rt.new_object('SimplePie_SimplePie_Cache_File', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_simplepie_src_cache_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache'), rt.new_string('SimplePie_Cache')])
}

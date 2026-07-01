import rt

struct Class_SimplePie_HTTP_FileClient {
	rt.PhpObjectBase
pub mut:
		registry rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_HTTP_FileClient) construct(mut var_registry Class_SimplePie_Registry, mut var_options Class_SimplePie_HTTP_array)  {
	this.registry = var_registry.dup()
	this.options = var_options.dup()
}

fn (mut this Class_SimplePie_HTTP_FileClient) request(method string, url string, mut var_headers Class_SimplePie_HTTP_array) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('%s(): Argument #1 ($method) only supports method "%s".'), rt.new_string(@METHOD), Class_SimplePie_HTTP_SimplePie_HTTP_FileClient.method_get()]), rt.new_int(1))))
	}
	mut var_file := rt.call_method(this.registry, 'create', [Class_SimplePie_File.class(), rt.create_array([rt.ArrayItem{ key: none, val: url }, rt.ArrayItem{ key: none, val: if !(this.options.array_get('timeout')).is_null() { this.options.array_get('timeout') } else { rt.new_int(10) } }, rt.ArrayItem{ key: none, val: if !(this.options.array_get('redirects')).is_null() { this.options.array_get('redirects') } else { rt.new_int(5) } }, rt.ArrayItem{ key: none, val: var_headers }, rt.ArrayItem{ key: none, val: if !(this.options.array_get('useragent')).is_null() { this.options.array_get('useragent') } else { fn () rt.PhpVal { mut temp := Class_SimplePie_Misc{}; return temp.get_default_useragent() }() } }, rt.ArrayItem{ key: none, val: if !(this.options.array_get('force_fsockopen')).is_null() { this.options.array_get('force_fsockopen') } else { rt.new_bool(false) } }, rt.ArrayItem{ key: none, val: if !(this.options.array_get('curl_options')).is_null() { this.options.array_get('curl_options') } else { rt.new_array() } }])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_th := var_e_1.dup()
		rt.throw_exception(rt.new_object('SimplePie_HTTP_ClientException', []string{}, create_simplepie_http_clientexception(rt.call_method(var_th, 'getMessage', []rt.PhpVal{}), rt.call_method(var_th, 'getCode', []rt.PhpVal{}), var_th.dup())))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('SimplePie_HTTP_ClientException', []string{}, create_simplepie_http_clientexception(rt.get_property(var_file, 'error'))))
	}
	return var_file.dup()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_ClientException {
	rt.PhpObjectBase
}

fn create_simplepie_http_fileclient(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_SimplePie_HTTP_FileClient {
	mut obj := &Class_SimplePie_HTTP_FileClient{
		PhpObjectBase: rt.PhpObjectBase{}
		registry: rt.new_null()
		options: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_misc() &Class_SimplePie_Misc {
	mut obj := &Class_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_clientexception() &Class_SimplePie_HTTP_ClientException {
	mut obj := &Class_SimplePie_HTTP_ClientException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_HTTP_FileClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_HTTP_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_HTTP_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.request(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_HTTP_FileClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registry' { return this.registry }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_HTTP_FileClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registry' { this.registry = val; return true }
		'options' { this.options = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_HTTP_ClientException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_ClientException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_ClientException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_http_fileclient_php() {
	// unsupported statement: Stmt_Declare
}

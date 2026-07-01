import rt

struct Class_WpOrg_Requests_Response {
	rt.PhpObjectBase
pub mut:
		body rt.PhpVal = rt.new_string('')
		raw rt.PhpVal = rt.new_string('')
		headers rt.PhpVal = rt.new_array()
		status_code rt.PhpVal = rt.new_bool(false)
		protocol_version rt.PhpVal = rt.new_bool(false)
		success rt.PhpVal = rt.new_bool(false)
		redirects rt.PhpVal = rt.new_int(0)
		url rt.PhpVal = rt.new_string('')
		history rt.PhpVal = rt.new_array()
		cookies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WpOrg_Requests_Response) construct()  {
	this.headers = create_wporg_requests_response_headers()
	this.cookies = create_wporg_requests_cookie_jar()
}

fn (mut this Class_WpOrg_Requests_Response) is_redirect() bool {
	mut var_code := this.status_code
	return rt.is_true(rt.call_function('in_array', [var_code.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 300 }, rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }, rt.ArrayItem{ key: none, val: 303 }, rt.ArrayItem{ key: none, val: 307 }]), rt.new_bool(true)])) || rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_code, rt.new_int(307))) && rt.is_true(rt.less(var_code, rt.new_int(400)))))
}

fn (mut this Class_WpOrg_Requests_Response) throw_for_status(allow_redirects bool)  {
	if this.is_redirect() {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Redirection not allowed'), rt.new_string('response.no_redirects'), rt.new_object('WpOrg_Requests_Response', []string{}, &this).dup())))
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(this.success)))) {
		mut var_exception := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_Http{}; return temp.get_class(arg_0) }(this.status_code)
		rt.throw_exception(rt.new_object('', []string{}, rt.create_object_dynamically(var_exception, [rt.new_null(), rt.new_object('WpOrg_Requests_Response', []string{}, &this)])))
	}
}

fn (mut this Class_WpOrg_Requests_Response) decode_body(associative bool, depth i64, options i64) rt.PhpVal {
	mut var_data := rt.call_function('json_decode', [this.body, rt.new_bool(associative), rt.new_int(depth), rt.new_int(options)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_last_error := rt.call_function('json_last_error_msg', []rt.PhpVal{})
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception('Unable to parse JSON data: ' + (var_last_error).str(), rt.new_string('response.invalid'), rt.new_object('WpOrg_Requests_Response', []string{}, &this).dup())))
	}
	return var_data.dup()
}

struct Class_WpOrg_Requests_Response_Headers {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Cookie_Jar {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_Http {
	rt.PhpObjectBase
}

fn create_wporg_requests_response() &Class_WpOrg_Requests_Response {
	mut obj := &Class_WpOrg_Requests_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		body: rt.new_string('')
		raw: rt.new_string('')
		headers: rt.new_array()
		status_code: rt.new_bool(false)
		protocol_version: rt.new_bool(false)
		success: rt.new_bool(false)
		redirects: rt.new_int(0)
		url: rt.new_string('')
		history: rt.new_array()
		cookies: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wporg_requests_response_headers() &Class_WpOrg_Requests_Response_Headers {
	mut obj := &Class_WpOrg_Requests_Response_Headers{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_cookie_jar() &Class_WpOrg_Requests_Cookie_Jar {
	mut obj := &Class_WpOrg_Requests_Cookie_Jar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception() &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_http() &Class_WpOrg_Requests_Exception_Http {
	mut obj := &Class_WpOrg_Requests_Exception_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_redirect' {
			return rt.new_bool(this.is_redirect())
		}
		'throw_for_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.throw_for_status(dispatch_arg_0)
			return rt.new_null()
		}
		'decode_body' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.decode_body(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'body' { return this.body }
		'raw' { return this.raw }
		'headers' { return this.headers }
		'status_code' { return this.status_code }
		'protocol_version' { return this.protocol_version }
		'success' { return this.success }
		'redirects' { return this.redirects }
		'url' { return this.url }
		'history' { return this.history }
		'cookies' { return this.cookies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'body' { this.body = val; return true }
		'raw' { this.raw = val; return true }
		'headers' { this.headers = val; return true }
		'status_code' { this.status_code = val; return true }
		'protocol_version' { this.protocol_version = val; return true }
		'success' { this.success = val; return true }
		'redirects' { this.redirects = val; return true }
		'url' { this.url = val; return true }
		'history' { this.history = val; return true }
		'cookies' { this.cookies = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WpOrg_Requests_Response_Headers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Response_Headers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Response_Headers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Cookie_Jar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Cookie_Jar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WpOrg_Requests_Response', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_response()
		return rt.new_object('WpOrg_Requests_Response', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Response_Headers', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_response_headers()
		return rt.new_object('WpOrg_Requests_Response_Headers', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Cookie_Jar', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_cookie_jar()
		return rt.new_object('WpOrg_Requests_Cookie_Jar', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception()
		return rt.new_object('WpOrg_Requests_Exception', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_Http', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_http()
		return rt.new_object('WpOrg_Requests_Exception_Http', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_requests_src_response_php() {
}

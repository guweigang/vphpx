import rt

struct Class_WpOrg_Requests_Proxy_Http {
	rt.PhpObjectBase
pub mut:
		proxy rt.PhpVal = rt.new_null()
		user rt.PhpVal = rt.new_null()
		pass rt.PhpVal = rt.new_null()
		use_authentication bool
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) construct(var_args rt.PhpVal)  {
	if rt.is_true(rt.new_bool(var_args.dup().is_string())) {
		this.proxy = var_args.dup()
	} else if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
		if var_args.dup().array_count() == 1 {
			// unsupported assign target: Expr_List
		} else if var_args.dup().array_count() == 3 {
			// unsupported assign target: Expr_List
			this.use_authentication = true
		} else {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_ArgumentCount{}; return temp.create(arg_0, arg_1, arg_2) }(rt.new_string('an array with exactly one element or exactly three elements'), rt.new_int(var_args.dup().array_count()), rt.new_string('proxyhttpbadargs')))
		}
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$args'), rt.new_string('array|string|null'), rt.call_function('gettype', [var_args.dup()])))
	}
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) register(mut var_hooks Class_WpOrg_Requests_Hooks)  {
	var_hooks.register(rt.new_string('curl.before_send'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Proxy_Http', ['Proxy'], &this) }, rt.ArrayItem{ key: none, val: 'curl_before_send' }]))
	var_hooks.register(rt.new_string('fsockopen.remote_socket'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Proxy_Http', ['Proxy'], &this) }, rt.ArrayItem{ key: none, val: 'fsockopen_remote_socket' }]))
	var_hooks.register(rt.new_string('fsockopen.remote_host_path'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Proxy_Http', ['Proxy'], &this) }, rt.ArrayItem{ key: none, val: 'fsockopen_remote_host_path' }]))
	if rt.is_true(this.use_authentication) {
		var_hooks.register(rt.new_string('fsockopen.after_headers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Proxy_Http', ['Proxy'], &this) }, rt.ArrayItem{ key: none, val: 'fsockopen_header' }]))
	}
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) curl_before_send(var_handle rt.PhpVal)  {
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYTYPE'), rt.get_constant('CURLPROXY_HTTP')])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXY'), this.proxy])
	if rt.is_true(this.use_authentication) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYAUTH'), rt.get_constant('CURLAUTH_ANY')])
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYUSERPWD'), this.get_auth_string()])
	}
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) fsockopen_remote_socket(var_remote_socket rt.PhpVal)  {
	mut var_remote_socket_mutated := var_remote_socket
	var_remote_socket_mutated = this.proxy
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) fsockopen_remote_host_path(var_path rt.PhpVal, var_url rt.PhpVal)  {
	mut var_path_mutated := var_path
	var_path_mutated = var_url
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) fsockopen_header(var_out rt.PhpVal)  {
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) get_auth_string() string {
	return (this.user).str() + ':' + (this.pass).str()
}

struct Class_WpOrg_Requests_Exception_ArgumentCount {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

fn create_wporg_requests_proxy_http(arg_0 rt.PhpVal) &Class_WpOrg_Requests_Proxy_Http {
	mut obj := &Class_WpOrg_Requests_Proxy_Http{
		PhpObjectBase: rt.PhpObjectBase{}
		proxy: rt.new_null()
		user: rt.new_null()
		pass: rt.new_null()
		use_authentication: false
	}
	obj.construct(arg_0)
	return obj
}

fn create_wporg_requests_exception_argumentcount() &Class_WpOrg_Requests_Exception_ArgumentCount {
	mut obj := &Class_WpOrg_Requests_Exception_ArgumentCount{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Hooks](if args.len > 0 { args[0] } else { rt.new_null() })
			this.register(mut dispatch_arg_0)
			return rt.new_null()
		}
		'curl_before_send' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.curl_before_send(dispatch_arg_0)
			return rt.new_null()
		}
		'fsockopen_remote_socket' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.fsockopen_remote_socket(dispatch_arg_0)
			return rt.new_null()
		}
		'fsockopen_remote_host_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.fsockopen_remote_host_path(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'fsockopen_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.fsockopen_header(dispatch_arg_0)
			return rt.new_null()
		}
		'get_auth_string' {
			return rt.new_string(this.get_auth_string())
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Proxy_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'proxy' { return this.proxy }
		'user' { return this.user }
		'pass' { return this.pass }
		'use_authentication' { return rt.new_bool(this.use_authentication) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Proxy_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'proxy' { this.proxy = val; return true }
		'user' { this.user = val; return true }
		'pass' { this.pass = val; return true }
		'use_authentication' { this.use_authentication = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WpOrg_Requests_Exception_ArgumentCount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_ArgumentCount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_ArgumentCount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_requests_src_proxy_http_php() {
}

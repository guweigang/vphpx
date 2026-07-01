import rt

struct Class_WpOrg_Requests_Auth_Basic {
	rt.PhpObjectBase
pub mut:
		user rt.PhpVal = rt.new_null()
		pass rt.PhpVal = rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Auth_Basic) construct(var_args rt.PhpVal)  {
	if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_ArgumentCount{}; return temp.create(arg_0, arg_1, arg_2) }(rt.new_string('an array with exactly two elements'), rt.new_int(var_args.dup().array_count()), rt.new_string('authbasicbadargs')))
		}
		// unsupported assign target: Expr_List
		return
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$args'), rt.new_string('array|null'), rt.call_function('gettype', [var_args.dup()])))
	}
}

fn (mut this Class_WpOrg_Requests_Auth_Basic) register(mut var_hooks Class_WpOrg_Requests_Hooks)  {
	var_hooks.register(rt.new_string('curl.before_send'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Auth_Basic', ['Auth'], &this) }, rt.ArrayItem{ key: none, val: 'curl_before_send' }]))
	var_hooks.register(rt.new_string('fsockopen.after_headers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Auth_Basic', ['Auth'], &this) }, rt.ArrayItem{ key: none, val: 'fsockopen_header' }]))
}

fn (mut this Class_WpOrg_Requests_Auth_Basic) curl_before_send(var_handle rt.PhpVal)  {
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_HTTPAUTH'), rt.get_constant('CURLAUTH_BASIC')])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_USERPWD'), this.getauthstring()])
}

fn (mut this Class_WpOrg_Requests_Auth_Basic) fsockopen_header(var_out rt.PhpVal)  {
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_WpOrg_Requests_Auth_Basic) getauthstring() string {
	return (this.user).str() + ':' + (this.pass).str()
}

struct Class_WpOrg_Requests_Exception_ArgumentCount {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

fn create_wporg_requests_auth_basic(arg_0 rt.PhpVal) &Class_WpOrg_Requests_Auth_Basic {
	mut obj := &Class_WpOrg_Requests_Auth_Basic{
		PhpObjectBase: rt.PhpObjectBase{}
		user: rt.new_null()
		pass: rt.new_null()
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

fn (mut this Class_WpOrg_Requests_Auth_Basic) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'fsockopen_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.fsockopen_header(dispatch_arg_0)
			return rt.new_null()
		}
		'getAuthString' {
			return rt.new_string(this.getauthstring())
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Auth_Basic) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'user' { return this.user }
		'pass' { return this.pass }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Auth_Basic) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'user' { this.user = val; return true }
		'pass' { this.pass = val; return true }
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




pub fn init_wp_includes_requests_src_auth_basic_php() {
}

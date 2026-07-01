import rt

struct Class_WpOrg_Requests_Exception_Http {
	rt.PhpObjectBase
pub mut:
		code rt.PhpVal = rt.new_int(0)
		reason rt.PhpVal = rt.new_string('Unknown')
}

fn (mut this Class_WpOrg_Requests_Exception_Http) construct(var_reason rt.PhpVal, var_data rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.reason = var_reason.dup()
	}
	mut var_message := rt.call_function('sprintf', [rt.new_string('%d %s'), this.code, this.reason])
	this.Class_WpOrg_Requests_Exception.construct(var_message.dup(), rt.new_string('httpresponse'), var_data.dup(), this.code)
}

fn (mut this Class_WpOrg_Requests_Exception_Http) getreason() rt.PhpVal {
	return this.reason
}

fn Class_WpOrg_Requests_Exception_Http.get_class(var_code rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_code)))) {
		return Class_WpOrg_Requests_Exception_Http_StatusUnknown.class()
	}
	mut var_class := rt.call_function('sprintf', [rt.new_string('\\WpOrg\\Requests\\Exception\\Http\\Status%d'), var_code.dup()])
	if rt.is_true(rt.call_function('class_exists', [var_class.dup()])) {
		return var_class.dup()
	}
	return Class_WpOrg_Requests_Exception_Http_StatusUnknown.class()
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

fn create_wporg_requests_exception_http(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WpOrg_Requests_Exception_Http {
	mut obj := &Class_WpOrg_Requests_Exception_Http{
		PhpObjectBase: rt.PhpObjectBase{}
		code: rt.new_int(0)
		reason: rt.new_string('Unknown')
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wporg_requests_exception() &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Exception_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getReason' {
			return this.getreason()
		}
		'get_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_Exception_Http.get_class(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Exception_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return this.code }
		'reason' { return this.reason }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Exception_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' { this.code = val; return true }
		'reason' { this.reason = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_includes_requests_src_exception_http_php() {
}

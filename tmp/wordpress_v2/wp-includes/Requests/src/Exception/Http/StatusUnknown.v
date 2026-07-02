import rt

struct Class_WpOrg_Requests_Exception_Http_StatusUnknown {
	rt.PhpObjectBase
pub mut:
	code   rt.PhpVal = rt.new_int(0)
	reason rt.PhpVal = rt.new_string('Unknown')
}

fn (mut this Class_WpOrg_Requests_Exception_Http_StatusUnknown) construct(var_reason rt.PhpVal, var_data rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_data, 'WpOrg_Requests_Response'))) {
		this.code = rt.new_int((rt.get_property(var_data, 'status_code')).to_i64())
	}
	this.Class_WpOrg_Requests_Exception_Http.construct(var_reason.clone(), var_data.clone())
}

struct Class_WpOrg_Requests_Exception_Http {
	rt.PhpObjectBase
}

fn create_wporg_requests_exception_http_statusunknown(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WpOrg_Requests_Exception_Http_StatusUnknown {
	mut obj := &Class_WpOrg_Requests_Exception_Http_StatusUnknown{
		PhpObjectBase: rt.PhpObjectBase{}
		code:          rt.new_int(0)
		reason:        rt.new_string('Unknown')
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wporg_requests_exception_http(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_Http {
	mut obj := &Class_WpOrg_Requests_Exception_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Exception_Http_StatusUnknown) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Exception_Http_StatusUnknown) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return this.code }
		'reason' { return this.reason }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Exception_Http_StatusUnknown) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' {
			this.code = val
			return true
		}
		'reason' {
			this.reason = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}

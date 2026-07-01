import rt

pub fn Class_WpOrg_Requests_Exception_Transport_Curl.easy() string {
	return 'cURLEasy'
}
pub fn Class_WpOrg_Requests_Exception_Transport_Curl.multi() string {
	return 'cURLMulti'
}
pub fn Class_WpOrg_Requests_Exception_Transport_Curl.share() string {
	return 'cURLShare'
}
struct Class_WpOrg_Requests_Exception_Transport_Curl {
	rt.PhpObjectBase
pub mut:
		code rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_string('Unknown')
		reason rt.PhpVal = rt.new_string('Unknown')
}

fn (mut this Class_WpOrg_Requests_Exception_Transport_Curl) construct(var_message rt.PhpVal, var_type rt.PhpVal, var_data rt.PhpVal, code i64)  {
	mut var_message_mutated := var_message
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.prop_type = var_type.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.code = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.reason = var_message_mutated.dup()
	}
	var_message_mutated = rt.call_function('sprintf', [rt.new_string('%d %s'), this.code, this.reason])
	this.Class_WpOrg_Requests_Exception_Transport.construct(var_message_mutated.dup(), this.prop_type, var_data.dup(), this.code)
}

fn (mut this Class_WpOrg_Requests_Exception_Transport_Curl) getreason() rt.PhpVal {
	return this.reason
}

struct Class_WpOrg_Requests_Exception_Transport {
	rt.PhpObjectBase
}

fn create_wporg_requests_exception_transport_curl(arg_0 rt.PhpVal, code i64, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WpOrg_Requests_Exception_Transport_Curl {
	mut obj := &Class_WpOrg_Requests_Exception_Transport_Curl{
		PhpObjectBase: rt.PhpObjectBase{}
		code: rt.new_null()
		prop_type: rt.new_string('Unknown')
		reason: rt.new_string('Unknown')
	}
	obj.construct(arg_0, code, arg_2, arg_3)
	return obj
}

fn create_wporg_requests_exception_transport() &Class_WpOrg_Requests_Exception_Transport {
	mut obj := &Class_WpOrg_Requests_Exception_Transport{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Exception_Transport_Curl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'getReason' {
			return this.getreason()
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Exception_Transport_Curl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return this.code }
		'type' { return this.prop_type }
		'reason' { return this.reason }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Exception_Transport_Curl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' { this.code = val; return true }
		'type' { this.prop_type = val; return true }
		'reason' { this.reason = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WpOrg_Requests_Exception_Transport) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_Transport) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_Transport) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_requests_src_exception_transport_curl_php() {
}

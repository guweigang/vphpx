import rt

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_null()
	data      rt.PhpVal = rt.new_null()
	message   rt.PhpVal = rt.new_null()
	code      rt.PhpVal = rt.new_null()
	file      rt.PhpVal = rt.new_null()
	line      rt.PhpVal = rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Exception) construct(var_message rt.PhpVal, var_type rt.PhpVal, var_data rt.PhpVal, code i64) {
	this.Class_Exception.construct(var_message.clone(), rt.new_int(code))
	this.prop_type = var_type.clone()
	this.data = var_data.clone()
}

fn (mut this Class_WpOrg_Requests_Exception) gettype() rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_WpOrg_Requests_Exception) getdata() rt.PhpVal {
	return this.data
}

fn (mut this Class_WpOrg_Requests_Exception) getmessage() string {
	return this.message
}

fn create_wporg_requests_exception(arg_0 rt.PhpVal, code i64, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_null()
		data:          rt.new_null()
		message:       rt.new_null()
		code:          rt.new_null()
		file:          rt.new_null()
		line:          rt.new_null()
	}
	obj.construct(arg_0, code, arg_2, arg_3)
	return obj
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'getType' {
			return this.gettype()
		}
		'getData' {
			return this.getdata()
		}
		'getMessage' {
			return this.getmessage()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'data' { return this.data }
		'message' { return this.message }
		'code' { return this.code }
		'file' { return this.file }
		'line' { return this.line }
		else { return this.Class_Exception.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'data' {
			this.data = val
			return true
		}
		'message' {
			this.message = val
			return true
		}
		'code' {
			this.code = val
			return true
		}
		'file' {
			this.file = val
			return true
		}
		'line' {
			this.line = val
			return true
		}
		else {
			return this.Class_Exception.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) construct(var_error_code rt.PhpVal, var_error_message rt.PhpVal, var_http_code rt.PhpVal) {
	this.dispatch_set_prop('error_code', var_error_code.clone())
	this.dispatch_set_prop('error_message', if !var_error_message.is_null() {
		var_error_message
	} else {
		if !(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.error_messages().array_get(var_error_code)).is_null() {
			Class_WC_REST_WCCOM_Site_Installer_Error_Codes.error_messages().array_get(var_error_code)
		} else {
			rt.new_string('')
		}
	})
	this.dispatch_set_prop('http_code', if !var_http_code.is_null() {
		var_http_code
	} else {
		if !(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.http_codes().array_get(var_error_code)).is_null() {
			Class_WC_REST_WCCOM_Site_Installer_Error_Codes.http_codes().array_get(var_error_code)
		} else {
			rt.new_int(400)
		}
	})
	this.Class_Exception.construct(var_error_code.clone())
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) get_error_code() rt.PhpVal {
	return rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', [
		'Exception',
	], &this), 'error_code')
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) get_error_message() rt.PhpVal {
	return rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', [
		'Exception',
	], &this), 'error_message')
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) get_http_code() rt.PhpVal {
	return rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', [
		'Exception',
	], &this), 'http_code')
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) getmessage() string {
	return this.message
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_rest_wccom_site_installer_error(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WC_REST_WCCOM_Site_Installer_Error {
	mut obj := &Class_WC_REST_WCCOM_Site_Installer_Error{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_error_code' {
			return this.get_error_code()
		}
		'get_error_message' {
			return this.get_error_message()
		}
		'get_http_code' {
			return this.get_http_code()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

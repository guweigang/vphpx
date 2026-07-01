module wp_includes

import rt

struct Class_WP_HTTP_Response {
	rt.PhpObjectBase
pub mut:
	data    rt.PhpVal = rt.new_null()
	headers rt.PhpVal = rt.new_null()
	status  rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTTP_Response) construct(var_data rt.PhpVal, status i64, var_headers rt.PhpVal) {
	this.set_data(var_data.dup())
	this.set_status(rt.new_int(status))
	this.set_headers(var_headers.dup())
}

fn (mut this Class_WP_HTTP_Response) get_headers() rt.PhpVal {
	return this.headers
}

fn (mut this Class_WP_HTTP_Response) set_headers(var_headers rt.PhpVal) {
	this.headers = var_headers.dup()
}

fn (mut this Class_WP_HTTP_Response) header(var_key rt.PhpVal, var_value rt.PhpVal, replace bool) {
	if var_replace || !(this.headers.array_isset(var_key)) {
		this.headers.array_set(var_key, var_value.dup())
	} else {
		this.headers.array_get(var_key) = rt.concat(this.headers.array_get(var_key), rt.new_string(
			', ' + var_value.str()))
	}
}

fn (mut this Class_WP_HTTP_Response) get_status() rt.PhpVal {
	return this.status
}

fn (mut this Class_WP_HTTP_Response) set_status(var_code rt.PhpVal) {
	this.status = rt.call_function('absint', [var_code.dup()])
}

fn (mut this Class_WP_HTTP_Response) get_data() rt.PhpVal {
	return this.data
}

fn (mut this Class_WP_HTTP_Response) set_data(var_data rt.PhpVal) {
	this.data = var_data.dup()
}

fn (mut this Class_WP_HTTP_Response) jsonserialize() rt.PhpVal {
	return this.get_data()
}

fn create_wp_http_response(arg_0 rt.PhpVal, status i64, arg_2 rt.PhpVal) &Class_WP_HTTP_Response {
	mut obj := &Class_WP_HTTP_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_null()
		headers:       rt.new_null()
		status:        rt.new_null()
	}
	obj.construct(arg_0, status, arg_2)
	return obj
}

fn (mut this Class_WP_HTTP_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_headers' {
			return this.get_headers()
		}
		'set_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.header(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_status' {
			return this.get_status()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'get_data' {
			return this.get_data()
		}
		'set_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_data(dispatch_arg_0)
			return rt.new_null()
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTTP_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'headers' { return this.headers }
		'status' { return this.status }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTTP_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
			return true
		}
		'headers' {
			this.headers = val
			return true
		}
		'status' {
			this.status = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_class_wp_http_response_php() {
}

import rt

struct Class_SimplePie_HTTP_Psr7Response {
	rt.PhpObjectBase
pub mut:
	response      rt.PhpVal = rt.new_null()
	permanent_url string
	requested_url string
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) construct(mut var_response Class_Psr_Http_Message_ResponseInterface, permanent_url string, requested_url string) {
	this.response = var_response
	this.permanent_url = permanent_url
	this.requested_url = requested_url
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_permanent_uri() string {
	return this.permanent_url
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_final_requested_uri() string {
	return this.requested_url
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_status_code() i64 {
	return (rt.call_method(this.response, 'getStatusCode', []rt.PhpVal{})).to_i64()
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_headers() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_header.clone().array_count() >= 1)
	}
	return rt.call_function('array_filter', [
		rt.call_method(this.response, 'getHeaders', []rt.PhpVal{}),
		rt.new_closure(closure_1_fn),
	])
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) has_header(name string) bool {
	return (rt.call_method(this.response, 'hasHeader', [rt.new_string(name)])).to_bool()
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) with_header(name string, var_value rt.PhpVal) rt.PhpVal {
	return rt.new_object('SimplePie_HTTP_self', []string{}, create_simplepie_http_self(rt.call_method(this.response,
		'withHeader', [rt.new_string(name), var_value.clone()]), this.permanent_url,
		this.requested_url))
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_header(name string) rt.PhpVal {
	return rt.call_method(this.response, 'getHeader', [rt.new_string(name)])
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_header_line(name string) string {
	return (rt.call_method(this.response, 'getHeaderLine', [rt.new_string(name)])).str()
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) get_body_content() string {
	return (rt.call_method(rt.call_method(this.response, 'getBody', []rt.PhpVal{}), '__toString',
		[]rt.PhpVal{})).str()
}

struct Class_SimplePie_HTTP_self {
	rt.PhpObjectBase
}

fn create_simplepie_http_psr7response(arg_0 rt.PhpVal, permanent_url string, requested_url string) &Class_SimplePie_HTTP_Psr7Response {
	mut obj := &Class_SimplePie_HTTP_Psr7Response{
		PhpObjectBase: rt.PhpObjectBase{}
		response:      rt.new_null()
		permanent_url: ''
		requested_url: ''
	}
	obj.construct(arg_0, permanent_url, requested_url)
	return obj
}

fn create_simplepie_http_self(_args ...rt.PhpVal) &Class_SimplePie_HTTP_self {
	mut obj := &Class_SimplePie_HTTP_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Message_ResponseInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_permanent_uri' {
			return rt.new_string(this.get_permanent_uri())
		}
		'get_final_requested_uri' {
			return rt.new_string(this.get_final_requested_uri())
		}
		'get_status_code' {
			return rt.new_int(this.get_status_code())
		}
		'get_headers' {
			return this.get_headers()
		}
		'has_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_header(dispatch_arg_0))
		}
		'with_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.with_header(dispatch_arg_0, dispatch_arg_1)
		}
		'get_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_header(dispatch_arg_0)
		}
		'get_header_line' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_header_line(dispatch_arg_0))
		}
		'get_body_content' {
			return rt.new_string(this.get_body_content())
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_HTTP_Psr7Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'response' { return this.response }
		'permanent_url' { return rt.new_string(this.permanent_url) }
		'requested_url' { return rt.new_string(this.requested_url) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_HTTP_Psr7Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'response' {
			this.response = val
			return true
		}
		'permanent_url' {
			this.permanent_url = val.str()
			return true
		}
		'requested_url' {
			this.requested_url = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_SimplePie_HTTP_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

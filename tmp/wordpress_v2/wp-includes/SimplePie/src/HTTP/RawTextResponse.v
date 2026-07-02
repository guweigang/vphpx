import rt

struct Class_SimplePie_HTTP_RawTextResponse {
	rt.PhpObjectBase
pub mut:
	raw_text      string
	permanent_url string
	headers       rt.PhpVal = rt.new_array()
	requested_url string
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) construct(raw_text string, filepath string) {
	this.raw_text = raw_text
	this.permanent_url = filepath
	this.requested_url = filepath
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_permanent_uri() string {
	return this.permanent_url
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_final_requested_uri() string {
	return this.requested_url
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_status_code() i64 {
	return 200
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_headers() rt.PhpVal {
	return this.headers
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) has_header(name string) bool {
	return (rt.new_bool(this.headers.array_isset(rt.new_string(name.to_lower())))).to_bool()
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_header(name string) rt.PhpVal {
	return if this.headers.array_isset(rt.new_string(name.to_lower())) {
		this.headers.array_get(rt.new_string(name))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) with_header(name string, var_value rt.PhpVal) rt.PhpVal {
	mut var_new := rt.new_object('SimplePie_HTTP_RawTextResponse', ['Response'], &this).dup()
	mut var_newHeader := rt.create_array([
		rt.ArrayItem{ key: name.to_lower(), val: rt.cast_array(var_value) },
	])
	rt.set_property(var_new, 'headers', rt.add(var_newHeader, this.headers))
	return var_new.clone()
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_header_line(name string) string {
	return (if this.headers.array_isset(rt.new_string(name.to_lower())) {
		rt.call_function('implode',
			[rt.new_string(', '), this.headers.array_get(rt.new_string(name))])
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) get_body_content() string {
	return this.raw_text
}

fn create_simplepie_http_rawtextresponse(raw_text string, filepath string) &Class_SimplePie_HTTP_RawTextResponse {
	mut obj := &Class_SimplePie_HTTP_RawTextResponse{
		PhpObjectBase: rt.PhpObjectBase{}
		raw_text:      ''
		permanent_url: ''
		headers:       rt.new_array()
		requested_url: ''
	}
	obj.construct(raw_text, filepath)
	return obj
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
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
		'get_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_header(dispatch_arg_0)
		}
		'with_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.with_header(dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_SimplePie_HTTP_RawTextResponse) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'raw_text' { return rt.new_string(this.raw_text) }
		'permanent_url' { return rt.new_string(this.permanent_url) }
		'headers' { return this.headers }
		'requested_url' { return rt.new_string(this.requested_url) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_HTTP_RawTextResponse) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'raw_text' {
			this.raw_text = val.str()
			return true
		}
		'permanent_url' {
			this.permanent_url = val.str()
			return true
		}
		'headers' {
			this.headers = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}

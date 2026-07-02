import rt

pub fn Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response.phrases() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 100, val: 'Continue' }, rt.ArrayItem{ key: 101, val: 'Switching Protocols' }, rt.ArrayItem{ key: 102, val: 'Processing' }, rt.ArrayItem{ key: 200, val: 'OK' }, rt.ArrayItem{ key: 201, val: 'Created' }, rt.ArrayItem{ key: 202, val: 'Accepted' }, rt.ArrayItem{ key: 203, val: 'Non-Authoritative Information' }, rt.ArrayItem{ key: 204, val: 'No Content' }, rt.ArrayItem{ key: 205, val: 'Reset Content' }, rt.ArrayItem{ key: 206, val: 'Partial Content' }, rt.ArrayItem{ key: 207, val: 'Multi-status' }, rt.ArrayItem{ key: 208, val: 'Already Reported' }, rt.ArrayItem{ key: 300, val: 'Multiple Choices' }, rt.ArrayItem{ key: 301, val: 'Moved Permanently' }, rt.ArrayItem{ key: 302, val: 'Found' }, rt.ArrayItem{ key: 303, val: 'See Other' }, rt.ArrayItem{ key: 304, val: 'Not Modified' }, rt.ArrayItem{ key: 305, val: 'Use Proxy' }, rt.ArrayItem{ key: 306, val: 'Switch Proxy' }, rt.ArrayItem{ key: 307, val: 'Temporary Redirect' }, rt.ArrayItem{ key: 400, val: 'Bad Request' }, rt.ArrayItem{ key: 401, val: 'Unauthorized' }, rt.ArrayItem{ key: 402, val: 'Payment Required' }, rt.ArrayItem{ key: 403, val: 'Forbidden' }, rt.ArrayItem{ key: 404, val: 'Not Found' }, rt.ArrayItem{ key: 405, val: 'Method Not Allowed' }, rt.ArrayItem{ key: 406, val: 'Not Acceptable' }, rt.ArrayItem{ key: 407, val: 'Proxy Authentication Required' }, rt.ArrayItem{ key: 408, val: 'Request Time-out' }, rt.ArrayItem{ key: 409, val: 'Conflict' }, rt.ArrayItem{ key: 410, val: 'Gone' }, rt.ArrayItem{ key: 411, val: 'Length Required' }, rt.ArrayItem{ key: 412, val: 'Precondition Failed' }, rt.ArrayItem{ key: 413, val: 'Request Entity Too Large' }, rt.ArrayItem{ key: 414, val: 'Request-URI Too Large' }, rt.ArrayItem{ key: 415, val: 'Unsupported Media Type' }, rt.ArrayItem{ key: 416, val: 'Requested range not satisfiable' }, rt.ArrayItem{ key: 417, val: 'Expectation Failed' }, rt.ArrayItem{ key: 418, val: 'I\'m a teapot' }, rt.ArrayItem{ key: 422, val: 'Unprocessable Entity' }, rt.ArrayItem{ key: 423, val: 'Locked' }, rt.ArrayItem{ key: 424, val: 'Failed Dependency' }, rt.ArrayItem{ key: 425, val: 'Unordered Collection' }, rt.ArrayItem{ key: 426, val: 'Upgrade Required' }, rt.ArrayItem{ key: 428, val: 'Precondition Required' }, rt.ArrayItem{ key: 429, val: 'Too Many Requests' }, rt.ArrayItem{ key: 431, val: 'Request Header Fields Too Large' }, rt.ArrayItem{ key: 451, val: 'Unavailable For Legal Reasons' }, rt.ArrayItem{ key: 500, val: 'Internal Server Error' }, rt.ArrayItem{ key: 501, val: 'Not Implemented' }, rt.ArrayItem{ key: 502, val: 'Bad Gateway' }, rt.ArrayItem{ key: 503, val: 'Service Unavailable' }, rt.ArrayItem{ key: 504, val: 'Gateway Time-out' }, rt.ArrayItem{ key: 505, val: 'HTTP Version not supported' }, rt.ArrayItem{ key: 506, val: 'Variant Also Negotiates' }, rt.ArrayItem{ key: 507, val: 'Insufficient Storage' }, rt.ArrayItem{ key: 508, val: 'Loop Detected' }, rt.ArrayItem{ key: 511, val: 'Network Authentication Required' }])
}
struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response {
	rt.PhpObjectBase
pub mut:
		reasonPhrase rt.PhpVal = rt.new_string('')
		statusCode i64
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) construct(status i64, mut var_headers Class_WordPress_AiClientDependencies_Nyholm_Psr7_array, var_body rt.PhpVal, version string, mut var_reason Class_WordPress_AiClientDependencies_Nyholm_Psr7_?string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_body)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_body)))) {
		mut iife_temp_0 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
		mut iife_result_0 := iife_temp_0.create(var_body.clone())
		this.dispatch_set_prop('stream', iife_result_0)
	}
	this.statusCode = status
	this.setheaders(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_array', []string{}, var_headers))
	if rt.is_true(rt.identical(rt.new_null(), var_reason)) && Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Response.phrases().array_isset(this.statusCode) {
		this.reasonPhrase = Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Response.phrases().array_get(rt.new_int(status))
	} else {
		this.reasonPhrase = if !(var_reason).is_null() { var_reason } else { rt.new_string('') }
	}
	this.dispatch_set_prop('protocol', rt.new_string(version))
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) getstatuscode() i64 {
	return this.statusCode
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) getreasonphrase() string {
	return (this.reasonPhrase).str()
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) withstatus(var_code rt.PhpVal, reasonPhrase string) rt.PhpVal {
	mut var_code_mutated := var_code
	mut reasonPhrase_mutated := reasonPhrase
	if !(var_code_mutated.clone().is_long()) && !(var_code_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.new_string('Status code has to be an integer'))))
	}
	var_code_mutated = rt.new_int((var_code_mutated).to_i64())
	if rt.is_true(rt.less(var_code_mutated, rt.new_int(100))) || rt.is_true(rt.greater(var_code_mutated, rt.new_int(599))) {
		rt.throw_exception(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException', []string{}, create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Status code has to be an integer between 100 and 599. A status code of %d was given'), var_code_mutated.clone()]))))
	}
	mut var_new := rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Response', ['ResponseInterface'], &this).dup()
	rt.set_property(var_new, 'statusCode', var_code_mutated.clone())
	if rt.is_true(rt.identical(rt.new_null(), rt.new_string(reasonPhrase_mutated))) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string(reasonPhrase_mutated))) && Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Response.phrases().array_isset(rt.get_property(var_new, 'statusCode')) {
	reasonPhrase_mutated = (Class_WordPress_AiClientDependencies_Nyholm_Psr7_WordPress_AiClientDependencies_Nyholm_Psr7_Response.phrases().array_get(rt.get_property(var_new, 'statusCode'))).str()
	}
	rt.set_property(var_new, 'reasonPhrase', rt.new_string(reasonPhrase_mutated).clone())
	return var_new.clone()
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_response(status i64, arg_1 rt.PhpVal, arg_2 rt.PhpVal, version string, arg_4 rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		reasonPhrase: rt.new_string('')
		statusCode: i64(0)
	}
	obj.construct(status, arg_1, arg_2, version, arg_4)
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_stream(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'getStatusCode' {
			return rt.new_int(this.getstatuscode())
		}
		'getReasonPhrase' {
			return rt.new_string(this.getreasonphrase())
		}
		'withStatus' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.withstatus(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'reasonPhrase' { return this.reasonPhrase }
		'statusCode' { return rt.new_int(this.statusCode) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'reasonPhrase' { this.reasonPhrase = val; return true }
		'statusCode' { this.statusCode = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

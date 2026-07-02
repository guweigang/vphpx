import rt

struct Class_IXR_Client {
	rt.PhpObjectBase
pub mut:
	server    rt.PhpVal = rt.new_null()
	port      rt.PhpVal = rt.new_null()
	path      rt.PhpVal = rt.new_null()
	useragent string
	response  rt.PhpVal = rt.new_null()
	message   rt.PhpVal = rt.new_bool(false)
	debug     rt.PhpVal = rt.new_bool(false)
	timeout   rt.PhpVal = rt.new_null()
	headers   rt.PhpVal = rt.new_array()
	error     rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_IXR_Client) construct(var_server rt.PhpVal, path bool, port i64, timeout i64) {
	if !var_path {
		mut var_bits := rt.call_function('parse_url', [var_server.clone()])
		this.server = if !(var_bits.array_get(rt.new_string('host'))).is_null() {
			var_bits.array_get(rt.new_string('host'))
		} else {
			rt.new_string('')
		}
		this.port = if !(var_bits.array_get(rt.new_string('port'))).is_null() {
			var_bits.array_get(rt.new_string('port'))
		} else {
			rt.new_int(80)
		}
		this.path = if !(var_bits.array_get(rt.new_string('path'))).is_null() {
			var_bits.array_get(rt.new_string('path'))
		} else {
			rt.new_string('/')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.path)))) {
			this.path = rt.new_string('/')
		}
		if !(!rt.is_true(var_bits.array_get(rt.new_string('query')))) {
			this.path = rt.concat(this.path, rt.new_string('?' +
				(var_bits.array_get(rt.new_string('query'))).str()))
		}
	} else {
		this.server = var_server.clone()
		this.path = rt.new_bool(path)
		this.port = rt.new_int(port)
	}
	this.useragent = 'The Incutio XML-RPC PHP Library'
	this.timeout = rt.new_int(timeout)
}

fn (mut this Class_IXR_Client) ixr_client(var_server rt.PhpVal, path bool, port i64, timeout i64) {
	mut iife_temp_0 := Class_IXR_Client{}
	iife_temp_0.construct(var_server.to_bool(), path, port, rt.new_int(timeout))
	rt.new_null()
}

fn (mut this Class_IXR_Client) query(var_args rt.PhpVal) bool {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut var_method := rt.call_function('array_shift', [var_args.clone()])
	mut var_request := create_ixr_request(var_method.clone(), var_args.clone())
	mut var_length := rt.call_method(var_request, 'getLength', []rt.PhpVal{})
	mut var_xml := rt.call_method(var_request, 'getXml', []rt.PhpVal{})
	mut var_r := rt.new_string('\r\n')
	var_request = rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('POST '), this.path),
		rt.new_string(' HTTP/1.0')), var_r)).str())
	this.headers.array_set('Host', this.server)
	this.headers.array_set('Content-Type', 'text/xml')
	this.headers.array_set('User-Agent', this.useragent)
	this.headers.array_set('Content-Length', var_length.clone())
	mut iter_1 := this.headers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_header := item_1.key
		var_request = rt.concat(var_request,
			rt.new_string('${var_header.to_string()}: ${var_value.to_string()}${var_r.to_string()}'))
	}
	var_request = rt.concat(var_request, var_r)
	var_request = rt.concat(var_request, var_xml)
	if rt.is_true(this.debug) {
		print('<pre class="ixr_request">' +
			(rt.call_function('htmlspecialchars', [var_request.clone()])).str() + '\n</pre>\n\n')
	}
	if rt.is_true(this.timeout) {
		mut var_fp := rt.call_function('fsockopen', [this.server, this.port, var_errno.clone(),
			var_errstr.clone(), this.timeout])
	} else {
		var_fp = rt.call_function('fsockopen', [this.server, this.port, var_errno.clone(),
			var_errstr.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
		this.error = create_ixr_error(-32300,
			rt.new_string('transport error - could not open socket'))
		return false
	}
	rt.call_function('fputs', [var_fp.clone(), var_request.clone()])
	mut var_contents := rt.new_string('')
	mut var_debugContents := rt.new_string('')
	mut var_gotFirstLine := rt.new_bool(false)
	mut var_gettingHeaders := rt.new_bool(true)
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		var_fp.clone()]))))) {
		mut var_line := rt.call_function('fgets', [var_fp.clone(),
			rt.new_int(4096)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gotFirstLine)))) {
			if rt.is_true(rt.identical(rt.call_function('strstr', [
				var_line.clone(), rt.new_string('200')]), rt.new_bool(false)))
			{
				this.error = create_ixr_error(-32300,
					rt.new_string('transport error - HTTP status code was not 200'))
				return false
			}
			var_gotFirstLine = rt.new_bool(true)
		}
		if rt.is_true(rt.equal(rt.new_string(var_line.clone().to_string().trim_space()),
			rt.new_string('')))
		{
			var_gettingHeaders = rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gettingHeaders)))) {
			var_contents = rt.concat(var_contents, var_line)
		}
		if rt.is_true(this.debug) {
			var_debugContents = rt.concat(var_debugContents, var_line)
		}
	}
	if rt.is_true(this.debug) {
		print('<pre class="ixr_response">' +
			(rt.call_function('htmlspecialchars', [var_debugContents.clone()])).str() +
			'\n</pre>\n\n')
	}
	this.message = create_ixr_message(var_contents.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.message, 'parse', []rt.PhpVal{}))))) {
		this.error = create_ixr_error(-32700, rt.new_string('parse error. not well formed'))
		return false
	}
	if rt.is_true(rt.equal(rt.get_property(this.message, 'messageType'), rt.new_string('fault'))) {
		this.error = create_ixr_error(rt.get_property(this.message, 'faultCode'), rt.get_property(this.message,
			'faultString'))
		return false
	}
	return true
}

fn (mut this Class_IXR_Client) getresponse() rt.PhpVal {
	return rt.get_property(this.message, 'params').array_get(rt.new_int(0))
}

fn (mut this Class_IXR_Client) iserror() bool {
	return this.error.is_object()
}

fn (mut this Class_IXR_Client) geterrorcode() rt.PhpVal {
	return rt.get_property(this.error, 'code')
}

fn (mut this Class_IXR_Client) geterrormessage() rt.PhpVal {
	return rt.get_property(this.error, 'message')
}

struct Class_IXR_Request {
	rt.PhpObjectBase
}

struct Class_IXR_Error {
	rt.PhpObjectBase
}

struct Class_IXR_Message {
	rt.PhpObjectBase
}

fn create_ixr_client(path bool, port i64, timeout i64, arg_3 rt.PhpVal) &Class_IXR_Client {
	mut obj := &Class_IXR_Client{
		PhpObjectBase: rt.PhpObjectBase{}
		server:        rt.new_null()
		port:          rt.new_null()
		path:          rt.new_null()
		useragent:     ''
		response:      rt.new_null()
		message:       rt.new_bool(false)
		debug:         rt.new_bool(false)
		timeout:       rt.new_null()
		headers:       rt.new_array()
		error:         rt.new_bool(false)
	}
	obj.construct(path, port, timeout, arg_3)
	return obj
}

fn create_ixr_request(_args ...rt.PhpVal) &Class_IXR_Request {
	mut obj := &Class_IXR_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_error(_args ...rt.PhpVal) &Class_IXR_Error {
	mut obj := &Class_IXR_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_message(_args ...rt.PhpVal) &Class_IXR_Message {
	mut obj := &Class_IXR_Message{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_IXR_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'IXR_Client' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.ixr_client(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.query(dispatch_arg_0))
		}
		'getResponse' {
			return this.getresponse()
		}
		'isError' {
			return rt.new_bool(this.iserror())
		}
		'getErrorCode' {
			return this.geterrorcode()
		}
		'getErrorMessage' {
			return this.geterrormessage()
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'server' { return this.server }
		'port' { return this.port }
		'path' { return this.path }
		'useragent' { return rt.new_string(this.useragent) }
		'response' { return this.response }
		'message' { return this.message }
		'debug' { return this.debug }
		'timeout' { return this.timeout }
		'headers' { return this.headers }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'server' {
			this.server = val
			return true
		}
		'port' {
			this.port = val
			return true
		}
		'path' {
			this.path = val
			return true
		}
		'useragent' {
			this.useragent = val.str()
			return true
		}
		'response' {
			this.response = val
			return true
		}
		'message' {
			this.message = val
			return true
		}
		'debug' {
			this.debug = val
			return true
		}
		'timeout' {
			this.timeout = val
			return true
		}
		'headers' {
			this.headers = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_IXR_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_IXR_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_IXR_Message) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Message) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Message) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

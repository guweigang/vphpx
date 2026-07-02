import rt

struct Class_WP_HTTP_IXR_Client {
	rt.PhpObjectBase
pub mut:
	scheme rt.PhpVal = rt.new_null()
	error  rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTTP_IXR_Client) construct(var_server rt.PhpVal, path bool, port bool, timeout i64) {
	mut port_mutated := port
	if !var_path {
		mut var_bits := rt.call_function('parse_url', [var_server.clone()])
		this.scheme = if !(var_bits.array_get(rt.new_string('scheme'))).is_null() {
			var_bits.array_get(rt.new_string('scheme'))
		} else {
			rt.new_string('')
		}
		this.dispatch_set_prop('server', if !(var_bits.array_get(rt.new_string('host'))).is_null() {
			var_bits.array_get(rt.new_string('host'))
		} else {
			rt.new_string('')
		})
		this.dispatch_set_prop('port', if !(var_bits.array_get(rt.new_string('port'))).is_null() {
			var_bits.array_get(rt.new_string('port'))
		} else {
			rt.new_bool(port_mutated)
		})
		this.dispatch_set_prop('path', if !(var_bits.array_get(rt.new_string('path'))).is_null() {
			var_bits.array_get(rt.new_string('path'))
		} else {
			rt.new_string('/')
		})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
			'IXR_Client',
		], &this), 'path')))))
		{
			this.dispatch_set_prop('path', rt.new_string('/'))
		}
		if !(!rt.is_true(var_bits.array_get(rt.new_string('query')))) {
			rt.get_property(rt.new_object('WP_HTTP_IXR_Client', ['IXR_Client'], &this), 'path') = rt.concat(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
				'IXR_Client',
			], &this), 'path'), rt.new_string('?' +
				(var_bits.array_get(rt.new_string('query'))).str()))
		}
	} else {
		this.scheme = rt.new_string('http')
		this.dispatch_set_prop('server', var_server.clone())
		this.dispatch_set_prop('path', rt.new_bool(path))
		this.dispatch_set_prop('port', rt.new_bool(port_mutated).clone())
	}
	this.dispatch_set_prop('useragent', rt.new_string('The Incutio XML-RPC PHP Library'))
	this.dispatch_set_prop('timeout', rt.new_int(timeout))
}

fn (mut this Class_WP_HTTP_IXR_Client) query(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	mut var_method := rt.call_function('array_shift', [var_args_mutated.clone()])
	mut var_request := create_ixr_request(var_method.clone(), var_args_mutated.clone())
	mut var_xml := var_request.getxml()
	mut var_port := rt.new_string((if rt.is_true(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
		'IXR_Client',
	], &this), 'port'))
	{ rt.concat(rt.new_string(':'), rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
			'IXR_Client',
		], &this), 'port')) } else { '' }).str())
	mut var_url := rt.new_string(
		(this.scheme).str() + '://' + (rt.get_property(rt.new_object('WP_HTTP_IXR_Client', ['IXR_Client'], &this), 'server')).str() +
		var_port.str() +
		(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', ['IXR_Client'], &this), 'path')).str())
	var_args_mutated = rt.create_array([
		rt.ArrayItem{ key: 'headers', val: rt.create_array([
			rt.ArrayItem{ key: 'Content-Type', val: 'text/xml' },
		]) },
		rt.ArrayItem{ key: 'user-agent', val: rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
			'IXR_Client',
		], &this), 'useragent') },
		rt.ArrayItem{ key: 'body', val: var_xml },
	])
	mut iter_1 := rt.get_property(rt.new_object('WP_HTTP_IXR_Client', ['IXR_Client'], &this),
		'headers').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_header := item_1.key
		var_args_mutated.array_get_mut('headers').array_set(var_header, var_value.clone())
	}
	var_args_mutated.array_set('headers', rt.call_function('apply_filters', [
		rt.new_string('wp_http_ixr_client_headers'),
		var_args_mutated.array_get(rt.new_string('headers')),
	]))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
		'IXR_Client',
	], &this), 'timeout')))))
	{
		var_args_mutated.array_set('timeout', rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
			'IXR_Client',
		], &this), 'timeout'))
	}
	if rt.is_true(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', ['IXR_Client'], &this),
		'debug'))
	{
		print('<pre class="ixr_request">' +
			(rt.call_function('htmlspecialchars', [var_xml.clone()])).str() + '\n</pre>\n\n')
	}
	mut var_response := rt.call_function('wp_safe_remote_post', [
		var_url.clone(), var_args_mutated.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		mut var_errno := rt.call_method(var_response, 'get_error_code', []rt.PhpVal{})
		mut var_errorstr := rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})
		this.error = create_ixr_error(-32300,
			rt.new_string('transport error: ${var_errno.to_string()} ${var_errorstr.to_string()}'))
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [
		var_response.clone(),
	])))))
	{
		this.error = create_ixr_error(-32301, 'transport error -
			HTTP status code was not 200 (' + (rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()])).str() +
			')')
		return false
	}
	if rt.is_true(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', ['IXR_Client'], &this),
		'debug'))
	{
		print('<pre class="ixr_response">' +
			(rt.call_function('htmlspecialchars', [rt.call_function('wp_remote_retrieve_body', [var_response.clone()])])).str() +
			'\n</pre>\n\n')
	}
	this.dispatch_set_prop('message', create_ixr_message(rt.call_function('wp_remote_retrieve_body', [
		var_response.clone(),
	])))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
		'IXR_Client',
	], &this), 'message'), 'parse', []rt.PhpVal{})))))
	{
		this.error = create_ixr_error(-32700, rt.new_string('parse error. not well formed'))
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('fault'), rt.get_property(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
		'IXR_Client',
	], &this), 'message'), 'messageType')))
	{
		this.error = create_ixr_error(rt.get_property(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
			'IXR_Client',
		], &this), 'message'), 'faultCode'), rt.get_property(rt.get_property(rt.new_object('WP_HTTP_IXR_Client', [
			'IXR_Client',
		], &this), 'message'), 'faultString'))
		return false
	}
	return true
}

struct Class_IXR_Client {
	rt.PhpObjectBase
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

fn create_wp_http_ixr_client(path bool, port bool, timeout i64, arg_3 rt.PhpVal) &Class_WP_HTTP_IXR_Client {
	mut obj := &Class_WP_HTTP_IXR_Client{
		PhpObjectBase: rt.PhpObjectBase{}
		scheme:        rt.new_null()
		error:         rt.new_null()
	}
	obj.construct(path, port, timeout, arg_3)
	return obj
}

fn create_ixr_client(_args ...rt.PhpVal) &Class_IXR_Client {
	mut obj := &Class_IXR_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn (mut this Class_WP_HTTP_IXR_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.query(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTTP_IXR_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'scheme' { return this.scheme }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTTP_IXR_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'scheme' {
			this.scheme = val
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

fn (mut this Class_IXR_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

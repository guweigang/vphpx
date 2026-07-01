import rt

pub fn Class_WpOrg_Requests_Transport_Fsockopen.second_in_microseconds() i64 {
	return 1000000
}
struct Class_WpOrg_Requests_Transport_Fsockopen {
	rt.PhpObjectBase
pub mut:
		headers rt.PhpVal = rt.new_string('')
		info rt.PhpVal = rt.new_null()
		max_bytes rt.PhpVal = rt.new_bool(false)
		connect_error rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) request(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) string {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Utility_InputValidator{}; return temp.is_string_or_stringable(arg_0) }(var_url.dup()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_string('$url'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_url.dup()])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_headers_mutated.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(2), rt.new_string('$headers'), rt.new_string('array'), rt.call_function('gettype', [var_headers_mutated.dup()])))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.dup().is_array()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.dup().is_string()))))))) {
		if rt.is_true(rt.identical(var_data_mutated, rt.new_null())) {
			var_data_mutated = rt.new_string(rt.new_string(''))
		} else {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(3), rt.new_string('$data'), rt.new_string('array|string'), rt.call_function('gettype', [var_data_mutated.dup()])))
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options.dup().is_array()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}; return temp.create(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(4), rt.new_string('$options'), rt.new_string('array'), rt.call_function('gettype', [var_options.dup()])))
	}
	rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.before_request')])
	mut var_url_parts := rt.call_function('parse_url', [var_url.dup()])
	if !rt.is_true(var_url_parts) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid URL.'), rt.new_string('invalidurl'), var_url.dup())))
	}
	mut var_host := var_url_parts.array_get('host')
	mut var_context := rt.call_function('stream_context_create', []rt.PhpVal{})
	mut var_verifyname := rt.new_bool(rt.new_bool(false))
	mut var_case_insensitive_headers := create_wporg_requests_utility_caseinsensitivedictionary(var_headers_mutated.dup())
	if rt.is_true(rt.new_bool(var_url_parts.array_isset(rt.new_string('scheme')) && rt.is_true(rt.identical(rt.new_string(var_url_parts.array_get('scheme').to_string().to_lower()), rt.new_string('https'))))) {
		mut var_remote_socket := rt.new_string('ssl://' + (var_host).str())
		if !(var_url_parts.array_isset(rt.new_string('port'))) {
			var_url_parts.array_set('port', Class_WpOrg_Requests_Port.https())
		}
		mut var_context_options := rt.create_array([rt.ArrayItem{ key: 'verify_peer', val: true }, rt.ArrayItem{ key: 'capture_peer_cert', val: true }])
		var_verifyname = rt.new_bool(rt.new_bool(true))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('OPENSSL_TLSEXT_SERVER_NAME')])) && rt.is_true(rt.get_constant('OPENSSL_TLSEXT_SERVER_NAME')))) {
			var_context_options.array_set('SNI_enabled', true)
			if rt.is_true(rt.new_bool(var_options.array_isset(rt.new_string('verifyname')) && rt.is_true(rt.identical(var_options.array_get('verifyname'), rt.new_bool(false))))) {
				var_context_options.array_set('SNI_enabled', false)
			}
		}
		if var_options.array_isset(rt.new_string('verify')) {
			if rt.is_true(rt.identical(var_options.array_get('verify'), rt.new_bool(false))) {
				var_context_options.array_set('verify_peer', false)
				var_context_options.array_set('verify_peer_name', false)
				var_verifyname = rt.new_bool(rt.new_bool(false))
			} else if rt.is_true(rt.new_bool(var_options.array_get('verify').is_string())) {
				var_context_options.array_set('cafile', var_options.array_get('verify'))
			}
		}
		if rt.is_true(rt.new_bool(var_options.array_isset(rt.new_string('verifyname')) && rt.is_true(rt.identical(var_options.array_get('verifyname'), rt.new_bool(false))))) {
			var_context_options.array_set('verify_peer_name', false)
			var_verifyname = rt.new_bool(rt.new_bool(false))
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('stream_context_set_options')])) {
			rt.call_function('stream_context_set_options', [var_context.dup(), rt.create_array([rt.ArrayItem{ key: 'ssl', val: var_context_options }])])
		} else {
			rt.call_function('stream_context_set_option', [var_context.dup(), rt.create_array([rt.ArrayItem{ key: 'ssl', val: var_context_options }])])
		}
	} else {
		var_remote_socket = rt.new_string('tcp://' + (var_host).str())
	}
	this.max_bytes = var_options.array_get('max_bytes')
	if !(var_url_parts.array_isset(rt.new_string('port'))) {
		var_url_parts.array_set('port', Class_WpOrg_Requests_Port.http())
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_function('set_error_handler', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Transport_Fsockopen', ['Transport'], &this) }, rt.ArrayItem{ key: none, val: 'connect_error_handler' }]), rt.bitwise_or(rt.get_constant('E_WARNING'), rt.get_constant('E_NOTICE'))])
	rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.remote_socket'), rt.create_array([rt.ArrayItem{ key: none, val: var_remote_socket }])])
	mut var_socket := rt.call_function('stream_socket_client', [var_remote_socket.dup(), var_errno.dup(), var_errstr.dup(), rt.call_function('ceil', [var_options.array_get('connect_timeout')]), rt.get_constant('STREAM_CLIENT_CONNECT'), var_context.dup()])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_verifyname) && rt.is_true(rt.new_bool(!(rt.is_true(this.verify_certificate_from_context(var_host.dup(), var_context.dup()))))))) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('SSL certificate did not match the requested domain name'), rt.new_string('ssl.no_match'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_socket)))) {
		if rt.is_true(rt.identical(var_errno, rt.new_int(0))) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string(this.connect_error.to_string().trim_right(' \t\n\r')), rt.new_string('fsockopen.connect_error'))))
		}
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_errstr.dup(), rt.new_string('fsockopenerror'), rt.new_null(), var_errno.dup())))
	}
	mut var_data_format := var_options.array_get('data_format')
	if rt.is_true(rt.identical(var_data_format, rt.new_string('query'))) {
		mut var_path := Class_WpOrg_Requests_Transport_Fsockopen.format_get(var_url_parts.dup(), var_data_mutated.dup())
		var_data_mutated = rt.new_string(rt.new_string(''))
	} else {
		var_path = Class_WpOrg_Requests_Transport_Fsockopen.format_get(var_url_parts.dup(), rt.new_array())
	}
	rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.remote_host_path'), rt.create_array([rt.ArrayItem{ key: none, val: var_path }, rt.ArrayItem{ key: none, val: var_url }])])
	mut var_request_body := rt.new_string(rt.new_string(''))
	mut var_out := rt.call_function('sprintf', [rt.new_string('%s %s HTTP/%.1F\r\n'), var_options.array_get('type'), var_path.dup(), var_options.array_get('protocol_version')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(var_data_mutated.dup().is_array())) {
			var_request_body = rt.call_function('http_build_query', [var_data_mutated.dup(), rt.new_string(''), rt.new_string('&')])
		} else {
			var_request_body = var_data_mutated.dup()
		}
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_data_mutated)) || rt.is_true(rt.identical(var_options.array_get('type'), Class_WpOrg_Requests_Requests.post())))) {
			if !(var_case_insensitive_headers.array_isset(rt.new_string('Content-Length'))) {
				var_headers_mutated.array_set('Content-Length', var_request_body.dup().to_string().len)
			}
			if !(var_case_insensitive_headers.array_isset(rt.new_string('Content-Type'))) {
				var_headers_mutated.array_set('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
			}
		}
	}
	if !(var_case_insensitive_headers.array_isset(rt.new_string('Host'))) {
		// unsupported expression: Expr_AssignOp_Concat
		mut var_scheme_lower := rt.new_string(rt.new_string(var_url_parts.array_get('scheme').to_string().to_lower()))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_scheme_lower, rt.new_string('http'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_scheme_lower, rt.new_string('https'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(var_case_insensitive_headers.array_isset(rt.new_string('User-Agent'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_accept_encoding := this.accept_encoding()
	if !(var_case_insensitive_headers.array_isset(rt.new_string('Accept-Encoding'))) && !(!rt.is_true(var_accept_encoding)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_headers_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WpOrg_Requests_Requests{}; return temp.flatten(arg_0) }(var_headers_mutated.dup())
	if !(!rt.is_true(var_headers_mutated)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.after_headers'), rt.create_array([rt.ArrayItem{ key: none, val: var_out }])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(var_case_insensitive_headers.array_isset(rt.new_string('Connection'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.before_send'), rt.create_array([rt.ArrayItem{ key: none, val: var_out }])])
	rt.call_function('fwrite', [var_socket.dup(), var_out.dup()])
	rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.after_send'), rt.create_array([rt.ArrayItem{ key: none, val: var_out }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options.array_get('blocking'))))) {
		rt.call_function('fclose', [var_socket.dup()])
		mut var_fake_headers := rt.new_string(rt.new_string(''))
		rt.call_method(var_options.array_get('hooks'), 'dispatch', [rt.new_string('fsockopen.after_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_fake_headers }])])
		return ''
	}
	mut var_timeout_sec := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(var_timeout_sec, var_options.array_get('timeout'))) {
		mut var_timeout_msec := rt.new_int(rt.new_int(0))
	} else {
		var_timeout_msec = rt.mod_(rt.mul(Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Fsockopen.second_in_microseconds(), var_options.array_get('timeout')), Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Fsockopen.second_in_microseconds())
	}
	rt.call_function('stream_set_timeout', [var_socket.dup(), var_timeout_sec.dup(), var_timeout_msec.dup()])
	mut var_response := rt.new_string(rt.new_string(''))
	mut var_body := rt.new_string(rt.new_string(''))
	var_headers_mutated = rt.new_string(rt.new_string(''))
	this.info = rt.call_function('stream_get_meta_data', [var_socket.dup()])
	mut var_size := rt.new_int(rt.new_int(0))
	mut var_doingbody := rt.new_bool(rt.new_bool(false))
	mut var_download := rt.new_bool(rt.new_bool(false))
	if rt.is_true(var_options.array_get('filename')) {
		var_download = rt.call_function('fopen', [var_options.array_get('filename'), rt.new_string('wb')])
		if rt.is_true(rt.identical(var_download, rt.new_bool(false))) {
			mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_error.array_get('message'), rt.new_string('fopen'))))
		}
	}
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_socket.dup()]))))) {
		this.info = rt.call_function('stream_get_meta_data', [var_socket.dup()])
		if rt.is_true(this.info.array_get('timed_out')) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('fsocket timed out'), rt.new_string('timeout'))))
		}
		mut var_block := rt.call_function('fread', [var_socket.dup(), Class_WpOrg_Requests_Requests.buffer_size()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_doingbody)))) {
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true() {
			}
		}
		if rt.is_true(var_doingbody) {
			
		}
	}
	
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) request_multiple(var_requests rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
}

fn Class_WpOrg_Requests_Transport_Fsockopen.accept_encoding() rt.PhpVal {
}

fn Class_WpOrg_Requests_Transport_Fsockopen.format_get(var_url_parts rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_url_parts_mutated := var_url_parts
	mut var_data_mutated := var_data
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) connect_error_handler(var_errno rt.PhpVal, var_errstr rt.PhpVal) bool {
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) verify_certificate_from_context(var_host rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_host_mutated := var_host
	mut var_context_mutated := var_context
}

fn Class_WpOrg_Requests_Transport_Fsockopen.test(var_capabilities rt.PhpVal) bool {
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

fn create_wporg_requests_transport_fsockopen() &Class_WpOrg_Requests_Transport_Fsockopen {
	mut obj := &Class_WpOrg_Requests_Transport_Fsockopen{
		PhpObjectBase: rt.PhpObjectBase{}
		headers: rt.new_string('')
		info: rt.new_null()
		max_bytes: rt.new_bool(false)
		connect_error: rt.new_string('')
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator() &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception() &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_caseinsensitivedictionary() &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests() &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(this.request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'request_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.request_multiple(dispatch_arg_0, dispatch_arg_1)
		}
		'accept_encoding' {
			return Class_WpOrg_Requests_Transport_Fsockopen.accept_encoding()
		}
		'format_get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WpOrg_Requests_Transport_Fsockopen.format_get(dispatch_arg_0, dispatch_arg_1)
		}
		'connect_error_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.connect_error_handler(dispatch_arg_0, dispatch_arg_1))
		}
		'verify_certificate_from_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.verify_certificate_from_context(dispatch_arg_0, dispatch_arg_1)
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_Transport_Fsockopen.test(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_Transport_Fsockopen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'headers' { return this.headers }
		'info' { return this.info }
		'max_bytes' { return this.max_bytes }
		'connect_error' { return this.connect_error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'headers' { this.headers = val; return true }
		'info' { this.info = val; return true }
		'max_bytes' { this.max_bytes = val; return true }
		'connect_error' { this.connect_error = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WpOrg_Requests_Transport_Fsockopen', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_transport_fsockopen()
		return rt.new_object('WpOrg_Requests_Transport_Fsockopen', ['Transport'], obj)
	})
	rt.register_class_factory('WpOrg_Requests_Utility_InputValidator', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_utility_inputvalidator()
		return rt.new_object('WpOrg_Requests_Utility_InputValidator', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_InvalidArgument', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_invalidargument()
		return rt.new_object('WpOrg_Requests_Exception_InvalidArgument', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception()
		return rt.new_object('WpOrg_Requests_Exception', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Utility_CaseInsensitiveDictionary', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_utility_caseinsensitivedictionary()
		return rt.new_object('WpOrg_Requests_Utility_CaseInsensitiveDictionary', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Requests', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_requests()
		return rt.new_object('WpOrg_Requests_Requests', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_requests_src_transport_fsockopen_php() {
}

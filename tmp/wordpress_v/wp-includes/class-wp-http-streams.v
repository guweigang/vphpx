import rt

struct Class_WP_Http_Streams {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Http_Streams) request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_defaults := { 'method': rt.new_string('GET'), 'timeout': rt.new_int(5), 'redirection': rt.new_int(5), 'httpversion': rt.new_string('1.0'), 'blocking': rt.new_bool(true), 'headers': map[string]rt.PhpVal{}, 'body': rt.new_null(), 'cookies': map[string]rt.PhpVal{}, 'decompress': rt.new_bool(false), 'stream': rt.new_bool(false), 'filename': rt.new_null() }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	if var_parsed_args.array_get('headers').array_isset(rt.new_string('User-Agent')) {
		var_parsed_args.array_set('user-agent', var_parsed_args.array_get('headers').array_get('User-Agent'))
		var_parsed_args.array_get('headers').array_unset(rt.new_string('User-Agent'))
	} else if var_parsed_args.array_get('headers').array_isset(rt.new_string('user-agent')) {
		var_parsed_args.array_set('user-agent', var_parsed_args.array_get('headers').array_get('user-agent'))
		var_parsed_args.array_get('headers').array_unset(rt.new_string('user-agent'))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.buildcookieheader(arg_0) }(var_parsed_args.dup())
	mut var_parsed_url := rt.call_function('parse_url', [var_url.dup()])
	mut var_connect_host := var_parsed_url.array_get('host')
	mut var_secure_transport := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('ssl'), var_parsed_url.array_get('scheme'))) || rt.is_true(rt.identical(rt.new_string('https'), var_parsed_url.array_get('scheme')))))
	if !(var_parsed_url.array_isset(rt.new_string('port'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('ssl'), var_parsed_url.array_get('scheme'))) || rt.is_true(rt.identical(rt.new_string('https'), var_parsed_url.array_get('scheme'))))) {
			var_parsed_url.array_set('port', 443)
			var_secure_transport = rt.new_bool(rt.new_bool(true))
		} else {
			var_parsed_url.array_set('port', 80)
		}
	}
	if !(var_parsed_url.array_isset(rt.new_string('path'))) {
		var_parsed_url.array_set('path', '/')
	}
	if var_parsed_args.array_get('headers').array_isset(rt.new_string('Host')) || var_parsed_args.array_get('headers').array_isset(rt.new_string('host')) {
		var_parsed_url.array_set('host', if !(var_parsed_args.array_get('headers').array_get('Host')).is_null() { var_parsed_args.array_get('headers').array_get('Host') } else { var_parsed_args.array_get('headers').array_get('host') })
		var_parsed_args.array_get('headers').array_unset(rt.new_string('Host'))
		var_parsed_args.array_get('headers').array_unset(rt.new_string('host'))
	}
	if rt.is_true(rt.identical(rt.new_string('localhost'), rt.new_string(var_connect_host.dup().to_string().to_lower()))) {
		var_connect_host = rt.new_string(rt.new_string('127.0.0.1'))
	}
	var_connect_host = rt.new_string(if rt.is_true(var_secure_transport) { 'ssl://' + (var_connect_host).str() } else { 'tcp://' + (var_connect_host).str() })
	mut var_is_local := rt.new_bool(rt.new_bool(var_parsed_args.array_isset(rt.new_string('local')) && rt.is_true(var_parsed_args.array_get('local'))))
	mut var_ssl_verify := rt.new_bool(rt.new_bool(var_parsed_args.array_isset(rt.new_string('sslverify')) && rt.is_true(var_parsed_args.array_get('sslverify'))))
	if rt.is_true(var_is_local) {
		var_ssl_verify = rt.call_function('apply_filters', [rt.new_string('https_local_ssl_verify'), var_ssl_verify.dup(), var_url.dup()])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_local)))) {
		var_ssl_verify = rt.call_function('apply_filters', [rt.new_string('https_ssl_verify'), var_ssl_verify.dup(), var_url.dup()])
	}
	mut var_proxy := create_wp_http_proxy()
	mut var_context := rt.call_function('stream_context_create', [rt.create_array([rt.ArrayItem{ key: 'ssl', val: rt.create_array([rt.ArrayItem{ key: 'verify_peer', val: var_ssl_verify }, rt.ArrayItem{ key: 'capture_peer_cert', val: var_ssl_verify }, rt.ArrayItem{ key: 'SNI_enabled', val: true }, rt.ArrayItem{ key: 'cafile', val: var_parsed_args.array_get('sslcertificates') }, rt.ArrayItem{ key: 'allow_self_signed', val: !(rt.is_true(var_ssl_verify)) }]) }])])
	mut var_timeout := // unsupported expression: Expr_Cast_Int
	mut var_utimeout := rt.new_int(rt.new_int(0))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_utimeout = rt.mod_(rt.mul(rt.new_int(1000000), var_parsed_args.array_get('timeout')), rt.new_int(1000000))
	}
	mut var_connect_timeout := rt.call_function('max', [var_timeout.dup(), rt.new_int(1)])
	mut var_connection_error := rt.new_null()
	mut var_connection_error_str := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
		if rt.is_true(var_secure_transport) {
			mut var_error_reporting := rt.call_function('error_reporting', [rt.new_int(0)])
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_proxy.is_enabled()) && rt.is_true(var_proxy.send_through_proxy(var_url.dup())))) {
			mut var_handle := rt.call_function('stream_socket_client', ['tcp://' + (var_proxy.host()).str() + ':' + (var_proxy.port()).str(), var_connection_error.dup(), var_connection_error_str.dup(), var_connect_timeout.dup(), rt.get_constant('STREAM_CLIENT_CONNECT'), var_context.dup()])
		} else {
			var_handle = rt.call_function('stream_socket_client', [(var_connect_host).str() + ':' + (var_parsed_url.array_get('port')).str(), var_connection_error.dup(), var_connection_error_str.dup(), var_connect_timeout.dup(), rt.get_constant('STREAM_CLIENT_CONNECT'), var_context.dup()])
		}
		if rt.is_true(var_secure_transport) {
			rt.call_function('error_reporting', [var_error_reporting.dup()])
		}
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(var_proxy.is_enabled()) && rt.is_true(var_proxy.send_through_proxy(var_url.dup())))) {
			var_handle = rt.call_function('stream_socket_client', ['tcp://' + (var_proxy.host()).str() + ':' + (var_proxy.port()).str(), var_connection_error.dup(), var_connection_error_str.dup(), var_connect_timeout.dup(), rt.get_constant('STREAM_CLIENT_CONNECT'), var_context.dup()])
		} else {
			var_handle = rt.call_function('stream_socket_client', [(var_connect_host).str() + ':' + (var_parsed_url.array_get('port')).str(), var_connection_error.dup(), var_connection_error_str.dup(), var_connect_timeout.dup(), rt.get_constant('STREAM_CLIENT_CONNECT'), var_context.dup()])
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_handle)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_secure_transport) && rt.is_true(rt.identical(rt.new_int(0), var_connection_error)))) && rt.is_true(rt.identical(rt.new_string(''), var_connection_error_str)))) {
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('The SSL certificate for the host could not be verified.')]))
		}
		return create_wp_error(rt.new_string('http_request_failed'), (var_connection_error).str() + ': ' + (var_connection_error_str).str())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_secure_transport) && rt.is_true(var_ssl_verify))) && rt.is_true(rt.new_bool(!(rt.is_true(var_proxy.is_enabled())))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Http_Streams.verify_ssl_certificate(var_handle.dup(), var_parsed_url.array_get('host')))))) {
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('The SSL certificate for the host could not be verified.')]))
		}
	}
	rt.call_function('stream_set_timeout', [var_handle.dup(), var_timeout.dup(), var_utimeout.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_proxy.is_enabled()) && rt.is_true(var_proxy.send_through_proxy(var_url.dup())))) {
		mut var_request_path := var_url
	} else {
		var_request_path = rt.new_string((var_parsed_url.array_get('path')).str() + if var_parsed_url.array_isset(rt.new_string('query')) { '?' + (var_parsed_url.array_get('query')).str() } else { '' })
	}
	mut var_headers := rt.new_string(var_parsed_args.array_get('method').to_string().to_upper() + ' ' + (var_request_path).str() + ' HTTP/' + (var_parsed_args.array_get('httpversion')).str() + '\r\n')
	mut var_include_port_in_host_header := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_proxy.is_enabled()) && rt.is_true(var_proxy.send_through_proxy(var_url.dup())))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('http'), var_parsed_url.array_get('scheme'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('https'), var_parsed_url.array_get('scheme'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))))
	if rt.is_true(var_include_port_in_host_header) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_parsed_args.array_isset(rt.new_string('user-agent')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.new_bool(var_parsed_args.array_get('headers').is_array())) {
		{
			mut iter_1 := rt.cast_array(var_parsed_args.array_get('headers')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_header_value := item_1.val
				mut var_header := item_1.key
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(var_proxy.use_authentication()) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_parsed_args.array_get('body').is_null()))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_function('fwrite', [var_handle.dup(), var_headers.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get('blocking'))))) {
		rt.call_function('stream_set_blocking', [var_handle.dup(), rt.new_int(0)])
		rt.call_function('fclose', [var_handle.dup()])
		return rt.create_array([rt.ArrayItem{ key: 'headers', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'body', val: '' }, rt.ArrayItem{ key: 'response', val: rt.create_array([rt.ArrayItem{ key: 'code', val: false }, rt.ArrayItem{ key: 'message', val: false }]) }, rt.ArrayItem{ key: 'cookies', val: map[string]rt.PhpVal{} }])
	}
	mut var_response := rt.new_string(rt.new_string(''))
	mut var_body_started := rt.new_bool(rt.new_bool(false))
	mut var_keep_reading := rt.new_bool(rt.new_bool(true))
	mut var_block_size := rt.new_int(rt.new_int(4096))
	if var_parsed_args.array_isset(rt.new_string('limit_response_size')) {
		var_block_size = rt.call_function('min', [var_block_size.dup(), var_parsed_args.array_get('limit_response_size')])
	}
	if rt.is_true(var_parsed_args.array_get('stream')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
			mut var_stream_handle := rt.call_function('fopen', [var_parsed_args.array_get('filename'), rt.new_string('w+')])
		} else {
			var_stream_handle = rt.call_function('fopen', [var_parsed_args.array_get('filename'), rt.new_string('w+')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_stream_handle)))) {
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not open handle for %1$s to %2$s.')]), rt.new_string('fopen()'), var_parsed_args.array_get('filename')]))
		}
		mut var_bytes_written := rt.new_int(rt.new_int(0))
		for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_handle.dup()]))))) && rt.is_true(var_keep_reading))) {
			mut var_block := rt.call_function('fread', [var_handle.dup(), var_block_size.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_body_started)))) {
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(rt.call_function('strpos', [var_response.dup(), rt.new_string('\r\n\r\n')])) {
					mut var_processed_response := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.processresponse(arg_0) }(var_response.dup())
					var_body_started = rt.new_bool(rt.new_bool(true))
					var_block = var_processed_response.array_get('body')
					var_response = rt.new_null()
					var_processed_response.array_set('body', '')
				}
			}
			mut var_this_block_size := rt.new_int(rt.new_int(var_block.dup().to_string().len))
			if rt.is_true(rt.new_bool(var_parsed_args.array_isset(rt.new_string('limit_response_size')) && rt.is_true(rt.greater(rt.add(var_bytes_written, var_this_block_size), var_parsed_args.array_get('limit_response_size'))))) {
				var_this_block_size = rt.sub(var_parsed_args.array_get('limit_response_size'), var_bytes_written)
				var_block = rt.call_function('substr', [var_block.dup(), rt.new_int(0), var_this_block_size.dup()])
			}
			mut var_bytes_written_to_file := rt.call_function('fwrite', [var_stream_handle.dup(), var_block.dup()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_function('fclose', [var_handle.dup()])
				rt.call_function('fclose', [var_stream_handle.dup()])
				return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('Failed to write request to temporary file.')]))
			}
			// unsupported expression: Expr_AssignOp_Plus
			var_keep_reading = rt.new_bool(rt.new_bool(!(var_parsed_args.array_isset(rt.new_string('limit_response_size'))) || rt.is_true(rt.less(var_bytes_written, var_parsed_args.array_get('limit_response_size')))))
		}
		rt.call_function('fclose', [var_stream_handle.dup()])
	} else {
		mut var_header_length := rt.new_int(rt.new_int(0))
		for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_handle.dup()]))))) && rt.is_true(var_keep_reading))) {
			var_block = rt.call_function('fread', [var_handle.dup(), var_block_size.dup()])
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_body_started)))) && rt.is_true(rt.call_function('strpos', [var_response.dup(), rt.new_string('\r\n\r\n')])))) {
				var_header_length = rt.add(rt.call_function('strpos', [var_response.dup(), rt.new_string('\r\n\r\n')]), rt.new_int(4))
				var_body_started = rt.new_bool(rt.new_bool(true))
			}
			var_keep_reading = rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_body_started)))) || !(var_parsed_args.array_isset(rt.new_string('limit_response_size'))))) || rt.is_true(rt.less(rt.new_int(var_response.dup().to_string().len), rt.add(var_header_length, var_parsed_args.array_get('limit_response_size'))))))
		}
		var_processed_response = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.processresponse(arg_0) }(var_response.dup())
		var_response = rt.new_null()
	}
	rt.call_function('fclose', [var_handle.dup()])
	mut var_processed_headers := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.processheaders(arg_0, arg_1) }(var_processed_response.array_get('headers'), var_url.dup())
	var_response = rt.create_array([rt.ArrayItem{ key: 'headers', val: .array_get() }, rt.ArrayItem{ key: 'body', val: rt.new_null() }, rt.ArrayItem{ key: 'response', val: .array_get() }, rt.ArrayItem{ key: 'cookies', val: .array_get() }, rt.ArrayItem{ key: 'filename', val: .array_get() }])
	mut var_redirect_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.handle_redirects(arg_0, arg_1, arg_2) }(.dup(), .dup(), .dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return .dup()
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn Class_WP_Http_Streams.verify_ssl_certificate(var_stream rt.PhpVal, var_host rt.PhpVal) bool {
	mut var_match_type := rt.new_null()
	mut var_match_host := rt.new_null()
}

fn Class_WP_Http_Streams.test(var_args rt.PhpVal) bool {
}

struct Class_WP_Http {
	rt.PhpObjectBase
}

struct Class_WP_HTTP_Proxy {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_http_streams() &Class_WP_Http_Streams {
	mut obj := &Class_WP_Http_Streams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_fsockopen() &Class_WP_HTTP_Fsockopen {
	mut obj := &Class_WP_HTTP_Fsockopen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http() &Class_WP_Http {
	mut obj := &Class_WP_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_proxy() &Class_WP_HTTP_Proxy {
	mut obj := &Class_WP_HTTP_Proxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Http_Streams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.request(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_ssl_certificate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Http_Streams.verify_ssl_certificate(dispatch_arg_0, dispatch_arg_1))
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Http_Streams.test(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Http_Streams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http_Streams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTTP_Fsockopen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Fsockopen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Fsockopen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTTP_Proxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Proxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Proxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_http_streams_php() {
}

import rt

struct Class_WP_Http_Curl {
	rt.PhpObjectBase
pub mut:
		headers string
		body string
		max_body_length rt.PhpVal = rt.new_bool(false)
		stream_handle rt.PhpVal = rt.new_bool(false)
		bytes_written_total i64
}

fn (mut this Class_WP_Http_Curl) request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
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
	mut var_handle := rt.call_function('curl_init', []rt.PhpVal{})
	mut var_proxy := create_wp_http_proxy()
	if rt.is_true(rt.new_bool(rt.is_true(var_proxy.is_enabled()) && rt.is_true(var_proxy.send_through_proxy(var_url.dup())))) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYTYPE'), rt.get_constant('CURLPROXY_HTTP')])
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXY'), var_proxy.host()])
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYPORT'), var_proxy.port()])
		if rt.is_true(var_proxy.use_authentication()) {
			rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYAUTH'), rt.get_constant('CURLAUTH_ANY')])
			rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROXYUSERPWD'), var_proxy.authentication()])
		}
	}
	mut var_is_local := rt.new_bool(rt.new_bool(var_parsed_args.array_isset(rt.new_string('local')) && rt.is_true(var_parsed_args.array_get('local'))))
	mut var_ssl_verify := rt.new_bool(rt.new_bool(var_parsed_args.array_isset(rt.new_string('sslverify')) && rt.is_true(var_parsed_args.array_get('sslverify'))))
	if rt.is_true(var_is_local) {
		var_ssl_verify = rt.call_function('apply_filters', [rt.new_string('https_local_ssl_verify'), var_ssl_verify.dup(), var_url.dup()])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_local)))) {
		var_ssl_verify = rt.call_function('apply_filters', [rt.new_string('https_ssl_verify'), var_ssl_verify.dup(), var_url.dup()])
	}
	mut var_timeout := // unsupported expression: Expr_Cast_Int
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_CONNECTTIMEOUT'), var_timeout.dup()])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_TIMEOUT'), var_timeout.dup()])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_URL'), var_url.dup()])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_RETURNTRANSFER'), rt.new_bool(true)])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_SSL_VERIFYHOST'), if rt.is_true(rt.identical(rt.new_bool(true), var_ssl_verify)) { rt.new_int(2) } else { rt.new_bool(false) }])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_SSL_VERIFYPEER'), var_ssl_verify.dup()])
	if rt.is_true(var_ssl_verify) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_CAINFO'), var_parsed_args.array_get('sslcertificates')])
	}
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_USERAGENT'), var_parsed_args.array_get('user-agent')])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_FOLLOWLOCATION'), rt.new_bool(false)])
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_PROTOCOLS'), rt.bitwise_or(rt.get_constant('CURLPROTO_HTTP'), rt.get_constant('CURLPROTO_HTTPS'))])
	mut switch_val_1 := var_parsed_args.array_get('method')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('HEAD'))) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_NOBODY'), rt.new_bool(true)])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('POST'))) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_POST'), rt.new_bool(true)])
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_POSTFIELDS'), var_parsed_args.array_get('body')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('PUT'))) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_CUSTOMREQUEST'), rt.new_string('PUT')])
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_POSTFIELDS'), var_parsed_args.array_get('body')])
	} else {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_CUSTOMREQUEST'), var_parsed_args.array_get('method')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_parsed_args.array_get('body').is_null()))))) {
			rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_POSTFIELDS'), var_parsed_args.array_get('body')])
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_parsed_args.array_get('blocking'))) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_HEADERFUNCTION'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Http_Curl', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'stream_headers' }])])
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_WRITEFUNCTION'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Http_Curl', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'stream_body' }])])
	}
	rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_HEADER'), rt.new_bool(false)])
	if var_parsed_args.array_isset(rt.new_string('limit_response_size')) {
		this.max_body_length = // unsupported expression: Expr_Cast_Int
	} else {
		this.max_body_length = rt.new_bool(false)
	}
	if rt.is_true(var_parsed_args.array_get('stream')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
			this.stream_handle = rt.call_function('fopen', [var_parsed_args.array_get('filename'), rt.new_string('w+')])
		} else {
			this.stream_handle = rt.call_function('fopen', [var_parsed_args.array_get('filename'), rt.new_string('w+')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.stream_handle)))) {
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not open handle for %1$s to %2$s.')]), rt.new_string('fopen()'), var_parsed_args.array_get('filename')]))
		}
	} else {
		this.stream_handle = rt.new_bool(false)
	}
	if !(!rt.is_true(var_parsed_args.array_get('headers'))) {
		mut var_headers := map[string]rt.PhpVal{}
		{
			mut iter_1 := var_parsed_args.array_get('headers').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_name := item_1.key
				var_headers << "${var_name.to_string()}: ${var_value.to_string()}"
			}
		}
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_HTTPHEADER'), var_headers.dup()])
	}
	if rt.is_true(rt.identical(rt.new_string('1.0'), var_parsed_args.array_get('httpversion'))) {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_HTTP_VERSION'), rt.get_constant('CURL_HTTP_VERSION_1_0')])
	} else {
		rt.call_function('curl_setopt', [var_handle.dup(), rt.get_constant('CURLOPT_HTTP_VERSION'), rt.get_constant('CURL_HTTP_VERSION_1_1')])
	}
	rt.call_function('do_action_ref_array', [rt.new_string('http_api_curl'), rt.create_array([rt.ArrayItem{ key: none, val: var_handle }, rt.ArrayItem{ key: none, val: var_parsed_args }, rt.ArrayItem{ key: none, val: var_url }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get('blocking'))))) {
		rt.call_function('curl_exec', [var_handle.dup()])
		mut var_curl_error := rt.call_function('curl_error', [var_handle.dup()])
		if rt.is_true(var_curl_error) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('curl_close', [var_handle.dup()])
			}
			return create_wp_error(rt.new_string('http_request_failed'), var_curl_error.dup())
		}
		if rt.is_true(rt.call_function('in_array', [rt.call_function('curl_getinfo', [var_handle.dup(), rt.get_constant('CURLINFO_HTTP_CODE')]), rt.create_array([rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }]), rt.new_bool(true)])) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('curl_close', [var_handle.dup()])
			}
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('Too many redirects.')]))
		}
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
			rt.call_function('curl_close', [var_handle.dup()])
		}
		return rt.create_array([rt.ArrayItem{ key: 'headers', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'body', val: '' }, rt.ArrayItem{ key: 'response', val: rt.create_array([rt.ArrayItem{ key: 'code', val: false }, rt.ArrayItem{ key: 'message', val: false }]) }, rt.ArrayItem{ key: 'cookies', val: map[string]rt.PhpVal{} }])
	}
	rt.call_function('curl_exec', [var_handle.dup()])
	mut var_processed_headers := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.processheaders(arg_0, arg_1) }(rt.new_string(this.headers), var_url.dup())
	mut var_body := rt.new_string(this.body)
	mut var_bytes_written_total := rt.new_int(this.bytes_written_total)
	this.headers = ''
	this.body = ''
	this.bytes_written_total = 0
	var_curl_error = rt.call_function('curl_errno', [var_handle.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_curl_error) || 0 == var_body.dup().to_string().len && !rt.is_true(var_processed_headers.array_get('headers')))) {
		if rt.is_true(rt.identical(rt.get_constant('CURLE_WRITE_ERROR'), var_curl_error)) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.max_body_length)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				if rt.is_true(var_parsed_args.array_get('stream')) {
					if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
						rt.call_function('curl_close', [var_handle.dup()])
					}
					rt.call_function('fclose', [this.stream_handle])
					return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('Failed to write request to temporary file.')]))
				} else {
					if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
						rt.call_function('curl_close', [var_handle.dup()])
					}
					return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('curl_error', [var_handle.dup()]))
				}
			}
		} else {
			var_curl_error = rt.call_function('curl_error', [var_handle.dup()])
			if rt.is_true(var_curl_error) {
				if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
					rt.call_function('curl_close', [var_handle.dup()])
				}
				return create_wp_error(rt.new_string('http_request_failed'), var_curl_error.dup())
			}
		}
		if rt.is_true(rt.call_function('in_array', [rt.call_function('curl_getinfo', [var_handle.dup(), rt.get_constant('CURLINFO_HTTP_CODE')]), rt.create_array([rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }]), rt.new_bool(true)])) {
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('curl_close', [var_handle.dup()])
			}
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [rt.new_string('Too many redirects.')]))
		}
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('curl_close', [var_handle.dup()])
	}
	if rt.is_true(var_parsed_args.array_get('stream')) {
		rt.call_function('fclose', [this.stream_handle])
	}
	mut var_response := { 'headers': var_processed_headers.array_get('headers'), 'body': rt.new_null(), 'response': var_processed_headers.array_get('response'), 'cookies': var_processed_headers.array_get('cookies'), 'filename': var_parsed_args.array_get('filename') }
	mut var_redirect_response := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http{}; return temp.handle_redirects(arg_0, arg_1, arg_2) }(var_url.dup(), var_parsed_args.dup(), var_response.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_redirect_response.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), var_parsed_args.array_get('decompress'))) && rt.is_true(rt.identical(rt.new_bool(true), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http_Encoding{}; return temp.should_decode(arg_0) }(var_processed_headers.array_get('headers')))))) {
		var_body = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Http_Encoding{}; return temp.decompress(arg_0) }(var_body.dup())
	}
	var_response['body'] = var_body.dup()
	return var_response.dup()
}

fn (mut this Class_WP_Http_Curl) stream_headers(var_handle rt.PhpVal, var_headers rt.PhpVal) i64 {
	mut var_handle_mutated := var_handle
	mut var_headers_mutated := var_headers
	// unsupported expression: Expr_AssignOp_Concat
	return var_headers_mutated.dup().to_string().len
}

fn (mut this Class_WP_Http_Curl) stream_body(var_handle rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_data_mutated := var_data
	mut var_data_length := rt.new_int(rt.new_int(var_data_mutated.dup().to_string().len))
	if rt.is_true(rt.new_bool(rt.is_true(this.max_body_length) && rt.is_true(rt.greater(rt.add(this.bytes_written_total, var_data_length), this.max_body_length)))) {
		var_data_length = rt.sub(this.max_body_length, this.bytes_written_total)
		var_data_mutated = rt.call_function('substr', [var_data_mutated.dup(), rt.new_int(0), var_data_length.dup()])
	}
	if rt.is_true(this.stream_handle) {
		mut var_bytes_written := rt.call_function('fwrite', [this.stream_handle, var_data_mutated.dup()])
	} else {
		// unsupported expression: Expr_AssignOp_Concat
		var_bytes_written = var_data_length.dup()
	}
	// unsupported expression: Expr_AssignOp_Plus
	return var_bytes_written.dup()
}

fn Class_WP_Http_Curl.test(var_args rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true() || rt.is_true())) {
		return 
	}
	
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

struct Class_WP_Http_Encoding {
	rt.PhpObjectBase
}

fn create_wp_http_curl() &Class_WP_Http_Curl {
	mut obj := &Class_WP_Http_Curl{
		PhpObjectBase: rt.PhpObjectBase{}
		headers: ''
		body: ''
		max_body_length: rt.new_bool(false)
		stream_handle: rt.new_bool(false)
		bytes_written_total: i64(0)
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

fn create_wp_http_encoding() &Class_WP_Http_Encoding {
	mut obj := &Class_WP_Http_Encoding{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Http_Curl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.request(dispatch_arg_0, dispatch_arg_1)
		}
		'stream_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.stream_headers(dispatch_arg_0, dispatch_arg_1))
		}
		'stream_body' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.stream_body(dispatch_arg_0, dispatch_arg_1)
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Http_Curl.test(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Http_Curl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'headers' { return rt.new_string(this.headers) }
		'body' { return rt.new_string(this.body) }
		'max_body_length' { return this.max_body_length }
		'stream_handle' { return this.stream_handle }
		'bytes_written_total' { return rt.new_int(this.bytes_written_total) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Http_Curl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'headers' { this.headers = (val).str(); return true }
		'body' { this.body = (val).str(); return true }
		'max_body_length' { this.max_body_length = val; return true }
		'stream_handle' { this.stream_handle = val; return true }
		'bytes_written_total' { this.bytes_written_total = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Http_Encoding) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http_Encoding) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http_Encoding) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_http_curl_php() {
}

import rt

struct Class_SimplePie_File {
	rt.PhpObjectBase
pub mut:
		url rt.PhpVal = rt.new_null()
		useragent rt.PhpVal = rt.new_null()
		success bool
		parsed_headers rt.PhpVal = rt.new_array()
		last_headers rt.PhpVal = rt.new_array()
		headers rt.PhpVal = rt.new_array()
		body rt.PhpVal = rt.new_null()
		status_code rt.PhpVal = rt.new_int(0)
		redirects rt.PhpVal = rt.new_int(0)
		error rt.PhpVal = rt.new_null()
		method rt.PhpVal = rt.new_null()
		permanent_url string
		permanentUrlMutable bool
}

fn (mut this Class_SimplePie_File) construct(url string, timeout i64, redirects i64, mut var_headers Class_SimplePie_?array, mut var_useragent Class_SimplePie_?string, force_fsockopen bool, mut var_curl_options Class_SimplePie_array)  {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut url_mutated := url
	mut var_headers_mutated := var_headers
	mut var_useragent_mutated := var_useragent
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('idn_to_ascii')])) {
		mut var_parsed := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.parse_url(arg_0) }(rt.new_string(url_mutated))
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_print', [var_parsed.array_get('authority')]))))))) {
			mut var_authority := // unsupported expression: Expr_Cast_String
			url_mutated = (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.compress_parse_url(arg_0, arg_1, arg_2, arg_3, arg_4) }(var_parsed.array_get('scheme'), var_authority.dup(), var_parsed.array_get('path'), var_parsed.array_get('query'), rt.new_null())).str()
		}
	}
	this.url = rt.new_string(url_mutated).dup()
	if rt.is_true(this.permanentUrlMutable) {
		this.permanent_url = (rt.new_string(url_mutated)).str()
	}
	this.useragent = var_useragent_mutated.dup()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^http(s)?:\\/\\//i'), rt.new_string(url_mutated).dup()])) {
		if rt.is_true(rt.identical(var_useragent_mutated, rt.new_null())) {
			var_useragent_mutated = // unsupported expression: Expr_Cast_String
			this.useragent = var_useragent_mutated.dup()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_headers_mutated.dup().is_array()))))) {
			var_headers_mutated = rt.new_array()
		}
		if rt.is_true(rt.new_bool(!(var_force_fsockopen) && rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_exec')])))) {
			this.method = rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.file_source_remote(), Class_SimplePie_SimplePie_SimplePie.file_source_curl())
			mut var_fp := rt.call_function('curl_init', []rt.PhpVal{})
			mut var_headers2 := rt.new_array()
			{
				mut iter_1 := var_headers_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					var_headers2.array_push("${var_key.to_string()}: ${var_value.to_string()}")
				}
			}
			if var_curl_options.array_isset(rt.get_constant('CURLOPT_HTTPHEADER')) {
				if rt.is_true(rt.new_bool(var_curl_options.array_get(rt.get_constant('CURLOPT_HTTPHEADER')).is_array())) {
					var_headers2 = rt.call_function('array_merge', [var_headers2.dup(), var_curl_options.array_get(rt.get_constant('CURLOPT_HTTPHEADER'))])
				}
				var_curl_options.array_unset(rt.get_constant('CURLOPT_HTTPHEADER'))
			}
			if rt.is_true(rt.call_function('version_compare', [fn () rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.get_curl_version() }(), rt.new_string('7.10.5'), rt.new_string('>=')])) {
				rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_ENCODING'), rt.new_string('')])
			}
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_URL'), rt.new_string(url_mutated).dup()])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_HEADER'), rt.new_int(1)])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_RETURNTRANSFER'), rt.new_int(1)])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_FAILONERROR'), rt.new_int(1)])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_TIMEOUT'), rt.new_int(timeout)])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_CONNECTTIMEOUT'), rt.new_int(timeout)])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_REFERER'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.url_remove_credentials(arg_0) }(rt.new_string(url_mutated))])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_USERAGENT'), var_useragent_mutated.dup()])
			rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_HTTPHEADER'), var_headers2.dup()])
			{
				mut iter_1 := var_curl_options.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_curl_value := item_1.val
					mut var_curl_param := item_1.key
					rt.call_function('curl_setopt', [var_fp.dup(), var_curl_param.dup(), var_curl_value.dup()])
				}
			}
			mut var_responseHeaders := rt.call_function('curl_exec', [var_fp.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('curl_errno', [var_fp.dup()]), rt.get_constant('CURLE_WRITE_ERROR'))) || rt.is_true(rt.identical(rt.call_function('curl_errno', [var_fp.dup()]), rt.get_constant('CURLE_BAD_CONTENT_ENCODING'))))) {
				rt.call_function('curl_setopt', [var_fp.dup(), rt.get_constant('CURLOPT_ENCODING'), rt.new_string('none')])
				var_responseHeaders = rt.call_function('curl_exec', [var_fp.dup()])
			}
			this.status_code = rt.call_function('curl_getinfo', [var_fp.dup(), rt.get_constant('CURLINFO_HTTP_CODE')])
			if rt.is_true(rt.call_function('curl_errno', [var_fp.dup()])) {
				this.error = 'cURL error ' + (rt.call_function('curl_errno', [var_fp.dup()])).str() + ': ' + (rt.call_function('curl_error', [var_fp.dup()])).str()
				this.success = false
			} else {
				if rt.is_true(mut var_info := rt.call_function('curl_getinfo', [var_fp.dup()])) {
					this.url = var_info.array_get('url')
				}
				rt.call_function('assert', [rt.new_bool(rt.is_true(rt.new_bool(var_info.dup().is_array())) && rt.is_true(rt.greater_equal(var_info.array_get('redirect_count'), rt.new_int(0))))])
				if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
					rt.call_function('curl_close', [var_fp.dup()])
				}
				var_responseHeaders = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_HTTP_Parser{}; return temp.prepareheaders(arg_0, arg_1) }(// unsupported expression: Expr_Cast_String, rt.add(var_info.array_get('redirect_count'), rt.new_int(1)))
				mut var_parser := create_simplepie_simplepie_http_parser(var_responseHeaders.dup(), rt.new_bool(true))
				if rt.is_true(var_parser.parse()) {
					this.set_headers(mut rt.cast_object_ptr[Class_SimplePie_array](rt.get_property(var_parser, 'headers')))
					this.body = rt.get_property(var_parser, 'body')
					this.status_code = rt.get_property(var_parser, 'status_code')
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [this.status_code, rt.create_array([rt.ArrayItem{ key: none, val: 300 }, rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }, rt.ArrayItem{ key: none, val: 303 }, rt.ArrayItem{ key: none, val: 307 }])])) || rt.is_true(rt.new_bool(rt.is_true(rt.greater(this.status_code, rt.new_int(307))) && rt.is_true(rt.less(this.status_code, rt.new_int(400))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.less(this.redirects, rt.new_int(redirects))))) {
						rt.post_inc(this.redirects)
						mut var_location := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.absolutize_url(arg_0, arg_1) }(var_locationHeader.dup(), rt.new_string(url_mutated))
						if rt.is_true(rt.identical(var_location, rt.new_bool(false))) {
							this.error = rt.new_string("Invalid redirect location, trying to base “${var_locationHeader.to_string()}” onto “${var_url.to_string()}”")
							this.success = false
							return
						}
						this.permanentUrlMutable = rt.is_true(this.permanentUrlMutable) && rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.status_code, rt.new_int(301))) || rt.is_true(rt.equal(this.status_code, rt.new_int(308)))))
						this.construct((var_location).str(), timeout, redirects, mut var_headers_mutated, mut var_useragent_mutated, force_fsockopen, mut var_curl_options)
						return
					}
				}
			}
		} else {
			this.method = rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.file_source_remote(), Class_SimplePie_SimplePie_SimplePie.file_source_fsockopen())
			if rt.is_true(rt.identical(mut var_url_parts := rt.call_function('parse_url', [rt.new_string(url_mutated).dup()]), rt.new_bool(false))) {
				rt.throw_exception(rt.new_object('SimplePie_InvalidArgumentException', []string{}, create_simplepie_invalidargumentexception('Malformed URL: ' + url_mutated)))
			}
			if !(var_url_parts.array_isset(rt.new_string('host'))) {
				rt.throw_exception(rt.new_object('SimplePie_InvalidArgumentException', []string{}, create_simplepie_invalidargumentexception('Missing hostname: ' + url_mutated)))
			}
			mut var_socket_host := var_url_parts.array_get('host')
			if rt.is_true(rt.new_bool(var_url_parts.array_isset(rt.new_string('scheme')) && rt.is_true(rt.identical(rt.new_string(var_url_parts.array_get('scheme').to_string().to_lower()), rt.new_string('https'))))) {
				var_socket_host = rt.new_string('ssl://' + (var_socket_host).str())
				var_url_parts.array_set('port', 443)
			}
			if !(var_url_parts.array_isset(rt.new_string('port'))) {
				var_url_parts.array_set('port', 80)
			}
			var_fp = rt.call_function('fsockopen', [var_socket_host.dup(), var_url_parts.array_get('port'), var_errno.dup(), var_errstr.dup(), rt.new_int(timeout)])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
				this.error = 'fsockopen error: ' + (var_errstr).str()
				this.success = false
			} else {
				rt.call_function('stream_set_timeout', [var_fp.dup(), rt.new_int(timeout)])
				if var_url_parts.array_isset(rt.new_string('path')) {
					if var_url_parts.array_isset(rt.new_string('query')) {
						mut var_get := rt.new_string(rt.concat(rt.concat(var_url_parts.array_get('path'), rt.new_string('?')), var_url_parts.array_get('query')))
					} else {
						var_get = var_url_parts.array_get('path')
					}
				} else {
					var_get = rt.new_string(rt.new_string('/'))
				}
				mut var_out := rt.new_string(rt.new_string("GET ${var_get.to_string()} HTTP/1.1\r\n"))
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('zlib')])) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				if var_url_parts.array_isset(rt.new_string('user')) && var_url_parts.array_isset(rt.new_string('pass')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				{
					mut iter_1 := var_headers_mutated.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_value := item_1.val
						mut var_key := item_1.key
						// unsupported expression: Expr_AssignOp_Concat
					}
				}
				// unsupported expression: Expr_AssignOp_Concat
				rt.call_function('fwrite', [var_fp.dup(), var_out.dup()])
				var_info = rt.call_function('stream_get_meta_data', [var_fp.dup()])
				var_responseHeaders = rt.new_string(rt.new_string(''))
				for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_info.array_get('eof'))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_info.array_get('timed_out'))))))) {
					// unsupported expression: Expr_AssignOp_Concat
					var_info = rt.call_function('stream_get_meta_data', [var_fp.dup()])
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_info.array_get('timed_out'))))) {
					var_parser = create_simplepie_simplepie_http_parser(var_responseHeaders.dup(), rt.new_bool(true))
					if rt.is_true(var_parser.parse()) {
						this.set_headers(mut rt.cast_object_ptr[Class_SimplePie_array](rt.get_property(var_parser, 'headers')))
						this.body = rt.get_property(var_parser, 'body')
						this.status_code = rt.get_property(var_parser, 'status_code')
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [this.status_code, rt.create_array([rt.ArrayItem{ key: none, val: 300 }, rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }, rt.ArrayItem{ key: none, val: 303 }, rt.ArrayItem{ key: none, val: 307 }])])) || rt.is_true(rt.new_bool(rt.is_true(rt.greater(this.status_code, rt.new_int(307))) && rt.is_true(rt.less(this.status_code, rt.new_int(400))))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.less(this.redirects, rt.new_int(redirects))))) {
							rt.post_inc(this.redirects)
							var_location = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_SimplePie_Misc{}; return temp.absolutize_url(arg_0, arg_1) }(var_locationHeader.dup(), rt.new_string(url_mutated))
							this.permanentUrlMutable = rt.is_true(this.permanentUrlMutable) && rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.status_code, rt.new_int(301))) || rt.is_true(rt.equal(this.status_code, rt.new_int(308)))))
							if rt.is_true(rt.identical(var_location, rt.new_bool(false))) {
								this.error = rt.new_string("Invalid redirect location, trying to base “${var_locationHeader.to_string()}” onto “${var_url.to_string()}”")
								this.success = false
								return
							}
							this.construct(().str(), , , mut , mut , , mut )
							return
						}
						if rt.is_true() {
						}
					}
				} else {
					this.error = 
					
				}
				
			}
		}
	} else {
		this.method = 
		if rt.is_true() {
		} else {
		}
	}
	if rt.is_true(this.success) {
		
	}
}

fn (mut this Class_SimplePie_File) get_permanent_uri() string {
	return ().str()
}

fn (mut this Class_SimplePie_File) get_final_requested_uri() string {
}

fn (mut this Class_SimplePie_File) get_status_code() i64 {
}

fn (mut this Class_SimplePie_File) get_headers() rt.PhpVal {
}

fn (mut this Class_SimplePie_File) has_header(name string) bool {
}

fn (mut this Class_SimplePie_File) get_header(name string) rt.PhpVal {
}

fn (mut this Class_SimplePie_File) with_header(name string, var_value rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_SimplePie_File) get_header_line(name string) string {
}

fn (mut this Class_SimplePie_File) get_body_content() string {
}

fn (mut this Class_SimplePie_File) maybe_update_headers()  {
}

fn (mut this Class_SimplePie_File) set_headers(mut var_headers Class_SimplePie_array)  {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_SimplePie_File) flatten_headers(mut var_headers Class_SimplePie_array) rt.PhpVal {
	mut var_headers_mutated := var_headers
}

fn Class_SimplePie_File.fromresponse(mut var_response Class_SimplePie_HTTP_Response) rt.PhpVal {
}

struct Class_SimplePie_SimplePie_Misc {
	rt.PhpObjectBase
}

struct Class_SimplePie_SimplePie_HTTP_Parser {
	rt.PhpObjectBase
}

struct Class_SimplePie_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_simplepie_file(url string, timeout i64, redirects i64, arg_3 rt.PhpVal, arg_4 rt.PhpVal, force_fsockopen bool, arg_6 rt.PhpVal) &Class_SimplePie_File {
	mut obj := &Class_SimplePie_File{
		PhpObjectBase: rt.PhpObjectBase{}
		url: rt.new_null()
		useragent: rt.new_null()
		success: false
		parsed_headers: rt.new_array()
		last_headers: rt.new_array()
		headers: rt.new_array()
		body: rt.new_null()
		status_code: rt.new_int(0)
		redirects: rt.new_int(0)
		error: rt.new_null()
		method: rt.new_null()
		permanent_url: ''
		permanentUrlMutable: false
	}
	obj.construct(url, timeout, redirects, arg_3, arg_4, force_fsockopen, arg_6)
	return obj
}

fn create_simplepie_simplepie_misc() &Class_SimplePie_SimplePie_Misc {
	mut obj := &Class_SimplePie_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_simplepie_http_parser() &Class_SimplePie_SimplePie_HTTP_Parser {
	mut obj := &Class_SimplePie_SimplePie_HTTP_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_invalidargumentexception() &Class_SimplePie_InvalidArgumentException {
	mut obj := &Class_SimplePie_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 6 { args[6] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5, mut dispatch_arg_6)
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
		'maybe_update_headers' {
			this.maybe_update_headers()
			return rt.new_null()
		}
		'set_headers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_headers(mut dispatch_arg_0)
			return rt.new_null()
		}
		'flatten_headers' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.flatten_headers(mut dispatch_arg_0)
		}
		'fromResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_HTTP_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_SimplePie_File.fromresponse(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'url' { return this.url }
		'useragent' { return this.useragent }
		'success' { return rt.new_bool(this.success) }
		'parsed_headers' { return this.parsed_headers }
		'last_headers' { return this.last_headers }
		'headers' { return this.headers }
		'body' { return this.body }
		'status_code' { return this.status_code }
		'redirects' { return this.redirects }
		'error' { return this.error }
		'method' { return this.method }
		'permanent_url' { return rt.new_string(this.permanent_url) }
		'permanentUrlMutable' { return rt.new_bool(this.permanentUrlMutable) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'url' { this.url = val; return true }
		'useragent' { this.useragent = val; return true }
		'success' { this.success = (val).to_bool(); return true }
		'parsed_headers' { this.parsed_headers = val; return true }
		'last_headers' { this.last_headers = val; return true }
		'headers' { this.headers = val; return true }
		'body' { this.body = val; return true }
		'status_code' { this.status_code = val; return true }
		'redirects' { this.redirects = val; return true }
		'error' { this.error = val; return true }
		'method' { this.method = val; return true }
		'permanent_url' { this.permanent_url = (val).str(); return true }
		'permanentUrlMutable' { this.permanentUrlMutable = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_SimplePie_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_SimplePie_HTTP_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_HTTP_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_HTTP_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_file_php() {
	// unsupported statement: Stmt_Declare
}

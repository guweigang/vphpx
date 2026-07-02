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

fn (mut this Class_SimplePie_File) construct(url string, timeout i64, redirects i64, mut var_headers Class_SimplePie_?array, mut var_useragent Class_SimplePie_?string, force_fsockopen bool, mut var_curl_options Class_SimplePie_array) {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut url_mutated := url
	mut var_headers_mutated := var_headers
	mut var_useragent_mutated := var_useragent
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('idn_to_ascii')])) {
		mut iife_temp_0 := Class_SimplePie_SimplePie_Misc{}
		mut iife_result_0 := iife_temp_0.parse_url(rt.new_string(url_mutated))
		mut var_parsed := iife_result_0
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsed.array_get(rt.new_string('authority')), rt.new_string(''))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_print', [var_parsed.array_get(rt.new_string('authority'))]))))) {
		mut var_authority := rt.new_string((rt.call_function('idn_to_ascii', [var_parsed.array_get(rt.new_string('authority')), rt.get_constant('IDNA_NONTRANSITIONAL_TO_ASCII'), rt.get_constant('INTL_IDNA_VARIANT_UTS46')])).str())
		mut iife_temp_1 := Class_SimplePie_SimplePie_Misc{}
		mut iife_result_1 := iife_temp_1.compress_parse_url(var_parsed.array_get(rt.new_string('scheme')), var_authority.clone(), var_parsed.array_get(rt.new_string('path')), var_parsed.array_get(rt.new_string('query')), rt.new_null())
		url_mutated = (iife_result_1).str()
		}
	}
	this.url = rt.new_string(url_mutated).clone()
	if this.permanentUrlMutable {
		this.permanent_url = (rt.new_string(url_mutated)).str()
	}
	this.useragent = var_useragent_mutated
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^http(s)?:\\/\\//i'), rt.new_string(url_mutated).clone()])) {
		if rt.is_true(rt.identical(var_useragent_mutated, rt.new_null())) {
			var_useragent_mutated = rt.new_string((rt.call_function('ini_get', [rt.new_string('user_agent')])).str())
			this.useragent = var_useragent_mutated
		}
		if !(var_headers_mutated.is_array()) {
		var_headers_mutated = rt.new_array()
		}
		if !(var_force_fsockopen) && rt.is_true(rt.call_function('function_exists', [rt.new_string('curl_exec')])) {
			this.method = rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.file_source_remote(), Class_SimplePie_SimplePie_SimplePie.file_source_curl())
			mut var_fp := rt.call_function('curl_init', []rt.PhpVal{})
			mut var_headers2 := rt.new_array()
			mut iter_1 := var_headers_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				var_headers2.array_push("${var_key.to_string()}: ${var_value.to_string()}")
			}
			if var_curl_options.array_isset(rt.get_constant('CURLOPT_HTTPHEADER')) {
				if rt.is_true(rt.new_bool(var_curl_options.array_get(rt.get_constant('CURLOPT_HTTPHEADER')).is_array())) {
				var_headers2 = rt.call_function('array_merge', [var_headers2.clone(), var_curl_options.array_get(rt.get_constant('CURLOPT_HTTPHEADER'))])
				}
				var_curl_options.array_unset(rt.get_constant('CURLOPT_HTTPHEADER'))
			}
			mut iife_temp_2 := Class_SimplePie_SimplePie_Misc{}
			mut iife_result_2 := iife_temp_2.get_curl_version()
			mut iife_temp_3 := Class_SimplePie_SimplePie_Misc{}
			mut iife_result_3 := iife_temp_3.get_curl_version()
			if rt.is_true(rt.call_function('version_compare', [iife_result_2, rt.new_string('7.10.5'), rt.new_string('>=')])) {
				rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_ENCODING'), rt.new_string('')])
			}
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_URL'), rt.new_string(url_mutated).clone()])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_HEADER'), rt.new_int(1)])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_RETURNTRANSFER'), rt.new_int(1)])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_FAILONERROR'), rt.new_int(1)])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_TIMEOUT'), rt.new_int(timeout)])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_CONNECTTIMEOUT'), rt.new_int(timeout)])
			mut iife_temp_4 := Class_SimplePie_SimplePie_Misc{}
			mut iife_result_4 := iife_temp_4.url_remove_credentials(rt.new_string(url_mutated))
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_REFERER'), iife_result_4])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_USERAGENT'), var_useragent_mutated])
			rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_HTTPHEADER'), var_headers2.clone()])
			mut iter_2 := var_curl_options.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_curl_value := item_2.val
				mut var_curl_param := item_2.key
				rt.call_function('curl_setopt', [var_fp.clone(), var_curl_param.clone(), var_curl_value.clone()])
			}
			mut var_responseHeaders := rt.call_function('curl_exec', [var_fp.clone()])
			if rt.is_true(rt.identical(rt.call_function('curl_errno', [var_fp.clone()]), rt.get_constant('CURLE_WRITE_ERROR'))) || rt.is_true(rt.identical(rt.call_function('curl_errno', [var_fp.clone()]), rt.get_constant('CURLE_BAD_CONTENT_ENCODING'))) {
				rt.call_function('curl_setopt', [var_fp.clone(), rt.get_constant('CURLOPT_ENCODING'), rt.new_string('none')])
			var_responseHeaders = rt.call_function('curl_exec', [var_fp.clone()])
			}
			this.status_code = rt.call_function('curl_getinfo', [var_fp.clone(), rt.get_constant('CURLINFO_HTTP_CODE')])
			if rt.is_true(rt.call_function('curl_errno', [var_fp.clone()])) {
				this.error = 'cURL error ' + (rt.call_function('curl_errno', [var_fp.clone()])).str() + ': ' + (rt.call_function('curl_error', [var_fp.clone()])).str()
				this.success = false
			} else {
				mut var_info := rt.call_function('curl_getinfo', [var_fp.clone()])
				if rt.is_true(var_info) {
					this.url = var_info.array_get(rt.new_string('url'))
				}
				rt.call_function('assert', [rt.new_bool(var_info.clone().is_array() && rt.is_true(rt.greater_equal(var_info.array_get(rt.new_string('redirect_count')), rt.new_int(0))))])
				if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
					rt.call_function('curl_close', [var_fp.clone()])
				}
				mut iife_temp_5 := Class_SimplePie_SimplePie_HTTP_Parser{}
				mut iife_result_5 := iife_temp_5.prepareheaders(rt.new_string((var_responseHeaders).str()), rt.add(var_info.array_get(rt.new_string('redirect_count')), rt.new_int(1)))
				var_responseHeaders = iife_result_5
				mut var_parser := create_simplepie_simplepie_http_parser(var_responseHeaders.clone(), rt.new_bool(true))
				if rt.is_true(var_parser.parse()) {
					this.set_headers(mut rt.cast_object_ptr[Class_SimplePie_array](rt.get_property(var_parser, 'headers')))
					this.body = rt.get_property(var_parser, 'body')
					this.status_code = rt.get_property(var_parser, 'status_code')
					mut var_locationHeader := rt.new_string(this.get_header_line('location'))
					if rt.is_true(rt.call_function('in_array', [this.status_code, rt.create_array([rt.ArrayItem{ key: none, val: 300 }, rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }, rt.ArrayItem{ key: none, val: 303 }, rt.ArrayItem{ key: none, val: 307 }])])) || (rt.is_true(rt.greater(this.status_code, rt.new_int(307))) && rt.is_true(rt.less(this.status_code, rt.new_int(400)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_locationHeader, rt.new_string(''))))) && rt.is_true(rt.less(this.redirects, rt.new_int(redirects))) {
						rt.post_inc(this.redirects)
						mut iife_temp_6 := Class_SimplePie_SimplePie_Misc{}
						mut iife_result_6 := iife_temp_6.absolutize_url(var_locationHeader.clone(), rt.new_string(url_mutated))
						mut var_location := iife_result_6
						if rt.is_true(rt.identical(var_location, rt.new_bool(false))) {
							this.error = rt.new_string("Invalid redirect location, trying to base “${var_locationHeader.to_string()}” onto “${var_url.to_string()}”")
							this.success = false
							return
						}
						this.permanentUrlMutable = this.permanentUrlMutable && rt.is_true(rt.equal(this.status_code, rt.new_int(301))) || rt.is_true(rt.equal(this.status_code, rt.new_int(308)))
						this.construct((var_location).str(), timeout, redirects, mut var_headers_mutated, mut var_useragent_mutated, force_fsockopen, mut var_curl_options)
						return
					}
				}
			}
		} else {
			this.method = rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.file_source_remote(), Class_SimplePie_SimplePie_SimplePie.file_source_fsockopen())
			mut var_url_parts := rt.call_function('parse_url', [rt.new_string(url_mutated).clone()])
			if rt.is_true(rt.identical(var_url_parts, rt.new_bool(false))) {
				rt.throw_exception(rt.new_object('SimplePie_InvalidArgumentException', []string{}, create_simplepie_invalidargumentexception('Malformed URL: ' + url_mutated)))
			}
			if !(var_url_parts.array_isset(rt.new_string('host'))) {
				rt.throw_exception(rt.new_object('SimplePie_InvalidArgumentException', []string{}, create_simplepie_invalidargumentexception('Missing hostname: ' + url_mutated)))
			}
			mut var_socket_host := var_url_parts.array_get(rt.new_string('host'))
			if var_url_parts.array_isset(rt.new_string('scheme')) && rt.is_true(rt.identical(rt.new_string(var_url_parts.array_get(rt.new_string('scheme')).to_string().to_lower()), rt.new_string('https'))) {
				var_socket_host = rt.new_string('ssl://' + (var_socket_host).str())
				var_url_parts.array_set('port', 443)
			}
			if !(var_url_parts.array_isset(rt.new_string('port'))) {
				var_url_parts.array_set('port', 80)
			}
			var_fp = rt.call_function('fsockopen', [var_socket_host.clone(), var_url_parts.array_get(rt.new_string('port')), var_errno.clone(), var_errstr.clone(), rt.new_int(timeout)])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_fp)))) {
				this.error = 'fsockopen error: ' + (var_errstr).str()
				this.success = false
			} else {
				rt.call_function('stream_set_timeout', [var_fp.clone(), rt.new_int(timeout)])
				if var_url_parts.array_isset(rt.new_string('path')) {
					if var_url_parts.array_isset(rt.new_string('query')) {
					mut var_get := rt.new_string((rt.concat(rt.concat(var_url_parts.array_get(rt.new_string('path')), rt.new_string('?')), var_url_parts.array_get(rt.new_string('query')))).str())
					} else {
					var_get = var_url_parts.array_get(rt.new_string('path'))
					}
				} else {
				var_get = rt.new_string('/')
				}
				mut var_out := rt.new_string("GET ${var_get.to_string()} HTTP/1.1\r\n")
				var_out = rt.concat(var_out, rt.concat(rt.concat(rt.new_string('Host: '), var_url_parts.array_get(rt.new_string('host'))), rt.new_string('\r\n')))
				var_out = rt.concat(var_out, rt.new_string("User-Agent: ${var_useragent.to_string()}\r\n"))
				if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('zlib')])) {
					var_out = rt.concat(var_out, rt.new_string('Accept-Encoding: x-gzip,gzip,deflate\r\n'))
				}
				if var_url_parts.array_isset(rt.new_string('user')) && var_url_parts.array_isset(rt.new_string('pass')) {
					var_out = rt.concat(var_out, rt.new_string('Authorization: Basic ' + (rt.call_function('base64_encode', [rt.concat(rt.concat(var_url_parts.array_get(rt.new_string('user')), rt.new_string(':')), var_url_parts.array_get(rt.new_string('pass')))])).str() + '\r\n'))
				}
				mut iter_3 := var_headers_mutated.iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_value := item_3.val
					mut var_key := item_3.key
					var_out = rt.concat(var_out, rt.new_string("${var_key.to_string()}: ${var_value.to_string()}\r\n"))
				}
				var_out = rt.concat(var_out, rt.new_string('Connection: Close\r\n\r\n'))
				rt.call_function('fwrite', [var_fp.clone(), var_out.clone()])
				var_info = rt.call_function('stream_get_meta_data', [var_fp.clone()])
				var_responseHeaders = rt.new_string('')
				for rt.is_true(rt.new_bool(!(rt.is_true(var_info.array_get(rt.new_string('eof')))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_info.array_get(rt.new_string('timed_out')))))) {
					var_responseHeaders = rt.concat(var_responseHeaders, rt.call_function('fread', [var_fp.clone(), rt.new_int(1160)]))
				var_info = rt.call_function('stream_get_meta_data', [var_fp.clone()])
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_info.array_get(rt.new_string('timed_out')))))) {
					var_parser = create_simplepie_simplepie_http_parser(var_responseHeaders.clone(), rt.new_bool(true))
					if rt.is_true(var_parser.parse()) {
						this.set_headers(mut rt.cast_object_ptr[Class_SimplePie_array](rt.get_property(var_parser, 'headers')))
						this.body = rt.get_property(var_parser, 'body')
						this.status_code = rt.get_property(var_parser, 'status_code')
						var_locationHeader = rt.new_string(this.get_header_line('location'))
						if rt.is_true(rt.call_function('in_array', [this.status_code, rt.create_array([rt.ArrayItem{ key: none, val: 300 }, rt.ArrayItem{ key: none, val: 301 }, rt.ArrayItem{ key: none, val: 302 }, rt.ArrayItem{ key: none, val: 303 }, rt.ArrayItem{ key: none, val: 307 }])])) || (rt.is_true(rt.greater(this.status_code, rt.new_int(307))) && rt.is_true(rt.less(this.status_code, rt.new_int(400)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_locationHeader, rt.new_string(''))))) && rt.is_true(rt.less(this.redirects, rt.new_int(redirects))) {
							rt.post_inc(this.redirects)
							mut iife_temp_7 := Class_SimplePie_SimplePie_Misc{}
							mut iife_result_7 := iife_temp_7.absolutize_url(var_locationHeader.clone(), rt.new_string(url_mutated))
							var_location = iife_result_7
							this.permanentUrlMutable = this.permanentUrlMutable && rt.is_true(rt.equal(this.status_code, rt.new_int(301))) || rt.is_true(rt.equal(this.status_code, rt.new_int(308)))
							if rt.is_true(rt.identical(var_location, rt.new_bool(false))) {
								this.error = rt.new_string("Invalid redirect location, trying to base “${var_locationHeader.to_string()}” onto “${var_url.to_string()}”")
								this.success = false
								return
							}
							this.construct((var_location).str(), timeout, redirects, mut var_headers_mutated, mut var_useragent_mutated, force_fsockopen, mut var_curl_options)
							return
						}
						mut var_contentEncodingHeader := rt.new_string(this.get_header_line('content-encoding'))
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_contentEncodingHeader, rt.new_string(''))))) {
							mut switch_val_1 := rt.new_string(var_contentEncodingHeader.clone().to_string().trim_space().to_lower())
							if rt.is_true(rt.equal(switch_val_1, rt.new_string('gzip'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('x-gzip'))) {
								mut var_decompressed := rt.call_function('gzdecode', [this.body])
								if rt.is_true(rt.identical(var_decompressed, rt.new_bool(false))) {
									this.error = rt.new_string('Unable to decode HTTP "gzip" stream')
									this.success = false
								} else {
									this.body = var_decompressed.clone()
								}
							} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deflate'))) {
								var_decompressed = rt.call_function('gzinflate', [this.body])
								if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_decompressed, rt.new_bool(false))))) {
									this.body = var_decompressed.clone()
								var_decompressed = rt.call_function('gzuncompress', [this.body])
								} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_decompressed, rt.new_bool(false))))) {
									this.body = var_decompressed.clone()
								var_decompressed = rt.call_function('gzdecode', [this.body])
								} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_decompressed, rt.new_bool(false))))) {
									this.body = var_decompressed.clone()
								} else {
									this.error = rt.new_string('Unable to decode HTTP "deflate" stream')
									this.success = false
								}
							} else {
								this.error = rt.new_string('Unknown content coding')
								this.success = false
							}
						}
					}
				} else {
					this.error = rt.new_string('fsocket timed out')
					this.success = false
				}
				rt.call_function('fclose', [var_fp.clone()])
			}
		}
	} else {
		this.method = rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.file_source_local(), Class_SimplePie_SimplePie_SimplePie.file_source_file_get_contents())
		mut var_filebody := rt.call_function('file_get_contents', [rt.new_string(url_mutated).clone()])
		if url_mutated == '' || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string(url_mutated).clone()]))))) || rt.is_true(rt.identical(rt.new_bool(false), var_filebody)) {
			this.body = rt.new_string('')
			this.error = rt.call_function('sprintf', [rt.new_string('file "%s" is not readable'), rt.new_string(url_mutated).clone()])
			this.success = false
		} else {
			this.body = var_filebody.clone()
			this.status_code = rt.new_int(200)
		}
	}
	if this.success {
		rt.call_function('assert', [rt.new_bool(!rt.is_true(rt.identical(this.body, rt.new_null())))])
		this.body = rt.call_function('preg_replace', [rt.new_string('/^[ \\n\\r\\t\\v]+</'), rt.new_string('<'), this.body])
	}
}

fn (mut this Class_SimplePie_File) get_permanent_uri() string {
	return this.permanent_url
}

fn (mut this Class_SimplePie_File) get_final_requested_uri() string {
	return (this.url).str()
}

fn (mut this Class_SimplePie_File) get_status_code() i64 {
	return rt.new_int((this.status_code).to_i64())
}

fn (mut this Class_SimplePie_File) get_headers() rt.PhpVal {
	this.maybe_update_headers()
	return this.parsed_headers
}

fn (mut this Class_SimplePie_File) has_header(name string) bool {
	this.maybe_update_headers()
	return rt.new_bool(!rt.is_true(rt.identical(this.get_header(name), rt.new_array())))
}

fn (mut this Class_SimplePie_File) get_header(name string) rt.PhpVal {
	this.maybe_update_headers()
	return if !(this.parsed_headers.array_get(rt.new_string(name.to_lower()))).is_null() { this.parsed_headers.array_get(rt.new_string(name.to_lower())) } else { rt.new_array() }
}

fn (mut this Class_SimplePie_File) with_header(name string, var_value rt.PhpVal) rt.PhpVal {
	this.maybe_update_headers()
	mut var_new := rt.new_object('SimplePie_File', ['Response'], &this).dup()
	mut var_newHeader := rt.create_array([rt.ArrayItem{ key: name.to_lower(), val: rt.cast_array(var_value) }])
	rt.call_method(var_new, 'set_headers', [rt.add(var_newHeader, this.get_headers())])
	return var_new.clone()
}

fn (mut this Class_SimplePie_File) get_header_line(name string) string {
	this.maybe_update_headers()
	return (rt.call_function('implode', [rt.new_string(', '), this.get_header(name)])).str()
}

fn (mut this Class_SimplePie_File) get_body_content() string {
	return (this.body).str()
}

fn (mut this Class_SimplePie_File) maybe_update_headers() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.headers, this.last_headers)))) {
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_header_line := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.call_function('strpos', [var_header_line.clone(), rt.new_string(',')]), rt.new_bool(false))) {
				return
			} else {
				return
			}
			return rt.new_null()
			}
		closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_header_line := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.call_function('strpos', [var_header_line.clone(), rt.new_string(',')]), rt.new_bool(false))) {
				return
			} else {
				return
			}
			return rt.new_null()
			}
		this.parsed_headers = rt.call_function('array_map', [rt.new_closure(closure_9_fn), this.headers])
	}
	this.last_headers = this.headers
}

fn (mut this Class_SimplePie_File) set_headers(mut var_headers Class_SimplePie_array) {
	mut var_headers_mutated := var_headers
	this.parsed_headers = var_headers_mutated
	mut iife_temp_10 := Class_SimplePie_File{}
	mut iife_result_10 := iife_temp_10.flatten_headers(mut var_headers_mutated)
	this.headers = iife_result_10
	this.last_headers = this.headers
}

fn (mut this Class_SimplePie_File) flatten_headers(mut var_headers Class_SimplePie_array) rt.PhpVal {
	mut var_headers_mutated := var_headers
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('implode', [rt.new_string(','), var_values.clone()])
		}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('implode', [rt.new_string(','), var_values.clone()])
		}
	return rt.call_function('array_map', [rt.new_closure(closure_12_fn), var_headers_mutated])
}

fn Class_SimplePie_File.fromresponse(mut var_response Class_SimplePie_HTTP_Response) rt.PhpVal {
	mut var_headers := rt.new_array()
	mut iter_4 := var_response.get_headers().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_header := item_4.val
		mut var_name := item_4.key
		var_headers.array_set(var_name, rt.call_function('implode', [rt.new_string(', '), var_header.clone()]))
	}
	mut var_file := rt.call_method(create_simplepie_reflectionclass(Class_SimplePie_File.class()), 'newInstanceWithoutConstructor', []rt.PhpVal{})
	rt.set_property(var_file, 'url', var_response.get_final_requested_uri())
	rt.set_property(var_file, 'useragent', rt.new_null())
	rt.set_property(var_file, 'headers', var_headers.clone())
	rt.set_property(var_file, 'body', var_response.get_body_content())
	rt.set_property(var_file, 'status_code', var_response.get_status_code())
	rt.set_property(var_file, 'permanent_url', var_response.get_permanent_uri())
	return var_file.clone()
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

struct Class_SimplePie_ReflectionClass {
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

fn create_simplepie_simplepie_misc(_args ...rt.PhpVal) &Class_SimplePie_SimplePie_Misc {
	mut obj := &Class_SimplePie_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_simplepie_http_parser(_args ...rt.PhpVal) &Class_SimplePie_SimplePie_HTTP_Parser {
	mut obj := &Class_SimplePie_SimplePie_HTTP_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_invalidargumentexception(_args ...rt.PhpVal) &Class_SimplePie_InvalidArgumentException {
	mut obj := &Class_SimplePie_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_reflectionclass(_args ...rt.PhpVal) &Class_SimplePie_ReflectionClass {
	mut obj := &Class_SimplePie_ReflectionClass{
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


fn (mut this Class_SimplePie_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\File'), rt.new_string('SimplePie_File')])
}

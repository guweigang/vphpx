import rt

pub fn Class_WpOrg_Requests_Transport_Fsockopen.second_in_microseconds() i64 {
	return 1000000
}

struct Class_WpOrg_Requests_Transport_Fsockopen {
	rt.PhpObjectBase
pub mut:
	headers       rt.PhpVal = rt.new_string('')
	info          rt.PhpVal = rt.new_null()
	max_bytes     rt.PhpVal = rt.new_bool(false)
	connect_error rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) request(var_url rt.PhpVal, var_headers rt.PhpVal, var_data rt.PhpVal, var_options rt.PhpVal) string {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut var_headers_mutated := var_headers
	mut var_data_mutated := var_data
	mut iife_temp_0 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_0 := iife_temp_0.is_string_or_stringable(var_url.clone())
	if rt.is_true(rt.identical(iife_result_0, rt.new_bool(false))) {
		mut iife_temp_1 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_1 := iife_temp_1.create(rt.new_int(1), rt.new_string('$url'),
			rt.new_string('string|Stringable'), rt.call_function('gettype', [
			var_url.clone()]))
		rt.throw_exception(iife_result_1)
	}
	if rt.is_true(rt.identical(rt.new_bool(var_headers_mutated.clone().is_array()),
		rt.new_bool(false)))
	{
		mut iife_temp_2 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_2 := iife_temp_2.create(rt.new_int(2), rt.new_string('$headers'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_headers_mutated.clone()]))
		rt.throw_exception(iife_result_2)
	}
	if !(var_data_mutated.clone().is_array()) && !(var_data_mutated.clone().is_string()) {
		if rt.is_true(rt.identical(var_data_mutated, rt.new_null())) {
			var_data_mutated = rt.new_string('')
		} else {
			mut iife_temp_3 := Class_WpOrg_Requests_Exception_InvalidArgument{}
			mut iife_result_3 := iife_temp_3.create(rt.new_int(3), rt.new_string('$data'),
				rt.new_string('array|string'), rt.call_function('gettype', [
				var_data_mutated.clone()]))
			rt.throw_exception(iife_result_3)
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options.clone().is_array()), rt.new_bool(false))) {
		mut iife_temp_4 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_4 := iife_temp_4.create(rt.new_int(4), rt.new_string('$options'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_options.clone()]))
		rt.throw_exception(iife_result_4)
	}
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.before_request'),
	])
	mut var_url_parts := rt.call_function('parse_url', [var_url.clone()])
	if !rt.is_true(var_url_parts) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid URL.'),
			rt.new_string('invalidurl'), var_url.clone())))
	}
	mut var_host := var_url_parts.array_get(rt.new_string('host'))
	mut var_context := rt.call_function('stream_context_create', []rt.PhpVal{})
	mut var_verifyname := rt.new_bool(false)
	mut var_case_insensitive_headers :=
		create_wporg_requests_utility_caseinsensitivedictionary(var_headers_mutated.clone())
	if var_url_parts.array_isset(rt.new_string('scheme'))
		&& rt.is_true(rt.identical(rt.new_string(var_url_parts.array_get(rt.new_string('scheme')).to_string().to_lower()), rt.new_string('https'))) {
		mut var_remote_socket := rt.new_string('ssl://' + var_host.str())
		if !(var_url_parts.array_isset(rt.new_string('port'))) {
			var_url_parts.array_set('port', Class_WpOrg_Requests_Port.https())
		}
		mut var_context_options := rt.create_array([
			rt.ArrayItem{ key: 'verify_peer', val: true },
			rt.ArrayItem{ key: 'capture_peer_cert', val: true },
		])
		var_verifyname = rt.new_bool(true)
		if rt.is_true(rt.call_function('defined', [rt.new_string('OPENSSL_TLSEXT_SERVER_NAME')]))
			&& rt.is_true(rt.get_constant('OPENSSL_TLSEXT_SERVER_NAME')) {
			var_context_options.array_set('SNI_enabled', true)
			if var_options.array_isset(rt.new_string('verifyname'))
				&& rt.is_true(rt.identical(var_options.array_get(rt.new_string('verifyname')), rt.new_bool(false))) {
				var_context_options.array_set('SNI_enabled', false)
			}
		}
		if var_options.array_isset(rt.new_string('verify')) {
			if rt.is_true(rt.identical(var_options.array_get(rt.new_string('verify')),
				rt.new_bool(false)))
			{
				var_context_options.array_set('verify_peer', false)
				var_context_options.array_set('verify_peer_name', false)
				var_verifyname = rt.new_bool(false)
			} else if rt.is_true(rt.new_bool(var_options.array_get(rt.new_string('verify')).is_string())) {
				var_context_options.array_set('cafile',
					var_options.array_get(rt.new_string('verify')))
			}
		}
		if var_options.array_isset(rt.new_string('verifyname'))
			&& rt.is_true(rt.identical(var_options.array_get(rt.new_string('verifyname')), rt.new_bool(false))) {
			var_context_options.array_set('verify_peer_name', false)
			var_verifyname = rt.new_bool(false)
		}
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('stream_context_set_options'),
		]))
		{
			rt.call_function('stream_context_set_options', [var_context.clone(),
				rt.create_array([rt.ArrayItem{ key: 'ssl', val: var_context_options }])])
		} else {
			rt.call_function('stream_context_set_option', [var_context.clone(),
				rt.create_array([rt.ArrayItem{ key: 'ssl', val: var_context_options }])])
		}
	} else {
		var_remote_socket = rt.new_string('tcp://' + var_host.str())
	}
	this.max_bytes = var_options.array_get(rt.new_string('max_bytes'))
	if !(var_url_parts.array_isset(rt.new_string('port'))) {
		var_url_parts.array_set('port', Class_WpOrg_Requests_Port.http())
	}
	var_remote_socket = rt.concat(var_remote_socket, rt.new_string(':' +
		(var_url_parts.array_get(rt.new_string('port'))).str()))
	rt.call_function('set_error_handler', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Transport_Fsockopen', [
				'Transport',
			], &this) },
			rt.ArrayItem{ key: none, val: 'connect_error_handler' },
		]),
		rt.bitwise_or(rt.get_constant('E_WARNING'), rt.get_constant('E_NOTICE')),
	])
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.remote_socket'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_remote_socket }]),
	])
	mut var_socket := rt.call_function('stream_socket_client', [
		var_remote_socket.clone(), var_errno.clone(), var_errstr.clone(),
		rt.call_function('ceil', [var_options.array_get(rt.new_string('connect_timeout'))]),
		rt.get_constant('STREAM_CLIENT_CONNECT'), var_context.clone()])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.is_true(var_verifyname)
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.verify_certificate_from_context(var_host.clone(), var_context.clone()))))) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('SSL certificate did not match the requested domain name'),
			rt.new_string('ssl.no_match'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_socket)))) {
		if rt.is_true(rt.identical(var_errno, rt.new_int(0))) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string(this.connect_error.to_string().trim_right(' \t\n\r')),
				rt.new_string('fsockopen.connect_error'))))
		}
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_errstr.clone(),
			rt.new_string('fsockopenerror'), rt.new_null(), var_errno.clone())))
	}
	mut var_data_format := var_options.array_get(rt.new_string('data_format'))
	if rt.is_true(rt.identical(var_data_format, rt.new_string('query'))) {
		mut var_path := Class_WpOrg_Requests_Transport_Fsockopen.format_get(var_url_parts.clone(),
			var_data_mutated.clone())
		var_data_mutated = rt.new_string('')
	} else {
		var_path = Class_WpOrg_Requests_Transport_Fsockopen.format_get(var_url_parts.clone(),
			rt.new_array())
	}
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.remote_host_path'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_path },
			rt.ArrayItem{ key: none, val: var_url }]),
	])
	mut var_request_body := rt.new_string('')
	mut var_out := rt.call_function('sprintf', [rt.new_string('%s %s HTTP/%.1F\r\n'),
		var_options.array_get(rt.new_string('type')), var_path.clone(),
		var_options.array_get(rt.new_string('protocol_version'))])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_options.array_get(rt.new_string('type')),
		Class_WpOrg_Requests_Requests.trace()))))
	{
		if rt.is_true(rt.new_bool(var_data_mutated.clone().is_array())) {
			var_request_body = rt.call_function('http_build_query', [
				var_data_mutated.clone(), rt.new_string(''), rt.new_string('&')])
		} else {
			var_request_body = var_data_mutated.clone()
		}
		if !(!rt.is_true(var_data_mutated))
			|| rt.is_true(rt.identical(var_options.array_get(rt.new_string('type')), Class_WpOrg_Requests_Requests.post())) {
			if !(var_case_insensitive_headers.array_isset(rt.new_string('Content-Length'))) {
				var_headers_mutated.array_set('Content-Length',
					var_request_body.clone().to_string().len)
			}
			if !(var_case_insensitive_headers.array_isset(rt.new_string('Content-Type'))) {
				var_headers_mutated.array_set('Content-Type',
					'application/x-www-form-urlencoded; charset=UTF-8')
			}
		}
	}
	if !(var_case_insensitive_headers.array_isset(rt.new_string('Host'))) {
		var_out = rt.concat(var_out, rt.call_function('sprintf', [
			rt.new_string('Host: %s'),
			var_url_parts.array_get(rt.new_string('host')),
		]))
		mut var_scheme_lower :=
			rt.new_string(var_url_parts.array_get(rt.new_string('scheme')).to_string().to_lower())
		if (rt.is_true(rt.identical(var_scheme_lower, rt.new_string('http')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url_parts.array_get(rt.new_string('port')), Class_WpOrg_Requests_Port.http())))))
			|| (rt.is_true(rt.identical(var_scheme_lower, rt.new_string('https')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url_parts.array_get(rt.new_string('port')), Class_WpOrg_Requests_Port.https()))))) {
			var_out = rt.concat(var_out, rt.new_string(':' +
				(var_url_parts.array_get(rt.new_string('port'))).str()))
		}
		var_out = rt.concat(var_out, rt.new_string('\r\n'))
	}
	if !(var_case_insensitive_headers.array_isset(rt.new_string('User-Agent'))) {
		var_out = rt.concat(var_out, rt.call_function('sprintf', [
			rt.new_string('User-Agent: %s\r\n'),
			var_options.array_get(rt.new_string('useragent')),
		]))
	}
	mut var_accept_encoding := this.accept_encoding()
	if !(var_case_insensitive_headers.array_isset(rt.new_string('Accept-Encoding')))
		&& !(!rt.is_true(var_accept_encoding)) {
		var_out = rt.concat(var_out, rt.call_function('sprintf', [
			rt.new_string('Accept-Encoding: %s\r\n'),
			var_accept_encoding.clone(),
		]))
	}
	mut iife_temp_5 := Class_WpOrg_Requests_Requests{}
	mut iife_result_5 := iife_temp_5.flatten(var_headers_mutated.clone())
	var_headers_mutated = iife_result_5
	if !(!rt.is_true(var_headers_mutated)) {
		var_out = rt.concat(var_out, rt.new_string(
			(rt.call_function('implode', [rt.new_string('\r\n'), var_headers_mutated.clone()])).str() +
			'\r\n'))
	}
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.after_headers'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_out }]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
		var_out.clone(),
		rt.new_int(-2),
	]), rt.new_string('\r\n')))))
	{
		var_out = rt.concat(var_out, rt.new_string('\r\n'))
	}
	if !(var_case_insensitive_headers.array_isset(rt.new_string('Connection'))) {
		var_out = rt.concat(var_out, rt.new_string('Connection: Close\r\n'))
	}
	var_out = rt.concat(var_out, rt.new_string('\r\n' + var_request_body.str()))
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.before_send'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_out }]),
	])
	rt.call_function('fwrite', [var_socket.clone(), var_out.clone()])
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.after_send'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_out }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options.array_get(rt.new_string('blocking')))))) {
		rt.call_function('fclose', [var_socket.clone()])
		mut var_fake_headers := rt.new_string('')
		rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
			rt.new_string('fsockopen.after_request'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_fake_headers }]),
		])
		return ''
	}
	mut var_timeout_sec := rt.new_int((rt.call_function('floor', [
		var_options.array_get(rt.new_string('timeout')),
	])).to_i64())
	if rt.is_true(rt.identical(var_timeout_sec, var_options.array_get(rt.new_string('timeout')))) {
		mut var_timeout_msec := rt.new_int(0)
	} else {
		var_timeout_msec = rt.mod_(rt.mul(Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Fsockopen.second_in_microseconds(),
			var_options.array_get(rt.new_string('timeout'))),
			Class_WpOrg_Requests_Transport_WpOrg_Requests_Transport_Fsockopen.second_in_microseconds())
	}
	rt.call_function('stream_set_timeout', [var_socket.clone(),
		var_timeout_sec.clone(), var_timeout_msec.clone()])
	mut var_response := rt.new_string('')
	mut var_body := rt.new_string('')
	var_headers_mutated = rt.new_string('')
	this.info = rt.call_function('stream_get_meta_data', [var_socket.clone()])
	mut var_size := rt.new_int(0)
	mut var_doingbody := rt.new_bool(false)
	mut var_download := rt.new_bool(false)
	if rt.is_true(var_options.array_get(rt.new_string('filename'))) {
		var_download = rt.call_function('fopen', [
			var_options.array_get(rt.new_string('filename')),
			rt.new_string('wb'),
		])
		if rt.is_true(rt.identical(var_download, rt.new_bool(false))) {
			mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(var_error.array_get(rt.new_string('message')),
				rt.new_string('fopen'))))
		}
	}
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [
		var_socket.clone()]))))) {
		this.info = rt.call_function('stream_get_meta_data', [
			var_socket.clone()])
		if rt.is_true(this.info.array_get(rt.new_string('timed_out'))) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('fsocket timed out'),
				rt.new_string('timeout'))))
		}
		mut var_block := rt.call_function('fread', [var_socket.clone(),
			Class_WpOrg_Requests_Requests.buffer_size()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_doingbody)))) {
			var_response = rt.concat(var_response, var_block)
			if rt.is_true(rt.call_function('strpos', [var_response.clone(),
				rt.new_string('\r\n\r\n')]))
			{
				mut list_tmp_1 := rt.call_function('explode', [
					rt.new_string('\r\n\r\n'), var_response.clone(),
					rt.new_int(2)])
				var_headers_mutated = list_tmp_1.array_get(0)
				var_block = list_tmp_1.array_get(1)
				var_doingbody = rt.new_bool(true)
			}
		}
		if rt.is_true(var_doingbody) {
			rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
				rt.new_string('request.progress'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_block },
					rt.ArrayItem{ key: none, val: var_size },
					rt.ArrayItem{ key: none, val: this.max_bytes }]),
			])
			mut var_data_length := rt.new_int(var_block.clone().to_string().len)
			if rt.is_true(this.max_bytes) {
				if rt.is_true(rt.identical(var_size, this.max_bytes)) {
					continue
				}
				if rt.is_true(rt.greater(rt.add(var_size, var_data_length), this.max_bytes)) {
					mut var_limited_length := rt.sub(this.max_bytes, var_size)
					var_block = rt.call_function('substr', [var_block.clone(),
						rt.new_int(0), var_limited_length.clone()])
				}
			}
			var_size = rt.add(var_size, rt.new_int(var_block.clone().to_string().len))
			if rt.is_true(var_download) {
				rt.call_function('fwrite', [var_download.clone(),
					var_block.clone()])
			} else {
				var_body = rt.concat(var_body, var_block)
			}
		}
	}
	this.headers = var_headers_mutated.clone()
	if rt.is_true(var_download) {
		rt.call_function('fclose', [var_download.clone()])
	} else {
		this.headers = rt.concat(this.headers, rt.new_string('\r\n\r\n' + var_body.str()))
	}
	rt.call_function('fclose', [var_socket.clone()])
	rt.call_method(var_options.array_get(rt.new_string('hooks')), 'dispatch', [
		rt.new_string('fsockopen.after_request'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.headers },
			rt.ArrayItem{ key: none, val: this.info }]),
	])
	return (this.headers).str()
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) request_multiple(var_requests rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_requests) {
		return rt.new_array()
	}
	mut iife_temp_6 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_6 := iife_temp_6.has_array_access(var_requests.clone())
	mut iife_temp_7 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_7 := iife_temp_7.is_iterable(var_requests.clone())
	if rt.is_true(rt.identical(iife_result_6, rt.new_bool(false)))
		|| rt.is_true(rt.identical(iife_result_7, rt.new_bool(false))) {
		mut iife_temp_8 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_8 := iife_temp_8.create(rt.new_int(1), rt.new_string('$requests'),
			rt.new_string('array|ArrayAccess&Traversable'), rt.call_function('gettype', [
			var_requests.clone(),
		]))
		rt.throw_exception(iife_result_8)
	}
	if rt.is_true(rt.identical(rt.new_bool(var_options.clone().is_array()), rt.new_bool(false))) {
		mut iife_temp_9 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_9 := iife_temp_9.create(rt.new_int(2), rt.new_string('$options'),
			rt.new_string('array'), rt.call_function('gettype', [
			var_options.clone()]))
		rt.throw_exception(iife_result_9)
	}
	mut var_responses := rt.new_array()
	mut var_class := rt.call_function('get_class', [
		rt.new_object('WpOrg_Requests_Transport_Fsockopen', ['Transport'], &this),
	])
	mut iter_1 := var_requests.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_request := item_1.val
		mut var_id := item_1.key
		mut var_handler := rt.create_object_dynamically(var_class, []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_responses.array_set(var_id, rt.call_method(var_handler, 'request', [
			var_request.array_get(rt.new_string('url')),
			var_request.array_get(rt.new_string('headers')),
			var_request.array_get(rt.new_string('data')),
			var_request.array_get(rt.new_string('options')),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_request.array_get(rt.new_string('options')).array_get(rt.new_string('hooks')),
			'dispatch', [rt.new_string('transport.internal.parse_response'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_responses.array_get(var_id) },
				rt.ArrayItem{ key: none, val: var_request },
			])])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'WpOrg_Requests_Exception') {
			mut var_e := var_e_1.clone()
			var_responses.array_set(var_id, var_e.clone())
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
		if !(var_responses.array_get(var_id).is_string()) {
			rt.call_method(var_request.array_get(rt.new_string('options')).array_get(rt.new_string('hooks')),
				'dispatch', [rt.new_string('multiple.request.complete'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_responses.array_get(var_id) },
					rt.ArrayItem{ key: none, val: var_id },
				])])
		}
	}
	return var_responses.clone()
}

fn Class_WpOrg_Requests_Transport_Fsockopen.accept_encoding() rt.PhpVal {
	mut var_type := rt.new_array()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gzinflate')])) {
		var_type.array_push('deflate;q=1.0')
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gzuncompress')])) {
		var_type.array_push('compress;q=0.5')
	}
	var_type.array_push('gzip;q=0.5')
	return rt.call_function('implode', [rt.new_string(', '), var_type.clone()])
}

fn Class_WpOrg_Requests_Transport_Fsockopen.format_get(var_url_parts rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_url_parts_mutated := var_url_parts
	mut var_data_mutated := var_data
	if !(!rt.is_true(var_data_mutated)) {
		if !rt.is_true(var_url_parts_mutated.array_get(rt.new_string('query'))) {
			var_url_parts_mutated.array_set('query', '')
		}
		var_url_parts_mutated.array_get(rt.new_string('query')) = rt.concat(var_url_parts_mutated.array_get(rt.new_string('query')), rt.new_string(
			'&' +(rt.call_function('http_build_query', [var_data_mutated.clone(), rt.new_string(''), rt.new_string('&')])).str()))
		var_url_parts_mutated.array_set('query',
			var_url_parts_mutated.array_get(rt.new_string('query')).to_string().trim_space())
	}
	if var_url_parts_mutated.array_isset(rt.new_string('path')) {
		if var_url_parts_mutated.array_isset(rt.new_string('query')) {
			mut var_get := rt.new_string(
				(var_url_parts_mutated.array_get(rt.new_string('path'))).str() + '?' +
				(var_url_parts_mutated.array_get(rt.new_string('query'))).str())
		} else {
			var_get = var_url_parts_mutated.array_get(rt.new_string('path'))
		}
	} else {
		var_get = rt.new_string('/')
	}
	return var_get.clone()
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) connect_error_handler(var_errno rt.PhpVal, var_errstr rt.PhpVal) bool {
	if rt.bitwise_and(var_errno, rt.get_constant('E_WARNING')) == 0
		&& rt.bitwise_and(var_errno, rt.get_constant('E_NOTICE')) == 0 {
		return false
	}
	this.connect_error = rt.concat(this.connect_error, rt.new_string(var_errstr.str() + '\n'))
	return true
}

fn (mut this Class_WpOrg_Requests_Transport_Fsockopen) verify_certificate_from_context(var_host rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_host_mutated := var_host
	mut var_context_mutated := var_context
	mut var_meta := rt.call_function('stream_context_get_options', [
		var_context_mutated.clone()])
	if !rt.is_true(var_meta) || !rt.is_true(var_meta.array_get(rt.new_string('ssl')))
		|| !rt.is_true(var_meta.array_get(rt.new_string('ssl')).array_get(rt.new_string('peer_certificate'))) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string(this.connect_error.to_string().trim_right(' \t\n\r')),
			rt.new_string('ssl.connect_error'))))
	}
	mut var_cert := rt.call_function('openssl_x509_parse', [
		var_meta.array_get(rt.new_string('ssl')).array_get(rt.new_string('peer_certificate')),
	])
	mut iife_temp_10 := Class_WpOrg_Requests_Ssl{}
	mut iife_result_10 := iife_temp_10.verify_certificate(var_host_mutated.clone(),
		var_cert.clone())
	return iife_result_10
}

fn Class_WpOrg_Requests_Transport_Fsockopen.test(var_capabilities rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('fsockopen'),
	])))))
	{
		return false
	}
	if var_capabilities.array_isset(Class_WpOrg_Requests_Capability.ssl())
		&& rt.is_true(var_capabilities.array_get(Class_WpOrg_Requests_Capability.ssl())) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('openssl')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('openssl_x509_parse')]))))) {
			return false
		}
	}
	return true
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

struct Class_WpOrg_Requests_Ssl {
	rt.PhpObjectBase
}

fn create_wporg_requests_transport_fsockopen(_args ...rt.PhpVal) &Class_WpOrg_Requests_Transport_Fsockopen {
	mut obj := &Class_WpOrg_Requests_Transport_Fsockopen{
		PhpObjectBase: rt.PhpObjectBase{}
		headers:       rt.new_string('')
		info:          rt.new_null()
		max_bytes:     rt.new_bool(false)
		connect_error: rt.new_string('')
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_caseinsensitivedictionary(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests(_args ...rt.PhpVal) &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_ssl(_args ...rt.PhpVal) &Class_WpOrg_Requests_Ssl {
	mut obj := &Class_WpOrg_Requests_Ssl{
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
			return rt.new_string(this.request(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
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
			return Class_WpOrg_Requests_Transport_Fsockopen.format_get(dispatch_arg_0,
				dispatch_arg_1)
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
		else {
			return none
		}
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
		'headers' {
			this.headers = val
			return true
		}
		'info' {
			this.info = val
			return true
		}
		'max_bytes' {
			this.max_bytes = val
			return true
		}
		'connect_error' {
			this.connect_error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WpOrg_Requests_Ssl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Ssl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Ssl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WpOrg_Requests_Transport_Fsockopen', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_transport_fsockopen()
		return rt.new_object('WpOrg_Requests_Transport_Fsockopen', ['Transport'], obj)
	})
	rt.register_class_factory('WpOrg_Requests_Utility_InputValidator', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_utility_inputvalidator()
		return rt.new_object('WpOrg_Requests_Utility_InputValidator', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception_InvalidArgument', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception_invalidargument()
		return rt.new_object('WpOrg_Requests_Exception_InvalidArgument', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Exception', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_exception()
		return rt.new_object('WpOrg_Requests_Exception', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Utility_CaseInsensitiveDictionary', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_utility_caseinsensitivedictionary()
		return rt.new_object('WpOrg_Requests_Utility_CaseInsensitiveDictionary', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Requests', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_requests()
		return rt.new_object('WpOrg_Requests_Requests', []string{}, obj)
	})
	rt.register_class_factory('WpOrg_Requests_Ssl', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wporg_requests_ssl()
		return rt.new_object('WpOrg_Requests_Ssl', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}

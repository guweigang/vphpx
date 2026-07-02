import rt

struct Class_WP_Http_Streams {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Http_Streams) request(var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_defaults := {
		'method':      rt.new_string('GET')
		'timeout':     rt.new_int(5)
		'redirection': rt.new_int(5)
		'httpversion': rt.new_string('1.0')
		'blocking':    rt.new_bool(true)
		'headers':     map[string]rt.PhpVal{}
		'body':        rt.new_null()
		'cookies':     map[string]rt.PhpVal{}
		'decompress':  rt.new_bool(false)
		'stream':      rt.new_bool(false)
		'filename':    rt.new_null()
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	if var_parsed_args.array_get(rt.new_string('headers')).array_isset(rt.new_string('User-Agent')) {
		var_parsed_args.array_set('user-agent',
			var_parsed_args.array_get(rt.new_string('headers')).array_get(rt.new_string('User-Agent')))
		var_parsed_args.array_get(rt.new_string('headers')).array_unset(rt.new_string('User-Agent'))
	} else if var_parsed_args.array_get(rt.new_string('headers')).array_isset(rt.new_string('user-agent')) {
		var_parsed_args.array_set('user-agent',
			var_parsed_args.array_get(rt.new_string('headers')).array_get(rt.new_string('user-agent')))
		var_parsed_args.array_get(rt.new_string('headers')).array_unset(rt.new_string('user-agent'))
	}
	mut iife_temp_0 := Class_WP_Http{}
	mut iife_result_0 := iife_temp_0.buildcookieheader(var_parsed_args.clone())
	mut var_parsed_url := rt.call_function('parse_url', [var_url.clone()])
	mut var_connect_host := var_parsed_url.array_get(rt.new_string('host'))
	mut var_secure_transport := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('ssl'), var_parsed_url.array_get(rt.new_string('scheme'))))
		|| rt.is_true(rt.identical(rt.new_string('https'), var_parsed_url.array_get(rt.new_string('scheme')))))
	if !(var_parsed_url.array_isset(rt.new_string('port'))) {
		if rt.is_true(rt.identical(rt.new_string('ssl'), var_parsed_url.array_get(rt.new_string('scheme'))))
			|| rt.is_true(rt.identical(rt.new_string('https'), var_parsed_url.array_get(rt.new_string('scheme')))) {
			var_parsed_url.array_set('port', 443)
			var_secure_transport = rt.new_bool(true)
		} else {
			var_parsed_url.array_set('port', 80)
		}
	}
	if !(var_parsed_url.array_isset(rt.new_string('path'))) {
		var_parsed_url.array_set('path', '/')
	}
	if var_parsed_args.array_get(rt.new_string('headers')).array_isset(rt.new_string('Host'))
		|| var_parsed_args.array_get(rt.new_string('headers')).array_isset(rt.new_string('host')) {
		var_parsed_url.array_set('host', if !(var_parsed_args.array_get(rt.new_string('headers')).array_get(rt.new_string('Host'))).is_null() {
			var_parsed_args.array_get(rt.new_string('headers')).array_get(rt.new_string('Host'))
		} else {
			var_parsed_args.array_get(rt.new_string('headers')).array_get(rt.new_string('host'))
		})
		var_parsed_args.array_get(rt.new_string('headers')).array_unset(rt.new_string('Host'))
		var_parsed_args.array_get(rt.new_string('headers')).array_unset(rt.new_string('host'))
	}
	if rt.is_true(rt.identical(rt.new_string('localhost'),
		rt.new_string(var_connect_host.clone().to_string().to_lower())))
	{
		var_connect_host = rt.new_string('127.0.0.1')
	}
	var_connect_host = rt.new_string((if rt.is_true(var_secure_transport) {
		'ssl://' + var_connect_host.str()
	} else {
		'tcp://' + var_connect_host.str()
	}).str())
	mut var_is_local := rt.new_bool(var_parsed_args.array_isset(rt.new_string('local'))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('local'))))
	mut var_ssl_verify := rt.new_bool(var_parsed_args.array_isset(rt.new_string('sslverify'))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('sslverify'))))
	if rt.is_true(var_is_local) {
		var_ssl_verify = rt.call_function('apply_filters', [
			rt.new_string('https_local_ssl_verify'),
			var_ssl_verify.clone(),
			var_url.clone(),
		])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_is_local)))) {
		var_ssl_verify = rt.call_function('apply_filters', [
			rt.new_string('https_ssl_verify'),
			var_ssl_verify.clone(),
			var_url.clone(),
		])
	}
	mut var_proxy := create_wp_http_proxy()
	mut var_context := rt.call_function('stream_context_create', [
		rt.create_array([
			rt.ArrayItem{ key: 'ssl', val: rt.create_array([
				rt.ArrayItem{ key: 'verify_peer', val: var_ssl_verify },
				rt.ArrayItem{ key: 'capture_peer_cert', val: var_ssl_verify },
				rt.ArrayItem{ key: 'SNI_enabled', val: true },
				rt.ArrayItem{
					key: 'cafile'
					val: var_parsed_args.array_get(rt.new_string('sslcertificates'))
				},
				rt.ArrayItem{ key: 'allow_self_signed', val: !(rt.is_true(var_ssl_verify)) },
			]) },
		]),
	])
	mut var_timeout := rt.new_int((rt.call_function('floor', [
		var_parsed_args.array_get(rt.new_string('timeout')),
	])).to_i64())
	mut var_utimeout := rt.new_int(0)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_timeout,
		rt.new_int((var_parsed_args.array_get(rt.new_string('timeout'))).to_i64())))))
	{
		var_utimeout = rt.mod_(rt.mul(rt.new_int(1000000),
			var_parsed_args.array_get(rt.new_string('timeout'))), rt.new_int(1000000))
	}
	mut var_connect_timeout := rt.call_function('max', [var_timeout.clone(),
		rt.new_int(1)])
	mut var_connection_error := rt.new_null()
	mut var_connection_error_str := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
		if rt.is_true(var_secure_transport) {
			mut var_error_reporting := rt.call_function('error_reporting', [
				rt.new_int(0),
			])
		}
		if rt.is_true(var_proxy.is_enabled())
			&& rt.is_true(var_proxy.send_through_proxy(var_url.clone())) {
			mut var_handle := rt.call_function('stream_socket_client', [
				rt.new_string('tcp://' + (var_proxy.host()).str() + ':' + (var_proxy.port()).str()),
				var_connection_error.clone(),
				var_connection_error_str.clone(),
				var_connect_timeout.clone(),
				rt.get_constant('STREAM_CLIENT_CONNECT'),
				var_context.clone(),
			])
		} else {
			var_handle = rt.call_function('stream_socket_client', [
				rt.new_string(var_connect_host.str() + ':' +
					(var_parsed_url.array_get(rt.new_string('port'))).str()),
				var_connection_error.clone(),
				var_connection_error_str.clone(),
				var_connect_timeout.clone(),
				rt.get_constant('STREAM_CLIENT_CONNECT'),
				var_context.clone(),
			])
		}
		if rt.is_true(var_secure_transport) {
			rt.call_function('error_reporting', [var_error_reporting.clone()])
		}
	} else {
		if rt.is_true(var_proxy.is_enabled())
			&& rt.is_true(var_proxy.send_through_proxy(var_url.clone())) {
			var_handle = rt.call_function('stream_socket_client', [
				rt.new_string('tcp://' + (var_proxy.host()).str() + ':' + (var_proxy.port()).str()),
				var_connection_error.clone(),
				var_connection_error_str.clone(),
				var_connect_timeout.clone(),
				rt.get_constant('STREAM_CLIENT_CONNECT'),
				var_context.clone(),
			])
		} else {
			var_handle = rt.call_function('stream_socket_client', [
				rt.new_string(var_connect_host.str() + ':' +
					(var_parsed_url.array_get(rt.new_string('port'))).str()),
				var_connection_error.clone(),
				var_connection_error_str.clone(),
				var_connect_timeout.clone(),
				rt.get_constant('STREAM_CLIENT_CONNECT'),
				var_context.clone(),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_handle)) {
		if rt.is_true(var_secure_transport)
			&& rt.is_true(rt.identical(rt.new_int(0), var_connection_error))
			&& rt.is_true(rt.identical(rt.new_string(''), var_connection_error_str)) {
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [
				rt.new_string('The SSL certificate for the host could not be verified.'),
			]))
		}
		return create_wp_error(rt.new_string('http_request_failed'), var_connection_error.str() +
			': ' + var_connection_error_str.str())
	}
	if rt.is_true(var_secure_transport) && rt.is_true(var_ssl_verify)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_proxy.is_enabled())))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Http_Streams.verify_ssl_certificate(var_handle.clone(),
			var_parsed_url.array_get(rt.new_string('host')))))))
		{
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [
				rt.new_string('The SSL certificate for the host could not be verified.'),
			]))
		}
	}
	rt.call_function('stream_set_timeout', [var_handle.clone(),
		var_timeout.clone(), var_utimeout.clone()])
	if rt.is_true(var_proxy.is_enabled())
		&& rt.is_true(var_proxy.send_through_proxy(var_url.clone())) {
		mut var_request_path := var_url
	} else {
		var_request_path = rt.new_string(
			(var_parsed_url.array_get(rt.new_string('path'))).str() + if var_parsed_url.array_isset(rt.new_string('query')) { '?' +
			(var_parsed_url.array_get(rt.new_string('query'))).str() } else { '' })
	}
	mut var_headers := rt.new_string((
		var_parsed_args.array_get(rt.new_string('method')).to_string().to_upper() + ' ' +
		var_request_path.str() + ' HTTP/' +
		(var_parsed_args.array_get(rt.new_string('httpversion'))).str() + '\r\n').str())
	mut var_include_port_in_host_header := rt.new_bool((rt.is_true(var_proxy.is_enabled())
		&& rt.is_true(var_proxy.send_through_proxy(var_url.clone())))|| (rt.is_true(rt.identical(rt.new_string('http'), var_parsed_url.array_get(rt.new_string('scheme'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(80), var_parsed_url.array_get(rt.new_string('port')))))))
		|| rt.is_true(rt.identical(rt.new_string('https'), var_parsed_url.array_get(rt.new_string('scheme'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(443), var_parsed_url.array_get(rt.new_string('port')))))))
	if rt.is_true(var_include_port_in_host_header) {
		var_headers = rt.concat(var_headers, rt.new_string('Host: ' +
			(var_parsed_url.array_get(rt.new_string('host'))).str() + ':' + (var_parsed_url.array_get(rt.new_string('port'))).str() + '\r\n'))
	} else {
		var_headers = rt.concat(var_headers, rt.new_string('Host: ' +
			(var_parsed_url.array_get(rt.new_string('host'))).str() + '\r\n'))
	}
	if var_parsed_args.array_isset(rt.new_string('user-agent')) {
		var_headers = rt.concat(var_headers, rt.new_string('User-agent: ' +
			(var_parsed_args.array_get(rt.new_string('user-agent'))).str() + '\r\n'))
	}
	if rt.is_true(rt.new_bool(var_parsed_args.array_get(rt.new_string('headers')).is_array())) {
		mut iter_1 := rt.cast_array(var_parsed_args.array_get(rt.new_string('headers'))).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_header_value := item_1.val
			mut var_header := item_1.key
			var_headers = rt.concat(var_headers, rt.new_string(var_header.str() + ': ' +
				var_header_value.str() + '\r\n'))
		}
	} else {
		var_headers = rt.concat(var_headers, var_parsed_args.array_get(rt.new_string('headers')))
	}
	if rt.is_true(var_proxy.use_authentication()) {
		var_headers = rt.concat(var_headers, rt.new_string(
			(var_proxy.authentication_header()).str() + '\r\n'))
	}
	var_headers = rt.concat(var_headers, rt.new_string('\r\n'))
	if !(var_parsed_args.array_get(rt.new_string('body')).is_null()) {
		var_headers = rt.concat(var_headers, var_parsed_args.array_get(rt.new_string('body')))
	}
	rt.call_function('fwrite', [var_handle.clone(), var_headers.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('blocking')))))) {
		rt.call_function('stream_set_blocking', [var_handle.clone(),
			rt.new_int(0)])
		rt.call_function('fclose', [var_handle.clone()])
		return rt.create_array([
			rt.ArrayItem{
				key: 'headers'
				val: map[string]rt.PhpVal{}
			},
			rt.ArrayItem{ key: 'body', val: '' },
			rt.ArrayItem{ key: 'response', val: rt.create_array([
				rt.ArrayItem{ key: 'code', val: false },
				rt.ArrayItem{ key: 'message', val: false },
			]) },
			rt.ArrayItem{
				key: 'cookies'
				val: map[string]rt.PhpVal{}
			},
		])
	}
	mut var_response := rt.new_string('')
	mut var_body_started := rt.new_bool(false)
	mut var_keep_reading := rt.new_bool(true)
	mut var_block_size := rt.new_int(4096)
	if var_parsed_args.array_isset(rt.new_string('limit_response_size')) {
		var_block_size = rt.call_function('min', [var_block_size.clone(),
			var_parsed_args.array_get(rt.new_string('limit_response_size'))])
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('stream'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
			mut var_stream_handle := rt.call_function('fopen', [
				var_parsed_args.array_get(rt.new_string('filename')),
				rt.new_string('w+'),
			])
		} else {
			var_stream_handle = rt.call_function('fopen', [
				var_parsed_args.array_get(rt.new_string('filename')),
				rt.new_string('w+'),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_stream_handle)))) {
			return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Could not open handle for %1$s to %2$s.'),
				]),
				rt.new_string('fopen()'),
				var_parsed_args.array_get(rt.new_string('filename')),
			]))
		}
		mut var_bytes_written := rt.new_int(0)
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_handle.clone()])))))
			&& rt.is_true(var_keep_reading) {
			mut var_block := rt.call_function('fread', [var_handle.clone(),
				var_block_size.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_body_started)))) {
				var_response = rt.concat(var_response, var_block)
				if rt.is_true(rt.call_function('strpos', [var_response.clone(),
					rt.new_string('\r\n\r\n')]))
				{
					mut iife_temp_1 := Class_WP_Http{}
					mut iife_result_1 := iife_temp_1.processresponse(var_response.clone())
					mut var_processed_response := iife_result_1
					var_body_started = rt.new_bool(true)
					var_block = var_processed_response.array_get(rt.new_string('body'))
					var_response = rt.new_null()
					var_processed_response.array_set('body', '')
				}
			}
			mut var_this_block_size := rt.new_int(var_block.clone().to_string().len)
			if var_parsed_args.array_isset(rt.new_string('limit_response_size'))
				&& rt.is_true(rt.greater(rt.add(var_bytes_written, var_this_block_size), var_parsed_args.array_get(rt.new_string('limit_response_size')))) {
				var_this_block_size = rt.sub(var_parsed_args.array_get(rt.new_string('limit_response_size')),
					var_bytes_written)
				var_block = rt.call_function('substr', [var_block.clone(),
					rt.new_int(0), var_this_block_size.clone()])
			}
			mut var_bytes_written_to_file := rt.call_function('fwrite', [
				var_stream_handle.clone(), var_block.clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_bytes_written_to_file,
				var_this_block_size))))
			{
				rt.call_function('fclose', [var_handle.clone()])
				rt.call_function('fclose', [var_stream_handle.clone()])
				return create_wp_error(rt.new_string('http_request_failed'), rt.call_function('__', [
					rt.new_string('Failed to write request to temporary file.'),
				]))
			}
			var_bytes_written = rt.add(var_bytes_written, var_bytes_written_to_file)
			var_keep_reading = rt.new_bool(
				!(var_parsed_args.array_isset(rt.new_string('limit_response_size')))
				|| rt.is_true(rt.less(var_bytes_written, var_parsed_args.array_get(rt.new_string('limit_response_size')))))
		}
		rt.call_function('fclose', [var_stream_handle.clone()])
	} else {
		mut var_header_length := rt.new_int(0)
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_handle.clone()])))))
			&& rt.is_true(var_keep_reading) {
			var_block = rt.call_function('fread', [var_handle.clone(),
				var_block_size.clone()])
			var_response = rt.concat(var_response, var_block)
			if rt.is_true(rt.new_bool(!(rt.is_true(var_body_started))))
				&& rt.is_true(rt.call_function('strpos', [var_response.clone(), rt.new_string('\r\n\r\n')])) {
				var_header_length = rt.add(rt.call_function('strpos', [
					var_response.clone(), rt.new_string('\r\n\r\n')]), rt.new_int(4))
				var_body_started = rt.new_bool(true)
			}
			var_keep_reading = rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_body_started))))
				|| !(var_parsed_args.array_isset(rt.new_string('limit_response_size')))
				|| rt.is_true(rt.less(rt.new_int(var_response.clone().to_string().len), rt.add(var_header_length, var_parsed_args.array_get(rt.new_string('limit_response_size'))))))
		}
		mut iife_temp_2 := Class_WP_Http{}
		mut iife_result_2 := iife_temp_2.processresponse(var_response.clone())
		var_processed_response = iife_result_2
		var_response = rt.new_null()
	}
	rt.call_function('fclose', [var_handle.clone()])
	mut iife_temp_3 := Class_WP_Http{}
	mut iife_result_3 := iife_temp_3.processheaders(var_processed_response.array_get(rt.new_string('headers')),
		var_url.clone())
	mut var_processed_headers := iife_result_3
	var_response = rt.create_array([
		rt.ArrayItem{ key: 'headers', val: var_processed_headers.array_get(rt.new_string('headers')) },
		rt.ArrayItem{ key: 'body', val: rt.new_null() },
		rt.ArrayItem{
			key: 'response'
			val: var_processed_headers.array_get(rt.new_string('response'))
		},
		rt.ArrayItem{ key: 'cookies', val: var_processed_headers.array_get(rt.new_string('cookies')) },
		rt.ArrayItem{ key: 'filename', val: var_parsed_args.array_get(rt.new_string('filename')) },
	])
	mut iife_temp_4 := Class_WP_Http{}
	mut iife_result_4 := iife_temp_4.handle_redirects(var_url.clone(), var_parsed_args.clone(),
		var_response.clone())
	mut var_redirect_response := iife_result_4
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_redirect_response)))) {
		return var_redirect_response.clone()
	}
	if !(!rt.is_true(var_processed_response.array_get(rt.new_string('body'))))
		&& var_processed_headers.array_get(rt.new_string('headers')).array_isset(rt.new_string('transfer-encoding'))
		&& rt.is_true(rt.identical(rt.new_string('chunked'), var_processed_headers.array_get(rt.new_string('headers')).array_get(rt.new_string('transfer-encoding')))) {
		mut iife_temp_5 := Class_WP_Http{}
		mut iife_result_5 :=
			iife_temp_5.chunktransferdecode(var_processed_response.array_get(rt.new_string('body')))
		var_processed_response.array_set('body', iife_result_5)
	}
	mut iife_temp_6 := Class_WP_Http_Encoding{}
	mut iife_result_6 :=
		iife_temp_6.should_decode(var_processed_headers.array_get(rt.new_string('headers')))
	if rt.is_true(rt.identical(rt.new_bool(true), var_parsed_args.array_get(rt.new_string('decompress'))))
		&& rt.is_true(rt.identical(rt.new_bool(true), iife_result_6)) {
		mut iife_temp_7 := Class_WP_Http_Encoding{}
		mut iife_result_7 :=
			iife_temp_7.decompress(var_processed_response.array_get(rt.new_string('body')))
		var_processed_response.array_set('body', iife_result_7)
	}
	if var_parsed_args.array_isset(rt.new_string('limit_response_size'))
		&& rt.is_true(rt.greater(rt.new_int(var_processed_response.array_get(rt.new_string('body')).to_string().len), var_parsed_args.array_get(rt.new_string('limit_response_size')))) {
		var_processed_response.array_set('body', rt.call_function('substr', [
			var_processed_response.array_get(rt.new_string('body')),
			rt.new_int(0),
			var_parsed_args.array_get(rt.new_string('limit_response_size')),
		]))
	}
	var_response.array_set('body', var_processed_response.array_get(rt.new_string('body')))
	return var_response.clone()
}

fn Class_WP_Http_Streams.verify_ssl_certificate(var_stream rt.PhpVal, var_host rt.PhpVal) bool {
	mut var_match_type := rt.new_null()
	mut var_match_host := rt.new_null()
	mut var_context_options := rt.call_function('stream_context_get_options', [
		var_stream.clone(),
	])
	if !rt.is_true(var_context_options.array_get(rt.new_string('ssl')).array_get(rt.new_string('peer_certificate'))) {
		return false
	}
	mut var_cert := rt.call_function('openssl_x509_parse', [
		var_context_options.array_get(rt.new_string('ssl')).array_get(rt.new_string('peer_certificate')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cert)))) {
		return false
	}
	mut iife_temp_8 := Class_WP_Http{}
	mut iife_result_8 := iife_temp_8.is_ip_address(var_host.clone())
	mut var_host_type := rt.new_string((if rt.is_true(iife_result_8) { 'ip' } else { 'dns' }).str())
	mut var_certificate_hostnames := map[string]rt.PhpVal{}
	if !(!rt.is_true(var_cert.array_get(rt.new_string('extensions')).array_get(rt.new_string('subjectAltName')))) {
		mut var_match_against := rt.call_function('preg_split', [
			rt.new_string('/,\\s*/'),
			var_cert.array_get(rt.new_string('extensions')).array_get(rt.new_string('subjectAltName')),
		])
		mut iter_2 := var_match_against.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_match := item_2.val
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'),
				var_match.clone()])
			var_match_type = list_tmp_1.array_get(0)
			var_match_host = list_tmp_1.array_get(1)
			if rt.is_true(rt.identical(rt.new_string(var_match_type.clone().to_string().trim_space().to_lower()),
				var_host_type))
			{
				var_certificate_hostnames << var_match_host.clone().to_string().trim_space().to_lower()
			}
		}
	} else if !(!rt.is_true(var_cert.array_get(rt.new_string('subject')).array_get(rt.new_string('CN')))) {
		var_certificate_hostnames << var_cert.array_get(rt.new_string('subject')).array_get(rt.new_string('CN')).to_string().to_lower()
	}
	if rt.is_true(rt.call_function('in_array', [
		rt.new_string(var_host.clone().to_string().to_lower()),
		rt.create_array_from_list(var_certificate_hostnames),
		rt.new_bool(true),
	]))
	{
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('ip'), var_host_type)) {
		return false
	}
	if rt.is_true(rt.less(rt.call_function('substr_count', [var_host.clone(),
		rt.new_string('.')]), rt.new_int(2)))
	{
		return false
	}
	mut var_wildcard_host := rt.call_function('preg_replace', [
		rt.new_string('/^[^.]+\\./'),
		rt.new_string('*.'),
		var_host.clone(),
	])
	return (rt.call_function('in_array', [
		rt.new_string(var_wildcard_host.clone().to_string().to_lower()),
		rt.create_array_from_list(var_certificate_hostnames),
		rt.new_bool(true),
	])).to_bool()
}

fn Class_WP_Http_Streams.test(var_args rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('stream_socket_client'),
	])))))
	{
		return false
	}
	mut var_is_ssl := rt.new_bool(var_args.array_isset(rt.new_string('ssl'))
		&& rt.is_true(var_args.array_get(rt.new_string('ssl'))))
	if rt.is_true(var_is_ssl) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [
			rt.new_string('openssl'),
		])))))
		{
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('openssl_x509_parse'),
		])))))
		{
			return false
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('use_streams_transport'),
		rt.new_bool(true), var_args.clone()])).to_bool()
}

struct Class_WP_HTTP_Fsockopen {
	rt.PhpObjectBase
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

fn create_wp_http_streams(_args ...rt.PhpVal) &Class_WP_Http_Streams {
	mut obj := &Class_WP_Http_Streams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_fsockopen(_args ...rt.PhpVal) &Class_WP_HTTP_Fsockopen {
	mut obj := &Class_WP_HTTP_Fsockopen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http(_args ...rt.PhpVal) &Class_WP_Http {
	mut obj := &Class_WP_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_proxy(_args ...rt.PhpVal) &Class_WP_HTTP_Proxy {
	mut obj := &Class_WP_HTTP_Proxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http_encoding(_args ...rt.PhpVal) &Class_WP_Http_Encoding {
	mut obj := &Class_WP_Http_Encoding{
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
			return rt.new_bool(Class_WP_Http_Streams.verify_ssl_certificate(dispatch_arg_0,
				dispatch_arg_1))
		}
		'test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Http_Streams.test(dispatch_arg_0))
		}
		else {
			return none
		}
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

fn (mut this Class_WP_Http_Encoding) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http_Encoding) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http_Encoding) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

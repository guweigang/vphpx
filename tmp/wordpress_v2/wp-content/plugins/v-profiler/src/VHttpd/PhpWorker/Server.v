import rt

fn parsesocketfromargv(var_argv rt.PhpVal) string {
	mut var_arg := rt.new_null()
	mut var_index := rt.new_null()
	mut var_socket := rt.new_null()
	mut iter_1 := var_argv.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_arg_shadow := item_1.val
		mut var_index_shadow := item_1.key
		if rt.is_true(rt.identical(var_arg_shadow, rt.new_string('--socket'))) && var_argv.array_isset(rt.add(var_index_shadow, rt.new_int(1))) {
			return (var_argv.array_get(rt.add(var_index_shadow, rt.new_int(1)))).str()
		}
		if rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_arg_shadow).str()), rt.new_string('--socket=')])) {
			return (rt.call_function('substr', [rt.new_string((var_arg_shadow).str()), rt.new_int('--socket='.len)])).str()
		}
	}
	var_socket = rt.call_function('getenv', [rt.new_string('VHTTPD_WORKER_SOCKET')])
	if var_socket.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_socket, rt.new_string(''))))) {
		return (var_socket).str()
	}
	rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('vhttpd worker socket is required'))))
	return ''
}

struct Class_VHttpd_PhpWorker_Server {
	rt.PhpObjectBase
pub mut:
		app rt.PhpVal = rt.new_null()
		parentPid rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_PhpWorker_Server) construct(socketPath string, defaultApp string) {
	mut var_parentPid := rt.call_function('getenv', [rt.new_string('VHTTPD_PARENT_PID')])
	this.parentPid = if var_parentPid.clone().is_string() && rt.is_true(rt.call_function('ctype_digit', [var_parentPid.clone()])) { rt.new_int((var_parentPid).to_i64()) } else { 0 }
	mut var_appPath := rt.call_function('getenv', [rt.new_string('VHTTPD_APP')])
	if !(var_appPath.clone().is_string()) || rt.is_true(rt.identical(var_appPath, rt.new_string(''))) {
	var_appPath = rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'defaultApp')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_appPath.clone()]))))) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception('vhttpd app entry not found: ' + (var_appPath).str())))
	}
	mut var_app := rt.include_file((var_appPath).to_string(), '3')
	if !(rt.call_function('is_callable', [var_app.clone()])) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('vhttpd app entry must return a callable'))))
	}
	this.app = var_app.clone()
}

fn (mut this Class_VHttpd_PhpWorker_Server) run() {
	if rt.is_true(rt.identical(rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath'), rt.new_string(''))) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('vhttpd worker socket is empty'))))
	}
	if rt.is_true(rt.call_function('file_exists', [rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')])) || rt.is_true(rt.call_function('is_link', [rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')])) {
		rt.call_function('unlink', [rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('sockets')]))))) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('php sockets extension is required for vhttpd worker sockets'))))
	}
	mut var_server := rt.call_function('socket_create', [rt.get_constant('AF_UNIX'), rt.get_constant('SOCK_STREAM'), rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_server)))) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception('failed to create worker socket: ' + (rt.call_function('socket_strerror', [rt.call_function('socket_last_error', []rt.PhpVal{})])).str())))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_bind', [var_server.clone(), rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')]))))) {
		mut var_error := rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [var_server.clone()])])
		rt.call_function('socket_close', [var_server.clone()])
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.concat(rt.concat(rt.concat(rt.new_string('failed to bind worker socket '), rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')), rt.new_string(': ')), var_error))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('socket_listen', [var_server.clone()]))))) {
		var_error = rt.call_function('socket_strerror', [rt.call_function('socket_last_error', [var_server.clone()])])
		rt.call_function('socket_close', [var_server.clone()])
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.concat(rt.concat(rt.concat(rt.new_string('failed to listen on worker socket '), rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')), rt.new_string(': ')), var_error))))
	}
	rt.call_function('socket_set_nonblock', [var_server.clone()])
	for !(this.parentprocessexited()) {
		mut var_conn := rt.call_function('socket_accept', [var_server.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_conn)))) {
			if rt.is_true(Class_VHttpd_PhpWorker_Server.iswouldblock((rt.call_function('socket_last_error', [var_server.clone()])).to_i64())) {
				rt.call_function('socket_clear_error', [var_server.clone()])
				rt.call_function('usleep', [rt.new_int(200000)])
				continue
			}
			continue
		}
		rt.call_function('socket_set_block', [var_conn.clone()])
		this.handleconnection(var_conn.clone())
		rt.call_function('socket_close', [var_conn.clone()])
	}
	rt.call_function('socket_close', [var_server.clone()])
	if rt.is_true(rt.call_function('file_exists', [rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')])) || rt.is_true(rt.call_function('is_link', [rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')])) {
		rt.call_function('unlink', [rt.get_property(rt.new_object('VHttpd_PhpWorker_Server', []string{}, &this), 'socketPath')])
	}
}

fn (mut this Class_VHttpd_PhpWorker_Server) parentprocessexited() bool {
	if rt.is_true(rt.less_equal(this.parentPid, rt.new_int(0))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('posix_kill')]))))) {
		return false
	}
	return !(rt.is_true(rt.call_function('posix_kill', [this.parentPid, rt.new_int(0)])))
}

fn Class_VHttpd_PhpWorker_Server.iswouldblock(error i64) bool {
	mut error_mutated := error
	mut var_wouldBlock := rt.new_array()
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'SOCKET_EAGAIN' }, rt.ArrayItem{ key: none, val: 'SOCKET_EWOULDBLOCK' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_constant := item_2.val
		if rt.is_true(rt.call_function('defined', [var_constant.clone()])) {
			var_wouldBlock.array_push(rt.call_function('constant', [var_constant.clone()]))
		}
	}
	return error_mutated == 0 || rt.is_true(rt.call_function('in_array', [rt.new_int(error_mutated).clone(), var_wouldBlock.clone(), rt.new_bool(true)]))
}

fn (mut this Class_VHttpd_PhpWorker_Server) handleconnection(var_conn rt.PhpVal) {
	mut var_conn_mutated := var_conn
	mut var_raw := Class_VHttpd_PhpWorker_Server.readframe(var_conn_mutated.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_payload := rt.call_function('json_decode', [var_raw.clone(), rt.new_bool(true), rt.new_int(512), rt.get_constant('JSON_THROW_ON_ERROR')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_payload.clone().is_array()) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('worker payload must be a JSON object'))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_result := rt.call_callable(this.app, [var_payload.clone(), var_payload.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.instance_of(var_result, 'VHttpd_PhpWorker_StreamResponse'))) {
		Class_VHttpd_PhpWorker_Server.writestreamresponse(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](var_conn_mutated), mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_StreamResponse](var_payload), var_result.clone())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		return
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	Class_VHttpd_PhpWorker_Server.writeframe((var_conn_mutated).str(), rt.new_string((rt.json_encode(Class_VHttpd_PhpWorker_Server.normalizeresponse(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](var_payload), mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](var_result)))).str()))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.clone()
		if rt.is_true(rt.call_function('str_contains', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.new_string('unexpected EOF')])) {
			return
		}
		Class_VHttpd_PhpWorker_Server.writeframe((var_conn_mutated).str(), rt.new_string((rt.json_encode(Class_VHttpd_PhpWorker_Server.errorresponse(mut rt.cast_object_ptr[Class_Throwable](var_e)))).str()))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Throwable') {
			return
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn Class_VHttpd_PhpWorker_Server.readframe(var_conn rt.PhpVal) string {
	mut var_conn_mutated := var_conn
	mut var_header := Class_VHttpd_PhpWorker_Server.readexact((var_conn_mutated).to_i64(), rt.new_int(4))
	mut var_unpacked := rt.call_function('unpack', [rt.new_string('Nsize'), var_header.clone()])
	mut var_size := rt.new_int((if !(var_unpacked.array_get(rt.new_string('size'))).is_null() { var_unpacked.array_get(rt.new_string('size')) } else { rt.new_int(0) }).to_i64())
	if rt.is_true(rt.less_equal(var_size, rt.new_int(0))) || rt.is_true(rt.greater(var_size, 16 * 1024 * 1024)) {
		rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception('invalid worker frame size: ' + (var_size).str())))
	}
	return (Class_VHttpd_PhpWorker_Server.readexact((var_conn_mutated).to_i64(), var_size.clone())).str()
}

fn Class_VHttpd_PhpWorker_Server.readexact(var_conn rt.PhpVal, size i64) string {
	mut var_conn_mutated := var_conn
	mut size_mutated := size
	mut var_buf := rt.new_string('')
	for var_buf.clone().to_string().len < size_mutated {
		mut var_chunk := rt.call_function('socket_read', [var_conn_mutated.clone(), rt.new_int(size_mutated - var_buf.clone().to_string().len), rt.get_constant('PHP_BINARY_READ')])
		if rt.is_true(rt.identical(var_chunk, rt.new_bool(false))) || rt.is_true(rt.identical(var_chunk, rt.new_string(''))) {
			rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('unexpected EOF while reading worker frame'))))
		}
		var_buf = rt.concat(var_buf, var_chunk)
	}
	return (var_buf).str()
}

fn Class_VHttpd_PhpWorker_Server.writeframe(var_conn rt.PhpVal, payload string) {
	mut var_conn_mutated := var_conn
	mut payload_mutated := payload
	mut var_data := rt.new_string((rt.call_function('pack', [rt.new_string('N'), rt.new_int(payload_mutated.len)])).str() + payload_mutated)
	mut var_written := rt.new_int(0)
	mut var_size := rt.new_int(var_data.clone().to_string().len)
	for rt.is_true(rt.less(var_written, var_size)) {
		mut var_n := rt.call_function('socket_write', [var_conn_mutated.clone(), rt.call_function('substr', [var_data.clone(), var_written.clone()]), rt.sub(var_size, var_written)])
		if rt.is_true(rt.identical(var_n, rt.new_bool(false))) || rt.is_true(rt.identical(var_n, rt.new_int(0))) {
			rt.throw_exception(rt.new_object('VHttpd_PhpWorker_RuntimeException', []string{}, create_vhttpd_phpworker_runtimeexception(rt.new_string('failed to write worker frame'))))
		}
		var_written = rt.add(var_written, var_n)
	}
}

fn Class_VHttpd_PhpWorker_Server.normalizeresponse(mut var_request Class_VHttpd_PhpWorker_array, mut var_result Class_VHttpd_PhpWorker_mixed) rt.PhpVal {
	mut var_result_mutated := var_result
	if rt.is_true(rt.new_bool(rt.instance_of(var_result_mutated, 'VHttpd_PhpWorker_Response'))) {
		mut var_payload := rt.call_method(var_result_mutated, 'toArray', []rt.PhpVal{})
		if rt.is_true(rt.identical((if !(var_payload.array_get(rt.new_string('id'))).is_null() { var_payload.array_get(rt.new_string('id')) } else { rt.new_string('') }).str(), rt.new_string(''))) {
			var_payload.array_set('id', (if !(var_request.array_get(rt.new_string('id'))).is_null() { var_request.array_get(rt.new_string('id')) } else { rt.new_string('') }).str())
		}
		return var_payload.clone()
	}
	if !(var_result_mutated.is_array()) {
	var_result_mutated = rt.create_array([rt.ArrayItem{ key: 'status', val: 200 }, rt.ArrayItem{ key: 'body', val: (var_result_mutated).str() }])
	}
	mut var_headers := Class_VHttpd_PhpWorker_Server.normalizeheaders(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if !(var_result_mutated.array_get(rt.new_string('headers'))).is_null() { var_result_mutated.array_get(rt.new_string('headers')) } else { rt.new_array() }))
	mut var_contentType := rt.new_string((if !(var_result_mutated.array_get(rt.new_string('content_type'))).is_null() { var_result_mutated.array_get(rt.new_string('content_type')) } else { if !(var_result_mutated.array_get(rt.new_string('contentType'))).is_null() { var_result_mutated.array_get(rt.new_string('contentType')) } else { rt.new_string('') } }).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_contentType, rt.new_string(''))))) && !(var_headers.array_isset(rt.new_string('content-type'))) {
		var_headers.array_set('content-type', var_contentType.clone())
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: (if !(var_request.array_get(rt.new_string('id'))).is_null() { var_request.array_get(rt.new_string('id')) } else { rt.new_string('') }).str() }, rt.ArrayItem{ key: 'status', val: rt.new_int((if !(var_result_mutated.array_get(rt.new_string('status'))).is_null() { var_result_mutated.array_get(rt.new_string('status')) } else { rt.new_int(200) }).to_i64()) }, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{ key: 'body', val: (if !(var_result_mutated.array_get(rt.new_string('body'))).is_null() { var_result_mutated.array_get(rt.new_string('body')) } else { rt.new_string('') }).str() }])
}

fn Class_VHttpd_PhpWorker_Server.writestreamresponse(var_conn rt.PhpVal, mut var_request Class_VHttpd_PhpWorker_array, mut var_response Class_VHttpd_PhpWorker_StreamResponse) {
	mut var_conn_mutated := var_conn
	mut var_headers := Class_VHttpd_PhpWorker_Server.normalizeheaders(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](rt.get_property(var_response, 'headers')))
	if !(var_headers.array_isset(rt.new_string('content-type'))) {
		var_headers.array_set('content-type', rt.get_property(var_response, 'contentType'))
	}
	Class_VHttpd_PhpWorker_Server.writejsonframe(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](var_conn_mutated), rt.create_array([rt.ArrayItem{ key: 'id', val: (if !(var_request.array_get(rt.new_string('id'))).is_null() { var_request.array_get(rt.new_string('id')) } else { rt.new_string('') }).str() }, rt.ArrayItem{ key: 'mode', val: 'stream' }, rt.ArrayItem{ key: 'event', val: 'start' }, rt.ArrayItem{ key: 'status', val: rt.get_property(var_response, 'status') }, rt.ArrayItem{ key: 'stream_type', val: rt.get_property(var_response, 'streamType') }, rt.ArrayItem{ key: 'content_type', val: rt.get_property(var_response, 'contentType') }, rt.ArrayItem{ key: 'headers', val: var_headers }]))
	mut iter_3 := rt.get_property(var_response, 'chunks').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_chunk := item_3.val
		Class_VHttpd_PhpWorker_Server.writejsonframe(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](var_conn_mutated), Class_VHttpd_PhpWorker_Server.streamchunkframe(mut var_request, mut var_response, mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](var_chunk)))
	}
	Class_VHttpd_PhpWorker_Server.writejsonframe(mut rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](var_conn_mutated), rt.create_array([rt.ArrayItem{ key: 'id', val: (if !(var_request.array_get(rt.new_string('id'))).is_null() { var_request.array_get(rt.new_string('id')) } else { rt.new_string('') }).str() }, rt.ArrayItem{ key: 'mode', val: 'stream' }, rt.ArrayItem{ key: 'event', val: 'end' }, rt.ArrayItem{ key: 'stream_type', val: rt.get_property(var_response, 'streamType') }]))
}

fn Class_VHttpd_PhpWorker_Server.streamchunkframe(mut var_request Class_VHttpd_PhpWorker_array, mut var_response Class_VHttpd_PhpWorker_StreamResponse, mut var_chunk Class_VHttpd_PhpWorker_mixed) rt.PhpVal {
	mut var_chunk_mutated := var_chunk
	mut var_frame := rt.create_array([rt.ArrayItem{ key: 'id', val: (if !(var_request.array_get(rt.new_string('id'))).is_null() { var_request.array_get(rt.new_string('id')) } else { rt.new_string('') }).str() }, rt.ArrayItem{ key: 'mode', val: 'stream' }, rt.ArrayItem{ key: 'event', val: 'chunk' }, rt.ArrayItem{ key: 'stream_type', val: rt.get_property(var_response, 'streamType') }])
	if rt.is_true(rt.identical(rt.get_property(var_response, 'streamType'), rt.new_string('sse'))) {
		if rt.is_true(rt.new_bool(var_chunk_mutated.is_array())) {
			var_frame.array_set('data', (if !(var_chunk_mutated.array_get(rt.new_string('data'))).is_null() { var_chunk_mutated.array_get(rt.new_string('data')) } else { rt.new_string('') }).str())
			var_frame.array_set('sse_id', (if !(var_chunk_mutated.array_get(rt.new_string('id'))).is_null() { var_chunk_mutated.array_get(rt.new_string('id')) } else { if !(var_chunk_mutated.array_get(rt.new_string('sse_id'))).is_null() { var_chunk_mutated.array_get(rt.new_string('sse_id')) } else { rt.new_string('') } }).str())
			var_frame.array_set('sse_event', (if !(var_chunk_mutated.array_get(rt.new_string('event'))).is_null() { var_chunk_mutated.array_get(rt.new_string('event')) } else { if !(var_chunk_mutated.array_get(rt.new_string('sse_event'))).is_null() { var_chunk_mutated.array_get(rt.new_string('sse_event')) } else { rt.new_string('') } }).str())
			mut var_retry := if !(var_chunk_mutated.array_get(rt.new_string('retry'))).is_null() { var_chunk_mutated.array_get(rt.new_string('retry')) } else { if !(var_chunk_mutated.array_get(rt.new_string('sse_retry'))).is_null() { var_chunk_mutated.array_get(rt.new_string('sse_retry')) } else { rt.new_int(0) } }
			var_frame.array_set('sse_retry', if var_retry.clone().is_long() || var_retry.clone().is_double() { rt.new_int((var_retry).to_i64()) } else { 0 })
			return var_frame.clone()
		}
		var_frame.array_set('data', (var_chunk_mutated).str())
		return var_frame.clone()
	}
	var_frame.array_set('data_base64', rt.call_function('base64_encode', [rt.new_string((var_chunk_mutated).str())]))
	return var_frame.clone()
}

fn Class_VHttpd_PhpWorker_Server.writejsonframe(var_conn rt.PhpVal, mut var_payload Class_VHttpd_PhpWorker_array) {
	mut var_conn_mutated := var_conn
	mut var_payload_mutated := var_payload
	Class_VHttpd_PhpWorker_Server.writeframe((var_conn_mutated).str(), rt.new_string((rt.json_encode(var_payload_mutated)).str()))
}

fn Class_VHttpd_PhpWorker_Server.normalizeheaders(mut var_headers Class_VHttpd_PhpWorker_mixed) rt.PhpVal {
	mut var_headers_mutated := var_headers
	if !(var_headers_mutated.is_array()) {
		return rt.new_array()
	}
	mut var_out := rt.new_array()
	mut iter_4 := var_headers_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_name := item_4.key
		if !(var_name.clone().is_string()) && !(var_name.clone().is_long()) {
			continue
		}
		mut var_key := rt.new_string((var_name).str().to_lower())
		var_out.array_set(var_key, if var_value.clone().is_array() { rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.new_string('strval'), var_value.clone()])]) } else { (var_value).str() })
	}
	return var_out.clone()
}

fn Class_VHttpd_PhpWorker_Server.errorresponse(mut var_e Class_Throwable) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'status', val: 500 }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'content-type', val: 'text/plain; charset=utf-8' }, rt.ArrayItem{ key: 'x-vhttpd-error-class', val: Class_VHttpd_PhpWorker_{"nodeType":"Expr_Variable","line":333,"name":"e"}.class() }]) }, rt.ArrayItem{ key: 'body', val: 'Worker Error: ' + (var_e.getmessage()).str() }])
}

struct Class_VHttpd_PhpWorker_RuntimeException {
	rt.PhpObjectBase
}

fn create_vhttpd_phpworker_server(socketPath string, defaultApp string) &Class_VHttpd_PhpWorker_Server {
	mut obj := &Class_VHttpd_PhpWorker_Server{
		PhpObjectBase: rt.PhpObjectBase{}
		app: rt.new_null()
		parentPid: rt.new_null()
	}
	obj.construct(socketPath, defaultApp)
	return obj
}

fn create_vhttpd_phpworker_runtimeexception(_args ...rt.PhpVal) &Class_VHttpd_PhpWorker_RuntimeException {
	mut obj := &Class_VHttpd_PhpWorker_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_PhpWorker_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'run' {
			this.run()
			return rt.new_null()
		}
		'parentProcessExited' {
			return rt.new_bool(this.parentprocessexited())
		}
		'isWouldBlock' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_VHttpd_PhpWorker_Server.iswouldblock(dispatch_arg_0))
		}
		'handleConnection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handleconnection(dispatch_arg_0)
			return rt.new_null()
		}
		'readFrame' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_VHttpd_PhpWorker_Server.readframe(dispatch_arg_0))
		}
		'readExact' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_VHttpd_PhpWorker_Server.readexact(dispatch_arg_0, dispatch_arg_1))
		}
		'writeFrame' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_VHttpd_PhpWorker_Server.writeframe(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'normalizeResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_VHttpd_PhpWorker_Server.normalizeresponse(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'writeStreamResponse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_StreamResponse](if args.len > 2 { args[2] } else { rt.new_null() })
			Class_VHttpd_PhpWorker_Server.writestreamresponse(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'streamChunkFrame' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_StreamResponse](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_VHttpd_PhpWorker_Server.streamchunkframe(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'writeJsonFrame' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_VHttpd_PhpWorker_Server.writejsonframe(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'normalizeHeaders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_PhpWorker_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_VHttpd_PhpWorker_Server.normalizeheaders(mut dispatch_arg_0)
		}
		'errorResponse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Throwable](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_VHttpd_PhpWorker_Server.errorresponse(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_PhpWorker_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'app' { return this.app }
		'parentPid' { return this.parentPid }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_PhpWorker_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'app' { this.app = val; return true }
		'parentPid' { this.parentPid = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_VHttpd_PhpWorker_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_PhpWorker_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_PhpWorker_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('parseSocketFromArgv', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(parsesocketfromargv(arg_0))
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

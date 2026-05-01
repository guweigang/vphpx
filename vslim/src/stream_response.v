module main

import vphp

@[php_arg_name: 'stream_type=streamType,content_type=contentType']
@[php_method]
pub fn (mut r VSlimStreamResponse) construct(stream_type string, chunks vphp.RequestBorrowedZBox, status int, content_type string, headers vphp.RequestBorrowedZBox) &VSlimStreamResponse {
	r.stream_type = normalize_stream_type(stream_type)
	r.status = if status <= 0 { 200 } else { status }
	r.content_type = default_stream_content_type(r.stream_type, content_type).clone()
	r.headers = snapshot_string_map(normalize_header_map(headers.to_string_map()))
	if 'content-type' !in r.headers {
		r.headers['content-type'] = r.content_type.clone()
	}
	r.set_chunks(chunks)
	return &r
}

@[php_method]
pub fn VSlimStreamResponse.text(chunks vphp.RequestBorrowedZBox) &VSlimStreamResponse {
	return VSlimStreamResponse.text_with(chunks, 200, 'text/plain; charset=utf-8',
		vphp.RequestBorrowedZBox.null())
}

@[php_arg_name: 'content_type=contentType']
@[php_method: 'textWith']
pub fn VSlimStreamResponse.text_with(chunks vphp.RequestBorrowedZBox, status int, content_type string, headers vphp.RequestBorrowedZBox) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('text', chunks, status, content_type, headers)
	return out
}

@[php_method]
pub fn VSlimStreamResponse.sse(events vphp.RequestBorrowedZBox) &VSlimStreamResponse {
	return VSlimStreamResponse.sse_with(events, 200, vphp.RequestBorrowedZBox.null())
}

@[php_method: 'sseWith']
pub fn VSlimStreamResponse.sse_with(events vphp.RequestBorrowedZBox, status int, headers vphp.RequestBorrowedZBox) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('sse', events, status, 'text/event-stream', headers)
	return out
}

@[php_method]
pub fn (r &VSlimStreamResponse) header(name string) string {
	headers := r.header_values()
	return headers[VSlimRequest.normalize_header_name(name)] or { '' }
}

@[php_method]
pub fn (r &VSlimStreamResponse) headers() map[string]string {
	return r.header_values()
}

@[php_method: 'hasHeader']
pub fn (r &VSlimStreamResponse) has_header(name string) bool {
	headers := r.header_values()
	return VSlimRequest.normalize_header_name(name) in headers
}

@[php_method: 'setHeader']
pub fn (mut r VSlimStreamResponse) set_header(name string, value string) &VSlimStreamResponse {
	mut headers := r.header_values()
	headers[VSlimRequest.normalize_header_name(name)] = value.clone()
	apply_stream_headers(mut r, headers)
	return &r
}

@[php_method: 'setStatus']
pub fn (mut r VSlimStreamResponse) set_status(status int) &VSlimStreamResponse {
	r.status = if status <= 0 { 200 } else { status }
	return &r
}

@[php_arg_name: 'content_type=contentType']
@[php_method: 'setContentType']
pub fn (mut r VSlimStreamResponse) set_content_type(content_type string) &VSlimStreamResponse {
	r.content_type = default_stream_content_type(r.stream_type, content_type).clone()
	mut headers := r.header_values()
	headers['content-type'] = r.content_type.clone()
	apply_stream_headers(mut r, headers)
	return &r
}

@[php_method: 'setChunks']
pub fn (mut r VSlimStreamResponse) set_chunks(chunks vphp.RequestBorrowedZBox) &VSlimStreamResponse {
	if r.chunks_ref.is_valid() {
		unsafe {
			mut owned := r.chunks_ref
			owned.release()
		}
	}
	r.chunks_ref = vphp.PersistentOwnedZBox.from_mixed_zval(chunks.to_zval())
	return &r
}

@[php_method]
pub fn (r &VSlimStreamResponse) chunks() vphp.RequestOwnedZBox {
	if !r.chunks_ref.is_valid() || r.chunks_ref.is_null() || r.chunks_ref.is_undef() {
		return vphp.RequestOwnedZBox.new_null()
	}
	return r.chunks_ref.clone_request_owned()
}

pub fn (r &VSlimStreamResponse) header_values() map[string]string {
	return snapshot_string_map(r.headers)
}

fn apply_stream_headers(mut r VSlimStreamResponse, headers map[string]string) {
	r.headers = snapshot_string_map(normalize_header_map(headers))
	r.content_type = (r.headers['content-type'] or {
		default_stream_content_type(r.stream_type, r.content_type)
	}).clone()
}

fn default_stream_content_type(stream_type string, content_type string) string {
	if content_type.trim_space() != '' {
		return content_type
	}
	if normalize_stream_type(stream_type) == 'sse' {
		return 'text/event-stream'
	}
	return 'text/plain; charset=utf-8'
}

fn normalize_stream_type(stream_type string) string {
	return if stream_type.trim_space().to_lower() == 'sse' { 'sse' } else { 'text' }
}

fn is_worker_stream_response_borrowed(result vphp.RequestBorrowedZBox) bool {
	raw := result.to_zval()
	return raw.is_object() && (raw.is_instance_of('VSlim\\Stream\\Response')
		|| raw.is_instance_of('VPhp\\VSlim\\Stream\\Response')
		|| raw.is_instance_of('VPhp\\VHttpd\\PhpWorker\\StreamResponse'))
}

fn propagate_request_trace_headers_to_object(req &VSlimRequest, raw vphp.RequestBorrowedZBox) {
	obj := raw.to_zval()
	if !obj.is_object() || !obj.method_exists('hasHeader') || !obj.method_exists('setHeader') {
		return
	}
	rid := req.request_id()
	if rid != '' {
		mut request_id_name_arg := vphp.PhpString.of('x-request-id')
		defer {
			request_id_name_arg.release()
		}
		missing := vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool]('hasHeader',
			fn (has vphp.PhpValue) bool {
			raw := has.to_zval()
			return !raw.is_valid() || !raw.to_bool()
		}, request_id_name_arg) or { true }
		if missing {
			mut rid_arg := vphp.PhpString.of(rid)
			defer {
				rid_arg.release()
			}
			vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool]('setHeader',
				fn (_ vphp.PhpValue) bool {
				return true
			}, request_id_name_arg, rid_arg) or { false }
		}
	}
	tid := req.trace_id()
	if tid == '' {
		return
	}
	mut trace_id_name_arg := vphp.PhpString.of('x-trace-id')
	defer {
		trace_id_name_arg.release()
	}
	missing_trace := vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool]('hasHeader',
		fn (has vphp.PhpValue) bool {
		raw := has.to_zval()
		return !raw.is_valid() || !raw.to_bool()
	}, trace_id_name_arg) or { true }
	if missing_trace {
		mut tid_arg := vphp.PhpString.of(tid)
		defer {
			tid_arg.release()
		}
		vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool]('setHeader',
			fn (_ vphp.PhpValue) bool {
			return true
		}, trace_id_name_arg, tid_arg) or { false }
	}
	mut vhttpd_trace_id_name_arg := vphp.PhpString.of('x-vhttpd-trace-id')
	defer {
		vhttpd_trace_id_name_arg.release()
	}
	missing_vhttpd := vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool]('hasHeader',
		fn (has vphp.PhpValue) bool {
		raw := has.to_zval()
		return !raw.is_valid() || !raw.to_bool()
	}, vhttpd_trace_id_name_arg) or { true }
	if missing_vhttpd {
		mut tid_arg := vphp.PhpString.of(tid)
		defer {
			tid_arg.release()
		}
		vphp.PhpObject.borrowed(obj).with_method_result[vphp.PhpValue, bool]('setHeader',
			fn (_ vphp.PhpValue) bool {
			return true
		}, vhttpd_trace_id_name_arg, tid_arg) or { false }
	}
}

pub fn (r &VSlimStreamResponse) free() {
	if r.chunks_ref.is_valid() {
		unsafe {
			mut owned := r.chunks_ref
			owned.release()
		}
	}
	unsafe {
		r.stream_type.free()
		r.content_type.free()
		r.headers.free()
	}
}

module main

import vphp

@[php_method]
pub fn (mut r VSlimStreamResponse) construct(stream_type string, chunks vphp.ZVal, status int, content_type string, headers vphp.ZVal) &VSlimStreamResponse {
	r.stream_type = normalize_stream_type(stream_type)
	r.status = if status <= 0 { 200 } else { status }
	r.content_type = default_stream_content_type(r.stream_type, content_type)
	r.headers = normalize_header_map(headers.to_string_map())
	if 'content-type' !in r.headers {
		r.headers['content-type'] = r.content_type
	}
	r.set_chunks(chunks)
	return &r
}

@[php_method]
pub fn VSlimStreamResponse.text(chunks vphp.ZVal) &VSlimStreamResponse {
	return VSlimStreamResponse.text_with(chunks, 200, 'text/plain; charset=utf-8', vphp.RequestOwnedZVal.new_null().to_zval())
}

@[php_method]
pub fn VSlimStreamResponse.text_with(chunks vphp.ZVal, status int, content_type string, headers vphp.ZVal) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('text', chunks, status, content_type, headers)
	return out
}

@[php_method]
pub fn VSlimStreamResponse.sse(events vphp.ZVal) &VSlimStreamResponse {
	return VSlimStreamResponse.sse_with(events, 200, vphp.RequestOwnedZVal.new_null().to_zval())
}

@[php_method]
pub fn VSlimStreamResponse.sse_with(events vphp.ZVal, status int, headers vphp.ZVal) &VSlimStreamResponse {
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

@[php_method]
pub fn (r &VSlimStreamResponse) has_header(name string) bool {
	headers := r.header_values()
	return VSlimRequest.normalize_header_name(name) in headers
}

@[php_method]
pub fn (mut r VSlimStreamResponse) set_header(name string, value string) &VSlimStreamResponse {
	mut headers := r.header_values()
	headers[VSlimRequest.normalize_header_name(name)] = value
	apply_stream_headers(mut r, headers)
	return &r
}

@[php_method]
pub fn (mut r VSlimStreamResponse) set_status(status int) &VSlimStreamResponse {
	r.status = if status <= 0 { 200 } else { status }
	return &r
}

@[php_method]
pub fn (mut r VSlimStreamResponse) set_content_type(content_type string) &VSlimStreamResponse {
	r.content_type = default_stream_content_type(r.stream_type, content_type)
	mut headers := r.header_values()
	headers['content-type'] = r.content_type
	apply_stream_headers(mut r, headers)
	return &r
}

@[php_method]
pub fn (mut r VSlimStreamResponse) set_chunks(chunks vphp.ZVal) &VSlimStreamResponse {
	if r.chunks_ref.is_valid() {
		unsafe {
			mut owned := r.chunks_ref
			owned.release()
		}
	}
	r.chunks_ref = vphp.PersistentOwnedZVal.from_zval(chunks)
	return &r
}

@[php_method]
@[export: 'manual_stream_chunks']
pub fn (r &VSlimStreamResponse) chunks() {}

@[export: 'VSlimStreamResponse_chunks']
pub fn vslimstreamresponse_chunks(ptr voidptr, ctx vphp.Context) {
	recv := unsafe { &VSlimStreamResponse(ptr) }
	if !recv.chunks_ref.is_valid() || recv.chunks_ref.is_null() || recv.chunks_ref.is_undef() {
		ctx.return_zval(vphp.RequestOwnedZVal.new_null().to_zval())
		return
	}
	ctx.return_zval(recv.chunks_ref.clone_request_owned().to_zval())
}

fn (r &VSlimStreamResponse) header_values() map[string]string {
	return r.headers.clone()
}

fn apply_stream_headers(mut r VSlimStreamResponse, headers map[string]string) {
	r.headers = normalize_header_map(headers)
	r.content_type = r.headers['content-type'] or { default_stream_content_type(r.stream_type, r.content_type) }
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

fn is_worker_stream_response_borrowed(result vphp.BorrowedZVal) bool {
	raw := result.to_zval()
	return raw.is_object()
		&& (raw.is_instance_of('VSlim\\Stream\\Response')
		|| raw.is_instance_of('VPhp\\VSlim\\Stream\\Response')
		|| raw.is_instance_of('VPhp\\VHttpd\\PhpWorker\\StreamResponse'))
}

fn propagate_request_trace_headers_to_object(req &VSlimRequest, raw vphp.BorrowedZVal) {
	obj := raw.to_zval()
	if !obj.is_object() || !obj.method_exists('has_header') || !obj.method_exists('set_header') {
		return
	}
	rid := req.request_id()
	if rid != '' {
		has := obj.method_owned_request('has_header', [vphp.RequestOwnedZVal.new_string('x-request-id').to_zval()])
		if !has.is_valid() || !has.to_bool() {
			_ = obj.method_owned_request('set_header', [
				vphp.RequestOwnedZVal.new_string('x-request-id').to_zval(),
				vphp.RequestOwnedZVal.new_string(rid).to_zval(),
			])
		}
	}
	tid := req.trace_id()
	if tid == '' {
		return
	}
	has_trace := obj.method_owned_request('has_header', [vphp.RequestOwnedZVal.new_string('x-trace-id').to_zval()])
	if !has_trace.is_valid() || !has_trace.to_bool() {
		_ = obj.method_owned_request('set_header', [
			vphp.RequestOwnedZVal.new_string('x-trace-id').to_zval(),
			vphp.RequestOwnedZVal.new_string(tid).to_zval(),
		])
	}
	has_vhttpd := obj.method_owned_request('has_header', [vphp.RequestOwnedZVal.new_string('x-vhttpd-trace-id').to_zval()])
	if !has_vhttpd.is_valid() || !has_vhttpd.to_bool() {
		_ = obj.method_owned_request('set_header', [
			vphp.RequestOwnedZVal.new_string('x-vhttpd-trace-id').to_zval(),
			vphp.RequestOwnedZVal.new_string(tid).to_zval(),
		])
	}
}

fn (mut r VSlimStreamResponse) free() {
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

module streamx

import httpx
import routing
import vphp

struct PhpValueSubject {
	value vphp.PhpValue
}

fn value_subject(value vphp.PhpValue) PhpValueSubject {
	return PhpValueSubject{
		value: value
	}
}

@[php_arg_name: 'stream_type=streamType,content_type=contentType']
@[php_method]
pub fn (mut r VSlimStreamResponse) construct(stream_type string, chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpValue) &VSlimStreamResponse {
	r.stream_type = normalize_stream_type(stream_type)
	r.status = if status <= 0 { 200 } else { status }
	r.content_type = default_stream_content_type(r.stream_type, content_type).clone()
	r.headers = httpx.snapshot_string_map(httpx.normalize_header_map(value_subject(headers).stream_headers()))
	if 'content-type' !in r.headers {
		r.headers['content-type'] = r.content_type.clone()
	}
	r.set_chunks(chunks)
	return &r
}

@[php_method]
pub fn VSlimStreamResponse.text(chunks vphp.PhpValue) &VSlimStreamResponse {
	return VSlimStreamResponse.text_with(chunks, 200, 'text/plain; charset=utf-8',
		vphp.PhpValue.null())
}

@[php_arg_name: 'content_type=contentType']
@[php_method: 'textWith']
pub fn VSlimStreamResponse.text_with(chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpValue) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('text', chunks, status, content_type, headers)
	return out
}

@[php_method]
pub fn VSlimStreamResponse.sse(events vphp.PhpValue) &VSlimStreamResponse {
	return VSlimStreamResponse.sse_with(events, 200, vphp.PhpValue.null())
}

@[php_method: 'sseWith']
pub fn VSlimStreamResponse.sse_with(events vphp.PhpValue, status int, headers vphp.PhpValue) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('sse', events, status, 'text/event-stream', headers)
	return out
}

@[php_method]
pub fn (r &VSlimStreamResponse) header(name string) string {
	headers := r.header_values()
	return headers[routing.Header.normalize_name(name)] or { '' }
}

@[php_method]
pub fn (r &VSlimStreamResponse) headers() map[string]string {
	return r.header_values()
}

@[php_method: 'stream_type']
pub fn (r &VSlimStreamResponse) stream_type_value() string {
	return r.stream_type
}

@[php_method: 'content_type']
pub fn (r &VSlimStreamResponse) content_type_value() string {
	return r.content_type
}

@[php_method: 'hasHeader']
pub fn (r &VSlimStreamResponse) has_header(name string) bool {
	headers := r.header_values()
	return routing.Header.normalize_name(name) in headers
}

@[php_method: 'setHeader']
pub fn (mut r VSlimStreamResponse) set_header(name string, value string) &VSlimStreamResponse {
	mut headers := r.header_values()
	headers[routing.Header.normalize_name(name)] = value.clone()
	r.apply_headers(headers)
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
	r.apply_headers(headers)
	return &r
}

@[php_method: 'setChunks']
pub fn (mut r VSlimStreamResponse) set_chunks(chunks vphp.PhpValue) &VSlimStreamResponse {
	if r.chunks_ref.is_valid() {
		mut owned := r.chunks_ref
		owned.release()
	}
	r.chunks_ref = chunks.retain()
	return &r
}

@[php_method]
pub fn (r &VSlimStreamResponse) chunks() vphp.PhpValue {
	if !r.chunks_ref.is_valid() || r.chunks_ref.is_null() || r.chunks_ref.is_undef() {
		return vphp.PhpValue.null()
	}
	return r.chunks_ref.to_request_owned()
}

pub fn (r &VSlimStreamResponse) header_values() map[string]string {
	return httpx.snapshot_string_map(r.headers)
}

fn (mut r VSlimStreamResponse) apply_headers(headers map[string]string) {
	r.headers = httpx.snapshot_string_map(httpx.normalize_header_map(headers))
	r.content_type = (r.headers['content-type'] or {
		default_stream_content_type(r.stream_type, r.content_type)
	}).clone()
}

fn (subject PhpValueSubject) stream_headers() map[string]string {
	headers := subject.value
	arr := headers.as_array() or { return map[string]string{} }
	return arr.to_string_map()
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

pub fn (r &VSlimStreamResponse) free() {
	if r.chunks_ref.is_valid() {
		mut owned := r.chunks_ref
		owned.release()
	}
	unsafe {
		r.stream_type.free()
		r.content_type.free()
		r.headers.free()
	}
}

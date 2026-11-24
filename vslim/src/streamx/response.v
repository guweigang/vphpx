module streamx

import httpx
import vphp

struct PhpValueSubject {
	value vphp.PhpValue
}

fn value_subject(value vphp.PhpValue) PhpValueSubject {
	return PhpValueSubject{
		value: value
	}
}

@[vphp.PhpArgNames(names: 'stream_type=streamType,content_type=contentType')]
@[vphp.PhpExportMethod(name: '')]
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

pub fn VSlimStreamResponse.text(chunks vphp.PhpValue) &VSlimStreamResponse {
	return VSlimStreamResponse.text_with(chunks, 200, 'text/plain; charset=utf-8',
		vphp.PhpValue.null())
}

pub fn VSlimStreamResponse.text_with(chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpValue) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('text', chunks, status, content_type, headers)
	return out
}

pub fn VSlimStreamResponse.sse(events vphp.PhpValue) &VSlimStreamResponse {
	return VSlimStreamResponse.sse_with(events, 200, vphp.PhpValue.null())
}

pub fn VSlimStreamResponse.sse_with(events vphp.PhpValue, status int, headers vphp.PhpValue) &VSlimStreamResponse {
	mut out := &VSlimStreamResponse{}
	out.construct('sse', events, status, 'text/event-stream', headers)
	return out
}

fn new_php_response(stream_type string, chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpValue) vphp.PhpValue {
	mut response := &VSlimStreamResponse{}
	mut value := vphp.bind_owned_object_value[VSlimStreamResponse](response)
	response.construct(stream_type, chunks, status, content_type, headers)
	return value.move_to_request_scope()
}

@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpExportMethod(name: 'text')]
pub fn VSlimStreamResponse.export_text(chunks vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamResponse.export_text_with(chunks, 200, 'text/plain; charset=utf-8',
		vphp.PhpValue.null())
}

@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpArgName(v_name: 'wait_timeout_ms', php_name: 'waitTimeoutMs')]
@[vphp.PhpArgDefaults(defaults: 'args=[],wait_timeout_ms=-1')]
@[vphp.PhpExportMethod(name: 'textFrom')]
pub fn VSlimStreamResponse.export_text_from(factory vphp.PhpCallable, args vphp.PhpArray, wait_timeout_ms i64) !vphp.PhpValue {
	chunks := vphp.PhpGenerator.from_iterable_factory_args(factory, args,
		stream: vphp.PhpStreamGeneratorOptions{ wait_timeout_ms: wait_timeout_ms }
	)!
	return VSlimStreamResponse.export_text(chunks.to_value())
}

@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpArgName(v_name: 'wait_timeout_ms', php_name: 'waitTimeoutMs')]
@[vphp.PhpExportMethod(name: 'textStream')]
pub fn VSlimStreamResponse.export_text_stream(stream vphp.PhpResource, wait_timeout_ms i64) !vphp.PhpValue {
	chunks := vphp.PhpGenerator.from_stream_resource(stream, wait_timeout_ms: wait_timeout_ms)!
	return VSlimStreamResponse.export_text(chunks.to_value())
}

@[vphp.PhpArgName(v_name: 'content_type', php_name: 'contentType')]
@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpExportMethod(name: 'textWith')]
pub fn VSlimStreamResponse.export_text_with(chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpValue) vphp.PhpValue {
	return new_php_response('text', chunks, status, content_type, headers)
}

@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpExportMethod(name: 'sse')]
pub fn VSlimStreamResponse.export_sse(events vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamResponse.export_sse_with(events, 200, vphp.PhpValue.null())
}

@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpArgDefault(v_name: 'args', default_value: '[]')]
@[vphp.PhpExportMethod(name: 'sseFrom')]
pub fn VSlimStreamResponse.export_sse_from(factory vphp.PhpCallable, args vphp.PhpArray) !vphp.PhpValue {
	events := vphp.PhpGenerator.from_iterable_factory_args(factory, args)!
	return VSlimStreamResponse.export_sse(events.to_value())
}

@[vphp.PhpReturnType(php_type: 'VSlim\\Stream\\Response')]
@[vphp.PhpExportMethod(name: 'sseWith')]
pub fn VSlimStreamResponse.export_sse_with(events vphp.PhpValue, status int, headers vphp.PhpValue) vphp.PhpValue {
	return new_php_response('sse', events, status, 'text/event-stream', headers)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (r &VSlimStreamResponse) header(name string) string {
	headers := r.header_values()
	return headers[httpx.Header.normalize_name(name)] or { '' }
}

@[vphp.PhpExportMethod(name: '')]
pub fn (r &VSlimStreamResponse) headers() map[string]string {
	return r.header_values()
}

@[vphp.PhpExportMethod(name: 'stream_type')]
pub fn (r &VSlimStreamResponse) stream_type_value() string {
	return r.stream_type
}

@[vphp.PhpExportMethod(name: 'content_type')]
pub fn (r &VSlimStreamResponse) content_type_value() string {
	return r.content_type
}

@[vphp.PhpExportMethod(name: 'hasHeader')]
pub fn (r &VSlimStreamResponse) has_header(name string) bool {
	headers := r.header_values()
	return httpx.Header.normalize_name(name) in headers
}

@[vphp.PhpExportMethod(name: 'setHeader')]
pub fn (mut r VSlimStreamResponse) set_header(name string, value string) &VSlimStreamResponse {
	mut headers := r.header_values()
	headers[httpx.Header.normalize_name(name)] = value.clone()
	r.apply_headers(headers)
	return &r
}

@[vphp.PhpExportMethod(name: 'setStatus')]
pub fn (mut r VSlimStreamResponse) set_status(status int) &VSlimStreamResponse {
	r.status = if status <= 0 { 200 } else { status }
	return &r
}

@[vphp.PhpArgName(v_name: 'content_type', php_name: 'contentType')]
@[vphp.PhpExportMethod(name: 'setContentType')]
pub fn (mut r VSlimStreamResponse) set_content_type(content_type string) &VSlimStreamResponse {
	r.content_type = default_stream_content_type(r.stream_type, content_type).clone()
	mut headers := r.header_values()
	headers['content-type'] = r.content_type.clone()
	r.apply_headers(headers)
	return &r
}

@[vphp.PhpExportMethod(name: 'setChunks')]
pub fn (mut r VSlimStreamResponse) set_chunks(chunks vphp.PhpValue) &VSlimStreamResponse {
	if r.stream_type == 'text' {
		if resource := chunks.as_resource() {
			generator := vphp.PhpGenerator.from_stream_resource(resource) or {
				vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
				return &r
			}
			r.store_chunks(generator.to_value())
			return &r
		}
	}
	r.store_chunks(chunks)
	return &r
}

fn (mut r VSlimStreamResponse) store_chunks(chunks vphp.PhpValue) {
	if state := vphp.owned_object_php_state(r) {
		if chunks.is_valid() && !chunks.is_undef() {
			state.set_value('chunks', chunks)
		} else {
			state.remove('chunks')
		}
		r.chunks_ref.release()
	} else {
		mut old := r.chunks_ref
		r.chunks_ref = chunks.retain()
		old.release()
	}
}

@[vphp.PhpExportMethod(name: '')]
pub fn (r &VSlimStreamResponse) chunks() vphp.PhpValue {
	if state := vphp.owned_object_php_state(r) {
		if chunks := state.find('chunks') {
			return chunks.to_request_scoped()
		}
	}
	if !r.chunks_ref.is_valid() || r.chunks_ref.is_null() || r.chunks_ref.is_undef() {
		return vphp.PhpValue.null()
	}
	return r.chunks_ref.to_request_scoped()
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
	unsafe {
		r.stream_type.free()
		r.content_type.free()
		r.headers.free()
	}
}

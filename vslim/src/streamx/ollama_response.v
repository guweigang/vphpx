module streamx

import vphp

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'textResponseFromRequest']
pub fn (c &VSlimStreamOllamaClient) text_response_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	req := c.request_from_ollama_source(request_payload)
	mut payload := c.payload_from_vslim_request(req)
	defer {
		payload.release()
	}
	mut upstream := c.open_stream(payload)
	defer {
		upstream.release()
	}
	if !upstream.bool_at('ok', false) {
		return upstream_error_response(upstream).take_value()
	}
	rows := value_subject(upstream.value_at('stream')).ndjson_rows()
	chunks := ollama_text_chunks(rows)
	headers := new_ollama_response_headers(payload, upstream)
	mut status_arg := vphp.PhpInt.of(200)
	mut content_type_arg := vphp.PhpString.of('text/plain; charset=utf-8')
	defer {
		status_arg.release()
		content_type_arg.release()
	}
	mut response := vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('textWith', chunks,
		status_arg, content_type_arg, headers)
	propagate_request_trace_headers_to_value(req, response)
	return response
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'sseResponseFromRequest']
pub fn (c &VSlimStreamOllamaClient) sse_response_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	req := c.request_from_ollama_source(request_payload)
	mut payload := c.payload_from_vslim_request(req)
	defer {
		payload.release()
	}
	mut upstream := c.open_stream(payload)
	defer {
		upstream.release()
	}
	if !upstream.bool_at('ok', false) {
		return upstream_error_response(upstream).take_value()
	}
	rows := value_subject(upstream.value_at('stream')).ndjson_rows()
	events := encode_ollama_sse_events(rows, payload.string_at('model', c.default_model_value()))
	headers := new_ollama_response_headers(payload, upstream)
	mut status_arg := vphp.PhpInt.of(200)
	defer {
		status_arg.release()
	}
	mut response := vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sseWith', events,
		status_arg, headers)
	propagate_request_trace_headers_to_value(req, response)
	return response
}

fn new_ollama_response_headers(payload vphp.PhpArray, upstream vphp.PhpArray) vphp.PhpArray {
	mut headers := vphp.PhpArray.new()
	headers.string('x-ollama-model', payload.string_at('model', ''))
	headers.string('x-ollama-url', upstream.string_at('url', ''))
	return headers
}

fn upstream_error_response(upstream vphp.PhpArray) vphp.PhpArray {
	mut body := vphp.PhpArray.new()
	body.string('error', upstream.string_at('error', 'failed to open upstream stream'))
	body.string('url', upstream.string_at('url', ''))
	json := body.to_json_with_flags(256)
	mut out := vphp.PhpArray.new()
	out.int('status', upstream.int_at('status', 502))
	out.string('content_type', 'application/json; charset=utf-8')
	out.string('body', json)
	return out
}

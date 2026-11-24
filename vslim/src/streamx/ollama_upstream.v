module streamx

import httpx
import vphp

@[vphp.PhpExportMethod(name: 'openStream')]
pub fn (c &VSlimStreamOllamaClient) open_stream(payload vphp.PhpArray) vphp.PhpArray {
	fixture := c.fixture_path_value()
	if fixture != '' {
		mut stream := vphp.PhpResource.open_stream(fixture, 'r') or {
			return new_open_stream_result(false, vphp.PhpNull.value(), 'failed to open stream fixture: ' +
				fixture, 500, 'fixture://' + fixture)
		}
		defer {
			stream.release()
		}
		return new_open_stream_result(true, stream, '', 200, 'fixture://' + fixture)
	}

	mut request_body := vphp.PhpArray.new()
	request_body.string('model', payload.string_at('model', c.default_model_value()))
	request_body.bool('stream', true)
	request_body.set('messages', payload.value_at('messages'))
	encoded := request_body.to_json_with_flags(256)
	if encoded == '' {
		mut null_stream := vphp.PhpNull.value()
		return new_open_stream_result(false, null_stream, 'failed to encode request payload', 500,
			c.chat_url_value())
	}

	headers := vphp.PhpArray.new()
	headers.push_string('Content-Type: application/json')
	headers.push_string('Accept: application/x-ndjson')
	if c.api_key_value() != '' {
		headers.push_string('Authorization: Bearer ' + c.api_key_value())
	}

	mut http_options := vphp.PhpArray.new()
	http_options.string('method', 'POST')
	http_options.string('header', implode_lines(headers))
	http_options.string('content', encoded)
	http_options.int('timeout', 300)
	http_options.bool('ignore_errors', true)
	mut ctx_opts := vphp.PhpArray.new()
	ctx_opts.set('http', http_options)
	http_options.release()
	defer {
		ctx_opts.release()
	}
	url := c.chat_url_value()
	mut context := vphp.PhpResource.new_stream_context(ctx_opts) or {
		return new_open_stream_result(false, vphp.PhpNull.value(), err.msg(), 502, url)
	}
	defer {
		context.release()
	}
	mut stream := vphp.PhpResource.open_stream(url, 'r', context: context) or {
		return new_open_stream_result(false, vphp.PhpNull.value(), 'failed to open upstream stream: ' +
			url, 502, url)
	}
	defer {
		stream.release()
	}
	status := httpx.http_stream_response_status(stream)
	if status < 200 || status >= 300 {
		body := (stream.read_to_end() or { '' }).trim_space()
		_ = stream.close()
		return new_open_stream_result(false, vphp.PhpNull.value(), if body != '' {
			body
		} else {
			'upstream status ${status}'
		}, status, url)
	}

	return new_open_stream_result(true, stream, '', status, url)
}

@[vphp.PhpStringParam('output_mode', php_name: 'outputMode', default_value: 'sse', optional: true)]
@[vphp.PhpExportMethod(name: 'upstreamPlan')]
pub fn (c &VSlimStreamOllamaClient) upstream_plan(payload vphp.PhpArray, output_mode string) vphp.PhpValue {
	mode := if output_mode.trim_space().to_lower() == 'text' { 'text' } else { 'sse' }
	mapper := if mode == 'text' { 'ndjson_text_field' } else { 'ndjson_sse_field' }
	content_type := if mode == 'text' { 'text/plain; charset=utf-8' } else { 'text/event-stream' }
	model := payload.string_at('model', c.default_model_value())

	mut request_headers := vphp.PhpArray.new()
	request_headers.string('content-type', 'application/json')
	request_headers.string('accept', 'application/x-ndjson')
	if c.api_key_value() != '' {
		request_headers.string('authorization', 'Bearer ' + c.api_key_value())
	}
	mut response_headers := vphp.PhpArray.new()
	response_headers.string('content-type', content_type)
	response_headers.string('x-ollama-model', model)
	response_headers.string('x-ollama-url', c.chat_url_value())
	mut meta := vphp.PhpArray.new()
	meta.string('provider', 'ollama')
	meta.string('field_path', 'message.content')
	meta.string('fallback_field_path', 'response')
	meta.string('sse_event', 'token')

	mut url_arg := vphp.PhpString.of(c.chat_url_value())
	mut method_arg := vphp.PhpString.of('POST')
	mut body_arg := vphp.PhpString.of(payload.to_json_with_flags(256))
	mut codec_arg := vphp.PhpString.of('ndjson')
	mut mapper_arg := vphp.PhpString.of(mapper)
	mut mode_arg := vphp.PhpString.of(mode)
	mut content_type_arg := vphp.PhpString.of(content_type)
	mut fixture_arg := vphp.PhpString.of(c.fixture_path_value())
	mut name_arg := vphp.PhpString.of('ollama')
	mut arguments := vphp.PhpArray.new()
	defer {
		arguments.release()
		request_headers.release()
		response_headers.release()
		meta.release()
		url_arg.release()
		method_arg.release()
		body_arg.release()
		codec_arg.release()
		mapper_arg.release()
		mode_arg.release()
		content_type_arg.release()
		fixture_arg.release()
		name_arg.release()
	}
	arguments.set('url', url_arg)
	arguments.set('method', method_arg)
	arguments.set('requestHeaders', request_headers)
	arguments.set('body', body_arg)
	arguments.set('codec', codec_arg)
	arguments.set('mapper', mapper_arg)
	arguments.set('outputStreamType', mode_arg)
	arguments.set('outputContentType', content_type_arg)
	arguments.set('responseHeaders', response_headers)
	arguments.set('fixturePath', fixture_arg)
	arguments.set('name', name_arg)
	arguments.set('meta', meta)
	return vphp.PhpClass.named('VHttpd\\Upstream\\Plan').call_static_args('http', arguments)
}

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpExportMethod(name: 'upstreamTextPlanFromRequest')]
pub fn (c &VSlimStreamOllamaClient) upstream_text_plan_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	mut payload := c.payload_from_request(request_payload)
	defer {
		payload.release()
	}
	return c.upstream_plan(payload, 'text')
}

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpExportMethod(name: 'upstreamSsePlanFromRequest')]
pub fn (c &VSlimStreamOllamaClient) upstream_sse_plan_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	mut payload := c.payload_from_request(request_payload)
	defer {
		payload.release()
	}
	return c.upstream_plan(payload, 'sse')
}

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpStringParam('output_mode', php_name: 'outputMode', default_value: 'sse', optional: true)]
@[vphp.PhpExportMethod(name: 'upstreamPlanFromRequest')]
pub fn (c &VSlimStreamOllamaClient) upstream_plan_from_request(request_payload vphp.PhpValue, output_mode string) vphp.PhpValue {
	mut payload := c.payload_from_request(request_payload)
	defer {
		payload.release()
	}
	return c.upstream_plan(payload, output_mode)
}

fn new_open_stream_result(ok bool, stream vphp.PhpArgInput, error string, status int, url string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	out.bool('ok', ok)
	out.set('stream', stream)
	out.string('error', error)
	out.int('status', status)
	out.string('url', url)
	return out
}

fn implode_lines(lines vphp.PhpArray) string {
	mut parts := []string{}
	for item in lines.value_items() {
		text := item.to_string()
		if text != '' {
			parts << text
		}
	}
	if parts.len == 0 {
		return ''
	}
	return parts.join('\r\n') + '\r\n'
}

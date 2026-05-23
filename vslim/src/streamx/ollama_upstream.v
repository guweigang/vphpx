module streamx

import vphp

@[php_method: 'openStream']
pub fn (c &VSlimStreamOllamaClient) open_stream(payload vphp.PhpArray) vphp.PhpArray {
	fixture := c.fixture_path_value()
	if fixture != '' {
		mut fixture_arg := vphp.PhpString.of(fixture)
		mut mode_arg := vphp.PhpString.of('r')
		defer {
			fixture_arg.release()
			mode_arg.release()
		}
		mut fp := vphp.PhpFunction.named('fopen').invoke(fixture_arg, mode_arg)
		defer {
			fp.release()
		}
		if fp.is_resource() {
			return new_open_stream_result(true, fp.to_borrowed(), '', 200, 'fixture://' + fixture)
		}
		mut null_stream := vphp.PhpNull.value()
		return new_open_stream_result(false, null_stream, 'failed to open stream fixture: ' +
			fixture, 500, 'fixture://' + fixture)
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
	mut ctx := vphp.PhpFunction.named('stream_context_create').invoke(ctx_opts)
	defer {
		ctx.release()
	}
	mut url_arg := vphp.PhpString.of(c.chat_url_value())
	mut mode_arg := vphp.PhpString.of('r')
	mut use_include_path_arg := vphp.PhpBool.of(false)
	defer {
		url_arg.release()
		mode_arg.release()
		use_include_path_arg.release()
	}
	mut fp := vphp.PhpFunction.named('fopen').invoke(url_arg, mode_arg, use_include_path_arg, ctx)
	defer {
		fp.release()
	}
	if !fp.is_resource() {
		mut null_stream := vphp.PhpNull.value()
		return new_open_stream_result(false, null_stream, 'failed to open upstream stream: ' +
			c.chat_url_value(), 502, c.chat_url_value())
	}

	status := read_last_http_status()
	if status < 200 || status >= 300 {
		stream := fp.as_resource() or {
			mut null_stream := vphp.PhpNull.value()
			return new_open_stream_result(false, null_stream, 'upstream status ${status}', status,
				c.chat_url_value())
		}
		err := (stream.contents() or { '' }).trim_space()
		if stream.is_stream() {
			_ = stream.close()
		}
		mut null_stream := vphp.PhpNull.value()
		return new_open_stream_result(false, null_stream, if err != '' {
			err
		} else {
			'upstream status ${status}'
		}, status, c.chat_url_value())
	}

	return new_open_stream_result(true, fp.to_borrowed(), '', status, c.chat_url_value())
}

@[php_arg_name(output_mode: 'outputMode')]
@[php_arg_default(output_mode: '"sse"')]
@[php_arg_optional(output_mode: true)]
@[php_method: 'upstreamPlan']
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
	defer {
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
	return vphp.PhpClass.named('VHttpd\\Upstream\\Plan').call_static('http', url_arg, method_arg,
		request_headers, body_arg, codec_arg, mapper_arg, mode_arg, content_type_arg,
		response_headers, fixture_arg, name_arg, meta)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'upstreamTextPlanFromRequest']
pub fn (c &VSlimStreamOllamaClient) upstream_text_plan_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	mut payload := c.payload_from_request(request_payload)
	defer {
		payload.release()
	}
	return c.upstream_plan(payload, 'text')
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'upstreamSsePlanFromRequest']
pub fn (c &VSlimStreamOllamaClient) upstream_sse_plan_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	mut payload := c.payload_from_request(request_payload)
	defer {
		payload.release()
	}
	return c.upstream_plan(payload, 'sse')
}

@[php_arg_name(request_payload: 'requestPayload', output_mode: 'outputMode')]
@[php_arg_default(output_mode: '"sse"')]
@[php_arg_optional(output_mode: true)]
@[php_method: 'upstreamPlanFromRequest']
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

fn read_last_http_status() int {
	if !vphp.PhpFunction.named('http_get_last_response_headers').exists() {
		return 200
	}
	return vphp.PhpFunction.named('http_get_last_response_headers').with_result[vphp.PhpArray, int](fn (headers vphp.PhpArray) int {
		if headers.count() == 0 {
			return 200
		}
		line := headers.get_index(0).to_string()
		parts := line.split(' ')
		for part in parts {
			clean := part.trim_space()
			if clean.len == 3 && clean[0].is_digit() && clean[1].is_digit() && clean[2].is_digit() {
				return clean.int()
			}
		}
		return 200
	}) or { 200 }
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

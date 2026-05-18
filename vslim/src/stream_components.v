module main

import os
import vphp

@[php_method]
pub fn VSlimStreamFactory.text(chunks vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('text', chunks)
}

@[php_arg_name(content_type: 'contentType')]
@[php_method: 'textWith']
pub fn VSlimStreamFactory.text_with(chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpArray) vphp.PhpValue {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	mut content_type_arg := vphp.PhpString.of(content_type)
	defer {
		content_type_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('textWith', chunks,
		status_arg, content_type_arg, headers)
}

@[php_method]
pub fn VSlimStreamFactory.sse(events vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sse', events)
}

@[php_method: 'sseWith']
pub fn VSlimStreamFactory.sse_with(events vphp.PhpValue, status int, headers vphp.PhpArray) vphp.PhpValue {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sseWith', events,
		status_arg, headers)
}

@[php_arg_name(batch_size: 'batchSize', delay_ms: 'delayMs')]
@[php_arg_default(batch_size: '1', delay_ms: '0')]
@[php_arg_optional(batch_size: true, delay_ms: true)]
@[php_method: 'dispatchSse']
pub fn VSlimStreamFactory.dispatch_sse(events vphp.PhpValue, status int, headers vphp.PhpArray, batch_size int, delay_ms int) vphp.PhpValue {
	mut stream_type_arg := vphp.PhpString.of('sse')
	mut status_arg := vphp.PhpInt.of(status)
	mut content_type_arg := vphp.PhpString.of('text/event-stream')
	mut batch_arg := vphp.PhpInt.of(batch_size)
	mut delay_arg := vphp.PhpInt.of(delay_ms)
	defer {
		stream_type_arg.release()
		status_arg.release()
		content_type_arg.release()
		batch_arg.release()
		delay_arg.release()
	}
	return vphp.PhpClass.named('VHttpd\\PhpWorker\\StreamApp').call_static('fromSequence',
		stream_type_arg, events, status_arg, content_type_arg, headers, batch_arg, delay_arg)
}

@[php_arg_name(batch_size: 'batchSize', delay_ms: 'delayMs')]
@[php_arg_default(batch_size: '1', delay_ms: '0')]
@[php_arg_optional(batch_size: true, delay_ms: true)]
@[php_method: 'dispatchResponse']
pub fn VSlimStreamFactory.dispatch_response(response vphp.PhpObject, batch_size int, delay_ms int) vphp.PhpValue {
	mut batch_arg := vphp.PhpInt.of(batch_size)
	mut delay_arg := vphp.PhpInt.of(delay_ms)
	defer {
		batch_arg.release()
		delay_arg.release()
	}
	return vphp.PhpClass.named('VHttpd\\PhpWorker\\StreamApp').call_static('fromStreamResponse',
		response, batch_arg, delay_arg)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaText']
pub fn VSlimStreamFactory.ollama_text(request_payload vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_env().text_response_from_request(request_payload)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaTextWith']
pub fn VSlimStreamFactory.ollama_text_with(request_payload vphp.PhpValue, options vphp.PhpArray) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_options(options).text_response_from_request(request_payload)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaSse']
pub fn VSlimStreamFactory.ollama_sse(request_payload vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_env().sse_response_from_request(request_payload)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaSseWith']
pub fn VSlimStreamFactory.ollama_sse_with(request_payload vphp.PhpValue, options vphp.PhpArray) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_options(options).sse_response_from_request(request_payload)
}

@[php_method]
pub fn VSlimStreamNdjsonDecoder.decode(stream vphp.PhpValue) vphp.PhpArray {
	return decode_ndjson_rows(stream)
}

@[php_method: 'fromOllama']
pub fn VSlimStreamSseEncoder.from_ollama(rows vphp.PhpArray, model string) vphp.PhpArray {
	return encode_ollama_sse_events(rows, model)
}

@[php_arg_name(chat_url: 'chatUrl', default_model: 'defaultModel', api_key: 'apiKey', fixture_path: 'fixturePath')]
@[php_method]
pub fn (mut c VSlimStreamOllamaClient) construct(chat_url string, default_model string, api_key string, fixture_path string) &VSlimStreamOllamaClient {
	c.chat_url = normalize_ollama_chat_url(chat_url)
	c.default_model = normalize_ollama_model(default_model)
	c.api_key = api_key.trim_space()
	c.fixture_path = fixture_path.trim_space()
	return &c
}

@[php_method: 'fromEnv']
pub fn VSlimStreamOllamaClient.from_env() &VSlimStreamOllamaClient {
	mut out := &VSlimStreamOllamaClient{}
	out.construct(os.getenv('OLLAMA_CHAT_URL'), os.getenv('OLLAMA_MODEL'),
		os.getenv('OLLAMA_API_KEY'), os.getenv('OLLAMA_STREAM_FIXTURE'))
	return out
}

@[php_method: 'fromConfig']
pub fn VSlimStreamOllamaClient.from_config(config &VSlimConfig) &VSlimStreamOllamaClient {
	mut out := &VSlimStreamOllamaClient{}
	out.construct(config.get_string('stream.ollama.chat_url', os.getenv('OLLAMA_CHAT_URL')), config.get_string('stream.ollama.model',
		os.getenv('OLLAMA_MODEL')), config.get_string('stream.ollama.api_key',
		os.getenv('OLLAMA_API_KEY')), config.get_string('stream.ollama.fixture',
		os.getenv('OLLAMA_STREAM_FIXTURE')))
	return out
}

@[php_method: 'fromApp']
pub fn VSlimStreamOllamaClient.from_app(app &VSlimApp) &VSlimStreamOllamaClient {
	if app.config_ref != unsafe { nil } {
		return VSlimStreamOllamaClient.from_config(app.config_ref)
	}
	return VSlimStreamOllamaClient.from_env()
}

@[php_method: 'fromOptions']
pub fn VSlimStreamOllamaClient.from_options(options vphp.PhpArray) &VSlimStreamOllamaClient {
	base := VSlimStreamOllamaClient.from_env()
	mut out := &VSlimStreamOllamaClient{}
	out.construct(options.string_at('chat_url', base.chat_url_value()), options.string_at('model',
		base.default_model_value()), options.string_at('api_key', base.api_key_value()), options.string_at('fixture',
		base.fixture_path_value()))
	return out
}

@[php_method: 'chatUrl']
pub fn (c &VSlimStreamOllamaClient) chat_url() string {
	return c.chat_url_value()
}

@[php_method: 'defaultModel']
pub fn (c &VSlimStreamOllamaClient) default_model() string {
	return c.default_model_value()
}

@[php_method: 'apiKey']
pub fn (c &VSlimStreamOllamaClient) api_key() string {
	return c.api_key_value()
}

@[php_method: 'fixturePath']
pub fn (c &VSlimStreamOllamaClient) fixture_path() string {
	return c.fixture_path_value()
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) payload(input vphp.PhpArray) vphp.PhpArray {
	query := input['query']
	body_input := input['body']
	body := decode_ollama_body_payload(body_input)
	prompt := first_non_empty([
		query.string_at('prompt', ''),
		body.string_at('prompt', ''),
		'Explain VSlim streaming in one paragraph.',
	])
	model := first_non_empty([
		query.string_at('model', ''),
		body.string_at('model', ''),
		c.default_model_value(),
	])
	messages := normalize_ollama_messages(body, prompt)
	payload := new_ollama_payload(prompt, model, messages)
	return payload
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'payloadFromRequest']
pub fn (c &VSlimStreamOllamaClient) payload_from_request(request_payload vphp.PhpValue) vphp.PhpArray {
	req := normalize_ollama_source_request(request_payload)
	return c.payload_from_vslim_request(req)
}

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

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'textResponseFromRequest']
pub fn (c &VSlimStreamOllamaClient) text_response_from_request(request_payload vphp.PhpValue) vphp.PhpValue {
	req := normalize_ollama_source_request(request_payload)
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
	rows := decode_ndjson_rows(upstream.value_at('stream'))
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
	req := normalize_ollama_source_request(request_payload)
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
	rows := decode_ndjson_rows(upstream.value_at('stream'))
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

fn normalize_ollama_source_request(payload vphp.PhpValue) &VSlimRequest {
	return new_vslim_request_from_psr_server_request_value(payload, route_params_from_payload(payload))
}

pub fn (c &VSlimStreamOllamaClient) payload_from_vslim_request(req &VSlimRequest) vphp.PhpArray {
	mut input := vphp.PhpArray.new()
	mut query := new_string_map(req.query_params())
	input.set('query', query)
	query.release()
	mut body := decode_request_body_to_payload(req)
	input.set('body', body)
	body.release()
	return c.payload(input)
}

pub fn (c &VSlimStreamOllamaClient) chat_url_value() string {
	return normalize_ollama_chat_url(c.chat_url)
}

pub fn (c &VSlimStreamOllamaClient) default_model_value() string {
	return normalize_ollama_model(c.default_model)
}

pub fn (c &VSlimStreamOllamaClient) api_key_value() string {
	return c.api_key.trim_space()
}

pub fn (c &VSlimStreamOllamaClient) fixture_path_value() string {
	return c.fixture_path.trim_space()
}

fn normalize_ollama_chat_url(input string) string {
	clean := input.trim_space()
	if clean != '' {
		return clean
	}
	return 'http://127.0.0.1:11434/api/chat'
}

fn normalize_ollama_model(input string) string {
	clean := input.trim_space()
	if clean != '' {
		return clean
	}
	return 'qwen2.5:7b-instruct'
}

fn first_non_empty(values []string) string {
	for value in values {
		if value.trim_space() != '' {
			return value.trim_space()
		}
	}
	return ''
}

fn decode_request_body_to_payload(req &VSlimRequest) vphp.PhpArray {
	body := req.body.trim_space()
	if body == '' {
		return vphp.PhpArray.new()
	}
	decoded := vphp.PhpJson.decode_assoc_value(body)
	defer {
		decoded.release()
	}
	if decoded.is_array() {
		return decoded.as_array() or { vphp.PhpArray.new() }
	}
	return new_string_map(req.parsed_body())
}

fn decode_ollama_body_payload(input vphp.PhpValue) vphp.PhpArray {
	if arr := input.as_array() {
		return arr
	}
	if input.to_string().trim_space() == '' {
		return vphp.PhpArray.new()
	}
	decoded := vphp.PhpJson.decode_assoc_value(input.to_string())
	defer {
		decoded.release()
	}
	if decoded.is_array() {
		return decoded.as_array() or { vphp.PhpArray.new() }
	}
	return vphp.PhpArray.new()
}

fn normalize_ollama_messages(body vphp.PhpArray, prompt string) vphp.PhpArray {
	messages := body['messages'].as_array() or { vphp.PhpArray.new() }
	if messages.count() > 0 {
		normalized := normalize_message_rows(messages)
		if normalized.count() > 0 {
			return normalized
		}
	}

	mut fallback := vphp.PhpArray.new()
	system := body.string_at('system', '')
	if system != '' {
		mut row := new_message_row('system', system)
		fallback.push(row)
		row.release()
	}
	mut user_row := new_message_row('user', prompt)
	fallback.push(user_row)
	user_row.release()
	return fallback
}

fn normalize_message_rows(rows vphp.PhpArray) vphp.PhpArray {
	mut normalized := vphp.PhpArray.new()
	for idx := 0; idx < rows.count(); idx++ {
		item := rows.index_value(idx).as_array() or { continue }
		role := first_non_empty([
			item.string_at('role', ''),
			'user',
		])
		content := item.string_at('content', '')
		if content == '' {
			continue
		}
		mut row := new_message_row(role, content)
		normalized.push(row)
		row.release()
	}
	return normalized
}

fn new_message_row(role string, content string) vphp.PhpArray {
	mut row := vphp.PhpArray.new()
	row.string('role', if role.trim_space() == '' { 'user' } else { role.trim_space() })
	row.string('content', content)
	return row
}

fn new_ollama_payload(prompt string, model string, messages vphp.PhpArray) vphp.PhpArray {
	mut payload := vphp.PhpArray.new()
	payload.string('prompt', prompt)
	payload.string('model', model)
	payload.set('messages', messages)
	return payload
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

fn decode_ndjson_rows(stream_value vphp.PhpValue) vphp.PhpArray {
	mut rows := vphp.PhpArray.new()
	stream := stream_value.as_resource() or { return rows }
	defer {
		stream.release()
	}
	if !stream.is_stream() {
		return rows
	}
	for {
		if stream.eof() {
			break
		}
		line_raw := stream.read_line() or { '' }
		line := line_raw.trim_space()
		if line == '' {
			if line_raw == '' && stream.eof() {
				break
			}
			continue
		}
		mut row := vphp.PhpJson.decode_assoc_value(line)
		if !row.is_array() {
			row.release()
			continue
		}
		done := row.bool_at('done', false)
		rows.push_value(row)
		row.release()
		if done {
			break
		}
	}
	if stream.is_stream() {
		_ = stream.close()
	}
	return rows
}

fn encode_ollama_sse_events(rows vphp.PhpArray, model string) vphp.PhpArray {
	mut events := vphp.PhpArray.new()
	mut index := 0
	for row in rows.value_items() {
		piece := ollama_row_piece(row)
		if piece != '' {
			index++
			mut event := vphp.PhpArray.new()
			event.string('id', 'tok-${index}')
			event.string('event', 'token')
			event.int('retry', 1000)
			mut data := vphp.PhpArray.new()
			data.int('index', index)
			data.string('token', piece)
			data.string('model', model)
			event.string('data', data.to_json_with_flags(256))
			events.push(event)
			event.release()
		}
		if row.bool_at('done', false) {
			mut done_event := vphp.PhpArray.new()
			done_event.string('event', 'done')
			mut data := vphp.PhpArray.new()
			data.bool('done', true)
			data.string('model', model)
			done_event.string('data', data.to_json_with_flags(256))
			events.push(done_event)
			done_event.release()
			break
		}
	}
	return events
}

fn ollama_text_chunks(rows vphp.PhpArray) vphp.PhpArray {
	mut chunks := vphp.PhpArray.new()
	for row in rows.value_items() {
		piece := ollama_row_piece(row)
		if piece != '' {
			chunks.push_string(piece)
		}
		if row.bool_at('done', false) {
			break
		}
	}
	return chunks
}

fn ollama_row_piece(row vphp.PhpValue) string {
	message := row.value_at('message')
	content := message.raw_string_at('content', '')
	if content != '' {
		return content
	}
	return row.raw_string_at('response', '')
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

fn new_string_map(input map[string]string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	for key, value in input {
		out.string(key, value)
	}
	return out
}

pub fn (c &VSlimStreamOllamaClient) free() {
	unsafe {
		c.chat_url.free()
		c.default_model.free()
		c.api_key.free()
		c.fixture_path.free()
	}
}

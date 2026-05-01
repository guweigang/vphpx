module main

import os
import vphp

@[php_method]
pub fn VSlimStreamFactory.text(chunks vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').static_method_request_owned('text',
		vphp.PhpValue.from_zval(chunks.to_zval()))
}

@[php_arg_name: 'content_type=contentType']
@[php_method: 'textWith']
pub fn VSlimStreamFactory.text_with(chunks vphp.RequestBorrowedZBox, status int, content_type string, headers vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	mut content_type_arg := vphp.PhpString.of(content_type)
	defer {
		content_type_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').static_method_request_owned('textWith',
		vphp.PhpValue.from_zval(chunks.to_zval()), status_arg, content_type_arg,
		vphp.PhpValue.from_zval(headers.to_zval()))
}

@[php_method]
pub fn VSlimStreamFactory.sse(events vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').static_method_request_owned('sse',
		vphp.PhpValue.from_zval(events.to_zval()))
}

@[php_method: 'sseWith']
pub fn VSlimStreamFactory.sse_with(events vphp.RequestBorrowedZBox, status int, headers vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').static_method_request_owned('sseWith',
		vphp.PhpValue.from_zval(events.to_zval()), status_arg, vphp.PhpValue.from_zval(headers.to_zval()))
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'ollamaText']
pub fn VSlimStreamFactory.ollama_text(request_payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return VSlimStreamOllamaClient.from_env().text_response_from_request(request_payload)
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'ollamaTextWith']
pub fn VSlimStreamFactory.ollama_text_with(request_payload vphp.RequestBorrowedZBox, options vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return VSlimStreamOllamaClient.from_options(options).text_response_from_request(request_payload)
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'ollamaSse']
pub fn VSlimStreamFactory.ollama_sse(request_payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return VSlimStreamOllamaClient.from_env().sse_response_from_request(request_payload)
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'ollamaSseWith']
pub fn VSlimStreamFactory.ollama_sse_with(request_payload vphp.RequestBorrowedZBox, options vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return VSlimStreamOllamaClient.from_options(options).sse_response_from_request(request_payload)
}

@[php_method]
pub fn VSlimStreamNdjsonDecoder.decode(stream vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(decode_ndjson_rows(stream.to_zval()))
}

@[php_method: 'fromOllama']
pub fn VSlimStreamSseEncoder.from_ollama(rows vphp.RequestBorrowedZBox, model string) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(encode_ollama_sse_events(rows.to_zval(), model))
}

@[php_arg_name: 'chat_url=chatUrl,default_model=defaultModel,api_key=apiKey,fixture_path=fixturePath']
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
	out.construct(os.getenv('OLLAMA_CHAT_URL'), os.getenv('OLLAMA_MODEL'), os.getenv('OLLAMA_API_KEY'),
		os.getenv('OLLAMA_STREAM_FIXTURE'))
	return out
}

@[php_method: 'fromConfig']
pub fn VSlimStreamOllamaClient.from_config(config &VSlimConfig) &VSlimStreamOllamaClient {
	mut out := &VSlimStreamOllamaClient{}
	out.construct(config.get_string('stream.ollama.chat_url', os.getenv('OLLAMA_CHAT_URL')),
		config.get_string('stream.ollama.model', os.getenv('OLLAMA_MODEL')), config.get_string('stream.ollama.api_key',
		os.getenv('OLLAMA_API_KEY')), config.get_string('stream.ollama.fixture', os.getenv('OLLAMA_STREAM_FIXTURE')))
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
pub fn VSlimStreamOllamaClient.from_options(options vphp.RequestBorrowedZBox) &VSlimStreamOllamaClient {
	base := VSlimStreamOllamaClient.from_env()
	mut out := &VSlimStreamOllamaClient{}
	raw_options := options.to_zval()
	out.construct(zval_string_key(raw_options, 'chat_url', base.chat_url_value()), zval_string_key(raw_options,
		'model', base.default_model_value()), zval_string_key(raw_options, 'api_key',
		base.api_key_value()), zval_string_key(raw_options, 'fixture', base.fixture_path_value()))
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
pub fn (c &VSlimStreamOllamaClient) payload(input vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_input := input.to_zval()
	query := zval_key(raw_input, 'query')
	body_input := zval_key(raw_input, 'body')
	body := decode_ollama_body_payload(body_input)
	prompt := first_non_empty([
		zval_string_key(query, 'prompt', ''),
		zval_string_key(body, 'prompt', ''),
		'Explain VSlim streaming in one paragraph.',
	])
	model := first_non_empty([
		zval_string_key(query, 'model', ''),
		zval_string_key(body, 'model', ''),
		c.default_model_value(),
	])
	messages := normalize_ollama_messages(body, prompt)
	return vphp.RequestOwnedZBox.adopt_zval(new_ollama_payload(prompt, model, messages))
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'payloadFromRequest']
pub fn (c &VSlimStreamOllamaClient) payload_from_request(request_payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	req := normalize_ollama_source_request(request_payload)
	return c.payload_from_vslim_request(req)
}

@[php_method: 'openStream']
pub fn (c &VSlimStreamOllamaClient) open_stream(payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_payload := payload.to_zval()
	fixture := c.fixture_path_value()
	if fixture != '' {
		mut fixture_arg := vphp.PhpString.of(fixture)
		mut mode_arg := vphp.PhpString.of('r')
		defer {
			fixture_arg.release()
			mode_arg.release()
		}
		mut fp := vphp.PhpFunction.named('fopen').request_owned(fixture_arg, mode_arg)
		defer {
			fp.release()
		}
		if fp.to_zval().is_stream_resource() {
			return vphp.RequestOwnedZBox.adopt_zval(new_open_stream_result(true, fp.to_zval(),
				'', 200, 'fixture://' + fixture))
		}
		mut null_stream := vphp.PhpNull.value()
		return vphp.RequestOwnedZBox.adopt_zval(new_open_stream_result(false, null_stream.take_zval(),
			'failed to open stream fixture: ' + fixture, 500, 'fixture://' + fixture))
	}

	mut request_body := new_array()
	request_body.string('model', zval_string_key(raw_payload, 'model', c.default_model_value()))
	request_body.bool('stream', true)
	request_body.set('messages', vphp.PhpValue.from_zval(zval_key(raw_payload, 'messages')))
	encoded := request_body.to_json_with_flags(256)
	if encoded == '' {
		mut null_stream := vphp.PhpNull.value()
		return vphp.RequestOwnedZBox.adopt_zval(new_open_stream_result(false, null_stream.take_zval(),
			'failed to encode request payload', 500, c.chat_url_value()))
	}

	headers := new_array()
	headers.push_string('Content-Type: application/json')
	headers.push_string('Accept: application/x-ndjson')
	if c.api_key_value() != '' {
		headers.push_string('Authorization: Bearer ' + c.api_key_value())
	}

	mut http_options := new_array()
	http_options.string('method', 'POST')
	http_options.string('header', implode_lines(headers.to_zval()))
	http_options.string('content', encoded)
	http_options.int('timeout', 300)
	http_options.bool('ignore_errors', true)
	mut ctx_opts := new_array()
	ctx_opts.set('http', http_options)
	http_options.release()
	mut ctx := vphp.PhpFunction.named('stream_context_create').request_owned(ctx_opts)
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
	mut fp := vphp.PhpFunction.named('fopen').request_owned(url_arg, mode_arg, use_include_path_arg,
		vphp.PhpValue.from_zval(ctx.to_zval()))
	defer {
		fp.release()
	}
	if !fp.to_zval().is_stream_resource() {
		mut null_stream := vphp.PhpNull.value()
		return vphp.RequestOwnedZBox.adopt_zval(new_open_stream_result(false, null_stream.take_zval(),
			'failed to open upstream stream: ' + c.chat_url_value(), 502, c.chat_url_value()))
	}

	status := read_last_http_status()
	if status < 200 || status >= 300 {
		err := (fp.to_zval().stream_get_contents() or { '' }).trim_space()
		if fp.to_zval().is_stream_resource() {
			_ = fp.to_zval().stream_close()
		}
		mut null_stream := vphp.PhpNull.value()
		return vphp.RequestOwnedZBox.adopt_zval(new_open_stream_result(false, null_stream.take_zval(),
			if err != '' { err } else { 'upstream status ${status}' }, status, c.chat_url_value()))
	}

	return vphp.RequestOwnedZBox.adopt_zval(new_open_stream_result(true, fp.take_zval(),
		'', status, c.chat_url_value()))
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'textResponseFromRequest']
pub fn (c &VSlimStreamOllamaClient) text_response_from_request(request_payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	req := normalize_ollama_source_request(request_payload)
	payload := c.payload_from_vslim_request(req)
	upstream := c.open_stream(vphp.RequestBorrowedZBox.of(payload.to_zval()))
	upstream_raw := upstream.to_zval()
	if !zval_bool_key(upstream_raw, 'ok') {
		return vphp.RequestOwnedZBox.adopt_zval(upstream_error_response(upstream_raw))
	}
	rows := decode_ndjson_rows(zval_key(upstream_raw, 'stream'))
	chunks := ollama_text_chunks(rows)
	headers := new_ollama_response_headers(payload.to_zval(), upstream_raw)
	mut status_arg := vphp.PhpInt.of(200)
	mut content_type_arg := vphp.PhpString.of('text/plain; charset=utf-8')
	defer {
		status_arg.release()
		content_type_arg.release()
	}
	mut response := vphp.PhpClass.named('VSlim\\Stream\\Response').static_method_request_owned('textWith',
		vphp.PhpValue.from_zval(chunks), status_arg, content_type_arg,
		vphp.PhpValue.from_zval(headers))
	propagate_request_trace_headers_to_object(req, vphp.RequestBorrowedZBox.from_zval(response.to_zval()))
	return response
}

@[php_arg_name: 'request_payload=requestPayload']
@[php_method: 'sseResponseFromRequest']
pub fn (c &VSlimStreamOllamaClient) sse_response_from_request(request_payload vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	req := normalize_ollama_source_request(request_payload)
	payload := c.payload_from_vslim_request(req)
	upstream := c.open_stream(vphp.RequestBorrowedZBox.of(payload.to_zval()))
	upstream_raw := upstream.to_zval()
	if !zval_bool_key(upstream_raw, 'ok') {
		return vphp.RequestOwnedZBox.adopt_zval(upstream_error_response(upstream_raw))
	}
	rows := decode_ndjson_rows(zval_key(upstream_raw, 'stream'))
	events := encode_ollama_sse_events(rows, zval_string_key(payload.to_zval(), 'model',
		c.default_model_value()))
	headers := new_ollama_response_headers(payload.to_zval(), upstream_raw)
	mut status_arg := vphp.PhpInt.of(200)
	defer {
		status_arg.release()
	}
	mut response := vphp.PhpClass.named('VSlim\\Stream\\Response').static_method_request_owned('sseWith',
		vphp.PhpValue.from_zval(events), status_arg, vphp.PhpValue.from_zval(headers))
	propagate_request_trace_headers_to_object(req, vphp.RequestBorrowedZBox.from_zval(response.to_zval()))
	return response
}

fn normalize_ollama_source_request(payload vphp.RequestBorrowedZBox) &VSlimRequest {
	raw := payload.to_zval()
	return new_vslim_request_from_psr_server_request(vphp.RequestBorrowedZBox.from_zval(raw),
		route_params_from_payload(vphp.RequestBorrowedZBox.from_zval(raw)))
}

pub fn (c &VSlimStreamOllamaClient) payload_from_vslim_request(req &VSlimRequest) vphp.RequestOwnedZBox {
	mut input := new_array()
	mut query := new_string_map(req.query_params())
	input.set('query', query)
	query.release()
	input.set('body', vphp.PhpValue.from_zval(decode_request_body_to_payload_zval(req)))
	return c.payload(input.to_borrowed_zbox())
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

fn decode_request_body_to_payload_zval(req &VSlimRequest) vphp.ZVal {
	body := req.body.trim_space()
	if body == '' {
		mut out := new_array()
		return out.take_zval()
	}
	decoded := vphp.PhpJson.decode_assoc(body)
	if decoded.is_array() {
		return decoded
	}
	mut out := new_string_map(req.parsed_body())
	return out.take_zval()
}

fn decode_ollama_body_payload(input vphp.ZVal) vphp.ZVal {
	if input.is_array() {
		return input
	}
	if input.to_string().trim_space() == '' {
		mut out := new_array()
		return out.take_zval()
	}
	decoded := vphp.PhpJson.decode_assoc(input.to_string())
	if decoded.is_array() {
		return decoded
	}
	mut out := new_array()
	return out.take_zval()
}

fn normalize_ollama_messages(body vphp.ZVal, prompt string) vphp.ZVal {
	messages := zval_key(body, 'messages')
	if messages.is_array() && messages.array_count() > 0 {
		normalized := normalize_message_rows(messages)
		if normalized.array_count() > 0 {
			return normalized
		}
	}

	mut fallback := new_array()
	system := zval_string_key(body, 'system', '')
	if system != '' {
		fallback.push(vphp.PhpValue.from_zval(new_message_row('system', system)))
	}
	fallback.push(vphp.PhpValue.from_zval(new_message_row('user', prompt)))
	return fallback.take_zval()
}

fn normalize_message_rows(rows vphp.ZVal) vphp.ZVal {
	mut normalized := new_array()
	for idx := 0; idx < rows.array_count(); idx++ {
		item := rows.array_get(idx)
		if !item.is_array() {
			continue
		}
		role := first_non_empty([
			zval_string_key(item, 'role', ''),
			'user',
		])
		content := zval_string_key(item, 'content', '')
		if content == '' {
			continue
		}
		normalized.push(vphp.PhpValue.from_zval(new_message_row(role, content)))
	}
	return normalized.take_zval()
}

fn new_message_row(role string, content string) vphp.ZVal {
	mut row := new_array()
	row.string('role', if role.trim_space() == '' { 'user' } else { role.trim_space() })
	row.string('content', content)
	return row.take_zval()
}

fn new_ollama_payload(prompt string, model string, messages vphp.ZVal) vphp.ZVal {
	mut payload := new_array()
	payload.string('prompt', prompt)
	payload.string('model', model)
	payload.set('messages', vphp.PhpValue.from_zval(messages))
	return payload.take_zval()
}

fn new_open_stream_result(ok bool, stream vphp.ZVal, error string, status int, url string) vphp.ZVal {
	mut out := new_array()
	out.bool('ok', ok)
	out.set('stream', vphp.PhpValue.from_zval(stream))
	out.string('error', error)
	out.int('status', status)
	out.string('url', url)
	return out.take_zval()
}

fn new_ollama_response_headers(payload vphp.ZVal, upstream vphp.ZVal) vphp.ZVal {
	mut headers := new_array()
	headers.string('x-ollama-model', zval_string_key(payload, 'model', ''))
	headers.string('x-ollama-url', zval_string_key(upstream, 'url', ''))
	return headers.take_zval()
}

fn upstream_error_response(upstream vphp.ZVal) vphp.ZVal {
	mut body := new_array()
	body.string('error', zval_string_key(upstream, 'error', 'failed to open upstream stream'))
	body.string('url', zval_string_key(upstream, 'url', ''))
	json := body.to_json_with_flags(256)
	mut out := new_array()
	out.int('status', zval_int_key(upstream, 'status', 502))
	out.string('content_type', 'application/json; charset=utf-8')
	out.string('body', json)
	return out.take_zval()
}

fn decode_ndjson_rows(stream vphp.ZVal) vphp.ZVal {
	mut rows := new_array()
	if !stream.is_stream_resource() {
		return rows.take_zval()
	}
	for {
		if stream.stream_eof() {
			break
		}
		line_raw := stream.stream_read_line() or { '' }
		line := line_raw.trim_space()
		if line == '' {
			if line_raw == '' && stream.stream_eof() {
				break
			}
			continue
		}
		row := vphp.PhpJson.decode_assoc(line)
		if !row.is_array() {
			continue
		}
		rows.push(vphp.PhpValue.from_zval(row))
		if zval_bool_key(row, 'done') {
			break
		}
	}
	if stream.is_stream_resource() {
		_ = stream.stream_close()
	}
	return rows.take_zval()
}

fn encode_ollama_sse_events(rows vphp.ZVal, model string) vphp.ZVal {
	mut events := new_array()
	mut index := 0
	for row in zval_array_items(rows) {
		piece := ollama_row_piece(row)
		if piece != '' {
			index++
			mut event := new_array()
			event.string('id', 'tok-${index}')
			event.string('event', 'token')
			event.int('retry', 1000)
			mut data := new_array()
			data.int('index', index)
			data.string('token', piece)
			data.string('model', model)
			event.string('data', data.to_json_with_flags(256))
			events.push(event)
			event.release()
		}
		if zval_bool_key(row, 'done') {
			mut done_event := new_array()
			done_event.string('event', 'done')
			mut data := new_array()
			data.bool('done', true)
			data.string('model', model)
			done_event.string('data', data.to_json_with_flags(256))
			events.push(done_event)
			done_event.release()
			break
		}
	}
	return events.take_zval()
}

fn ollama_text_chunks(rows vphp.ZVal) vphp.ZVal {
	mut chunks := new_array()
	for row in zval_array_items(rows) {
		piece := ollama_row_piece(row)
		if piece != '' {
			chunks.push_string(piece)
		}
		if zval_bool_key(row, 'done') {
			break
		}
	}
	return chunks.take_zval()
}

fn ollama_row_piece(row vphp.ZVal) string {
	message := zval_key(row, 'message')
	content := zval_raw_string_key(message, 'content', '')
	if content != '' {
		return content
	}
	return zval_raw_string_key(row, 'response', '')
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

fn implode_lines(lines vphp.ZVal) string {
	mut parts := []string{}
	for item in zval_array_items(lines) {
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

fn new_array() vphp.PhpArray {
	return vphp.PhpArray.empty()
}

fn new_string_map(input map[string]string) vphp.PhpArray {
	mut out := new_array()
	for key, value in input {
		out.string(key, value)
	}
	return out
}

fn zval_key(input vphp.ZVal, key string) vphp.ZVal {
	return input.get(key) or { vphp.RequestOwnedZBox.new_null().to_zval() }
}

fn zval_string_key(input vphp.ZVal, key string, default_value string) string {
	raw := input.get(key) or { return default_value }
	text := raw.to_string().trim_space()
	return if text == '' { default_value } else { text }
}

fn zval_raw_string_key(input vphp.ZVal, key string, default_value string) string {
	raw := input.get(key) or { return default_value }
	return raw.to_string()
}

fn zval_int_key(input vphp.ZVal, key string, default_value int) int {
	raw := input.get(key) or { return default_value }
	if raw.is_string() {
		text := raw.to_string().trim_space()
		return if text == '' { default_value } else { text.int() }
	}
	return int(raw.to_i64())
}

fn zval_bool_key(input vphp.ZVal, key string) bool {
	raw := input.get(key) or { return false }
	if raw.is_bool() {
		return raw.to_bool()
	}
	if raw.is_long() {
		return raw.to_i64() != 0
	}
	return raw.to_string().trim_space().to_lower() in ['1', 'true', 'yes', 'on']
}

fn zval_array_items(input vphp.ZVal) []vphp.ZVal {
	mut out := []vphp.ZVal{}
	if !input.is_array() {
		return out
	}
	for idx := 0; idx < input.array_count(); idx++ {
		out << input.array_get(idx)
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

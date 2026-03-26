module main

import os
import vphp

@[php_method]
pub fn VSlimStreamFactory.text(chunks vphp.ZVal) vphp.ZVal {
	return vphp.php_class('VSlim\\Stream\\Response').static_method_owned_request('text', [
		chunks,
	])
}

@[php_method]
pub fn VSlimStreamFactory.text_with(chunks vphp.ZVal, status int, content_type string, headers vphp.ZVal) vphp.ZVal {
	return vphp.php_class('VSlim\\Stream\\Response').static_method_owned_request('text_with', [
		chunks,
		vphp.RequestOwnedZVal.new_int(status).to_zval(),
		vphp.RequestOwnedZVal.new_string(content_type).to_zval(),
		headers,
	])
}

@[php_method]
pub fn VSlimStreamFactory.sse(events vphp.ZVal) vphp.ZVal {
	return vphp.php_class('VSlim\\Stream\\Response').static_method_owned_request('sse', [
		events,
	])
}

@[php_method]
pub fn VSlimStreamFactory.sse_with(events vphp.ZVal, status int, headers vphp.ZVal) vphp.ZVal {
	return vphp.php_class('VSlim\\Stream\\Response').static_method_owned_request('sse_with', [
		events,
		vphp.RequestOwnedZVal.new_int(status).to_zval(),
		headers,
	])
}

@[php_method]
pub fn VSlimStreamFactory.ollama_text(req &VSlimRequest) vphp.ZVal {
	return VSlimStreamOllamaClient.from_env().text_response_from_request(req)
}

@[php_method]
pub fn VSlimStreamFactory.ollama_text_with(req &VSlimRequest, options vphp.ZVal) vphp.ZVal {
	return VSlimStreamOllamaClient.from_options(options).text_response_from_request(req)
}

@[php_method]
pub fn VSlimStreamFactory.ollama_sse(req &VSlimRequest) vphp.ZVal {
	return VSlimStreamOllamaClient.from_env().sse_response_from_request(req)
}

@[php_method]
pub fn VSlimStreamFactory.ollama_sse_with(req &VSlimRequest, options vphp.ZVal) vphp.ZVal {
	return VSlimStreamOllamaClient.from_options(options).sse_response_from_request(req)
}

@[php_method]
pub fn VSlimStreamNdjsonDecoder.decode(stream vphp.ZVal) vphp.ZVal {
	return decode_ndjson_rows(stream)
}

@[php_method]
pub fn VSlimStreamSseEncoder.from_ollama(rows vphp.ZVal, model string) vphp.ZVal {
	return encode_ollama_sse_events(rows, model)
}

@[php_method]
pub fn (mut c VSlimStreamOllamaClient) construct(chat_url string, default_model string, api_key string, fixture_path string) &VSlimStreamOllamaClient {
	c.chat_url = normalize_ollama_chat_url(chat_url)
	c.default_model = normalize_ollama_model(default_model)
	c.api_key = api_key.trim_space()
	c.fixture_path = fixture_path.trim_space()
	return &c
}

@[php_method]
pub fn VSlimStreamOllamaClient.from_env() &VSlimStreamOllamaClient {
	mut out := &VSlimStreamOllamaClient{}
	out.construct(
		os.getenv('OLLAMA_CHAT_URL'),
		os.getenv('OLLAMA_MODEL'),
		os.getenv('OLLAMA_API_KEY'),
		os.getenv('OLLAMA_STREAM_FIXTURE'),
	)
	return out
}

@[php_method]
pub fn VSlimStreamOllamaClient.from_options(options vphp.ZVal) &VSlimStreamOllamaClient {
	base := VSlimStreamOllamaClient.from_env()
	mut out := &VSlimStreamOllamaClient{}
	out.construct(
		zval_string_key(options, 'chat_url', base.chat_url_value()),
		zval_string_key(options, 'model', base.default_model_value()),
		zval_string_key(options, 'api_key', base.api_key_value()),
		zval_string_key(options, 'fixture', base.fixture_path_value()),
	)
	return out
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) chat_url() string {
	return c.chat_url_value()
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) default_model() string {
	return c.default_model_value()
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) api_key() string {
	return c.api_key_value()
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) fixture_path() string {
	return c.fixture_path_value()
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) payload(input vphp.ZVal) vphp.ZVal {
	query := zval_key(input, 'query')
	body_input := zval_key(input, 'body')
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
	return new_ollama_payload(prompt, model, messages)
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) payload_from_request(req &VSlimRequest) vphp.ZVal {
	mut input := new_array_zval()
	add_assoc_zval(input, 'query', new_string_map_zval(req.query_params()))
	add_assoc_zval(input, 'body', decode_request_body_to_payload_zval(req))
	return c.payload(input)
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) open_stream(payload vphp.ZVal) vphp.ZVal {
	fixture := c.fixture_path_value()
	if fixture != '' {
		fp := vphp.call_php('fopen', [
			vphp.RequestOwnedZVal.new_string(fixture).to_zval(),
			vphp.RequestOwnedZVal.new_string('r').to_zval(),
		])
		if fp.is_resource() {
			return new_open_stream_result(true, fp, '', 200, 'fixture://' + fixture)
		}
		return new_open_stream_result(false, vphp.RequestOwnedZVal.new_null().to_zval(), 'failed to open stream fixture: ' + fixture, 500, 'fixture://' + fixture)
	}

	mut request_body := new_array_zval()
	request_body.add_assoc_string('model', zval_string_key(payload, 'model', c.default_model_value()))
	request_body.add_assoc_bool('stream', true)
	add_assoc_zval(request_body, 'messages', zval_key(payload, 'messages'))
	encoded := vphp.call_php('json_encode', [
		request_body,
		vphp.RequestOwnedZVal.new_int(256).to_zval(),
	])
	if !encoded.is_valid() || encoded.to_string() == '' {
		return new_open_stream_result(false, vphp.RequestOwnedZVal.new_null().to_zval(), 'failed to encode request payload', 500, c.chat_url_value())
	}

	headers := new_array_zval()
	headers.push_string('Content-Type: application/json')
	headers.push_string('Accept: application/x-ndjson')
	if c.api_key_value() != '' {
		headers.push_string('Authorization: Bearer ' + c.api_key_value())
	}

	mut http_options := new_array_zval()
	http_options.add_assoc_string('method', 'POST')
	http_options.add_assoc_string('header', implode_lines(headers))
	http_options.add_assoc_string('content', encoded.to_string())
	http_options.add_assoc_long('timeout', 300)
	http_options.add_assoc_bool('ignore_errors', true)
	mut ctx_opts := new_array_zval()
	add_assoc_zval(ctx_opts, 'http', http_options)
	ctx := vphp.call_php('stream_context_create', [ctx_opts])
	fp := vphp.call_php('fopen', [
		vphp.RequestOwnedZVal.new_string(c.chat_url_value()).to_zval(),
		vphp.RequestOwnedZVal.new_string('r').to_zval(),
		vphp.RequestOwnedZVal.new_bool(false).to_zval(),
		ctx,
	])
	if !fp.is_resource() {
		return new_open_stream_result(false, vphp.RequestOwnedZVal.new_null().to_zval(), 'failed to open upstream stream: ' + c.chat_url_value(), 502, c.chat_url_value())
	}

	status := read_last_http_status()
	if status < 200 || status >= 300 {
		err := vphp.call_php('stream_get_contents', [fp]).to_string().trim_space()
		if fp.is_resource() {
			_ = vphp.call_php('fclose', [fp])
		}
		return new_open_stream_result(false, vphp.RequestOwnedZVal.new_null().to_zval(), if err != '' { err } else { 'upstream status ${status}' }, status, c.chat_url_value())
	}

	return new_open_stream_result(true, fp, '', status, c.chat_url_value())
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) text_response_from_request(req &VSlimRequest) vphp.ZVal {
	payload := c.payload_from_request(req)
	upstream := c.open_stream(payload)
	if !zval_bool_key(upstream, 'ok') {
		return upstream_error_response(upstream)
	}
	rows := decode_ndjson_rows(zval_key(upstream, 'stream'))
	chunks := ollama_text_chunks(rows)
	headers := new_ollama_response_headers(payload, upstream)
	mut response := vphp.php_class('VSlim\\Stream\\Response').static_method_owned_request('text_with', [
		chunks,
		vphp.RequestOwnedZVal.new_int(200).to_zval(),
		vphp.RequestOwnedZVal.new_string('text/plain; charset=utf-8').to_zval(),
		headers,
	])
	propagate_request_trace_headers_to_object(req, vphp.BorrowedZVal.from_zval(response))
	return response
}

@[php_method]
pub fn (c &VSlimStreamOllamaClient) sse_response_from_request(req &VSlimRequest) vphp.ZVal {
	payload := c.payload_from_request(req)
	upstream := c.open_stream(payload)
	if !zval_bool_key(upstream, 'ok') {
		return upstream_error_response(upstream)
	}
	rows := decode_ndjson_rows(zval_key(upstream, 'stream'))
	events := encode_ollama_sse_events(rows, zval_string_key(payload, 'model', c.default_model_value()))
	headers := new_ollama_response_headers(payload, upstream)
	mut response := vphp.php_class('VSlim\\Stream\\Response').static_method_owned_request('sse_with', [
		events,
		vphp.RequestOwnedZVal.new_int(200).to_zval(),
		headers,
	])
	propagate_request_trace_headers_to_object(req, vphp.BorrowedZVal.from_zval(response))
	return response
}

fn (c &VSlimStreamOllamaClient) chat_url_value() string {
	return normalize_ollama_chat_url(c.chat_url)
}

fn (c &VSlimStreamOllamaClient) default_model_value() string {
	return normalize_ollama_model(c.default_model)
}

fn (c &VSlimStreamOllamaClient) api_key_value() string {
	return c.api_key.trim_space()
}

fn (c &VSlimStreamOllamaClient) fixture_path_value() string {
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
		return new_array_zval()
	}
	decoded := vphp.php_fn('json_decode').call_owned_request([
		vphp.RequestOwnedZVal.new_string(body).to_zval(),
		vphp.RequestOwnedZVal.new_bool(true).to_zval(),
	])
	if decoded.is_array() {
		return decoded
	}
	return new_string_map_zval(req.parsed_body())
}

fn decode_ollama_body_payload(input vphp.ZVal) vphp.ZVal {
	if input.is_array() {
		return input
	}
	if input.to_string().trim_space() == '' {
		return new_array_zval()
	}
	decoded := vphp.php_fn('json_decode').call_owned_request([
		vphp.RequestOwnedZVal.new_string(input.to_string()).to_zval(),
		vphp.RequestOwnedZVal.new_bool(true).to_zval(),
	])
	if decoded.is_array() {
		return decoded
	}
	return new_array_zval()
}

fn normalize_ollama_messages(body vphp.ZVal, prompt string) vphp.ZVal {
	messages := zval_key(body, 'messages')
	if messages.is_array() && messages.array_count() > 0 {
		normalized := normalize_message_rows(messages)
		if normalized.array_count() > 0 {
			return normalized
		}
	}

	mut fallback := new_array_zval()
	system := zval_string_key(body, 'system', '')
	if system != '' {
		fallback.add_next_val(new_message_row('system', system))
	}
	fallback.add_next_val(new_message_row('user', prompt))
	return fallback
}

fn normalize_message_rows(rows vphp.ZVal) vphp.ZVal {
	mut normalized := new_array_zval()
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
		normalized.add_next_val(new_message_row(role, content))
	}
	return normalized
}

fn new_message_row(role string, content string) vphp.ZVal {
	mut row := new_array_zval()
	row.add_assoc_string('role', if role.trim_space() == '' { 'user' } else { role.trim_space() })
	row.add_assoc_string('content', content)
	return row
}

fn new_ollama_payload(prompt string, model string, messages vphp.ZVal) vphp.ZVal {
	mut payload := new_array_zval()
	payload.add_assoc_string('prompt', prompt)
	payload.add_assoc_string('model', model)
	add_assoc_zval(payload, 'messages', messages)
	return payload
}

fn new_open_stream_result(ok bool, stream vphp.ZVal, error string, status int, url string) vphp.ZVal {
	mut out := new_array_zval()
	out.add_assoc_bool('ok', ok)
	add_assoc_zval(out, 'stream', stream)
	out.add_assoc_string('error', error)
	out.add_assoc_long('status', status)
	out.add_assoc_string('url', url)
	return out
}

fn new_ollama_response_headers(payload vphp.ZVal, upstream vphp.ZVal) vphp.ZVal {
	mut headers := new_array_zval()
	headers.add_assoc_string('x-ollama-model', zval_string_key(payload, 'model', ''))
	headers.add_assoc_string('x-ollama-url', zval_string_key(upstream, 'url', ''))
	return headers
}

fn upstream_error_response(upstream vphp.ZVal) vphp.ZVal {
	mut body := new_array_zval()
	body.add_assoc_string('error', zval_string_key(upstream, 'error', 'failed to open upstream stream'))
	body.add_assoc_string('url', zval_string_key(upstream, 'url', ''))
	json := vphp.call_php('json_encode', [
		body,
		vphp.RequestOwnedZVal.new_int(256).to_zval(),
	])
	mut out := new_array_zval()
	out.add_assoc_long('status', zval_int_key(upstream, 'status', 502))
	out.add_assoc_string('content_type', 'application/json; charset=utf-8')
	out.add_assoc_string('body', json.to_string())
	return out
}

fn decode_ndjson_rows(stream vphp.ZVal) vphp.ZVal {
	mut rows := new_array_zval()
	if !stream.is_resource() {
		return rows
	}
	for {
		is_eof := vphp.call_php('feof', [stream])
		if is_eof.is_valid() && is_eof.to_bool() {
			break
		}
		line_raw := vphp.call_php('fgets', [stream])
		line := line_raw.to_string().trim_space()
		if line == '' {
			if !line_raw.is_valid() || line_raw.is_null() {
				break
			}
			continue
		}
		row := vphp.php_fn('json_decode').call_owned_request([
			vphp.RequestOwnedZVal.new_string(line).to_zval(),
			vphp.RequestOwnedZVal.new_bool(true).to_zval(),
		])
		if !row.is_array() {
			continue
		}
		rows.add_next_val(row)
		if zval_bool_key(row, 'done') {
			break
		}
	}
	if stream.is_resource() {
		_ = vphp.call_php('fclose', [stream])
	}
	return rows
}

fn encode_ollama_sse_events(rows vphp.ZVal, model string) vphp.ZVal {
	mut events := new_array_zval()
	mut index := 0
	for row in zval_array_items(rows) {
		piece := ollama_row_piece(row)
		if piece != '' {
			index++
			mut event := new_array_zval()
			event.add_assoc_string('id', 'tok-${index}')
			event.add_assoc_string('event', 'token')
			event.add_assoc_long('retry', 1000)
			mut data := new_array_zval()
			data.add_assoc_long('index', index)
			data.add_assoc_string('token', piece)
			data.add_assoc_string('model', model)
			event.add_assoc_string('data', json_encode_zval(data))
			events.add_next_val(event)
		}
		if zval_bool_key(row, 'done') {
			mut done_event := new_array_zval()
			done_event.add_assoc_string('event', 'done')
			mut data := new_array_zval()
			data.add_assoc_bool('done', true)
			data.add_assoc_string('model', model)
			done_event.add_assoc_string('data', json_encode_zval(data))
			events.add_next_val(done_event)
			break
		}
	}
	return events
}

fn ollama_text_chunks(rows vphp.ZVal) vphp.ZVal {
	mut chunks := new_array_zval()
	for row in zval_array_items(rows) {
		piece := ollama_row_piece(row)
		if piece != '' {
			chunks.push_string(piece)
		}
		if zval_bool_key(row, 'done') {
			break
		}
	}
	return chunks
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
	if !vphp.function_exists('http_get_last_response_headers') {
		return 200
	}
	headers := vphp.call_php('http_get_last_response_headers', [])
	if !headers.is_array() || headers.array_count() == 0 {
		return 200
	}
	line := headers.array_get(0).to_string()
	parts := line.split(' ')
	for part in parts {
		clean := part.trim_space()
		if clean.len == 3 && clean[0].is_digit() && clean[1].is_digit() && clean[2].is_digit() {
			return clean.int()
		}
	}
	return 200
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

fn json_encode_zval(input vphp.ZVal) string {
	return vphp.call_php('json_encode', [
		input,
		vphp.RequestOwnedZVal.new_int(256).to_zval(),
	]).to_string()
}

fn new_array_zval() vphp.ZVal {
	mut out := vphp.RequestOwnedZVal.new_null().to_zval()
	out.array_init()
	return out
}

fn new_string_map_zval(input map[string]string) vphp.ZVal {
	mut out := new_array_zval()
	for key, value in input {
		out.add_assoc_string(key, value)
	}
	return out
}

fn add_assoc_zval(target vphp.ZVal, key string, child vphp.ZVal) {
	unsafe {
		C.vphp_array_add_assoc_zval(target.raw, &char(key.str), child.raw)
	}
}

fn zval_key(input vphp.ZVal, key string) vphp.ZVal {
	return input.get(key) or { vphp.RequestOwnedZVal.new_null().to_zval() }
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

fn (mut c VSlimStreamOllamaClient) free() {
	unsafe {
		c.chat_url.free()
		c.default_model.free()
		c.api_key.free()
		c.fixture_path.free()
	}
}

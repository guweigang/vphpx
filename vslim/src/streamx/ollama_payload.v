module streamx

import httpx
import vphp

@[php_method]
pub fn (c &VSlimStreamOllamaClient) payload(input vphp.PhpArray) vphp.PhpArray {
	query := input['query']
	body_input := input['body']
	body := value_subject(body_input).ollama_body_payload()
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
	req := c.request_from_ollama_source(request_payload)
	return c.payload_from_vslim_request(req)
}

pub fn (c &VSlimStreamOllamaClient) request_from_ollama_source(payload vphp.PhpValue) &httpx.VSlimRequest {
	_ = c
	return stream_request_from_payload(payload)
}

pub fn (c &VSlimStreamOllamaClient) payload_from_vslim_request(req &httpx.VSlimRequest) vphp.PhpArray {
	mut input := vphp.PhpArray.new()
	mut query := new_string_map(req.query_params())
	input.set('query', query)
	query.release()
	mut body := vslim_request_decode_body_payload(req)
	input.set('body', body)
	body.release()
	return c.payload(input)
}

fn first_non_empty(values []string) string {
	for value in values {
		if value.trim_space() != '' {
			return value.trim_space()
		}
	}
	return ''
}

fn vslim_request_decode_body_payload(req &httpx.VSlimRequest) vphp.PhpArray {
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

fn stream_request_from_payload(payload vphp.PhpValue) &httpx.VSlimRequest {
	if object := payload.as_object() {
		if object.is_instance_of('VSlim\\VHttpd\\Request') || object.is_instance_of('VSlimRequest') {
			if req := object.to_v_object[httpx.VSlimRequest]() {
				return req.boxed_snapshot()
			}
		}
		if object.method_exists('getMethod') || object.method_exists('getRequestTarget') {
			return stream_request_from_psr_object(object)
		}
	}
	return httpx.VSlimRequest.from_value(payload)
}

fn stream_request_from_psr_object(request vphp.PhpObject) &httpx.VSlimRequest {
	method := if request.method_exists('getMethod') {
		request.with_method_result[vphp.PhpString, string]('getMethod', fn (z vphp.PhpString) string {
			return z.value()
		}) or { 'GET' }
	} else {
		'GET'
	}
	mut target := if request.method_exists('getRequestTarget') {
		request.with_method_result[vphp.PhpString, string]('getRequestTarget', fn (z vphp.PhpString) string {
			return z.value()
		}) or { '' }
	} else {
		''
	}
	if target == '' && request.method_exists('getUri') {
		mut uri_value := request.call_method('getUri')
		defer {
			uri_value.release()
		}
		target = httpx.VSlimPsr7Uri.from_value(uri_value).str()
	}
	if target == '' {
		target = '/'
	}
	body := if request.method_exists('getBody') {
		request.with_method_result[vphp.PhpValue, string]('getBody', fn (z vphp.PhpValue) string {
			return httpx.VSlimPsr7Stream.from_value(z).stream_string()
		}) or { '' }
	} else {
		''
	}
	mut out := httpx.VSlimRequest.new(method, target, body)
	if request.method_exists('getHeaders') {
		mut headers_value := request.call_method('getHeaders')
		defer {
			headers_value.release()
		}
		headers, _ := httpx.psr7_header_state_from_value(headers_value)
		out.headers = httpx.flatten_psr7_header_map(headers)
	}
	if request.method_exists('getQueryParams') {
		mut query_value := request.call_method('getQueryParams')
		defer {
			query_value.release()
		}
		if query := query_value.as_array() {
			out.query = httpx.snapshot_string_map(query.to_string_map())
		}
	}
	if request.method_exists('getParsedBody') {
		mut parsed_value := request.call_method('getParsedBody')
		defer {
			parsed_value.release()
		}
		if parsed := parsed_value.as_array() {
			out.set_body(parsed.to_json_with_flags(256))
		}
	}
	return out
}

fn (subject PhpValueSubject) ollama_body_payload() vphp.PhpArray {
	input := subject.value
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

fn new_string_map(input map[string]string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	for key, value in input {
		out.string(key, value)
	}
	return out
}

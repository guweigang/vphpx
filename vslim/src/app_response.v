module main

import vphp

fn resolve_effective_method(req &VSlimRequest) string {
	method := req.method.to_upper()
	if method != 'POST' {
		return method
	}
	mut override := req.header('x-http-method-override').trim_space().to_upper()
	if override == '' {
		override = req.query('_method').trim_space().to_upper()
	}
	if override == '' {
		override = parse_body_method_override(req.body)
	}
	allowed := ['PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS']
	if override in allowed {
		return override
	}
	return method
}

fn parse_body_method_override(body string) string {
	if body == '' {
		return ''
	}
	for pair in body.split('&') {
		if !pair.starts_with('_method=') {
			continue
		}
		return pair.all_after('_method=').trim_space().to_upper()
	}
	return ''
}

fn normalize_php_route_response_value(result vphp.PhpValue) (VSlimResponse, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return text_response(200, ''), true
	}
	if object := result.as_object() {
		if object.is_instance_of('VSlim\\Psr7\\Response')
			|| object.is_instance_of('VSlimPsr7Response') {
			if psr := object.to_v_object[VSlimPsr7Response]() {
				cli_debug_log('normalize.response.vslim_psr status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
				return new_vslim_response_from_psr_response(psr), true
			}
		}
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			psr := normalize_to_psr7_response_value(result)
			body := psr7_stream_string(response_body_or_empty(psr))
			cli_debug_log('normalize.response.psr status=${psr.get_status_code()} body_len=${body.len}')
			return VSlimResponse{
				status:       psr.get_status_code()
				body:         body
				content_type: psr.get_header_line_name('content-type')
				headers:      snapshot_string_map(flatten_psr7_header_map(psr.get_headers()))
			}, true
		}
		if object.is_instance_of('VSlim\\VHttpd\\Response')
			|| object.is_instance_of('VSlimResponse') {
			if resp := object.to_v_object[VSlimResponse]() {
				return VSlimResponse{
					status:       resp.status
					body:         resp.body
					content_type: resp.content_type
					headers:      resp.headers()
				}, true
			}
		}
	}
	if result.is_string() {
		return text_response(200, result.to_string()), true
	}
	if arr := result.as_array() {
		mut headers := map[string]string{}
		if headers_value := arr.value('headers') {
			if headers_array := headers_value.as_array() {
				for name in headers_array.assoc_keys() {
					headers[name] = headers_array[name].to_string()
				}
			}
		}
		status := arr.int_at('status', 200)
		body := arr.string_at('body', '')
		content_type := arr.string_at('content_type', headers['content-type'] or {
			'text/plain; charset=utf-8'
		})
		if 'content-type' !in headers {
			headers['content-type'] = content_type
		}
		return VSlimResponse{
			status:       status
			body:         body
			content_type: headers['content-type'] or { '' }
			headers:      snapshot_string_map(headers)
		}, true
	}
	return VSlimResponse{}, false
}

fn normalize_php_route_response_psr_value(result vphp.PhpValue) (&VSlimPsr7Response, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return new_psr7_text_response(200, ''), true
	}
	if object := result.as_object() {
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			return normalize_to_psr7_response_value(result), true
		}
		if object.is_instance_of('VSlim\\VHttpd\\Response')
			|| object.is_instance_of('VSlimResponse') {
			if resp := object.to_v_object[VSlimResponse]() {
				return new_psr7_response_from_vslim_response(VSlimResponse{
					status:       resp.status
					body:         resp.body
					content_type: resp.content_type
					headers:      resp.headers()
				}), true
			}
		}
	}
	if result.is_string() {
		return new_psr7_text_response(200, result.to_string()), true
	}
	if arr := result.as_array() {
		mut headers := map[string][]string{}
		mut header_names := map[string]string{}
		if headers_value := arr.value('headers') {
			if headers_array := headers_value.as_array() {
				for name in headers_array.assoc_keys() {
					normalized := normalize_psr7_header_name(name)
					headers[normalized] = [headers_array[name].to_string()]
					header_names[normalized] = name
				}
			}
		}
		status := arr.int_at('status', 200)
		body := arr.string_at('body', '')
		content_type := arr.string_at('content_type', if 'content-type' in headers {
			headers['content-type'][0]
		} else {
			'text/plain; charset=utf-8'
		})
		if 'content-type' !in headers {
			headers['content-type'] = [content_type]
			header_names['content-type'] = 'content-type'
		}
		return &VSlimPsr7Response{
			status:           normalize_psr7_status(status)
			reason_phrase:    normalize_reason_phrase(status, '')
			protocol_version: '1.1'
			headers:          clone_header_values(headers)
			header_names:     header_names
			body_ref:         new_psr7_stream(body)
		}, true
	}
	return unsafe { nil }, false
}

fn normalize_php_route_response_body_value(result vphp.PhpValue) (string, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return '', true
	}
	if object := result.as_object() {
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			return psr7_stream_string(response_body_or_empty(normalize_to_psr7_response_value(result))), true
		}
		if object.is_instance_of('VSlim\\VHttpd\\Response')
			|| object.is_instance_of('VSlimResponse') {
			if resp := object.to_v_object[VSlimResponse]() {
				return resp.body, true
			}
		}
	}
	if result.is_string() {
		return result.to_string(), true
	}
	if arr := result.as_array() {
		return arr.string_at('body', ''), true
	}
	return '', false
}

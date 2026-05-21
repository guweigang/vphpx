module httpx

import vphp

fn response_from_object_props(object vphp.PhpObject) ?VSlimResponse {
	mut status_value := object.prop_value('status')
	mut body_value := object.prop_value('body')
	mut content_type_value := object.prop_value('contentType')
	mut headers_value := object.prop_value('headers')
	defer {
		status_value.release()
		body_value.release()
		content_type_value.release()
		headers_value.release()
	}
	if !status_value.is_valid() || status_value.is_null() || status_value.is_undef() {
		return none
	}
	mut headers := map[string]string{}
	if headers_array := headers_value.as_array() {
		for name in headers_array.assoc_keys() {
			headers[name] = headers_array[name].to_string()
		}
		headers_array.release()
	}
	content_type := content_type_value.to_string()
	if content_type != '' && 'content-type' !in headers {
		headers['content-type'] = content_type
	}
	return VSlimResponse{
		status:       status_value.to_int()
		body:         body_value.to_string()
		content_type: content_type
		headers:      snapshot_string_map(headers)
	}
}

pub fn VSlimResponse.from_route_result(result vphp.PhpValue) (VSlimResponse, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return VSlimResponse.text(200, ''), true
	}
	if object := result.as_object() {
		if object.is_instance_of('VSlim\\Psr7\\Response') || object.is_instance_of('VSlimPsr7') {
			if psr := object.to_v_object[VSlimPsr7Response]() {
				return psr.to_vslim_response(), true
			}
		}
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			psr := VSlimPsr7Response.from_value(result)
			body := psr.body_or_empty().stream_string()
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
			if resp := response_from_object_props(object) {
				return resp, true
			}
		}
	}
	if result.is_string() {
		return VSlimResponse.text(200, result.to_string()), true
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

pub fn VSlimPsr7Response.from_route_result(result vphp.PhpValue) (&VSlimPsr7Response, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return VSlimPsr7Response.text(200, ''), true
	}
	if object := result.as_object() {
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			return VSlimPsr7Response.from_value(result), true
		}
		if object.is_instance_of('VSlim\\VHttpd\\Response')
			|| object.is_instance_of('VSlimResponse') {
			if resp := object.to_v_object[VSlimResponse]() {
				return (VSlimResponse{
					status:       resp.status
					body:         resp.body
					content_type: resp.content_type
					headers:      resp.headers()
				}).to_psr7_response(), true
			}
			if resp := response_from_object_props(object) {
				return resp.to_psr7_response(), true
			}
		}
	}
	if result.is_string() {
		return VSlimPsr7Response.text(200, result.to_string()), true
	}
	if arr := result.as_array() {
		mut headers := map[string][]string{}
		mut header_names := map[string]string{}
		if headers_value := arr.value('headers') {
			if headers_array := headers_value.as_array() {
				for name in headers_array.assoc_keys() {
					normalized := normalize_header_name(name)
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
			status:           normalize_status(status)
			reason_phrase:    normalize_reason_phrase(status, '')
			protocol_version: '1.1'
			headers:          clone_header_values(headers)
			header_names:     header_names
			body_ref:         VSlimPsr7Stream.from_content(body)
		}, true
	}
	return unsafe { nil }, false
}

pub fn VSlimResponse.body_from_route_result(result vphp.PhpValue) (string, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return '', true
	}
	if object := result.as_object() {
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			psr := VSlimPsr7Response.from_value(result)
			return psr.body_or_empty().stream_string(), true
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

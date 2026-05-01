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

fn normalize_php_route_response_borrowed(result vphp.RequestBorrowedZBox) (VSlimResponse, bool) {
	return normalize_php_route_response(result.to_zval())
}

fn normalize_php_route_response_psr_borrowed(result vphp.RequestBorrowedZBox) (&VSlimPsr7Response, bool) {
	return normalize_php_route_response_psr(result.to_zval())
}

fn normalize_php_route_response_psr(result vphp.ZVal) (&VSlimPsr7Response, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return new_psr7_text_response(200, ''), true
	}
	if result.is_object() && result.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
		return normalize_to_psr7_response(result), true
	}
	if result.is_object()
		&& (result.is_instance_of('VSlim\\VHttpd\\Response') || result.is_instance_of('VSlimResponse')) {
		if resp := result.to_object[VSlimResponse]() {
			return new_psr7_response_from_vslim_response(VSlimResponse{
				status:       resp.status
				body:         resp.body
				content_type: resp.content_type
				headers:      resp.headers()
			}), true
		}
	}
	if result.is_string() {
		return new_psr7_text_response(200, result.get_string()), true
	}
	if result.is_array() {
		mut headers := map[string][]string{}
		mut header_names := map[string]string{}
		if h := result.get('headers') {
			headers = h.fold[map[string][]string](map[string][]string{}, fn (key vphp.ZVal, val vphp.ZVal, mut acc map[string][]string) {
				name := key.to_string()
				acc[normalize_psr7_header_name(name)] = [val.to_string()]
			})
			header_names = h.fold[map[string]string](map[string]string{}, fn (key vphp.ZVal, val vphp.ZVal, mut acc map[string]string) {
				name := key.to_string()
				acc[normalize_psr7_header_name(name)] = name
			})
		}
		status := if s := result.get('status') { int(s.to_i64()) } else { 200 }
		body := result.get_or('body', '')
		content_type := result.get_or('content_type', if 'content-type' in headers {
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

fn normalize_php_route_response(result vphp.ZVal) (VSlimResponse, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return text_response(200, ''), true
	}
	if result.is_object() && (result.is_instance_of('VSlim\\Psr7\\Response')
		|| result.is_instance_of('VSlimPsr7Response')) {
		if psr := result.to_object[VSlimPsr7Response]() {
			cli_debug_log('normalize.response.vslim_psr status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
			return new_vslim_response_from_psr_response(psr), true
		}
	}
	if result.is_object() && result.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
		psr := normalize_to_psr7_response(result)
		body := psr7_stream_string(response_body_or_empty(psr))
		cli_debug_log('normalize.response.psr status=${psr.get_status_code()} body_len=${body.len}')
		mut content_type_name := vphp.PhpString.of('content-type')
		defer {
			content_type_name.release()
		}
		return VSlimResponse{
			status:       psr.get_status_code()
			body:         body
			content_type: psr.get_header_line(vphp.RequestBorrowedZBox.from_zval(content_type_name.to_zval()))
			headers:      snapshot_string_map(flatten_psr7_header_map(psr.get_headers()))
		}, true
	}
	if result.is_object()
		&& (result.is_instance_of('VSlim\\VHttpd\\Response') || result.is_instance_of('VSlimResponse')) {
		if resp := result.to_object[VSlimResponse]() {
			return VSlimResponse{
				status:       resp.status
				body:         resp.body
				content_type: resp.content_type
				headers:      resp.headers()
			}, true
		}
	}
	if result.is_string() {
		return text_response(200, result.get_string()), true
	}
	if result.is_array() {
		mut headers := map[string]string{}
		if h := result.get('headers') {
			headers = h.fold[map[string]string](map[string]string{}, fn (key vphp.ZVal, val vphp.ZVal, mut acc map[string]string) {
				acc[key.to_string()] = val.to_string()
			})
		}
		status := if s := result.get('status') { int(s.to_i64()) } else { 200 }
		body := result.get_or('body', '')
		content_type := result.get_or('content_type', headers['content-type'] or {
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

fn normalize_php_route_response_body(result vphp.ZVal) (string, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return '', true
	}
	if result.is_object() && result.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
		return psr7_stream_string(response_body_or_empty(normalize_to_psr7_response(result))), true
	}
	if result.is_object()
		&& (result.is_instance_of('VSlim\\VHttpd\\Response') || result.is_instance_of('VSlimResponse')) {
		if resp := result.to_object[VSlimResponse]() {
			return resp.body, true
		}
	}
	if result.is_string() {
		return result.get_string(), true
	}
	if result.is_array() {
		return result.get_or('body', ''), true
	}
	return '', false
}

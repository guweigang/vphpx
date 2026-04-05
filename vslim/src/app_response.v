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

fn normalize_php_route_response(result vphp.ZVal) (VSlimResponse, bool) {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return text_response(200, ''), true
	}
	if result.is_object() && result.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
		psr := normalize_to_psr7_response(result)
		return VSlimResponse{
			status:       psr.get_status_code()
			body:         psr7_stream_string(response_body_or_empty(psr))
			content_type: psr.get_header_line(vphp.borrow_zbox(vphp.RequestOwnedZBox.new_string('content-type').to_zval()))
			headers:      flatten_psr7_header_map(psr.get_headers())
		}, true
	}
	if result.is_object()
		&& (result.is_instance_of('VSlim\\Vhttpd\\Response') || result.is_instance_of('VSlimResponse')) {
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
			headers:      headers
		}, true
	}
	return VSlimResponse{}, false
}

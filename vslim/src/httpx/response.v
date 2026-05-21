module httpx

import routingx

@[php_class: 'VSlim\\VHttpd\\Response']
@[heap]
pub struct VSlimResponse {
pub mut:
	status       int
	body         string
	content_type string @[php_prop: contentType]
	headers      map[string]string
}

pub fn (res &VSlimResponse) free() {
	_ = res
}

@[php_arg_name: 'content_type=contentType']
@[php_method]
pub fn (mut r VSlimResponse) construct(status int, body string, content_type string) &VSlimResponse {
	r.status = status
	r.body = body
	r.content_type = content_type
	mut headers := map[string]string{}
	headers['content-type'] = r.content_type
	r.apply_headers(headers)
	return r
}

@[php_method]
pub fn (r &VSlimResponse) header(name string) string {
	headers := r.header_values()
	return headers[routingx.Header.normalize_name(name)] or { '' }
}

@[php_method]
pub fn (r &VSlimResponse) headers() map[string]string {
	return r.header_values()
}

@[php_method: 'hasHeader']
pub fn (r &VSlimResponse) has_header(name string) bool {
	headers := r.header_values()
	return routingx.Header.normalize_name(name) in headers
}

@[php_method: 'setHeader']
pub fn (mut r VSlimResponse) set_header(name string, value string) &VSlimResponse {
	mut headers := r.header_values()
	headers[routingx.Header.normalize_name(name)] = value
	r.apply_headers(headers)
	return r
}

@[php_arg_name: 'request_id=requestId']
@[php_method: 'withRequestId']
pub fn (mut r VSlimResponse) with_request_id(request_id string) &VSlimResponse {
	if request_id == '' {
		return r
	}
	return r.set_header('x-request-id', request_id)
}

@[php_arg_name: 'trace_id=traceId']
@[php_method: 'withTraceId']
pub fn (mut r VSlimResponse) with_trace_id(trace_id string) &VSlimResponse {
	if trace_id == '' {
		return r
	}
	r.set_header('x-trace-id', trace_id)
	if !r.has_header('x-vhttpd-trace-id') {
		r.set_header('x-vhttpd-trace-id', trace_id)
	}
	return r
}

@[php_arg_name: 'content_type=contentType']
@[php_method: 'setContentType']
pub fn (mut r VSlimResponse) set_content_type(content_type string) &VSlimResponse {
	r.content_type = content_type
	mut headers := r.header_values()
	headers['content-type'] = content_type
	r.apply_headers(headers)
	return r
}

@[php_method: 'cookieHeader']
pub fn (r &VSlimResponse) cookie_header() string {
	return r.header('set-cookie')
}

@[php_method: 'setCookie']
pub fn (mut r VSlimResponse) set_cookie(name string, value string) &VSlimResponse {
	return r.set_cookie_opts(name, value, '/')
}

@[php_method: 'setCookieOpts']
pub fn (mut r VSlimResponse) set_cookie_opts(name string, value string, path string) &VSlimResponse {
	return r.set_cookie_full(name, value, path, '', 0, false, false, '')
}

@[php_arg_name: 'max_age=maxAge,http_only=httpOnly,same_site=sameSite']
@[php_method: 'setCookieFull']
pub fn (mut r VSlimResponse) set_cookie_full(name string, value string, path string, domain string, max_age int, secure bool, http_only bool, same_site string) &VSlimResponse {
	header_value := build_set_cookie_header(name, value, path, domain, max_age, secure, http_only,
		same_site)
	mut headers := r.header_values()
	headers['set-cookie'] = header_value
	r.apply_headers(headers)
	return r
}

@[php_method: 'deleteCookie']
pub fn (mut r VSlimResponse) delete_cookie(name string) &VSlimResponse {
	header_value := '${name}=; Path=/; Max-Age=0'
	mut headers := r.header_values()
	headers['set-cookie'] = header_value
	r.apply_headers(headers)
	return r
}

@[php_method: 'setStatus']
pub fn (mut r VSlimResponse) set_status(status int) &VSlimResponse {
	r.status = status
	return r
}

@[php_method: 'withStatus']
pub fn (mut r VSlimResponse) with_status(status int) &VSlimResponse {
	return r.set_status(status)
}

@[php_method]
pub fn (mut r VSlimResponse) text(body string) &VSlimResponse {
	r.body = body
	r.content_type = 'text/plain; charset=utf-8'
	mut headers := r.header_values()
	headers['content-type'] = r.content_type
	r.apply_headers(headers)
	return r
}

@[php_method]
pub fn (mut r VSlimResponse) json(body string) &VSlimResponse {
	r.body = body
	r.content_type = 'application/json; charset=utf-8'
	mut headers := r.header_values()
	headers['content-type'] = r.content_type
	r.apply_headers(headers)
	return r
}

@[php_method]
pub fn (mut r VSlimResponse) html(body string) &VSlimResponse {
	r.body = body
	r.content_type = 'text/html'
	mut headers := r.header_values()
	headers['content-type'] = r.content_type
	r.apply_headers(headers)
	return r
}

@[php_method]
pub fn (mut r VSlimResponse) redirect(location string) &VSlimResponse {
	return r.redirect_with_status(location, 302)
}

@[php_method: 'redirectWithStatus']
pub fn (mut r VSlimResponse) redirect_with_status(location string, status int) &VSlimResponse {
	r.status = status
	r.body = ''
	mut headers := r.header_values()
	headers['location'] = location
	if 'content-type' !in headers {
		headers['content-type'] = r.content_type
	}
	r.apply_headers(headers)
	return r
}

@[php_method: 'headersAll']
pub fn (r &VSlimResponse) headers_all() map[string]string {
	return r.headers()
}

fn (r &VSlimResponse) header_values() map[string]string {
	return snapshot_string_map(r.headers)
}

pub fn (r &VSlimResponse) as_array() map[string]string {
	return {
		'status':       '${r.status}'
		'body':         r.body
		'content_type': r.content_type
	}
}

pub fn (res &VSlimResponse) dispatch_map() map[string]string {
	mut out := res.as_array()
	for name, value in res.headers {
		if name == '' {
			continue
		}
		out['headers_${name.to_lower()}'] = value
	}
	return out
}

pub fn (mut res VSlimResponse) propagate_request_trace_headers(req &VSlimRequest) {
	rid := req.request_id()
	if rid != '' && !res.has_header('x-request-id') {
		res.set_header('x-request-id', rid)
	}
	tid := req.trace_id()
	if tid != '' {
		if !res.has_header('x-trace-id') {
			res.set_header('x-trace-id', tid)
		}
		if !res.has_header('x-vhttpd-trace-id') {
			res.set_header('x-vhttpd-trace-id', tid)
		}
	}
}

@[php_method]
pub fn (r &VSlimResponse) str() string {
	return '${r.status} ${r.content_type} ${r.body}'
}

@[php_method: 'contentLength']
pub fn (r &VSlimResponse) content_length() int {
	return r.body.len
}

pub fn (res VSlimResponse) boxed_snapshot() &VSlimResponse {
	snapshot := res.snapshot()
	return &snapshot
}

pub fn (res &VSlimResponse) boxed_snapshot_ref() &VSlimResponse {
	snapshot := res.snapshot()
	return &snapshot
}

pub fn (res &VSlimResponse) snapshot() VSlimResponse {
	return VSlimResponse{
		status:       res.status
		body:         res.body.clone()
		content_type: res.content_type.clone()
		headers:      snapshot_string_map(res.headers)
	}
}

pub fn (mut r VSlimResponse) apply_headers(headers map[string]string) {
	r.headers = snapshot_string_map(normalize_header_map(headers))
	r.content_type = r.headers['content-type'] or { r.content_type }
}

pub fn VSlimResponse.text(status int, body string) VSlimResponse {
	mut out := VSlimResponse{}
	out.construct(status, body, 'text/plain; charset=utf-8')
	return out
}

pub fn VSlimResponse.empty() VSlimResponse {
	return VSlimResponse.text(200, '')
}

pub fn VSlimResponse.json(status int, json_body string) VSlimResponse {
	mut out := VSlimResponse{}
	out.construct(status, json_body, 'application/json; charset=utf-8')
	return out
}

pub fn VSlimResponse.html(status int, body string) VSlimResponse {
	mut out := VSlimResponse{}
	out.construct(status, body, 'text/html; charset=utf-8')
	return out
}

pub fn VSlimResponse.redirect_to(location string) VSlimResponse {
	mut out := VSlimResponse.text(302, '')
	out.redirect(location)
	return out
}

pub fn VSlimResponse.redirect_to_status(location string, status int) VSlimResponse {
	mut out := VSlimResponse.text(if status == 0 { 302 } else { status }, '')
	out.redirect(location)
	return out
}

pub fn VSlimResponse.not_found() VSlimResponse {
	return VSlimResponse.text(404, 'Not Found')
}

pub fn VSlimResponse.method_not_allowed() VSlimResponse {
	return VSlimResponse.text(405, 'Method Not Allowed')
}

pub fn (res VSlimResponse) with_allowed_methods(allowed_methods []string) VSlimResponse {
	if allowed_methods.len == 0 || 'allow' in res.headers {
		return res
	}
	mut out := res.snapshot()
	out.headers['allow'] = allowed_methods.join(', ')
	return out
}

pub fn VSlimResponse.internal_error() VSlimResponse {
	return VSlimResponse.text(500, 'Internal Server Error')
}

pub fn VSlimResponse.options(allowed_methods []string) VSlimResponse {
	mut allow := allowed_methods.clone()
	if 'OPTIONS' !in allow {
		allow << 'OPTIONS'
	}
	return VSlimResponse{
		status:       204
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type': 'text/plain; charset=utf-8'
			'allow':        allow.join(', ')
		}
	}
}

pub fn VSlimResponse.internal_phase_continue() VSlimResponse {
	return VSlimResponse{
		status:       299
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type':     'text/plain; charset=utf-8'
			'x-vslim-continue': '1'
		}
	}
}

pub fn VSlimResponse.live_html(body string) &VSlimResponse {
	return &VSlimResponse{
		status:       200
		body:         body
		content_type: 'text/html; charset=utf-8'
		headers:      {
			'content-type': 'text/html; charset=utf-8'
		}
	}
}

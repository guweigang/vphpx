module httpx

import vphp

@[vphp.PhpArgName(v_name: 'default_status', php_name: 'defaultStatus')]
@[vphp.PhpStringParam('default_reason_phrase', php_name: 'defaultReasonPhrase', default_value: '', optional: true)]
@[vphp.PhpArgDefault(v_name: 'default_status', default_value: '200')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut r VSlimPsr7Response) construct(default_status int, default_reason_phrase string) &VSlimPsr7Response {
	r.status = httpx.default_status(default_status)
	r.reason_phrase = normalize_reason_phrase(r.status, default_reason_phrase)
	r.protocol_version = normalize_protocol_version(r.protocol_version)
	if r.headers.len == 0 {
		r.headers = map[string][]string{}
	}
	if r.header_names.len == 0 {
		r.header_names = map[string]string{}
	}
	if r.body_ref == unsafe { nil } {
		r.body_ref = VSlimPsr7Stream.from_content('')
	}
	return &r
}

@[vphp.PhpExportMethod(name: 'getProtocolVersion')]
pub fn (r &VSlimPsr7Response) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'withProtocolVersion')]
pub fn (r &VSlimPsr7Response) with_protocol_version(version vphp.PhpValue) &VSlimPsr7Response {
	return r.clone_with(normalize_protocol_version(value_subject(version).log_message()),
		r.headers, r.header_names,
		r.body_ref, r.status, r.reason_phrase)
}

@[vphp.PhpExportMethod(name: 'getHeaders')]
pub fn (r &VSlimPsr7Response) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[vphp.PhpExportMethod(name: 'hasHeader')]
pub fn (r &VSlimPsr7Response) has_header(name vphp.PhpValue) bool {
	return normalize_header_name(value_subject(name).log_message()) in r.headers
}

@[vphp.PhpExportMethod(name: 'getHeader')]
pub fn (r &VSlimPsr7Response) get_header(name vphp.PhpValue) []string {
	key := normalize_header_name(value_subject(name).log_message())
	return clone_header_list(r.headers[key] or { []string{} })
}

@[vphp.PhpExportMethod(name: 'getHeaderLine')]
pub fn (r &VSlimPsr7Response) get_header_line(name vphp.PhpValue) string {
	return r.get_header_line_name(value_subject(name).log_message())
}

pub fn (r &VSlimPsr7Response) get_header_line_name(name string) string {
	key := normalize_header_name(name)
	return clone_header_list(r.headers[key] or { []string{} }).join(', ')
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'withHeader')]
pub fn (r &VSlimPsr7Response) with_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Response {
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, r.status,
			r.reason_phrase)
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, r.status,
			r.reason_phrase)
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	headers[key] = values
	header_names[key] = original_name
	return r.clone_with(r.protocol_version, headers, header_names,
		r.body_ref, r.status, r.reason_phrase)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'withAddedHeader')]
pub fn (r &VSlimPsr7Response) with_added_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Response {
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, r.status,
			r.reason_phrase)
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, r.status,
			r.reason_phrase)
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	mut existing := headers[key] or { []string{} }
	existing << values
	headers[key] = existing
	if key !in header_names {
		header_names[key] = original_name
	}
	return r.clone_with(r.protocol_version, headers, header_names,
		r.body_ref, r.status, r.reason_phrase)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'withoutHeader')]
pub fn (r &VSlimPsr7Response) without_header(name vphp.PhpValue) &VSlimPsr7Response {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_header_name(value_subject(name).log_message())
	headers.delete(key)
	header_names.delete(key)
	return r.clone_with(r.protocol_version, headers, header_names,
		r.body_ref, r.status, r.reason_phrase)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpExportMethod(name: 'getBody')]
pub fn (mut r VSlimPsr7Response) get_body() vphp.PhpValue {
	if body := r.response_body_object() {
		return body.to_request_scoped()
	}
	if vphp.PhpException.has_current() {
		return vphp.PhpValue.invalid()
	}
	return psr7_body_value(r, r.body_ref, r.body_pending)
}

pub fn (mut r VSlimPsr7Response) init_php_state() {
	install_psr7_body(r, mut r.body_pending)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'withBody')]
pub fn (r &VSlimPsr7Response) with_body(body PsrStream) &VSlimPsr7Response {
	mut out := r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, r.status,
		r.reason_phrase)
	out.body_pending.release()
	out.body_pending = body.to_value().owned()
	out.body_ref = unsafe { nil }
	return out
}

@[vphp.PhpExportMethod(name: 'getStatusCode')]
pub fn (r &VSlimPsr7Response) get_status_code() int {
	return default_status(r.status)
}

@[vphp.PhpArgName(v_name: 'default_reason_phrase', php_name: 'defaultReasonPhrase')]
@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpArgDefault(v_name: 'default_reason_phrase', default_value: '""')]
@[vphp.PhpExportMethod(name: 'withStatus')]
pub fn (r &VSlimPsr7Response) with_status(code vphp.PhpValue, default_reason_phrase vphp.PhpValue) &VSlimPsr7Response {
	status := validate_status_or_throw(int(code.to_i64())) or {
		return r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, r.status,
			r.reason_phrase)
	}
	return r.clone_with(r.protocol_version, r.headers, r.header_names, r.body_ref, status, normalize_reason_phrase(status,
		value_or_empty_string(default_reason_phrase)))
}

@[vphp.PhpExportMethod(name: 'getReasonPhrase')]
pub fn (r &VSlimPsr7Response) get_reason_phrase() string {
	return normalize_reason_phrase(r.status, r.reason_phrase)
}

@[vphp.PhpArgNames(names: 'max_age=maxAge,http_only=httpOnly,same_site=sameSite')]
@[vphp.PhpExportMethod(name: 'setCookieFull')]
pub fn (mut r VSlimPsr7Response) set_cookie_full(name string, value string, path string, domain string, max_age int, secure bool, http_only bool, same_site string) &VSlimPsr7Response {
	header_value := build_set_cookie_header(name, value, path, domain, max_age, secure, http_only,
		same_site)
	r.headers['set-cookie'] = [header_value]
	r.header_names['set-cookie'] = 'Set-Cookie'
	return &r
}

@[vphp.PhpExportMethod(name: 'deleteCookie')]
pub fn (mut r VSlimPsr7Response) delete_cookie(name string) &VSlimPsr7Response {
	r.headers['set-cookie'] = ['${name}=; Path=/; Max-Age=0']
	r.header_names['set-cookie'] = 'Set-Cookie'
	return &r
}

@[vphp.PhpExportMethod(name: '')]
pub fn (r &VSlimPsr7Response) str() string {
	return 'VSlim\\Psr7\\Response(status=${r.get_status_code()}, headers=${r.headers.len})'
}

pub fn (mut r VSlimPsr7Response) cleanup() {
	r.body_ref = unsafe { nil }
}

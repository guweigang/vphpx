module httpx

import vphp

@[php_arg_name: 'default_status=defaultStatus,default_reason_phrase=defaultReasonPhrase']
@[php_arg_default: 'default_status=200,default_reason_phrase=""']
@[php_arg_optional: 'default_status,default_reason_phrase']
@[php_method]
pub fn (mut r VSlimPsr7Response) construct(default_status int, default_reason_phrase string) &VSlimPsr7Response {
	r.status = default_status(default_status)
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

@[php_method: 'getProtocolVersion']
pub fn (r &VSlimPsr7Response) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withProtocolVersion']
pub fn (r &VSlimPsr7Response) with_protocol_version(version vphp.PhpValue) &VSlimPsr7Response {
	return r.clone_with(normalize_protocol_version(value_subject(version).log_message()),
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.status, r.reason_phrase)
}

@[php_method: 'getHeaders']
pub fn (r &VSlimPsr7Response) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[php_method: 'hasHeader']
pub fn (r &VSlimPsr7Response) has_header(name vphp.PhpValue) bool {
	return normalize_header_name(value_subject(name).log_message()) in r.headers
}

@[php_method: 'getHeader']
pub fn (r &VSlimPsr7Response) get_header(name vphp.PhpValue) []string {
	key := normalize_header_name(value_subject(name).log_message())
	return clone_header_list(r.headers[key] or { []string{} })
}

@[php_method: 'getHeaderLine']
pub fn (r &VSlimPsr7Response) get_header_line(name vphp.PhpValue) string {
	return r.get_header_line_name(value_subject(name).log_message())
}

pub fn (r &VSlimPsr7Response) get_header_line_name(name string) string {
	key := normalize_header_name(name)
	return clone_header_list(r.headers[key] or { []string{} }).join(', ')
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withHeader']
pub fn (r &VSlimPsr7Response) with_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Response {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), r.body_or_empty(), r.status,
			r.reason_phrase)
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), r.body_or_empty(), r.status,
			r.reason_phrase)
	}
	headers[key] = values
	header_names[key] = original_name
	return r.clone_with(r.protocol_version, headers, header_names,
		r.body_or_empty(), r.status, r.reason_phrase)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withAddedHeader']
pub fn (r &VSlimPsr7Response) with_added_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Response {
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), r.body_or_empty(), r.status,
			r.reason_phrase)
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), r.body_or_empty(), r.status,
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
		r.body_or_empty(), r.status, r.reason_phrase)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withoutHeader']
pub fn (r &VSlimPsr7Response) without_header(name vphp.PhpValue) &VSlimPsr7Response {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_header_name(value_subject(name).log_message())
	headers.delete(key)
	header_names.delete(key)
	return r.clone_with(r.protocol_version, headers, header_names,
		r.body_or_empty(), r.status, r.reason_phrase)
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getBody']
@[php_borrowed_return]
pub fn (r &VSlimPsr7Response) get_body() &VSlimPsr7Stream {
	if r.body_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Response(r)
			writable.body_ref = VSlimPsr7Stream.from_content('')
		}
	}
	return r.body_ref
}

@[php_arg_type: 'body=Psr\\Http\\Message\\StreamInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'withBody']
pub fn (r &VSlimPsr7Response) with_body(body vphp.PhpValue) &VSlimPsr7Response {
	return r.clone_with(r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), VSlimPsr7Stream.from_value(body), r.status,
		r.reason_phrase)
}

@[php_method: 'getStatusCode']
pub fn (r &VSlimPsr7Response) get_status_code() int {
	return default_status(r.status)
}

@[php_arg_name: 'default_reason_phrase=defaultReasonPhrase']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_default: 'default_reason_phrase=""']
@[php_arg_optional: 'default_reason_phrase']
@[php_method: 'withStatus']
pub fn (r &VSlimPsr7Response) with_status(code vphp.PhpValue, default_reason_phrase vphp.PhpValue) &VSlimPsr7Response {
	status := validate_status_or_throw(int(code.to_i64())) or {
		return r.clone_with(r.protocol_version, clone_header_values(r.headers),
			clone_header_names(r.header_names), r.body_or_empty(), r.status,
			r.reason_phrase)
	}
	return r.clone_with(r.protocol_version, clone_header_values(r.headers),
		clone_header_names(r.header_names), r.body_or_empty(), status, normalize_reason_phrase(status,
		value_or_empty_string(default_reason_phrase)))
}

@[php_method: 'getReasonPhrase']
pub fn (r &VSlimPsr7Response) get_reason_phrase() string {
	return normalize_reason_phrase(r.status, r.reason_phrase)
}

@[php_arg_name: 'max_age=maxAge,http_only=httpOnly,same_site=sameSite']
@[php_method: 'setCookieFull']
pub fn (mut r VSlimPsr7Response) set_cookie_full(name string, value string, path string, domain string, max_age int, secure bool, http_only bool, same_site string) &VSlimPsr7Response {
	header_value := build_set_cookie_header(name, value, path, domain, max_age, secure, http_only,
		same_site)
	r.headers['set-cookie'] = [header_value]
	r.header_names['set-cookie'] = 'Set-Cookie'
	return &r
}

@[php_method: 'deleteCookie']
pub fn (mut r VSlimPsr7Response) delete_cookie(name string) &VSlimPsr7Response {
	r.headers['set-cookie'] = ['${name}=; Path=/; Max-Age=0']
	r.header_names['set-cookie'] = 'Set-Cookie'
	return &r
}

@[php_method]
pub fn (r &VSlimPsr7Response) str() string {
	return 'VSlim\\Psr7\\Response(status=${r.get_status_code()}, headers=${r.headers.len})'
}

pub fn (mut r VSlimPsr7Response) cleanup() {
	if r.body_ref != unsafe { nil } {
		// `getBody()` is exported as a borrowed return, so nested stream refs are
		// not owned vptr roots of the parent response object.
		r.body_ref = unsafe { nil }
	}
}

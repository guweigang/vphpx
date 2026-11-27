module httpx

import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut r VSlimPsr7Request) construct() &VSlimPsr7Request {
	r.method = 'GET'
	r.request_target = ''
	r.protocol_version = '1.1'
	if r.headers.len == 0 {
		r.headers = map[string][]string{}
	}
	if r.header_names.len == 0 {
		r.header_names = map[string]string{}
	}
	if r.body_ref == unsafe { nil } {
		r.body_ref = VSlimPsr7Stream.from_content('')
	}
	if r.uri_ref == unsafe { nil } {
		r.uri_ref = VSlimPsr7Uri.from_string('/')
	}
	return &r
}

pub fn VSlimPsr7Request.new_object() vphp.PhpObject {
	request := vphp.PhpClass.named('VSlim\\Psr7\\Request').construct() or {
		return vphp.PhpObject.invalid()
	}
	return request
}

@[vphp.PhpExportMethod(name: 'getProtocolVersion')]
pub fn (r &VSlimPsr7Request) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'withProtocolVersion')]
pub fn (r &VSlimPsr7Request) with_protocol_version(version vphp.PhpValue) &VSlimPsr7Request {
	return r.clone_with(r.method, r.request_target,
		normalize_protocol_version(value_subject(version).log_message()),
		r.headers, r.header_names,
		r.body_ref, r.uri_or_default())
}

@[vphp.PhpExportMethod(name: 'getHeaders')]
pub fn (r &VSlimPsr7Request) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[vphp.PhpExportMethod(name: 'hasHeader')]
pub fn (r &VSlimPsr7Request) has_header(name vphp.PhpValue) bool {
	return normalize_header_name(value_subject(name).log_message()) in r.headers
}

@[vphp.PhpExportMethod(name: 'getHeader')]
pub fn (r &VSlimPsr7Request) get_header(name vphp.PhpValue) []string {
	key := normalize_header_name(value_subject(name).log_message())
	return clone_header_list(r.headers[key] or { []string{} })
}

@[vphp.PhpExportMethod(name: 'getHeaderLine')]
pub fn (r &VSlimPsr7Request) get_header_line(name vphp.PhpValue) string {
	return r.get_header(name).join(', ')
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'withHeader')]
pub fn (r &VSlimPsr7Request) with_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Request {
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			r.headers, r.header_names,
			r.body_ref, r.uri_or_default())
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			r.headers, r.header_names,
			r.body_ref, r.uri_or_default())
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	headers[key] = values
	header_names[key] = original_name
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_ref, r.uri_or_default())
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'withAddedHeader')]
pub fn (r &VSlimPsr7Request) with_added_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Request {
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			r.headers, r.header_names,
			r.body_ref, r.uri_or_default())
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			r.headers, r.header_names,
			r.body_ref, r.uri_or_default())
	}
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	mut existing := headers[key] or { []string{} }
	existing << values
	headers[key] = existing
	if key !in header_names {
		header_names[key] = original_name
	}
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_ref, r.uri_or_default())
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'withoutHeader')]
pub fn (r &VSlimPsr7Request) without_header(name vphp.PhpValue) &VSlimPsr7Request {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_header_name(value_subject(name).log_message())
	headers.delete(key)
	header_names.delete(key)
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_ref, r.uri_or_default())
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpExportMethod(name: 'getBody')]
pub fn (mut r VSlimPsr7Request) get_body() vphp.PhpValue {
	return psr7_body_value(r, r.body_ref, r.body_pending)
}

pub fn (mut r VSlimPsr7Request) init_php_state() {
	install_psr7_body(r, mut r.body_pending)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'withBody')]
pub fn (r &VSlimPsr7Request) with_body(body PsrStream) &VSlimPsr7Request {
	mut out := r.clone_with(r.method, r.request_target, r.protocol_version,
		r.headers, r.header_names,
		r.body_ref, r.uri_or_default())
	out.body_pending.release()
	out.body_pending = body.to_value().owned()
	out.body_ref = unsafe { nil }
	return out
}

@[vphp.PhpExportMethod(name: 'getRequestTarget')]
pub fn (r &VSlimPsr7Request) get_request_target() string {
	target := r.request_target.trim_space()
	if target != '' {
		return target
	}
	return build_psr7_request_target(r.uri_or_default())
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpArgName(v_name: 'request_target', php_name: 'requestTarget')]
@[vphp.PhpExportMethod(name: 'withRequestTarget')]
pub fn (r &VSlimPsr7Request) with_request_target(request_target vphp.PhpValue) &VSlimPsr7Request {
	target := validate_request_target_or_throw(value_subject(request_target).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			r.headers, r.header_names,
			r.body_ref, r.uri_or_default())
	}
	return r.clone_with(r.method, target, r.protocol_version,
		r.headers, r.header_names,
		r.body_ref, r.uri_or_default())
}

@[vphp.PhpExportMethod(name: 'getMethod')]
pub fn (r &VSlimPsr7Request) get_method() string {
	return normalize_method(r.method)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'withMethod')]
pub fn (r &VSlimPsr7Request) with_method(method vphp.PhpValue) &VSlimPsr7Request {
	next_method := validate_method_or_throw(value_subject(method).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			r.headers, r.header_names,
			r.body_ref, r.uri_or_default())
	}
	return r.clone_with(next_method, r.request_target, r.protocol_version,
		r.headers, r.header_names,
		r.body_ref, r.uri_or_default())
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\UriInterface')]
@[vphp.PhpExportMethod(name: 'getUri')]
@[vphp.PhpBorrowedReturn]
pub fn (r &VSlimPsr7Request) get_uri() &VSlimPsr7Uri {
	if r.uri_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Request(r)
			writable.uri_ref = VSlimPsr7Uri.from_string('/')
		}
	}
	return r.uri_ref
}

@[vphp.PhpReturnType('Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpBoolParam('preserve_host', php_name: 'preserveHost', default_value: false, optional: true)]
@[vphp.PhpExportMethod(name: 'withUri')]
pub fn (r &VSlimPsr7Request) with_uri(uri PsrUri, preserve_host bool) &VSlimPsr7Request {
	next_uri := VSlimPsr7Uri.from_value(uri.to_value())
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	current_host := headers[normalize_header_name('Host')] or { []string{} }
	if !preserve_host || current_host.len == 0 || current_host[0].trim_space() == '' {
		apply_psr7_host_header(mut headers, mut header_names, next_uri)
	}
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_ref, next_uri)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (r &VSlimPsr7Request) str() string {
	return 'VSlim\\Psr7\\Request(method=${r.get_method()}, target=${r.get_request_target()})'
}

pub fn (mut r VSlimPsr7Request) cleanup() {
	r.body_ref = unsafe { nil }
	if r.uri_ref != unsafe { nil } {
		// `getUri()` is exported as a borrowed return for PSR-7 requests.
		r.uri_ref = unsafe { nil }
	}
}

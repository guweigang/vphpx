module httpx

import vphp

@[php_method]
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

@[php_method: 'getProtocolVersion']
pub fn (r &VSlimPsr7Request) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withProtocolVersion']
pub fn (r &VSlimPsr7Request) with_protocol_version(version vphp.PhpValue) &VSlimPsr7Request {
	return r.clone_with(r.method, r.request_target,
		normalize_protocol_version(value_subject(version).log_message()),
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default())
}

@[php_method: 'getHeaders']
pub fn (r &VSlimPsr7Request) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[php_method: 'hasHeader']
pub fn (r &VSlimPsr7Request) has_header(name vphp.PhpValue) bool {
	return normalize_header_name(value_subject(name).log_message()) in r.headers
}

@[php_method: 'getHeader']
pub fn (r &VSlimPsr7Request) get_header(name vphp.PhpValue) []string {
	key := normalize_header_name(value_subject(name).log_message())
	return clone_header_list(r.headers[key] or { []string{} })
}

@[php_method: 'getHeaderLine']
pub fn (r &VSlimPsr7Request) get_header_line(name vphp.PhpValue) string {
	return r.get_header(name).join(', ')
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withHeader']
pub fn (r &VSlimPsr7Request) with_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Request {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default())
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default())
	}
	headers[key] = values
	header_names[key] = original_name
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_or_empty(), r.uri_or_default())
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withAddedHeader']
pub fn (r &VSlimPsr7Request) with_added_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7Request {
	original_name := value_subject(name).log_message().trim_space()
	key := validate_header_name_or_throw(value_subject(name).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default())
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default())
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
		header_names, r.body_or_empty(), r.uri_or_default())
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withoutHeader']
pub fn (r &VSlimPsr7Request) without_header(name vphp.PhpValue) &VSlimPsr7Request {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := normalize_header_name(value_subject(name).log_message())
	headers.delete(key)
	header_names.delete(key)
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_or_empty(), r.uri_or_default())
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getBody']
@[php_borrowed_return]
pub fn (r &VSlimPsr7Request) get_body() &VSlimPsr7Stream {
	if r.body_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Request(r)
			writable.body_ref = VSlimPsr7Stream.from_content('')
		}
	}
	return r.body_ref
}

@[php_arg_type: 'body=Psr\\Http\\Message\\StreamInterface']
@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withBody']
pub fn (r &VSlimPsr7Request) with_body(body vphp.PhpValue) &VSlimPsr7Request {
	return r.clone_with(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		VSlimPsr7Stream.from_value(body), r.uri_or_default())
}

@[php_method: 'getRequestTarget']
pub fn (r &VSlimPsr7Request) get_request_target() string {
	target := r.request_target.trim_space()
	if target != '' {
		return target
	}
	return build_psr7_request_target(r.uri_or_default())
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_arg_name: 'request_target=requestTarget']
@[php_method: 'withRequestTarget']
pub fn (r &VSlimPsr7Request) with_request_target(request_target vphp.PhpValue) &VSlimPsr7Request {
	target := validate_request_target_or_throw(value_subject(request_target).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default())
	}
	return r.clone_with(r.method, target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default())
}

@[php_method: 'getMethod']
pub fn (r &VSlimPsr7Request) get_method() string {
	return normalize_method(r.method)
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'withMethod']
pub fn (r &VSlimPsr7Request) with_method(method vphp.PhpValue) &VSlimPsr7Request {
	next_method := validate_method_or_throw(value_subject(method).log_message()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default())
	}
	return r.clone_with(next_method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default())
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'getUri']
@[php_borrowed_return]
pub fn (r &VSlimPsr7Request) get_uri() &VSlimPsr7Uri {
	if r.uri_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7Request(r)
			writable.uri_ref = VSlimPsr7Uri.from_string('/')
		}
	}
	return r.uri_ref
}

@[php_arg_type: 'uri=Psr\\Http\\Message\\UriInterface']
@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_arg_name: 'preserve_host=preserveHost']
@[php_arg_default: 'preserve_host=false']
@[php_arg_optional: 'preserve_host']
@[php_method: 'withUri']
pub fn (r &VSlimPsr7Request) with_uri(uri vphp.PhpValue, preserve_host bool) &VSlimPsr7Request {
	next_uri := VSlimPsr7Uri.from_value(uri)
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	current_host := headers[normalize_header_name('Host')] or { []string{} }
	if !preserve_host || current_host.len == 0 || current_host[0].trim_space() == '' {
		apply_psr7_host_header(mut headers, mut header_names, next_uri)
	}
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_or_empty(), next_uri)
}

@[php_method]
pub fn (r &VSlimPsr7Request) str() string {
	return 'VSlim\\Psr7\\Request(method=${r.get_method()}, target=${r.get_request_target()})'
}

pub fn (mut r VSlimPsr7Request) cleanup() {
	if r.body_ref != unsafe { nil } {
		// `getBody()` is exported as a borrowed return; parent cleanup should only
		// sever the reference, not mutate the global vptr root table.
		r.body_ref = unsafe { nil }
	}
	if r.uri_ref != unsafe { nil } {
		// `getUri()` is exported as a borrowed return for PSR-7 requests.
		r.uri_ref = unsafe { nil }
	}
}

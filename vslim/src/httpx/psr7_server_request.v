module httpx

import psrx
import vphp

@[php_method]
pub fn (mut r VSlimPsr7ServerRequest) construct() &VSlimPsr7ServerRequest {
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
	if !r.server_params_ref.is_valid() {
		r.server_params_ref = empty_persistent_array()
	}
	if !r.cookie_params_ref.is_valid() {
		r.cookie_params_ref = empty_persistent_array()
	}
	if !r.query_params_ref.is_valid() {
		r.query_params_ref = empty_persistent_array()
	}
	if !r.uploaded_files_ref.is_valid() {
		r.uploaded_files_ref = empty_persistent_array()
	}
	if !r.attributes_ref.is_valid() || r.attributes_ref.is_null() || r.attributes_ref.is_undef() {
		r.attributes_ref = empty_persistent_array_value()
	}
	if !r.parsed_body_ref.is_valid() {
		r.parsed_body_ref = persistent_null_value()
	}
	return &r
}

@[php_method: 'getProtocolVersion']
pub fn (r &VSlimPsr7ServerRequest) get_protocol_version() string {
	return normalize_protocol_version(r.protocol_version)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withProtocolVersion']
pub fn (r &VSlimPsr7ServerRequest) with_protocol_version(version vphp.PhpValue) &VSlimPsr7ServerRequest {
	return r.clone_with(r.method, r.request_target,
		normalize_protocol_version(version.to_string()), clone_header_values(r.headers),
		clone_header_names(r.header_names), r.body_or_empty(),
		r.uri_or_default(), r.server_params_ref, r.cookie_params_ref,
		r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref, r.attributes_ref)
}

@[php_method: 'getHeaders']
pub fn (r &VSlimPsr7ServerRequest) get_headers() map[string][]string {
	return materialize_psr7_headers(r.headers, r.header_names)
}

@[php_method: 'hasHeader']
pub fn (r &VSlimPsr7ServerRequest) has_header(name vphp.PhpValue) bool {
	return psrx.normalize_header_name(name.to_string()) in r.headers
}

@[php_method: 'getHeader']
pub fn (r &VSlimPsr7ServerRequest) get_header(name vphp.PhpValue) []string {
	key := psrx.normalize_header_name(name.to_string())
	return clone_header_list(r.headers[key] or { []string{} })
}

@[php_method: 'getHeaderLine']
pub fn (r &VSlimPsr7ServerRequest) get_header_line(name vphp.PhpValue) string {
	return r.get_header(name).join(', ')
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withHeader']
pub fn (r &VSlimPsr7ServerRequest) with_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7ServerRequest {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	raw_name := name.to_string()
	original_name := raw_name.trim_space()
	key := psrx.validate_header_name_or_throw(raw_name) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
	}
	headers[key] = values
	header_names[key] = original_name
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_or_empty(), r.uri_or_default(),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withAddedHeader']
pub fn (r &VSlimPsr7ServerRequest) with_added_header(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7ServerRequest {
	raw_name := name.to_string()
	original_name := raw_name.trim_space()
	key := psrx.validate_header_name_or_throw(raw_name) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
	}
	values := value_subject(value).header_values() or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
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
		header_names, r.body_or_empty(), r.uri_or_default(),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withoutHeader']
pub fn (r &VSlimPsr7ServerRequest) without_header(name vphp.PhpValue) &VSlimPsr7ServerRequest {
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	key := psrx.normalize_header_name(name.to_string())
	headers.delete(key)
	header_names.delete(key)
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_or_empty(), r.uri_or_default(),
		r.server_params_ref, r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		r.parsed_body_ref, r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'getBody']
@[php_borrowed_return]
pub fn (r &VSlimPsr7ServerRequest) get_body() &VSlimPsr7Stream {
	if r.body_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7ServerRequest(r)
			writable.body_ref = VSlimPsr7Stream.from_content('')
		}
	}
	return r.body_ref
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_type: 'body=Psr\\Http\\Message\\StreamInterface']
@[php_method: 'withBody']
pub fn (r &VSlimPsr7ServerRequest) with_body(body vphp.PhpValue) &VSlimPsr7ServerRequest {
	return r.clone_with(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		VSlimPsr7Stream.from_value(body), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

pub fn (mut r VSlimPsr7ServerRequest) cleanup() {
	if r.body_ref != unsafe { nil } {
		// `getBody()` is exported as a borrowed return; nested stream refs are not
		// parent-owned vptr roots and must not be unregistered here.
		r.body_ref = unsafe { nil }
	}
	if r.uri_ref != unsafe { nil } {
		// `getUri()` is exported as a borrowed return for server requests.
		r.uri_ref = unsafe { nil }
	}
	// Note: other fields are semantic PHP wrappers or native V values;
	// generic_free_raw handles the wrappers automatically.
}

@[php_method: 'getRequestTarget']
pub fn (r &VSlimPsr7ServerRequest) get_request_target() string {
	target := r.request_target.trim_space()
	if target != '' {
		return target
	}
	return build_psr7_request_target(r.uri_or_default())
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'request_target=requestTarget']
@[php_method: 'withRequestTarget']
pub fn (r &VSlimPsr7ServerRequest) with_request_target(request_target vphp.PhpValue) &VSlimPsr7ServerRequest {
	target := psrx.validate_request_target_or_throw(request_target.to_string()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
	}
	return r.clone_with(r.method, target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

@[php_method: 'getMethod']
pub fn (r &VSlimPsr7ServerRequest) get_method() string {
	return psrx.normalize_method(r.method)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withMethod']
pub fn (r &VSlimPsr7ServerRequest) with_method(method vphp.PhpValue) &VSlimPsr7ServerRequest {
	next_method := psrx.validate_method_or_throw(method.to_string()) or {
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
	}
	return r.clone_with(next_method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'getUri']
@[php_borrowed_return]
pub fn (r &VSlimPsr7ServerRequest) get_uri() &VSlimPsr7Uri {
	if r.uri_ref == unsafe { nil } {
		unsafe {
			mut writable := &VSlimPsr7ServerRequest(r)
			writable.uri_ref = VSlimPsr7Uri.from_string('/')
		}
	}
	return r.uri_ref
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_type: 'uri=Psr\\Http\\Message\\UriInterface']
@[php_arg_name: 'preserve_host=preserveHost']
@[php_arg_default: 'preserve_host=false']
@[php_arg_optional: 'preserve_host']
@[php_method: 'withUri']
pub fn (r &VSlimPsr7ServerRequest) with_uri(uri vphp.PhpValue, preserve_host bool) &VSlimPsr7ServerRequest {
	next_uri := VSlimPsr7Uri.from_value(uri)
	mut headers := clone_header_values(r.headers)
	mut header_names := clone_header_names(r.header_names)
	current_host := headers[psrx.normalize_header_name('Host')] or { []string{} }
	if !preserve_host || current_host.len == 0 || current_host[0].trim_space() == '' {
		apply_psr7_host_header(mut headers, mut header_names, next_uri)
	}
	return r.clone_with(r.method, r.request_target, r.protocol_version, headers,
		header_names, r.body_or_empty(), next_uri, r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

@[php_method: 'getServerParams']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_server_params() vphp.PhpArray {
	return psr7_persistent_array(r.server_params_ref)
}

@[php_method: 'getCookieParams']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_cookie_params() vphp.PhpArray {
	return psr7_persistent_array(r.cookie_params_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withCookieParams']
pub fn (r &VSlimPsr7ServerRequest) with_cookie_params(cookies vphp.PhpArray) &VSlimPsr7ServerRequest {
	return r.clone_with(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		cookies.retain(), r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

@[php_method: 'getQueryParams']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_query_params() vphp.PhpArray {
	return psr7_persistent_array(r.query_params_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withQueryParams']
pub fn (r &VSlimPsr7ServerRequest) with_query_params(query vphp.PhpArray) &VSlimPsr7ServerRequest {
	return r.clone_with(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, query.retain(), r.uploaded_files_ref, r.parsed_body_ref,
		r.attributes_ref)
}

@[php_method: 'getUploadedFiles']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_uploaded_files() vphp.PhpArray {
	return psr7_persistent_array(r.uploaded_files_ref)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'uploaded_files=uploadedFiles']
@[php_method: 'withUploadedFiles']
pub fn (r &VSlimPsr7ServerRequest) with_uploaded_files(uploaded_files vphp.PhpArray) &VSlimPsr7ServerRequest {
	return r.clone_with(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref,
		normalize_uploaded_files_tree_array(uploaded_files), r.parsed_body_ref,
		r.attributes_ref)
}

@[php_method: 'getParsedBody']
pub fn (r &VSlimPsr7ServerRequest) get_parsed_body() vphp.PhpValue {
	return r.parsed_body_ref.to_request_owned()
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_name: 'parsed_body=parsedBody']
@[php_method: 'withParsedBody']
pub fn (r &VSlimPsr7ServerRequest) with_parsed_body(parsed_body vphp.PhpValue) &VSlimPsr7ServerRequest {
	if !is_valid_psr7_parsed_body_value(parsed_body) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'parsed body must be null, an array, or an object', 0)
		return r.clone_with(r.method, r.request_target, r.protocol_version,
			clone_header_values(r.headers), clone_header_names(r.header_names),
			r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
			r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
			r.attributes_ref)
	}
	return r.clone_with(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref,
		parsed_body.retain(), r.attributes_ref)
}

@[php_method: 'getAttributes']
@[php_return_type: 'array']
pub fn (r &VSlimPsr7ServerRequest) get_attributes() vphp.PhpArray {
	return psr7_persistent_array_value(r.attributes_ref)
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method: 'getAttribute']
pub fn (r &VSlimPsr7ServerRequest) get_attribute(name vphp.PhpValue, default_value ?vphp.PhpValue) vphp.PhpValue {
	key := name.to_string()
	if key == '' {
		return psr7_default_value_or_null(default_value)
	}
	return r.attributes_ref.with_value(fn [key, default_value] (attrs vphp.PhpValue) vphp.PhpValue {
		arr := attrs.as_array() or {
			return psr7_default_value_or_null(default_value)
		}
		value := arr.value(key) or { return psr7_default_value_or_null(default_value) }
		return value.owned()
	})
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withAttribute']
pub fn (r &VSlimPsr7ServerRequest) with_attribute(name vphp.PhpValue, value vphp.PhpValue) &VSlimPsr7ServerRequest {
	key := name.to_string()
	mut next_attrs := persistent_value_assoc_with_value(r.attributes_ref, key, value)
	out := r.clone_with_owned_attrs(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		next_attrs)
	next_attrs.release()
	return out
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'withoutAttribute']
pub fn (r &VSlimPsr7ServerRequest) without_attribute(name vphp.PhpValue) &VSlimPsr7ServerRequest {
	key := name.to_string()
	mut next_attrs := persistent_value_assoc_without_key(r.attributes_ref, key)
	out := r.clone_with_owned_attrs(r.method, r.request_target, r.protocol_version,
		clone_header_values(r.headers), clone_header_names(r.header_names),
		r.body_or_empty(), r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		next_attrs)
	next_attrs.release()
	return out
}

@[php_method]
pub fn (r &VSlimPsr7ServerRequest) str() string {
	return 'VSlim\\Psr7\\ServerRequest(method=${r.get_method()}, target=${r.get_request_target()})'
}

module httpx

import vphp

@[php_arg_type: 'response=Psr\\Http\\Message\\ResponseInterface']
@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_method: 'toVSlimResponse']
pub fn VSlimPsr7Adapter.to_vslim_response(response vphp.PhpValue) &VSlimResponse {
	return VSlimPsr7Response.from_value(response).to_vslim_response().boxed_snapshot()
}

@[php_method: 'toVSlimRequest']
pub fn VSlimPsr7Adapter.to_vslim_request(request vphp.PhpValue) &VSlimRequest {
	method := adapter_read_string(request, 'getMethod', 'method', 'GET')
	target := adapter_read_request_target(request)
	body := adapter_read_body(request)

	mut out := VSlimRequest.new(method, target, body)
	out.set_scheme(adapter_read_uri_part(request, 'getScheme', 'scheme', 'http'))
	out.set_host(adapter_read_uri_part(request, 'getHost', 'host', ''))
	out.set_port(adapter_read_uri_part(request, 'getPort', 'port', ''))
	out.set_protocol_version(adapter_read_string(request, 'getProtocolVersion', 'protocolVersion',
		'1.1'))
	out.set_remote_addr(adapter_read_server_value(request, 'REMOTE_ADDR'))
	mut headers := adapter_read_headers(request)
	defer {
		headers.release()
	}
	out.set_headers(headers)
	mut cookies := adapter_read_map(request, 'getCookieParams', 'cookies')
	defer {
		cookies.release()
	}
	out.set_cookies(cookies)
	mut query := adapter_read_map(request, 'getQueryParams', 'query')
	defer {
		query.release()
	}
	out.set_query(query)
	mut attributes := adapter_read_attributes(request)
	defer {
		attributes.release()
	}
	out.set_attributes(attributes)
	mut server := adapter_read_server_params(request)
	defer {
		server.release()
	}
	out.set_server(server)
	mut uploaded := adapter_read_uploaded_files(request)
	defer {
		uploaded.release()
	}
	out.set_uploaded_files(uploaded)
	return out
}

@[php_method: 'toWorkerEnvelope']
pub fn VSlimPsr7Adapter.to_worker_envelope(request vphp.PhpValue) vphp.PhpArray {
	vreq := VSlimPsr7Adapter.to_vslim_request(request)
	mut out := vphp.PhpArray.new()
	out.string('method', vreq.method)
	out.string('path', vreq.raw_path)
	out.string('body', vreq.body)
	out.string('scheme', vreq.scheme)
	out.string('host', vreq.host)
	out.string('port', vreq.port)
	out.string('protocol_version', vreq.protocol_version)
	out.string('remote_addr', vreq.remote_addr)
	mut headers := adapter_read_headers(request)
	defer {
		headers.release()
	}
	out.set('headers', headers)
	mut cookies := adapter_read_map(request, 'getCookieParams', 'cookies')
	defer {
		cookies.release()
	}
	out.set('cookies', cookies)
	mut query := adapter_read_map(request, 'getQueryParams', 'query')
	defer {
		query.release()
	}
	out.set('query', query)
	mut attributes := adapter_read_attributes(request)
	defer {
		attributes.release()
	}
	out.set('attributes', attributes)
	mut server := adapter_read_server_params(request)
	defer {
		server.release()
	}
	out.set('server', server)
	mut uploaded := adapter_read_uploaded_files(request)
	defer {
		uploaded.release()
	}
	out.set('uploaded_files', uploaded)
	return out
}

fn adapter_read_request_target(request vphp.PhpValue) string {
	if request.method_exists('getRequestTarget') {
		mut target := request.call_method('getRequestTarget')
		defer {
			target.release()
		}
		value := target.to_string()
		if value != '' {
			return value
		}
	}
	mut uri := value_subject(request).adapter_read_uri_object()
	defer {
		uri.release()
	}
	if uri.is_valid() && uri.is_object() {
		if uri.method_exists('getPath') {
			path := adapter_read_string(uri, 'getPath', 'path', '/')
			query := adapter_read_string(uri, 'getQuery', 'query', '')
			return if query != '' { '${path}?${query}' } else { path }
		}
		if uri.property_exists('path') {
			path := uri.prop_value('path').to_string()
			query := if uri.property_exists('query') {
				uri.prop_value('query').to_string()
			} else {
				''
			}
			return if query != '' { '${path}?${query}' } else { path }
		}
	}
	if request.property_exists('uri') {
		uri_value := request.prop_value('uri')
		if uri_value.is_string() {
			return target_from_uri_string(uri_value.to_string())
		}
	}
	return '/'
}

fn adapter_read_body(request vphp.PhpValue) string {
	if request.method_exists('getBody') {
		mut body := request.call_method('getBody')
		defer {
			body.release()
		}
		return body.to_string()
	}
	if request.property_exists('body') {
		return request.prop_value('body').to_string()
	}
	return ''
}

fn adapter_read_headers(request vphp.PhpValue) vphp.PhpArray {
	mut raw := value_subject(request).adapter_read_method_or_prop('getHeaders', 'headers')
	defer {
		raw.release()
	}
	mut out := vphp.PhpArray.new()
	if !raw.is_valid() || !raw.is_array() {
		return out
	}
	raw_headers := raw.as_array() or { return out }
	for key in raw_headers.assoc_keys() {
		value := raw_headers.value_at(key)
		if value.is_array() {
			out.string(key.to_lower(), value.to_string_list().join(', '))
			continue
		}
		out.string(key.to_lower(), value.to_string())
	}
	return out
}

fn adapter_read_attributes(request vphp.PhpValue) vphp.PhpArray {
	return adapter_read_map(request, 'getAttributes', 'attributes')
}

fn adapter_read_server_params(request vphp.PhpValue) vphp.PhpArray {
	return adapter_read_map(request, 'getServerParams', 'server')
}

fn adapter_read_map(request vphp.PhpValue, getter string, property string) vphp.PhpArray {
	mut raw := value_subject(request).adapter_read_method_or_prop(getter, property)
	defer {
		raw.release()
	}
	mut out := vphp.PhpArray.new()
	if !raw.is_valid() || !raw.is_array() {
		return out
	}
	raw_map := raw.as_array() or { return out }
	for key in raw_map.assoc_keys() {
		value := raw_map.value_at(key)
		if value.is_array() {
			out.string(key, value.to_string_list().join(', '))
		} else {
			out.string(key, value.to_string())
		}
	}
	return out
}

fn adapter_read_uploaded_files(request vphp.PhpValue) vphp.PhpArray {
	mut raw := value_subject(request).adapter_read_method_or_prop('getUploadedFiles',
		'uploadedFiles')
	defer {
		raw.release()
	}
	if !raw.is_valid() || !raw.is_array() {
		return vphp.PhpArray.new()
	}
	mut values := vphp.PhpFunction.named('array_values').invoke(raw)
	arr := values.as_array() or {
		values.release()
		return vphp.PhpArray.new()
	}
	values.release()
	return arr
}

fn adapter_read_server_value(request vphp.PhpValue, key string) string {
	mut server := adapter_read_server_params(request)
	defer {
		server.release()
	}
	return server.value_at(key).to_string()
}

fn adapter_read_uri_part(request vphp.PhpValue, getter string, property string, default_value string) string {
	mut uri := value_subject(request).adapter_read_uri_object()
	defer {
		uri.release()
	}
	if uri.is_valid() && uri.is_object() {
		if uri.method_exists(getter) {
			uri_obj := uri.as_object() or { return default_value }
			mut value := uri_obj.call_method(getter)
			defer {
				value.release()
			}
			if value.is_null() || value.is_undef() {
				return default_value
			}
			return value.to_string()
		}
		if uri.property_exists(property) {
			prop := uri.prop_value(property)
			if prop.is_null() || prop.is_undef() {
				return default_value
			}
			return prop.to_string()
		}
	}
	if request.property_exists('uri') {
		uri_value := request.prop_value('uri')
		if uri_value.is_string() {
			return uri_part_from_string(uri_value.to_string(), property, default_value)
		}
	}
	return default_value
}

fn (subject PhpValueSubject) adapter_read_uri_object() vphp.PhpValue {
	request := subject.value
	if request.method_exists('getUri') {
		return request.call_method('getUri').owned()
	}
	if request.property_exists('uri') {
		return request.prop_value('uri').owned()
	}
	return vphp.PhpValue.null()
}

fn adapter_read_string(request vphp.PhpValue, getter string, property string, default_value string) string {
	mut value := value_subject(request).adapter_read_method_or_prop(getter, property)
	defer {
		value.release()
	}
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return default_value
	}
	return value.to_string()
}

fn (subject PhpValueSubject) adapter_read_method_or_prop(getter string, property string) vphp.PhpValue {
	request := subject.value
	if request.method_exists(getter) {
		return request.call_method(getter).owned()
	}
	if request.property_exists(property) {
		return request.prop_value(property).owned()
	}
	return vphp.PhpValue.null()
}

fn target_from_uri_string(uri string) string {
	mut uri_arg := vphp.PhpString.of(uri)
	defer {
		uri_arg.release()
	}
	mut parts_value := vphp.PhpFunction.named('parse_url').invoke(uri_arg)
	defer {
		parts_value.release()
	}
	if !parts_value.is_valid() || !parts_value.is_array() {
		return '/'
	}
	path := parts_value.value_at('path').to_string()
	query := parts_value.value_at('query').to_string()
	base := if path == '' { '/' } else { path }
	return if query != '' { '${base}?${query}' } else { base }
}

fn uri_part_from_string(uri string, property string, default_value string) string {
	mut uri_arg := vphp.PhpString.of(uri)
	defer {
		uri_arg.release()
	}
	mut parts_value := vphp.PhpFunction.named('parse_url').invoke(uri_arg)
	defer {
		parts_value.release()
	}
	if !parts_value.is_valid() || !parts_value.is_array() {
		return default_value
	}
	match property {
		'scheme' { return parts_value.string_at('scheme', default_value) }
		'host' { return parts_value.string_at('host', default_value) }
		'port' { return parts_value.string_at('port', default_value) }
		else { return default_value }
	}
}

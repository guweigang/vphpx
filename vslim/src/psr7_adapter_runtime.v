module main

import vphp

@[php_method]
pub fn VPhpVSlimPsr7Adapter.dispatch(app &VSlimApp, request vphp.RequestBorrowedZBox) &VSlimResponse {
	return app.dispatch_request_raw(VPhpVSlimPsr7Adapter.to_vslim_request(request))
}

@[php_method: 'toVSlimRequest']
pub fn VPhpVSlimPsr7Adapter.to_vslim_request(request vphp.RequestBorrowedZBox) &VSlimRequest {
	raw_request := request.to_zval()
	method := adapter_read_string(raw_request, 'getMethod', 'method', 'GET')
	target := adapter_read_request_target(raw_request)
	body := adapter_read_body(raw_request)

	mut out := new_vslim_request(method, target, body)
	out.set_scheme(adapter_read_uri_part(raw_request, 'getScheme', 'scheme', 'http'))
	out.set_host(adapter_read_uri_part(raw_request, 'getHost', 'host', ''))
	out.set_port(adapter_read_uri_part(raw_request, 'getPort', 'port', ''))
	out.set_protocol_version(adapter_read_string(raw_request, 'getProtocolVersion', 'protocolVersion',
		'1.1'))
	out.set_remote_addr(adapter_read_server_value(raw_request, 'REMOTE_ADDR'))
	mut headers := adapter_read_headers(raw_request)
	defer {
		headers.release()
	}
	out.set_headers(headers.borrowed())
	mut cookies := adapter_read_map(raw_request, 'getCookieParams', 'cookies')
	defer {
		cookies.release()
	}
	out.set_cookies(cookies.borrowed())
	mut query := adapter_read_map(raw_request, 'getQueryParams', 'query')
	defer {
		query.release()
	}
	out.set_query(query.borrowed())
	mut attributes := adapter_read_attributes(raw_request)
	defer {
		attributes.release()
	}
	out.set_attributes(attributes.borrowed())
	mut server := adapter_read_server_params(raw_request)
	defer {
		server.release()
	}
	out.set_server(server.borrowed())
	mut uploaded := adapter_read_uploaded_files(raw_request)
	defer {
		uploaded.release()
	}
	out.set_uploaded_files(uploaded.borrowed())
	return out
}

@[php_method: 'toWorkerEnvelope']
pub fn VPhpVSlimPsr7Adapter.to_worker_envelope(request vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_request := request.to_zval()
	vreq := VPhpVSlimPsr7Adapter.to_vslim_request(request)
	mut out := new_array_zval()
	out.add_assoc_string('method', vreq.method)
	out.add_assoc_string('path', vreq.raw_path)
	out.add_assoc_string('body', vreq.body)
	out.add_assoc_string('scheme', vreq.scheme)
	out.add_assoc_string('host', vreq.host)
	out.add_assoc_string('port', vreq.port)
	out.add_assoc_string('protocol_version', vreq.protocol_version)
	out.add_assoc_string('remote_addr', vreq.remote_addr)
	mut headers := adapter_read_headers(raw_request)
	add_assoc_zval(out, 'headers', headers.take_zval())
	mut cookies := adapter_read_map(raw_request, 'getCookieParams', 'cookies')
	add_assoc_zval(out, 'cookies', cookies.take_zval())
	mut query := adapter_read_map(raw_request, 'getQueryParams', 'query')
	add_assoc_zval(out, 'query', query.take_zval())
	mut attributes := adapter_read_attributes(raw_request)
	add_assoc_zval(out, 'attributes', attributes.take_zval())
	mut server := adapter_read_server_params(raw_request)
	add_assoc_zval(out, 'server', server.take_zval())
	mut uploaded := adapter_read_uploaded_files(raw_request)
	add_assoc_zval(out, 'uploaded_files', uploaded.take_zval())
	return vphp.own_request_zbox(out)
}

fn adapter_read_request_target(request vphp.ZVal) string {
	if request.method_exists('getRequestTarget') {
		mut target := vphp.RequestOwnedZBox.adopt_zval(request.method_owned_request('getRequestTarget',
			[]vphp.ZVal{}))
		defer {
			target.release()
		}
		value := target.to_string()
		if value != '' {
			return value
		}
	}
	mut uri := adapter_read_uri_object(request)
	defer {
		uri.release()
	}
	if uri.is_valid() && uri.is_object() {
		if uri.method_exists('getPath') {
			path := adapter_read_string(uri.to_zval(), 'getPath', 'path', '/')
			query := adapter_read_string(uri.to_zval(), 'getQuery', 'query', '')
			return if query != '' { '${path}?${query}' } else { path }
		}
		if uri.to_zval().property_exists('path') {
			path := uri.to_zval().get_prop_string('path')
			query := if uri.to_zval().property_exists('query') { uri.to_zval().get_prop_string('query') } else { '' }
			return if query != '' { '${path}?${query}' } else { path }
		}
	}
	if request.property_exists('uri') {
		uri_value := request.get_prop('uri')
		if uri_value.is_string() {
			return target_from_uri_string(uri_value.to_string())
		}
	}
	return '/'
}

fn adapter_read_body(request vphp.ZVal) string {
	if request.method_exists('getBody') {
		mut body := vphp.RequestOwnedZBox.adopt_zval(request.method_owned_request('getBody', []vphp.ZVal{}))
		defer {
			body.release()
		}
		return body.to_string()
	}
	if request.property_exists('body') {
		return request.get_prop('body').to_string()
	}
	return ''
}

fn adapter_read_headers(request vphp.ZVal) vphp.RequestOwnedZBox {
	mut raw := adapter_read_method_or_prop(request, 'getHeaders', 'headers')
	defer {
		raw.release()
	}
	mut out := new_array_zval()
	if !raw.is_valid() || !raw.is_array() {
		return vphp.own_request_zbox(out)
	}
	for key in raw.to_zval().assoc_keys() {
		value := zval_key(raw.to_zval(), key)
		if value.is_array() {
			out.add_assoc_string(key.to_lower(), value.to_string_list().join(', '))
			continue
		}
		out.add_assoc_string(key.to_lower(), value.to_string())
	}
	return vphp.own_request_zbox(out)
}

fn adapter_read_attributes(request vphp.ZVal) vphp.RequestOwnedZBox {
	return adapter_read_map(request, 'getAttributes', 'attributes')
}

fn adapter_read_server_params(request vphp.ZVal) vphp.RequestOwnedZBox {
	return adapter_read_map(request, 'getServerParams', 'server')
}

fn adapter_read_map(request vphp.ZVal, getter string, property string) vphp.RequestOwnedZBox {
	mut raw := adapter_read_method_or_prop(request, getter, property)
	defer {
		raw.release()
	}
	mut out := new_array_zval()
	if !raw.is_valid() || !raw.is_array() {
		return vphp.own_request_zbox(out)
	}
	for key in raw.to_zval().assoc_keys() {
		value := zval_key(raw.to_zval(), key)
		if value.is_array() {
			out.add_assoc_string(key, value.to_string_list().join(', '))
		} else {
			out.add_assoc_string(key, value.to_string())
		}
	}
	return vphp.own_request_zbox(out)
}

fn adapter_read_uploaded_files(request vphp.ZVal) vphp.RequestOwnedZBox {
	mut raw := adapter_read_method_or_prop(request, 'getUploadedFiles', 'uploadedFiles')
	defer {
		raw.release()
	}
	if !raw.is_valid() || !raw.is_array() {
		return vphp.own_request_zbox(new_array_zval())
	}
	return vphp.RequestOwnedZBox.adopt_zval(vphp.php_fn('array_values').call_owned_request([
		raw.to_zval(),
	]))
}

fn adapter_read_server_value(request vphp.ZVal, key string) string {
	mut server := adapter_read_server_params(request)
	defer {
		server.release()
	}
	return zval_key(server.to_zval(), key).to_string()
}

fn adapter_read_uri_part(request vphp.ZVal, getter string, property string, default_value string) string {
	mut uri := adapter_read_uri_object(request)
	defer {
		uri.release()
	}
	if uri.is_valid() && uri.is_object() {
		if uri.to_zval().method_exists(getter) {
			mut value := vphp.RequestOwnedZBox.adopt_zval(uri.to_zval().method_owned_request(getter, []vphp.ZVal{}))
			defer {
				value.release()
			}
			if value.is_null() || value.is_undef() {
				return default_value
			}
			return value.to_string()
		}
		if uri.to_zval().property_exists(property) {
			prop := uri.to_zval().get_prop(property)
			if prop.is_null() || prop.is_undef() {
				return default_value
			}
			return prop.to_string()
		}
	}
	if request.property_exists('uri') {
		uri_value := request.get_prop('uri')
		if uri_value.is_string() {
			return uri_part_from_string(uri_value.to_string(), property, default_value)
		}
	}
	return default_value
}

fn adapter_read_uri_object(request vphp.ZVal) vphp.RequestOwnedZBox {
	if request.method_exists('getUri') {
		return vphp.RequestOwnedZBox.adopt_zval(request.method_owned_request('getUri', []vphp.ZVal{}))
	}
	if request.property_exists('uri') {
		return vphp.RequestOwnedZBox.of(request.get_prop('uri'))
	}
	return vphp.RequestOwnedZBox.new_null()
}

fn adapter_read_string(request vphp.ZVal, getter string, property string, default_value string) string {
	mut value := adapter_read_method_or_prop(request, getter, property)
	defer {
		value.release()
	}
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return default_value
	}
	return value.to_string()
}

fn adapter_read_method_or_prop(request vphp.ZVal, getter string, property string) vphp.RequestOwnedZBox {
	if request.method_exists(getter) {
		return vphp.RequestOwnedZBox.adopt_zval(request.method_owned_request(getter, []vphp.ZVal{}))
	}
	if request.property_exists(property) {
		return vphp.RequestOwnedZBox.of(request.get_prop(property))
	}
	return vphp.RequestOwnedZBox.new_null()
}

fn target_from_uri_string(uri string) string {
	mut parts := vphp.php_fn('parse_url').call([vphp.ZVal.new_string(uri)])
	defer {
		parts.release()
	}
	if !parts.is_valid() || !parts.is_array() {
		return '/'
	}
	path := zval_key(parts, 'path').to_string()
	query := zval_key(parts, 'query').to_string()
	base := if path == '' { '/' } else { path }
	return if query != '' { '${base}?${query}' } else { base }
}

fn uri_part_from_string(uri string, property string, default_value string) string {
	mut parts := vphp.php_fn('parse_url').call([vphp.ZVal.new_string(uri)])
	defer {
		parts.release()
	}
	if !parts.is_valid() || !parts.is_array() {
		return default_value
	}
	match property {
		'scheme' { return zval_string_key(parts, 'scheme', default_value) }
		'host' { return zval_string_key(parts, 'host', default_value) }
		'port' { return zval_string_key(parts, 'port', default_value) }
		else { return default_value }
	}
}

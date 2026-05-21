module httpx

import routing
import vphp

pub fn VSlimPsr7ServerRequest.from_vslim_request_value(req &VSlimRequest, route_params map[string]string) vphp.PhpValue {
	mut headers := map[string][]string{}
	for key, value in req.headers() {
		headers[key] = [value]
	}
	mut header_names := map[string]string{}
	for key in headers.keys() {
		header_names[normalize_header_name(key)] = key
	}
	if req.host != '' && 'host' !in headers {
		host_line := if req.port != '' { '${req.host}:${req.port}' } else { req.host }
		headers['host'] = [host_line]
		header_names['host'] = 'Host'
	}
	return (&VSlimPsr7ServerRequest{
		method:             normalize_method(req.method)
		request_target:     req.raw_path
		protocol_version:   normalize_protocol_version(req.protocol_version)
		headers:            headers
		header_names:       header_names
		body_ref:           VSlimPsr7Stream.from_content(req.body)
		uri_ref:            VSlimPsr7Uri.from_string(req.uri_string())
		server_params_ref:  string_map_to_persistent_array(req.server_params())
		cookie_params_ref:  string_map_to_persistent_array(req.cookies())
		query_params_ref:   string_map_to_persistent_array(req.query_params())
		uploaded_files_ref: empty_persistent_array()
		parsed_body_ref:    persistent_null_value()
		attributes_ref:     req.persistent_attrs(route_params)
	}).build_psr7_server_request_value()
}

pub fn VSlimRequest.from_psr_server_request_object(payload vphp.PhpObject, route_params map[string]string) &VSlimRequest {
	if payload.is_instance_of('VSlim\\VHttpd\\Request') || payload.is_instance_of('VSlimRequest') {
		if req := payload.to_v_object[VSlimRequest]() {
			mut cloned := req.to_vslim_request()
			cloned.params = snapshot_string_map(route_params)
			return &cloned
		}
	}
	if internal := payload.to_v_object[VSlimPsr7ServerRequest]() {
		uri := internal.uri_or_default()
		built_target := build_psr7_request_target(uri)
		mut raw_path := internal.get_request_target()
		if built_target.trim_space() != '' && built_target != '*' {
			raw_path = built_target
		} else if raw_path.trim_space() == '' {
			raw_path = built_target
		}
		uri_query_params := routing.Query.parse(uri.get_query())
		query_params := if uri.get_query().trim_space() != '' {
			uri_query_params
		} else {
			persistent_array_to_string_map(internal.query_params_ref)
		}
		mut out := &VSlimRequest{
			method:           internal.get_method()
			raw_path:         raw_path
			path:             routing.Path.normalize(uri.get_path())
			body:             psr7_stream_string(internal.body_or_empty())
			query_string:     uri.get_query()
			scheme:           uri.get_scheme()
			host:             uri.get_host()
			port:             if port := uri.get_port() { '${port}' } else { '' }
			protocol_version: internal.get_protocol_version()
			remote_addr:      persistent_array_to_string_map(internal.server_params_ref)['REMOTE_ADDR'] or {
				''
			}
			query:            snapshot_string_map(query_params)
			headers:          snapshot_string_map(flatten_psr7_header_map(internal.get_headers()))
			cookies:          snapshot_string_map(persistent_array_to_string_map(internal.cookie_params_ref))
			attributes:       snapshot_string_map(persistent_value_to_scalar_string_map(internal.attributes_ref))
			server:           snapshot_string_map(persistent_array_to_string_map(internal.server_params_ref))
			uploaded_files:   snapshot_string_list(uploaded_files_to_filenames_array(internal.get_uploaded_files()))
			params:           snapshot_string_map(route_params)
		}
		for key, value in route_params {
			if key !in out.attributes {
				out.attributes[key] = value
			}
		}
		return out
	}
	return VSlimRequest.new('GET', '/', '')
}

pub fn VSlimRequest.from_psr_server_request_value(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
	if object := payload.as_object() {
		return VSlimRequest.from_psr_server_request_object(object, route_params)
	}
	return VSlimRequest.new('GET', '/', '')
}

pub fn psr7_stream_string(stream &VSlimPsr7Stream) string {
	if stream == unsafe { nil } {
		return ''
	}
	return stream.stream_string()
}

fn (req &VSlimRequest) persistent_attrs(route_params map[string]string) vphp.PhpValue {
	mut attrs := empty_persistent_array_value()
	for key, value in req.attributes() {
		mut value_arg := vphp.PhpString.of(value)
		mut next_attrs := persistent_value_assoc_with_value(attrs, key, value_arg)
		value_arg.release()
		attrs.release()
		attrs = next_attrs
	}
	next_attrs := persistent_value_assoc_with_strings(attrs, route_params)
	attrs.release()
	return next_attrs
}

fn (req &VSlimRequest) uri_string() string {
	mut uri := ''
	scheme := if req.scheme.trim_space() == '' { 'http' } else { req.scheme.trim_space() }
	if req.host.trim_space() != '' {
		uri = '${scheme}://${req.host.trim_space()}'
		if req.port.trim_space() != '' {
			uri += ':${req.port.trim_space()}'
		}
	}
	mut path := req.path_value().trim_space()
	if path == '' {
		path = '/'
	}
	uri += path
	query := req.query_string_value().trim_space()
	if query != '' {
		uri += '?${query}'
	}
	return uri
}

pub fn persistent_value_assoc_with_strings(value vphp.PhpValue, extras map[string]string) vphp.PhpValue {
	mut out := vphp.PhpArray.new()
	value.with_array(fn [mut out] (arr vphp.PhpArray) bool {
		for name in arr.assoc_keys() {
			out.set_value(name, arr[name])
		}
		return true
	})
	for key, item in extras {
		out.string(key, item)
	}
	persistent := out.retain().to_value()
	out.release()
	return persistent
}

fn persistent_value_to_scalar_string_map(value vphp.PhpValue) map[string]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return map[string]string{}
	}
	return value.with_array(fn (arr vphp.PhpArray) map[string]string {
		return arr.to_scalar_string_map()
	}) or {
		map[string]string{}
	}
}

fn uploaded_files_to_filenames_array(files vphp.PhpArray) []string {
	mut out := []string{}
	for item in files.value_items() {
		object := item.as_object() or { continue }
		filename := if object.method_exists('getClientFilename') {
			object.with_method_result[vphp.PhpString, string]('getClientFilename', fn (result vphp.PhpString) string {
				return result.value()
			}) or { '' }
		} else {
			''
		}
		if filename != '' && filename !in out {
			out << filename
		}
	}
	return out
}

module httpx

import routing
import vphp

struct PhpValueSubject {
	value vphp.PhpValue
}

fn value_subject(value vphp.PhpValue) PhpValueSubject {
	return PhpValueSubject{
		value: value
	}
}

fn (subject PhpValueSubject) log_message() string {
	value := subject.value
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	return value.to_string()
}

pub fn VSlimPsr7Request.from_uri_value(method string, uri_input vphp.PhpValue) &VSlimPsr7Request {
	uri := VSlimPsr7Uri.from_value(uri_input)
	mut headers := map[string][]string{}
	mut header_names := map[string]string{}
	apply_psr7_host_header(mut headers, mut header_names, uri)
	return &VSlimPsr7Request{
		method:           method
		request_target:   ''
		protocol_version: '1.1'
		headers:          headers
		header_names:     header_names
		body_ref:         VSlimPsr7Stream.from_content('')
		uri_ref:          uri
	}
}

pub fn VSlimPsr7ServerRequest.with_uri(method string, uri &VSlimPsr7Uri, server_params_input vphp.PhpArray) &VSlimPsr7ServerRequest {
	mut headers := map[string][]string{}
	mut header_names := map[string]string{}
	apply_psr7_host_header(mut headers, mut header_names, uri)
	mut out := &VSlimPsr7ServerRequest{}
	out.method = method
	out.request_target = ''
	out.protocol_version = '1.1'
	out.headers = clone_header_values(headers)
	out.header_names = clone_header_names(header_names)
	out.body_ref = VSlimPsr7Stream.from_content('')
	out.uri_ref = uri
	out.server_params_ref = server_params_input.retain()
	out.cookie_params_ref = empty_persistent_array()
	out.query_params_ref =
		string_map_to_persistent_array(routing.Query.parse(normalize_query(uri.query)))
	out.uploaded_files_ref = empty_persistent_array()
	out.parsed_body_ref = persistent_null_value()
	out.attributes_ref = empty_persistent_array_value()
	return out
}

pub fn VSlimPsr7ServerRequest.from_uri_value(method string, uri_input vphp.PhpValue, server_params_input vphp.PhpArray) &VSlimPsr7ServerRequest {
	return VSlimPsr7ServerRequest.with_uri(method, VSlimPsr7Uri.from_value(uri_input),
		server_params_input)
}

pub fn VSlimPsr7ServerRequest.from_string(method string, uri string, server_params_input vphp.PhpArray) &VSlimPsr7ServerRequest {
	return VSlimPsr7ServerRequest.with_uri(method, VSlimPsr7Uri.from_string(uri), server_params_input)
}

pub fn normalize_protocol_version(version string) string {
	trimmed := version.trim_space()
	return if trimmed == '' { '1.1' } else { trimmed }
}

pub fn (r &VSlimPsr7ServerRequest) free() {
	_ = r
}

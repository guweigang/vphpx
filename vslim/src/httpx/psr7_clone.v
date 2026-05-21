module httpx

import psrx
import vphp

pub fn (r &VSlimPsr7Response) body_or_empty() &VSlimPsr7Stream {
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return VSlimPsr7Stream.from_content('')
}

pub fn (r &VSlimPsr7Request) body_or_empty() &VSlimPsr7Stream {
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return VSlimPsr7Stream.from_content('')
}

pub fn (r &VSlimPsr7Request) uri_or_default() &VSlimPsr7Uri {
	if r.uri_ref != unsafe { nil } {
		return r.uri_ref
	}
	return VSlimPsr7Uri.from_string('/')
}

pub fn (r &VSlimPsr7ServerRequest) body_or_empty() &VSlimPsr7Stream {
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return VSlimPsr7Stream.from_content('')
}

pub fn (r &VSlimPsr7ServerRequest) uri_or_default() &VSlimPsr7Uri {
	if r.uri_ref != unsafe { nil } {
		return r.uri_ref
	}
	return VSlimPsr7Uri.from_string('/')
}

pub fn (r &VSlimPsr7Response) clone_with(protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, status int, reason_phrase string) &VSlimPsr7Response {
	resolved_status := psrx.default_status(status)
	return &VSlimPsr7Response{
		status:           resolved_status
		reason_phrase:    psrx.normalize_reason_phrase(resolved_status, reason_phrase).clone()
		protocol_version: normalize_protocol_version(protocol_version).clone()
		headers:          clone_header_values(headers)
		header_names:     clone_header_names(header_names)
		body_ref:         body.clone_or_empty()
	}
}

pub fn (r &VSlimPsr7Request) clone_with(method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri) &VSlimPsr7Request {
	return &VSlimPsr7Request{
		method:           method.clone()
		request_target:   request_target.clone()
		protocol_version: normalize_protocol_version(protocol_version).clone()
		headers:          clone_header_values(headers)
		header_names:     clone_header_names(header_names)
		body_ref:         body.clone_or_empty()
		uri_ref:          uri.clone_or_default()
	}
}

pub fn (r &VSlimPsr7ServerRequest) clone_with(method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PhpArray, cookie_params_ref vphp.PhpArray, query_params_ref vphp.PhpArray, uploaded_files_ref vphp.PhpArray, parsed_body_ref vphp.PhpValue, attributes_ref vphp.PhpValue) &VSlimPsr7ServerRequest {
	return r.clone_with_owned_attrs(method, request_target, protocol_version,
		headers, header_names, body, uri, server_params_ref, cookie_params_ref, query_params_ref,
		uploaded_files_ref, parsed_body_ref, attributes_ref)
}

fn (r &VSlimPsr7ServerRequest) clone_with_owned_attrs(method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PhpArray, cookie_params_ref vphp.PhpArray, query_params_ref vphp.PhpArray, uploaded_files_ref vphp.PhpArray, parsed_body_ref vphp.PhpValue, attributes_ref vphp.PhpValue) &VSlimPsr7ServerRequest {
	mut out := &VSlimPsr7ServerRequest{}
	out.method = method.clone()
	out.request_target = request_target.clone()
	out.protocol_version = normalize_protocol_version(protocol_version).clone()
	out.headers = clone_header_values(headers)
	out.header_names = clone_header_names(header_names)
	out.body_ref = body.clone_or_empty()
	out.uri_ref = uri.clone_or_default()
	out.server_params_ref = clone_assoc_payload_ref(server_params_ref)
	out.cookie_params_ref = clone_assoc_payload_ref(cookie_params_ref)
	out.query_params_ref = clone_assoc_payload_ref(query_params_ref)
	out.uploaded_files_ref = clone_assoc_payload_ref(uploaded_files_ref)
	out.parsed_body_ref = clone_parsed_body_ref(parsed_body_ref)
	out.attributes_ref = clone_assoc_payload_value(attributes_ref)
	return out
}

pub fn (stream &VSlimPsr7Stream) clone_or_empty() &VSlimPsr7Stream {
	if stream == unsafe { nil } {
		return VSlimPsr7Stream.from_content('')
	}
	return &VSlimPsr7Stream{
		content:  stream.content.clone()
		position: stream.position
		detached: stream.detached
		metadata: stream.metadata.clone()
	}
}

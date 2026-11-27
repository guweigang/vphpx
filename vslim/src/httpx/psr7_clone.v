module httpx

import vphp

pub fn (r &VSlimPsr7Response) body_or_empty() &VSlimPsr7Stream {
	if body := r.response_body_object() {
		return VSlimPsr7Stream.from_value(body)
	}
	if r.body_ref != unsafe { nil } {
		return r.body_ref
	}
	return VSlimPsr7Stream.from_content('')
}

pub fn (r &VSlimPsr7Request) body_or_empty() &VSlimPsr7Stream {
	return psr7_body_stream(r, r.body_ref, r.body_pending)
}

pub fn (r &VSlimPsr7Request) uri_or_default() &VSlimPsr7Uri {
	if r.uri_ref != unsafe { nil } {
		return r.uri_ref
	}
	return VSlimPsr7Uri.from_string('/')
}

pub fn (r &VSlimPsr7ServerRequest) body_or_empty() &VSlimPsr7Stream {
	return psr7_body_stream(r, r.body_ref, r.body_pending)
}

pub fn (r &VSlimPsr7ServerRequest) uri_or_default() &VSlimPsr7Uri {
	if r.uri_ref != unsafe { nil } {
		return r.uri_ref
	}
	return VSlimPsr7Uri.from_string('/')
}

pub fn (r &VSlimPsr7Response) clone_with(protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, status int, reason_phrase string) &VSlimPsr7Response {
	resolved_status := default_status(status)
	mut out := &VSlimPsr7Response{}
	copy_response_into(mut out, normalize_protocol_version(protocol_version), headers,
		header_names, body, resolved_status, normalize_reason_phrase(resolved_status, reason_phrase))
	if body == r.body_ref {
		out.body_pending = copy_psr7_body(r, r.body_pending)
	}
	return out
}

pub fn (r &VSlimPsr7Response) clone_into(mut target VSlimPsr7Response) {
	copy_response_into(mut target, r.protocol_version, r.headers, r.header_names, r.body_ref,
		r.status, r.reason_phrase)
	target.body_pending = clone_psr7_body(r, r.body_ref, r.body_pending)
}

fn copy_response_into(mut target VSlimPsr7Response, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, status int, reason_phrase string) {
	target.status = status
	target.reason_phrase = reason_phrase.clone()
	target.protocol_version = protocol_version.clone()
	target.headers = clone_header_values(headers)
	target.header_names = clone_header_names(header_names)
	target.body_ref = body
}

pub fn (r &VSlimPsr7Request) clone_with(method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri) &VSlimPsr7Request {
	mut out := &VSlimPsr7Request{}
	copy_request_into(mut out, method, request_target, normalize_protocol_version(protocol_version),
		headers, header_names, body, uri)
	if body == r.body_ref {
		out.body_pending = copy_psr7_body(r, r.body_pending)
	}
	return out
}

pub fn (r &VSlimPsr7Request) clone_into(mut target VSlimPsr7Request) {
	copy_request_into(mut target, r.method, r.request_target, r.protocol_version, r.headers,
		r.header_names, r.body_ref, r.uri_or_default())
	target.body_pending = clone_psr7_body(r, r.body_ref, r.body_pending)
}

fn copy_request_into(mut target VSlimPsr7Request, method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri) {
	target.method = method.clone()
	target.request_target = request_target.clone()
	target.protocol_version = protocol_version.clone()
	target.headers = clone_header_values(headers)
	target.header_names = clone_header_names(header_names)
	target.body_ref = body
	target.uri_ref = uri.clone_or_default()
}

pub fn (r &VSlimPsr7ServerRequest) clone_with(method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PhpArray, cookie_params_ref vphp.PhpArray, query_params_ref vphp.PhpArray, uploaded_files_ref vphp.PhpArray, parsed_body_ref vphp.PhpValue, attributes_ref vphp.PhpValue) &VSlimPsr7ServerRequest {
	return r.clone_with_owned_attrs(method, request_target, protocol_version,
		headers, header_names, body, uri, server_params_ref, cookie_params_ref, query_params_ref,
		uploaded_files_ref, parsed_body_ref, clone_assoc_payload_value(attributes_ref))
}

// The new request takes ownership of owned_attrs.
fn (r &VSlimPsr7ServerRequest) clone_with_owned_attrs(method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PhpArray, cookie_params_ref vphp.PhpArray, query_params_ref vphp.PhpArray, uploaded_files_ref vphp.PhpArray, parsed_body_ref vphp.PhpValue, owned_attrs vphp.PhpValue) &VSlimPsr7ServerRequest {
	mut out := &VSlimPsr7ServerRequest{}
	copy_server_request_into(mut out, method, request_target, normalize_protocol_version(protocol_version),
		headers, header_names, body, uri, server_params_ref, cookie_params_ref, query_params_ref,
		uploaded_files_ref, parsed_body_ref, owned_attrs)
	if body == r.body_ref {
		out.body_pending = copy_psr7_body(r, r.body_pending)
	}
	return out
}

pub fn (r &VSlimPsr7ServerRequest) clone_into(mut target VSlimPsr7ServerRequest) {
	copy_server_request_into(mut target, r.method, r.request_target, r.protocol_version,
		r.headers, r.header_names, r.body_ref, r.uri_or_default(), r.server_params_ref,
		r.cookie_params_ref, r.query_params_ref, r.uploaded_files_ref, r.parsed_body_ref,
		clone_assoc_payload_value(r.attributes_ref))
	target.body_pending = clone_psr7_body(r, r.body_ref, r.body_pending)
}

fn copy_server_request_into(mut target VSlimPsr7ServerRequest, method string, request_target string, protocol_version string, headers map[string][]string, header_names map[string]string, body &VSlimPsr7Stream, uri &VSlimPsr7Uri, server_params_ref vphp.PhpArray, cookie_params_ref vphp.PhpArray, query_params_ref vphp.PhpArray, uploaded_files_ref vphp.PhpArray, parsed_body_ref vphp.PhpValue, owned_attrs vphp.PhpValue) {
	target.method = method.clone()
	target.request_target = request_target.clone()
	target.protocol_version = protocol_version.clone()
	target.headers = clone_header_values(headers)
	target.header_names = clone_header_names(header_names)
	target.body_ref = body
	target.uri_ref = uri.clone_or_default()
	target.server_params_ref = clone_assoc_payload_ref(server_params_ref)
	target.cookie_params_ref = clone_assoc_payload_ref(cookie_params_ref)
	target.query_params_ref = clone_assoc_payload_ref(query_params_ref)
	target.uploaded_files_ref = clone_assoc_payload_ref(uploaded_files_ref)
	target.parsed_body_ref = clone_parsed_body_ref(parsed_body_ref)
	target.attributes_ref = owned_attrs
}

pub fn (stream &VSlimPsr7Stream) clone_or_empty() &VSlimPsr7Stream {
	if stream == unsafe { nil } {
		return VSlimPsr7Stream.from_content('')
	}
	if stream.native_backed {
		if stream.is_detached() {
			return &VSlimPsr7Stream{ detached: true }
		}
		resource := stream.native_resource() or { return VSlimPsr7Stream.from_content('') }
		position := resource.tell() or { 0 }
		metadata := resource.stream_metadata() or { vphp.StreamMetadata{} }
		content := stream.stream_string()
		return &VSlimPsr7Stream{
			content:  content
			position: int(if position < content.len { position } else { content.len })
			metadata: psr7_stream_metadata_for(metadata.mode, metadata.uri, metadata.seekable)
		}
	}
	return &VSlimPsr7Stream{
		content:  stream.content.clone()
		position: stream.position
		detached: stream.detached
		metadata: stream.metadata.clone()
	}
}

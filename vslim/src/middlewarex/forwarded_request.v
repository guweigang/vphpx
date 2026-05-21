module middlewarex

import httpx
import vphp

__global (
	forwarded_requests map[u64]PhaseForwardedServerRequestSnapshot
)

pub struct PhaseForwardedServerRequestSnapshot {
	method             string
	request_target     string
	protocol_version   string
	headers            map[string][]string
	body_content       string
	body_position      int
	body_detached      bool
	body_metadata      map[string]string
	uri_scheme         string
	uri_user           string
	uri_password       string
	uri_host           string
	uri_port           int = -1
	uri_path           string
	uri_query          string
	uri_fragment       string
	header_names       map[string]string
	server_params_ref  vphp.PhpArray
	cookie_params_ref  vphp.PhpArray
	query_params_ref   vphp.PhpArray
	uploaded_files_ref vphp.PhpArray
	parsed_body_ref    vphp.PhpValue
	attributes_ref     vphp.PhpValue
}

pub fn forwarded_request_key(ptr voidptr) u64 {
	return u64(ptr)
}

pub fn (snapshot PhaseForwardedServerRequestSnapshot) clone() PhaseForwardedServerRequestSnapshot {
	return PhaseForwardedServerRequestSnapshot{
		method:             snapshot.method
		request_target:     snapshot.request_target
		protocol_version:   snapshot.protocol_version
		headers:            httpx.clone_header_values(snapshot.headers)
		body_content:       snapshot.body_content
		body_position:      snapshot.body_position
		body_detached:      snapshot.body_detached
		body_metadata:      snapshot.body_metadata.clone()
		uri_scheme:         snapshot.uri_scheme
		uri_user:           snapshot.uri_user
		uri_password:       snapshot.uri_password
		uri_host:           snapshot.uri_host
		uri_port:           snapshot.uri_port
		uri_path:           snapshot.uri_path
		uri_query:          snapshot.uri_query
		uri_fragment:       snapshot.uri_fragment
		header_names:       httpx.clone_header_names(snapshot.header_names)
		server_params_ref:  httpx.clone_assoc_payload_ref(snapshot.server_params_ref)
		cookie_params_ref:  httpx.clone_assoc_payload_ref(snapshot.cookie_params_ref)
		query_params_ref:   httpx.clone_assoc_payload_ref(snapshot.query_params_ref)
		uploaded_files_ref: httpx.clone_assoc_payload_ref(snapshot.uploaded_files_ref)
		parsed_body_ref:    httpx.clone_parsed_body_ref(snapshot.parsed_body_ref)
		attributes_ref:     httpx.clone_assoc_payload_value(snapshot.attributes_ref)
	}
}

pub fn snapshot_phase_forwarded_request(payload vphp.PhpObject) ?PhaseForwardedServerRequestSnapshot {
	if !payload.is_valid() {
		return none
	}
	if internal := payload.to_v_object[httpx.VSlimPsr7ServerRequest]() {
		body := internal.body_or_empty()
		uri := internal.uri_or_default()
		return PhaseForwardedServerRequestSnapshot{
			method:             internal.method
			request_target:     internal.get_request_target()
			protocol_version:   internal.get_protocol_version()
			headers:            httpx.clone_header_values(internal.headers)
			body_content:       body.content
			body_position:      body.position
			body_detached:      body.detached
			body_metadata:      body.metadata.clone()
			uri_scheme:         uri.scheme
			uri_user:           uri.user
			uri_password:       uri.password
			uri_host:           uri.host
			uri_port:           uri.port
			uri_path:           uri.path
			uri_query:          uri.query
			uri_fragment:       uri.fragment
			header_names:       httpx.clone_header_names(internal.header_names)
			server_params_ref:  httpx.clone_assoc_payload_ref(internal.server_params_ref)
			cookie_params_ref:  httpx.clone_assoc_payload_ref(internal.cookie_params_ref)
			query_params_ref:   httpx.clone_assoc_payload_ref(internal.query_params_ref)
			uploaded_files_ref: httpx.clone_assoc_payload_ref(internal.uploaded_files_ref)
			parsed_body_ref:    httpx.clone_parsed_body_ref(internal.parsed_body_ref)
			attributes_ref:     httpx.clone_assoc_payload_value(internal.attributes_ref)
		}
	}
	return none
}

pub fn store_forwarded_request_snapshot(key u64, snapshot PhaseForwardedServerRequestSnapshot) {
	unsafe {
		forwarded_requests[key] = snapshot.clone()
	}
}

pub fn take_forwarded_request_snapshot(key u64) ?PhaseForwardedServerRequestSnapshot {
	unsafe {
		if key !in forwarded_requests {
			return none
		}
		out := forwarded_requests[key] or { return none }
		forwarded_requests.delete(key)
		return out.clone()
	}
}

pub fn request_with_forwarded_snapshot(payload vphp.PhpValue, route_params map[string]string, snapshot PhaseForwardedServerRequestSnapshot) vphp.PhpObject {
	mut normalized := httpx.normalize_psr15_server_request(payload, route_params)
	if _ := normalized.to_v_object[httpx.VSlimPsr7ServerRequest]() {
		normalized.release()
		attrs_owned := if route_params.len == 0 {
			httpx.clone_assoc_payload_value(snapshot.attributes_ref)
		} else {
			httpx.persistent_value_assoc_with_strings(snapshot.attributes_ref, route_params)
		}
		mut forwarded := (&httpx.VSlimPsr7ServerRequest{
			method:             snapshot.method
			request_target:     snapshot.request_target
			protocol_version:   snapshot.protocol_version
			headers:            httpx.clone_header_values(snapshot.headers)
			header_names:       httpx.clone_header_names(snapshot.header_names)
			body_ref:           &httpx.VSlimPsr7Stream{
				content:  snapshot.body_content
				position: snapshot.body_position
				detached: snapshot.body_detached
				metadata: snapshot.body_metadata.clone()
			}
			uri_ref:            &httpx.VSlimPsr7Uri{
				scheme:   snapshot.uri_scheme
				user:     snapshot.uri_user
				password: snapshot.uri_password
				host:     snapshot.uri_host
				port:     snapshot.uri_port
				path:     snapshot.uri_path
				query:    snapshot.uri_query
				fragment: snapshot.uri_fragment
			}
			server_params_ref:  httpx.clone_assoc_payload_ref(snapshot.server_params_ref)
			cookie_params_ref:  httpx.clone_assoc_payload_ref(snapshot.cookie_params_ref)
			query_params_ref:   httpx.clone_assoc_payload_ref(snapshot.query_params_ref)
			uploaded_files_ref: httpx.clone_assoc_payload_ref(snapshot.uploaded_files_ref)
			parsed_body_ref:    httpx.clone_parsed_body_ref(snapshot.parsed_body_ref)
			attributes_ref:     attrs_owned
		}).build_psr7_server_request_value()
		return httpx.object_from_owned_value(mut forwarded)
	}
	return normalized
}

pub fn continued_phase_request_value(payload vphp.PhpValue, route_params map[string]string, cont &VSlimPsr15ContinueHandler) vphp.PhpValue {
	if cont.state.has_forwarded_request {
		if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(cont)) {
			mut request := request_with_forwarded_snapshot(payload, route_params, forwarded_request)
			out := request.owned().to_value()
			request.release()
			return out
		}
	}
	mut request := httpx.normalize_psr15_server_request(payload, route_params)
	out := request.owned().to_value()
	request.release()
	return out
}

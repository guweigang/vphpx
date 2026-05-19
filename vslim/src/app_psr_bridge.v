module main

import vphp

#include "php_bridge.h"

fn route_params_from_payload(payload vphp.PhpValue) map[string]string {
	object := payload.as_object() or { return map[string]string{} }
	if object.is_instance_of('VSlim\\VHttpd\\Request') || object.is_instance_of('VSlimRequest') {
		if req := object.to_v_object[VSlimRequest]() {
			return req.route_params()
		}
	}
	return map[string]string{}
}

fn forwarded_request_key(ptr voidptr) u64 {
	return u64(ptr)
}

fn (snapshot PhaseForwardedServerRequestSnapshot) clone() PhaseForwardedServerRequestSnapshot {
	return PhaseForwardedServerRequestSnapshot{
		method:             snapshot.method
		request_target:     snapshot.request_target
		protocol_version:   snapshot.protocol_version
		headers:            clone_header_values(snapshot.headers)
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
		header_names:       clone_header_names(snapshot.header_names)
		server_params_ref:  clone_assoc_payload_ref(snapshot.server_params_ref)
		cookie_params_ref:  clone_assoc_payload_ref(snapshot.cookie_params_ref)
		query_params_ref:   clone_assoc_payload_ref(snapshot.query_params_ref)
		uploaded_files_ref: clone_assoc_payload_ref(snapshot.uploaded_files_ref)
		parsed_body_ref:    clone_parsed_body_ref(snapshot.parsed_body_ref)
		attributes_ref:     clone_assoc_payload_value(snapshot.attributes_ref)
	}
}

fn snapshot_phase_forwarded_request(payload vphp.PhpObject) ?PhaseForwardedServerRequestSnapshot {
	if !payload.is_valid() {
		return none
	}
	if internal := payload.to_v_object[VSlimPsr7ServerRequest]() {
		body := internal.body_or_empty()
		uri := internal.uri_or_default()
		return PhaseForwardedServerRequestSnapshot{
			method:             internal.method
			request_target:     internal.get_request_target()
			protocol_version:   internal.get_protocol_version()
			headers:            clone_header_values(internal.headers)
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
			header_names:       clone_header_names(internal.header_names)
			server_params_ref:  clone_assoc_payload_ref(internal.server_params_ref)
			cookie_params_ref:  clone_assoc_payload_ref(internal.cookie_params_ref)
			query_params_ref:   clone_assoc_payload_ref(internal.query_params_ref)
			uploaded_files_ref: clone_assoc_payload_ref(internal.uploaded_files_ref)
			parsed_body_ref:    clone_parsed_body_ref(internal.parsed_body_ref)
			attributes_ref:     clone_assoc_payload_value(internal.attributes_ref)
		}
	}
	return none
}

fn store_forwarded_request_snapshot(key u64, snapshot PhaseForwardedServerRequestSnapshot) {
	unsafe {
		forwarded_requests[key] = snapshot.clone()
	}
}

fn take_forwarded_request_snapshot(key u64) ?PhaseForwardedServerRequestSnapshot {
	unsafe {
		if key !in forwarded_requests {
			return none
		}
		out := forwarded_requests[key] or { return none }
		forwarded_requests.delete(key)
		return out.clone()
	}
}

fn request_with_forwarded_snapshot(payload vphp.PhpValue, route_params map[string]string, snapshot PhaseForwardedServerRequestSnapshot) vphp.PhpObject {
	mut normalized := normalize_psr15_server_request(payload, route_params)
	if _ := normalized.to_v_object[VSlimPsr7ServerRequest]() {
		normalized.release()
		attrs_owned := if route_params.len == 0 {
			clone_assoc_payload_value(snapshot.attributes_ref)
		} else {
			persistent_value_assoc_with_strings(snapshot.attributes_ref, route_params)
		}
		mut forwarded := (&VSlimPsr7ServerRequest{
			method:             snapshot.method
			request_target:     snapshot.request_target
			protocol_version:   snapshot.protocol_version
			headers:            clone_header_values(snapshot.headers)
			header_names:       clone_header_names(snapshot.header_names)
			body_ref:           &VSlimPsr7Stream{
				content:  snapshot.body_content
				position: snapshot.body_position
				detached: snapshot.body_detached
				metadata: snapshot.body_metadata.clone()
			}
			uri_ref:            &VSlimPsr7Uri{
				scheme:   snapshot.uri_scheme
				user:     snapshot.uri_user
				password: snapshot.uri_password
				host:     snapshot.uri_host
				port:     snapshot.uri_port
				path:     snapshot.uri_path
				query:    snapshot.uri_query
				fragment: snapshot.uri_fragment
			}
			server_params_ref:  clone_assoc_payload_ref(snapshot.server_params_ref)
			cookie_params_ref:  clone_assoc_payload_ref(snapshot.cookie_params_ref)
			query_params_ref:   clone_assoc_payload_ref(snapshot.query_params_ref)
			uploaded_files_ref: clone_assoc_payload_ref(snapshot.uploaded_files_ref)
			parsed_body_ref:    clone_parsed_body_ref(snapshot.parsed_body_ref)
			attributes_ref:     attrs_owned
		}).build_psr7_server_request_value()
		return object_from_owned_value(mut forwarded)
	}
	return normalized
}

fn continued_phase_request_value(payload vphp.PhpValue, route_params map[string]string, cont &VSlimPsr15ContinueHandler) vphp.PhpValue {
	if cont.state.has_forwarded_request {
		if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(cont)) {
			mut request := request_with_forwarded_snapshot(payload, route_params, forwarded_request)
			out := request.owned().to_value()
			request.release()
			return out
		}
	}
	mut request := normalize_psr15_server_request(payload, route_params)
	out := request.owned().to_value()
	request.release()
	return out
}

fn (req &VSlimRequest) build_request_value(params map[string]string) vphp.PhpValue {
	unsafe {
		mut bound := req.boxed_snapshot_with_params(params)
		return bound.bind_owned_php_object_value()
	}
}

fn (res VSlimResponse) to_value() vphp.PhpValue {
	unsafe {
		bound := (res).boxed_snapshot()
		return bound.bind_owned_php_object_value()
	}
}

fn (res &VSlimResponse) build_response_value_ref() vphp.PhpValue {
	unsafe {
		bound := res.boxed_snapshot_ref()
		return bound.bind_owned_php_object_value()
	}
}

fn (res &VSlimPsr7Response) build_psr7_response_value() vphp.PhpValue {
	unsafe {
		bound := res.clone_with(res.get_protocol_version(),
			clone_header_values(res.headers), clone_header_names(res.header_names),
			res.body_or_empty(), res.get_status_code(), res.get_reason_phrase())
		return bound.bind_owned_php_object_value()
	}
}

fn (req &VSlimPsr7ServerRequest) build_psr7_server_request_value() vphp.PhpValue {
	unsafe {
		bound := req.clone_with(req.method, req.request_target,
			req.protocol_version, clone_header_values(req.headers),
			clone_header_names(req.header_names), req.body_or_empty(),
			req.uri_or_default(), req.server_params_ref, req.cookie_params_ref,
			req.query_params_ref, req.uploaded_files_ref, req.parsed_body_ref, req.attributes_ref)
		return bound.bind_owned_php_object_value()
	}
}

fn object_from_owned_value(mut value vphp.PhpValue) vphp.PhpObject {
	object := value.as_object() or {
		value.release()
		return vphp.PhpObject.invalid()
	}
	value.release()
	return object
}

fn normalize_psr15_server_request_object(request vphp.PhpObject, route_params map[string]string) vphp.PhpObject {
	if (request.is_instance_of('VSlim\\Psr7\\ServerRequest')
		|| request.is_instance_of('VSlimPsr7ServerRequest')) && request.is_valid() {
		if internal := request.to_v_object[VSlimPsr7ServerRequest]() {
			mut cloned := (&VSlimPsr7ServerRequest{
				method:             internal.method
				request_target:     internal.get_request_target()
				protocol_version:   internal.get_protocol_version()
				headers:            clone_header_values(internal.headers)
				header_names:       clone_header_names(internal.header_names)
				body_ref:           internal.body_or_empty().clone_or_empty()
				uri_ref:            internal.uri_or_default().clone_or_default()
				server_params_ref:  clone_assoc_payload_ref(internal.server_params_ref)
				cookie_params_ref:  clone_assoc_payload_ref(internal.cookie_params_ref)
				query_params_ref:   clone_assoc_payload_ref(internal.query_params_ref)
				uploaded_files_ref: clone_assoc_payload_ref(internal.uploaded_files_ref)
				parsed_body_ref:    clone_parsed_body_ref(internal.parsed_body_ref)
				attributes_ref:     if route_params.len == 0 {
					clone_assoc_payload_value(internal.attributes_ref)
				} else {
					persistent_value_assoc_with_strings(internal.attributes_ref, route_params)
				}
			}).build_psr7_server_request_value()
			return object_from_owned_value(mut cloned)
		}
	}
	if request.is_instance_of('VSlim\\VHttpd\\Request') || request.is_instance_of('VSlimRequest') {
		if req := request.to_v_object[VSlimRequest]() {
			mut cloned := req.build_psr7_server_request_value_from_vslim(route_params)
			return object_from_owned_value(mut cloned)
		}
	}
	method := if request.method_exists('getMethod') {
		request.with_method_result[vphp.PhpString, string]('getMethod', fn (z vphp.PhpString) string {
			return z.value()
		}) or { 'GET' }
	} else {
		'GET'
	}
	request_target := if request.method_exists('getRequestTarget') {
		request.with_method_result[vphp.PhpString, string]('getRequestTarget', fn (z vphp.PhpString) string {
			return z.value()
		}) or { '' }
	} else {
		''
	}
	protocol_version := if request.method_exists('getProtocolVersion') {
		request.with_method_result[vphp.PhpString, string]('getProtocolVersion', fn (z vphp.PhpString) string {
			return z.value()
		}) or { '1.1' }
	} else {
		'1.1'
	}
	header_map, header_names := if request.method_exists('getHeaders') {
		mut headers := request.call_method('getHeaders')
		defer {
			headers.release()
		}
		value_subject(headers).psr7_header_state()
	} else {
		map[string][]string{}, map[string]string{}
	}
	body_ref := if request.method_exists('getBody') {
		request.with_method_result[vphp.PhpValue, &VSlimPsr7Stream]('getBody', fn (z vphp.PhpValue) &VSlimPsr7Stream {
			return VSlimPsr7Stream.from_value(z)
		}) or { VSlimPsr7Stream.from_content('') }
	} else {
		VSlimPsr7Stream.from_content('')
	}
	uri_ref := if request.method_exists('getUri') {
		request.with_method_result[vphp.PhpValue, &VSlimPsr7Uri]('getUri', fn (z vphp.PhpValue) &VSlimPsr7Uri {
			return VSlimPsr7Uri.from_value(z)
		}) or { VSlimPsr7Uri.from_string('/') }
	} else {
		VSlimPsr7Uri.from_string('/')
	}
	server_params_ref := if request.method_exists('getServerParams') {
		request.with_method_result[vphp.PhpValue, vphp.PhpArray]('getServerParams', fn (z vphp.PhpValue) vphp.PhpArray {
			if arr := z.as_array() {
				return arr.retain()
			}
			return empty_persistent_array()
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	cookie_params_ref := if request.method_exists('getCookieParams') {
		request.with_method_result[vphp.PhpValue, vphp.PhpArray]('getCookieParams', fn (z vphp.PhpValue) vphp.PhpArray {
			if arr := z.as_array() {
				return arr.retain()
			}
			return empty_persistent_array()
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	query_params_ref := if request.method_exists('getQueryParams') {
		request.with_method_result[vphp.PhpValue, vphp.PhpArray]('getQueryParams', fn (z vphp.PhpValue) vphp.PhpArray {
			if arr := z.as_array() {
				return arr.retain()
			}
			return empty_persistent_array()
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	uploaded_files_ref := if request.method_exists('getUploadedFiles') {
		request.with_method_result[vphp.PhpValue, vphp.PhpArray]('getUploadedFiles', fn (z vphp.PhpValue) vphp.PhpArray {
			return normalize_uploaded_files_tree_value(z)
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	parsed_body_ref := if request.method_exists('getParsedBody') {
		request.with_method_result[vphp.PhpValue, vphp.PhpValue]('getParsedBody', fn (z vphp.PhpValue) vphp.PhpValue {
			if z.is_valid() && !z.is_null() && !z.is_undef() {
				return z.retain()
			}
			return persistent_null_value()
		}) or { persistent_null_value() }
	} else {
		persistent_null_value()
	}
	attributes_ref := if request.method_exists('getAttributes') {
		request.with_method_result[vphp.PhpValue, vphp.PhpValue]('getAttributes', fn [route_params] (z vphp.PhpValue) vphp.PhpValue {
			base := persistent_array_value(z)
			if route_params.len == 0 {
				return clone_assoc_payload_value(base)
			}
			return persistent_value_assoc_with_strings(base, route_params)
		}) or { empty_persistent_array_value() }
	} else {
		persistent_value_assoc_with_strings(empty_persistent_array_value(), route_params)
	}
	mut normalized := (&VSlimPsr7ServerRequest{
		method:             normalize_psr7_method(method)
		request_target:     request_target
		protocol_version:   normalize_protocol_version(protocol_version)
		headers:            header_map
		header_names:       header_names
		body_ref:           body_ref
		uri_ref:            uri_ref
		server_params_ref:  server_params_ref
		cookie_params_ref:  cookie_params_ref
		query_params_ref:   query_params_ref
		uploaded_files_ref: uploaded_files_ref
		parsed_body_ref:    parsed_body_ref
		attributes_ref:     attributes_ref
	}).build_psr7_server_request_value()
	return object_from_owned_value(mut normalized)
}

fn normalize_psr15_server_request_value(payload_value vphp.PhpValue, route_params map[string]string) vphp.PhpObject {
	payload_object := payload_value.as_object() or {
		mut cloned := VSlimRequest.new('GET', '/', '').build_psr7_server_request_value_from_vslim(route_params)
		return object_from_owned_value(mut cloned)
	}
	return normalize_psr15_server_request_object(payload_object, route_params)
}

fn normalize_psr15_server_request(payload vphp.PhpValue, route_params map[string]string) vphp.PhpObject {
	return normalize_psr15_server_request_value(payload, route_params)
}

fn (req &VSlimRequest) build_psr7_server_request_value_from_vslim(route_params map[string]string) vphp.PhpValue {
	mut headers := map[string][]string{}
	for key, value in req.headers() {
		headers[key] = [value]
	}
	mut header_names := map[string]string{}
	for key in headers.keys() {
		header_names[normalize_psr7_header_name(key)] = key
	}
	if req.host != '' && 'host' !in headers {
		host_line := if req.port != '' { '${req.host}:${req.port}' } else { req.host }
		headers['host'] = [host_line]
		header_names['host'] = 'Host'
	}
	return (&VSlimPsr7ServerRequest{
		method:             normalize_psr7_method(req.method)
		request_target:     req.raw_path
		protocol_version:   normalize_protocol_version(req.protocol_version)
		headers:            headers
		header_names:       header_names
		body_ref:           VSlimPsr7Stream.from_content(req.body)
		uri_ref:            VSlimPsr7Uri.from_string(vslim_request_uri_string(req))
		server_params_ref:  string_map_to_persistent_array(req.server_params())
		cookie_params_ref:  string_map_to_persistent_array(req.cookies())
		query_params_ref:   string_map_to_persistent_array(req.query_params())
		uploaded_files_ref: empty_persistent_array()
		parsed_body_ref:    persistent_null_value()
		attributes_ref:     req.persistent_attrs_from_request(route_params)
	}).build_psr7_server_request_value()
}

fn (req &VSlimRequest) persistent_attrs_from_request(route_params map[string]string) vphp.PhpValue {
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

fn persistent_array_value(value vphp.PhpValue) vphp.PhpValue {
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		return value.retain()
	}
	return empty_persistent_array_value()
}

fn persistent_value_assoc_with_strings(value vphp.PhpValue, extras map[string]string) vphp.PhpValue {
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

fn vslim_request_uri_string(req &VSlimRequest) string {
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

fn VSlimRequest.from_psr_server_request(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
	if payload_object := payload.as_object() {
		if (payload_object.is_instance_of('VSlim\\VHttpd\\Request')
			|| payload_object.is_instance_of('VSlimRequest')) && payload_object.is_valid() {
			if req := payload_object.to_v_object[VSlimRequest]() {
				mut cloned := req.to_vslim_request()
				cloned.params = snapshot_string_map(route_params)
				return &cloned
			}
		}
	}
	mut request := normalize_psr15_server_request(payload, route_params)
	defer {
		request.release()
	}
	return VSlimRequest.from_psr_server_request_object(request, route_params)
}

fn VSlimRequest.from_psr_server_request_object(payload vphp.PhpObject, route_params map[string]string) &VSlimRequest {
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
		uri_query_params := VSlimRequest.parse_query(uri.get_query())
		query_params := if uri.get_query().trim_space() != '' {
			uri_query_params
		} else {
			persistent_array_to_string_map(internal.query_params_ref)
		}
		mut out := &VSlimRequest{
			method:           internal.get_method()
			raw_path:         raw_path
			path:             RoutePath.normalize(uri.get_path())
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
			attributes:       snapshot_string_map(persistent_array_value_to_scalar_string_map(internal.attributes_ref))
			server:           snapshot_string_map(persistent_array_to_string_map(internal.server_params_ref))
			uploaded_files:   snapshot_string_list(uploaded_files_to_filenames_array(internal.get_uploaded_files()))
			params:           snapshot_string_map(route_params)
		}
		for key, value in route_params {
			if key !in out.attributes {
				out.attributes[key] = value
			}
		}
		if out.path != '/probe' || out.raw_path != '/probe' {
			cli_debug_log('psr->vslim method=${out.method} raw_path=${out.raw_path} path=${out.path} query=${out.query_string} attrs=${out.attributes.len} params=${out.params.len}')
		}
		return out
	}
	return VSlimRequest.new('GET', '/', '')
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

struct Psr7HeaderState {
mut:
	headers      map[string][]string
	header_names map[string]string
}

fn (subject PhpValueSubject) psr7_header_state() (map[string][]string, map[string]string) {
	value := subject.value
	mut arr := value.as_array() or { return map[string][]string{}, map[string]string{} }
	defer {
		arr.release()
	}
	state := arr.fold_values[Psr7HeaderState](Psr7HeaderState{
		headers:      map[string][]string{}
		header_names: map[string]string{}
	}, fn (key vphp.PhpValue, child vphp.PhpValue, mut state Psr7HeaderState) {
		name := key.to_string()
		normalized := normalize_psr7_header_name(name)
		state.headers[normalized] = value_subject(child).header_values() or { []string{} }
		state.header_names[normalized] = name
	})
	return state.headers, state.header_names
}

fn flatten_psr7_header_map(headers map[string][]string) map[string]string {
	mut out := map[string]string{}
	for key, values in headers {
		out[key] = values.join(', ')
	}
	return out
}

fn persistent_array_to_scalar_string_map(value vphp.PhpArray) map[string]string {
	if !value.is_valid() {
		return map[string]string{}
	}
	return value.to_scalar_string_map()
}

fn persistent_array_value_to_scalar_string_map(value vphp.PhpValue) map[string]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return map[string]string{}
	}
	return value.with_array(fn (arr vphp.PhpArray) map[string]string {
		return arr.to_scalar_string_map()
	}) or {
		map[string]string{}
	}
}

fn (subject PhpValueSubject) assoc_scalar_string_map() map[string]string {
	value := subject.value
	if arr := value.as_array() {
		return arr.to_scalar_string_map()
	}
	return map[string]string{}
}

fn VSlimRequest.from_psr_server_request_value(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
	if object := payload.as_object() {
		return VSlimRequest.from_psr_server_request_object(object, route_params)
	}
	return VSlimRequest.new('GET', '/', '')
}

fn psr7_stream_string(stream &VSlimPsr7Stream) string {
	if stream == unsafe { nil } {
		return ''
	}
	return stream.stream_string()
}

fn (res VSlimResponse) to_psr7_response() &VSlimPsr7Response {
	mut headers := map[string][]string{}
	for key, value in res.headers() {
		headers[normalize_psr7_header_name(key)] = [value]
	}
	return &VSlimPsr7Response{
		status:           normalize_psr7_status(res.status)
		reason_phrase:    normalize_reason_phrase(res.status, '').clone()
		protocol_version: '1.1'
		headers:          clone_header_values(headers)
		body_ref:         VSlimPsr7Stream.from_content(res.body.clone())
	}
}

fn (res &VSlimPsr7Response) to_vslim_response() VSlimResponse {
	mut headers := map[string]string{}
	for key, values in res.headers {
		if values.len == 0 {
			continue
		}
		headers[key] = values.join(', ')
	}
	content_type := headers['content-type'] or { 'text/plain; charset=utf-8' }
	return VSlimResponse{
		status:       res.status
		body:         psr7_stream_string(res.body_or_empty()).clone()
		content_type: content_type.clone()
		headers:      snapshot_string_map(headers)
	}
}

fn VSlimPsr7Response.text(status int, body string) &VSlimPsr7Response {
	return VSlimResponse.text(status, body).to_psr7_response()
}

fn VSlimPsr7Response.json(status int, json_body string) &VSlimPsr7Response {
	return VSlimResponse.json(status, json_body).to_psr7_response()
}

fn VSlimPsr7Response.from_value(result vphp.PhpValue) &VSlimPsr7Response {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return VSlimResponse.text(200, '').to_psr7_response()
	}
	if object := result.as_object() {
		if object.is_instance_of('VSlim\\Psr7\\Response')
			|| object.is_instance_of('VSlimPsr7Response') {
			if resp := object.to_v_object[VSlimPsr7Response]() {
				return resp.clone_with(resp.get_protocol_version(),
					clone_header_values(resp.headers), clone_header_names(resp.header_names),
					resp.body_or_empty(), resp.get_status_code(), resp.get_reason_phrase())
			}
		}
		if object.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			status := if object.method_exists('getStatusCode') {
				int(object.with_method_result[vphp.PhpInt, i64]('getStatusCode', fn (z vphp.PhpInt) i64 {
					return z.value()
				}) or { 200 })
			} else {
				200
			}
			reason := if object.method_exists('getReasonPhrase') {
				object.with_method_result[vphp.PhpString, string]('getReasonPhrase', fn (z vphp.PhpString) string {
					return z.value()
				}) or { '' }
			} else {
				''
			}
			protocol := if object.method_exists('getProtocolVersion') {
				object.with_method_result[vphp.PhpString, string]('getProtocolVersion', fn (z vphp.PhpString) string {
					return z.value()
				}) or { '1.1' }
			} else {
				'1.1'
			}
			headers, header_names := if object.method_exists('getHeaders') {
				mut headers_value := object.call_method('getHeaders')
				defer {
					headers_value.release()
				}
				value_subject(headers_value).psr7_header_state()
			} else {
				map[string][]string{}, map[string]string{}
			}
			body_ref := if object.method_exists('getBody') {
				object.with_method_result[vphp.PhpValue, &VSlimPsr7Stream]('getBody', fn (z vphp.PhpValue) &VSlimPsr7Stream {
					return VSlimPsr7Stream.from_value(z).clone_or_empty()
				}) or { VSlimPsr7Stream.from_content('') }
			} else {
				VSlimPsr7Stream.from_content('')
			}
			return &VSlimPsr7Response{
				status:           normalize_psr7_status(status)
				reason_phrase:    normalize_reason_phrase(status, reason)
				protocol_version: normalize_protocol_version(protocol)
				headers:          headers
				header_names:     header_names
				body_ref:         body_ref
			}
		}
	}
	res, ok := VSlimResponse.psr7_from_route_result(result)
	if ok {
		return res
	}
	return VSlimResponse.text(500, 'Invalid route response').to_psr7_response()
}

module main

import vphp

#include "php_bridge.h"

fn route_params_from_payload(payload vphp.RequestBorrowedZBox) map[string]string {
	if !payload.is_valid() || !payload.to_zval().is_object() {
		return map[string]string{}
	}
	raw := payload.to_zval()
	if raw.is_instance_of('VSlim\\VHttpd\\Request') || raw.is_instance_of('VSlimRequest') {
		if req := raw.to_object[VSlimRequest]() {
			return req.route_params()
		}
	}
	return map[string]string{}
}

fn forwarded_request_key(ptr voidptr) u64 {
	return u64(ptr)
}

fn clone_phase_forwarded_request_snapshot(snapshot PhaseForwardedServerRequestSnapshot) PhaseForwardedServerRequestSnapshot {
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
		attributes_ref:     clone_assoc_payload_ref(snapshot.attributes_ref)
	}
}

fn snapshot_phase_forwarded_request(payload vphp.RequestBorrowedZBox) ?PhaseForwardedServerRequestSnapshot {
	if !payload.is_valid() || !payload.to_zval().is_object() {
		return none
	}
	if internal := payload.to_zval().to_object[VSlimPsr7ServerRequest]() {
		body := server_request_body_or_empty(internal)
		uri := server_request_uri_or_default(internal)
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
			uri_host:     uri.host
			uri_port:     uri.port
			uri_path:     uri.path
			uri_query:    uri.query
			uri_fragment: uri.fragment
			header_names: clone_header_names(internal.header_names)
			server_params_ref:  clone_assoc_payload_ref(internal.server_params_ref)
			cookie_params_ref:  clone_assoc_payload_ref(internal.cookie_params_ref)
			query_params_ref:   clone_assoc_payload_ref(internal.query_params_ref)
			uploaded_files_ref: clone_assoc_payload_ref(internal.uploaded_files_ref)
			parsed_body_ref:    clone_parsed_body_ref(internal.parsed_body_ref)
			attributes_ref:     clone_assoc_payload_ref(internal.attributes_ref)
		}
	}
	return none
}

fn store_forwarded_request_snapshot(key u64, snapshot PhaseForwardedServerRequestSnapshot) {
	unsafe {
		forwarded_requests[key] = clone_phase_forwarded_request_snapshot(snapshot)
	}
}

fn take_forwarded_request_snapshot(key u64) ?PhaseForwardedServerRequestSnapshot {
	unsafe {
		if key !in forwarded_requests {
			return none
		}
		out := forwarded_requests[key] or { return none }
		forwarded_requests.delete(key)
		return clone_phase_forwarded_request_snapshot(out)
	}
}

fn request_with_forwarded_snapshot(payload vphp.RequestBorrowedZBox, route_params map[string]string, snapshot PhaseForwardedServerRequestSnapshot) vphp.ZVal {
	normalized := normalize_psr15_server_request_payload(payload, route_params)
	if _ := normalized.to_object[VSlimPsr7ServerRequest]() {
		attrs_owned := if route_params.len == 0 {
			clone_assoc_payload_ref(snapshot.attributes_ref)
		} else {
			persistent_assoc_with_strings(snapshot.attributes_ref, route_params)
		}
		return build_php_psr7_server_request_object(&VSlimPsr7ServerRequest{
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
		})
	}
	return normalized
}

fn continued_phase_request_payload(payload vphp.RequestBorrowedZBox, route_params map[string]string, cont &VSlimPsr15ContinueHandler) vphp.RequestOwnedZBox {
	if cont.state.has_forwarded_request {
		if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(cont)) {
			return vphp.RequestOwnedZBox.adopt_zval(request_with_forwarded_snapshot(payload,
				route_params, forwarded_request))
		}
	}
	return vphp.RequestOwnedZBox.adopt_zval(normalize_psr15_server_request_payload(payload,
		route_params))
}

fn build_php_request_object(req &VSlimRequest, params map[string]string) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		mut bound := new_vslim_request_snapshot_with_params(req, params)
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__vhttpd__request_ce,
			&C.vphp_class_handlers(vslimrequest_handlers()))
		return payload
	}
}

fn build_php_response_object(res VSlimResponse) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		bound := new_vslim_response_snapshot(res)
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__vhttpd__response_ce,
			&C.vphp_class_handlers(vslimresponse_handlers()))
		return payload
	}
}

fn build_php_response_object_ref(res &VSlimResponse) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		bound := new_vslim_response_snapshot_ref(res)
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__vhttpd__response_ce,
			&C.vphp_class_handlers(vslimresponse_handlers()))
		return payload
	}
}

fn build_php_psr7_response_object(res &VSlimPsr7Response) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		bound := clone_psr7_response(res, res.get_protocol_version(), clone_header_values(res.headers),
			clone_header_names(res.header_names), response_body_or_empty(res), res.get_status_code(),
			res.get_reason_phrase())
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__psr7__response_ce,
			&C.vphp_class_handlers(vslimpsr7response_handlers()))
		return payload
	}
}

fn build_php_psr7_server_request_object(req &VSlimPsr7ServerRequest) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		bound := clone_psr7_server_request(req, req.method, req.request_target, req.protocol_version,
			clone_header_values(req.headers), clone_header_names(req.header_names),
			server_request_body_or_empty(req), server_request_uri_or_default(req), req.server_params_ref,
			req.cookie_params_ref, req.query_params_ref, req.uploaded_files_ref, req.parsed_body_ref,
			req.attributes_ref)
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__psr7__serverrequest_ce,
			&C.vphp_class_handlers(vslimpsr7serverrequest_handlers()))
		return payload
	}
}

fn normalize_psr15_server_request_payload(payload vphp.RequestBorrowedZBox, route_params map[string]string) vphp.ZVal {
	if payload.is_valid() && payload.to_zval().is_object()
		&& (payload.to_zval().is_instance_of('VSlim\\Psr7\\ServerRequest')
		|| payload.to_zval().is_instance_of('VSlimPsr7ServerRequest')) {
		if internal := payload.to_zval().to_object[VSlimPsr7ServerRequest]() {
			return build_php_psr7_server_request_object(&VSlimPsr7ServerRequest{
				method:             internal.method
				request_target:     internal.get_request_target()
				protocol_version:   internal.get_protocol_version()
				headers:            clone_header_values(internal.headers)
				header_names:       clone_header_names(internal.header_names)
				body_ref:           clone_psr7_stream(server_request_body_or_empty(internal))
				uri_ref:            clone_psr7_uri_or_default(server_request_uri_or_default(internal))
				server_params_ref:  clone_assoc_payload_ref(internal.server_params_ref)
				cookie_params_ref:  clone_assoc_payload_ref(internal.cookie_params_ref)
				query_params_ref:   clone_assoc_payload_ref(internal.query_params_ref)
				uploaded_files_ref: clone_assoc_payload_ref(internal.uploaded_files_ref)
				parsed_body_ref:    clone_parsed_body_ref(internal.parsed_body_ref)
				attributes_ref:     if route_params.len == 0 {
					clone_assoc_payload_ref(internal.attributes_ref)
				} else {
					persistent_assoc_with_strings(internal.attributes_ref, route_params)
				}
			})
		}
	}
	if payload.is_valid() && payload.to_zval().is_object()
		&& (payload.to_zval().is_instance_of('VSlim\\VHttpd\\Request')
		|| payload.to_zval().is_instance_of('VSlimRequest')) {
		if req := payload.to_zval().to_object[VSlimRequest]() {
			return build_php_psr7_server_request_from_vslim(req, route_params)
		}
	}
	if !is_psr_server_request_payload(payload) {
		return build_php_psr7_server_request_from_vslim(new_vslim_request('GET', '/',
			''), route_params)
	}
	request := payload.to_zval()
	method := if request.method_exists('getMethod') {
		vphp.with_method_result_zval(request, 'getMethod', []vphp.ZVal{}, fn (z vphp.ZVal) string {
			return z.to_string()
		})
	} else {
		'GET'
	}
	request_target := if request.method_exists('getRequestTarget') {
		vphp.with_method_result_zval(request, 'getRequestTarget', []vphp.ZVal{}, fn (z vphp.ZVal) string {
			return z.to_string()
		})
	} else {
		''
	}
	protocol_version := if request.method_exists('getProtocolVersion') {
		vphp.with_method_result_zval(request, 'getProtocolVersion', []vphp.ZVal{}, fn (z vphp.ZVal) string {
			return z.to_string()
		})
	} else {
		'1.1'
	}
	header_map, header_names := if request.method_exists('getHeaders') {
		mut headers_z := vphp.method_request_owned_box(request, 'getHeaders', []vphp.ZVal{})
		defer {
			headers_z.release()
		}
		zval_to_psr7_header_state(headers_z.to_zval())
	} else {
		map[string][]string{}, map[string]string{}
	}
	body_ref := if request.method_exists('getBody') {
		vphp.with_method_result_zval(request, 'getBody', []vphp.ZVal{}, fn (z vphp.ZVal) &VSlimPsr7Stream {
			return zval_to_psr7_stream(z)
		})
	} else {
		new_psr7_stream('')
	}
	uri_ref := if request.method_exists('getUri') {
		vphp.with_method_result_zval(request, 'getUri', []vphp.ZVal{}, fn (z vphp.ZVal) &VSlimPsr7Uri {
			return zval_to_psr7_uri(z)
		})
	} else {
		new_psr7_uri('/')
	}
	server_params_ref := if request.method_exists('getServerParams') {
		vphp.with_method_result_zval(request, 'getServerParams', []vphp.ZVal{}, fn (z vphp.ZVal) vphp.PersistentOwnedZBox {
			return persistent_array_owned(z)
		})
	} else {
		empty_persistent_array()
	}
	cookie_params_ref := if request.method_exists('getCookieParams') {
		vphp.with_method_result_zval(request, 'getCookieParams', []vphp.ZVal{}, fn (z vphp.ZVal) vphp.PersistentOwnedZBox {
			return persistent_array_owned(z)
		})
	} else {
		empty_persistent_array()
	}
	query_params_ref := if request.method_exists('getQueryParams') {
		vphp.with_method_result_zval(request, 'getQueryParams', []vphp.ZVal{}, fn (z vphp.ZVal) vphp.PersistentOwnedZBox {
			return persistent_array_owned(z)
		})
	} else {
		empty_persistent_array()
	}
	uploaded_files_ref := if request.method_exists('getUploadedFiles') {
		vphp.with_method_result_zval(request, 'getUploadedFiles', []vphp.ZVal{}, fn (z vphp.ZVal) vphp.PersistentOwnedZBox {
			return normalize_uploaded_files_tree(z)
		})
	} else {
		empty_persistent_array()
	}
	parsed_body_ref := if request.method_exists('getParsedBody') {
		vphp.with_method_result_zval(request, 'getParsedBody', []vphp.ZVal{}, fn (z vphp.ZVal) vphp.PersistentOwnedZBox {
			return persistent_owned_or_null(z)
		})
	} else {
		vphp.PersistentOwnedZBox.new_null()
	}
	attributes_ref := if request.method_exists('getAttributes') {
		vphp.with_method_result_zval(request, 'getAttributes', []vphp.ZVal{}, fn [route_params] (z vphp.ZVal) vphp.PersistentOwnedZBox {
			base := persistent_array_owned(z)
			if route_params.len == 0 {
				return clone_assoc_payload_ref(base)
			}
			return persistent_assoc_with_strings(base, route_params)
		})
	} else {
		persistent_assoc_with_strings(empty_persistent_array(), route_params)
	}
	return build_php_psr7_server_request_object(&VSlimPsr7ServerRequest{
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
	})
}

fn build_php_psr7_server_request_from_vslim(req &VSlimRequest, route_params map[string]string) vphp.ZVal {
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
	return build_php_psr7_server_request_object(&VSlimPsr7ServerRequest{
		method:             normalize_psr7_method(req.method)
		request_target:     req.raw_path
		protocol_version:   normalize_protocol_version(req.protocol_version)
		headers:            headers
		header_names:       header_names
		body_ref:           new_psr7_stream(req.body)
		uri_ref:            new_psr7_uri(vslim_request_uri_string(req))
		server_params_ref:  string_map_to_persistent_array(req.server_params())
		cookie_params_ref:  string_map_to_persistent_array(req.cookies())
		query_params_ref:   string_map_to_persistent_array(req.query_params())
		uploaded_files_ref: empty_persistent_array()
		parsed_body_ref:    vphp.PersistentOwnedZBox.invalid()
		attributes_ref:     persistent_attrs_from_request(req, route_params)
	})
}

fn persistent_attrs_from_request(req &VSlimRequest, route_params map[string]string) vphp.PersistentOwnedZBox {
	mut attrs := empty_persistent_array()
	for key, value in req.attributes() {
		attrs = persistent_assoc_with_value(attrs, key, vphp.RequestOwnedZBox.new_string(value).to_zval())
	}
	return persistent_assoc_with_strings(attrs, route_params)
}

fn persistent_assoc_with_strings(value vphp.PersistentOwnedZBox, extras map[string]string) vphp.PersistentOwnedZBox {
	mut out := new_array_zval()
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		value.with_request_zval(fn [mut out] (raw vphp.ZVal) bool {
			raw.foreach(fn [mut out] (key vphp.ZVal, val vphp.ZVal) {
				if key.is_string() {
					add_assoc_zval(out, key.get_string(), val.dup())
				}
			})
			return true
		})
	}
	for key, item in extras {
		add_assoc_zval(out, key, vphp.RequestOwnedZBox.new_string(item).to_zval())
	}
	return vphp.PersistentOwnedZBox.of(out)
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

fn new_vslim_request_from_psr_server_request(payload vphp.RequestBorrowedZBox, route_params map[string]string) &VSlimRequest {
	if payload.is_valid() && payload.to_zval().is_object()
		&& (payload.to_zval().is_instance_of('VSlim\\VHttpd\\Request')
		|| payload.to_zval().is_instance_of('VSlimRequest')) {
		if req := payload.to_zval().to_object[VSlimRequest]() {
			mut cloned := req.to_vslim_request()
			cloned.params = snapshot_string_map(route_params)
			return &cloned
		}
	}
	request := normalize_psr15_server_request_payload(payload, route_params)
	if internal := request.to_object[VSlimPsr7ServerRequest]() {
		uri := server_request_uri_or_default(internal)
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
			body:             psr7_stream_string(server_request_body_or_empty(internal))
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
			attributes:       snapshot_string_map(persistent_array_to_scalar_string_map(internal.attributes_ref))
			server:           snapshot_string_map(persistent_array_to_string_map(internal.server_params_ref))
			uploaded_files:   snapshot_string_list(uploaded_files_to_filenames_zval(internal.get_uploaded_files().to_zval()))
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
	return new_vslim_request('GET', '/', '')
}

fn uploaded_files_to_filenames(files map[string]vphp.ZVal) []string {
	mut out := []string{}
	for _, item in files {
		if !item.is_valid() || !item.is_object() {
			continue
		}
		filename := if item.method_exists('getClientFilename') {
			vphp.with_method_result_zval(item, 'getClientFilename', []vphp.ZVal{}, fn (result vphp.ZVal) string {
				return result.to_string()
			})
		} else {
			''
		}
		if filename != '' && filename !in out {
			out << filename
		}
	}
	return out
}

fn uploaded_files_to_filenames_zval(files vphp.ZVal) []string {
	if !files.is_valid() || !files.is_array() {
		return []string{}
	}
	mut out := []string{}
	files.foreach(fn [mut out] (_ vphp.ZVal, item vphp.ZVal) {
		if !item.is_valid() || !item.is_object() {
			return
		}
		filename := if item.method_exists('getClientFilename') {
			vphp.with_method_result_zval(item, 'getClientFilename', []vphp.ZVal{}, fn (result vphp.ZVal) string {
				return result.to_string()
			})
		} else {
			''
		}
		if filename != '' && filename !in out {
			out << filename
		}
	})
	return out
}

fn zval_to_psr7_header_state(value vphp.ZVal) (map[string][]string, map[string]string) {
	mut out := map[string][]string{}
	mut header_names := map[string]string{}
	if !value.is_valid() || !value.is_array() {
		return out, header_names
	}
	value.foreach(fn [mut out, mut header_names] (key vphp.ZVal, child vphp.ZVal) {
		name := key.to_string()
		normalized := normalize_psr7_header_name(name)
		out[normalized] = zval_to_header_values(child) or { []string{} }
		header_names[normalized] = name
	})
	return out, header_names
}

fn flatten_psr7_header_map(headers map[string][]string) map[string]string {
	mut out := map[string]string{}
	for key, values in headers {
		out[key] = values.join(', ')
	}
	return out
}

fn zval_map_to_string_map(values map[string]vphp.ZVal) map[string]string {
	mut out := map[string]string{}
	for key, value in values {
		if !value.is_valid() || value.is_null() || value.is_undef() {
			out[key] = ''
			continue
		}
		if !value.is_string() && !value.is_bool() && !value.is_long() && !value.is_double() {
			continue
		}
		out[key] = value.to_string()
	}
	return out
}

fn zval_assoc_scalar_string_map(value vphp.ZVal) map[string]string {
	if !value.is_valid() || !value.is_array() {
		return map[string]string{}
	}
	return value.foreach_with_ctx[map[string]string](map[string]string{}, fn (key vphp.ZVal, child vphp.ZVal, mut acc map[string]string) {
		acc[key.to_string()] = vphp.stringify_value(child)
	})
}

fn persistent_array_to_scalar_string_map(value vphp.PersistentOwnedZBox) map[string]string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return map[string]string{}
	}
	return value.with_request_zval(fn (z vphp.ZVal) map[string]string {
		return zval_assoc_scalar_string_map(z)
	})
}

fn psr7_stream_string(stream &VSlimPsr7Stream) string {
	if stream == unsafe { nil } {
		return ''
	}
	return stream.stream_string()
}

fn new_psr7_response_from_vslim_response(res VSlimResponse) &VSlimPsr7Response {
	mut headers := map[string][]string{}
	for key, value in res.headers() {
		headers[normalize_psr7_header_name(key)] = [value]
	}
	return &VSlimPsr7Response{
		status:           normalize_psr7_status(res.status)
		reason_phrase:    normalize_reason_phrase(res.status, '').clone()
		protocol_version: '1.1'
		headers:          clone_header_values(headers)
		body_ref:         new_psr7_stream(res.body.clone())
	}
}

fn new_vslim_response_from_psr_response(res &VSlimPsr7Response) VSlimResponse {
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
		body:         psr7_stream_string(response_body_or_empty(res)).clone()
		content_type: content_type.clone()
		headers:      snapshot_string_map(headers)
	}
}

fn new_psr7_text_response(status int, body string) &VSlimPsr7Response {
	return new_psr7_response_from_vslim_response(text_response(status, body))
}

fn new_psr7_json_response(status int, json_body string) &VSlimPsr7Response {
	return new_psr7_response_from_vslim_response(json_response(status, json_body))
}

fn normalize_to_psr7_response(result vphp.ZVal) &VSlimPsr7Response {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return new_psr7_response_from_vslim_response(text_response(200, ''))
	}
	if result.is_object() && (result.is_instance_of('VSlim\\Psr7\\Response')
		|| result.is_instance_of('VSlimPsr7Response')) {
		if resp := result.to_object[VSlimPsr7Response]() {
			return clone_psr7_response(resp, resp.get_protocol_version(), clone_header_values(resp.headers),
				clone_header_names(resp.header_names), response_body_or_empty(resp), resp.get_status_code(),
				resp.get_reason_phrase())
		}
	}
	if result.is_object() && result.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
		status := if result.method_exists('getStatusCode') {
			int(vphp.with_method_result_zval(result, 'getStatusCode', []vphp.ZVal{}, fn (z vphp.ZVal) i64 {
				return z.to_i64()
			}))
		} else {
			200
		}
		reason := if result.method_exists('getReasonPhrase') {
			vphp.with_method_result_zval(result, 'getReasonPhrase', []vphp.ZVal{}, fn (z vphp.ZVal) string {
				return z.to_string()
			})
		} else {
			''
		}
		protocol := if result.method_exists('getProtocolVersion') {
			vphp.with_method_result_zval(result, 'getProtocolVersion', []vphp.ZVal{}, fn (z vphp.ZVal) string {
				return z.to_string()
			})
		} else {
			'1.1'
		}
		headers, header_names := if result.method_exists('getHeaders') {
			mut headers_z := vphp.method_request_owned_box(result, 'getHeaders', []vphp.ZVal{})
			defer {
				headers_z.release()
			}
			zval_to_psr7_header_state(headers_z.to_zval())
		} else {
			map[string][]string{}, map[string]string{}
		}
		body_ref := if result.method_exists('getBody') {
			vphp.with_method_result_zval(result, 'getBody', []vphp.ZVal{}, fn (z vphp.ZVal) &VSlimPsr7Stream {
				return clone_psr7_stream(zval_to_psr7_stream(z))
			})
		} else {
			new_psr7_stream('')
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
	res, ok := normalize_php_route_response_psr(result)
	if ok {
		return res
	}
	return new_psr7_response_from_vslim_response(text_response(500, 'Invalid route response'))
}

module main

import vphp

fn route_params_from_payload(payload vphp.BorrowedZVal) map[string]string {
	if !payload.is_valid() || !payload.to_zval().is_object() {
		return map[string]string{}
	}
	raw := payload.to_zval()
	if raw.is_instance_of('VSlim\\Vhttpd\\Request') || raw.is_instance_of('VSlimRequest') {
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
		server_params_ref:  vphp.PersistentOwnedZVal.from_zval(snapshot.server_params_ref.to_zval())
		cookie_params_ref:  vphp.PersistentOwnedZVal.from_zval(snapshot.cookie_params_ref.to_zval())
		query_params_ref:   vphp.PersistentOwnedZVal.from_zval(snapshot.query_params_ref.to_zval())
		uploaded_files_ref: vphp.PersistentOwnedZVal.from_zval(snapshot.uploaded_files_ref.to_zval())
		parsed_body_ref:    vphp.PersistentOwnedZVal.from_zval(snapshot.parsed_body_ref.to_zval())
		attributes_ref:     vphp.PersistentOwnedZVal.from_zval(snapshot.attributes_ref.to_zval())
	}
}

fn snapshot_phase_forwarded_request(payload vphp.BorrowedZVal) ?PhaseForwardedServerRequestSnapshot {
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
			uri_host:           uri.host
			uri_port:           uri.port
			uri_path:           uri.path
			uri_query:          uri.query
			uri_fragment:       uri.fragment
			header_names:       clone_header_names(internal.header_names)
			server_params_ref:  vphp.PersistentOwnedZVal.from_zval(internal.server_params_ref.to_zval())
			cookie_params_ref:  vphp.PersistentOwnedZVal.from_zval(internal.cookie_params_ref.to_zval())
			query_params_ref:   vphp.PersistentOwnedZVal.from_zval(internal.query_params_ref.to_zval())
			uploaded_files_ref: vphp.PersistentOwnedZVal.from_zval(internal.uploaded_files_ref.to_zval())
			parsed_body_ref:    vphp.PersistentOwnedZVal.from_zval(internal.parsed_body_ref.to_zval())
			attributes_ref:     vphp.PersistentOwnedZVal.from_zval(internal.attributes_ref.to_zval())
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

fn request_with_forwarded_snapshot(payload vphp.BorrowedZVal, route_params map[string]string, snapshot PhaseForwardedServerRequestSnapshot) vphp.ZVal {
	normalized := normalize_psr15_server_request_payload(payload, route_params)
	if _ := normalized.to_object[VSlimPsr7ServerRequest]() {
		attrs_owned := persistent_assoc_with_strings(snapshot.attributes_ref, route_params)
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
			server_params_ref:  vphp.PersistentOwnedZVal.from_zval(snapshot.server_params_ref.to_zval())
			cookie_params_ref:  vphp.PersistentOwnedZVal.from_zval(snapshot.cookie_params_ref.to_zval())
			query_params_ref:   vphp.PersistentOwnedZVal.from_zval(snapshot.query_params_ref.to_zval())
			uploaded_files_ref: vphp.PersistentOwnedZVal.from_zval(snapshot.uploaded_files_ref.to_zval())
			parsed_body_ref:    vphp.PersistentOwnedZVal.from_zval(snapshot.parsed_body_ref.to_zval())
			attributes_ref:     attrs_owned
		})
	}
	return normalized
}

fn continued_phase_request_payload(payload vphp.BorrowedZVal, route_params map[string]string, cont &VSlimPsr15ContinueHandler) vphp.RequestOwnedZVal {
	if cont.state.has_forwarded_request {
		if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(cont)) {
			return vphp.RequestOwnedZVal.from_zval(request_with_forwarded_snapshot(payload,
				route_params, forwarded_request))
		}
	}
	return vphp.RequestOwnedZVal.from_zval(normalize_psr15_server_request_payload(payload,
		route_params))
}

fn build_php_request_object(req &VSlimRequest, params map[string]string) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		mut bound := &VSlimRequest{
			method:           req.method
			raw_path:         req.raw_path
			path:             req.path
			body:             req.body
			query_string:     req.query_string
			scheme:           req.scheme
			host:             req.host
			port:             req.port
			protocol_version: req.protocol_version
			remote_addr:      req.remote_addr
			query:            req.query.clone()
			headers:          req.headers.clone()
			cookies:          req.cookies.clone()
			attributes:       req.attributes.clone()
			server:           req.server.clone()
			uploaded_files:   req.uploaded_files.clone()
			params:           params.clone()
		}
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__vhttpd__request_ce,
			&C.vphp_class_handlers(vslimrequest_handlers()))
		return payload
	}
}

fn build_php_response_object(res VSlimResponse) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		bound := to_vslim_response(res)
		vphp.return_owned_object_raw(payload.raw, bound, C.vslim__vhttpd__response_ce,
			&C.vphp_class_handlers(vslimresponse_handlers()))
		return payload
	}
}

fn build_php_psr7_server_request_object(req &VSlimPsr7ServerRequest) vphp.ZVal {
	unsafe {
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		vphp.return_owned_object_raw(payload.raw, req, C.vslim__psr7__serverrequest_ce,
			&C.vphp_class_handlers(vslimpsr7serverrequest_handlers()))
		return payload
	}
}

fn normalize_psr15_server_request_payload(payload vphp.BorrowedZVal, route_params map[string]string) vphp.ZVal {
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
				body_ref:           server_request_body_or_empty(internal)
				uri_ref:            server_request_uri_or_default(internal)
				server_params_ref:  vphp.PersistentOwnedZVal.from_zval(internal.server_params_ref.to_zval())
				cookie_params_ref:  vphp.PersistentOwnedZVal.from_zval(internal.cookie_params_ref.to_zval())
				query_params_ref:   vphp.PersistentOwnedZVal.from_zval(internal.query_params_ref.to_zval())
				uploaded_files_ref: vphp.PersistentOwnedZVal.from_zval(internal.uploaded_files_ref.to_zval())
				parsed_body_ref:    vphp.PersistentOwnedZVal.from_zval(internal.parsed_body_ref.to_zval())
				attributes_ref:     persistent_assoc_with_strings(internal.attributes_ref,
					route_params)
			})
		}
	}
	if payload.is_valid() && payload.to_zval().is_object()
		&& (payload.to_zval().is_instance_of('VSlim\\Vhttpd\\Request')
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
		request.method_owned_request('getMethod', []).to_string()
	} else {
		'GET'
	}
	request_target := if request.method_exists('getRequestTarget') {
		request.method_owned_request('getRequestTarget', []).to_string()
	} else {
		''
	}
	protocol_version := if request.method_exists('getProtocolVersion') {
		request.method_owned_request('getProtocolVersion', []).to_string()
	} else {
		'1.1'
	}
	header_map, header_names := if request.method_exists('getHeaders') {
		zval_to_psr7_header_state(request.method_owned_request('getHeaders', []))
	} else {
		map[string][]string{}, map[string]string{}
	}
	body_ref := if request.method_exists('getBody') {
		zval_to_psr7_stream(request.method_owned_request('getBody', []))
	} else {
		new_psr7_stream('')
	}
	uri_ref := if request.method_exists('getUri') {
		zval_to_psr7_uri(request.method_owned_request('getUri', []))
	} else {
		new_psr7_uri('/')
	}
	server_params_ref := if request.method_exists('getServerParams') {
		persistent_array_owned(request.method_owned_request('getServerParams', []))
	} else {
		empty_persistent_array()
	}
	cookie_params_ref := if request.method_exists('getCookieParams') {
		persistent_array_owned(request.method_owned_request('getCookieParams', []))
	} else {
		empty_persistent_array()
	}
	query_params_ref := if request.method_exists('getQueryParams') {
		persistent_array_owned(request.method_owned_request('getQueryParams', []))
	} else {
		empty_persistent_array()
	}
	uploaded_files_ref := if request.method_exists('getUploadedFiles') {
		normalize_uploaded_files_tree(request.method_owned_request('getUploadedFiles',
			[]))
	} else {
		empty_persistent_array()
	}
	parsed_body_ref := if request.method_exists('getParsedBody') {
		persistent_owned_or_null(request.method_owned_request('getParsedBody', []))
	} else {
		vphp.PersistentOwnedZVal.new_null()
	}
	attributes_ref := if request.method_exists('getAttributes') {
		persistent_assoc_with_strings(persistent_array_owned(request.method_owned_request('getAttributes',
			[])), route_params)
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
		parsed_body_ref:    vphp.PersistentOwnedZVal.new_null()
		attributes_ref:     persistent_attrs_from_request(req, route_params)
	})
}

fn persistent_attrs_from_request(req &VSlimRequest, route_params map[string]string) vphp.PersistentOwnedZVal {
	mut attrs := empty_persistent_array()
	for key, value in req.attributes() {
		attrs = persistent_assoc_with_value(attrs, key, vphp.RequestOwnedZVal.new_string(value).to_zval())
	}
	return persistent_assoc_with_strings(attrs, route_params)
}

fn persistent_assoc_with_strings(value vphp.PersistentOwnedZVal, extras map[string]string) vphp.PersistentOwnedZVal {
	mut out := new_array_zval()
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		raw := value.clone_request_owned().to_zval()
		for existing_key in raw.assoc_keys() {
			add_assoc_zval(out, existing_key, raw.get(existing_key) or { continue })
		}
	}
	for key, item in extras {
		add_assoc_zval(out, key, vphp.RequestOwnedZVal.new_string(item).to_zval())
	}
	return vphp.PersistentOwnedZVal.from_zval(out)
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
	mut path := req.path.trim_space()
	if path == '' {
		path = '/'
	}
	uri += path
	query := req.query_string.trim_space()
	if query != '' {
		uri += '?${query}'
	}
	return uri
}

fn new_vslim_request_from_psr_server_request(payload vphp.BorrowedZVal, route_params map[string]string) &VSlimRequest {
	if payload.is_valid() && payload.to_zval().is_object()
		&& (payload.to_zval().is_instance_of('VSlim\\Vhttpd\\Request')
		|| payload.to_zval().is_instance_of('VSlimRequest')) {
		if req := payload.to_zval().to_object[VSlimRequest]() {
			mut cloned := req.to_vslim_request()
			cloned.params = route_params.clone()
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
			query:            query_params
			headers:          flatten_psr7_header_map(internal.get_headers())
			cookies:          persistent_array_to_string_map(internal.cookie_params_ref)
			attributes:       zval_map_to_string_map(internal.get_attributes().to_zval().to_v[map[string]vphp.ZVal]() or { map[string]vphp.ZVal{} })
			server:           persistent_array_to_string_map(internal.server_params_ref)
			uploaded_files:   uploaded_files_to_filenames(internal.get_uploaded_files().to_zval().to_v[map[string]vphp.ZVal]() or { map[string]vphp.ZVal{} })
			params:           route_params.clone()
		}
		for key, value in route_params {
			if key !in out.attributes {
				out.attributes[key] = value
			}
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
			item.method_owned_request('getClientFilename', []).to_string()
		} else {
			''
		}
		if filename != '' && filename !in out {
			out << filename
		}
	}
	return out
}

fn zval_to_psr7_header_state(value vphp.ZVal) (map[string][]string, map[string]string) {
	mut out := map[string][]string{}
	mut header_names := map[string]string{}
	if !value.is_valid() || !value.is_array() {
		return out, header_names
	}
	for key in value.assoc_keys() {
		child := value.get(key) or { continue }
		normalized := normalize_psr7_header_name(key)
		out[normalized] = zval_to_header_values(child) or { []string{} }
		header_names[normalized] = key
	}
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
		reason_phrase:    normalize_reason_phrase(res.status, '')
		protocol_version: '1.1'
		headers:          headers
		body_ref:         new_psr7_stream(res.body)
	}
}

fn normalize_to_psr7_response(result vphp.ZVal) &VSlimPsr7Response {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return new_psr7_response_from_vslim_response(text_response(200, ''))
	}
	if result.is_object() && (result.is_instance_of('VSlim\\Psr7\\Response')
		|| result.is_instance_of('VSlimPsr7Response')) {
		if resp := result.to_object[VSlimPsr7Response]() {
			return clone_psr7_response(resp, resp.get_protocol_version(), resp.headers.clone(),
				clone_header_names(resp.header_names), response_body_or_empty(resp), resp.get_status_code(),
				resp.get_reason_phrase())
		}
	}
	if result.is_object() && result.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
		status := if result.method_exists('getStatusCode') {
			int(result.method_owned_request('getStatusCode', []).to_i64())
		} else {
			200
		}
		reason := if result.method_exists('getReasonPhrase') {
			result.method_owned_request('getReasonPhrase', []).to_string()
		} else {
			''
		}
		protocol := if result.method_exists('getProtocolVersion') {
			result.method_owned_request('getProtocolVersion', []).to_string()
		} else {
			'1.1'
		}
		headers, header_names := if result.method_exists('getHeaders') {
			zval_to_psr7_header_state(result.method_owned_request('getHeaders', []))
		} else {
			map[string][]string{}, map[string]string{}
		}
		body_ref := if result.method_exists('getBody') {
			zval_to_psr7_stream(result.method_owned_request('getBody', []))
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
	res, ok := normalize_php_route_response(result)
	if ok {
		return new_psr7_response_from_vslim_response(res)
	}
	return new_psr7_response_from_vslim_response(text_response(500, 'Invalid route response'))
}

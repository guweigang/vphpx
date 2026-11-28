module httpx

import vphp

pub fn route_params_from_payload(payload vphp.PhpValue) map[string]string {
	object := payload.as_object() or { return map[string]string{} }
	if object.is_instance_of('VSlim\\VHttpd\\Request') || object.is_instance_of('VSlimRequest') {
		if req := object.to_v_object[VSlimRequest]() {
			return req.route_params()
		}
	}
	return map[string]string{}
}

pub fn vslim_request_build_value(req &VSlimRequest, params map[string]string) vphp.PhpValue {
	unsafe {
		mut bound := req.boxed_snapshot_with_params(params)
		return vphp.bind_owned_object_value[VSlimRequest](bound)
	}
}

pub fn vslim_response_to_value(res VSlimResponse) vphp.PhpValue {
	unsafe {
		bound := res.boxed_snapshot()
		return vphp.bind_owned_object_value[VSlimResponse](bound)
	}
}

pub fn vslim_response_ref_to_value(res &VSlimResponse) vphp.PhpValue {
	unsafe {
		bound := res.boxed_snapshot_ref()
		return vphp.bind_owned_object_value[VSlimResponse](bound)
	}
}

pub fn object_from_owned_value(mut value vphp.PhpValue) vphp.PhpObject {
	object := value.as_object() or {
		value.release()
		return vphp.PhpObject.invalid()
	}
	value.release()
	return object
}

pub fn normalize_psr15_server_request_object(request vphp.PhpObject, route_params map[string]string) vphp.PhpObject {
	if (request.is_instance_of('VSlim\\Psr7\\ServerRequest') || request.is_instance_of('VSlimPsr7'))
		&& request.is_valid() {
		if internal := request.to_v_object[VSlimPsr7ServerRequest]() {
			attrs := if route_params.len == 0 {
				clone_assoc_payload_value(internal.attributes_ref)
			} else {
				persistent_value_assoc_with_strings(internal.attributes_ref, route_params)
			}
			cloned := internal.clone_with_owned_attrs(internal.method, internal.get_request_target(),
				internal.get_protocol_version(), internal.headers, internal.header_names,
				internal.body_ref, internal.uri_or_default(), internal.server_params_ref,
				internal.cookie_params_ref, internal.query_params_ref, internal.uploaded_files_ref,
				internal.parsed_body_ref, attrs)
			mut value := vphp.bind_owned_object_value[VSlimPsr7ServerRequest](cloned)
			return object_from_owned_value(mut value)
		}
	}
	if request.is_instance_of('VSlim\\VHttpd\\Request') || request.is_instance_of('VSlimRequest') {
		if req := request.to_v_object[VSlimRequest]() {
			mut cloned := VSlimPsr7ServerRequest.from_vslim_request_value(req, route_params)
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
		mut headers := request.call_method_by_value('getHeaders')
		defer {
			headers.release()
		}
		psr7_header_state_from_value(headers)
	} else {
		map[string][]string{}, map[string]string{}
	}
	body_ref, body_pending := import_psr7_body(request)
	uri_ref := if request.method_exists('getUri') {
		mut uri := request.call_method_by_value('getUri')
		defer {
			uri.release()
		}
		VSlimPsr7Uri.from_value(uri)
	} else {
		VSlimPsr7Uri.from_string('/')
	}
	server_params_ref := if request.method_exists('getServerParams') {
		request.with_method_result[vphp.PhpArray, vphp.PhpArray]('getServerParams', fn (z vphp.PhpArray) vphp.PhpArray {
			return z.retain()
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	cookie_params_ref := if request.method_exists('getCookieParams') {
		request.with_method_result[vphp.PhpArray, vphp.PhpArray]('getCookieParams', fn (z vphp.PhpArray) vphp.PhpArray {
			return z.retain()
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	query_params_ref := if request.method_exists('getQueryParams') {
		request.with_method_result[vphp.PhpArray, vphp.PhpArray]('getQueryParams', fn (z vphp.PhpArray) vphp.PhpArray {
			return z.retain()
		}) or { empty_persistent_array() }
	} else {
		empty_persistent_array()
	}
	uploaded_files_ref := if request.method_exists('getUploadedFiles') {
		mut uploaded := request.call_method_by_value('getUploadedFiles')
		defer {
			uploaded.release()
		}
		normalize_uploaded_files_tree_value(uploaded)
	} else {
		empty_persistent_array()
	}
	parsed_body_ref := if request.method_exists('getParsedBody') {
		mut parsed := request.call_method_by_value('getParsedBody')
		defer {
			parsed.release()
		}
		if parsed.is_valid() && !parsed.is_null() && !parsed.is_undef() {
			parsed.retain()
		} else {
			persistent_null_value()
		}
	} else {
		persistent_null_value()
	}
	attributes_ref := if request.method_exists('getAttributes') {
		request.with_method_result[vphp.PhpArray, vphp.PhpValue]('getAttributes', fn [route_params] (z vphp.PhpArray) vphp.PhpValue {
			base := persistent_array_value(z.to_value())
			if route_params.len == 0 {
				return clone_assoc_payload_value(base)
			}
			return persistent_value_assoc_with_strings(base, route_params)
		}) or { persistent_value_assoc_with_strings(empty_persistent_array_value(), route_params) }
	} else {
		persistent_value_assoc_with_strings(empty_persistent_array_value(), route_params)
	}
	normalized := &VSlimPsr7ServerRequest{
		method:             normalize_method(method)
		request_target:     request_target
		protocol_version:   normalize_protocol_version(protocol_version)
		headers:            header_map
		header_names:       header_names
		body_ref:           body_ref
		body_pending:       body_pending
		uri_ref:            uri_ref
		server_params_ref:  server_params_ref
		cookie_params_ref:  cookie_params_ref
		query_params_ref:   query_params_ref
		uploaded_files_ref: uploaded_files_ref
		parsed_body_ref:    parsed_body_ref
		attributes_ref:     attributes_ref
	}
	mut value := vphp.bind_owned_object_value[VSlimPsr7ServerRequest](normalized)
	return object_from_owned_value(mut value)
}

pub fn normalize_psr15_server_request_value(payload_value vphp.PhpValue, route_params map[string]string) vphp.PhpObject {
	mut request_value := payload_value.to_request_owned()
	defer { request_value.release() }
	mut payload_object := request_value.as_object() or {
		mut cloned := VSlimPsr7ServerRequest.from_vslim_request_value(VSlimRequest.new('GET', '/', ''),
			route_params)
		return object_from_owned_value(mut cloned)
	}
	defer { payload_object.release() }
	return normalize_psr15_server_request_object(payload_object, route_params)
}

pub fn normalize_psr15_server_request(payload vphp.PhpValue, route_params map[string]string) vphp.PhpObject {
	return normalize_psr15_server_request_value(payload, route_params)
}

pub fn persistent_array_value(value vphp.PhpValue) vphp.PhpValue {
	if value.is_valid() && !value.is_null() && !value.is_undef() && value.is_array() {
		return value.retain()
	}
	return empty_persistent_array_value()
}

pub fn vslim_request_from_psr_server_request(payload vphp.PhpValue, route_params map[string]string, options PsrRequestProjectionOptions) &VSlimRequest {
	mut request_value := payload.to_request_owned()
	defer { request_value.release() }
	if mut payload_object := request_value.as_object() {
		defer { payload_object.release() }
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
	return VSlimRequest.from_psr_server_request_object(request, route_params, options)
}

pub fn vslim_request_from_psr_server_request_object(payload vphp.PhpObject, route_params map[string]string) &VSlimRequest {
	return VSlimRequest.from_psr_server_request_object(payload, route_params)
}

pub fn vslim_request_from_psr_server_request_value(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
	return VSlimRequest.from_psr_server_request_value(payload, route_params)
}

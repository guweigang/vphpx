module httpx

import psrx
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
		mut headers := request.call_method('getHeaders')
		defer {
			headers.release()
		}
		psr7_header_state_from_value(headers)
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
		method:             psrx.normalize_method(method)
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

pub fn normalize_psr15_server_request_value(payload_value vphp.PhpValue, route_params map[string]string) vphp.PhpObject {
	payload_object := payload_value.as_object() or {
		mut cloned := VSlimPsr7ServerRequest.from_vslim_request_value(VSlimRequest.new('GET', '/', ''),
			route_params)
		return object_from_owned_value(mut cloned)
	}
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

pub fn vslim_request_from_psr_server_request(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
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

pub fn vslim_request_from_psr_server_request_object(payload vphp.PhpObject, route_params map[string]string) &VSlimRequest {
	return VSlimRequest.from_psr_server_request_object(payload, route_params)
}

pub fn vslim_request_from_psr_server_request_value(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
	return VSlimRequest.from_psr_server_request_value(payload, route_params)
}

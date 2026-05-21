module httpx

import vphp

pub fn VSlimPsr7Response.from_vslim_response(res VSlimResponse) &VSlimPsr7Response {
	mut headers := map[string][]string{}
	for key, value in res.headers() {
		headers[normalize_header_name(key)] = [value]
	}
	return &VSlimPsr7Response{
		status:           normalize_status(res.status)
		reason_phrase:    normalize_reason_phrase(res.status, '').clone()
		protocol_version: '1.1'
		headers:          clone_header_values(headers)
		body_ref:         VSlimPsr7Stream.from_content(res.body.clone())
	}
}

pub fn (res VSlimResponse) to_psr7_response() &VSlimPsr7Response {
	return VSlimPsr7Response.from_vslim_response(res)
}

pub fn (res &VSlimPsr7Response) to_vslim_response() VSlimResponse {
	headers := flatten_psr7_header_map(res.headers)
	content_type := headers['content-type'] or { 'text/plain; charset=utf-8' }
	return VSlimResponse{
		status:       res.status
		body:         res.body_or_empty().stream_string().clone()
		content_type: content_type.clone()
		headers:      snapshot_string_map(headers)
	}
}

pub fn VSlimPsr7Response.text(status int, body string) &VSlimPsr7Response {
	return VSlimPsr7Response.from_vslim_response(VSlimResponse.text(status, body))
}

pub fn VSlimPsr7Response.json(status int, json_body string) &VSlimPsr7Response {
	return VSlimPsr7Response.from_vslim_response(VSlimResponse.json(status, json_body))
}

pub fn (res &VSlimPsr7Response) with_allowed_methods(allowed_methods []string) &VSlimPsr7Response {
	if allowed_methods.len == 0 {
		return res
	}
	mut headers := clone_header_values(res.headers)
	mut header_names := clone_header_names(res.header_names)
	if 'allow' !in headers {
		headers['allow'] = [allowed_methods.join(', ')]
		header_names['allow'] = 'Allow'
	}
	return res.clone_with(res.protocol_version, headers, header_names, res.body_or_empty(),
		res.status, res.reason_phrase)
}

pub fn VSlimPsr7Response.from_value(result vphp.PhpValue) &VSlimPsr7Response {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return VSlimPsr7Response.text(200, '')
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
				status:           normalize_status(status)
				reason_phrase:    normalize_reason_phrase(status, reason)
				protocol_version: normalize_protocol_version(protocol)
				headers:          headers
				header_names:     header_names
				body_ref:         body_ref
			}
		}
	}
	return VSlimPsr7Response.text(500, 'Invalid route response')
}

pub fn (res &VSlimPsr7Response) build_psr7_response_value() vphp.PhpValue {
	unsafe {
		bound := res.clone_with(res.get_protocol_version(), clone_header_values(res.headers),
			clone_header_names(res.header_names), res.body_or_empty(), res.get_status_code(),
			res.get_reason_phrase())
		return vphp.bind_owned_object_value[VSlimPsr7Response](bound)
	}
}

pub fn (req &VSlimPsr7ServerRequest) build_psr7_server_request_value() vphp.PhpValue {
	unsafe {
		bound := req.clone_with(req.method, req.request_target, req.protocol_version,
			clone_header_values(req.headers), clone_header_names(req.header_names),
			req.body_or_empty(), req.uri_or_default(), req.server_params_ref,
			req.cookie_params_ref, req.query_params_ref, req.uploaded_files_ref,
			req.parsed_body_ref, req.attributes_ref)
		return vphp.bind_owned_object_value[VSlimPsr7ServerRequest](bound)
	}
}

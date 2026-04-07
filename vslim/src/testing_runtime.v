module main

import vphp

fn testing_response_object_vars(raw vphp.ZVal) map[string]vphp.ZVal {
	props := vphp.php_fn('get_object_vars').call([raw])
	if !props.is_array() {
		return {}
	}
	mut out := map[string]vphp.ZVal{}
	for key in props.assoc_keys() {
		out[key] = props.get(key) or { continue }
	}
	return out
}

fn testing_response_status(response vphp.RequestBorrowedZBox) int {
	raw := response.to_zval()
	if !raw.is_valid() || !raw.is_object() {
		return 0
	}
	props := testing_response_object_vars(raw)
	if 'status' in props {
		return props['status'].to_int()
	}
	if raw.method_exists('getStatusCode') {
		return int(vphp.with_method_result_zval(raw, 'getStatusCode', []vphp.ZVal{}, fn (z vphp.ZVal) i64 {
			return z.to_int()
		}))
	}
	return 0
}

fn testing_response_header(response vphp.RequestBorrowedZBox, name string) string {
	raw := response.to_zval()
	if !raw.is_valid() || !raw.is_object() {
		return ''
	}
	props := testing_response_object_vars(raw)
	if 'headers' in props {
		headers := props['headers'].to_string_map()
		return headers[VSlimRequest.normalize_header_name(name)] or { '' }
	}
	if raw.method_exists('getHeaderLine') {
		return vphp.with_method_result_zval(raw, 'getHeaderLine', [vphp.RequestOwnedZBox.new_string(name).to_zval()], fn (z vphp.ZVal) string {
			return z.to_string()
		})
	}
	if raw.method_exists('header') {
		return vphp.with_method_result_zval(raw, 'header', [vphp.RequestOwnedZBox.new_string(name).to_zval()], fn (z vphp.ZVal) string {
			return z.to_string()
		})
	}
	return ''
}

fn testing_response_body(response vphp.RequestBorrowedZBox) string {
	raw := response.to_zval()
	if !raw.is_valid() || !raw.is_object() {
		return ''
	}
	props := testing_response_object_vars(raw)
	if 'body' in props {
		return props['body'].to_string()
	}
	if raw.method_exists('getBody') {
		return vphp.with_method_result_zval(raw, 'getBody', []vphp.ZVal{}, fn (body_z vphp.ZVal) string {
			if body_z.is_valid() && body_z.is_object() && body_z.method_exists('getContents') {
				return vphp.with_method_result_zval(body_z, 'getContents', []vphp.ZVal{}, fn (contents vphp.ZVal) string {
					return contents.to_string()
				})
			}
			return body_z.to_string()
		})
	}
	return ''
}

fn testing_new_request(method string, uri string, body string) &VSlimPsr7ServerRequest {
	mut req := new_psr7_server_request(method, vphp.RequestOwnedZBox.new_string(uri).to_zval(),
		vphp.RequestOwnedZBox.new_null().to_zval())
	if body == '' {
		return req
	}
	return clone_psr7_server_request(req, req.method, req.request_target, req.protocol_version,
		req.headers.clone(), clone_header_names(req.header_names), new_psr7_stream(body),
		server_request_uri_or_default(req), req.server_params_ref, req.cookie_params_ref,
		req.query_params_ref, req.uploaded_files_ref, req.parsed_body_ref, req.attributes_ref)
}

fn testing_new_json_request(method string, uri string, payload vphp.ZVal) &VSlimPsr7ServerRequest {
	mut payload_box := vphp.RequestOwnedZBox.adopt_zval(payload)
	defer {
		payload_box.release()
	}
	payload_json := vphp.json_encode(payload)
	mut req := testing_new_request(method, uri, payload_json)
	mut headers := req.headers.clone()
	mut header_names := clone_header_names(req.header_names)
	headers['content-type'] = ['application/json']
	header_names['content-type'] = 'Content-Type'
	return clone_psr7_server_request(req, req.method, req.request_target, req.protocol_version,
		headers, header_names, server_request_body_or_empty(req), server_request_uri_or_default(req),
		req.server_params_ref, req.cookie_params_ref, req.query_params_ref, req.uploaded_files_ref,
		persistent_owned_or_null(payload_box.to_zval()), req.attributes_ref)
}

@[php_method]
pub fn (mut h VSlimTestingHarness) construct() &VSlimTestingHarness {
	return &h
}

@[php_method: 'setApp']
pub fn (mut h VSlimTestingHarness) set_app(app &VSlimApp) &VSlimTestingHarness {
	h.app_ref = app
	return &h
}

@[php_method]
pub fn (h &VSlimTestingHarness) app() &VSlimApp {
	return h.app_ref
}

@[php_method]
pub fn (mut h VSlimTestingHarness) container() &VSlimContainer {
	if h.app_ref == unsafe { nil } {
		return new_vslim_container()
	}
	return h.app_ref.container()
}

@[php_method: 'withService']
pub fn (mut h VSlimTestingHarness) with_service(id string, value vphp.RequestBorrowedZBox) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'testing harness app is not configured', 0)
		return &h
	}
	mut container := h.app_ref.container()
	container.set(id, value)
	return &h
}

@[php_method: 'withFactory']
pub fn (mut h VSlimTestingHarness) with_factory(id string, callable vphp.RequestBorrowedZBox) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'testing harness app is not configured', 0)
		return &h
	}
	mut container := h.app_ref.container()
	container.factory(id, callable)
	return &h
}

@[php_method: 'withConfig']
pub fn (mut h VSlimTestingHarness) with_config(path string) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'testing harness app is not configured', 0)
		return &h
	}
	h.app_ref.merge_config(path)
	return &h
}

@[php_method: 'withConfigText']
pub fn (mut h VSlimTestingHarness) with_config_text(text string) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'testing harness app is not configured', 0)
		return &h
	}
	h.app_ref.merge_config_text(text)
	return &h
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method]
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) request(method string, uri string, body string) &VSlimPsr7ServerRequest {
	return testing_new_request(method, uri, body)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'jsonRequest']
pub fn (h &VSlimTestingHarness) json_request(method string, uri string, payload vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	return testing_new_json_request(method, uri, payload.to_zval())
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_method]
pub fn (h &VSlimTestingHarness) handle(request vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return new_psr7_text_response(500, 'testing harness app is not configured')
	}
	return h.app_ref.handle(request)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleRequest']
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) handle_request(method string, uri string, body string) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return new_psr7_text_response(500, 'testing harness app is not configured')
	}
	mut req_z := build_php_psr7_server_request_object(testing_new_request(method, uri, body))
	defer {
		req_z.release()
	}
	return h.app_ref.handle(vphp.borrow_zbox(req_z))
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleJson']
pub fn (h &VSlimTestingHarness) handle_json(method string, uri string, payload vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return new_psr7_text_response(500, 'testing harness app is not configured')
	}
	mut req_z := build_php_psr7_server_request_object(testing_new_json_request(method, uri,
		payload.to_zval()))
	defer {
		req_z.release()
	}
	return h.app_ref.handle(vphp.borrow_zbox(req_z))
}

@[php_method: 'dispatchJson']
pub fn (h &VSlimTestingHarness) dispatch_json(method string, uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return to_vslim_response(new_vslim_response_from_psr_response(h.handle_json(method, uri,
		payload)))
}

@[php_method: 'responseStatus']
pub fn (h &VSlimTestingHarness) response_status(response vphp.RequestBorrowedZBox) int {
	return testing_response_status(response)
}

@[php_method: 'responseHeader']
pub fn (h &VSlimTestingHarness) response_header(response vphp.RequestBorrowedZBox, name string) string {
	return testing_response_header(response, name)
}

@[php_method: 'responseBody']
pub fn (h &VSlimTestingHarness) response_body(response vphp.RequestBorrowedZBox) string {
	return testing_response_body(response)
}

@[php_method: 'responseJson']
pub fn (h &VSlimTestingHarness) response_json(response vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(vphp.json_decode_assoc(testing_response_body(response)))
}

@[php_method: 'assertStatus']
pub fn (h &VSlimTestingHarness) assert_status(response vphp.RequestBorrowedZBox, expected int) &VSlimTestingHarness {
	actual := testing_response_status(response)
	if actual != expected {
		vphp.throw_exception_class('RuntimeException', 'expected response status ${expected}, got ${actual}', 0)
	}
	return &h
}

@[php_method: 'assertHeader']
pub fn (h &VSlimTestingHarness) assert_header(response vphp.RequestBorrowedZBox, name string, expected string) &VSlimTestingHarness {
	actual := testing_response_header(response, name)
	if actual != expected {
		vphp.throw_exception_class('RuntimeException', 'expected header ${name}=${expected}, got ${actual}', 0)
	}
	return &h
}

@[php_method: 'assertBodyContains']
pub fn (h &VSlimTestingHarness) assert_body_contains(response vphp.RequestBorrowedZBox, needle string) &VSlimTestingHarness {
	body := testing_response_body(response)
	if !body.contains(needle) {
		vphp.throw_exception_class('RuntimeException', 'expected response body to contain ${needle}', 0)
	}
	return &h
}

@[php_method]
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) dispatch(method string, uri string, body string) &VSlimResponse {
	if h.app_ref == unsafe { nil } {
		return to_vslim_response(VSlimResponse{
			status: 500
			body: 'testing harness app is not configured'
			content_type: 'text/plain; charset=utf-8'
			headers: {
				'content-type': 'text/plain; charset=utf-8'
			}
		})
	}
	return h.app_ref.dispatch_body(method, uri, body)
}

@[php_method]
pub fn (h &VSlimTestingHarness) get(uri string) &VSlimResponse {
	return h.dispatch('GET', uri, '')
}

@[php_method: 'getJson']
pub fn (h &VSlimTestingHarness) get_json(uri string) &VSlimResponse {
	return h.dispatch_json('GET', uri, vphp.RequestBorrowedZBox.null())
}

@[php_method]
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) post(uri string, body string) &VSlimResponse {
	return h.dispatch('POST', uri, body)
}

@[php_method: 'postJson']
pub fn (h &VSlimTestingHarness) post_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('POST', uri, payload)
}

@[php_method]
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) put(uri string, body string) &VSlimResponse {
	return h.dispatch('PUT', uri, body)
}

@[php_method: 'putJson']
pub fn (h &VSlimTestingHarness) put_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('PUT', uri, payload)
}

@[php_method]
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) patch(uri string, body string) &VSlimResponse {
	return h.dispatch('PATCH', uri, body)
}

@[php_method: 'patchJson']
pub fn (h &VSlimTestingHarness) patch_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('PATCH', uri, payload)
}

@[php_method]
@[php_optional_args: 'body']
pub fn (h &VSlimTestingHarness) delete(uri string, body string) &VSlimResponse {
	return h.dispatch('DELETE', uri, body)
}

@[php_method: 'deleteJson']
pub fn (h &VSlimTestingHarness) delete_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('DELETE', uri, payload)
}

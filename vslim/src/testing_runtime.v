module main

import vphp

fn testing_parse_set_cookie(header string) !(string, string) {
	head := header.split(';')[0].trim_space()
	if head == '' || !head.contains('=') {
		return error('invalid set-cookie header')
	}
	parts := head.split_nth('=', 2)
	if parts.len != 2 {
		return error('invalid set-cookie header')
	}
	return parts[0].trim_space(), parts[1]
}

fn testing_apply_cookies(request &VSlimPsr7ServerRequest, cookies map[string]string) &VSlimPsr7ServerRequest {
	if cookies.len == 0 {
		return request
	}
	mut merged := persistent_array_to_string_map(request.cookie_params_ref)
	for key, value in cookies {
		merged[key] = value
	}
	return clone_psr7_server_request(request, request.method, request.request_target,
		request.protocol_version, clone_header_values(request.headers), clone_header_names(request.header_names),
		server_request_body_or_empty(request), server_request_uri_or_default(request),
		request.server_params_ref, string_map_to_persistent_array(merged), request.query_params_ref,
		request.uploaded_files_ref, request.parsed_body_ref, request.attributes_ref)
}

fn testing_capture_response_cookie(mut h VSlimTestingHarness, response vphp.RequestBorrowedZBox) {
	header := testing_response_header(response, 'set-cookie').trim_space()
	if header == '' {
		return
	}
	name, value := testing_parse_set_cookie(header) or { return }
	if name == '' {
		return
	}
	if value == '' {
		h.cookies.delete(name)
		return
	}
	h.cookies[name] = value
}

fn testing_build_session_store(app &VSlimApp, cookies map[string]string) VSlimSessionStore {
	mut session := VSlimSessionStore{}
	session.construct()
	configure_default_session_store(mut session, app.config_ref)
	if cookie := cookies[session.cookie_name_value()] {
		session.values = session_decode_values(cookie, session.secret_value())
		session.loaded = true
	}
	return session
}

fn testing_store_session_cookie(mut h VSlimTestingHarness, session VSlimSessionStore) {
	h.cookies[session.cookie_name_value()] = session_encode_values(session.values, session.secret_value())
}

fn testing_response_object_vars(raw vphp.ZVal) map[string]vphp.ZVal {
	mut props_box := vphp.PhpFunction.named('get_object_vars').request_owned(vphp.PhpValue.from_zval(raw))
	props := props_box.take_zval()
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
		return int(vphp.PhpObject.borrowed(raw).with_method_result_zval('getStatusCode',
			fn (z vphp.ZVal) i64 {
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
		headers_z := props['headers'] or { return '' }
		headers := headers_z.to_string_map()
		return headers[VSlimRequest.normalize_header_name(name)] or { '' }
	}
	if raw.method_exists('getHeaderLine') {
		return vphp.PhpObject.borrowed(raw).with_method_result_zval('getHeaderLine', fn (z vphp.ZVal) string {
			return z.to_string()
		}, vphp.RequestOwnedZBox.new_string(name).to_zval())
	}
	if raw.method_exists('header') {
		return vphp.PhpObject.borrowed(raw).with_method_result_zval('header', fn (z vphp.ZVal) string {
			return z.to_string()
		}, vphp.RequestOwnedZBox.new_string(name).to_zval())
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
		body_z := props['body'] or { return '' }
		return body_z.to_string()
	}
	if raw.method_exists('getBody') {
		return vphp.PhpObject.borrowed(raw).with_method_result_zval('getBody', fn (body_z vphp.ZVal) string {
			if body_z.is_valid() && body_z.is_object() && body_z.method_exists('getContents') {
				return vphp.PhpObject.borrowed(body_z).with_method_result_zval('getContents',
					fn (contents vphp.ZVal) string {
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
		clone_header_values(req.headers), clone_header_names(req.header_names), new_psr7_stream(body),
		server_request_uri_or_default(req), req.server_params_ref, req.cookie_params_ref,
		req.query_params_ref, req.uploaded_files_ref, req.parsed_body_ref, req.attributes_ref)
}

fn testing_new_json_request(method string, uri string, payload vphp.ZVal) &VSlimPsr7ServerRequest {
	mut payload_box := vphp.RequestOwnedZBox.adopt_zval(payload)
	defer {
		payload_box.release()
	}
	payload_json := vphp.PhpJson.encode(payload)
	mut req := testing_new_request(method, uri, payload_json)
	mut headers := clone_header_values(req.headers)
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
	h.cookies = map[string]string{}
	return h
}

@[php_method: 'setApp']
pub fn (mut h VSlimTestingHarness) set_app(app &VSlimApp) &VSlimTestingHarness {
	h.app_ref = app
	return h
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
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut container := h.app_ref.container()
	container.set(id, value)
	return h
}

@[php_method: 'withFactory']
pub fn (mut h VSlimTestingHarness) with_factory(id string, callable vphp.RequestBorrowedZBox) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut container := h.app_ref.container()
	container.factory(id, callable)
	return h
}

@[php_method: 'withConfig']
pub fn (mut h VSlimTestingHarness) with_config(path string) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	h.app_ref.merge_config(path)
	return h
}

@[php_method: 'withConfigText']
pub fn (mut h VSlimTestingHarness) with_config_text(text string) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	h.app_ref.merge_config_text(text)
	return h
}

@[php_method: 'withCookie']
pub fn (mut h VSlimTestingHarness) with_cookie(name string, value string) &VSlimTestingHarness {
	key := name.trim_space()
	if key == '' {
		return h
	}
	h.cookies[key] = value
	return h
}

@[php_method: 'withoutCookie']
pub fn (mut h VSlimTestingHarness) without_cookie(name string) &VSlimTestingHarness {
	key := name.trim_space()
	if key == '' {
		return h
	}
	h.cookies.delete(key)
	return h
}

@[php_method: 'clearCookies']
pub fn (mut h VSlimTestingHarness) clear_cookies() &VSlimTestingHarness {
	h.cookies = map[string]string{}
	return h
}

@[php_method]
pub fn (h &VSlimTestingHarness) cookies() map[string]string {
	return snapshot_string_map(h.cookies)
}

@[php_method: 'withSession']
pub fn (mut h VSlimTestingHarness) with_session(values vphp.RequestBorrowedZBox) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut session := testing_build_session_store(h.app_ref, h.cookies)
	for key, value in values.to_zval().to_string_map() {
		session.values[key] = value
	}
	testing_store_session_cookie(mut h, session)
	return h
}

@[php_arg_name: 'user_id=userId']
@[php_method: 'actingAs']
pub fn (mut h VSlimTestingHarness) acting_as(user_id string) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut session := testing_build_session_store(h.app_ref, h.cookies)
	mut guard := VSlimAuthSessionGuard{}
	guard.construct()
	guard.set_store(&session)
	configure_default_auth_guard(mut guard, h.app_ref.config_ref)
	guard.login(user_id)
	testing_store_session_cookie(mut h, session)
	return h
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) request(method string, uri string, body string) &VSlimPsr7ServerRequest {
	return testing_apply_cookies(testing_new_request(method, uri, body), h.cookies)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'jsonRequest']
pub fn (h &VSlimTestingHarness) json_request(method string, uri string, payload vphp.RequestBorrowedZBox) &VSlimPsr7ServerRequest {
	return testing_apply_cookies(testing_new_json_request(method, uri, payload.to_zval()),
		h.cookies)
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (h &VSlimTestingHarness) handle(request vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return new_psr7_text_response(500, 'testing harness app is not configured')
	}
	response := h.app_ref.handle(request)
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_z := build_php_psr7_response_object(response)
		defer {
			response_z.release()
		}
		testing_capture_response_cookie(mut writable, vphp.RequestBorrowedZBox.of(response_z))
	}
	return response
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleRequest']
@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
pub fn (h &VSlimTestingHarness) handle_request(method string, uri string, body string) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return new_psr7_text_response(500, 'testing harness app is not configured')
	}
	mut req_z := build_php_psr7_server_request_object(testing_apply_cookies(testing_new_request(method,
		uri, body), h.cookies))
	defer {
		req_z.release()
	}
	return h.app_ref.handle(vphp.RequestBorrowedZBox.of(req_z))
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleJson']
pub fn (h &VSlimTestingHarness) handle_json(method string, uri string, payload vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return new_psr7_text_response(500, 'testing harness app is not configured')
	}
	mut req_z := build_php_psr7_server_request_object(testing_apply_cookies(testing_new_json_request(method,
		uri, payload.to_zval()), h.cookies))
	defer {
		req_z.release()
	}
	return h.app_ref.handle(vphp.RequestBorrowedZBox.of(req_z))
}

@[php_method: 'dispatchJson']
pub fn (h &VSlimTestingHarness) dispatch_json(method string, uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	response := to_vslim_response(new_vslim_response_from_psr_response(h.handle_json(method,
		uri, payload)))
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_z := build_php_response_object(*response)
		defer {
			response_z.release()
		}
		testing_capture_response_cookie(mut writable, vphp.RequestBorrowedZBox.of(response_z))
	}
	return response
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
	return vphp.RequestOwnedZBox.adopt_zval(vphp.PhpJson.decode_assoc(testing_response_body(response)))
}

@[php_method: 'assertStatus']
pub fn (h &VSlimTestingHarness) assert_status(response vphp.RequestBorrowedZBox, expected int) &VSlimTestingHarness {
	actual := testing_response_status(response)
	if actual != expected {
		vphp.PhpException.raise_class('RuntimeException', 'expected response status ${expected}, got ${actual}',
			0)
	}
	return h
}

@[php_method: 'assertHeader']
pub fn (h &VSlimTestingHarness) assert_header(response vphp.RequestBorrowedZBox, name string, expected string) &VSlimTestingHarness {
	actual := testing_response_header(response, name)
	if actual != expected {
		vphp.PhpException.raise_class('RuntimeException', 'expected header ${name}=${expected}, got ${actual}',
			0)
	}
	return h
}

@[php_method: 'assertBodyContains']
pub fn (h &VSlimTestingHarness) assert_body_contains(response vphp.RequestBorrowedZBox, needle string) &VSlimTestingHarness {
	body := testing_response_body(response)
	if !body.contains(needle) {
		vphp.PhpException.raise_class('RuntimeException', 'expected response body to contain ${needle}',
			0)
	}
	return h
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) dispatch(method string, uri string, body string) &VSlimResponse {
	if h.app_ref == unsafe { nil } {
		return to_vslim_response(VSlimResponse{
			status:       500
			body:         'testing harness app is not configured'
			content_type: 'text/plain; charset=utf-8'
			headers:      {
				'content-type': 'text/plain; charset=utf-8'
			}
		})
	}
	response := to_vslim_response(new_vslim_response_from_psr_response(h.handle_request(method,
		uri, body)))
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_z := build_php_response_object(*response)
		defer {
			response_z.release()
		}
		testing_capture_response_cookie(mut writable, vphp.RequestBorrowedZBox.of(response_z))
	}
	return response
}

@[php_method]
pub fn (h &VSlimTestingHarness) get(uri string) &VSlimResponse {
	return h.dispatch('GET', uri, '')
}

@[php_method: 'getJson']
pub fn (h &VSlimTestingHarness) get_json(uri string) &VSlimResponse {
	return h.dispatch_json('GET', uri, vphp.RequestBorrowedZBox.null())
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) post(uri string, body string) &VSlimResponse {
	return h.dispatch('POST', uri, body)
}

@[php_method: 'postJson']
pub fn (h &VSlimTestingHarness) post_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('POST', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) put(uri string, body string) &VSlimResponse {
	return h.dispatch('PUT', uri, body)
}

@[php_method: 'putJson']
pub fn (h &VSlimTestingHarness) put_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('PUT', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) patch(uri string, body string) &VSlimResponse {
	return h.dispatch('PATCH', uri, body)
}

@[php_method: 'patchJson']
pub fn (h &VSlimTestingHarness) patch_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('PATCH', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) delete(uri string, body string) &VSlimResponse {
	return h.dispatch('DELETE', uri, body)
}

@[php_method: 'deleteJson']
pub fn (h &VSlimTestingHarness) delete_json(uri string, payload vphp.RequestBorrowedZBox) &VSlimResponse {
	return h.dispatch_json('DELETE', uri, payload)
}

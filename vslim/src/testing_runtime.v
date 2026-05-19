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

fn (request &VSlimPsr7ServerRequest) with_testing_cookies(cookies map[string]string) &VSlimPsr7ServerRequest {
	if cookies.len == 0 {
		return request
	}
	mut merged := persistent_array_to_string_map(request.cookie_params_ref)
	for key, value in cookies {
		merged[key] = value
	}
	return request.clone_with(request.method, request.request_target,
		request.protocol_version, clone_header_values(request.headers),
		clone_header_names(request.header_names), request.body_or_empty(),
		request.uri_or_default(), request.server_params_ref,
		string_map_to_persistent_array(merged), request.query_params_ref,
		request.uploaded_files_ref, request.parsed_body_ref, request.attributes_ref)
}

fn (mut h VSlimTestingHarness) capture_response_cookie(response vphp.PhpValue) {
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

fn (app &VSlimApp) testing_build_session_store(cookies map[string]string) VSlimSessionStore {
	mut session := VSlimSessionStore{}
	session.construct()
	session.configure_defaults(app.config_ref)
	if cookie := cookies[session.cookie_name_value()] {
		session.values = session_decode_values(cookie, session.secret_value())
		session.loaded = true
	}
	return session
}

fn (mut h VSlimTestingHarness) store_session_cookie(session VSlimSessionStore) {
	h.cookies[session.cookie_name_value()] = session_encode_values(session.values,
		session.secret_value())
}

fn testing_response_object_vars(response vphp.PhpValue) map[string]vphp.PhpValue {
	mut props_value := vphp.PhpFunction.named('get_object_vars').invoke(response)
	defer {
		props_value.release()
	}
	props := props_value.as_array() or {
		return {}
	}
	mut out := map[string]vphp.PhpValue{}
	for key in props.assoc_keys() {
		out[key] = props.value_at(key).owned()
	}
	return out
}

fn testing_response_status(response vphp.PhpValue) int {
	if !response.is_valid() || !response.is_object() {
		return 0
	}
	props := testing_response_object_vars(response)
	if 'status' in props {
		return props['status'].to_int()
	}
	obj := response.as_object() or { return 0 }
	if obj.method_exists('getStatusCode') {
		return int(obj.with_method_result[vphp.PhpInt, i64]('getStatusCode', fn (z vphp.PhpInt) i64 {
			return z.value()
		}) or { 0 })
	}
	return 0
}

fn testing_response_header(response vphp.PhpValue, name string) string {
	if !response.is_valid() || !response.is_object() {
		return ''
	}
	props := testing_response_object_vars(response)
	if 'headers' in props {
		headers_z := props['headers'] or { return '' }
		headers := headers_z.to_string_map()
		return headers[VSlimRequest.normalize_header_name(name)] or { '' }
	}
	obj := response.as_object() or { return '' }
	if obj.method_exists('getHeaderLine') {
		mut name_arg := vphp.PhpString.of(name)
		defer {
			name_arg.release()
		}
		return obj.with_method_result[vphp.PhpString, string]('getHeaderLine', fn (z vphp.PhpString) string {
			return z.value()
		}, name_arg) or { '' }
	}
	if obj.method_exists('header') {
		mut name_arg := vphp.PhpString.of(name)
		defer {
			name_arg.release()
		}
		return obj.with_method_result[vphp.PhpString, string]('header', fn (z vphp.PhpString) string {
			return z.value()
		}, name_arg) or { '' }
	}
	return ''
}

fn testing_response_body(response vphp.PhpValue) string {
	if !response.is_valid() || !response.is_object() {
		return ''
	}
	props := testing_response_object_vars(response)
	if 'body' in props {
		body_z := props['body'] or { return '' }
		return body_z.to_string()
	}
	obj := response.as_object() or { return '' }
	if obj.method_exists('getBody') {
		return obj.with_method_result[vphp.PhpValue, string]('getBody', fn (body vphp.PhpValue) string {
			if body.is_valid() && body.is_object() && body.method_exists('getContents') {
				mut contents := body.call_method('getContents')
				defer {
					contents.release()
				}
				return contents.to_string()
			}
			return body.to_string()
		}) or { '' }
	}
	return ''
}

fn VSlimPsr7ServerRequest.testing_request(method string, uri string, body string) &VSlimPsr7ServerRequest {
	mut server_params_arg := vphp.PhpArray.new()
	defer {
		server_params_arg.release()
	}
	mut req := VSlimPsr7ServerRequest.from_string(method, uri, server_params_arg)
	if body == '' {
		return req
	}
	return req.clone_with(req.method, req.request_target, req.protocol_version,
		clone_header_values(req.headers), clone_header_names(req.header_names),
		VSlimPsr7Stream.from_content(body), req.uri_or_default(), req.server_params_ref,
		req.cookie_params_ref, req.query_params_ref, req.uploaded_files_ref, req.parsed_body_ref,
		req.attributes_ref)
}

fn VSlimPsr7ServerRequest.testing_json_request(method string, uri string, payload vphp.PhpValue) &VSlimPsr7ServerRequest {
	payload_json := payload.to_json()
	mut req := VSlimPsr7ServerRequest.testing_request(method, uri, payload_json)
	mut headers := clone_header_values(req.headers)
	mut header_names := clone_header_names(req.header_names)
	headers['content-type'] = ['application/json']
	header_names['content-type'] = 'Content-Type'
	return req.clone_with(req.method, req.request_target, req.protocol_version,
		headers, header_names, req.body_or_empty(),
		req.uri_or_default(), req.server_params_ref, req.cookie_params_ref,
		req.query_params_ref, req.uploaded_files_ref, payload.retain(),
		req.attributes_ref)
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
		return VSlimContainer.new()
	}
	return h.app_ref.container()
}

@[php_method: 'withService']
pub fn (mut h VSlimTestingHarness) with_service(id string, value vphp.PhpValue) &VSlimTestingHarness {
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
pub fn (mut h VSlimTestingHarness) with_factory(id string, callable vphp.PhpCallable) &VSlimTestingHarness {
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
pub fn (mut h VSlimTestingHarness) with_session(values vphp.PhpValue) &VSlimTestingHarness {
	if h.app_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut session := h.app_ref.testing_build_session_store(h.cookies)
	for key, value in values.to_string_map() {
		session.values[key] = value
	}
	h.store_session_cookie(session)
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
	mut session := h.app_ref.testing_build_session_store(h.cookies)
	mut guard := VSlimAuthSessionGuard{}
	guard.construct()
	guard.set_store(&session)
	guard.configure_defaults(h.app_ref.config_ref)
	guard.login(user_id)
	h.store_session_cookie(session)
	return h
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) request(method string, uri string, body string) &VSlimPsr7ServerRequest {
	return VSlimPsr7ServerRequest.testing_request(method, uri, body).with_testing_cookies(h.cookies)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'jsonRequest']
pub fn (h &VSlimTestingHarness) json_request(method string, uri string, payload vphp.PhpValue) &VSlimPsr7ServerRequest {
	return VSlimPsr7ServerRequest.testing_json_request(method, uri, payload).with_testing_cookies(h.cookies)
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (h &VSlimTestingHarness) handle(request vphp.PhpObject) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return VSlimPsr7Response.text(500, 'testing harness app is not configured')
	}
	response := h.app_ref.handle_object(request)
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_value := response.build_psr7_response_value()
		defer {
			response_value.release()
		}
		writable.capture_response_cookie(response_value)
	}
	return response
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleRequest']
@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
pub fn (h &VSlimTestingHarness) handle_request(method string, uri string, body string) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return VSlimPsr7Response.text(500, 'testing harness app is not configured')
	}
	mut req_value := VSlimPsr7ServerRequest.testing_request(method, uri,
		body).with_testing_cookies(h.cookies).build_psr7_server_request_value()
	defer {
		req_value.release()
	}
	request := req_value.as_object() or {
		return VSlimPsr7Response.text(500, 'testing request could not be wrapped')
	}
	return h.app_ref.handle(request)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleJson']
pub fn (h &VSlimTestingHarness) handle_json(method string, uri string, payload vphp.PhpValue) &VSlimPsr7Response {
	if h.app_ref == unsafe { nil } {
		return VSlimPsr7Response.text(500, 'testing harness app is not configured')
	}
	mut req_value := VSlimPsr7ServerRequest.testing_json_request(method, uri,
		payload).with_testing_cookies(h.cookies).build_psr7_server_request_value()
	defer {
		req_value.release()
	}
	request := req_value.as_object() or {
		return VSlimPsr7Response.text(500, 'testing request could not be wrapped')
	}
	return h.app_ref.handle(request)
}

@[php_method: 'dispatchJson']
pub fn (h &VSlimTestingHarness) dispatch_json(method string, uri string, payload vphp.PhpValue) &VSlimResponse {
	response := h.handle_json(method, uri, payload).to_vslim_response().boxed_snapshot()
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_value := (*response).to_value()
		defer {
			response_value.release()
		}
		writable.capture_response_cookie(response_value)
	}
	return response
}

@[php_method: 'responseStatus']
pub fn (h &VSlimTestingHarness) response_status(response vphp.PhpValue) int {
	return testing_response_status(response)
}

@[php_method: 'responseHeader']
pub fn (h &VSlimTestingHarness) response_header(response vphp.PhpValue, name string) string {
	return testing_response_header(response, name)
}

@[php_method: 'responseBody']
pub fn (h &VSlimTestingHarness) response_body(response vphp.PhpValue) string {
	return testing_response_body(response)
}

@[php_method: 'responseJson']
pub fn (h &VSlimTestingHarness) response_json(response vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpJson.decode_assoc_value(testing_response_body(response))
}

@[php_method: 'assertStatus']
pub fn (h &VSlimTestingHarness) assert_status(response vphp.PhpValue, expected int) &VSlimTestingHarness {
	actual := testing_response_status(response)
	if actual != expected {
		vphp.PhpException.raise_class('RuntimeException',
			'expected response status ${expected}, got ${actual}', 0)
	}
	return h
}

@[php_method: 'assertHeader']
pub fn (h &VSlimTestingHarness) assert_header(response vphp.PhpValue, name string, expected string) &VSlimTestingHarness {
	actual := testing_response_header(response, name)
	if actual != expected {
		vphp.PhpException.raise_class('RuntimeException',
			'expected header ${name}=${expected}, got ${actual}', 0)
	}
	return h
}

@[php_method: 'assertBodyContains']
pub fn (h &VSlimTestingHarness) assert_body_contains(response vphp.PhpValue, needle string) &VSlimTestingHarness {
	body := testing_response_body(response)
	if !body.contains(needle) {
		vphp.PhpException.raise_class('RuntimeException',
			'expected response body to contain ${needle}', 0)
	}
	return h
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) dispatch(method string, uri string, body string) &VSlimResponse {
	if h.app_ref == unsafe { nil } {
		return (VSlimResponse{
			status:       500
			body:         'testing harness app is not configured'
			content_type: 'text/plain; charset=utf-8'
			headers:      {
				'content-type': 'text/plain; charset=utf-8'
			}
		}).boxed_snapshot()
	}
	response := h.handle_request(method, uri, body).to_vslim_response().boxed_snapshot()
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_value := (*response).to_value()
		defer {
			response_value.release()
		}
		writable.capture_response_cookie(response_value)
	}
	return response
}

@[php_method]
pub fn (h &VSlimTestingHarness) get(uri string) &VSlimResponse {
	return h.dispatch('GET', uri, '')
}

@[php_method: 'getJson']
pub fn (h &VSlimTestingHarness) get_json(uri string) &VSlimResponse {
	return h.dispatch_json('GET', uri, vphp.PhpValue.null())
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) post(uri string, body string) &VSlimResponse {
	return h.dispatch('POST', uri, body)
}

@[php_method: 'postJson']
pub fn (h &VSlimTestingHarness) post_json(uri string, payload vphp.PhpValue) &VSlimResponse {
	return h.dispatch_json('POST', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) put(uri string, body string) &VSlimResponse {
	return h.dispatch('PUT', uri, body)
}

@[php_method: 'putJson']
pub fn (h &VSlimTestingHarness) put_json(uri string, payload vphp.PhpValue) &VSlimResponse {
	return h.dispatch_json('PUT', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) patch(uri string, body string) &VSlimResponse {
	return h.dispatch('PATCH', uri, body)
}

@[php_method: 'patchJson']
pub fn (h &VSlimTestingHarness) patch_json(uri string, payload vphp.PhpValue) &VSlimResponse {
	return h.dispatch_json('PATCH', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) delete(uri string, body string) &VSlimResponse {
	return h.dispatch('DELETE', uri, body)
}

@[php_method: 'deleteJson']
pub fn (h &VSlimTestingHarness) delete_json(uri string, payload vphp.PhpValue) &VSlimResponse {
	return h.dispatch_json('DELETE', uri, payload)
}

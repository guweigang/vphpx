module testingx

import configx as cfgx
import containerx
import httpx
import sessionx
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

fn psr7_server_request_with_testing_cookies(request &httpx.VSlimPsr7ServerRequest, cookies map[string]string) &httpx.VSlimPsr7ServerRequest {
	if cookies.len == 0 {
		return request
	}
	mut merged := httpx.persistent_array_to_string_map(request.cookie_params_ref)
	for key, value in cookies {
		merged[key] = value
	}
	return request.clone_with(request.method, request.request_target, request.protocol_version,
		httpx.clone_header_values(request.headers), httpx.clone_header_names(request.header_names),
		request.body_or_empty(), request.uri_or_default(), request.server_params_ref,
		httpx.string_map_to_persistent_array(merged), request.query_params_ref,
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

fn (h &VSlimTestingHarness) app_object() ?vphp.PhpObject {
	if h.container_ref == unsafe { nil } {
		return none
	}
	unsafe {
		mut container := h.container_ref
		mut value := container.get_value(service_app) or { return none }
		defer {
			value.release()
		}
		object := value.as_object() or { return none }
		return object.retain()
	}
}

fn (h &VSlimTestingHarness) has_app_object() bool {
	app := h.app_object() or { return false }
	app.release()
	return true
}

fn (mut h VSlimTestingHarness) config_from_container() &cfgx.VSlimConfig {
	if h.container_ref == unsafe { nil } {
		return unsafe { nil }
	}
	unsafe {
		mut container := h.container_ref
		mut value := container.get_value(cfgx.service_config) or { return nil }
		defer {
			value.release()
		}
		object := value.as_object() or { return nil }
		if cfg := object.to_v_object[cfgx.VSlimConfig]() {
			return cfg
		}
	}
	return unsafe { nil }
}

fn (mut h VSlimTestingHarness) testing_build_session_store(cookies map[string]string) sessionx.VSlimSessionStore {
	mut session := sessionx.VSlimSessionStore{}
	session.construct()
	session.configure_defaults(h.config_from_container())
	if cookie := cookies[session.cookie_name_value()] {
		session.load_cookie_value(cookie)
	}
	return session
}

fn (mut h VSlimTestingHarness) store_session_cookie(session sessionx.VSlimSessionStore) {
	h.cookies[session.cookie_name_value()] = session.encoded_value()
}

fn testing_response_object_vars(response vphp.PhpValue) map[string]vphp.PhpValue {
	mut props_value := vphp.PhpFunction.named('get_object_vars').invoke(response)
	defer {
		props_value.release()
	}
	props := props_value.as_array() or { return {} }
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
		return headers[httpx.normalize_header_name(name)] or { '' }
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

fn testing_psr7_server_request(method string, uri string, body string) &httpx.VSlimPsr7ServerRequest {
	mut server_params_arg := vphp.PhpArray.new()
	defer {
		server_params_arg.release()
	}
	mut req := httpx.VSlimPsr7ServerRequest.from_string(method, uri, server_params_arg)
	if body == '' {
		return req
	}
	return req.clone_with(req.method, req.request_target, req.protocol_version,
		httpx.clone_header_values(req.headers), httpx.clone_header_names(req.header_names),
		httpx.VSlimPsr7Stream.from_content(body), req.uri_or_default(), req.server_params_ref,
		req.cookie_params_ref, req.query_params_ref, req.uploaded_files_ref, req.parsed_body_ref,
		req.attributes_ref)
}

fn testing_psr7_json_server_request(method string, uri string, payload vphp.PhpValue) &httpx.VSlimPsr7ServerRequest {
	payload_json := payload.to_json()
	mut req := testing_psr7_server_request(method, uri, payload_json)
	mut headers := httpx.clone_header_values(req.headers)
	mut header_names := httpx.clone_header_names(req.header_names)
	headers['content-type'] = ['application/json']
	header_names['content-type'] = 'Content-Type'
	return req.clone_with(req.method, req.request_target, req.protocol_version, headers,
		header_names, req.body_or_empty(), req.uri_or_default(), req.server_params_ref,
		req.cookie_params_ref, req.query_params_ref, req.uploaded_files_ref, payload.retain(),
		req.attributes_ref)
}

@[php_method]
pub fn (mut h VSlimTestingHarness) construct() &VSlimTestingHarness {
	h.container_ref = containerx.VSlimContainer.new()
	h.cookies = map[string]string{}
	return h
}

pub fn VSlimTestingHarness.from_container(container &containerx.VSlimContainer) &VSlimTestingHarness {
	return &VSlimTestingHarness{
		container_ref: container
		cookies:       map[string]string{}
	}
}

@[php_method: 'setApp']
pub fn (mut h VSlimTestingHarness) set_app(app vphp.PhpObject) &VSlimTestingHarness {
	if !app.is_valid() {
		return h
	}
	if app.method_exists('container') {
		mut container_value := app.call_method('container')
		defer {
			container_value.release()
		}
		if container_object := container_value.as_object() {
			if container := container_object.to_v_object[containerx.VSlimContainer]() {
				h.container_ref = container
			}
		}
	}
	mut value := app.retain().to_value()
	mut container := h.container()
	container.set(service_app, value)
	value.release()
	return h
}

@[php_method]
pub fn (h &VSlimTestingHarness) app() vphp.PhpObject {
	return h.app_object() or { vphp.PhpObject.invalid() }
}

@[php_method]
pub fn (mut h VSlimTestingHarness) container() &containerx.VSlimContainer {
	if h.container_ref == unsafe { nil } {
		h.container_ref = containerx.VSlimContainer.new()
	}
	return h.container_ref
}

@[php_method: 'withService']
pub fn (mut h VSlimTestingHarness) with_service(id string, value vphp.PhpValue) &VSlimTestingHarness {
	mut container := h.container()
	container.set(id, value)
	return h
}

@[php_method: 'withFactory']
pub fn (mut h VSlimTestingHarness) with_factory(id string, callable vphp.PhpCallable) &VSlimTestingHarness {
	mut container := h.container()
	container.factory(id, callable)
	return h
}

@[php_method: 'withConfig']
pub fn (mut h VSlimTestingHarness) with_config(path string) &VSlimTestingHarness {
	app := h.app_object() or {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured', 0)
		return h
	}
	defer {
		app.release()
	}
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	mut result := app.call_method('mergeConfig', path_arg)
	result.release()
	return h
}

@[php_method: 'withConfigText']
pub fn (mut h VSlimTestingHarness) with_config_text(text string) &VSlimTestingHarness {
	app := h.app_object() or {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured', 0)
		return h
	}
	defer {
		app.release()
	}
	mut text_arg := vphp.PhpString.of(text)
	defer {
		text_arg.release()
	}
	mut result := app.call_method('mergeConfigText', text_arg)
	result.release()
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
	return httpx.snapshot_string_map(h.cookies)
}

@[php_method: 'withSession']
pub fn (mut h VSlimTestingHarness) with_session(values vphp.PhpValue) &VSlimTestingHarness {
	if h.container_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut session := h.testing_build_session_store(h.cookies)
	session.set_many(values.to_string_map())
	h.store_session_cookie(session)
	return h
}

@[php_arg_name: 'user_id=userId']
@[php_method: 'actingAs']
pub fn (mut h VSlimTestingHarness) acting_as(user_id string) &VSlimTestingHarness {
	if h.container_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'testing harness app is not configured',
			0)
		return h
	}
	mut session := h.testing_build_session_store(h.cookies)
	mut guard := sessionx.VSlimAuthSessionGuard{}
	guard.construct()
	guard.set_store(&session)
	guard.configure_defaults(h.config_from_container())
	guard.login(user_id)
	h.store_session_cookie(session)
	return h
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) request(method string, uri string, body string) &httpx.VSlimPsr7ServerRequest {
	return psr7_server_request_with_testing_cookies(testing_psr7_server_request(method, uri, body),
		h.cookies)
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'jsonRequest']
pub fn (h &VSlimTestingHarness) json_request(method string, uri string, payload vphp.PhpValue) &httpx.VSlimPsr7ServerRequest {
	return psr7_server_request_with_testing_cookies(testing_psr7_json_server_request(method, uri,
		payload), h.cookies)
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (h &VSlimTestingHarness) handle(request vphp.PhpObject) &httpx.VSlimPsr7Response {
	app := h.app_object() or {
		return httpx.VSlimPsr7Response.text(500, 'testing harness app is not configured')
	}
	defer {
		app.release()
	}
	mut response_value := app.call_method('handle', request)
	defer {
		response_value.release()
	}
	response := httpx.VSlimPsr7Response.from_value(response_value)
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut captured := response.build_psr7_response_value()
		defer {
			captured.release()
		}
		writable.capture_response_cookie(captured)
	}
	return response
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleRequest']
@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
pub fn (h &VSlimTestingHarness) handle_request(method string, uri string, body string) &httpx.VSlimPsr7Response {
	if !h.has_app_object() {
		return httpx.VSlimPsr7Response.text(500, 'testing harness app is not configured')
	}
	mut req_value := psr7_server_request_with_testing_cookies(testing_psr7_server_request(method,
		uri, body), h.cookies).build_psr7_server_request_value()
	defer {
		req_value.release()
	}
	request := req_value.as_object() or {
		return httpx.VSlimPsr7Response.text(500, 'testing request could not be wrapped')
	}
	return h.handle(request)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handleJson']
pub fn (h &VSlimTestingHarness) handle_json(method string, uri string, payload vphp.PhpValue) &httpx.VSlimPsr7Response {
	if !h.has_app_object() {
		return httpx.VSlimPsr7Response.text(500, 'testing harness app is not configured')
	}
	mut req_value := psr7_server_request_with_testing_cookies(testing_psr7_json_server_request(method,
		uri, payload), h.cookies).build_psr7_server_request_value()
	defer {
		req_value.release()
	}
	request := req_value.as_object() or {
		return httpx.VSlimPsr7Response.text(500, 'testing request could not be wrapped')
	}
	return h.handle(request)
}

@[php_method: 'dispatchJson']
pub fn (h &VSlimTestingHarness) dispatch_json(method string, uri string, payload vphp.PhpValue) &httpx.VSlimResponse {
	response := h.handle_json(method, uri, payload).to_vslim_response().boxed_snapshot()
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_value := (*response).to_psr7_response().build_psr7_response_value()
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
pub fn (h &VSlimTestingHarness) dispatch(method string, uri string, body string) &httpx.VSlimResponse {
	if !h.has_app_object() {
		return httpx.VSlimResponse.text(500, 'testing harness app is not configured').boxed_snapshot()
	}
	response := h.handle_request(method, uri, body).to_vslim_response().boxed_snapshot()
	unsafe {
		mut writable := &VSlimTestingHarness(h)
		mut response_value := (*response).to_psr7_response().build_psr7_response_value()
		defer {
			response_value.release()
		}
		writable.capture_response_cookie(response_value)
	}
	return response
}

@[php_method]
pub fn (h &VSlimTestingHarness) get(uri string) &httpx.VSlimResponse {
	return h.dispatch('GET', uri, '')
}

@[php_method: 'getJson']
pub fn (h &VSlimTestingHarness) get_json(uri string) &httpx.VSlimResponse {
	return h.dispatch_json('GET', uri, vphp.PhpValue.null())
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) post(uri string, body string) &httpx.VSlimResponse {
	return h.dispatch('POST', uri, body)
}

@[php_method: 'postJson']
pub fn (h &VSlimTestingHarness) post_json(uri string, payload vphp.PhpValue) &httpx.VSlimResponse {
	return h.dispatch_json('POST', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) put(uri string, body string) &httpx.VSlimResponse {
	return h.dispatch('PUT', uri, body)
}

@[php_method: 'putJson']
pub fn (h &VSlimTestingHarness) put_json(uri string, payload vphp.PhpValue) &httpx.VSlimResponse {
	return h.dispatch_json('PUT', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) patch(uri string, body string) &httpx.VSlimResponse {
	return h.dispatch('PATCH', uri, body)
}

@[php_method: 'patchJson']
pub fn (h &VSlimTestingHarness) patch_json(uri string, payload vphp.PhpValue) &httpx.VSlimResponse {
	return h.dispatch_json('PATCH', uri, payload)
}

@[php_arg_default: 'body=""']
@[php_arg_optional: 'body']
@[php_method]
pub fn (h &VSlimTestingHarness) delete(uri string, body string) &httpx.VSlimResponse {
	return h.dispatch('DELETE', uri, body)
}

@[php_method: 'deleteJson']
pub fn (h &VSlimTestingHarness) delete_json(uri string, payload vphp.PhpValue) &httpx.VSlimResponse {
	return h.dispatch_json('DELETE', uri, payload)
}

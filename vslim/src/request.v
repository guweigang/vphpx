module main

import net.http
import vphp

@[php_method]
@[php_arg_name: 'raw_path=rawPath']
pub fn (mut r VSlimRequest) construct(method string, raw_path string, body string) &VSlimRequest {
	r.set_method(method)
	r.set_target(raw_path)
	r.set_body(body)
	apply_request_defaults(mut r)
	return r
}

@[php_method]
pub fn (r &VSlimRequest) str() string {
	return '${r.method} ${r.raw_path}'
}

@[php_method: 'setQuery']
pub fn (mut r VSlimRequest) set_query(query vphp.RequestBorrowedZBox) &VSlimRequest {
	r.query = snapshot_string_map(query.to_string_map())
	return r
}

@[php_method: 'setMethod']
pub fn (mut r VSlimRequest) set_method(method string) &VSlimRequest {
	r.method = method.clone()
	return r
}

@[php_method: 'setTarget']
@[php_arg_name: 'raw_path=rawPath']
pub fn (mut r VSlimRequest) set_target(raw_path string) &VSlimRequest {
	r.raw_path = raw_path.clone()
	r.path, r.query_string = VSlimRequest.normalize_target(raw_path)
	return r
}

@[php_method: 'path']
pub fn (r &VSlimRequest) path_value() string {
	path, _ := VSlimRequest.normalize_target(r.raw_path)
	return path
}

@[php_method: 'queryString']
pub fn (r &VSlimRequest) query_string_value() string {
	return r.effective_query_string()
}

@[php_method: 'setBody']
pub fn (mut r VSlimRequest) set_body(body string) &VSlimRequest {
	r.body = body.clone()
	return r
}

@[php_method: 'setScheme']
pub fn (mut r VSlimRequest) set_scheme(scheme string) &VSlimRequest {
	r.scheme = scheme.clone()
	return r
}

@[php_method: 'setHost']
pub fn (mut r VSlimRequest) set_host(host string) &VSlimRequest {
	r.host = host.clone()
	return r
}

@[php_method: 'setPort']
pub fn (mut r VSlimRequest) set_port(port string) &VSlimRequest {
	r.port = port.clone()
	return r
}

@[php_method: 'setProtocolVersion']
@[php_arg_name: 'protocol_version=protocolVersion']
pub fn (mut r VSlimRequest) set_protocol_version(protocol_version string) &VSlimRequest {
	r.protocol_version = protocol_version.clone()
	return r
}

@[php_method: 'setRemoteAddr']
@[php_arg_name: 'remote_addr=remoteAddr']
pub fn (mut r VSlimRequest) set_remote_addr(remote_addr string) &VSlimRequest {
	r.remote_addr = remote_addr.clone()
	return r
}

@[php_method: 'setHeaders']
pub fn (mut r VSlimRequest) set_headers(headers vphp.RequestBorrowedZBox) &VSlimRequest {
	r.headers = snapshot_string_map(normalize_header_map(headers.to_string_map()))
	return r
}

@[php_method: 'setCookies']
pub fn (mut r VSlimRequest) set_cookies(cookies vphp.RequestBorrowedZBox) &VSlimRequest {
	r.cookies = snapshot_string_map(cookies.to_string_map())
	return r
}

@[php_method: 'setAttributes']
pub fn (mut r VSlimRequest) set_attributes(attributes vphp.RequestBorrowedZBox) &VSlimRequest {
	r.attributes = snapshot_string_map(zval_assoc_scalar_string_map(attributes.to_zval()))
	return r
}

@[php_method: 'setServer']
pub fn (mut r VSlimRequest) set_server(server vphp.RequestBorrowedZBox) &VSlimRequest {
	r.server = snapshot_string_map(server.to_string_map())
	return r
}

@[php_method: 'setUploadedFiles']
@[php_arg_name: 'uploaded_files=uploadedFiles']
pub fn (mut r VSlimRequest) set_uploaded_files(uploaded_files vphp.RequestBorrowedZBox) &VSlimRequest {
	r.uploaded_files = snapshot_string_list(uploaded_files.to_string_list())
	return r
}

@[php_method: 'setParams']
pub fn (mut r VSlimRequest) set_params(params vphp.RequestBorrowedZBox) &VSlimRequest {
	r.params = snapshot_string_map(params.to_string_map())
	return r
}

@[php_method]
pub fn (r &VSlimRequest) query(key string) string {
	return r.query_values()[key] or { '' }
}

@[php_method: 'queryParams']
pub fn (r &VSlimRequest) query_params() map[string]string {
	return r.query_values()
}

@[php_method: 'hasQuery']
pub fn (r &VSlimRequest) has_query(key string) bool {
	return key in r.query_values()
}

@[php_method]
pub fn (r &VSlimRequest) input(key string) string {
	inputs := r.input_values()
	return inputs[key] or { '' }
}

@[php_method: 'inputOr']
@[php_arg_name: 'default_value=defaultValue']
@[php_arg_default: 'default_value=""']
@[php_arg_optional: 'default_value']
pub fn (r &VSlimRequest) input_or(key string, default_value string) string {
	inputs := r.input_values()
	return inputs[key] or { default_value }
}

@[php_method: 'hasInput']
pub fn (r &VSlimRequest) has_input(key string) bool {
	inputs := r.input_values()
	return key in inputs
}

@[php_method: 'allInputs']
pub fn (r &VSlimRequest) all_inputs() map[string]string {
	return r.input_values()
}

@[php_method: 'parsedBody']
pub fn (r &VSlimRequest) parsed_body() map[string]string {
	return r.parsed_body_values()
}

@[php_method: 'bodyFormat']
pub fn (r &VSlimRequest) body_format() string {
	raw_content_type := r.content_type()
	content_type := raw_content_type.to_lower()
	body := r.body.trim_space()
	if content_type.contains('multipart/form-data') {
		return 'multipart'
	}
	if content_type.contains('application/x-www-form-urlencoded') {
		return 'form'
	}
	if content_type.contains('application/json') {
		return 'json'
	}
	if body.starts_with('{') || body.starts_with('[') {
		return 'json'
	}
	if body.contains('=') {
		return 'form'
	}
	return 'none'
}

@[php_method: 'isJsonBody']
pub fn (r &VSlimRequest) is_json_body() bool {
	return r.body_format() == 'json'
}

@[php_method: 'isFormBody']
pub fn (r &VSlimRequest) is_form_body() bool {
	return r.body_format() == 'form'
}

@[php_method: 'isMultipartBody']
pub fn (r &VSlimRequest) is_multipart_body() bool {
	return r.body_format() == 'multipart'
}

@[php_method: 'jsonBody']
pub fn (r &VSlimRequest) json_body() map[string]string {
	if !r.is_json_body() {
		return map[string]string{}
	}
	return r.parsed_body_values()
}

@[php_method: 'formBody']
pub fn (r &VSlimRequest) form_body() map[string]string {
	if !r.is_form_body() {
		return map[string]string{}
	}
	return r.parsed_body_values()
}

@[php_method: 'multipartBody']
pub fn (r &VSlimRequest) multipart_body() map[string]string {
	if !r.is_multipart_body() {
		return map[string]string{}
	}
	return r.parsed_body_values()
}

@[php_method: 'parseError']
pub fn (r &VSlimRequest) parse_error() string {
	if !r.is_json_body() {
		return ''
	}
	body := r.body.trim_space()
	if body == '' {
		return ''
	}
		_ = vphp.PhpJson.decode_assoc(body)
		err_code := vphp.PhpJson.last_error_code()
		if err_code == 0 {
			return ''
		}
		err_msg := vphp.PhpJson.last_error_message()
		if err_msg == '' {
			return 'invalid JSON body'
		}
		return err_msg
}

@[php_method: 'queryAll']
pub fn (r &VSlimRequest) query_all() map[string]string {
	return r.query_params()
}

@[php_method]
pub fn (r &VSlimRequest) header(name string) string {
	headers := r.header_values()
	return headers[VSlimRequest.normalize_header_name(name)] or { '' }
}

@[php_method]
pub fn (r &VSlimRequest) headers() map[string]string {
	return r.header_values()
}

@[php_method: 'hasHeader']
pub fn (r &VSlimRequest) has_header(name string) bool {
	headers := r.header_values()
	return VSlimRequest.normalize_header_name(name) in headers
}

@[php_method: 'contentType']
pub fn (r &VSlimRequest) content_type() string {
	return r.header('content-type')
}

@[php_method: 'requestId']
pub fn (r &VSlimRequest) request_id() string {
	header_id := r.header('x-request-id')
	if header_id != '' {
		return header_id
	}
	attr_id := r.attribute('request_id')
	if attr_id != '' {
		return attr_id
	}
	query_id := r.query('request_id')
	if query_id != '' {
		return query_id
	}
	return ''
}

@[php_method: 'traceId']
pub fn (r &VSlimRequest) trace_id() string {
	mut trace := r.header('x-vhttpd-trace-id')
	if trace != '' {
		return trace
	}
	trace = r.header('x-trace-id')
	if trace != '' {
		return trace
	}
	trace = r.query('trace_id')
	if trace != '' {
		return trace
	}
	trace = r.attribute('trace_id')
	if trace != '' {
		return trace
	}
	return r.request_id()
}

@[php_method]
pub fn (r &VSlimRequest) cookie(name string) string {
	cookies := r.cookie_values()
	return cookies[name] or { '' }
}

@[php_method]
pub fn (r &VSlimRequest) cookies() map[string]string {
	return r.cookie_values()
}

@[php_method: 'hasCookie']
pub fn (r &VSlimRequest) has_cookie(name string) bool {
	cookies := r.cookie_values()
	return name in cookies
}

@[php_method]
pub fn (r &VSlimRequest) param(name string) string {
	params := r.route_param_values()
	return params[name] or { '' }
}

@[php_method: 'routeParams']
pub fn (r &VSlimRequest) route_params() map[string]string {
	return r.route_param_values()
}

@[php_method: 'hasParam']
pub fn (r &VSlimRequest) has_param(name string) bool {
	params := r.route_param_values()
	return name in params
}

@[php_method]
pub fn (r &VSlimRequest) attribute(name string) string {
	attrs := r.attribute_values()
	return attrs[name] or { '' }
}

@[php_method]
pub fn (r &VSlimRequest) attributes() map[string]string {
	return r.attribute_values()
}

@[php_method: 'hasAttribute']
pub fn (r &VSlimRequest) has_attribute(name string) bool {
	attrs := r.attribute_values()
	return name in attrs
}

@[php_method: 'serverValue']
pub fn (r &VSlimRequest) server_value(name string) string {
	values := r.server_param_values()
	return values[name] or { '' }
}

@[php_method: 'serverParams']
pub fn (r &VSlimRequest) server_params() map[string]string {
	return r.server_param_values()
}

@[php_method: 'hasServer']
pub fn (r &VSlimRequest) has_server(name string) bool {
	values := r.server_param_values()
	return name in values
}

@[php_method: 'uploadedFileCount']
pub fn (r &VSlimRequest) uploaded_file_count() int {
	return r.uploaded_file_values().len
}

@[php_method: 'uploadedFiles']
pub fn (r &VSlimRequest) uploaded_files() []string {
	return r.uploaded_file_values()
}

@[php_method: 'hasUploadedFiles']
pub fn (r &VSlimRequest) has_uploaded_files() bool {
	return r.uploaded_file_values().len > 0
}

@[php_method: 'isSecure']
pub fn (r &VSlimRequest) is_secure() bool {
	return r.scheme.to_lower() == 'https'
}

@[php_method: 'headersAll']
pub fn (r &VSlimRequest) headers_all() map[string]string {
	return r.headers()
}

@[php_method: 'cookiesAll']
pub fn (r &VSlimRequest) cookies_all() map[string]string {
	return r.cookies()
}

@[php_method: 'paramsAll']
pub fn (r &VSlimRequest) params_all() map[string]string {
	return r.route_params()
}

@[php_method: 'attributesAll']
pub fn (r &VSlimRequest) attributes_all() map[string]string {
	return r.attributes()
}

@[php_method: 'serverAll']
pub fn (r &VSlimRequest) server_all() map[string]string {
	return r.server_params()
}

@[php_method: 'uploadedFilesAll']
pub fn (r &VSlimRequest) uploaded_files_all() []string {
	return r.uploaded_files()
}

fn (r &VSlimRequest) header_values() map[string]string {
	return snapshot_string_map(r.headers)
}

fn (r &VSlimRequest) query_values() map[string]string {
	if r.query.len > 0 {
		return snapshot_string_map(r.query)
	}
	return VSlimRequest.parse_query(r.effective_query_string())
}

fn (r &VSlimRequest) input_values() map[string]string {
	mut out := r.query_values()
	body := r.parsed_body_values()
	for key, value in body {
		out[key] = value
	}
	return out
}

fn (r &VSlimRequest) parsed_body_values() map[string]string {
	mut out := map[string]string{}
	body := r.body.trim_space()
	if body == '' {
		return out
	}
	raw_content_type := r.content_type()
		content_type := raw_content_type.to_lower()
		is_json := content_type.contains('application/json') || body.starts_with('{') || body.starts_with('[')
		if is_json {
			decoded := vphp.PhpJson.decode_assoc(body)
			if decoded.is_array() {
				return decoded.to_string_map()
			}
		return out
	}
	if content_type.contains('multipart/form-data') {
		boundary := multipart_boundary_from_content_type(raw_content_type)
		if boundary != '' {
			form, _ := http.parse_multipart_form(r.body, boundary)
			return form
		}
		return out
	}
	if content_type.contains('application/x-www-form-urlencoded') {
		return http.parse_form(r.body)
	}
	// Backward-compatible fallback for missing Content-Type in demo/tests.
	if body.contains('=') {
		return http.parse_form(r.body)
	}
	return out
}

fn (r &VSlimRequest) cookie_values() map[string]string {
	return snapshot_string_map(r.cookies)
}

fn (r &VSlimRequest) attribute_values() map[string]string {
	return snapshot_string_map(r.attributes)
}

fn (r &VSlimRequest) route_param_values() map[string]string {
	return snapshot_string_map(r.params)
}

fn (r &VSlimRequest) server_param_values() map[string]string {
	return snapshot_string_map(r.server)
}

fn (r &VSlimRequest) uploaded_file_values() []string {
	mut out := snapshot_string_list(r.uploaded_files)
	raw_content_type := r.content_type()
	content_type := raw_content_type.to_lower()
	if !content_type.contains('multipart/form-data') {
		return out
	}
	boundary := multipart_boundary_from_content_type(raw_content_type)
	if boundary == '' {
		return out
	}
	_, files := http.parse_multipart_form(r.body, boundary)
	for _, items in files {
		for item in items {
			if item.filename == '' {
				continue
			}
			if item.filename !in out {
				out << item.filename
			}
		}
	}
	return out
}

fn snapshot_string_map(input map[string]string) map[string]string {
	mut out := map[string]string{}
	for key, value in input {
		out[key.clone()] = value.clone()
	}
	return out
}

fn snapshot_string_list(input []string) []string {
	mut out := []string{}
	for value in input {
		out << value.clone()
	}
	return out
}

fn snapshot_vslim_request(req &VSlimRequest) VSlimRequest {
	return VSlimRequest{
		method:           req.method.clone()
		raw_path:         req.raw_path.clone()
		path:             req.path_value()
		query_string:     req.query_string_value()
		scheme:           req.scheme.clone()
		host:             req.host.clone()
		port:             req.port.clone()
		protocol_version: req.protocol_version.clone()
		remote_addr:      req.remote_addr.clone()
		params:           snapshot_string_map(req.params)
		query:            snapshot_string_map(req.query)
		body:             req.body.clone()
		headers:          snapshot_string_map(req.headers)
		cookies:          snapshot_string_map(req.cookies)
		attributes:       snapshot_string_map(req.attributes)
		server:           snapshot_string_map(req.server)
		uploaded_files:   snapshot_string_list(req.uploaded_files)
	}
}

pub fn (r &VSlimRequest) to_vslim_request() VSlimRequest {
	return snapshot_vslim_request(r)
}

fn snapshot_vslim_request_with_params(req &VSlimRequest, params map[string]string) VSlimRequest {
	mut out := snapshot_vslim_request(req)
	out.params = snapshot_string_map(params)
	return out
}

fn new_vslim_request_snapshot(req &VSlimRequest) &VSlimRequest {
	snapshot := snapshot_vslim_request(req)
	return &snapshot
}

fn new_vslim_request_snapshot_with_params(req &VSlimRequest, params map[string]string) &VSlimRequest {
	snapshot := snapshot_vslim_request_with_params(req, params)
	return &snapshot
}

pub fn new_vslim_request(method string, raw_path string, body string) &VSlimRequest {
	path, query_string := VSlimRequest.normalize_target(raw_path)
	mut req := &VSlimRequest{
		method: method.clone()
		raw_path: raw_path.clone()
		path: path.clone()
		query_string: query_string.clone()
		body: body.clone()
	}
	apply_request_defaults(mut req)
	return req
}

pub fn new_vslim_request_from_zval(envelope vphp.ZVal) &VSlimRequest {
	method := if part := envelope.get('method') { part.to_string() } else { 'GET' }
	raw_path := if part := envelope.get('path') { part.to_string() } else { '/' }
	body := if part := envelope.get('body') { part.to_string() } else { '' }
	path, query_string := VSlimRequest.normalize_target(raw_path)
	mut req := &VSlimRequest{
		method: method.clone()
		raw_path: raw_path.clone()
		path: path.clone()
		query_string: query_string.clone()
		body: body.clone()
	}
	apply_request_defaults(mut req)
	req.scheme = if part := envelope.get('scheme') { part.to_string() } else { req.scheme }
	req.host = if part := envelope.get('host') { part.to_string() } else { req.host }
	req.port = if part := envelope.get('port') { part.to_string() } else { req.port }
	req.protocol_version = if part := envelope.get('protocol_version') { part.to_string() } else { req.protocol_version }
	req.remote_addr = if part := envelope.get('remote_addr') { part.to_string() } else { req.remote_addr }
	req.query = if part := envelope.get('query') { snapshot_string_map(part.to_string_map()) } else { map[string]string{} }
	req.headers = if part := envelope.get('headers') { snapshot_string_map(normalize_header_map(part.to_string_map())) } else { map[string]string{} }
	req.cookies = if part := envelope.get('cookies') { snapshot_string_map(part.to_string_map()) } else { map[string]string{} }
	req.attributes = if part := envelope.get('attributes') { snapshot_string_map(zval_assoc_scalar_string_map(part)) } else { map[string]string{} }
	req.server = if part := envelope.get('server') { snapshot_string_map(part.to_string_map()) } else { map[string]string{} }
	req.uploaded_files = if part := envelope.get('uploaded_files') { snapshot_string_list(part.to_string_list()) } else { []string{} }
	req.params = if part := envelope.get('params') { snapshot_string_map(part.to_string_map()) } else { map[string]string{} }
	return req
}

fn request_from_envelope(envelope vphp.ZVal) VSlimRequest {
	return new_vslim_request_from_zval(envelope).to_vslim_request()
}

fn split_path_and_query(raw_path string) (string, map[string]string) {
	path, query_str := VSlimRequest.normalize_target(raw_path)
	return path, VSlimRequest.parse_query(query_str)
}

fn (r &VSlimRequest) effective_query_string() string {
	if r.query.len > 0 {
		return encode_query_map(r.query)
	}
	_, query_string := VSlimRequest.normalize_target(r.raw_path)
	return query_string
}

fn encode_query_map(query map[string]string) string {
	mut keys := query.keys()
	keys.sort()
	mut parts := []string{}
	for key in keys {
		unsafe {
			parts << '${key}=${query[key]}'
		}
	}
	return parts.join('&')
}

fn apply_request_defaults(mut r VSlimRequest) {
	r.scheme = 'http'
	r.host = ''
	r.port = ''
	r.protocol_version = '1.1'
	r.remote_addr = ''
	r.query = map[string]string{}
	r.headers = map[string]string{}
	r.cookies = map[string]string{}
	r.attributes = map[string]string{}
	r.server = map[string]string{}
	r.uploaded_files = []string{}
	r.params = map[string]string{}
}

fn normalize_header_map(headers map[string]string) map[string]string {
	mut out := map[string]string{}
	for key, value in headers {
		out[VSlimRequest.normalize_header_name(key).clone()] = value.clone()
	}
	return out
}

fn multipart_boundary_from_content_type(content_type string) string {
	for part in content_type.split(';') {
		trimmed := part.trim_space()
		if !trimmed.starts_with('boundary=') {
			continue
		}
		mut boundary := trimmed.all_after('boundary=').trim_space()
		if boundary.len >= 2 && boundary.starts_with('"') && boundary.ends_with('"') {
			boundary = boundary[1..boundary.len - 1]
		}
		return boundary
	}
	return ''
}

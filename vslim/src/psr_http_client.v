module main

import vphp

struct Psr18OutboundRequest {
	request          vphp.ZVal
	method           string
	url              string
	request_target   string
	protocol_version string
	body             string
	headers          map[string][]string
	header_names     map[string]string
}

struct Psr18ParsedResponseHead {
mut:
	status           int = 200
	reason_phrase    string
	protocol_version string = '1.1'
	headers          map[string][]string
	header_names     map[string]string
}

@[php_method]
pub fn (mut client VSlimPsr18Client) construct() &VSlimPsr18Client {
	if client.timeout_seconds <= 0 {
		client.timeout_seconds = 30
	}
	return &client
}

@[php_method]
pub fn (mut client VSlimPsr18Client) timeout(seconds int) &VSlimPsr18Client {
	client.timeout_seconds = if seconds <= 0 { 30 } else { seconds }
	return &client
}

@[php_method: 'ignorePhpWarning']
pub fn VSlimPsr18Client.ignore_php_warning(err_no int, err_str string, err_file string, err_line int) bool {
	_ = err_no
	_ = err_str
	_ = err_file
	_ = err_line
	return true
}

@[php_method]
pub fn (client &VSlimPsr18Client) timeout_seconds_value() int {
	return if client.timeout_seconds <= 0 { 30 } else { client.timeout_seconds }
}

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'sendRequest']
pub fn (client &VSlimPsr18Client) send_request(request vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	outbound := normalize_psr18_request(request.to_zval()) or {
		throw_psr18_request_exception(err.msg(), request.to_zval())
		return unsafe { nil }
	}
	clear_last_php_error()
	ctx := new_psr18_stream_context(client, outbound)
	fp := psr18_open_stream(outbound.url, ctx)
	if !fp.is_stream_resource() {
		throw_psr18_network_exception(last_php_error_message('failed to open upstream stream'),
			request.to_zval())
		return unsafe { nil }
	}
	head := read_last_http_response_head()
	body := fp.stream_get_contents() or { '' }
	_ = fp.stream_close()
	return &VSlimPsr7Response{
		status: default_psr7_status(head.status)
		reason_phrase: normalize_reason_phrase(head.status, head.reason_phrase)
		protocol_version: normalize_protocol_version(head.protocol_version)
		headers: clone_header_values(head.headers)
		header_names: clone_header_names(head.header_names)
		body_ref: new_psr7_stream(body)
	}
}

@[php_method: 'attachRequest']
@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
pub fn (mut e VSlimPsr18RequestException) attach_request(request vphp.RequestBorrowedZBox) {
	_ = e
	psr18_exception_store_request(request.to_zval())
}

@[php_method: 'getRequest']
@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
pub fn (e &VSlimPsr18RequestException) get_request() vphp.RequestBorrowedZBox {
	_ = e
	return vphp.borrow_zbox(psr18_exception_load_request())
}

@[php_method: 'attachRequest']
@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
pub fn (mut e VSlimPsr18NetworkException) attach_request(request vphp.RequestBorrowedZBox) {
	_ = e
	psr18_exception_store_request(request.to_zval())
}

@[php_method: 'getRequest']
@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
pub fn (e &VSlimPsr18NetworkException) get_request() vphp.RequestBorrowedZBox {
	_ = e
	return vphp.borrow_zbox(psr18_exception_load_request())
}

fn normalize_psr18_request(request vphp.ZVal) !Psr18OutboundRequest {
	if !request.is_valid() || !request.is_object() {
		return error('request must be a valid RequestInterface object')
	}
	method := validate_psr7_method_or_throw(vphp.with_method_result_zval(request, 'getMethod', []vphp.ZVal{}, fn (z vphp.ZVal) string {
		return z.to_string()
	})) or {
		return error('request method must be a non-empty token')
	}
	mut uri_z := vphp.method_request_owned_box(request, 'getUri', []vphp.ZVal{})
	if !uri_z.is_valid() || !uri_z.is_object() {
		uri_z.release()
		return error('request URI must be a valid UriInterface object')
	}
	uri_text := uri_z.to_zval().to_string().trim_space()
	uri_z.release()
	if uri_text == '' {
		return error('request URI must not be empty')
	}
	uri := parse_psr7_uri(uri_text)
	scheme := normalize_psr7_scheme(uri.scheme)
	if scheme !in ['http', 'https'] {
		return error('request URI scheme must be http or https')
	}
	if normalize_psr7_host(uri.host) == '' {
		return error('request URI host must not be empty')
	}
	url := build_psr7_uri_string(&uri)
	if url.trim_space() == '' {
		return error('request URI could not be normalized into an absolute URL')
	}
	target_raw := vphp.with_method_result_zval(request, 'getRequestTarget', []vphp.ZVal{}, fn (z vphp.ZVal) string {
		return z.to_string()
	})
	request_target := if target_raw.trim_space() == '' { build_psr7_request_target(&uri) } else { validate_psr7_request_target_or_throw(target_raw) or { '' } }
	if request_target == '' {
		return error('request target must be a non-empty string without whitespace')
	}
	if request_target == '*' {
		return error('asterisk-form request targets are not supported by the stream transport')
	}
	if !request_target.starts_with('/') && !request_target.contains('://') {
		return error('request target must be origin-form or absolute-form for the stream transport')
	}
	mut headers_z := vphp.method_request_owned_box(request, 'getHeaders', []vphp.ZVal{})
	defer {
		headers_z.release()
	}
	mut headers, mut header_names := zval_to_psr7_header_state(headers_z.to_zval())
	if normalize_psr7_header_name('Host') !in headers {
		apply_psr7_host_header(mut headers, mut header_names, &uri)
	}
	body := vphp.with_method_result_zval(request, 'getBody', []vphp.ZVal{}, fn (z vphp.ZVal) string {
		return zval_to_psr7_stream(z).stream_string()
	})
	return Psr18OutboundRequest{
		request: request
		method: method
		url: url
		request_target: request_target
		protocol_version: normalize_protocol_version(vphp.with_method_result_zval(request, 'getProtocolVersion', []vphp.ZVal{}, fn (z vphp.ZVal) string {
			return z.to_string()
		}))
		body: body
		headers: headers
		header_names: header_names
	}
}

fn new_psr18_stream_context(client &VSlimPsr18Client, request Psr18OutboundRequest) vphp.ZVal {
	mut http_options := new_array_zval()
	http_options.add_assoc_string('method', request.method)
	headers := implode_lines(new_psr18_header_lines(request.headers, request.header_names))
	if headers != '' {
		http_options.add_assoc_string('header', headers)
	}
	if request.body != '' {
		http_options.add_assoc_string('content', request.body)
	}
	protocol_version := normalize_psr18_protocol_version(request.protocol_version)
	if protocol_version > 0 {
		http_options.add_assoc_double('protocol_version', protocol_version)
	}
	http_options.add_assoc_long('timeout', client.timeout_seconds_value())
	http_options.add_assoc_bool('ignore_errors', true)
	http_options.add_assoc_long('follow_location', 0)
	mut ctx_opts := new_array_zval()
	add_assoc_zval(ctx_opts, 'http', http_options)
	mut ctx := vphp.php_call_request_owned_box('stream_context_create', [ctx_opts])
	return ctx.take_zval()
}

fn psr18_open_stream(url string, ctx vphp.ZVal) vphp.ZVal {
	if vphp.function_exists('set_error_handler') && vphp.function_exists('restore_error_handler') {
		_ = vphp.with_php_call_result_zval('set_error_handler', [psr18_warning_handler()], fn (_ vphp.ZVal) bool {
			return true
		})
		mut fp := vphp.php_call_request_owned_box('fopen', [
			vphp.RequestOwnedZBox.new_string(url).to_zval(),
			vphp.RequestOwnedZBox.new_string('r').to_zval(),
			vphp.RequestOwnedZBox.new_bool(false).to_zval(),
			ctx,
		])
		_ = vphp.with_php_call_result_zval('restore_error_handler', [], fn (_ vphp.ZVal) bool {
			return true
		})
		return fp.take_zval()
	}
	mut fp := vphp.php_call_request_owned_box('fopen', [
		vphp.RequestOwnedZBox.new_string(url).to_zval(),
		vphp.RequestOwnedZBox.new_string('r').to_zval(),
		vphp.RequestOwnedZBox.new_bool(false).to_zval(),
		ctx,
	])
	return fp.take_zval()
}

fn psr18_warning_handler() vphp.ZVal {
	mut handler := new_array_zval()
	handler.push_string('VSlim\\Psr18\\Client')
	handler.push_string('ignorePhpWarning')
	return handler
}

fn new_psr18_header_lines(headers map[string][]string, header_names map[string]string) vphp.ZVal {
	mut out := new_array_zval()
	for key, values in headers {
		name := header_names[key] or { key }
		for value in values {
			out.push_string('${name}: ${value}')
		}
	}
	return out
}

fn normalize_psr18_protocol_version(version string) f64 {
	clean := normalize_protocol_version(version)
	return match clean {
		'1.0' { 1.0 }
		'1.1' { 1.1 }
		'2', '2.0' { 2.0 }
		else { 1.1 }
	}
}

fn read_last_http_response_head() Psr18ParsedResponseHead {
	if !vphp.function_exists('http_get_last_response_headers') {
		return Psr18ParsedResponseHead{
			headers: map[string][]string{}
			header_names: map[string]string{}
		}
	}
	return vphp.with_php_call_result_zval('http_get_last_response_headers', [], fn (headers_z vphp.ZVal) Psr18ParsedResponseHead {
		if !headers_z.is_array() {
			return Psr18ParsedResponseHead{
				headers: map[string][]string{}
				header_names: map[string]string{}
			}
		}
		mut current := Psr18ParsedResponseHead{
			headers: map[string][]string{}
			header_names: map[string]string{}
		}
		for line_z in zval_array_items(headers_z) {
			line := line_z.to_string().trim_space()
			if line == '' {
				continue
			}
			if line.starts_with('HTTP/') {
				current = parse_psr18_status_line(line)
				continue
			}
			sep := line.index(':') or { continue }
			name := line[..sep].trim_space()
			value := line[sep + 1..].trim_space()
			key := normalize_psr7_header_name(name)
			if key == '' {
				continue
			}
			mut values := current.headers[key] or { []string{} }
			values << value
			current.headers[key] = values
			current.header_names[key] = name
		}
		return current
	})
}

fn parse_psr18_status_line(line string) Psr18ParsedResponseHead {
	parts := line.split_nth(' ', 3)
	if parts.len < 2 {
		return Psr18ParsedResponseHead{
			headers: map[string][]string{}
			header_names: map[string]string{}
		}
	}
	proto := parts[0].trim_space()
	status_text := parts[1].trim_space()
	reason := if parts.len >= 3 { parts[2].trim_space() } else { '' }
	mut protocol_version := '1.1'
	if proto.starts_with('HTTP/') {
		protocol_version = normalize_protocol_version(proto[5..])
	}
	return Psr18ParsedResponseHead{
		status: status_text.int()
		reason_phrase: reason
		protocol_version: protocol_version
		headers: map[string][]string{}
		header_names: map[string]string{}
	}
}

fn clear_last_php_error() {
	if vphp.function_exists('error_clear_last') {
		_ = vphp.with_php_call_result_zval('error_clear_last', [], fn (_ vphp.ZVal) bool {
			return true
		})
	}
}

fn last_php_error_message(default_message string) string {
	if !vphp.function_exists('error_get_last') {
		return default_message
	}
	return vphp.with_php_call_result_zval('error_get_last', [], fn [default_message] (err vphp.ZVal) string {
		if !err.is_array() {
			return default_message
		}
		message := zval_string_key(err, 'message', '').trim_space()
		return if message == '' { default_message } else { message }
	})
}

fn throw_psr18_request_exception(message string, request vphp.ZVal) {
	throw_psr18_exception_object('VSlim\\Psr18\\RequestException', message, request)
}

fn throw_psr18_network_exception(message string, request vphp.ZVal) {
	throw_psr18_exception_object('VSlim\\Psr18\\NetworkException', message, request)
}

fn throw_psr18_exception_object(class_name string, message string, request vphp.ZVal) {
	mut exception := vphp.php_class(class_name).construct([
		vphp.RequestOwnedZBox.new_string(message).to_zval(),
		vphp.RequestOwnedZBox.new_int(0).to_zval(),
	])
	if exception.is_valid() && exception.is_object() {
		// attachRequest → store_request will dup the zval to anchor
		// its own refcount in the exception's property table.
		vphp.with_method_result_zval(exception, 'attachRequest', [request], fn (result vphp.ZVal) bool {
			return result.is_valid()
		})
	}
	vphp.throw_exception_object(mut exception)
}

fn psr18_exception_store_request(request vphp.ZVal) {
	obj_raw := C.vphp_get_current_this_object()
	if obj_raw == 0 || !request.is_valid() {
		return
	}
	obj := unsafe { &C.zend_object(obj_raw) }
	C.vphp_write_property_compat(obj, c'request_ref', 'request_ref'.len, request.raw)
}

fn psr18_exception_load_request() vphp.ZVal {
	obj_raw := C.vphp_get_current_this_object()
	if obj_raw != 0 {
		obj := unsafe { &C.zend_object(obj_raw) }
		mut rv := C.zval{}
		res := C.vphp_read_property_compat(obj, c'request_ref', 'request_ref'.len, &rv)
		if res != 0 {
			value := vphp.ZVal{
				raw: res
			}
			if value.is_valid() && !value.is_null() && !value.is_undef() {
				// Return without dup — the caller (own_request_zbox) already
				// does its own dup when wrapping into RequestOwnedZBox.
				return value
			}
		}
	}
	return vphp.php_class('VSlim\\Psr7\\Request').construct([])
}

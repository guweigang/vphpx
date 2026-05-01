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

@[php_arg_name: 'err_no=errNo,err_str=errStr,err_file=errFile,err_line=errLine']
@[php_method: 'ignorePhpWarning']
pub fn VSlimPsr18Client.ignore_php_warning(err_no int, err_str string, err_file string, err_line int) bool {
	_ = err_no
	_ = err_str
	_ = err_file
	_ = err_line
	return true
}

@[php_method: 'timeoutSecondsValue']
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
		status:           default_psr7_status(head.status)
		reason_phrase:    normalize_reason_phrase(head.status, head.reason_phrase)
		protocol_version: normalize_protocol_version(head.protocol_version)
		headers:          clone_header_values(head.headers)
		header_names:     clone_header_names(head.header_names)
		body_ref:         new_psr7_stream(body)
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_method: 'attachRequest']
pub fn (mut e VSlimPsr18RequestException) attach_request(request vphp.RequestBorrowedZBox) {
	_ = e
	psr18_exception_store_request(request.to_zval())
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'getRequest']
pub fn (e &VSlimPsr18RequestException) get_request() vphp.RequestBorrowedZBox {
	_ = e
	return vphp.RequestBorrowedZBox.of(psr18_exception_load_request())
}

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_method: 'attachRequest']
pub fn (mut e VSlimPsr18NetworkException) attach_request(request vphp.RequestBorrowedZBox) {
	_ = e
	psr18_exception_store_request(request.to_zval())
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'getRequest']
pub fn (e &VSlimPsr18NetworkException) get_request() vphp.RequestBorrowedZBox {
	_ = e
	return vphp.RequestBorrowedZBox.of(psr18_exception_load_request())
}

fn normalize_psr18_request(request vphp.ZVal) !Psr18OutboundRequest {
	if !request.is_valid() || !request.is_object() {
		return error('request must be a valid RequestInterface object')
	}
	method_raw := vphp.PhpObject.borrowed(request).with_method_result[vphp.PhpString, string]('getMethod',
		fn (z vphp.PhpString) string {
		return z.value()
	}) or { return error('request method must be a non-empty token') }
	method := validate_psr7_method_or_throw(method_raw) or { return error('request method must be a non-empty token') }
	mut uri_z := vphp.PhpObject.borrowed(request).method_request_owned('getUri')
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
	target_raw := vphp.PhpObject.borrowed(request).with_method_result[vphp.PhpString, string]('getRequestTarget',
		fn (z vphp.PhpString) string {
		return z.value()
	}) or { '' }
	request_target := if target_raw.trim_space() == '' { build_psr7_request_target(&uri) } else { validate_psr7_request_target_or_throw(target_raw) or {
			''} }
	if request_target == '' {
		return error('request target must be a non-empty string without whitespace')
	}
	if request_target == '*' {
		return error('asterisk-form request targets are not supported by the stream transport')
	}
	if !request_target.starts_with('/') && !request_target.contains('://') {
		return error('request target must be origin-form or absolute-form for the stream transport')
	}
	mut headers_z := vphp.PhpObject.borrowed(request).method_request_owned('getHeaders')
	defer {
		headers_z.release()
	}
	mut headers, mut header_names := zval_to_psr7_header_state(headers_z.to_zval())
	if normalize_psr7_header_name('Host') !in headers {
		apply_psr7_host_header(mut headers, mut header_names, &uri)
	}
	body := vphp.PhpObject.borrowed(request).with_method_result[vphp.PhpValue, string]('getBody',
		fn (z vphp.PhpValue) string {
		return zval_to_psr7_stream(z.to_zval()).stream_string()
	}) or { '' }
	return Psr18OutboundRequest{
		request:          request
		method:           method
		url:              url
		request_target:   request_target
		protocol_version: normalize_protocol_version(vphp.PhpObject.borrowed(request).with_method_result[vphp.PhpString, string]('getProtocolVersion',
			fn (z vphp.PhpString) string {
			return z.value()
		}) or { '1.1' })
		body:             body
		headers:          headers
		header_names:     header_names
	}
}

fn new_psr18_stream_context(client &VSlimPsr18Client, request Psr18OutboundRequest) vphp.ZVal {
	mut http_options := new_array()
	http_options.string('method', request.method)
	headers := implode_lines(new_psr18_header_lines(request.headers, request.header_names))
	if headers != '' {
		http_options.string('header', headers)
	}
	if request.body != '' {
		http_options.string('content', request.body)
	}
	protocol_version := normalize_psr18_protocol_version(request.protocol_version)
	if protocol_version > 0 {
		http_options.double('protocol_version', protocol_version)
	}
	http_options.int('timeout', client.timeout_seconds_value())
	http_options.bool('ignore_errors', true)
	http_options.int('follow_location', 0)
	mut ctx_opts := new_array()
	ctx_opts.set('http', http_options)
	http_options.release()
	mut ctx := vphp.PhpFunction.named('stream_context_create').request_owned(ctx_opts)
	return ctx.take_zval()
}

fn psr18_open_stream(url string, ctx vphp.ZVal) vphp.ZVal {
	if vphp.PhpFunction.named('set_error_handler').exists()
		&& vphp.PhpFunction.named('restore_error_handler').exists() {
		_ = vphp.PhpFunction.named('set_error_handler').with_result[vphp.PhpValue, bool](fn (_ vphp.PhpValue) bool {
			return true
		}, vphp.PhpValue.from_zval(psr18_warning_handler())) or { false }
		mut url_arg := vphp.PhpString.of(url)
		mut mode_arg := vphp.PhpString.of('r')
		mut use_include_path_arg := vphp.PhpBool.of(false)
		defer {
			url_arg.release()
			mode_arg.release()
			use_include_path_arg.release()
		}
		mut fp := vphp.PhpFunction.named('fopen').request_owned(url_arg, mode_arg,
			use_include_path_arg, vphp.PhpValue.from_zval(ctx))
		_ = vphp.PhpFunction.named('restore_error_handler').result_bool()
		return fp.take_zval()
	}
	mut url_arg := vphp.PhpString.of(url)
	mut mode_arg := vphp.PhpString.of('r')
	mut use_include_path_arg := vphp.PhpBool.of(false)
	defer {
		url_arg.release()
		mode_arg.release()
		use_include_path_arg.release()
	}
	mut fp := vphp.PhpFunction.named('fopen').request_owned(url_arg, mode_arg,
		use_include_path_arg, vphp.PhpValue.from_zval(ctx))
	return fp.take_zval()
}

fn psr18_warning_handler() vphp.ZVal {
	mut handler := new_array()
	handler.push_string('VSlim\\Psr18\\Client')
	handler.push_string('ignorePhpWarning')
	return handler.take_zval()
}

fn new_psr18_header_lines(headers map[string][]string, header_names map[string]string) vphp.ZVal {
	mut out := new_array()
	for key, values in headers {
		name := header_names[key] or { key }
		for value in values {
			out.push_string('${name}: ${value}')
		}
	}
	return out.take_zval()
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
	if !vphp.PhpFunction.named('http_get_last_response_headers').exists() {
		return Psr18ParsedResponseHead{
			headers:      map[string][]string{}
			header_names: map[string]string{}
		}
	}
	return vphp.PhpFunction.named('http_get_last_response_headers').with_result[vphp.PhpArray, Psr18ParsedResponseHead](fn (headers vphp.PhpArray) Psr18ParsedResponseHead {
		headers_z := headers.to_zval()
		mut current := Psr18ParsedResponseHead{
			headers:      map[string][]string{}
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
	}) or {
		Psr18ParsedResponseHead{
			headers:      map[string][]string{}
			header_names: map[string]string{}
		}
	}
}

fn parse_psr18_status_line(line string) Psr18ParsedResponseHead {
	parts := line.split_nth(' ', 3)
	if parts.len < 2 {
		return Psr18ParsedResponseHead{
			headers:      map[string][]string{}
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
		status:           status_text.int()
		reason_phrase:    reason
		protocol_version: protocol_version
		headers:          map[string][]string{}
		header_names:     map[string]string{}
	}
}

fn clear_last_php_error() {
	if vphp.PhpFunction.named('error_clear_last').exists() {
		_ = vphp.PhpFunction.named('error_clear_last').result_bool()
	}
}

fn last_php_error_message(default_message string) string {
	if !vphp.PhpFunction.named('error_get_last').exists() {
		return default_message
	}
	return vphp.PhpFunction.named('error_get_last').with_result[vphp.PhpValue, string](fn [default_message] (err vphp.PhpValue) string {
		raw := err.to_zval()
		if !raw.is_array() {
			return default_message
		}
		message := zval_string_key(raw, 'message', '').trim_space()
		return if message == '' { default_message } else { message }
	}) or { default_message }
}

fn throw_psr18_request_exception(message string, request vphp.ZVal) {
	throw_psr18_exception_object('VSlim\\Psr18\\RequestException', message, request)
}

fn throw_psr18_network_exception(message string, request vphp.ZVal) {
	throw_psr18_exception_object('VSlim\\Psr18\\NetworkException', message, request)
}

fn throw_psr18_exception_object(class_name string, message string, request vphp.ZVal) {
	mut message_arg := vphp.PhpString.of(message)
	mut code_arg := vphp.PhpInt.of(0)
	defer {
		message_arg.release()
		code_arg.release()
	}
	exception_obj := vphp.PhpClass.named(class_name).construct(message_arg, code_arg) or { return }
	mut exception := exception_obj.to_zval()
	if exception.is_valid() && exception.is_object() {
		// attachRequest → store_request will dup the zval to anchor
		// its own refcount in the exception's property table.
		vphp.PhpObject.borrowed(exception).with_method_result[vphp.PhpValue, bool]('attachRequest',
			fn (result vphp.PhpValue) bool {
			return result.to_zval().is_valid()
		}, vphp.PhpValue.from_zval(request)) or { false }
	}
	vphp.PhpException.raise_object(mut exception)
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
	request := vphp.PhpClass.named('VSlim\\Psr7\\Request').construct() or {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	return request.to_zval()
}

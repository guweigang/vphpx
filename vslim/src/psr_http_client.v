module main

import vphp

struct Psr18OutboundRequest {
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
pub fn VSlimPsr18Client.ignore_warning(err_no int, err_str string, err_file string, err_line int) bool {
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
pub fn (client &VSlimPsr18Client) send_request(request vphp.PhpObject) &VSlimPsr7Response {
	outbound := normalize_psr18_request(request) or {
		throw_psr18_request_exception(err.msg(), request)
		return unsafe { nil }
	}
	clear_last_error()
	mut ctx := new_psr18_stream_context(client, outbound)
	defer {
		ctx.release()
	}
	mut fp := psr18_open_stream(outbound.url, ctx)
	defer {
		fp.release()
	}
	mut stream := fp.as_resource() or {
		throw_psr18_network_exception(last_error_message('failed to open upstream stream'), request)
		return unsafe { nil }
	}
	defer {
		stream.release()
	}
	if !stream.is_stream() {
		throw_psr18_network_exception(last_error_message('failed to open upstream stream'), request)
		return unsafe { nil }
	}
	head := Psr18ParsedResponseHead.read_last_http_response()
	body := stream.contents() or { '' }
	_ = stream.close()
	return &VSlimPsr7Response{
		status:           default_psr7_status(head.status)
		reason_phrase:    normalize_reason_phrase(head.status, head.reason_phrase)
		protocol_version: normalize_protocol_version(head.protocol_version)
		headers:          clone_header_values(head.headers)
		header_names:     clone_header_names(head.header_names)
		body_ref:         VSlimPsr7Stream.from_content(body)
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_method: 'attachRequest']
pub fn (mut e VSlimPsr18RequestException) attach_request(request vphp.PhpObject) {
	_ = e
	psr18_exception_store_request(request)
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'getRequest']
pub fn (e &VSlimPsr18RequestException) get_request() vphp.PhpObject {
	_ = e
	return psr18_exception_load_request()
}

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_method: 'attachRequest']
pub fn (mut e VSlimPsr18NetworkException) attach_request(request vphp.PhpObject) {
	_ = e
	psr18_exception_store_request(request)
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_method: 'getRequest']
pub fn (e &VSlimPsr18NetworkException) get_request() vphp.PhpObject {
	_ = e
	return psr18_exception_load_request()
}

fn normalize_psr18_request(request vphp.PhpObject) !Psr18OutboundRequest {
	if !request.is_valid() {
		return error('request must be a valid RequestInterface object')
	}
	method_raw := request.with_method_result[vphp.PhpString, string]('getMethod', fn (z vphp.PhpString) string {
		return z.value()
	}) or { return error('request method must be a non-empty token') }
	method := validate_psr7_method_or_throw(method_raw) or {
		return error('request method must be a non-empty token')
	}
	mut uri_value := request.call_method('getUri')
	if !uri_value.is_valid() || !uri_value.is_object() {
		uri_value.release()
		return error('request URI must be a valid UriInterface object')
	}
	uri_text := uri_value.to_string().trim_space()
	uri_value.release()
	if uri_text == '' {
		return error('request URI must not be empty')
	}
	uri := VSlimPsr7Uri.parse(uri_text)
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
	target_raw := request.with_method_result[vphp.PhpString, string]('getRequestTarget', fn (z vphp.PhpString) string {
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
	mut headers_value := request.call_method('getHeaders')
	defer {
		headers_value.release()
	}
	mut headers, mut header_names := value_subject(headers_value).psr7_header_state()
	if normalize_psr7_header_name('Host') !in headers {
		apply_psr7_host_header(mut headers, mut header_names, &uri)
	}
	body := request.with_method_result[vphp.PhpValue, string]('getBody', fn (z vphp.PhpValue) string {
		return VSlimPsr7Stream.from_value(z).stream_string()
	}) or { '' }
	return Psr18OutboundRequest{
		method:           method
		url:              url
		request_target:   request_target
		protocol_version: normalize_protocol_version(request.with_method_result[vphp.PhpString, string]('getProtocolVersion', fn (z vphp.PhpString) string {
			return z.value()
		}) or { '1.1' })
		body:             body
		headers:          headers
		header_names:     header_names
	}
}

fn new_psr18_stream_context(client &VSlimPsr18Client, request Psr18OutboundRequest) vphp.PhpValue {
	mut http_options := vphp.PhpArray.new()
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
	mut ctx_opts := vphp.PhpArray.new()
	ctx_opts.set('http', http_options)
	http_options.release()
	mut ctx := vphp.PhpFunction.named('stream_context_create').invoke(ctx_opts)
	return ctx
}

fn psr18_open_stream(url string, ctx vphp.PhpValue) vphp.PhpValue {
	if vphp.PhpFunction.named('set_error_handler').exists()
		&& vphp.PhpFunction.named('restore_error_handler').exists() {
		mut handler := psr18_warning_handler()
		defer {
			handler.release()
		}
		_ = vphp.PhpFunction.named('set_error_handler').with_result[vphp.PhpValue, bool](fn (_ vphp.PhpValue) bool {
			return true
		}, handler) or { false }
		mut url_arg := vphp.PhpString.of(url)
		mut mode_arg := vphp.PhpString.of('r')
		mut use_include_path_arg := vphp.PhpBool.of(false)
		defer {
			url_arg.release()
			mode_arg.release()
			use_include_path_arg.release()
		}
		mut fp := vphp.PhpFunction.named('fopen').invoke(url_arg, mode_arg,
			use_include_path_arg, ctx)
		_ = vphp.PhpFunction.named('restore_error_handler').result_bool()
		return fp
	}
	mut url_arg := vphp.PhpString.of(url)
	mut mode_arg := vphp.PhpString.of('r')
	mut use_include_path_arg := vphp.PhpBool.of(false)
	defer {
		url_arg.release()
		mode_arg.release()
		use_include_path_arg.release()
	}
	mut fp := vphp.PhpFunction.named('fopen').invoke(url_arg, mode_arg,
		use_include_path_arg, ctx)
	return fp
}

fn psr18_warning_handler() vphp.PhpArray {
	mut handler := vphp.PhpArray.new()
	handler.push_string('VSlim\\Psr18\\Client')
	handler.push_string('ignorePhpWarning')
	return handler
}

fn new_psr18_header_lines(headers map[string][]string, header_names map[string]string) vphp.PhpArray {
	mut out := vphp.PhpArray.new()
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

fn Psr18ParsedResponseHead.read_last_http_response() Psr18ParsedResponseHead {
	if !vphp.PhpFunction.named('http_get_last_response_headers').exists() {
		return Psr18ParsedResponseHead{
			headers:      map[string][]string{}
			header_names: map[string]string{}
		}
	}
	return vphp.PhpFunction.named('http_get_last_response_headers').with_result[vphp.PhpArray, Psr18ParsedResponseHead](fn (headers vphp.PhpArray) Psr18ParsedResponseHead {
		mut current := Psr18ParsedResponseHead{
			headers:      map[string][]string{}
			header_names: map[string]string{}
		}
		for line_value in headers.value_items() {
			line := line_value.to_string().trim_space()
			if line == '' {
				continue
			}
			if line.starts_with('HTTP/') {
				current = Psr18ParsedResponseHead.from_status_line(line)
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

fn Psr18ParsedResponseHead.from_status_line(line string) Psr18ParsedResponseHead {
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

fn clear_last_error() {
	if vphp.PhpFunction.named('error_clear_last').exists() {
		_ = vphp.PhpFunction.named('error_clear_last').result_bool()
	}
}

fn last_error_message(default_message string) string {
	if !vphp.PhpFunction.named('error_get_last').exists() {
		return default_message
	}
	return vphp.PhpFunction.named('error_get_last').with_result[vphp.PhpValue, string](fn [default_message] (err vphp.PhpValue) string {
		if !err.is_array() {
			return default_message
		}
		message := err.string_at('message', '').trim_space()
		return if message == '' { default_message } else { message }
	}) or { default_message }
}

fn throw_psr18_request_exception(message string, request vphp.PhpObject) {
	throw_psr18_exception_object('VSlim\\Psr18\\RequestException', message, request)
}

fn throw_psr18_network_exception(message string, request vphp.PhpObject) {
	throw_psr18_exception_object('VSlim\\Psr18\\NetworkException', message, request)
}

fn throw_psr18_exception_object(class_name string, message string, request vphp.PhpObject) {
	mut message_arg := vphp.PhpString.of(message)
	mut code_arg := vphp.PhpInt.of(0)
	defer {
		message_arg.release()
		code_arg.release()
	}
	exception_obj := vphp.PhpClass.named(class_name).construct(message_arg, code_arg) or { return }
	mut exception := exception_obj
	if exception.is_valid() {
		// attachRequest → store_request will dup the zval to anchor
		// its own refcount in the exception's property table.
		exception.with_method_result[vphp.PhpValue, bool]('attachRequest', fn (result vphp.PhpValue) bool {
			return result.is_valid()
		}, request) or { false }
	}
	vphp.PhpException.raise_php_object(mut exception)
}

fn psr18_exception_store_request(request vphp.PhpObject) {
	obj := vphp.ZendObject.current()
	if !obj.is_valid() || !request.is_valid() {
		return
	}
	obj.set_prop_input('requestRef', request)
}

fn psr18_exception_load_request() vphp.PhpObject {
	obj := vphp.ZendObject.current()
	if obj.is_valid() {
		value := obj.prop_borrowed('requestRef')
		if value.is_valid() && !value.is_null() && !value.is_undef() {
			return vphp.PhpObject.borrowed(value)
		}
	}
	request := vphp.PhpClass.named('VSlim\\Psr7\\Request').construct() or {
		return vphp.PhpObject.invalid()
	}
	return request
}

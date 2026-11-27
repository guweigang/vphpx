module httpx

import configx
import vphp

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Client\\ClientInterface')]
pub interface PsrHttpClientContract {}

pub type PsrHttpClient = vphp.PhpInterface[PsrHttpClientContract]

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

@[vphp.PhpExportMethod(name: '')]
pub fn (mut client VSlimPsr18Client) construct() &VSlimPsr18Client {
	if client.timeout_seconds <= 0 {
		client.timeout_seconds = 30
	}
	return &client
}

pub fn VSlimPsr18Client.from_config(config &configx.VSlimConfig) &VSlimPsr18Client {
	mut client := &VSlimPsr18Client{}
	client.construct()
	client.configure_defaults(config)
	return client
}

pub fn VSlimPsr18Client.object_from_config(config &configx.VSlimConfig) vphp.PhpObject {
	mut value := vphp.bind_owned_object_value[VSlimPsr18Client](VSlimPsr18Client.from_config(config))
	defer {
		value.release()
	}
	return value.as_object() or { vphp.PhpObject.invalid() }
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut client VSlimPsr18Client) timeout(seconds int) &VSlimPsr18Client {
	client.timeout_seconds = if seconds <= 0 { 30 } else { seconds }
	return &client
}

pub fn (mut client VSlimPsr18Client) configure_defaults(config &configx.VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('http.client.timeout_seconds') {
		client.timeout(config.get_int('http.client.timeout_seconds', client.timeout_seconds_value()))
	}
}

@[vphp.PhpArgNames(names: 'err_no=errNo,err_str=errStr,err_file=errFile,err_line=errLine')]
@[vphp.PhpExportMethod(name: 'ignorePhpWarning')]
pub fn VSlimPsr18Client.ignore_warning(err_no int, err_str string, err_file string, err_line int) bool {
	_ = err_no
	_ = err_str
	_ = err_file
	_ = err_line
	return true
}

@[vphp.PhpExportMethod(name: 'timeoutSecondsValue')]
pub fn (client &VSlimPsr18Client) timeout_seconds_value() int {
	return if client.timeout_seconds <= 0 { 30 } else { client.timeout_seconds }
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'sendRequest')]
pub fn (client &VSlimPsr18Client) export_send_request(request PsrRequest) !&VSlimPsr7Response {
	return client.send_request(request.to_object())
}

pub fn (client &VSlimPsr18Client) send_request(request vphp.PhpObject) !&VSlimPsr7Response {
	outbound := normalize_psr18_request(request) or {
		throw_psr18_request_exception(err.msg(), request)
		return err
	}
	mut context := new_psr18_stream_context(client, outbound) or {
		if !vphp.has_exception() {
			throw_psr18_network_exception('failed to create an upstream stream context', request)
		}
		return err
	}
	defer {
		context.release()
	}
	mut stream := vphp.PhpResource.open_stream(outbound.url, 'r',
		context:       context
		report_errors: false
	) or {
		if !vphp.has_exception() {
			throw_psr18_network_exception('failed to open upstream stream', request)
		}
		return err
	}
	defer {
		stream.release()
	}
	mut head := Psr18ParsedResponseHead.from_stream(stream)
	body := read_psr18_response_body(stream, mut head, outbound.method) or {
		if !vphp.has_exception() {
			throw_psr18_network_exception(err.msg(), request)
		}
		return err
	}
	_ = stream.close()
	return &VSlimPsr7Response{
		status:           default_status(head.status)
		reason_phrase:    normalize_reason_phrase(head.status, head.reason_phrase)
		protocol_version: normalize_protocol_version(head.protocol_version)
		headers:          clone_header_values(head.headers)
		header_names:     clone_header_names(head.header_names)
		body_ref:         VSlimPsr7Stream.from_content(body)
	}
}

@[vphp.PhpExportMethod(name: 'attachRequest')]
pub fn (mut e VSlimPsr18RequestException) attach_request(request PsrRequest) {
	object := request.to_object()
	if object.is_valid() {
		e.request_ref = object.to_value()
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'getRequest')]
pub fn (e &VSlimPsr18RequestException) get_request() vphp.PhpObject {
	return psr18_exception_request_or_default(e.request_ref)
}

@[vphp.PhpExportMethod(name: 'attachRequest')]
pub fn (mut e VSlimPsr18NetworkException) attach_request(request PsrRequest) {
	e.VSlimPsr18RequestException.attach_request(request)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'getRequest')]
pub fn (e &VSlimPsr18NetworkException) get_request() vphp.PhpObject {
	return e.VSlimPsr18RequestException.get_request()
}

pub fn VSlimPsr18RequestException.new_object(message string, code int) vphp.PhpObject {
	return psr18_exception_new_object('VSlim\\Psr18\\RequestException', message, code)
}

pub fn VSlimPsr18NetworkException.new_object(message string, code int) vphp.PhpObject {
	return psr18_exception_new_object('VSlim\\Psr18\\NetworkException', message, code)
}

fn normalize_psr18_request(request vphp.PhpObject) !Psr18OutboundRequest {
	if !request.is_valid() {
		return error('request must be a valid RequestInterface object')
	}
	method_raw := request.with_method_result[vphp.PhpString, string]('getMethod', fn (z vphp.PhpString) string {
		return z.value()
	}) or { return error('request method must be a non-empty token') }
	method := validate_method_or_throw(method_raw) or {
		return error('request method must be a non-empty token')
	}
	mut uri_value := request.call_method_by_value('getUri')
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
	scheme := normalize_scheme(uri.scheme)
	if scheme !in ['http', 'https'] {
		return error('request URI scheme must be http or https')
	}
	if normalize_host(uri.host) == '' {
		return error('request URI host must not be empty')
	}
	url := build_psr7_uri_string(&uri)
	if url.trim_space() == '' {
		return error('request URI could not be normalized into an absolute URL')
	}
	target_raw := request.with_method_result[vphp.PhpString, string]('getRequestTarget', fn (z vphp.PhpString) string {
		return z.value()
	}) or { '' }
	request_target := if target_raw.trim_space() == '' {
		build_psr7_request_target(&uri)
	} else {
		validate_request_target_or_throw(target_raw) or {
			''
		}
	}
	if request_target == '' {
		return error('request target must be a non-empty string without whitespace')
	}
	if request_target == '*' {
		return error('asterisk-form request targets are not supported by the stream transport')
	}
	if !request_target.starts_with('/') && !request_target.contains('://') {
		return error('request target must be origin-form or absolute-form for the stream transport')
	}
	mut headers_value := request.call_method_by_value('getHeaders')
	defer {
		headers_value.release()
	}
	mut headers, mut header_names := psr7_header_state_from_value(headers_value)
	if normalize_header_name('Host') !in headers {
		apply_psr7_host_header(mut headers, mut header_names, &uri)
	}
	mut body_value := request.call_method_by_value('getBody')
	defer {
		body_value.release()
	}
	body := VSlimPsr7Stream.from_value(body_value).stream_string()
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

fn new_psr18_stream_context(client &VSlimPsr18Client, request Psr18OutboundRequest) !vphp.PhpResource {
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
	http_options.bool('auto_decode', false)
	mut ctx_opts := vphp.PhpArray.new()
	defer {
		ctx_opts.release()
	}
	ctx_opts.set('http', http_options)
	http_options.release()
	return vphp.PhpResource.new_stream_context(ctx_opts)
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

fn implode_lines(lines vphp.PhpArray) string {
	mut parts := []string{}
	for item in lines.value_items() {
		text := item.to_string()
		if text != '' {
			parts << text
		}
	}
	if parts.len == 0 {
		return ''
	}
	return parts.join('\r\n') + '\r\n'
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

pub fn http_stream_response_status(stream vphp.PhpResource) int {
	return default_status(Psr18ParsedResponseHead.from_stream(stream).status)
}

fn Psr18ParsedResponseHead.from_stream(stream vphp.PhpResource) Psr18ParsedResponseHead {
	mut current := Psr18ParsedResponseHead{
		headers:      map[string][]string{}
		header_names: map[string]string{}
	}
	mut metadata := stream.stream_wrapper_data() or { return current }
	defer {
		metadata.release()
	}
	headers := metadata.as_array() or { return current }
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
		key := normalize_header_name(name)
		if key == '' {
			continue
		}
		mut values := current.headers[key] or { []string{} }
		values << value
		current.headers[key] = values
		current.header_names[key] = name
	}
	return current
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

fn throw_psr18_request_exception(message string, request vphp.PhpObject) {
	throw_psr18_exception_object(VSlimPsr18RequestException.new_object(message, 0), request)
}

fn throw_psr18_network_exception(message string, request vphp.PhpObject) {
	throw_psr18_exception_object(VSlimPsr18NetworkException.new_object(message, 0), request)
}

fn psr18_exception_new_object(class_name string, message string, code int) vphp.PhpObject {
	mut message_arg := vphp.PhpString.of(message)
	mut code_arg := vphp.PhpInt.of(code)
	defer {
		message_arg.release()
		code_arg.release()
	}
	return vphp.PhpClass.named(class_name).construct(message_arg, code_arg) or {
		vphp.PhpObject.invalid()
	}
}

fn throw_psr18_exception_object(exception_obj vphp.PhpObject, request vphp.PhpObject) {
	mut exception := exception_obj
	if exception.is_valid() {
		// attachRequest keeps the request alive in the exception's property table.
		exception.with_method_result[vphp.PhpValue, bool]('attachRequest', fn (result vphp.PhpValue) bool {
			return result.is_valid()
		}, request) or { false }
	}
	if exception.is_valid() {
		vphp.PhpException.raise_php_object(mut exception)
	}
}

fn psr18_exception_request_or_default(value vphp.PhpValue) vphp.PhpObject {
	if value.is_valid() && !value.is_null() {
		return vphp.PhpObject.borrowed_zbox(value.to_borrowed_zbox())
	}
	return VSlimPsr7Request.new_object()
}

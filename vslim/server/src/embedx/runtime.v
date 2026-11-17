module embedx

import os
import net.urllib

#include "runtime.h"

struct C.vphp_embed_request {}

fn C.vphp_embed_engine_start(lanes uint) int

fn C.vphp_embed_engine_shutdown()

fn C.vphp_embed_request_new() &C.vphp_embed_request

fn C.vphp_embed_request_free(request &C.vphp_embed_request)

fn C.vphp_embed_request_set_script(request &C.vphp_embed_request, value &char)

fn C.vphp_embed_request_set_method(request &C.vphp_embed_request, value &char)

fn C.vphp_embed_request_set_uri(request &C.vphp_embed_request, value &char)

fn C.vphp_embed_request_set_query(request &C.vphp_embed_request, value &char)

fn C.vphp_embed_request_set_body(request &C.vphp_embed_request, value &char, value_len uint)

fn C.vphp_embed_request_set_content_type(request &C.vphp_embed_request, value &char)

fn C.vphp_embed_request_set_cookie(request &C.vphp_embed_request, value &char)

fn C.vphp_embed_request_add_server(request &C.vphp_embed_request, key &char, key_len uint, value &char, value_len uint) int

fn C.vphp_embed_request_execute(request &C.vphp_embed_request) int

fn C.vphp_embed_request_output(request &C.vphp_embed_request) &char

fn C.vphp_embed_request_output_len(request &C.vphp_embed_request) uint

fn C.vphp_embed_request_header_count(request &C.vphp_embed_request) uint

fn C.vphp_embed_request_header_line(request &C.vphp_embed_request, index uint) &char

fn C.vphp_embed_request_header_line_len(request &C.vphp_embed_request, index uint) uint

fn C.vphp_embed_request_status(request &C.vphp_embed_request) int

fn C.vphp_embed_request_error(request &C.vphp_embed_request) &char

pub struct Header {
pub:
	name  string
	value string
}

pub struct Request {
pub:
	script_path  string
	method       string = 'GET'
	uri          string = '/'
	query_string string
	body         string
	content_type string
	cookie       string
	// Map fields remain convenient for direct callers. Raw HTTP inputs above take precedence.
	get     map[string]string
	post    map[string]string
	cookies map[string]string
	server  map[string]string
}

pub struct Response {
pub:
	status_code int
	body        string
	headers     []Header
}

@[heap]
pub struct Engine {
mut:
	started  bool
	ini_path string
}

pub fn new_engine() !&Engine {
	return new_engine_with_lanes(1)
}

pub fn new_engine_with_lanes(lanes int) !&Engine {
	if lanes <= 0 {
		return error('embedded PHP lane count must be positive')
	}
	mut ini_path := ''
	extension_path := (os.getenv_opt('VSLIM_EXTENSION_PATH') or { '' }).trim_space()
	if extension_path != '' {
		ini_path = os.join_path(os.temp_dir(), 'vslim-server-${os.getpid()}.ini')
		escaped_path := extension_path.replace('\\', '\\\\').replace('"', '\\"')
		os.write_file(ini_path, 'extension="${escaped_path}"\n')!
		os.setenv('VSLIM_EMBED_INI_PATH', ini_path, true)
	}
	if C.vphp_embed_engine_start(uint(lanes)) == 0 {
		if ini_path != '' {
			os.rm(ini_path) or {}
			os.unsetenv('VSLIM_EMBED_INI_PATH')
		}
		return error('failed to start the embedded PHP engine')
	}
	return &Engine{
		started: true
		ini_path: ini_path
	}
}

pub fn (engine &Engine) execute(input Request) !Response {
	if !engine.started {
		return error('embedded PHP engine is stopped')
	}
	if input.script_path == '' {
		return error('PHP script path is empty')
	}
	if !os.is_file(input.script_path) {
		return error('PHP script not found: ${input.script_path}')
	}

	request := C.vphp_embed_request_new()
	if request == unsafe { nil } {
		return error('failed to allocate embedded PHP request')
	}
	defer {
		C.vphp_embed_request_free(request)
	}

	query_string := if input.query_string == '' && input.get.len > 0 {
		encode_vars(input.get)
	} else {
		input.query_string
	}
	mut request_body := input.body
	mut content_type := input.content_type
	if request_body == '' && input.post.len > 0 {
		request_body = encode_vars(input.post)
		if content_type == '' {
			content_type = 'application/x-www-form-urlencoded'
		}
	}
	cookie := if input.cookie == '' && input.cookies.len > 0 {
		encode_cookies(input.cookies)
	} else {
		input.cookie
	}

	C.vphp_embed_request_set_script(request, input.script_path.str)
	C.vphp_embed_request_set_method(request, input.method.str)
	C.vphp_embed_request_set_uri(request, input.uri.str)
	C.vphp_embed_request_set_query(request, query_string.str)
	C.vphp_embed_request_set_body(request, request_body.str, uint(request_body.len))
	C.vphp_embed_request_set_content_type(request, content_type.str)
	C.vphp_embed_request_set_cookie(request, cookie.str)
	for key, value in input.server {
		if C.vphp_embed_request_add_server(request, key.str, uint(key.len), value.str, uint(value.len)) == 0 {
			return error('failed to copy PHP server variables')
		}
	}

	if C.vphp_embed_request_execute(request) == 0 {
		mut message := unsafe { C.vphp_embed_request_error(request).vstring() }
		if message == '' {
			message = 'embedded PHP request failed'
		}
		return error(message)
	}
	body_view := unsafe {
		C.vphp_embed_request_output(request).vstring_with_len(int(C.vphp_embed_request_output_len(request)))
	}
	body := body_view.clone()
	return Response{
		status_code: C.vphp_embed_request_status(request)
		body: body
		headers: read_headers(request)
	}
}

pub fn (mut engine Engine) shutdown() {
	if !engine.started {
		return
	}
	C.vphp_embed_engine_shutdown()
	engine.started = false
	if engine.ini_path != '' {
		os.rm(engine.ini_path) or {}
		os.unsetenv('VSLIM_EMBED_INI_PATH')
		engine.ini_path = ''
	}
}

fn encode_vars(values map[string]string) string {
	mut parts := []string{cap: values.len}
	for key, value in values {
		parts << '${urllib.query_escape(key)}=${urllib.query_escape(value)}'
	}
	return parts.join('&')
}

fn encode_cookies(values map[string]string) string {
	mut parts := []string{cap: values.len}
	for key, value in values {
		parts << '${urllib.query_escape(key)}=${urllib.query_escape(value)}'
	}
	return parts.join('; ')
}

fn read_headers(request &C.vphp_embed_request) []Header {
	mut headers := []Header{}
	for index in 0 .. int(C.vphp_embed_request_header_count(request)) {
		line := unsafe {
			C.vphp_embed_request_header_line(request, uint(index)).vstring_with_len(int(C.vphp_embed_request_header_line_len(request, uint(index))))
		}
		if line.trim_space() == '' || !line.contains(':') {
			continue
		}
		name, value := line.split_once(':') or { continue }
		headers << Header{
			name: name.trim_space()
			value: value.trim_space()
		}
	}
	return headers
}

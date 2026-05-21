module httpx

import routing
import vphp

pub fn normalize_header_name(name string) string {
	return routing.Header.normalize_name(name)
}

pub fn validate_header_name_or_throw(name string) ?string {
	key := normalize_header_name(name)
	if key == '' || !is_valid_header_name(key) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'header name must be a non-empty RFC 7230 token', 0)
		return none
	}
	return key
}

pub fn normalize_method(method string) string {
	trimmed := method.trim_space()
	return if trimmed == '' { 'GET' } else { trimmed }
}

pub fn validate_method_or_throw(method string) ?string {
	trimmed := method.trim_space()
	if trimmed == '' {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'HTTP method must be a non-empty token', 0)
		return none
	}
	for ch in trimmed.bytes() {
		if ch <= 32 || ch == 127 {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'HTTP method must be a non-empty token', 0)
			return none
		}
	}
	return trimmed
}

pub fn validate_method_or_fallback(method string, fallback string) string {
	return validate_method_or_throw(method) or { fallback }
}

pub fn normalize_scheme(scheme string) string {
	return scheme.trim_space().trim_right(':').to_lower()
}

pub fn normalize_host(host string) string {
	return host.trim_space().to_lower()
}

pub fn normalize_path(path string, host string) string {
	mut clean := path
	if host != '' && clean != '' && !clean.starts_with('/') {
		clean = '/' + clean
	}
	if host == '' && clean.starts_with('//') {
		clean = '/' + clean.trim_left('/')
	}
	return clean
}

pub fn normalize_query(query string) string {
	return query.trim_space().trim_left('?')
}

pub fn normalize_fragment(fragment string) string {
	return fragment.trim_space().trim_left('#')
}

pub fn normalize_port(port int) int {
	return if port <= 0 { -1 } else { port }
}

pub fn normalize_protocol_version(version string) string {
	trimmed := version.trim_space()
	return if trimmed == '' { '1.1' } else { trimmed }
}

pub fn validate_request_target_or_throw(request_target string) ?string {
	trimmed := request_target.trim_space()
	if trimmed == '' {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'request target must be a non-empty string without whitespace', 0)
		return none
	}
	for ch in request_target.bytes() {
		if ch == ` ` || ch == `\t` || ch == `\r` || ch == `\n` {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'request target must be a non-empty string without whitespace', 0)
			return none
		}
	}
	return request_target
}

pub fn default_status(status int) int {
	return if status <= 0 { 200 } else { status }
}

pub fn normalize_status(status int) int {
	return default_status(status)
}

pub fn validate_response_status_or_throw(status int) ?int {
	if status <= 0 {
		return 200
	}
	return validate_status_or_throw(status)
}

pub fn validate_status_or_throw(status int) ?int {
	if status < 100 || status > 599 {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'status code must be an integer between 100 and 599', 0)
		return none
	}
	return status
}

pub fn normalize_reason_phrase(status int, reason_phrase string) string {
	trimmed := reason_phrase.trim_space()
	if trimmed != '' {
		return trimmed
	}
	return match default_status(status) {
		200 { 'OK' }
		201 { 'Created' }
		202 { 'Accepted' }
		204 { 'No Content' }
		301 { 'Moved Permanently' }
		302 { 'Found' }
		303 { 'See Other' }
		304 { 'Not Modified' }
		307 { 'Temporary Redirect' }
		308 { 'Permanent Redirect' }
		400 { 'Bad Request' }
		401 { 'Unauthorized' }
		403 { 'Forbidden' }
		404 { 'Not Found' }
		409 { 'Conflict' }
		422 { 'Unprocessable Content' }
		429 { 'Too Many Requests' }
		500 { 'Internal Server Error' }
		502 { 'Bad Gateway' }
		503 { 'Service Unavailable' }
		504 { 'Gateway Timeout' }
		else { '' }
	}
}

pub fn default_port_for_scheme(scheme string) ?int {
	return match normalize_scheme(scheme) {
		'http' { 80 }
		'https' { 443 }
		else { none }
	}
}

pub fn is_valid_header_name(name string) bool {
	if name == '' {
		return false
	}
	for ch in name.bytes() {
		if !((ch >= `!` && ch <= `~`) && ch !in [`(`, `)`, `<`, `>`, `@`, `,`, `;`, `:`,
			`\\`, `"`, `/`, `[`, `]`, `?`, `=`, `{`, `}`, ` `, `\t`]) {
			return false
		}
	}
	return true
}

pub fn is_valid_header_value(value string) bool {
	for ch in value.bytes() {
		if ch == `\r` || ch == `\n` {
			return false
		}
	}
	return true
}

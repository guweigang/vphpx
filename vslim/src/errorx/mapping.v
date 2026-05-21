module errorx

import httpx
import vphp

pub fn php_value_json_fragment(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return 'null'
	}
	return value.to_json()
}

pub fn json_escape(input string) string {
	return input.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t',
		'\\t')
}

pub fn error_json_body(status int, message string, error_code string) string {
	esc_code := json_escape(error_code)
	return '{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}'
}

pub fn validation_error_json_body(status int, errors vphp.PhpValue) string {
	return '{"ok":false,"code":"validation_error","error":"validation_error","status":${status},"message":"Validation failed","errors":${php_value_json_fragment(errors)}}'
}

pub fn default_response(status int, message string, error_code string, json_enabled bool) httpx.VSlimResponse {
	if json_enabled {
		return httpx.VSlimResponse.json(status, error_json_body(status, message, error_code))
	}
	return httpx.VSlimResponse.text(status, message)
}

pub fn default_psr_response(status int, message string, error_code string, json_enabled bool) &httpx.VSlimPsr7Response {
	if json_enabled {
		return httpx.VSlimPsr7Response.json(status, error_json_body(status, message, error_code))
	}
	return httpx.VSlimPsr7Response.text(status, message)
}

fn exception_class_name(exception vphp.PhpObject) string {
	if !exception.is_valid() {
		return ''
	}
	return exception.class_name().trim_space()
}

pub fn exception_message_value(exception vphp.PhpObject, fallback string) string {
	if !exception.is_valid() || !exception.method_exists('getMessage') {
		return fallback
	}
	mut out := exception.call_method('getMessage')
	defer {
		out.release()
	}
	message := out.to_string().trim_space()
	if message == '' {
		return fallback
	}
	return message
}

pub fn exception_status_code(exception vphp.PhpObject, fallback_status int) int {
	message := exception_message_value(exception, '').to_lower()
	if exception.is_valid() && exception.method_exists('getCode') {
		mut out := exception.call_method('getCode')
		defer {
			out.release()
		}
		code := out.to_int()
		if code >= 400 && code <= 599 {
			return code
		}
	}
	class_name := exception_class_name(exception)
	if class_name == '' {
		return fallback_status
	}
	if class_name == 'InvalidArgumentException' || class_name == 'DomainException'
		|| class_name == 'VSlim\\Psr16\\InvalidArgumentException'
		|| class_name == 'VSlim\\Psr6\\InvalidArgumentException' {
		return 400
	}
	if class_name == 'VSlim\\Container\\NotFoundException' {
		return 404
	}
	if class_name == 'VSlim\\Auth\\UnauthorizedException' {
		return 401
	}
	if class_name == 'VSlim\\Auth\\ForbiddenException' {
		return 403
	}
	if class_name == 'VSlim\\ValidationException' || class_name == 'ValidationException' {
		return 422
	}
	if message.starts_with('connect_failed:') || message.contains('database transport ')
		|| message.contains('database unavailable') {
		return 503
	}
	if message.starts_with('config load failed:') || message.starts_with('config parse failed:')
		|| message.starts_with('config env resolve failed:') {
		return 500
	}
	if message.starts_with('query_failed:') || message.starts_with('execute_failed:')
		|| message.starts_with('begin_transaction_failed:') || message.starts_with('commit_failed:')
		|| message.starts_with('rollback_failed:') || message.starts_with('database query failed:')
		|| message.starts_with('database execute failed:')
		|| message.starts_with('database begin transaction failed:')
		|| message.starts_with('database commit failed:')
		|| message.starts_with('database rollback failed:')
		|| message.starts_with('database connect failed:') {
		return 500
	}
	return fallback_status
}

pub fn exception_error_code(exception vphp.PhpObject) string {
	class_name := exception_class_name(exception)
	message := exception_message_value(exception, '').to_lower()
	if message.starts_with('config load failed:') || message.starts_with('config parse failed:')
		|| message.starts_with('config env resolve failed:') {
		return 'config_error'
	}
	if message.starts_with('connect_failed:') || message.contains('database transport ')
		|| message.contains('database unavailable') {
		return 'database_unavailable'
	}
	if message.starts_with('query_failed:') || message.starts_with('execute_failed:')
		|| message.starts_with('begin_transaction_failed:') || message.starts_with('commit_failed:')
		|| message.starts_with('rollback_failed:') || message.starts_with('database query failed:')
		|| message.starts_with('database execute failed:')
		|| message.starts_with('database begin transaction failed:')
		|| message.starts_with('database commit failed:')
		|| message.starts_with('database rollback failed:')
		|| message.starts_with('database connect failed:') {
		return 'database_error'
	}
	return match class_name {
		'InvalidArgumentException', 'DomainException', 'VSlim\\Psr16\\InvalidArgumentException',
		'VSlim\\Psr6\\InvalidArgumentException' {
			'invalid_argument'
		}
		'VSlim\\Container\\NotFoundException' {
			'not_found'
		}
		'VSlim\\Auth\\UnauthorizedException' {
			'unauthorized'
		}
		'VSlim\\Auth\\ForbiddenException' {
			'forbidden'
		}
		'VSlim\\ValidationException', 'ValidationException' {
			'validation_error'
		}
		else {
			'runtime_error'
		}
	}
}

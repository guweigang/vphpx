module httpx

import vphp

pub fn is_psr15_middleware_handler(handler vphp.PhpValue) bool {
	if !handler.is_valid() || !handler.is_object() {
		return false
	}
	if handler.is_instance_of('Closure') {
		return false
	}
	return handler.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| handler.method_exists('process')
}

pub fn is_psr15_middleware_registration(handler vphp.PhpValue) bool {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return false
	}
	if handler.is_string() || handler.is_array() {
		return true
	}
	return is_psr15_middleware_handler(handler)
}

pub fn is_psr15_request_handler(handler vphp.PhpValue) bool {
	if !handler.is_valid() {
		return false
	}
	return handler.is_object()
		&& handler.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
}

pub fn is_psr15_request_handler_like_object(handler vphp.PhpObject) bool {
	return handler.is_valid()
		&& (handler.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface')
		|| handler.method_exists('handle'))
}

pub fn is_psr_server_request_payload(payload vphp.PhpValue) bool {
	if !payload.is_valid() {
		return false
	}
	return payload.is_object() && is_psr_server_request_object(payload.as_object() or {
		vphp.PhpObject.invalid()
	})
}

pub fn is_psr_server_request_object(payload vphp.PhpObject) bool {
	return payload.is_valid()
		&& (payload.is_instance_of('Psr\\Http\\Message\\ServerRequestInterface')
		|| (payload.method_exists('getMethod') && payload.method_exists('getUri')))
}

pub fn psr15_middleware_target_method(target vphp.PhpValue, explicit_method string) string {
	method := explicit_method.trim_space()
	if method != '' {
		return method
	}
	if target.is_object() && (target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| target.method_exists('process')) {
		return 'process'
	}
	if target.is_object() && target.method_exists('__invoke') {
		return '__invoke'
	}
	return ''
}

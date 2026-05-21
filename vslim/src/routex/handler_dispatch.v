module routex

import vphp

pub fn call_route_target_method(target vphp.PhpValue, method string, args []vphp.PhpArgInput) vphp.PhpValue {
	if method.trim_space() != '' {
		if target_obj := target.as_object() {
			return target_obj.call_method(method, ...args)
		}
	}
	if callable := target.as_callable() {
		return callable.invoke(...args)
	}
	return vphp.PhpValue.null()
}

pub fn validate_route_service_method(target vphp.PhpValue, service_id string, method string) ! {
	clean_method := method.trim_space()
	if !target.is_object() {
		return error('Route handler service "${service_id}" must be an object')
	}
	if clean_method == '' {
		return error('Route handler array must be ["service", "method"]')
	}
	if !target.method_exists(clean_method) {
		return error('Container service "${service_id}" has no method "${clean_method}"')
	}
}

pub fn call_psr_request_handler(target vphp.PhpValue, request vphp.PhpObject) !vphp.PhpValue {
	target_obj := target.as_object() or { return error('Route handler must be an object') }
	mut result := target_obj.call_method('handle', request)
	return route_handler_response(result)
}

pub fn route_handler_response(value vphp.PhpValue) vphp.PhpValue {
	return value.owned()
}

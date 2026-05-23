module middlewarex

import httpx
import vphp

pub fn is_phase_middleware_target(target vphp.PhpValue, explicit_method string) bool {
	method := httpx.psr15_middleware_target_method(target, explicit_method)
	return method == 'process' && target.is_object()
		&& (target.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface')
		|| target.method_exists('process'))
}

pub fn dispatch_phase_process(target vphp.PhpValue, payload vphp.PhpObject, next_handler vphp.PhpObject) !vphp.PhpValue {
	if !is_phase_middleware_target(target, 'process') {
		return error('Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
	}
	target_obj := target.as_object() or { return error('Phase middleware must be an object') }
	mut next_handler_arg := next_handler.owned()
	defer {
		next_handler_arg.release()
	}
	mut result := target_obj.call_method('process', payload, next_handler_arg)
	return result.owned()
}

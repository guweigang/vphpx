module main

import vphp

#include "php_bridge.h"

fn dispatch_php_phase_middleware(app &VSlimApp, payload vphp.PhpValue, route_params map[string]string, handler vphp.PhpValue, next_handler vphp.PhpObject) !vphp.PhpValue {
	target := resolve_php_phase_middleware_target(app, handler)!
	bind_route_target_to_app_if_supported(app, target)
	mut payload_arg := normalize_psr15_server_request(payload, route_params)
	defer {
		payload_arg.release()
	}
	mut next_handler_arg := next_handler.owned()
	defer {
		next_handler_arg.release()
	}
	target_obj := target.as_object() or { return error('Phase middleware must be an object') }
	mut result := target_obj.call_method('process', payload_arg, next_handler_arg)
	return result.owned()
}

fn is_internal_phase_continue_response(result vphp.PhpValue) bool {
	res, ok := normalize_php_route_response_value(result)
	if !ok {
		return false
	}
	return res.status == 299 && (res.headers['x-vslim-continue'] or { '' }) == '1'
}

fn build_before_phase_dispatch_result(payload vphp.PhpValue, route_params map[string]string, cont &VSlimPsr15ContinueHandler, response vphp.PhpValue) PhaseMiddlewareDispatchResult {
	continued := cont.state.has_forwarded_request && is_internal_phase_continue_response(response)
	return PhaseMiddlewareDispatchResult{
		response_ref: response.owned()
		payload_ref:  continued_phase_request_value(payload, route_params, cont)
		continued:    continued
	}
}

fn dispatch_php_before_phase_middleware(app &VSlimApp, payload vphp.PhpValue, route_params map[string]string, handler vphp.PhpValue) !PhaseMiddlewareDispatchResult {
	mut cont := &VSlimPsr15ContinueHandler{
		state: Psr15NextHandlerState{
			mode: .continue_marker
		}
	}
	next_handler := build_php_psr15_continue_handler_object(cont)
	response := dispatch_php_phase_middleware(app, payload, route_params, handler, next_handler)!
	return build_before_phase_dispatch_result(payload, route_params, cont, response)
}

fn apply_php_before_middlewares(app &VSlimApp, path string, payload vphp.PhpValue) !VSlimBeforeMiddlewareResult {
	mut group_before := matching_group_before_middlewares(app, path)
	defer {
		release_collected_middlewares(mut group_before)
	}
	if app.php_before_middlewares.len == 0 && group_before.len == 0 {
		return VSlimBeforeMiddlewareResult{
			payload_ref: payload.owned()
		}
	}
	route_params := route_params_from_payload(payload)
	mut current_payload := payload.owned()
	mut all := collect_before_middlewares(app, group_before)
	defer {
		release_collected_middlewares(mut all)
	}
	for hook in all {
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return error('Middleware is not valid')
		}
		phase_result :=
			dispatch_php_before_phase_middleware(app, current_payload, route_params, hook)!
		if !phase_result.continued {
			return VSlimBeforeMiddlewareResult{
				response_ref: phase_result.response_ref.owned()
				payload_ref:  current_payload.owned()
			}
		}
		current_payload = phase_result.payload_ref.owned()
	}
	return VSlimBeforeMiddlewareResult{
		payload_ref: current_payload.owned()
	}
}

fn matching_group_before_middlewares(app &VSlimApp, path string) []vphp.PhpValue {
	return collect_matching_route_hooks(app.php_group_before_middle, path)
}

fn matching_group_middle_hooks(app &VSlimApp, path string) []vphp.PhpValue {
	return collect_matching_route_hooks(app.php_group_middle, path)
}

fn matching_group_after_middlewares(app &VSlimApp, path string) []vphp.PhpValue {
	return collect_matching_route_hooks(app.php_group_after_middle, path)
}

fn path_has_prefix(path string, prefix string) bool {
	if prefix == '' {
		return true
	}
	if path == prefix {
		return true
	}
	return path.starts_with(prefix + '/')
}

fn build_php_psr15_continue_handler_object(handler &VSlimPsr15ContinueHandler) vphp.PhpObject {
	unsafe {
		(&VSlimPsr15ContinueHandler(handler)).state = Psr15NextHandlerState{
			mode: .continue_marker
		}
		mut value := handler.bind_owned_php_object_value()
		object := value.as_object() or {
			value.release()
			return vphp.PhpObject.invalid()
		}
		value.release()
		return object
	}
}

fn internal_phase_continue_response() VSlimResponse {
	return VSlimResponse{
		status:       299
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type':     'text/plain; charset=utf-8'
			'x-vslim-continue': '1'
		}
	}
}

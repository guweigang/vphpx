module main

import vphp

#include "php_bridge.h"

fn dispatch_php_phase_middleware_raw(app &VSlimApp, payload vphp.RequestBorrowedZBox, route_params map[string]string, handler vphp.RequestBorrowedZBox, next_handler vphp.ZVal) !vphp.ZVal {
	target := resolve_php_phase_middleware_target(app, handler)!
	bind_route_target_to_app_if_supported(app, target)
	mut result := vphp.PhpObject.borrowed(target).method_request_owned('process', vphp.PhpValue.from_zval(normalize_psr15_server_request_payload(payload,
		route_params)), vphp.PhpValue.from_zval(next_handler))
	return result.take_zval()
}

fn is_internal_phase_continue_response(result vphp.ZVal) bool {
	res, ok := normalize_php_route_response(result)
	if !ok {
		return false
	}
	return res.status == 299 && (res.headers['x-vslim-continue'] or { '' }) == '1'
}

fn build_before_phase_dispatch_result(payload vphp.RequestBorrowedZBox, route_params map[string]string, cont &VSlimPsr15ContinueHandler, raw vphp.ZVal) PhaseMiddlewareDispatchResult {
	continued := cont.state.has_forwarded_request && is_internal_phase_continue_response(raw)
	return PhaseMiddlewareDispatchResult{
		raw_response_ref: vphp.RequestOwnedZBox.from_zval(raw)
		payload_ref:      continued_phase_request_payload(payload, route_params, cont)
		continued:        continued
	}
}

fn dispatch_php_before_phase_middleware(app &VSlimApp, payload vphp.RequestBorrowedZBox, route_params map[string]string, handler vphp.RequestBorrowedZBox) !PhaseMiddlewareDispatchResult {
	mut cont := &VSlimPsr15ContinueHandler{
		state: Psr15NextHandlerState{
			mode: .continue_marker
		}
	}
	next_handler := build_php_psr15_continue_handler_object(cont)
	raw := dispatch_php_phase_middleware_raw(app, payload, route_params, handler, next_handler)!
	return build_before_phase_dispatch_result(payload, route_params, cont, raw)
}

fn apply_php_before_middlewares(app &VSlimApp, path string, payload vphp.RequestBorrowedZBox) !VSlimBeforeMiddlewareResult {
	group_before := matching_group_before_middlewares(app, path)
	if app.php_before_middlewares.len == 0 && group_before.len == 0 {
		return VSlimBeforeMiddlewareResult{
			payload_ref: payload.clone_request_owned()
		}
	}
	route_params := route_params_from_payload(payload)
	mut current_payload := payload.clone_request_owned()
	mut all := collect_before_middlewares(app, group_before)
	defer {
		release_collected_middlewares(mut all)
	}
	for hook in all {
		current_borrowed := current_payload.borrowed()
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return error('Middleware is not valid')
		}
		phase_result := dispatch_php_before_phase_middleware(app, current_borrowed, route_params,
			hook.borrowed())!
		if !phase_result.continued {
			return VSlimBeforeMiddlewareResult{
				response_ref: phase_result.raw_response_ref.clone_request_owned()
				payload_ref:  current_payload.clone_request_owned()
			}
		}
		current_payload = phase_result.payload_ref.clone_request_owned()
	}
	return VSlimBeforeMiddlewareResult{
		payload_ref: current_payload.clone_request_owned()
	}
}

fn matching_group_before_middlewares(app &VSlimApp, path string) []vphp.RequestOwnedZBox {
	return collect_matching_route_hooks(app.php_group_before_middle, path)
}

fn matching_group_middle_hooks(app &VSlimApp, path string) []vphp.RequestOwnedZBox {
	return collect_matching_route_hooks(app.php_group_middle, path)
}

fn matching_group_after_middlewares(app &VSlimApp, path string) []vphp.RequestOwnedZBox {
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

fn build_php_psr15_continue_handler_object(handler &VSlimPsr15ContinueHandler) vphp.ZVal {
	unsafe {
		(&VSlimPsr15ContinueHandler(handler)).state = Psr15NextHandlerState{
			mode: .continue_marker
		}
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		vphp.PhpReturn.new(payload.raw).owned_object(handler, C.vslim__psr15__continuehandler_ce,
			&C.vphp_class_handlers(vslimpsr15continuehandler_handlers()))
		return payload
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

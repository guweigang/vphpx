module appx

import httpx
import middlewarex
import vphp

fn (app &VSlimApp) dispatch_phase_middleware(payload vphp.PhpValue, route_params map[string]string, handler vphp.PhpValue, next_handler vphp.PhpObject) !vphp.PhpValue {
	target := app.resolve_phase_middleware_target(handler)!
	app.bind_route_target_if_supported(target)
	mut payload_arg := httpx.normalize_psr15_server_request(payload, route_params)
	defer {
		payload_arg.release()
	}
	return middlewarex.dispatch_phase_process(target, payload_arg, next_handler)
}

fn (app &VSlimApp) dispatch_before_phase_middleware(payload vphp.PhpValue, route_params map[string]string, handler vphp.PhpValue) !middlewarex.PhaseMiddlewareDispatchResult {
	mut cont := middlewarex.VSlimPsr15ContinueHandler.with_dispatcher(middlewarex.dispatch_psr15_next_handler)
	next_handler := cont.request_handler_object()
	response := app.dispatch_phase_middleware(payload, route_params, handler, next_handler)!
	return middlewarex.PhaseMiddlewareDispatchResult.from_before(payload, route_params, cont,
		response)
}

fn (app &VSlimApp) apply_before_middlewares(path string, payload vphp.PhpValue) !middlewarex.VSlimBeforeMiddlewareResult {
	mut group_before := app.matching_group_before_middlewares(path)
	defer {
		release_collected_middlewares(mut group_before)
	}
	if app.before_middlewares.len == 0 && group_before.len == 0 {
		return middlewarex.VSlimBeforeMiddlewareResult{
			payload_ref: payload.owned()
		}
	}
	route_params := httpx.route_params_from_payload(payload)
	mut current_payload := payload.owned()
	mut all := app.collect_before_middlewares(group_before)
	defer {
		release_collected_middlewares(mut all)
	}
	for hook in all {
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return error('Middleware is not valid')
		}
		phase_result := app.dispatch_before_phase_middleware(current_payload, route_params, hook)!
		if !phase_result.continued {
			return middlewarex.VSlimBeforeMiddlewareResult{
				response_ref: phase_result.response_ref.owned()
				payload_ref:  current_payload.owned()
			}
		}
		current_payload = phase_result.payload_ref.owned()
	}
	return middlewarex.VSlimBeforeMiddlewareResult{
		payload_ref: current_payload.owned()
	}
}

fn (app &VSlimApp) matching_group_before_middlewares(path string) []vphp.PhpValue {
	return app.group_before_middle.collect_matching(path)
}

fn (app &VSlimApp) matching_group_middle_hooks(path string) []vphp.PhpValue {
	return app.group_middle.collect_matching(path)
}

fn (app &VSlimApp) matching_group_after_middlewares(path string) []vphp.PhpValue {
	return app.group_after_middle.collect_matching(path)
}

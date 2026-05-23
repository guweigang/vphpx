module middlewarex

import httpx
import vphp

pub enum MiddlewareTerminalKind {
	none
	fixed_response
	not_found
	method_not_allowed
	error_response
}

pub struct MiddlewareTerminalMeta {
pub mut:
	kind               MiddlewareTerminalKind   = .none
	fixed_response_ref &httpx.VSlimPsr7Response = unsafe { nil }
	status             int
	message            string
	fallback_message   string
	error_code         string
	allowed_methods    []string
}

pub fn MiddlewareTerminalMeta.fixed_response(res httpx.VSlimResponse) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:               .fixed_response
		fixed_response_ref: res.to_psr7_response()
	}
}

pub fn MiddlewareTerminalMeta.not_found() MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind: .not_found
	}
}

pub fn MiddlewareTerminalMeta.method_not_allowed(allowed_methods []string) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:            .method_not_allowed
		allowed_methods: allowed_methods.clone()
	}
}

pub fn MiddlewareTerminalMeta.error(status int, message string, fallback_message string, error_code string) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:             .error_response
		status:           status
		message:          message
		fallback_message: fallback_message
		error_code:       error_code
	}
}

pub struct RawDispatchPlan {
pub mut:
	route_params             map[string]string
	terminal_meta            MiddlewareTerminalMeta
	route_handler            vphp.PhpValue = vphp.PhpValue.invalid()
	resource_action          string
	resource_missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
}

pub fn (plan RawDispatchPlan) has_terminal() bool {
	return plan.terminal_meta.kind != .none
}

pub fn (plan RawDispatchPlan) clone() RawDispatchPlan {
	return RawDispatchPlan{
		route_params:             httpx.snapshot_string_map(plan.route_params)
		terminal_meta:            plan.terminal_meta
		route_handler:            plan.route_handler.clone()
		resource_action:          plan.resource_action
		resource_missing_handler: plan.resource_missing_handler.clone()
	}
}

pub fn (mut plan RawDispatchPlan) release() {
	plan.route_handler.release()
	plan.resource_missing_handler.release()
}

pub struct PipelineRequestContext {
pub mut:
	path         string
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	route_params map[string]string
}

pub fn (ctx PipelineRequestContext) with_current_request(request vphp.PhpValue) PipelineRequestContext {
	return ctx.with_payload_value(request)
}

pub fn PipelineRequestContext.from_value(path string, payload vphp.PhpValue, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.owned()
		route_params: httpx.snapshot_string_map(route_params)
	}
}

pub fn PipelineRequestContext.from_object(path string, payload vphp.PhpObject, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.owned().to_value()
		route_params: httpx.snapshot_string_map(route_params)
	}
}

pub fn (ctx PipelineRequestContext) with_payload_value(payload vphp.PhpValue) PipelineRequestContext {
	return PipelineRequestContext{
		path:         ctx.path
		payload_ref:  payload.owned()
		route_params: httpx.snapshot_string_map(ctx.route_params)
	}
}

pub struct PipelineDispatchResult {
pub mut:
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
}

pub fn PipelineDispatchResult.from(response vphp.PhpValue, payload vphp.PhpValue) PipelineDispatchResult {
	return PipelineDispatchResult{
		response_ref: response.owned()
		payload_ref:  payload.owned()
	}
}

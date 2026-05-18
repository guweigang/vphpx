module main

import vphp

fn has_php_not_found_pipeline(app &VSlimApp, path string) bool {
	if app.php_before_middlewares.len > 0 || app.php_middlewares.len > 0 {
		return true
	}
	mut group_before := matching_group_before_middlewares(app, path)
	defer {
		release_collected_middlewares(mut group_before)
	}
	if group_before.len > 0 {
		return true
	}
	mut group_middle := matching_group_middle_hooks(app, path)
	defer {
		release_collected_middlewares(mut group_middle)
	}
	return group_middle.len > 0
}

fn dispatch_php_terminal(app &VSlimApp, req &VSlimRequest, terminal_meta MiddlewareTerminalMeta) PipelineDispatchResult {
	path := RoutePath.normalize(req.path_value())
	payload := build_php_request_value(req, map[string]string{})
	defer {
		payload.release()
	}
	return dispatch_php_pipeline(app, path, payload, RawDispatchPlan{
		route_params:  map[string]string{}
		terminal_meta: terminal_meta
	})
}

fn dispatch_php_not_found_terminal(app &VSlimApp, req &VSlimRequest) PipelineDispatchResult {
	method := resolve_effective_method(req)
	dispatch_req := request_with_method(req, method)
	return dispatch_php_terminal(app, &dispatch_req, not_found_terminal_meta())
}

fn pipeline_dispatch_result(response vphp.PhpValue, payload vphp.PhpValue) PipelineDispatchResult {
	return PipelineDispatchResult{
		response_ref: response.owned()
		payload_ref:  payload.owned()
	}
}

fn new_pipeline_request_context_value(path string, payload vphp.PhpValue, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.owned()
		route_params: snapshot_string_map(route_params)
	}
}

fn new_pipeline_request_context_from_object(path string, payload vphp.PhpObject, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.owned().to_value()
		route_params: snapshot_string_map(route_params)
	}
}

fn pipeline_request_context_with_payload_value(ctx PipelineRequestContext, payload vphp.PhpValue) PipelineRequestContext {
	return PipelineRequestContext{
		path:         ctx.path
		payload_ref:  payload.owned()
		route_params: snapshot_string_map(ctx.route_params)
	}
}

fn build_handler_not_callable_response_value(app &VSlimApp, ctx PipelineRequestContext, msg string) vphp.PhpValue {
	return build_php_response_value(error_response_from_context(app, ctx, 500, msg,
		'handler_not_callable'))
}

fn apply_before_stage(app &VSlimApp, ctx PipelineRequestContext) (PipelineRequestContext, vphp.PhpValue, bool) {
	before_middle := apply_php_before_middlewares(app, ctx.path, ctx.payload_ref) or {
		msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
		return ctx, build_handler_not_callable_response_value(app, ctx, msg), true
	}
	if before_middle.response_ref.is_valid() && !before_middle.response_ref.is_null()
		&& !before_middle.response_ref.is_undef() {
		return pipeline_request_context_with_payload_value(ctx, before_middle.payload_ref), before_middle.response_ref.owned(), true
	}
	return pipeline_request_context_with_payload_value(ctx, before_middle.payload_ref), vphp.PhpValue.null(), false
}

fn raw_dispatch_plan_has_terminal(plan RawDispatchPlan) bool {
	return plan.terminal_meta.kind != .none
}

fn clone_raw_dispatch_plan(plan RawDispatchPlan) RawDispatchPlan {
	return RawDispatchPlan{
		route_params:             snapshot_string_map(plan.route_params)
		terminal_meta:            plan.terminal_meta
		route_handler:            plan.route_handler.clone()
		resource_action:          plan.resource_action
		resource_missing_handler: plan.resource_missing_handler.clone()
	}
}

fn release_raw_dispatch_plan(mut plan RawDispatchPlan) {
	plan.route_handler.release()
	plan.resource_missing_handler.release()
}

fn error_response_from_context(app &VSlimApp, ctx PipelineRequestContext, status int, message string, fallback_code string) VSlimResponse {
	return run_error_handler_with_context(app, ctx, status, message) or {
		default_error_response(app, status, message, fallback_code)
	}
}

fn error_response_from_context_psr(app &VSlimApp, ctx PipelineRequestContext, status int, message string, fallback_code string) &VSlimPsr7Response {
	return run_error_handler_with_context_psr(app, ctx, status, message) or {
		default_error_response_psr(app, status, message, fallback_code)
	}
}

fn resolve_route_response_value(app &VSlimApp, ctx PipelineRequestContext, response vphp.PhpValue, plan RawDispatchPlan) vphp.PhpValue {
	if response.is_valid() && !response.is_null() && !response.is_undef() {
		return response.owned()
	}
	mut missing_handler := plan.resource_missing_handler.clone()
	defer {
		missing_handler.release()
	}
	missing_raw := dispatch_resource_missing_meta(plan.resource_action, missing_handler,
		ctx.payload_ref, ctx.route_params)
	if missing_raw.is_valid() && !missing_raw.is_null() && !missing_raw.is_undef() {
		return missing_raw.owned()
	}
	return build_php_response_value(run_not_found_core_with_context(app, ctx))
}

fn execute_dispatch_plan(app &VSlimApp, ctx PipelineRequestContext, plan RawDispatchPlan) !vphp.PhpValue {
	if raw_dispatch_plan_has_terminal(plan) {
		return build_php_response_value(build_terminal_response(app, ctx, plan.terminal_meta))
	}
	mut route_handler := plan.route_handler.clone()
	defer {
		route_handler.release()
	}
	response := dispatch_route_handler(app, route_handler, ctx.payload_ref, ctx.route_params)!
	return resolve_route_response_value(app, ctx, response, plan)
}

fn dispatch_plan_from_payload(app &VSlimApp, ctx PipelineRequestContext, route_middle []vphp.PhpValue, plan RawDispatchPlan) PipelineDispatchResult {
	result := dispatch_php_middleware_chain_with_context(app, ctx, route_middle, plan) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		return pipeline_dispatch_result(build_handler_not_callable_response_value(app, ctx, msg),
			ctx.payload_ref)
	}
	return result
}

fn dispatch_php_pipeline(app &VSlimApp, path string, initial_payload vphp.PhpValue, plan RawDispatchPlan) PipelineDispatchResult {
	initial_ctx := new_pipeline_request_context_value(path, initial_payload, plan.route_params)
	effective_ctx, early_response, halted := apply_before_stage(app, initial_ctx)
	if halted {
		return pipeline_dispatch_result(early_response, effective_ctx.payload_ref)
	}
	mut route_middle := matching_group_middle_hooks(app, path)
	defer {
		release_collected_middlewares(mut route_middle)
	}
	return dispatch_plan_from_payload(app, effective_ctx, route_middle, plan)
}

fn finalize_response(app &VSlimApp, ctx PipelineRequestContext, response vphp.PhpValue) VSlimResponse {
	res := normalize_or_handle_error_with_context(app, ctx, response, 500, 'Invalid route response')
	return finalize_php_response(app, ctx, res)
}

fn finalize_response_with_snapshot(app &VSlimApp, ctx PipelineRequestContext, response vphp.PhpValue) (VSlimResponse, &VSlimRequest) {
	res := finalize_response(app, ctx, response)
	return snapshot_vslim_response(res), request_snapshot_from_payload(ctx.payload_ref,
		ctx.route_params)
}

fn finalize_response_for_psr(app &VSlimApp, ctx PipelineRequestContext, response vphp.PhpValue) &VSlimPsr7Response {
	if app.php_after_middlewares.len == 0
		&& matching_group_after_middlewares(app, ctx.path).len == 0 {
		res, ok := normalize_php_route_response_psr_value(response)
		if ok {
			return res
		}
		return error_response_from_context_psr(app, ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	res, ok := normalize_php_route_response_psr_value(response)
	if !ok {
		return error_response_from_context_psr(app, ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return finalize_php_response_psr(app, ctx, res)
}

fn finalize_response_for_worker(app &VSlimApp, ctx PipelineRequestContext, response vphp.PhpValue) (vphp.PhpValue, &VSlimRequest) {
	if is_worker_stream_response(response) {
		return response.owned(), request_snapshot_from_payload(ctx.payload_ref, ctx.route_params)
	}
	res, snapshot := finalize_response_with_snapshot(app, ctx, response)
	return build_php_response_value(res), snapshot
}

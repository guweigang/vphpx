module main

import vphp

fn (app &VSlimApp) has_not_found_pipeline(path string) bool {
	if app.before_middlewares.len > 0 || app.middlewares.len > 0 {
		return true
	}
	mut group_before := app.matching_group_before_middlewares(path)
	defer {
		release_collected_middlewares(mut group_before)
	}
	if group_before.len > 0 {
		return true
	}
	mut group_middle := app.matching_group_middle_hooks(path)
	defer {
		release_collected_middlewares(mut group_middle)
	}
	return group_middle.len > 0
}

fn (app &VSlimApp) dispatch_terminal(req &VSlimRequest, terminal_meta MiddlewareTerminalMeta) PipelineDispatchResult {
	path := RoutePath.normalize(req.path_value())
	payload := req.build_request_value(map[string]string{})
	defer {
		payload.release()
	}
	return app.dispatch_pipeline(path, payload, RawDispatchPlan{
		route_params:  map[string]string{}
		terminal_meta: terminal_meta
	})
}

fn (app &VSlimApp) dispatch_not_found_terminal(req &VSlimRequest) PipelineDispatchResult {
	method := req.effective_method()
	dispatch_req := req.with_method(method)
	return app.dispatch_terminal(&dispatch_req, MiddlewareTerminalMeta.not_found())
}

fn PipelineDispatchResult.from(response vphp.PhpValue, payload vphp.PhpValue) PipelineDispatchResult {
	return PipelineDispatchResult{
		response_ref: response.owned()
		payload_ref:  payload.owned()
	}
}

fn PipelineRequestContext.from_value(path string, payload vphp.PhpValue, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.owned()
		route_params: snapshot_string_map(route_params)
	}
}

fn PipelineRequestContext.from_object(path string, payload vphp.PhpObject, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.owned().to_value()
		route_params: snapshot_string_map(route_params)
	}
}

fn (ctx PipelineRequestContext) with_payload_value(payload vphp.PhpValue) PipelineRequestContext {
	return PipelineRequestContext{
		path:         ctx.path
		payload_ref:  payload.owned()
		route_params: snapshot_string_map(ctx.route_params)
	}
}

fn (app &VSlimApp) handler_not_callable_response_value(ctx PipelineRequestContext, msg string) vphp.PhpValue {
	return app.error_response_from_context(ctx, 500, msg, 'handler_not_callable').to_value()
}

fn (app &VSlimApp) apply_before_stage(ctx PipelineRequestContext) (PipelineRequestContext, vphp.PhpValue, bool) {
	before_middle := app.apply_before_middlewares(ctx.path, ctx.payload_ref) or {
		msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
		return ctx, app.handler_not_callable_response_value(ctx, msg), true
	}
	if before_middle.response_ref.is_valid() && !before_middle.response_ref.is_null()
		&& !before_middle.response_ref.is_undef() {
		return ctx.with_payload_value(before_middle.payload_ref), before_middle.response_ref.owned(), true
	}
	return ctx.with_payload_value(before_middle.payload_ref), vphp.PhpValue.null(), false
}

fn (plan RawDispatchPlan) has_terminal() bool {
	return plan.terminal_meta.kind != .none
}

fn (plan RawDispatchPlan) clone() RawDispatchPlan {
	return RawDispatchPlan{
		route_params:             snapshot_string_map(plan.route_params)
		terminal_meta:            plan.terminal_meta
		route_handler:            plan.route_handler.clone()
		resource_action:          plan.resource_action
		resource_missing_handler: plan.resource_missing_handler.clone()
	}
}

fn (mut plan RawDispatchPlan) release() {
	plan.route_handler.release()
	plan.resource_missing_handler.release()
}

fn (app &VSlimApp) error_response_from_context(ctx PipelineRequestContext, status int, message string, fallback_code string) VSlimResponse {
	return app.run_error_handler_with_context(ctx, status, message) or {
		app.default_error_response(status, message, fallback_code)
	}
}

fn (app &VSlimApp) error_response_from_context_psr(ctx PipelineRequestContext, status int, message string, fallback_code string) &VSlimPsr7Response {
	return app.run_error_handler_with_context_psr(ctx, status, message) or {
		app.default_error_response_psr(status, message, fallback_code)
	}
}

fn (app &VSlimApp) resolve_route_response_value(ctx PipelineRequestContext, response vphp.PhpValue, plan RawDispatchPlan) vphp.PhpValue {
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
	return app.run_not_found_core_with_context(ctx).to_value()
}

fn (app &VSlimApp) execute_dispatch_plan(ctx PipelineRequestContext, plan RawDispatchPlan) !vphp.PhpValue {
	if plan.has_terminal() {
		return plan.terminal_meta.build_response(app, ctx).to_value()
	}
	mut route_handler := plan.route_handler.clone()
	defer {
		route_handler.release()
	}
	response := app.dispatch_route_handler(route_handler, ctx.payload_ref, ctx.route_params)!
	return app.resolve_route_response_value(ctx, response, plan)
}

fn (app &VSlimApp) dispatch_plan_from_payload(ctx PipelineRequestContext, route_middle []vphp.PhpValue, plan RawDispatchPlan) PipelineDispatchResult {
	result := app.dispatch_middleware_chain_with_context(ctx, route_middle, plan) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		return PipelineDispatchResult.from(app.handler_not_callable_response_value(ctx, msg),
			ctx.payload_ref)
	}
	return result
}

fn (app &VSlimApp) dispatch_pipeline(path string, initial_payload vphp.PhpValue, plan RawDispatchPlan) PipelineDispatchResult {
	initial_ctx := PipelineRequestContext.from_value(path, initial_payload, plan.route_params)
	effective_ctx, early_response, halted := app.apply_before_stage(initial_ctx)
	if halted {
		return PipelineDispatchResult.from(early_response, effective_ctx.payload_ref)
	}
	mut route_middle := app.matching_group_middle_hooks(path)
	defer {
		release_collected_middlewares(mut route_middle)
	}
	return app.dispatch_plan_from_payload(effective_ctx, route_middle, plan)
}

fn (app &VSlimApp) finalize_response(ctx PipelineRequestContext, response vphp.PhpValue) VSlimResponse {
	res := app.normalize_or_handle_error_with_context(ctx, response, 500, 'Invalid route response')
	return app.finalize_with_after_middlewares(ctx, res)
}

fn (app &VSlimApp) finalize_response_with_snapshot(ctx PipelineRequestContext, response vphp.PhpValue) (VSlimResponse, &VSlimRequest) {
	res := app.finalize_response(ctx, response)
	return (res).snapshot(), VSlimRequest.from_payload(ctx.payload_ref,
		ctx.route_params)
}

fn (app &VSlimApp) finalize_response_for_psr(ctx PipelineRequestContext, response vphp.PhpValue) &VSlimPsr7Response {
	if app.after_middlewares.len == 0
		&& app.matching_group_after_middlewares(ctx.path).len == 0 {
		res, ok := VSlimResponse.psr7_from_route_result(response)
		if ok {
			return res
		}
		return app.error_response_from_context_psr(ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	res, ok := VSlimResponse.psr7_from_route_result(response)
	if !ok {
		return app.error_response_from_context_psr(ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return app.finalize_with_after_middlewares_psr(ctx, res)
}

fn (app &VSlimApp) finalize_response_for_worker(ctx PipelineRequestContext, response vphp.PhpValue) (vphp.PhpValue, &VSlimRequest) {
	if value_subject(response).is_worker_stream_response() {
		return response.owned(), VSlimRequest.from_payload(ctx.payload_ref, ctx.route_params)
	}
	res, snapshot := app.finalize_response_with_snapshot(ctx, response)
	return res.to_value(), snapshot
}

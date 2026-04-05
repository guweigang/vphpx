module main

import vphp

fn has_php_not_found_pipeline(app &VSlimApp, path string) bool {
	if app.php_before_middlewares.len > 0 || app.php_middlewares.len > 0 {
		return true
	}
	if matching_group_before_middlewares(app, path).len > 0 {
		return true
	}
	return matching_group_middle_hooks(app, path).len > 0
}

fn dispatch_php_terminal_raw(app &VSlimApp, req &VSlimRequest, terminal_meta MiddlewareTerminalMeta) (vphp.ZVal, vphp.RequestOwnedZBox) {
	path := RoutePath.normalize(req.path)
	payload := build_php_request_object(req, map[string]string{})
	return dispatch_php_pipeline_raw(app, path, vphp.BorrowedZVal.from_zval(payload),
		RawDispatchPlan{
		route_params:  map[string]string{}
		terminal_meta: terminal_meta
	})
}

fn dispatch_php_not_found_terminal_raw(app &VSlimApp, req &VSlimRequest) (vphp.ZVal, vphp.RequestOwnedZBox) {
	method := resolve_effective_method(req)
	dispatch_req := request_with_method(req, method)
	return dispatch_php_terminal_raw(app, &dispatch_req, not_found_terminal_meta())
}

fn new_pipeline_request_context(path string, payload vphp.RequestOwnedZBox, route_params map[string]string) PipelineRequestContext {
	return PipelineRequestContext{
		path:         path
		payload_ref:  payload.clone_request_owned()
		route_params: route_params.clone()
	}
}

fn pipeline_request_context_with_payload(ctx PipelineRequestContext, payload vphp.RequestOwnedZBox) PipelineRequestContext {
	return new_pipeline_request_context(ctx.path, payload, ctx.route_params)
}

fn build_handler_not_callable_raw_response(app &VSlimApp, request_payload vphp.BorrowedZVal, msg string) vphp.ZVal {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'),
		request_payload.clone_request_owned(), route_params_from_payload(request_payload))
	return build_handler_not_callable_raw_response_with_context(app, ctx, msg)
}

fn build_handler_not_callable_raw_response_with_context(app &VSlimApp, ctx PipelineRequestContext, msg string) vphp.ZVal {
	return build_php_response_object(error_response_from_context(app, ctx, 500, msg,
		'handler_not_callable'))
}

fn apply_before_stage_raw(app &VSlimApp, ctx PipelineRequestContext) (PipelineRequestContext, vphp.ZVal, bool) {
	before_middle := apply_php_before_middlewares(app, ctx.path, ctx.payload_ref.borrowed()) or {
		msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
		return ctx, build_handler_not_callable_raw_response_with_context(app, ctx, msg), true
	}
	if before_middle.response_ref.is_valid() && !before_middle.response_ref.is_null()
		&& !before_middle.response_ref.is_undef() {
		return pipeline_request_context_with_payload(ctx, before_middle.payload_ref),
			before_middle.response_ref.to_zval(), true
	}
	return pipeline_request_context_with_payload(ctx, before_middle.payload_ref),
		vphp.RequestOwnedZBox.new_null().to_zval(), false
}

fn raw_dispatch_plan_has_terminal(plan RawDispatchPlan) bool {
	return plan.terminal_meta.kind != .none
}

fn clone_raw_dispatch_plan(plan RawDispatchPlan) RawDispatchPlan {
	return RawDispatchPlan{
		route_params:             plan.route_params.clone()
		terminal_meta:            plan.terminal_meta
		route_handler:            plan.route_handler.clone_persistent_owned()
		resource_action:          plan.resource_action
		resource_missing_handler: plan.resource_missing_handler.clone_persistent_owned()
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

fn resolve_raw_route_response(app &VSlimApp, ctx PipelineRequestContext, raw_res vphp.ZVal, plan RawDispatchPlan) vphp.ZVal {
	if raw_res.is_valid() && !raw_res.is_null() && !raw_res.is_undef() {
		return raw_res
	}
	mut missing_handler := plan.resource_missing_handler.clone_request_owned()
	defer {
		missing_handler.release()
	}
	missing_raw := dispatch_resource_missing_meta(plan.resource_action, missing_handler.borrowed(),
		ctx.payload_ref.borrowed(), ctx.route_params)
	if missing_raw.is_valid() && !missing_raw.is_null() && !missing_raw.is_undef() {
		return missing_raw
	}
	return build_php_response_object(run_not_found_core_with_context(app, ctx))
}

fn execute_raw_dispatch_plan(app &VSlimApp, ctx PipelineRequestContext, plan RawDispatchPlan) !vphp.ZVal {
	if raw_dispatch_plan_has_terminal(plan) {
		return build_php_response_object(build_terminal_response(app, ctx, plan.terminal_meta))
	}
	mut route_handler := plan.route_handler.clone_request_owned()
	defer {
		route_handler.release()
	}
	raw_res := dispatch_route_handler(app, route_handler.borrowed(), ctx.payload_ref.borrowed(),
		ctx.route_params)!
	return resolve_raw_route_response(app, ctx, raw_res, plan)
}

fn dispatch_plan_from_payload_raw(app &VSlimApp, ctx PipelineRequestContext, route_middle []vphp.RequestOwnedZBox, plan RawDispatchPlan) (vphp.ZVal, vphp.RequestOwnedZBox) {
	raw_res, middleware_payload := dispatch_php_middleware_chain_with_context(app, ctx,
		route_middle, plan) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		return build_handler_not_callable_raw_response_with_context(app, ctx, msg),
			ctx.payload_ref.clone_request_owned()
	}
	return raw_res, middleware_payload
}

fn dispatch_php_pipeline_raw(app &VSlimApp, path string, initial_payload vphp.BorrowedZVal, plan RawDispatchPlan) (vphp.ZVal, vphp.RequestOwnedZBox) {
	initial_ctx := new_pipeline_request_context(path, initial_payload.clone_request_owned(),
		plan.route_params)
	effective_ctx, early_raw, halted := apply_before_stage_raw(app, initial_ctx)
	if halted {
		return early_raw, effective_ctx.payload_ref.clone_request_owned()
	}
	route_middle := matching_group_middle_hooks(app, path)
	return dispatch_plan_from_payload_raw(app, effective_ctx, route_middle, plan)
}

fn finalize_raw_response(app &VSlimApp, ctx PipelineRequestContext, raw_res vphp.ZVal) VSlimResponse {
	res := normalize_or_handle_error_with_context(app, ctx, vphp.BorrowedZVal.from_zval(raw_res),
		500, 'Invalid route response')
	return finalize_php_response(app, ctx, res)
}

fn finalize_raw_response_with_snapshot(app &VSlimApp, ctx PipelineRequestContext, raw_res vphp.ZVal) (VSlimResponse, VSlimRequest) {
	res := finalize_raw_response(app, ctx, raw_res)
	return res, request_snapshot_from_payload(ctx.payload_ref.borrowed(), ctx.route_params)
}

fn finalize_raw_response_for_psr(app &VSlimApp, ctx PipelineRequestContext, raw_res vphp.ZVal) &VSlimPsr7Response {
	return new_psr7_response_from_vslim_response(finalize_raw_response(app, ctx, raw_res))
}

fn finalize_raw_response_for_worker(app &VSlimApp, ctx PipelineRequestContext, raw_res vphp.ZVal) (vphp.ZVal, VSlimRequest) {
	if is_worker_stream_response_borrowed(vphp.BorrowedZVal.from_zval(raw_res)) {
		return raw_res, request_snapshot_from_payload(ctx.payload_ref.borrowed(), ctx.route_params)
	}
	res, snapshot := finalize_raw_response_with_snapshot(app, ctx, raw_res)
	return build_php_response_object(res), snapshot
}

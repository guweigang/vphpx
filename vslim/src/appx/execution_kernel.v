module appx

import httpx
import middlewarex
import routex
import streamx
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

fn (app &VSlimApp) dispatch_terminal(req &httpx.VSlimRequest, terminal_meta middlewarex.MiddlewareTerminalMeta, options httpx.Psr7ResponseImportOptions) middlewarex.PipelineDispatchResult {
	path := req.normalized_path()
	mut payload := httpx.vslim_request_build_value(req, map[string]string{})
	defer {
		payload.release()
	}
	return app.dispatch_terminal_payload(path, payload, terminal_meta, options)
}

fn (app &VSlimApp) dispatch_resolved_terminal(req &httpx.VSlimRequest, source_payload vphp.PhpValue, terminal_meta middlewarex.MiddlewareTerminalMeta, options httpx.Psr7ResponseImportOptions) middlewarex.PipelineDispatchResult {
	if httpx.is_psr_server_request_payload(source_payload) {
		return app.dispatch_terminal_payload(req.normalized_path(), source_payload, terminal_meta, options)
	}
	return app.dispatch_terminal(req, terminal_meta, options)
}

fn (app &VSlimApp) dispatch_terminal_payload(path string, payload vphp.PhpValue, terminal_meta middlewarex.MiddlewareTerminalMeta, options httpx.Psr7ResponseImportOptions) middlewarex.PipelineDispatchResult {
	return app.dispatch_pipeline(path, payload, middlewarex.RawDispatchPlan{
		route_params:  map[string]string{}
		terminal_meta: terminal_meta
	}, options)
}

fn (app &VSlimApp) dispatch_not_found_terminal(req &httpx.VSlimRequest, options httpx.Psr7ResponseImportOptions) middlewarex.PipelineDispatchResult {
	method := req.effective_method()
	dispatch_req := req.with_method_snapshot(method)
	return app.dispatch_terminal(&dispatch_req, middlewarex.MiddlewareTerminalMeta.not_found(),
		options)
}

fn (app &VSlimApp) handler_not_callable_response_value(ctx middlewarex.PipelineRequestContext, msg string) vphp.PhpValue {
	if ctx.response_import.defer_body {
		return app.error_response_from_context_psr(ctx, 500, msg, 'handler_not_callable').build_psr7_response_value()
	}
	return httpx.vslim_response_to_value(app.error_response_from_context(ctx, 500, msg,
		'handler_not_callable'))
}

fn (app &VSlimApp) apply_before_stage(ctx middlewarex.PipelineRequestContext) (middlewarex.PipelineRequestContext, vphp.PhpValue, bool) {
	before_middle := app.apply_before_middlewares(ctx.path, ctx.payload_ref, ctx.route_params) or {
		msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
		return ctx, app.handler_not_callable_response_value(ctx, msg), true
	}
	if before_middle.response_ref.is_valid() && !before_middle.response_ref.is_null()
		&& !before_middle.response_ref.is_undef() {
		return ctx.with_payload_value(before_middle.payload_ref), before_middle.response_ref, true
	}
	return ctx.with_payload_value(before_middle.payload_ref), vphp.PhpValue.null(), false
}

fn (app &VSlimApp) error_response_from_context(ctx middlewarex.PipelineRequestContext, status int, message string, fallback_code string) httpx.VSlimResponse {
	return app.run_error_handler_with_context(ctx, status, message) or {
		app.default_error_response(status, message, fallback_code)
	}
}

fn (app &VSlimApp) error_response_from_context_psr(ctx middlewarex.PipelineRequestContext, status int, message string, fallback_code string) &httpx.VSlimPsr7Response {
	return app.run_error_handler_with_context_psr(ctx, status, message) or {
		app.default_error_response_psr(status, message, fallback_code)
	}
}

fn (app &VSlimApp) resolve_route_response_value(ctx middlewarex.PipelineRequestContext, mut response vphp.PhpValue, plan middlewarex.RawDispatchPlan) vphp.PhpValue {
	if response.is_valid() && !response.is_null() && !response.is_undef() {
		return response
	}
	response.release()
	mut missing_handler := plan.resource_missing_handler.clone()
	defer {
		missing_handler.release()
	}
	mut missing_raw := routex.dispatch_resource_missing(plan.resource_action, missing_handler,
		ctx.payload_ref, ctx.route_params)
	if missing_raw.is_valid() && !missing_raw.is_null() && !missing_raw.is_undef() {
		return missing_raw
	}
	missing_raw.release()
	if ctx.response_import.defer_body {
		return app.run_not_found_core_with_context_psr(ctx).build_psr7_response_value()
	}
	return httpx.vslim_response_to_value(app.run_not_found_core_with_context(ctx))
}

fn (app &VSlimApp) execute_dispatch_plan(ctx middlewarex.PipelineRequestContext, plan middlewarex.RawDispatchPlan) !vphp.PhpValue {
	if plan.has_terminal() {
		if ctx.response_import.defer_body || httpx.is_psr_server_request_payload(ctx.payload_ref) {
			response := app.build_terminal_response_psr(plan.terminal_meta, ctx)
			return response.build_psr7_response_value()
		}
		return httpx.vslim_response_to_value(app.build_terminal_response(plan.terminal_meta, ctx))
	}
	mut route_handler := plan.route_handler.clone()
	defer {
		route_handler.release()
	}
	mut response := app.dispatch_route_handler(route_handler, ctx.payload_ref, ctx.route_params)!
	return app.resolve_route_response_value(ctx, mut response, plan)
}

fn (app &VSlimApp) dispatch_plan_from_payload(ctx middlewarex.PipelineRequestContext, route_middle []vphp.PhpValue, plan middlewarex.RawDispatchPlan) middlewarex.PipelineDispatchResult {
	result := app.dispatch_middleware_chain_with_context(ctx, route_middle, plan) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		return middlewarex.PipelineDispatchResult.from(app.handler_not_callable_response_value(ctx, msg),
			ctx.payload_ref)
	}
	return result
}

fn (app &VSlimApp) dispatch_pipeline(path string, initial_payload vphp.PhpValue, plan middlewarex.RawDispatchPlan, options httpx.Psr7ResponseImportOptions) middlewarex.PipelineDispatchResult {
	initial_ctx := middlewarex.PipelineRequestContext.from_value(path, initial_payload, plan.route_params,
		options)
	effective_ctx, early_response, halted := app.apply_before_stage(initial_ctx)
	if halted {
		return middlewarex.PipelineDispatchResult.from(early_response, effective_ctx.payload_ref)
	}
	mut route_middle := app.matching_group_middle_hooks(path)
	defer {
		release_collected_middlewares(mut route_middle)
	}
	return app.dispatch_plan_from_payload(effective_ctx, route_middle, plan)
}

fn (app &VSlimApp) finalize_response(ctx middlewarex.PipelineRequestContext, response vphp.PhpValue) httpx.VSlimResponse {
	res := app.normalize_or_handle_error_with_context(ctx, response, 500, 'Invalid route response')
	return app.finalize_with_after_middlewares(ctx, res)
}

fn (app &VSlimApp) finalize_response_with_snapshot(ctx middlewarex.PipelineRequestContext, response vphp.PhpValue) (httpx.VSlimResponse, &httpx.VSlimRequest) {
	res := app.finalize_response(ctx, response)
	return res.snapshot(), httpx.vslim_request_from_psr_server_request(ctx.payload_ref,
		ctx.route_params)
}

fn (app &VSlimApp) finalize_response_for_psr(ctx middlewarex.PipelineRequestContext, response vphp.PhpValue) &httpx.VSlimPsr7Response {
	if app.after_middlewares.len == 0 && !app.group_after_middle.has_matching(ctx.path) {
		res, ok := httpx.VSlimPsr7Response.from_route_result(response, ctx.response_import)
		if ok {
			return res
		}
		return app.error_response_from_context_psr(ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	res, ok := httpx.VSlimPsr7Response.from_route_result(response, ctx.response_import)
	if !ok {
		return app.error_response_from_context_psr(ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return app.finalize_with_after_middlewares_psr(ctx, res)
}

fn (app &VSlimApp) finalize_response_for_worker(ctx middlewarex.PipelineRequestContext, response vphp.PhpValue, head bool) (vphp.PhpValue, &httpx.VSlimRequest) {
	snapshot := httpx.vslim_request_from_psr_server_request(ctx.payload_ref, ctx.route_params,
		include_body: false
	)
	if streamx.is_worker_stream_response(response) {
		return streamx.suppress_worker_stream_body(response, head), snapshot
	}
	psr := app.finalize_response_for_psr(ctx, response)
	raw := streamx.psr7_worker_response(psr, head) or {
		if !vphp.PhpException.has_current() {
			vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		}
		return vphp.PhpValue.null(), snapshot
	}
	return raw, snapshot
}

module main

import vphp

#include "php_bridge.h"

fn build_php_psr15_next_handler_object(chain &MiddlewareChain) vphp.PhpObject {
	unsafe {
		bound := &VSlimPsr15NextHandler{
			state: Psr15NextHandlerState{
				mode:      .middleware_chain
				chain_ref: chain
			}
		}
		mut value := bound.bind_owned_php_object_value()
		object := value.as_object() or {
			value.release()
			return vphp.PhpObject.invalid()
		}
		value.release()
		return object
	}
}

fn build_php_psr15_fixed_response_handler_object(res &VSlimPsr7Response) vphp.PhpObject {
	unsafe {
		bound := &VSlimPsr15NextHandler{
			state: Psr15NextHandlerState{
				mode:               .fixed_response
				fixed_response_ref: res
			}
		}
		mut value := bound.bind_owned_php_object_value()
		object := value.as_object() or {
			value.release()
			return vphp.PhpObject.invalid()
		}
		value.release()
		return object
	}
}

fn dispatch_php_middleware_chain_with_plan(app &VSlimApp, path string, payload vphp.PhpValue, route_middle []vphp.PhpValue, plan RawDispatchPlan) !PipelineDispatchResult {
	request_ctx := new_pipeline_request_context_value(path, payload, plan.route_params)
	return dispatch_php_middleware_chain_with_context(app, request_ctx, route_middle, plan)
}

fn dispatch_php_middleware_chain_with_context(app &VSlimApp, ctx PipelineRequestContext, route_middle []vphp.PhpValue, plan RawDispatchPlan) !PipelineDispatchResult {
	if app.php_middlewares.len == 0 && route_middle.len == 0 {
		return pipeline_dispatch_result(execute_dispatch_plan(app, ctx, plan)!, ctx.payload_ref)
	}
	mut chain_plan := clone_raw_dispatch_plan(plan)
	defer {
		release_raw_dispatch_plan(mut chain_plan)
	}
	mut chain := &MiddlewareChain{
		app:         app
		request_ctx: ctx
		middlewares: collect_standard_middlewares(app, route_middle)
		plan:        chain_plan
	}
	defer {
		release_collected_middlewares(mut chain.middlewares)
	}
	response := chain.dispatch(ctx.payload_ref) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		mut error_payload := ctx.payload_ref.owned()
		if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(chain)) {
			mut forwarded := request_with_forwarded_snapshot(ctx.payload_ref, ctx.route_params,
				forwarded_request)
			error_payload = forwarded.owned().to_value()
			forwarded.release()
		}
		error_ctx := pipeline_request_context_with_payload_value(ctx, error_payload)
		res := error_response_from_context(app, error_ctx, 500, msg, 'handler_not_callable')
		return pipeline_dispatch_result(build_php_response_value(res), error_payload)
	}
	cli_debug_log('middleware.chain.raw type=${response.type_name()} class=${response.class_name()} valid=${response.is_valid()} null=${response.is_null()} undef=${response.is_undef()}')
	if forwarded_request := take_forwarded_request_snapshot(forwarded_request_key(chain)) {
		mut forwarded := request_with_forwarded_snapshot(ctx.payload_ref, ctx.route_params,
			forwarded_request)
		out := forwarded.owned().to_value()
		forwarded.release()
		return pipeline_dispatch_result(response, out)
	}
	return pipeline_dispatch_result(response, ctx.payload_ref)
}

fn (mut chain MiddlewareChain) dispatch(payload vphp.PhpValue) !vphp.PhpValue {
	mut normalized := normalize_psr15_server_request(payload, chain.request_ctx.route_params)
	if snapshot := snapshot_phase_forwarded_request(normalized) {
		store_forwarded_request_snapshot(forwarded_request_key(chain), snapshot)
	}
	normalized.release()
	effective_ctx := pipeline_request_context_with_payload_value(chain.request_ctx, payload)
	if chain.index >= chain.middlewares.len {
		return execute_dispatch_plan(chain.app, effective_ctx, chain.plan)!
	}
	mw := chain.middlewares[chain.index]
	chain.index++
	if !mw.is_valid() || mw.is_null() || mw.is_undef() {
		cli_debug_log('middleware.invalid idx=${chain.index - 1} valid=${mw.is_valid()} null=${mw.is_null()} undef=${mw.is_undef()} total=${chain.middlewares.len}')
		return error('Middleware is not valid')
	}
	if !mw.is_valid() || mw.is_null() || mw.is_undef() {
		cli_debug_log('middleware.req.invalid idx=${chain.index - 1} valid=${mw.is_valid()} null=${mw.is_null()} undef=${mw.is_undef()}')
	}
	response := dispatch_php_middleware_entry(mut chain, mw, payload)!
	if !response.is_valid() || response.is_null() || response.is_undef() {
		return error('Middleware must return a response')
	}
	return response
}

fn (mut chain MiddlewareChain) dispatch_pre_normalized(payload vphp.PhpValue) !vphp.PhpValue {
	if normalized := payload.as_object() {
		if snapshot := snapshot_phase_forwarded_request(normalized) {
			store_forwarded_request_snapshot(forwarded_request_key(chain), snapshot)
		}
	}
	effective_ctx := pipeline_request_context_with_payload_value(chain.request_ctx, payload)
	if chain.index >= chain.middlewares.len {
		return execute_dispatch_plan(chain.app, effective_ctx, chain.plan)!
	}
	mw := chain.middlewares[chain.index]
	chain.index++
	if !mw.is_valid() || mw.is_null() || mw.is_undef() {
		return error('Middleware is not valid')
	}
	response := dispatch_php_middleware_entry(mut chain, mw, payload)!
	if !response.is_valid() || response.is_null() || response.is_undef() {
		return error('Middleware must return a response')
	}
	return response
}

fn dispatch_php_after_phase_middleware_psr(app &VSlimApp, ctx PipelineRequestContext, hook vphp.PhpValue, current &VSlimPsr7Response) !vphp.PhpValue {
	next_handler := build_php_psr15_fixed_response_handler_object(current)
	if !hook.is_valid() || hook.is_null() || hook.is_undef() {
		return error('Middleware is not valid')
	}
	return dispatch_php_phase_middleware(app, ctx.payload_ref, ctx.route_params, hook, next_handler)
}

fn apply_php_after_middlewares(app &VSlimApp, ctx PipelineRequestContext, initial VSlimResponse) VSlimResponse {
	cli_debug_log('after.input vslim status=${initial.status} body_len=${initial.body.len}')
	initial_psr := new_psr7_response_from_vslim_response(initial)
	cli_debug_log('after.input psr status=${initial_psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(initial_psr)).len}')
	psr := apply_php_after_middlewares_psr(app, ctx, initial_psr)
	cli_debug_log('after.psr final status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
	res := new_vslim_response_from_psr_response(psr)
	cli_debug_log('after.vslim final status=${res.status} body_len=${res.body.len}')
	return res
}

fn apply_php_after_middlewares_psr(app &VSlimApp, ctx PipelineRequestContext, initial &VSlimPsr7Response) &VSlimPsr7Response {
	mut group_after := matching_group_after_middlewares(app, ctx.path)
	defer {
		release_collected_middlewares(mut group_after)
	}
	if app.php_after_middlewares.len == 0 && group_after.len == 0 {
		return initial
	}
	mut current := unsafe { initial }
	mut all := collect_after_middlewares(app, group_after)
	defer {
		release_collected_middlewares(mut all)
	}
	for hook in all {
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return error_response_from_context_psr(app, ctx, 500, 'Middleware is not valid',
				'handler_not_callable')
		}
		resolve_php_phase_middleware_target(app, hook) or {
			msg := if err.msg() == '' {
				'Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface'
			} else {
				err.msg()
			}
			return error_response_from_context_psr(app, ctx, 500, msg, 'handler_not_callable')
		}
		response := dispatch_php_after_phase_middleware_psr(app, ctx, hook, current) or {
			msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
			return error_response_from_context_psr(app, ctx, 500, msg, 'handler_not_callable')
		}
		if response.is_object() && response.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			psr := normalize_to_psr7_response_value(response)
			cli_debug_log('after.raw psr status=${psr.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(psr)).len}')
		}
		mut res, ok := normalize_php_route_response_psr_value(response)
		if ok {
			cli_debug_log('after.normalized psr status=${res.get_status_code()} body_len=${psr7_stream_string(response_body_or_empty(res)).len}')
			current = res
			continue
		}
		current = error_response_from_context_psr(app, ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return current
}

fn finalize_php_response(app &VSlimApp, ctx PipelineRequestContext, initial VSlimResponse) VSlimResponse {
	return apply_php_after_middlewares(app, ctx, initial)
}

fn finalize_php_response_psr(app &VSlimApp, ctx PipelineRequestContext, initial &VSlimPsr7Response) &VSlimPsr7Response {
	return apply_php_after_middlewares_psr(app, ctx, initial)
}

fn request_with_method(req &VSlimRequest, method string) VSlimRequest {
	mut out := snapshot_vslim_request(req)
	out.method = method.clone()
	return out
}

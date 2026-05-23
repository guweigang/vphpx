module appx

import httpx
import loggerx
import middlewarex
import vphp

#include "php_bridge.h"

fn app_terminal_callback(app_ptr voidptr, ctx middlewarex.PipelineRequestContext, plan middlewarex.RawDispatchPlan) !vphp.PhpValue {
	mut app := unsafe { &VSlimApp(app_ptr) }
	return app.execute_dispatch_plan(ctx, plan)!
}

fn app_error_callback(app_ptr voidptr, ctx middlewarex.PipelineRequestContext, msg string) &httpx.VSlimPsr7Response {
	mut app := unsafe { &VSlimApp(app_ptr) }
	res := app.error_response_from_context(ctx, 500, msg, 'handler_not_callable')
	return res.to_psr7_response()
}

fn app_execute_middleware_callback(app_ptr voidptr, chain &middlewarex.MiddlewareChain, handler vphp.PhpValue, payload vphp.PhpValue) !vphp.PhpValue {
	mut app := unsafe { &VSlimApp(app_ptr) }
	target, explicit_method := app.resolve_middleware_target(handler) or {
		loggerx.cli_debug_log('middleware.target.resolve.error msg=${err.msg()} handler_valid=${handler.is_valid()} handler_kind=${handler.kind_name()}')
		return err
	}
	app.bind_route_target_if_supported(target)
	method := httpx.psr15_middleware_target_method(target, explicit_method)
	if middlewarex.is_phase_middleware_target(target, explicit_method) {
		mut psr_payload := httpx.normalize_psr15_server_request(payload,
			chain.request_ctx.route_params)
		defer {
			psr_payload.release()
		}
		mut next_handler := chain.build_psr15_next_handler_object(middlewarex.dispatch_psr15_next_handler)
		if !next_handler.is_valid() {
			return error('Next handler object could not be created')
		}
		defer {
			next_handler.release()
		}
		mut result := middlewarex.dispatch_phase_process(target, psr_payload, next_handler)!
		defer {
			result.release()
		}
		normalized := httpx.VSlimPsr7Response.from_value(result)
		return httpx.vslim_response_to_value(normalized.to_vslim_response())
	}
	loggerx.cli_debug_log('middleware.target.invalid method=${method} target_valid=${target.is_valid()} target_kind=${target.kind_name()} target_class=${target.class_name()}')
	return error('Middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
}

fn (app &VSlimApp) dispatch_middleware_chain_with_plan(path string, payload vphp.PhpValue, route_middle []vphp.PhpValue, plan middlewarex.RawDispatchPlan) !middlewarex.PipelineDispatchResult {
	request_ctx := middlewarex.PipelineRequestContext.from_value(path, payload, plan.route_params)
	return app.dispatch_middleware_chain_with_context(request_ctx, route_middle, plan)
}

fn (app &VSlimApp) dispatch_middleware_chain_with_context(ctx middlewarex.PipelineRequestContext, route_middle []vphp.PhpValue, plan middlewarex.RawDispatchPlan) !middlewarex.PipelineDispatchResult {
	if app.middlewares.len == 0 && route_middle.len == 0 {
		return middlewarex.PipelineDispatchResult.from(app.execute_dispatch_plan(ctx, plan)!, ctx.payload_ref)
	}
	mut chain_plan := plan.clone()
	defer {
		chain_plan.release()
	}
	mut chain := &middlewarex.MiddlewareChain{
		app_ctx:     voidptr(app)
		request_ctx: ctx
		middlewares: app.collect_standard_middlewares(route_middle)
		plan:        chain_plan
		on_terminal: app_terminal_callback
		on_error:    app_error_callback
		on_execute:  app_execute_middleware_callback
	}
	defer {
		release_collected_middlewares(mut chain.middlewares)
	}
	response := chain.dispatch(ctx.payload_ref) or {
		msg := if err.msg() == '' { 'Route handler is not callable' } else { err.msg() }
		mut error_payload := ctx.payload_ref.owned()
		if forwarded_request := middlewarex.take_forwarded_request_snapshot(middlewarex.forwarded_request_key(chain)) {
			mut forwarded := middlewarex.request_with_forwarded_snapshot(ctx.payload_ref,
				ctx.route_params, forwarded_request)
			error_payload = forwarded.owned().to_value()
			forwarded.release()
		}
		error_ctx := ctx.with_payload_value(error_payload)
		res := app.error_response_from_context(error_ctx, 500, msg, 'handler_not_callable')
		return middlewarex.PipelineDispatchResult.from(httpx.vslim_response_to_value(res), error_payload)
	}
	loggerx.cli_debug_log('middleware.chain.raw type=${response.type_name()} class=${response.class_name()} valid=${response.is_valid()} null=${response.is_null()} undef=${response.is_undef()}')
	if forwarded_request := middlewarex.take_forwarded_request_snapshot(middlewarex.forwarded_request_key(chain)) {
		mut forwarded := middlewarex.request_with_forwarded_snapshot(ctx.payload_ref,
			ctx.route_params, forwarded_request)
		out := forwarded.owned().to_value()
		forwarded.release()
		return middlewarex.PipelineDispatchResult.from(response, out)
	}
	return middlewarex.PipelineDispatchResult.from(response, ctx.payload_ref)
}

fn (app &VSlimApp) dispatch_after_phase_middleware_psr(ctx middlewarex.PipelineRequestContext, hook vphp.PhpValue, current &httpx.VSlimPsr7Response) !vphp.PhpValue {
	next_handler := middlewarex.fixed_response_request_handler_object(current)
	if !hook.is_valid() || hook.is_null() || hook.is_undef() {
		return error('Middleware is not valid')
	}
	return app.dispatch_phase_middleware(ctx.payload_ref, ctx.route_params, hook, next_handler)
}

fn (app &VSlimApp) apply_after_middlewares(ctx middlewarex.PipelineRequestContext, initial httpx.VSlimResponse) httpx.VSlimResponse {
	loggerx.cli_debug_log('after.input vslim status=${initial.status} body_len=${initial.body.len}')
	initial_psr := initial.to_psr7_response()
	loggerx.cli_debug_log('after.input psr status=${initial_psr.get_status_code()} body_len=${httpx.psr7_stream_string(initial_psr.body_or_empty()).len}')
	psr := app.apply_after_middlewares_psr(ctx, initial_psr)
	loggerx.cli_debug_log('after.psr final status=${psr.get_status_code()} body_len=${httpx.psr7_stream_string(psr.body_or_empty()).len}')
	res := psr.to_vslim_response()
	loggerx.cli_debug_log('after.vslim final status=${res.status} body_len=${res.body.len}')
	return res
}

fn (app &VSlimApp) apply_after_middlewares_psr(ctx middlewarex.PipelineRequestContext, initial &httpx.VSlimPsr7Response) &httpx.VSlimPsr7Response {
	mut group_after := app.matching_group_after_middlewares(ctx.path)
	defer {
		release_collected_middlewares(mut group_after)
	}
	if app.after_middlewares.len == 0 && group_after.len == 0 {
		return initial
	}
	mut current := unsafe { initial }
	mut all := app.collect_after_middlewares(group_after)
	defer {
		release_collected_middlewares(mut all)
	}
	for hook in all {
		if !hook.is_valid() || hook.is_null() || hook.is_undef() {
			return app.error_response_from_context_psr(ctx, 500, 'Middleware is not valid',
				'handler_not_callable')
		}
		app.resolve_phase_middleware_target(hook) or {
			msg := if err.msg() == '' {
				'Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface'
			} else {
				err.msg()
			}
			return app.error_response_from_context_psr(ctx, 500, msg, 'handler_not_callable')
		}
		response := app.dispatch_after_phase_middleware_psr(ctx, hook, current) or {
			msg := if err.msg() == '' { 'Middleware is not callable' } else { err.msg() }
			return app.error_response_from_context_psr(ctx, 500, msg, 'handler_not_callable')
		}
		if response.is_object() && response.is_instance_of('Psr\\Http\\Message\\ResponseInterface') {
			psr := httpx.VSlimPsr7Response.from_value(response)
			loggerx.cli_debug_log('after.raw psr status=${psr.get_status_code()} body_len=${httpx.psr7_stream_string(psr.body_or_empty()).len}')
		}
		mut res, ok := httpx.VSlimPsr7Response.from_route_result(response)
		if ok {
			loggerx.cli_debug_log('after.normalized psr status=${res.get_status_code()} body_len=${httpx.psr7_stream_string(res.body_or_empty()).len}')
			current = res
			continue
		}
		current = app.error_response_from_context_psr(ctx, 500, 'Invalid route response',
			'invalid_response')
	}
	return current
}

fn (app &VSlimApp) finalize_with_after_middlewares(ctx middlewarex.PipelineRequestContext, initial httpx.VSlimResponse) httpx.VSlimResponse {
	return app.apply_after_middlewares(ctx, initial)
}

fn (app &VSlimApp) finalize_with_after_middlewares_psr(ctx middlewarex.PipelineRequestContext, initial &httpx.VSlimPsr7Response) &httpx.VSlimPsr7Response {
	return app.apply_after_middlewares_psr(ctx, initial)
}

module appx

import errorx
import httpx
import middlewarex
import vphp

fn (app &VSlimApp) normalize_or_handle_error_with_context(ctx middlewarex.PipelineRequestContext, result vphp.PhpValue, fallback_status int, fallback_message string) httpx.VSlimResponse {
	res, ok := httpx.VSlimResponse.from_route_result(result)
	if ok {
		return res
	}
	return app.error_response_from_context(ctx, fallback_status, fallback_message,
		'invalid_response')
}

fn (app &VSlimApp) normalize_or_handle_error_with_context_psr(ctx middlewarex.PipelineRequestContext, result vphp.PhpValue, fallback_status int, fallback_message string) &httpx.VSlimPsr7Response {
	res, ok := httpx.VSlimPsr7Response.from_route_result(result)
	if ok {
		return res
	}
	return app.error_response_from_context_psr(ctx, fallback_status, fallback_message,
		'invalid_response')
}

fn (app &VSlimApp) normalize_or_handle_error(request_payload vphp.PhpValue, result vphp.PhpValue, fallback_status int, fallback_message string) httpx.VSlimResponse {
	ctx := middlewarex.PipelineRequestContext.from_value('/', request_payload,
		httpx.route_params_from_payload(request_payload))
	return app.normalize_or_handle_error_with_context(ctx, result, fallback_status,
		fallback_message)
}

fn (app &VSlimApp) build_terminal_response(meta middlewarex.MiddlewareTerminalMeta, ctx middlewarex.PipelineRequestContext) httpx.VSlimResponse {
	return match meta.kind {
		.fixed_response {
			if meta.fixed_response_ref == unsafe { nil } {
				httpx.VSlimResponse.text(500, 'Invalid terminal response')
			} else {
				meta.fixed_response_ref.to_vslim_response()
			}
		}
		.not_found {
			app.run_not_found_core_with_context(ctx)
		}
		.method_not_allowed {
			app.build_method_not_allowed_response_with_context(ctx, meta.allowed_methods)
		}
		.error_response {
			app.run_error_handler_with_context(ctx, meta.status, meta.message) or {
				app.default_error_response(meta.status, meta.fallback_message, meta.error_code)
			}
		}
		.none {
			httpx.VSlimResponse.text(500, 'Invalid terminal response')
		}
	}
}

fn (app &VSlimApp) build_terminal_response_psr(meta middlewarex.MiddlewareTerminalMeta, ctx middlewarex.PipelineRequestContext) &httpx.VSlimPsr7Response {
	return match meta.kind {
		.fixed_response {
			if meta.fixed_response_ref == unsafe { nil } {
				httpx.VSlimPsr7Response.text(500, 'Invalid terminal response')
			} else {
				res := meta.fixed_response_ref
				res.clone_with(res.protocol_version, httpx.clone_header_values(res.headers),
					httpx.clone_header_names(res.header_names), res.body_or_empty(), res.status,
					res.reason_phrase)
			}
		}
		.not_found {
			app.run_not_found_core_with_context_psr(ctx)
		}
		.method_not_allowed {
			app.build_method_not_allowed_response_with_context_psr(ctx, meta.allowed_methods)
		}
		.error_response {
			app.run_error_handler_with_context_psr(ctx, meta.status, meta.message) or {
				app.default_error_response_psr(meta.status, meta.fallback_message, meta.error_code)
			}
		}
		.none {
			httpx.VSlimPsr7Response.text(500, 'Invalid terminal response')
		}
	}
}

fn (app &VSlimApp) build_method_not_allowed_response(payload vphp.PhpValue, allowed_methods []string) httpx.VSlimResponse {
	ctx := middlewarex.PipelineRequestContext.from_value('/', payload, httpx.route_params_from_payload(payload))
	return app.build_method_not_allowed_response_with_context(ctx, allowed_methods)
}

fn (app &VSlimApp) build_method_not_allowed_response_with_context(ctx middlewarex.PipelineRequestContext, allowed_methods []string) httpx.VSlimResponse {
	mut res := app.run_error_handler_with_context(ctx, 405, 'Method not allowed') or {
		httpx.VSlimResponse.method_not_allowed()
	}
	return res.with_allowed_methods(allowed_methods)
}

fn (app &VSlimApp) build_method_not_allowed_response_with_context_psr(ctx middlewarex.PipelineRequestContext, allowed_methods []string) &httpx.VSlimPsr7Response {
	mut res := app.run_error_handler_with_context_psr(ctx, 405, 'Method not allowed') or {
		httpx.VSlimPsr7Response.text(405, 'Method Not Allowed')
	}
	return res.with_allowed_methods(allowed_methods)
}

fn (app &VSlimApp) run_not_found(req &httpx.VSlimRequest) httpx.VSlimResponse {
	payload := httpx.vslim_request_build_value(req, map[string]string{})
	path := req.normalized_path()
	ctx := middlewarex.PipelineRequestContext.from_value(path, payload, map[string]string{})
	res := app.run_not_found_core_with_context(ctx)
	payload.release()
	return app.finalize_with_after_middlewares(ctx, res)
}

fn (app &VSlimApp) run_not_found_core_with_context(ctx middlewarex.PipelineRequestContext) httpx.VSlimResponse {
	nf := app.not_found_handler
	if nf.is_valid() {
		mut psr_payload := httpx.normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
		defer {
			psr_payload.release()
		}
		mut raw := nf.invoke(psr_payload)
		defer {
			raw.release()
		}
		return app.normalize_or_handle_error_with_context(ctx, raw, 404, 'Not Found')
	}
	return app.default_error_response(404, 'Not Found', 'not_found')
}

fn (app &VSlimApp) run_not_found_core_with_context_psr(ctx middlewarex.PipelineRequestContext) &httpx.VSlimPsr7Response {
	nf := app.not_found_handler
	if nf.is_valid() {
		mut psr_payload := httpx.normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
		defer {
			psr_payload.release()
		}
		mut raw := nf.invoke(psr_payload)
		defer {
			raw.release()
		}
		return app.normalize_or_handle_error_with_context_psr(ctx, raw, 404, 'Not Found')
	}
	return app.default_error_response_psr(404, 'Not Found', 'not_found')
}

fn (app &VSlimApp) run_not_found_core(payload vphp.PhpValue) httpx.VSlimResponse {
	ctx := middlewarex.PipelineRequestContext.from_value('/', payload, httpx.route_params_from_payload(payload))
	return app.run_not_found_core_with_context(ctx)
}

fn (app &VSlimApp) run_error_handler_with_context(ctx middlewarex.PipelineRequestContext, status int, message string) ?httpx.VSlimResponse {
	eh := app.error_handler
	if !eh.is_valid() {
		return none
	}
	mut psr_payload := httpx.normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
	mut message_arg := vphp.PhpString.of(message)
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		psr_payload.release()
		message_arg.release()
		status_arg.release()
	}
	mut raw := eh.invoke(psr_payload, message_arg, status_arg)
	defer {
		raw.release()
	}
	res, ok := httpx.VSlimResponse.from_route_result(raw)
	if !ok {
		return none
	}
	return res
}

fn (app &VSlimApp) run_error_handler_with_context_psr(ctx middlewarex.PipelineRequestContext, status int, message string) ?&httpx.VSlimPsr7Response {
	eh := app.error_handler
	if !eh.is_valid() {
		return none
	}
	mut psr_payload := httpx.normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
	mut message_arg := vphp.PhpString.of(message)
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		psr_payload.release()
		message_arg.release()
		status_arg.release()
	}
	mut raw := eh.invoke(psr_payload, message_arg, status_arg)
	defer {
		raw.release()
	}
	res, ok := httpx.VSlimPsr7Response.from_route_result(raw)
	if !ok {
		return none
	}
	return res
}

fn (app &VSlimApp) run_error_handler(request_payload vphp.PhpValue, status int, message string) ?httpx.VSlimResponse {
	ctx := middlewarex.PipelineRequestContext.from_value('/', request_payload,
		httpx.route_params_from_payload(request_payload))
	return app.run_error_handler_with_context(ctx, status, message)
}

fn (app &VSlimApp) default_error_response(status int, message string, error_code string) httpx.VSlimResponse {
	return errorx.default_response(status, message, error_code, app.error_response_json)
}

fn (app &VSlimApp) default_error_response_psr(status int, message string, error_code string) &httpx.VSlimPsr7Response {
	return errorx.default_psr_response(status, message, error_code, app.error_response_json)
}

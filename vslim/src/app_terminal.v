module main

import vphp

fn (app &VSlimApp) normalize_or_handle_error_with_context(ctx PipelineRequestContext, result vphp.PhpValue, fallback_status int, fallback_message string) VSlimResponse {
	res, ok := VSlimResponse.from_route_result(result)
	if ok {
		return res
	}
	return app.error_response_from_context(ctx, fallback_status, fallback_message,
		'invalid_response')
}

fn (app &VSlimApp) normalize_or_handle_error_with_context_psr(ctx PipelineRequestContext, result vphp.PhpValue, fallback_status int, fallback_message string) &VSlimPsr7Response {
	res, ok := VSlimResponse.psr7_from_route_result(result)
	if ok {
		return res
	}
	return app.error_response_from_context_psr(ctx, fallback_status, fallback_message,
		'invalid_response')
}

fn (app &VSlimApp) normalize_or_handle_error(request_payload vphp.PhpValue, result vphp.PhpValue, fallback_status int, fallback_message string) VSlimResponse {
	ctx := PipelineRequestContext.from_value(RoutePath.normalize('/'), request_payload,
		route_params_from_payload(request_payload))
	return app.normalize_or_handle_error_with_context(ctx,
		result, fallback_status, fallback_message)
}

fn (res VSlimResponse) fixed_terminal_meta() MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:               .fixed_response
		fixed_response_ref: res.to_psr7_response()
	}
}

fn (res &VSlimPsr7Response) fixed_terminal_meta() MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:               .fixed_response
		fixed_response_ref: res.clone_with(res.get_protocol_version(),
			clone_header_values(res.headers), clone_header_names(res.header_names),
			res.body_or_empty(), res.get_status_code(), res.get_reason_phrase())
	}
}

fn MiddlewareTerminalMeta.not_found() MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind: .not_found
	}
}

fn MiddlewareTerminalMeta.method_not_allowed(allowed_methods []string) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:            .method_not_allowed
		allowed_methods: allowed_methods.clone()
	}
}

fn MiddlewareTerminalMeta.error(status int, message string, fallback_message string, error_code string) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:             .error_response
		status:           status
		message:          message
		fallback_message: fallback_message
		error_code:       error_code
	}
}

fn (meta MiddlewareTerminalMeta) build_response(app &VSlimApp, ctx PipelineRequestContext) VSlimResponse {
	return match meta.kind {
		.fixed_response {
			if meta.fixed_response_ref == unsafe { nil } {
				VSlimResponse.text(500, 'Invalid terminal response')
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
			VSlimResponse.text(500, 'Invalid terminal response')
		}
	}
}

fn (meta MiddlewareTerminalMeta) build_response_psr(app &VSlimApp, ctx PipelineRequestContext) &VSlimPsr7Response {
	return match meta.kind {
		.fixed_response {
			if meta.fixed_response_ref == unsafe { nil } {
				VSlimPsr7Response.text(500, 'Invalid terminal response')
			} else {
				res := meta.fixed_response_ref
				res.clone_with(res.protocol_version, clone_header_values(res.headers),
					clone_header_names(res.header_names), res.body_or_empty(), res.status,
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
			VSlimPsr7Response.text(500, 'Invalid terminal response')
		}
	}
}

fn VSlimResponse.options(allowed_methods []string) VSlimResponse {
	mut allow := allowed_methods.clone()
	if 'OPTIONS' !in allow {
		allow << 'OPTIONS'
	}
	return VSlimResponse{
		status:       204
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type': 'text/plain; charset=utf-8'
			'allow':        allow.join(', ')
		}
	}
}

fn (app &VSlimApp) build_method_not_allowed_response(payload vphp.PhpValue, allowed_methods []string) VSlimResponse {
	ctx := PipelineRequestContext.from_value(RoutePath.normalize('/'), payload,
		route_params_from_payload(payload))
	return app.build_method_not_allowed_response_with_context(ctx, allowed_methods)
}

fn (app &VSlimApp) build_method_not_allowed_response_with_context(ctx PipelineRequestContext, allowed_methods []string) VSlimResponse {
	mut res := app.run_error_handler_with_context(ctx, 405, 'Method not allowed') or {
		VSlimResponse.method_not_allowed()
	}
	if allowed_methods.len > 0 && 'allow' !in res.headers {
		res.headers['allow'] = allowed_methods.join(', ')
	}
	return res
}

fn (app &VSlimApp) build_method_not_allowed_response_with_context_psr(ctx PipelineRequestContext, allowed_methods []string) &VSlimPsr7Response {
	mut res := app.run_error_handler_with_context_psr(ctx, 405, 'Method not allowed') or {
		VSlimPsr7Response.text(405, 'Method Not Allowed')
	}
	if allowed_methods.len == 0 {
		return res
	}
	mut headers := clone_header_values(res.headers)
	mut header_names := clone_header_names(res.header_names)
	if 'allow' !in headers {
		headers['allow'] = [allowed_methods.join(', ')]
		header_names['allow'] = 'Allow'
	}
	return res.clone_with(res.protocol_version, headers, header_names,
		res.body_or_empty(), res.status, res.reason_phrase)
}

fn (app &VSlimApp) run_not_found(req &VSlimRequest) VSlimResponse {
	payload := req.build_request_value(map[string]string{})
	path := RoutePath.normalize(req.path_value())
	ctx := PipelineRequestContext.from_value(path, payload, map[string]string{})
	res := app.run_not_found_core_with_context(ctx)
	payload.release()
	return app.finalize_with_after_middlewares(ctx, res)
}

fn (app &VSlimApp) run_not_found_core_with_context(ctx PipelineRequestContext) VSlimResponse {
	nf := app.not_found_handler
	if nf.is_valid() {
		mut psr_payload := normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
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

fn (app &VSlimApp) run_not_found_core_with_context_psr(ctx PipelineRequestContext) &VSlimPsr7Response {
	nf := app.not_found_handler
	if nf.is_valid() {
		mut psr_payload := normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
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

fn (app &VSlimApp) run_not_found_core(payload vphp.PhpValue) VSlimResponse {
	ctx := PipelineRequestContext.from_value(RoutePath.normalize('/'), payload,
		route_params_from_payload(payload))
	return app.run_not_found_core_with_context(ctx)
}

fn (app &VSlimApp) run_error_handler_with_context(ctx PipelineRequestContext, status int, message string) ?VSlimResponse {
	eh := app.error_handler
	if !eh.is_valid() {
		return none
	}
	mut psr_payload := normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
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
	res, ok := VSlimResponse.from_route_result(raw)
	if !ok {
		return none
	}
	return res
}

fn (app &VSlimApp) run_error_handler_with_context_psr(ctx PipelineRequestContext, status int, message string) ?&VSlimPsr7Response {
	eh := app.error_handler
	if !eh.is_valid() {
		return none
	}
	mut psr_payload := normalize_psr15_server_request(ctx.payload_ref, ctx.route_params)
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
	res, ok := VSlimResponse.psr7_from_route_result(raw)
	if !ok {
		return none
	}
	return res
}

fn (app &VSlimApp) run_error_handler(request_payload vphp.PhpValue, status int, message string) ?VSlimResponse {
	ctx := PipelineRequestContext.from_value(RoutePath.normalize('/'), request_payload,
		route_params_from_payload(request_payload))
	return app.run_error_handler_with_context(ctx, status, message)
}

fn (app &VSlimApp) default_error_response(status int, message string, error_code string) VSlimResponse {
	if app.error_response_json {
		esc_code := json_escape(error_code)
		return VSlimResponse.json(status,
			'{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}')
	}
	return VSlimResponse.text(status, message)
}

fn (app &VSlimApp) default_error_response_psr(status int, message string, error_code string) &VSlimPsr7Response {
	if app.error_response_json {
		esc_code := json_escape(error_code)
		return VSlimPsr7Response.json(status,
			'{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}')
	}
	return VSlimPsr7Response.text(status, message)
}

fn VSlimPsr7Response.internal_phase_continue() &VSlimPsr7Response {
	return &VSlimPsr7Response{
		status:           299
		reason_phrase:    normalize_reason_phrase(299, '')
		protocol_version: '1.1'
		headers:          {
			'content-type':     ['text/plain; charset=utf-8']
			'x-vslim-continue': ['1']
		}
		header_names:     {
			'content-type':     'content-type'
			'x-vslim-continue': 'x-vslim-continue'
		}
		body_ref:         VSlimPsr7Stream.from_content('')
	}
}

fn json_escape(input string) string {
	return input.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t',
		'\\t')
}

module main

import vphp

fn normalize_or_handle_error_with_context(app &VSlimApp, ctx PipelineRequestContext, result vphp.RequestBorrowedZBox, fallback_status int, fallback_message string) VSlimResponse {
	res, ok := normalize_php_route_response_borrowed(result)
	if ok {
		return res
	}
	return error_response_from_context(app, ctx, fallback_status, fallback_message, 'invalid_response')
}

fn normalize_or_handle_error_with_context_psr(app &VSlimApp, ctx PipelineRequestContext, result vphp.RequestBorrowedZBox, fallback_status int, fallback_message string) &VSlimPsr7Response {
	res, ok := normalize_php_route_response_psr_borrowed(result)
	if ok {
		return res
	}
	return error_response_from_context_psr(app, ctx, fallback_status, fallback_message,
		'invalid_response')
}

fn normalize_or_handle_error(app &VSlimApp, request_payload vphp.RequestBorrowedZBox, result vphp.RequestBorrowedZBox, fallback_status int, fallback_message string) VSlimResponse {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'), request_payload.clone_request_owned(),
		route_params_from_payload(request_payload))
	return normalize_or_handle_error_with_context(app, ctx, result, fallback_status, fallback_message)
}

fn fixed_terminal_meta(res VSlimResponse) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:               .fixed_response
		fixed_response_ref: new_psr7_response_from_vslim_response(res)
	}
}

fn fixed_terminal_meta_psr(res &VSlimPsr7Response) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:               .fixed_response
		fixed_response_ref: clone_psr7_response(res, res.get_protocol_version(), clone_header_values(res.headers),
			clone_header_names(res.header_names), response_body_or_empty(res), res.get_status_code(),
			res.get_reason_phrase())
	}
}

fn not_found_terminal_meta() MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind: .not_found
	}
}

fn method_not_allowed_terminal_meta(allowed_methods []string) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:            .method_not_allowed
		allowed_methods: allowed_methods.clone()
	}
}

fn error_terminal_meta(status int, message string, fallback_message string, error_code string) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:             .error_response
		status:           status
		message:          message
		fallback_message: fallback_message
		error_code:       error_code
	}
}

fn build_terminal_response(app &VSlimApp, ctx PipelineRequestContext, meta MiddlewareTerminalMeta) VSlimResponse {
	return match meta.kind {
		.fixed_response {
			if meta.fixed_response_ref == unsafe { nil } {
				text_response(500, 'Invalid terminal response')
			} else {
				new_vslim_response_from_psr_response(meta.fixed_response_ref)
			}
		}
		.not_found {
			run_not_found_core_with_context(app, ctx)
		}
		.method_not_allowed {
			build_method_not_allowed_response_with_context(app, ctx, meta.allowed_methods)
		}
		.error_response {
			run_error_handler_with_context(app, ctx, meta.status, meta.message) or {
				default_error_response(app, meta.status, meta.fallback_message, meta.error_code)
			}
		}
		.none {
			text_response(500, 'Invalid terminal response')
		}
	}
}

fn build_terminal_response_psr(app &VSlimApp, ctx PipelineRequestContext, meta MiddlewareTerminalMeta) &VSlimPsr7Response {
	return match meta.kind {
		.fixed_response {
			if meta.fixed_response_ref == unsafe { nil } {
				new_psr7_text_response(500, 'Invalid terminal response')
			} else {
				res := meta.fixed_response_ref
				clone_psr7_response(res, res.protocol_version, clone_header_values(res.headers),
					clone_header_names(res.header_names), response_body_or_empty(res),
					res.status, res.reason_phrase)
			}
		}
		.not_found {
			run_not_found_core_with_context_psr(app, ctx)
		}
		.method_not_allowed {
			build_method_not_allowed_response_with_context_psr(app, ctx, meta.allowed_methods)
		}
		.error_response {
			run_error_handler_with_context_psr(app, ctx, meta.status, meta.message) or {
				default_error_response_psr(app, meta.status, meta.fallback_message, meta.error_code)
			}
		}
		.none {
			new_psr7_text_response(500, 'Invalid terminal response')
		}
	}
}

fn build_options_response(allowed_methods []string) VSlimResponse {
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

fn build_method_not_allowed_response(app &VSlimApp, payload vphp.RequestBorrowedZBox, allowed_methods []string) VSlimResponse {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'), payload.clone_request_owned(),
		route_params_from_payload(payload))
	return build_method_not_allowed_response_with_context(app, ctx, allowed_methods)
}

fn build_method_not_allowed_response_with_context(app &VSlimApp, ctx PipelineRequestContext, allowed_methods []string) VSlimResponse {
	mut res := run_error_handler_with_context(app, ctx, 405, 'Method not allowed') or {
		method_not_allowed_response()
	}
	if allowed_methods.len > 0 && 'allow' !in res.headers {
		res.headers['allow'] = allowed_methods.join(', ')
	}
	return res
}

fn build_method_not_allowed_response_with_context_psr(app &VSlimApp, ctx PipelineRequestContext, allowed_methods []string) &VSlimPsr7Response {
	mut res := run_error_handler_with_context_psr(app, ctx, 405, 'Method not allowed') or {
		new_psr7_text_response(405, 'Method Not Allowed')
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
	return clone_psr7_response(res, res.protocol_version, headers, header_names, response_body_or_empty(res),
		res.status, res.reason_phrase)
}

fn run_not_found(app &VSlimApp, req &VSlimRequest) VSlimResponse {
	payload := build_php_request_object(req, map[string]string{})
	path := RoutePath.normalize(req.path_value())
	ctx := new_pipeline_request_context(path, vphp.RequestOwnedZBox.from_zval(payload),
		map[string]string{})
	res := run_not_found_core_with_context(app, ctx)
	return finalize_php_response(app, ctx, res)
}

fn run_not_found_core_with_context(app &VSlimApp, ctx PipelineRequestContext) VSlimResponse {
	nf := app.not_found_handler
	if nf.is_valid() && nf.is_callable() {
		psr_payload := normalize_psr15_server_request_payload(ctx.payload_ref.borrowed(),
			ctx.route_params)
		mut raw := nf.fn_request_owned(vphp.PhpValue.from_zval(psr_payload))
		return normalize_or_handle_error_with_context(app, ctx, raw.borrowed(), 404, 'Not Found')
	}
	return default_error_response(app, 404, 'Not Found', 'not_found')
}

fn run_not_found_core_with_context_psr(app &VSlimApp, ctx PipelineRequestContext) &VSlimPsr7Response {
	nf := app.not_found_handler
	if nf.is_valid() && nf.is_callable() {
		psr_payload := normalize_psr15_server_request_payload(ctx.payload_ref.borrowed(),
			ctx.route_params)
		mut raw := nf.fn_request_owned(vphp.PhpValue.from_zval(psr_payload))
		return normalize_or_handle_error_with_context_psr(app, ctx, raw.borrowed(), 404,
			'Not Found')
	}
	return default_error_response_psr(app, 404, 'Not Found', 'not_found')
}

fn run_not_found_core(app &VSlimApp, payload vphp.RequestBorrowedZBox) VSlimResponse {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'), payload.clone_request_owned(),
		route_params_from_payload(payload))
	return run_not_found_core_with_context(app, ctx)
}

fn run_error_handler_with_context(app &VSlimApp, ctx PipelineRequestContext, status int, message string) ?VSlimResponse {
	eh := app.error_handler
	if !eh.is_valid() || !eh.is_callable() {
		return none
	}
	psr_payload := normalize_psr15_server_request_payload(ctx.payload_ref.borrowed(),
		ctx.route_params)
	mut raw := eh.fn_request_owned(vphp.PhpValue.from_zval(psr_payload), vphp.PhpString.of(message),
		vphp.PhpInt.of(status))
	res, ok := normalize_php_route_response_borrowed(raw.borrowed())
	if !ok {
		return none
	}
	return res
}

fn run_error_handler_with_context_psr(app &VSlimApp, ctx PipelineRequestContext, status int, message string) ?&VSlimPsr7Response {
	eh := app.error_handler
	if !eh.is_valid() || !eh.is_callable() {
		return none
	}
	psr_payload := normalize_psr15_server_request_payload(ctx.payload_ref.borrowed(),
		ctx.route_params)
	mut raw := eh.fn_request_owned(vphp.PhpValue.from_zval(psr_payload), vphp.PhpString.of(message),
		vphp.PhpInt.of(status))
	res, ok := normalize_php_route_response_psr_borrowed(raw.borrowed())
	if !ok {
		return none
	}
	return res
}

fn run_error_handler(app &VSlimApp, request_payload vphp.RequestBorrowedZBox, status int, message string) ?VSlimResponse {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'), request_payload.clone_request_owned(),
		route_params_from_payload(request_payload))
	return run_error_handler_with_context(app, ctx, status, message)
}

fn default_error_response(app &VSlimApp, status int, message string, error_code string) VSlimResponse {
	if app.error_response_json {
		esc_code := json_escape(error_code)
		return json_response(status, '{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}')
	}
	return text_response(status, message)
}

fn default_error_response_psr(app &VSlimApp, status int, message string, error_code string) &VSlimPsr7Response {
	if app.error_response_json {
		esc_code := json_escape(error_code)
		return new_psr7_json_response(status, '{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}')
	}
	return new_psr7_text_response(status, message)
}

fn internal_phase_continue_response_psr() &VSlimPsr7Response {
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
		body_ref:         new_psr7_stream('')
	}
}

fn json_escape(input string) string {
	return input.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r',
		'\\r').replace('\t', '\\t')
}

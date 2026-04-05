module main

import vphp

fn normalize_or_handle_error_with_context(app &VSlimApp, ctx PipelineRequestContext, result vphp.BorrowedZVal, fallback_status int, fallback_message string) VSlimResponse {
	res, ok := normalize_php_route_response_borrowed(result)
	if ok {
		return res
	}
	return error_response_from_context(app, ctx, fallback_status, fallback_message, 'invalid_response')
}

fn normalize_or_handle_error(app &VSlimApp, request_payload vphp.BorrowedZVal, result vphp.BorrowedZVal, fallback_status int, fallback_message string) VSlimResponse {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'),
		request_payload.clone_request_owned(), route_params_from_payload(request_payload))
	return normalize_or_handle_error_with_context(app, ctx, result, fallback_status,
		fallback_message)
}

fn fixed_terminal_meta(res VSlimResponse) MiddlewareTerminalMeta {
	return MiddlewareTerminalMeta{
		kind:           .fixed_response
		fixed_response: res
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
			meta.fixed_response
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

fn build_method_not_allowed_response(app &VSlimApp, payload vphp.BorrowedZVal, allowed_methods []string) VSlimResponse {
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

fn run_not_found(app &VSlimApp, req &VSlimRequest) VSlimResponse {
	payload := build_php_request_object(req, map[string]string{})
	path := RoutePath.normalize(req.path)
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
		mut raw := nf.call_request_owned([psr_payload])
		return normalize_or_handle_error_with_context(app, ctx, raw.borrowed(),
			404, 'Not Found')
	}
	return default_error_response(app, 404, 'Not Found', 'not_found')
}

fn run_not_found_core(app &VSlimApp, payload vphp.BorrowedZVal) VSlimResponse {
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
	mut raw := eh.call_request_owned([
		psr_payload,
		vphp.RequestOwnedZBox.new_string(message).to_zval(),
		vphp.RequestOwnedZBox.new_int(status).to_zval(),
	])
	res, ok := normalize_php_route_response_borrowed(raw.borrowed())
	if !ok {
		return none
	}
	return res
}

fn run_error_handler(app &VSlimApp, request_payload vphp.BorrowedZVal, status int, message string) ?VSlimResponse {
	ctx := new_pipeline_request_context(RoutePath.normalize('/'),
		request_payload.clone_request_owned(), route_params_from_payload(request_payload))
	return run_error_handler_with_context(app, ctx, status, message)
}

fn default_error_response(app &VSlimApp, status int, message string, error_code string) VSlimResponse {
	if app.error_response_json {
		esc_code := json_escape(error_code)
		return json_response(status, '{"ok":false,"code":"${esc_code}","error":"${esc_code}","status":${status},"message":"${json_escape(message)}"}')
	}
	return text_response(status, message)
}

fn json_escape(input string) string {
	return input.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r',
		'\\r').replace('\t', '\\t')
}

module appx

import os
import httpx
import routex
import streamx
import vphp

fn (app &VSlimApp) dispatch_request_with_params(req &httpx.VSlimRequest, trace_on bool, trace_base i64) (httpx.VSlimResponse, map[string]string, &httpx.VSlimRequest) {
	if app.routes.len > 0 {
		if trace_on {
			app.trace_mem_log(req, 'dispatch.routes.begin', trace_base)
		}
		res, params, effective_req, ok := app.dispatch_routes_with_params(req, trace_on, trace_base)
		if trace_on {
			app.trace_mem_log(req, 'dispatch.routes.end', trace_base)
		}
		if ok {
			return res.snapshot(), httpx.snapshot_string_map(params), effective_req.boxed_snapshot()
		}
	}
	path := req.normalized_path()
	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		res, snapshot := app.finalize_response_with_snapshot(ctx, result.response_ref)
		return res.snapshot(), map[string]string{}, snapshot.boxed_snapshot()
	}
	if app.use_demo {
		if trace_on {
			app.trace_mem_log(req, 'dispatch.demo_fallback', trace_base)
		}
		res, params := routex.dispatch_demo_with_params(req.to_vslim_request())
		return res.snapshot(), httpx.snapshot_string_map(params), req.boxed_snapshot()
	}
	if trace_on {
		app.trace_mem_log(req, 'dispatch.not_found_fallback', trace_base)
	}
	return app.run_not_found(req).snapshot(), map[string]string{}, req.boxed_snapshot()
}

fn (app &VSlimApp) dispatch_request_worker_value(req &httpx.VSlimRequest) vphp.PhpValue {
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	if app.routes.len > 0 {
		mut raw, _, effective_req, ok := app.dispatch_routes_worker_with_params(req)
		if ok {
			streamx.propagate_request_trace_headers_to_value(effective_req, raw)
			if req.effective_method() == 'HEAD' && raw.is_object()
				&& raw.is_instance_of('VSlim\\VHttpd\\Response') {
				if object := raw.as_object() {
					if mut resp := object.to_v_object[httpx.VSlimResponse]() {
						resp.body = ''
					}
				}
			}
			return raw
		}
	}
	path := req.normalized_path()
	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		raw_out, final_request := app.finalize_response_for_worker(ctx, result.response_ref)
		if streamx.is_worker_stream_response(raw_out) {
			return raw_out
		}
		if object := raw_out.as_object() {
			if mut final_res := object.to_v_object[httpx.VSlimResponse]() {
				final_res.propagate_request_trace_headers(final_request)
				if req.effective_method() == 'HEAD' {
					final_res.body = ''
				}
			}
		}
		if req.effective_method() == 'HEAD' {
			return raw_out
		}
		return raw_out
	}
	if app.use_demo {
		mut res, _ := routex.dispatch_demo_with_params(req.to_vslim_request())
		res.propagate_request_trace_headers(req)
		if req.effective_method() == 'HEAD' {
			res.body = ''
		}
		return httpx.vslim_response_to_value(res)
	}
	mut res := app.run_not_found(req)
	res.propagate_request_trace_headers(req)
	if req.effective_method() == 'HEAD' {
		res.body = ''
	}
	return httpx.vslim_response_to_value(res)
}

fn (app &VSlimApp) dispatch_psr15_request_value(request_value vphp.PhpValue) &httpx.VSlimPsr7Response {
	request_object := request_value.as_object() or {
		return app.dispatch_psr15_request_object(vphp.PhpObject.invalid())
	}
	return app.dispatch_psr15_request_object(request_object)
}

fn (app &VSlimApp) dispatch_psr15_request_object(request_object vphp.PhpObject) &httpx.VSlimPsr7Response {
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	mut normalized_request := httpx.normalize_psr15_server_request_object(request_object,
		map[string]string{})
	defer {
		normalized_request.release()
	}
	req := httpx.vslim_request_from_psr_server_request_object(normalized_request,
		map[string]string{})
	if app.routes.len > 0 {
		res, ok := app.dispatch_routes_psr15(req, normalized_request)
		if ok {
			return res
		}
	}
	path := req.normalized_path()
	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		return app.finalize_response_for_psr(ctx, result.response_ref)
	}
	if app.use_demo {
		res, _ := routex.dispatch_demo_with_params(req.to_vslim_request())
		return res.to_psr7_response()
	}
	ctx := PipelineRequestContext.from_object(path, normalized_request, map[string]string{})
	return app.run_not_found_core_with_context_psr(ctx)
}

fn (result PipelineDispatchResult) route_dispatch_resolution(route_params map[string]string) routex.RouteDispatchResolution {
	return routex.RouteDispatchResolution{
		response_ref: result.response_ref.owned()
		payload_ref:  result.payload_ref.owned()
		route_params: httpx.snapshot_string_map(route_params)
		handled:      true
	}
}

fn (app &VSlimApp) resolve_route_dispatch(req &httpx.VSlimRequest, source_payload vphp.PhpValue, trace_on bool, trace_base i64) routex.RouteDispatchResolution {
	method := req.effective_method()
	path := req.normalized_path()
	dispatch_req := req.with_method_snapshot(method)
	resolved_route := routex.resolve_dispatch_match(app.routes, method, path)
	match resolved_route.kind {
		.matched {
			if trace_on {
				app.trace_mem_log(req, 'route.matched', trace_base)
			}
			payload, validation_req := httpx.route_dispatch_payload(&dispatch_req, source_payload,
				resolved_route.route_params)
			if trace_on {
				app.trace_mem_log(req, 'route.after_build_payload', trace_base)
			}
			result := app.dispatch_route_match(path, payload, &validation_req,
				resolved_route.route, resolved_route.route_params)
			if trace_on {
				app.trace_mem_log(req, 'route.after_middleware_chain', trace_base)
			}
			return result.route_dispatch_resolution(resolved_route.route_params)
		}
		.options {
			result := app.dispatch_terminal(&dispatch_req,
				MiddlewareTerminalMeta.fixed_response(httpx.VSlimResponse.options(resolved_route.allowed_methods)))
			return result.route_dispatch_resolution(map[string]string{})
		}
		.method_not_allowed {
			result := app.dispatch_terminal(&dispatch_req,
				MiddlewareTerminalMeta.method_not_allowed(resolved_route.allowed_methods))
			return result.route_dispatch_resolution(map[string]string{})
		}
		.unresolved {}
	}

	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(&dispatch_req)
		return result.route_dispatch_resolution(map[string]string{})
	}
	return routex.RouteDispatchResolution.unresolved()
}

fn (app &VSlimApp) resolve_route_dispatch_object(req &httpx.VSlimRequest, source_payload vphp.PhpObject, trace_on bool, trace_base i64) routex.RouteDispatchResolution {
	return app.resolve_route_dispatch(req, source_payload.to_value(), trace_on, trace_base)
}

fn (app &VSlimApp) dispatch_route_match(path string, initial_payload vphp.PhpValue, validation_req &httpx.VSlimRequest, route routex.VSlimRoute, params map[string]string) PipelineDispatchResult {
	validation_meta, has_validation_meta := app.request_validation_terminal_meta(validation_req)
	if has_validation_meta {
		return app.dispatch_pipeline(path, initial_payload, RawDispatchPlan{
			route_params:  httpx.snapshot_string_map(params)
			terminal_meta: validation_meta
		})
	}
	return app.dispatch_pipeline(path, initial_payload, RawDispatchPlan{
		route_params:             httpx.snapshot_string_map(params)
		route_handler:            route.handler_ref.clone()
		resource_action:          route.resource_action
		resource_missing_handler: route.resource_missing_handler.clone()
	})
}

fn (app &VSlimApp) dispatch_routes_psr15(req &httpx.VSlimRequest, request_payload vphp.PhpObject) (&httpx.VSlimPsr7Response, bool) {
	path := req.normalized_path()
	resolved := app.resolve_route_dispatch_object(req, request_payload, false, 0)
	if resolved.handled {
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: httpx.snapshot_string_map(resolved.route_params)
		}
		return app.finalize_response_for_psr(ctx, resolved.response_ref), true
	}
	empty := httpx.VSlimResponse.empty()
	return empty.to_psr7_response(), false
}

fn (app &VSlimApp) dispatch_routes_with_params(req &httpx.VSlimRequest, trace_on bool, trace_base i64) (httpx.VSlimResponse, map[string]string, &httpx.VSlimRequest, bool) {
	path := req.normalized_path()
	resolved := app.resolve_route_dispatch(req, vphp.PhpValue.null(), trace_on, trace_base)
	if resolved.handled {
		if trace_on {
			app.trace_mem_log(req, 'route.after_normalize', trace_base)
		}
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: httpx.snapshot_string_map(resolved.route_params)
		}
		res, snapshot := app.finalize_response_with_snapshot(ctx, resolved.response_ref)
		return res, httpx.snapshot_string_map(resolved.route_params), snapshot, true
	}
	return httpx.VSlimResponse.empty(), map[string]string{}, req.boxed_snapshot(), false
}

fn (app &VSlimApp) dispatch_routes_worker_with_params(req &httpx.VSlimRequest) (vphp.PhpValue, map[string]string, &httpx.VSlimRequest, bool) {
	path := req.normalized_path()
	resolved := app.resolve_route_dispatch(req, vphp.PhpValue.null(), false, 0)
	if resolved.handled {
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: httpx.snapshot_string_map(resolved.route_params)
		}
		if streamx.is_worker_stream_response(resolved.response_ref) {
			return resolved.response_ref.owned(), httpx.snapshot_string_map(resolved.route_params), httpx.vslim_request_from_psr_server_request(ctx.payload_ref,
				ctx.route_params), true
		}
		raw_out, snapshot := app.finalize_response_for_worker(ctx, resolved.response_ref)
		return raw_out, httpx.snapshot_string_map(resolved.route_params), snapshot, true
	}
	return vphp.PhpValue.null(), map[string]string{}, req.boxed_snapshot(), false
}

fn (app &VSlimApp) max_body_bytes() int {
	if app.config_ref != unsafe { nil } && app.config_ref.has('http.max_body_bytes') {
		max_bytes := app.config_ref.get_int('http.max_body_bytes', 0)
		if max_bytes > 0 {
			return max_bytes
		}
		return 0
	}
	raw := os.getenv('VSLIM_MAX_BODY_BYTES').trim_space()
	if raw == '' {
		return 0
	}
	max_bytes := raw.int()
	if max_bytes <= 0 {
		return 0
	}
	return max_bytes
}

fn (app &VSlimApp) request_validation_terminal_meta(req &httpx.VSlimRequest) (MiddlewareTerminalMeta, bool) {
	max_bytes := app.max_body_bytes()
	if max_bytes > 0 && req.body.len > max_bytes {
		return MiddlewareTerminalMeta.error(413, 'Payload too large', 'Payload Too Large',
			'payload_too_large'), true
	}
	parse_msg := req.parse_error()
	if parse_msg != '' {
		return MiddlewareTerminalMeta.error(400, 'Bad Request: invalid JSON body',
			'Bad Request: invalid JSON body', 'bad_json_body'), true
	}
	return MiddlewareTerminalMeta{}, false
}

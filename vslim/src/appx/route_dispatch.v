module appx

import os
import httpx
import middlewarex
import routex
import streamx
import vphp

const worker_response_import = httpx.Psr7ResponseImportOptions{ defer_body: true }

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
		ctx := middlewarex.PipelineRequestContext{
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
		raw, _, effective_req, ok := app.dispatch_routes_worker_with_params(req)
		if ok {
			streamx.propagate_request_trace_headers_to_value(effective_req, raw)
			return raw
		}
	}
	path := req.normalized_path()
	if app.has_not_found_pipeline(path) || !app.use_demo {
		result := app.dispatch_not_found_terminal(req, worker_response_import)
		ctx := middlewarex.PipelineRequestContext{
			path:            path
			payload_ref:     result.payload_ref.owned()
			route_params:    map[string]string{}
			response_import: worker_response_import
		}
		raw_out, final_request := app.finalize_response_for_worker(ctx, result.response_ref,
			req.effective_method() == 'HEAD')
		streamx.propagate_request_trace_headers_to_value(final_request, raw_out)
		return raw_out
	}
	mut res, _ := routex.dispatch_demo_with_params(req.to_vslim_request())
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
	mut req := httpx.VSlimRequest.from_psr_server_request_object(normalized_request,
		map[string]string{},
		include_body: false
	)
	if req.method.to_upper() == 'POST' && req.header('x-http-method-override').trim_space() == ''
		&& req.query('_method').trim_space() == '' {
		if mut normalized := normalized_request.to_v_object[httpx.VSlimPsr7ServerRequest]() {
			if req.is_form_body() || (req.content_type().trim_space() == ''
				&& normalized.dispatch_body_is_seekable()) {
				req.body = normalized.inspect_dispatch_body()
			}
		}
	}
	if vphp.PhpException.has_current() {
		return httpx.VSlimPsr7Response.text(500, '')
	}
	if app.routes.len > 0 {
		res, ok := app.dispatch_routes_psr15(req, normalized_request)
		if ok || vphp.PhpException.has_current() {
			return res
		}
	}
	path := req.normalized_path()
	if app.has_not_found_pipeline(path) {
		result := app.dispatch_terminal_payload(path, normalized_request.to_value(),
			middlewarex.MiddlewareTerminalMeta.not_found())
		ctx := middlewarex.PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		return app.finalize_response_for_psr(ctx, result.response_ref)
	}
	if app.use_demo {
		if mut normalized := normalized_request.to_v_object[httpx.VSlimPsr7ServerRequest]() {
			req.body = normalized.inspect_dispatch_body()
		}
		res, _ := routex.dispatch_demo_with_params(req.to_vslim_request())
		return res.to_psr7_response()
	}
	ctx := middlewarex.PipelineRequestContext.from_object(path, normalized_request, map[string]string{})
	return app.run_not_found_core_with_context_psr(ctx)
}

fn route_dispatch_resolution(result middlewarex.PipelineDispatchResult, route_params map[string]string) routex.RouteDispatchResolution {
	return routex.RouteDispatchResolution{
		response_ref: result.response_ref
		payload_ref:  result.payload_ref.owned()
		route_params: httpx.snapshot_string_map(route_params)
		handled:      true
	}
}

fn (app &VSlimApp) resolve_route_dispatch(req &httpx.VSlimRequest, source_payload vphp.PhpValue, trace_on bool, trace_base i64, options httpx.Psr7ResponseImportOptions) routex.RouteDispatchResolution {
	method := req.effective_method()
	path := req.normalized_path()
	dispatch_req := req.with_method_snapshot(method)
	resolved_route := app.route_index.resolve(app.routes, method, path)
	match resolved_route.kind {
		.matched {
			if trace_on {
				app.trace_mem_log(req, 'route.matched', trace_base)
			}
			payload, mut validation_req := httpx.route_dispatch_payload(&dispatch_req, source_payload,
				resolved_route.route_params)
			if validation_req.body == '' && (app.max_body_bytes() > 0 || validation_req.is_json_body())
				&& httpx.is_psr_server_request_payload(payload) {
				if object := payload.as_object() {
					if mut normalized := object.to_v_object[httpx.VSlimPsr7ServerRequest]() {
						validation_req.body = normalized.inspect_dispatch_body()
					}
				}
			}
			if vphp.PhpException.has_current() {
				return routex.RouteDispatchResolution.unresolved()
			}
			if trace_on {
				app.trace_mem_log(req, 'route.after_build_payload', trace_base)
			}
			result := app.dispatch_route_match(path, payload, &validation_req,
				resolved_route, resolved_route.route_params, options)
			if trace_on {
				app.trace_mem_log(req, 'route.after_middleware_chain', trace_base)
			}
			return route_dispatch_resolution(result, resolved_route.route_params)
		}
		.options {
			result := app.dispatch_resolved_terminal(&dispatch_req, source_payload,
				middlewarex.MiddlewareTerminalMeta.fixed_response(httpx.VSlimResponse.options(resolved_route.allowed_methods)),
				options)
			return route_dispatch_resolution(result, map[string]string{})
		}
		.method_not_allowed {
			result := app.dispatch_resolved_terminal(&dispatch_req, source_payload,
				middlewarex.MiddlewareTerminalMeta.method_not_allowed(resolved_route.allowed_methods),
				options)
			return route_dispatch_resolution(result, map[string]string{})
		}
		.unresolved {}
	}

	if app.has_not_found_pipeline(path) {
		result := app.dispatch_resolved_terminal(&dispatch_req, source_payload,
			middlewarex.MiddlewareTerminalMeta.not_found(), options)
		return route_dispatch_resolution(result, map[string]string{})
	}
	return routex.RouteDispatchResolution.unresolved()
}

fn (app &VSlimApp) resolve_route_dispatch_object(req &httpx.VSlimRequest, source_payload vphp.PhpObject, trace_on bool, trace_base i64) routex.RouteDispatchResolution {
	return app.resolve_route_dispatch(req, source_payload.to_value(), trace_on, trace_base)
}

fn (app &VSlimApp) dispatch_route_match(path string, initial_payload vphp.PhpValue, validation_req &httpx.VSlimRequest, matched routex.RouteDispatchMatch, params map[string]string, options httpx.Psr7ResponseImportOptions) middlewarex.PipelineDispatchResult {
	validation_meta, has_validation_meta := app.request_validation_terminal_meta(validation_req)
	if has_validation_meta {
		return app.dispatch_pipeline(path, initial_payload, middlewarex.RawDispatchPlan{
			route_params:  httpx.snapshot_string_map(params)
			terminal_meta: validation_meta
		}, options)
	}
	route := matched.route
	mut plan := middlewarex.RawDispatchPlan{
		route_params:             httpx.snapshot_string_map(params)
		route_handler:            app.registration_value(.routes, matched.index, route.handler_ref).owned()
		resource_action:          route.resource_action
		resource_missing_handler: app.resource_missing_callback(matched.index,
			route.resource_missing_handler)
	}
	defer {
		plan.release()
	}
	return app.dispatch_pipeline(path, initial_payload, plan, options)
}

fn (app &VSlimApp) resource_missing_callback(index int, fallback vphp.PhpCallable) vphp.PhpCallable {
	if state := vphp.owned_object_php_state(app) {
		if value := state.find(RegistrationValues.resource_missing.state_key(index)) {
			if callback := value.require_callable() {
				return callback.to_request_owned()
			}
		}
	}
	return fallback.to_request_owned()
}

fn (app &VSlimApp) dispatch_routes_psr15(req &httpx.VSlimRequest, request_payload vphp.PhpObject) (&httpx.VSlimPsr7Response, bool) {
	path := req.normalized_path()
	resolved := app.resolve_route_dispatch_object(req, request_payload, false, 0)
	if resolved.handled {
		ctx := middlewarex.PipelineRequestContext{
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
		ctx := middlewarex.PipelineRequestContext{
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
	resolved := app.resolve_route_dispatch(req, vphp.PhpValue.null(), false, 0, worker_response_import)
	if resolved.handled {
		ctx := middlewarex.PipelineRequestContext{
			path:            path
			payload_ref:     resolved.payload_ref.owned()
			route_params:    httpx.snapshot_string_map(resolved.route_params)
			response_import: worker_response_import
		}
		raw_out, snapshot := app.finalize_response_for_worker(ctx, resolved.response_ref,
			req.effective_method() == 'HEAD')
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

fn (app &VSlimApp) request_validation_terminal_meta(req &httpx.VSlimRequest) (middlewarex.MiddlewareTerminalMeta, bool) {
	max_bytes := app.max_body_bytes()
	if max_bytes > 0 && req.body.len > max_bytes {
		return middlewarex.MiddlewareTerminalMeta.error(413, 'Payload too large', 'Payload Too Large',
			'payload_too_large'), true
	}
	parse_msg := req.parse_error()
	if parse_msg != '' {
		return middlewarex.MiddlewareTerminalMeta.error(400, 'Bad Request: invalid JSON body',
			'Bad Request: invalid JSON body', 'bad_json_body'), true
	}
	return middlewarex.MiddlewareTerminalMeta{}, false
}

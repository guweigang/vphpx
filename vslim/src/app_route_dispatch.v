module main

import os
import vphp

struct RouteDispatchResolution {
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	route_params map[string]string
	handled      bool
}

fn (app &VSlimApp) dispatch_request_with_params(req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, &VSlimRequest) {
	if app.routes.len > 0 {
		if trace_on {
			app.trace_mem_log(req, 'dispatch.routes.begin', trace_base)
		}
		res, params, effective_req, ok := app.dispatch_routes_with_params(req, trace_on,
			trace_base)
		if trace_on {
			app.trace_mem_log(req, 'dispatch.routes.end', trace_base)
		}
		if ok {
			return (res).snapshot(), snapshot_string_map(params), effective_req.boxed_snapshot()
		}
	}
	path := RoutePath.normalize(req.path_value())
	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		res, snapshot := app.finalize_response_with_snapshot(ctx, result.response_ref)
		return (res).snapshot(), map[string]string{}, snapshot.boxed_snapshot()
	}
	if app.use_demo {
		if trace_on {
			app.trace_mem_log(req, 'dispatch.demo_fallback', trace_base)
		}
		res, params := req.to_vslim_request().dispatch_demo_with_params()
		return (res).snapshot(), snapshot_string_map(params), req.boxed_snapshot()
	}
	if trace_on {
		app.trace_mem_log(req, 'dispatch.not_found_fallback', trace_base)
	}
	return (app.run_not_found(req).snapshot()), map[string]string{}, req.boxed_snapshot()
}

fn (app &VSlimApp) dispatch_request_worker_value(req &VSlimRequest) vphp.PhpValue {
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	if app.routes.len > 0 {
		mut raw, _, effective_req, ok := app.dispatch_routes_worker_with_params(req)
		if ok {
			propagate_request_trace_headers_to_value(effective_req, raw)
			if req.effective_method() == 'HEAD' && raw.is_object()
				&& raw.is_instance_of('VSlim\\VHttpd\\Response') {
				if object := raw.as_object() {
					if mut resp := object.to_v_object[VSlimResponse]() {
						resp.body = ''
					}
				}
			}
			return raw
		}
	}
	path := RoutePath.normalize(req.path_value())
	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		raw_out, final_request := app.finalize_response_for_worker(ctx, result.response_ref)
		if value_subject(raw_out).is_worker_stream_response() {
			return raw_out
		}
		if object := raw_out.as_object() {
			if mut final_res := object.to_v_object[VSlimResponse]() {
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
		mut res, _ := req.to_vslim_request().dispatch_demo_with_params()
		res.propagate_request_trace_headers(req)
		if req.effective_method() == 'HEAD' {
			res.body = ''
		}
		return res.to_value()
	}
	mut res := app.run_not_found(req)
	res.propagate_request_trace_headers(req)
	if req.effective_method() == 'HEAD' {
		res.body = ''
	}
	return res.to_value()
}

fn (app &VSlimApp) dispatch_psr15_request_value(request_value vphp.PhpValue) &VSlimPsr7Response {
	request_object := request_value.as_object() or {
		return app.dispatch_psr15_request_object(vphp.PhpObject.invalid())
	}
	return app.dispatch_psr15_request_object(request_object)
}

fn (app &VSlimApp) dispatch_psr15_request_object(request_object vphp.PhpObject) &VSlimPsr7Response {
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	mut normalized_request := normalize_psr15_server_request_object(request_object, map[string]string{})
	defer {
		normalized_request.release()
	}
	req := VSlimRequest.from_psr_server_request_object(normalized_request, map[string]string{})
	if app.routes.len > 0 {
		res, ok := app.dispatch_routes_psr15(req, normalized_request)
		if ok {
			return res
		}
	}
	path := RoutePath.normalize(req.path_value())
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
		res, _ := req.to_vslim_request().dispatch_demo_with_params()
		return res.to_psr7_response()
	}
	ctx := PipelineRequestContext.from_object(path, normalized_request, map[string]string{})
	return app.run_not_found_core_with_context_psr(ctx)
}

fn build_route_dispatch_payload(req &VSlimRequest, source_payload vphp.PhpValue, params map[string]string) (vphp.PhpValue, VSlimRequest) {
	if value_subject(source_payload).is_psr_server_request_payload() {
		mut psr_payload := normalize_psr15_server_request_value(source_payload, params)
		defer {
			psr_payload.release()
		}
		dispatch_req := VSlimRequest.from_psr_server_request_object(psr_payload, params)
		return dispatch_req.build_request_value(params), dispatch_req.to_vslim_request()
	}
	dispatch_req := req.with_method(req.method)
	return (&dispatch_req).build_request_value(params), dispatch_req
}

fn (result PipelineDispatchResult) route_dispatch_resolution(route_params map[string]string) RouteDispatchResolution {
	return RouteDispatchResolution{
		response_ref: result.response_ref.owned()
		payload_ref:  result.payload_ref.owned()
		route_params: snapshot_string_map(route_params)
		handled:      true
	}
}

fn RouteDispatchResolution.unresolved() RouteDispatchResolution {
	return RouteDispatchResolution{
		handled: false
	}
}

fn (app &VSlimApp) resolve_route_dispatch(req &VSlimRequest, source_payload vphp.PhpValue, trace_on bool, trace_base i64) RouteDispatchResolution {
	method := req.effective_method()
	path := RoutePath.normalize(req.path_value())
	mut method_not_allowed := false
	mut allowed_methods := []string{}
	dispatch_req := req.with_method(method)

	for route in app.routes {
		if route.handler_type != .php_callable {
			continue
		}
		ok, params := route.matches(path)
		if !ok {
			continue
		}
		allowed_methods = collect_allowed_methods(allowed_methods, route.method)
		if route.method != '*' && route.method != method && !(method == 'HEAD'
			&& route.method == 'GET') {
			method_not_allowed = true
			continue
		}
		if trace_on {
			app.trace_mem_log(req, 'route.matched', trace_base)
		}
		payload, validation_req := build_route_dispatch_payload(&dispatch_req, source_payload,
			params)
		if trace_on {
			app.trace_mem_log(req, 'route.after_build_payload', trace_base)
		}
		result := app.dispatch_route_match(path, payload, &validation_req, route, params)
		if trace_on {
			app.trace_mem_log(req, 'route.after_middleware_chain', trace_base)
		}
		return result.route_dispatch_resolution(params)
	}

	if method == 'OPTIONS' && allowed_methods.len > 0 {
		result := app.dispatch_terminal(&dispatch_req,
			VSlimResponse.options(allowed_methods).fixed_terminal_meta())
		return result.route_dispatch_resolution(map[string]string{})
	}

	if method_not_allowed {
		result := app.dispatch_terminal(&dispatch_req,
			MiddlewareTerminalMeta.method_not_allowed(allowed_methods))
		return result.route_dispatch_resolution(map[string]string{})
	}

	if app.has_not_found_pipeline(path) {
		result := app.dispatch_not_found_terminal(&dispatch_req)
		return result.route_dispatch_resolution(map[string]string{})
	}
	return RouteDispatchResolution.unresolved()
}

fn (app &VSlimApp) resolve_route_dispatch_object(req &VSlimRequest, source_payload vphp.PhpObject, trace_on bool, trace_base i64) RouteDispatchResolution {
	return app.resolve_route_dispatch(req, source_payload.to_value(), trace_on, trace_base)
}

fn (app &VSlimApp) dispatch_route_match(path string, initial_payload vphp.PhpValue, validation_req &VSlimRequest, route VSlimRoute, params map[string]string) PipelineDispatchResult {
	validation_meta, has_validation_meta := app.request_validation_terminal_meta(validation_req)
	if has_validation_meta {
		return app.dispatch_pipeline(path, initial_payload, RawDispatchPlan{
			route_params:  snapshot_string_map(params)
			terminal_meta: validation_meta
		})
	}
	return app.dispatch_pipeline(path, initial_payload, RawDispatchPlan{
		route_params:             snapshot_string_map(params)
		route_handler:            route.handler_ref.clone()
		resource_action:          route.resource_action
		resource_missing_handler: route.resource_missing_handler.clone()
	})
}

fn (app &VSlimApp) dispatch_routes_psr15(req &VSlimRequest, request_payload vphp.PhpObject) (&VSlimPsr7Response, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := app.resolve_route_dispatch_object(req, request_payload, false, 0)
	if resolved.handled {
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: snapshot_string_map(resolved.route_params)
		}
		return app.finalize_response_for_psr(ctx, resolved.response_ref), true
	}
	return VSlimResponse{}.to_psr7_response(), false
}

fn (app &VSlimApp) dispatch_routes_with_params(req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, &VSlimRequest, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := app.resolve_route_dispatch(req, vphp.PhpValue.null(), trace_on, trace_base)
	if resolved.handled {
		if trace_on {
			app.trace_mem_log(req, 'route.after_normalize', trace_base)
		}
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: snapshot_string_map(resolved.route_params)
		}
		res, snapshot := app.finalize_response_with_snapshot(ctx, resolved.response_ref)
		return res, snapshot_string_map(resolved.route_params), snapshot, true
	}
	return VSlimResponse{}, map[string]string{}, req.boxed_snapshot(), false
}

fn (app &VSlimApp) dispatch_routes_worker_with_params(req &VSlimRequest) (vphp.PhpValue, map[string]string, &VSlimRequest, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := app.resolve_route_dispatch(req, vphp.PhpValue.null(), false, 0)
	if resolved.handled {
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: snapshot_string_map(resolved.route_params)
		}
		if value_subject(resolved.response_ref).is_worker_stream_response() {
			return resolved.response_ref.owned(), snapshot_string_map(resolved.route_params), VSlimRequest.from_payload(ctx.payload_ref,
				ctx.route_params), true
		}
		raw_out, snapshot := app.finalize_response_for_worker(ctx, resolved.response_ref)
		return raw_out, snapshot_string_map(resolved.route_params), snapshot, true
	}
	return vphp.PhpValue.null(), map[string]string{}, req.boxed_snapshot(), false
}

fn dispatch_resource_missing_meta(action string, handler vphp.PhpCallable, request_payload vphp.PhpValue, params map[string]string) vphp.PhpValue {
	if !handler.is_valid() || !handler.is_callable() {
		return vphp.PhpValue.null()
	}
	mut psr_arg := normalize_psr15_server_request(request_payload, params)
	mut action_arg := vphp.PhpString.of(action)
	mut params_arg := vphp.PhpValue.from_v[map[string]string](params) or { vphp.PhpValue.null() }
	defer {
		psr_arg.release()
		action_arg.release()
		params_arg.release()
	}
	mut result := handler.invoke(psr_arg, action_arg, params_arg)
	return result.owned()
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

fn (app &VSlimApp) request_validation_terminal_meta(req &VSlimRequest) (MiddlewareTerminalMeta, bool) {
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

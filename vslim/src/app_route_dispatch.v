module main

import os
import vphp

struct RouteDispatchResolution {
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	route_params map[string]string
	handled      bool
}

fn dispatch_app_request_with_params(app &VSlimApp, req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, &VSlimRequest) {
	if app.routes.len > 0 {
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.routes.begin', trace_base)
		}
		res, params, effective_req, ok := dispatch_php_routes_with_params(app, req, trace_on,
			trace_base)
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.routes.end', trace_base)
		}
		if ok {
			return snapshot_vslim_response(res), snapshot_string_map(params), new_vslim_request_snapshot(effective_req)
		}
	}
	path := RoutePath.normalize(req.path_value())
	if has_php_not_found_pipeline(app, path) {
		result := dispatch_php_not_found_terminal(app, req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		res, snapshot := finalize_response_with_snapshot(app, ctx, result.response_ref)
		return snapshot_vslim_response(res), map[string]string{}, new_vslim_request_snapshot(snapshot)
	}
	if app.use_demo {
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.demo_fallback', trace_base)
		}
		res, params := dispatch_demo_request_with_params(req.to_vslim_request())
		return snapshot_vslim_response(res), snapshot_string_map(params), new_vslim_request_snapshot(req)
	}
	if trace_on {
		vslim_trace_mem_log(app, req, 'dispatch.not_found_fallback', trace_base)
	}
	return snapshot_vslim_response(run_not_found(app, req)), map[string]string{}, new_vslim_request_snapshot(req)
}

fn dispatch_app_request_worker_value(app &VSlimApp, req &VSlimRequest) vphp.PhpValue {
	prev_app := enter_runtime_dispatch_app(app)
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	if app.routes.len > 0 {
		mut raw, _, effective_req, ok := dispatch_php_routes_worker_with_params(app, req)
		if ok {
			propagate_request_trace_headers_to_value(effective_req, raw)
			if resolve_effective_method(req) == 'HEAD' && raw.is_object()
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
	if has_php_not_found_pipeline(app, path) {
		result := dispatch_php_not_found_terminal(app, req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		raw_out, final_request := finalize_response_for_worker(app, ctx, result.response_ref)
		if is_worker_stream_response(raw_out) {
			return raw_out
		}
		if object := raw_out.as_object() {
			if mut final_res := object.to_v_object[VSlimResponse]() {
				propagate_request_trace_headers(final_request, mut final_res)
				if resolve_effective_method(req) == 'HEAD' {
					final_res.body = ''
				}
			}
		}
		if resolve_effective_method(req) == 'HEAD' {
			return raw_out
		}
		return raw_out
	}
	if app.use_demo {
		mut res, _ := dispatch_demo_request_with_params(req.to_vslim_request())
		propagate_request_trace_headers(req, mut res)
		if resolve_effective_method(req) == 'HEAD' {
			res.body = ''
		}
		return build_php_response_value(res)
	}
	mut res := run_not_found(app, req)
	propagate_request_trace_headers(req, mut res)
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	return build_php_response_value(res)
}

fn dispatch_app_psr15_request_value(app &VSlimApp, request_value vphp.PhpValue) &VSlimPsr7Response {
	request_object := request_value.as_object() or {
		return dispatch_app_psr15_request_object(app, vphp.PhpObject.invalid())
	}
	return dispatch_app_psr15_request_object(app, request_object)
}

fn dispatch_app_psr15_request_object(app &VSlimApp, request_object vphp.PhpObject) &VSlimPsr7Response {
	prev_app := enter_runtime_dispatch_app(app)
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	mut normalized_request := normalize_psr15_server_request_object(request_object, map[string]string{})
	defer {
		normalized_request.release()
	}
	req := new_vslim_request_from_psr_server_request_object(normalized_request, map[string]string{})
	if app.routes.len > 0 {
		res, ok := dispatch_php_routes_psr15(app, req, normalized_request)
		if ok {
			return res
		}
	}
	path := RoutePath.normalize(req.path_value())
	if has_php_not_found_pipeline(app, path) {
		result := dispatch_php_not_found_terminal(app, req)
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  result.payload_ref.owned()
			route_params: map[string]string{}
		}
		return finalize_response_for_psr(app, ctx, result.response_ref)
	}
	if app.use_demo {
		res, _ := dispatch_demo_request_with_params(req.to_vslim_request())
		return new_psr7_response_from_vslim_response(res)
	}
	ctx := new_pipeline_request_context_from_object(path, normalized_request, map[string]string{})
	return run_not_found_core_with_context_psr(app, ctx)
}

fn build_route_dispatch_payload(req &VSlimRequest, source_payload vphp.PhpValue, params map[string]string) (vphp.PhpValue, VSlimRequest) {
	if is_psr_server_request_payload(source_payload) {
		mut psr_payload := normalize_psr15_server_request_value(source_payload, params)
		defer {
			psr_payload.release()
		}
		dispatch_req := new_vslim_request_from_psr_server_request_object(psr_payload, params)
		return build_php_request_value(dispatch_req, params), dispatch_req.to_vslim_request()
	}
	dispatch_req := request_with_method(req, req.method)
	return build_php_request_value(&dispatch_req, params), dispatch_req
}

fn route_dispatch_resolution(result PipelineDispatchResult, route_params map[string]string) RouteDispatchResolution {
	return RouteDispatchResolution{
		response_ref: result.response_ref.owned()
		payload_ref:  result.payload_ref.owned()
		route_params: snapshot_string_map(route_params)
		handled:      true
	}
}

fn unresolved_route_dispatch_resolution() RouteDispatchResolution {
	return RouteDispatchResolution{
		handled: false
	}
}

fn resolve_php_route_dispatch(app &VSlimApp, req &VSlimRequest, source_payload vphp.PhpValue, trace_on bool, trace_base i64) RouteDispatchResolution {
	method := resolve_effective_method(req)
	path := RoutePath.normalize(req.path_value())
	mut method_not_allowed := false
	mut allowed_methods := []string{}
	dispatch_req := request_with_method(req, method)

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
			vslim_trace_mem_log(app, req, 'route.matched', trace_base)
		}
		payload, validation_req := build_route_dispatch_payload(&dispatch_req, source_payload,
			params)
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_build_payload', trace_base)
		}
		result := dispatch_php_route_match(app, path, payload, &validation_req, route, params)
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_middleware_chain', trace_base)
		}
		return route_dispatch_resolution(result, params)
	}

	if method == 'OPTIONS' && allowed_methods.len > 0 {
		result := dispatch_php_terminal(app, &dispatch_req,
			fixed_terminal_meta(build_options_response(allowed_methods)))
		return route_dispatch_resolution(result, map[string]string{})
	}

	if method_not_allowed {
		result := dispatch_php_terminal(app, &dispatch_req,
			method_not_allowed_terminal_meta(allowed_methods))
		return route_dispatch_resolution(result, map[string]string{})
	}

	if has_php_not_found_pipeline(app, path) {
		result := dispatch_php_not_found_terminal(app, &dispatch_req)
		return route_dispatch_resolution(result, map[string]string{})
	}
	return unresolved_route_dispatch_resolution()
}

fn resolve_php_route_dispatch_object(app &VSlimApp, req &VSlimRequest, source_payload vphp.PhpObject, trace_on bool, trace_base i64) RouteDispatchResolution {
	return resolve_php_route_dispatch(app, req, source_payload.to_value(), trace_on, trace_base)
}

fn dispatch_php_route_match(app &VSlimApp, path string, initial_payload vphp.PhpValue, validation_req &VSlimRequest, route VSlimRoute, params map[string]string) PipelineDispatchResult {
	validation_meta, has_validation_meta := request_validation_terminal_meta(app, validation_req)
	if has_validation_meta {
		return dispatch_php_pipeline(app, path, initial_payload, RawDispatchPlan{
			route_params:  snapshot_string_map(params)
			terminal_meta: validation_meta
		})
	}
	return dispatch_php_pipeline(app, path, initial_payload, RawDispatchPlan{
		route_params:             snapshot_string_map(params)
		route_handler:            route.php_handler.clone()
		resource_action:          route.resource_action
		resource_missing_handler: route.resource_missing_handler.clone()
	})
}

fn dispatch_php_routes_psr15(app &VSlimApp, req &VSlimRequest, request_payload vphp.PhpObject) (&VSlimPsr7Response, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := resolve_php_route_dispatch_object(app, req, request_payload, false, 0)
	if resolved.handled {
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: snapshot_string_map(resolved.route_params)
		}
		return finalize_response_for_psr(app, ctx, resolved.response_ref), true
	}
	return new_psr7_response_from_vslim_response(VSlimResponse{}), false
}

fn dispatch_php_routes_with_params(app &VSlimApp, req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, &VSlimRequest, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := resolve_php_route_dispatch(app, req, vphp.PhpValue.null(), trace_on, trace_base)
	if resolved.handled {
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_normalize', trace_base)
		}
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: snapshot_string_map(resolved.route_params)
		}
		res, snapshot := finalize_response_with_snapshot(app, ctx, resolved.response_ref)
		return res, snapshot_string_map(resolved.route_params), snapshot, true
	}
	return VSlimResponse{}, map[string]string{}, new_vslim_request_snapshot(req), false
}

fn dispatch_php_routes_worker_with_params(app &VSlimApp, req &VSlimRequest) (vphp.PhpValue, map[string]string, &VSlimRequest, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := resolve_php_route_dispatch(app, req, vphp.PhpValue.null(), false, 0)
	if resolved.handled {
		ctx := PipelineRequestContext{
			path:         path
			payload_ref:  resolved.payload_ref.owned()
			route_params: snapshot_string_map(resolved.route_params)
		}
		if is_worker_stream_response(resolved.response_ref) {
			return resolved.response_ref.owned(), snapshot_string_map(resolved.route_params), request_snapshot_from_payload(ctx.payload_ref,
				ctx.route_params), true
		}
		raw_out, snapshot := finalize_response_for_worker(app, ctx, resolved.response_ref)
		return raw_out, snapshot_string_map(resolved.route_params), snapshot, true
	}
	return vphp.PhpValue.null(), map[string]string{}, new_vslim_request_snapshot(req), false
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

fn vslim_max_body_bytes(app &VSlimApp) int {
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

fn request_validation_terminal_meta(app &VSlimApp, req &VSlimRequest) (MiddlewareTerminalMeta, bool) {
	max_bytes := vslim_max_body_bytes(app)
	if max_bytes > 0 && req.body.len > max_bytes {
		return error_terminal_meta(413, 'Payload too large', 'Payload Too Large',
			'payload_too_large'), true
	}
	parse_msg := req.parse_error()
	if parse_msg != '' {
		return error_terminal_meta(400, 'Bad Request: invalid JSON body',
			'Bad Request: invalid JSON body', 'bad_json_body'), true
	}
	return MiddlewareTerminalMeta{}, false
}

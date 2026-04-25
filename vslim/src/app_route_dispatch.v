module main

import os
import vphp

struct RawRouteDispatchResolution {
	raw_response_ref vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
	payload_ref      vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
	route_params     map[string]string
	handled          bool
}

fn dispatch_app_request_with_params(app &VSlimApp, req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, &VSlimRequest) {
	if app.routes.len > 0 {
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.routes.begin', trace_base)
		}
		res, params, effective_req, ok := dispatch_php_routes_with_params(app, req, trace_on, trace_base)
		if trace_on {
			vslim_trace_mem_log(app, req, 'dispatch.routes.end', trace_base)
		}
		if ok {
			return snapshot_vslim_response(res), snapshot_string_map(params), new_vslim_request_snapshot(effective_req)
		}
	}
	path := RoutePath.normalize(req.path_value())
	if has_php_not_found_pipeline(app, path) {
		raw, not_found_payload := dispatch_php_not_found_terminal_raw(app, req)
		ctx := new_pipeline_request_context(path, not_found_payload, map[string]string{})
		res, snapshot := finalize_raw_response_with_snapshot(app, ctx, raw)
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

fn dispatch_app_request_worker(app &VSlimApp, req &VSlimRequest) vphp.ZVal {
	prev_app := enter_runtime_dispatch_app(app)
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	if app.routes.len > 0 {
		raw, _, effective_req, ok := dispatch_php_routes_worker_with_params(app, req)
		if ok {
			propagate_request_trace_headers_to_object(effective_req, vphp.RequestBorrowedZBox.from_zval(raw))
			if resolve_effective_method(req) == 'HEAD' && raw.is_object()
				&& raw.is_instance_of('VSlim\\VHttpd\\Response') {
				if mut resp := raw.to_object[VSlimResponse]() {
					resp.body = ''
				}
			}
			return raw
		}
	}
	path := RoutePath.normalize(req.path_value())
	if has_php_not_found_pipeline(app, path) {
		raw, not_found_payload := dispatch_php_not_found_terminal_raw(app, req)
		ctx := new_pipeline_request_context(path, not_found_payload, map[string]string{})
		raw_out, final_request := finalize_raw_response_for_worker(app, ctx, raw)
		if is_worker_stream_response_borrowed(vphp.RequestBorrowedZBox.from_zval(raw_out)) {
			return raw_out
		}
		mut final_res := raw_out.to_object[VSlimResponse]() or { return raw_out }
		propagate_request_trace_headers(final_request, mut final_res)
		if resolve_effective_method(req) == 'HEAD' {
			final_res.body = ''
		}
		return raw_out
	}
	if app.use_demo {
		mut res, _ := dispatch_demo_request_with_params(req.to_vslim_request())
		propagate_request_trace_headers(req, mut res)
		if resolve_effective_method(req) == 'HEAD' {
			res.body = ''
		}
		return build_php_response_object(res)
	}
	mut res := run_not_found(app, req)
	propagate_request_trace_headers(req, mut res)
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	return build_php_response_object(res)
}

fn dispatch_app_psr15_request(app &VSlimApp, request_payload vphp.ZVal) &VSlimPsr7Response {
	prev_app := enter_runtime_dispatch_app(app)
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	normalized_request := normalize_psr15_server_request_payload(vphp.RequestBorrowedZBox.from_zval(request_payload),
		map[string]string{})
	req := new_vslim_request_from_psr_server_request(vphp.RequestBorrowedZBox.from_zval(normalized_request),
		map[string]string{})
	if app.routes.len > 0 {
		res, ok := dispatch_php_routes_psr15(app, req, normalized_request)
		if ok {
			return res
		}
	}
	path := RoutePath.normalize(req.path_value())
	if has_php_not_found_pipeline(app, path) {
		raw, not_found_payload := dispatch_php_not_found_terminal_raw(app, req)
		ctx := new_pipeline_request_context(path, not_found_payload, map[string]string{})
		return finalize_raw_response_for_psr(app, ctx, raw)
	}
	if app.use_demo {
		res, _ := dispatch_demo_request_with_params(req.to_vslim_request())
		return new_psr7_response_from_vslim_response(res)
	}
	ctx := new_pipeline_request_context(path, vphp.RequestOwnedZBox.from_zval(normalized_request),
		map[string]string{})
	return run_not_found_core_with_context_psr(app, ctx)
}

fn build_route_dispatch_payload(req &VSlimRequest, source_payload vphp.RequestBorrowedZBox, params map[string]string) (vphp.ZVal, VSlimRequest) {
	if is_psr_server_request_payload(source_payload) {
		psr_payload := normalize_psr15_server_request_payload(source_payload, params)
		dispatch_req := new_vslim_request_from_psr_server_request(vphp.RequestBorrowedZBox.from_zval(psr_payload),
			params)
		return build_php_request_object(dispatch_req, params), dispatch_req.to_vslim_request()
	}
	dispatch_req := request_with_method(req, req.method)
	return build_php_request_object(&dispatch_req, params), dispatch_req
}

fn raw_route_dispatch_resolution(raw vphp.ZVal, payload vphp.RequestOwnedZBox, route_params map[string]string) RawRouteDispatchResolution {
	return RawRouteDispatchResolution{
		raw_response_ref: vphp.RequestOwnedZBox.from_zval(raw)
		payload_ref:      payload.clone_request_owned()
		route_params:     snapshot_string_map(route_params)
		handled:          true
	}
}

fn unresolved_raw_route_dispatch_resolution() RawRouteDispatchResolution {
	return RawRouteDispatchResolution{
		handled: false
	}
}

fn resolve_php_route_dispatch_raw(app &VSlimApp, req &VSlimRequest, source_payload vphp.RequestBorrowedZBox, trace_on bool, trace_base i64) RawRouteDispatchResolution {
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
		if route.method != '*' && route.method != method && !(method == 'HEAD' && route.method == 'GET') {
			method_not_allowed = true
			continue
		}
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.matched', trace_base)
		}
		payload, validation_req := build_route_dispatch_payload(&dispatch_req, source_payload, params)
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_build_payload', trace_base)
		}
		raw_res, middleware_payload := dispatch_php_route_match_raw(app, path, vphp.RequestBorrowedZBox.from_zval(payload),
			&validation_req, route, params)
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_middleware_chain', trace_base)
		}
		return raw_route_dispatch_resolution(raw_res, middleware_payload, params)
	}

	if method == 'OPTIONS' && allowed_methods.len > 0 {
		raw_res, middleware_payload := dispatch_php_terminal_raw(app, &dispatch_req, fixed_terminal_meta(build_options_response(allowed_methods)))
		return raw_route_dispatch_resolution(raw_res, middleware_payload, map[string]string{})
	}

	if method_not_allowed {
		raw_res, middleware_payload := dispatch_php_terminal_raw(app, &dispatch_req, method_not_allowed_terminal_meta(allowed_methods))
		return raw_route_dispatch_resolution(raw_res, middleware_payload, map[string]string{})
	}

	if has_php_not_found_pipeline(app, path) {
		raw_res, middleware_payload := dispatch_php_not_found_terminal_raw(app, &dispatch_req)
		return raw_route_dispatch_resolution(raw_res, middleware_payload, map[string]string{})
	}
	return unresolved_raw_route_dispatch_resolution()
}

fn dispatch_php_route_match_raw(app &VSlimApp, path string, initial_payload vphp.RequestBorrowedZBox, validation_req &VSlimRequest, route VSlimRoute, params map[string]string) (vphp.ZVal, vphp.RequestOwnedZBox) {
	validation_meta, has_validation_meta := request_validation_terminal_meta(app, validation_req)
	if has_validation_meta {
		return dispatch_php_pipeline_raw(app, path, initial_payload, RawDispatchPlan{
			route_params:  snapshot_string_map(params)
			terminal_meta: validation_meta
		})
	}
	return dispatch_php_pipeline_raw(app, path, initial_payload, RawDispatchPlan{
		route_params:             snapshot_string_map(params)
		route_handler:            route.php_handler.clone()
		resource_action:          route.resource_action
		resource_missing_handler: route.resource_missing_handler.clone()
	})
}

fn dispatch_php_routes_psr15(app &VSlimApp, req &VSlimRequest, request_payload vphp.ZVal) (&VSlimPsr7Response, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := resolve_php_route_dispatch_raw(app, req, vphp.RequestBorrowedZBox.from_zval(request_payload),
		false, 0)
	if resolved.handled {
		ctx := new_pipeline_request_context(path, resolved.payload_ref, resolved.route_params)
		return finalize_raw_response_for_psr(app, ctx, resolved.raw_response_ref.to_zval()), true
	}
	return new_psr7_response_from_vslim_response(VSlimResponse{}), false
}

fn dispatch_php_routes_with_params(app &VSlimApp, req &VSlimRequest, trace_on bool, trace_base i64) (VSlimResponse, map[string]string, &VSlimRequest, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := resolve_php_route_dispatch_raw(app, req, vphp.RequestBorrowedZBox.null(), trace_on,
		trace_base)
	if resolved.handled {
		if trace_on {
			vslim_trace_mem_log(app, req, 'route.after_normalize', trace_base)
		}
		ctx := new_pipeline_request_context(path, resolved.payload_ref, resolved.route_params)
		res, snapshot := finalize_raw_response_with_snapshot(app, ctx, resolved.raw_response_ref.to_zval())
		return res, snapshot_string_map(resolved.route_params), snapshot, true
	}
	return VSlimResponse{}, map[string]string{}, new_vslim_request_snapshot(req), false
}

fn dispatch_php_routes_worker_with_params(app &VSlimApp, req &VSlimRequest) (vphp.ZVal, map[string]string, &VSlimRequest, bool) {
	path := RoutePath.normalize(req.path_value())
	resolved := resolve_php_route_dispatch_raw(app, req, vphp.RequestBorrowedZBox.null(), false, 0)
	if resolved.handled {
		ctx := new_pipeline_request_context(path, resolved.payload_ref, resolved.route_params)
		if is_worker_stream_response_borrowed(resolved.raw_response_ref.borrowed()) {
			return resolved.raw_response_ref.to_zval(), snapshot_string_map(resolved.route_params), request_snapshot_from_payload(ctx.payload_ref.borrowed(),
				ctx.route_params), true
		}
		raw_out, snapshot := finalize_raw_response_for_worker(app, ctx, resolved.raw_response_ref.to_zval())
		return raw_out, snapshot_string_map(resolved.route_params), snapshot, true
	}
	return vphp.RequestOwnedZBox.new_null().to_zval(), map[string]string{}, new_vslim_request_snapshot(req), false
}

fn dispatch_resource_missing_meta(action string, handler vphp.RequestBorrowedZBox, request_payload vphp.RequestBorrowedZBox, params map[string]string) vphp.ZVal {
	if !handler.is_valid() || !handler.is_callable() {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	params_z := vphp.new_zval_from[map[string]string](params) or {
		vphp.RequestOwnedZBox.new_null().to_zval()
	}
	action_z := vphp.RequestOwnedZBox.new_string(action).to_zval()
	psr_payload := normalize_psr15_server_request_payload(request_payload, params)
	mut result := vphp.call_request_owned_box(handler.to_zval(), [psr_payload, action_z, params_z])
	return result.take_zval()
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
		return error_terminal_meta(413, 'Payload too large', 'Payload Too Large', 'payload_too_large'),
			true
	}
	parse_msg := req.parse_error()
	if parse_msg != '' {
		return error_terminal_meta(400, 'Bad Request: invalid JSON body', 'Bad Request: invalid JSON body',
			'bad_json_body'), true
	}
	return MiddlewareTerminalMeta{}, false
}

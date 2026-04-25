module main

import vphp

struct AppKernelTraceState {
	enabled    bool
	base_bytes i64
}

struct AppKernelDispatchResult {
	response_ref      &VSlimResponse = unsafe { nil }
	route_params      map[string]string
	effective_request_ref &VSlimRequest = unsafe { nil }
}

fn app_kernel_prepare(app &VSlimApp) {
	unsafe {
		mut writable := &VSlimApp(app)
		ensure_app_booted(mut writable)
	}
}

fn new_app_kernel_trace(app &VSlimApp, req &VSlimRequest, enter_stage string) AppKernelTraceState {
	enabled := vslim_trace_mem_should_log(app)
	mut base_bytes := i64(0)
	if enabled {
		base_bytes = vslim_mem_usage_bytes()
		vslim_trace_mem_log(app, req, enter_stage, base_bytes)
	}
	return AppKernelTraceState{
		enabled:    enabled
		base_bytes: base_bytes
	}
}

fn app_kernel_trace_log(trace AppKernelTraceState, app &VSlimApp, req &VSlimRequest, stage string) {
	if trace.enabled {
		vslim_trace_mem_log(app, req, stage, trace.base_bytes)
	}
}

fn app_kernel_dispatch_request_with_trace_labels(app &VSlimApp, req &VSlimRequest, enter_stage string, after_core_stage string, before_return_stage string) AppKernelDispatchResult {
	trace := new_app_kernel_trace(app, req, enter_stage)
	mut res, params, effective_req := dispatch_app_request_with_params(app, req, trace.enabled,
		trace.base_bytes)
	cli_debug_log('kernel.after_dispatch status=${res.status} body_len=${res.body.len}')
	app_kernel_trace_log(trace, app, req, after_core_stage)
	propagate_request_trace_headers(effective_req, mut res)
	cli_debug_log('kernel.after_propagate status=${res.status} body_len=${res.body.len}')
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	cli_debug_log('kernel.before_snapshot status=${res.status} body_len=${res.body.len}')
	app_kernel_trace_log(trace, app, req, before_return_stage)
	return AppKernelDispatchResult{
		response_ref:          new_vslim_response_snapshot_ref(&res)
		route_params:          snapshot_string_map(params)
		effective_request_ref: new_vslim_request_snapshot(effective_req)
	}
}

fn app_kernel_dispatch_request(app &VSlimApp, req &VSlimRequest) AppKernelDispatchResult {
	return app_kernel_dispatch_request_with_trace_labels(app, req, 'dispatch.enter',
		'dispatch.after_core', 'dispatch.before_return')
}

fn app_kernel_dispatch_envelope_map(app &VSlimApp, req &VSlimRequest) map[string]string {
	result := app_kernel_dispatch_request_with_trace_labels(app, req, 'dispatch_map.enter',
		'dispatch_map.after_core', 'dispatch_map.before_return')
	if result.response_ref == unsafe { nil } {
		return app_kernel_response_map(VSlimResponse{})
	}
	return app_kernel_response_map(*result.response_ref)
}

fn app_kernel_response_map(res VSlimResponse) map[string]string {
	mut out := {
		'status':       '${res.status}'
		'body':         res.body
		'content_type': res.content_type
	}
	for name, value in res.headers {
		if name == '' {
			continue
		}
		out['headers_${name.to_lower()}'] = value
	}
	return out
}

fn app_kernel_sync_dispatch_request(mut target VSlimRequest, result AppKernelDispatchResult) {
	target.params = snapshot_string_map(result.route_params)
	if result.effective_request_ref != unsafe { nil } {
		sync_vslim_request_from_snapshot(mut target, *result.effective_request_ref)
	}
}

fn propagate_request_trace_headers(req &VSlimRequest, mut res VSlimResponse) {
	rid := req.request_id()
	if rid != '' && !res.has_header('x-request-id') {
		res.set_header('x-request-id', rid)
	}
	tid := req.trace_id()
	if tid != '' {
		if !res.has_header('x-trace-id') {
			res.set_header('x-trace-id', tid)
		}
		if !res.has_header('x-vhttpd-trace-id') {
			res.set_header('x-vhttpd-trace-id', tid)
		}
	}
}

fn request_snapshot_from_payload(payload vphp.RequestBorrowedZBox, route_params map[string]string) &VSlimRequest {
	return new_vslim_request_from_psr_server_request(payload, route_params)
}

fn sync_vslim_request_from_snapshot(mut target VSlimRequest, snapshot VSlimRequest) {
	target.method = snapshot.method.clone()
	target.raw_path = if snapshot.raw_path.trim_space() == '' {
		if snapshot.path == '/' && snapshot.query_string == '' {
			'/'
		} else if snapshot.query_string == '' {
			snapshot.path.clone()
		} else {
			'${snapshot.path}?${snapshot.query_string}'
		}
	} else {
		snapshot.raw_path.clone()
	}
	target.path = snapshot.path.clone()
	target.body = snapshot.body.clone()
	target.query_string = snapshot.query_string.clone()
	target.scheme = snapshot.scheme.clone()
	target.host = snapshot.host.clone()
	target.port = snapshot.port.clone()
	target.protocol_version = snapshot.protocol_version.clone()
	target.remote_addr = snapshot.remote_addr.clone()
	target.query = snapshot_string_map(snapshot.query)
	target.headers = snapshot_string_map(snapshot.headers)
	target.cookies = snapshot_string_map(snapshot.cookies)
	target.attributes = snapshot_string_map(snapshot.attributes)
	target.server = snapshot_string_map(snapshot.server)
	target.uploaded_files = snapshot_string_list(snapshot.uploaded_files)
	target.params = snapshot_string_map(snapshot.params)
}

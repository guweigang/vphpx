module main

import vphp

struct AppKernelTraceState {
	enabled    bool
	base_bytes i64
}

struct AppKernelDispatchResult {
	response          VSlimResponse
	route_params      map[string]string
	effective_request VSlimRequest
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
	app_kernel_trace_log(trace, app, req, after_core_stage)
	propagate_request_trace_headers(&effective_req, mut res)
	if resolve_effective_method(req) == 'HEAD' {
		res.body = ''
	}
	app_kernel_trace_log(trace, app, req, before_return_stage)
	return AppKernelDispatchResult{
		response:          res
		route_params:      params.clone()
		effective_request: effective_req
	}
}

fn app_kernel_dispatch_request(app &VSlimApp, req &VSlimRequest) AppKernelDispatchResult {
	return app_kernel_dispatch_request_with_trace_labels(app, req, 'dispatch.enter',
		'dispatch.after_core', 'dispatch.before_return')
}

fn app_kernel_dispatch_envelope_map(app &VSlimApp, req &VSlimRequest) map[string]string {
	result := app_kernel_dispatch_request_with_trace_labels(app, req, 'dispatch_map.enter',
		'dispatch_map.after_core', 'dispatch_map.before_return')
	return app_kernel_response_map(result.response)
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
	sync_vslim_request_from_snapshot(mut target, result.effective_request)
	target.params = result.route_params.clone()
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

fn request_snapshot_from_payload(payload vphp.RequestBorrowedZBox, route_params map[string]string) VSlimRequest {
	return new_vslim_request_from_psr_server_request(payload, route_params).to_vslim_request()
}

fn sync_vslim_request_from_snapshot(mut target VSlimRequest, snapshot VSlimRequest) {
	target.method = snapshot.method
	target.raw_path = snapshot.raw_path
	target.path = snapshot.path
	target.body = snapshot.body
	target.query_string = snapshot.query_string
	target.scheme = snapshot.scheme
	target.host = snapshot.host
	target.port = snapshot.port
	target.protocol_version = snapshot.protocol_version
	target.remote_addr = snapshot.remote_addr
	target.query = snapshot.query.clone()
	target.headers = snapshot.headers.clone()
	target.cookies = snapshot.cookies.clone()
	target.attributes = snapshot.attributes.clone()
	target.server = snapshot.server.clone()
	target.uploaded_files = snapshot.uploaded_files.clone()
	target.params = snapshot.params.clone()
}

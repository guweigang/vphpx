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

fn (app &VSlimApp) prepare_kernel() {
	unsafe {
		mut writable := &VSlimApp(app)
		writable.ensure_booted()
	}
}

fn (app &VSlimApp) new_kernel_trace(req &VSlimRequest, enter_stage string) AppKernelTraceState {
	enabled := app.trace_mem_should_log()
	mut base_bytes := i64(0)
	if enabled {
		base_bytes = vslim_mem_usage_bytes()
		app.trace_mem_log(req, enter_stage, base_bytes)
	}
	return AppKernelTraceState{
		enabled:    enabled
		base_bytes: base_bytes
	}
}

fn (trace AppKernelTraceState) log(app &VSlimApp, req &VSlimRequest, stage string) {
	if trace.enabled {
		app.trace_mem_log(req, stage, trace.base_bytes)
	}
}

fn (app &VSlimApp) dispatch_request_with_trace_labels(req &VSlimRequest, enter_stage string, after_core_stage string, before_return_stage string) AppKernelDispatchResult {
	trace := app.new_kernel_trace(req, enter_stage)
	mut res, params, effective_req := app.dispatch_request_with_params(req, trace.enabled,
		trace.base_bytes)
	cli_debug_log('kernel.after_dispatch status=${res.status} body_len=${res.body.len}')
	trace.log(app, req, after_core_stage)
	res.propagate_request_trace_headers(effective_req)
	cli_debug_log('kernel.after_propagate status=${res.status} body_len=${res.body.len}')
	if req.effective_method() == 'HEAD' {
		res.body = ''
	}
	cli_debug_log('kernel.before_snapshot status=${res.status} body_len=${res.body.len}')
	trace.log(app, req, before_return_stage)
	return AppKernelDispatchResult{
		response_ref:          res.boxed_snapshot()
		route_params:          snapshot_string_map(params)
		effective_request_ref: effective_req.boxed_snapshot()
	}
}

fn (app &VSlimApp) dispatch_kernel_request(req &VSlimRequest) AppKernelDispatchResult {
	return app.dispatch_request_with_trace_labels(req, 'dispatch.enter',
		'dispatch.after_core', 'dispatch.before_return')
}

fn (app &VSlimApp) dispatch_kernel_envelope_map(req &VSlimRequest) map[string]string {
	result := app.dispatch_request_with_trace_labels(req, 'dispatch_map.enter',
		'dispatch_map.after_core', 'dispatch_map.before_return')
	if result.response_ref == unsafe { nil } {
		return VSlimResponse{}.as_dispatch_map()
	}
	return result.response_ref.as_dispatch_map()
}

fn (res &VSlimResponse) as_dispatch_map() map[string]string {
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

fn (result AppKernelDispatchResult) sync_request(mut target VSlimRequest) {
	if result.effective_request_ref != unsafe { nil } {
		target.sync_from_snapshot(*result.effective_request_ref)
	}
	target.params = snapshot_string_map(result.route_params)
}

fn (mut res VSlimResponse) propagate_request_trace_headers(req &VSlimRequest) {
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

fn VSlimRequest.from_payload(payload vphp.PhpValue, route_params map[string]string) &VSlimRequest {
	return VSlimRequest.from_psr_server_request(payload, route_params)
}

fn (mut target VSlimRequest) sync_from_snapshot(snapshot VSlimRequest) {
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

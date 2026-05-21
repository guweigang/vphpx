module appx

import httpx
import loggerx

struct AppKernelTraceState {
	enabled    bool
	base_bytes i64
}

struct AppKernelDispatchResult {
	response_ref          &httpx.VSlimResponse = unsafe { nil }
	route_params          map[string]string
	effective_request_ref &httpx.VSlimRequest = unsafe { nil }
}

fn (app &VSlimApp) prepare_kernel() {
	unsafe {
		mut writable := &VSlimApp(app)
		writable.ensure_booted()
	}
}

fn (app &VSlimApp) new_kernel_trace(req &httpx.VSlimRequest, enter_stage string) AppKernelTraceState {
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

fn (trace AppKernelTraceState) log(app &VSlimApp, req &httpx.VSlimRequest, stage string) {
	if trace.enabled {
		app.trace_mem_log(req, stage, trace.base_bytes)
	}
}

fn (app &VSlimApp) dispatch_request_with_trace_labels(req &httpx.VSlimRequest, enter_stage string, after_core_stage string, before_return_stage string) AppKernelDispatchResult {
	trace := app.new_kernel_trace(req, enter_stage)
	mut res, params, effective_req := app.dispatch_request_with_params(req, trace.enabled,
		trace.base_bytes)
	loggerx.cli_debug_log('kernel.after_dispatch status=${res.status} body_len=${res.body.len}')
	trace.log(app, req, after_core_stage)
	res.propagate_request_trace_headers(effective_req)
	loggerx.cli_debug_log('kernel.after_propagate status=${res.status} body_len=${res.body.len}')
	if req.effective_method() == 'HEAD' {
		res.body = ''
	}
	loggerx.cli_debug_log('kernel.before_snapshot status=${res.status} body_len=${res.body.len}')
	trace.log(app, req, before_return_stage)
	return AppKernelDispatchResult{
		response_ref:          res.boxed_snapshot()
		route_params:          httpx.snapshot_string_map(params)
		effective_request_ref: effective_req.boxed_snapshot()
	}
}

fn (app &VSlimApp) dispatch_kernel_request(req &httpx.VSlimRequest) AppKernelDispatchResult {
	return app.dispatch_request_with_trace_labels(req, 'dispatch.enter', 'dispatch.after_core',
		'dispatch.before_return')
}

fn (app &VSlimApp) dispatch_kernel_envelope_map(req &httpx.VSlimRequest) map[string]string {
	result := app.dispatch_request_with_trace_labels(req, 'dispatch_map.enter',
		'dispatch_map.after_core', 'dispatch_map.before_return')
	if result.response_ref == unsafe { nil } {
		empty := httpx.VSlimResponse.empty()
		return empty.dispatch_map()
	}
	return result.response_ref.dispatch_map()
}

fn (result AppKernelDispatchResult) sync_request(mut target httpx.VSlimRequest) {
	if result.effective_request_ref != unsafe { nil } {
		target.sync_from_snapshot(*result.effective_request_ref)
	}
	target.params = httpx.snapshot_string_map(result.route_params)
}

module appx

import httpx
import loggerx
import vphp

fn (app &VSlimApp) dispatch_request_facade(req &httpx.VSlimRequest) &httpx.VSlimResponse {
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	result := app.dispatch_kernel_request(req)
	unsafe {
		mut writable := &httpx.VSlimRequest(req)
		result.sync_request(mut writable)
	}
	if result.response_ref == unsafe { nil } {
		empty := httpx.VSlimResponse.empty()
		return empty.boxed_snapshot()
	}
	loggerx.cli_debug_log('dispatch.facade result status=${result.response_ref.status} body_len=${result.response_ref.body.len}')
	return result.response_ref.boxed_snapshot_ref()
}

pub fn (app &VSlimApp) dispatch_raw(method string, raw_path string) &httpx.VSlimResponse {
	return app.dispatch_body_raw(method, raw_path, '')
}

pub fn (app &VSlimApp) dispatch_body_raw(method string, raw_path string, body string) &httpx.VSlimResponse {
	req := httpx.VSlimRequest.new(method, raw_path, body)
	return app.dispatch_request_raw(req)
}

pub fn (app &VSlimApp) dispatch_request_raw(req &httpx.VSlimRequest) &httpx.VSlimResponse {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel() or { return httpx.VSlimResponse.empty().boxed_snapshot() }
	return app.dispatch_request_facade(req)
}

fn (app &VSlimApp) dispatch_response_value(req &httpx.VSlimRequest) vphp.PhpValue {
	mut scope := vphp.PhpScope.request()
	app.prepare_kernel() or {
		scope.close()
		return vphp.PhpValue.null()
	}
	response := app.dispatch_request_facade(req)
	loggerx.cli_debug_log('dispatch.box before_leave status=${response.status} body_len=${response.body.len}')
	scope.close()
	loggerx.cli_debug_log('dispatch.box after_leave status=${response.status} body_len=${response.body.len}')
	return httpx.vslim_response_ref_to_value(response)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'handle')]
pub fn (app &VSlimApp) export_handle(request httpx.PsrServerRequest) &httpx.VSlimPsr7Response {
	return app.handle(request.to_object())
}

pub fn (app &VSlimApp) handle(request vphp.PhpObject) &httpx.VSlimPsr7Response {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel() or { return httpx.VSlimPsr7Response.text(500, '') }
	return app.dispatch_psr15_request_object(request)
}

pub fn (app &VSlimApp) handle_object(request vphp.PhpObject) &httpx.VSlimPsr7Response {
	return app.handle(request)
}

pub fn (app &VSlimApp) dispatch_envelope_raw(envelope vphp.PhpValue) &httpx.VSlimResponse {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel() or { return httpx.VSlimResponse.empty().boxed_snapshot() }
	req := httpx.VSlimRequest.from_value(envelope)
	return app.dispatch_request_facade(req)
}

@[vphp.PhpReturnType(php_type: 'VSlim\\VHttpd\\Response')]
@[vphp.PhpArgName(v_name: 'raw_path', php_name: 'rawPath')]
@[vphp.PhpExportMethod(name: '')]
pub fn (app &VSlimApp) dispatch(method string, raw_path string) vphp.PhpValue {
	req := httpx.VSlimRequest.new(method, raw_path, '')
	return app.dispatch_response_value(req)
}

@[vphp.PhpReturnType(php_type: 'VSlim\\VHttpd\\Response')]
@[vphp.PhpArgName(v_name: 'raw_path', php_name: 'rawPath')]
@[vphp.PhpExportMethod(name: 'dispatchBody')]
pub fn (app &VSlimApp) dispatch_body(method string, raw_path string, body string) vphp.PhpValue {
	req := httpx.VSlimRequest.new(method, raw_path, body)
	return app.dispatch_response_value(req)
}

@[vphp.PhpReturnType(php_type: 'VSlim\\VHttpd\\Response')]
@[vphp.PhpExportMethod(name: 'dispatchRequest')]
pub fn (app &VSlimApp) dispatch_request(req &httpx.VSlimRequest) vphp.PhpValue {
	return app.dispatch_response_value(req)
}

@[vphp.PhpReturnType(php_type: 'VSlim\\VHttpd\\Response')]
@[vphp.PhpExportMethod(name: 'dispatchEnvelope')]
pub fn (app &VSlimApp) dispatch_envelope(envelope vphp.PhpValue) vphp.PhpValue {
	req := httpx.VSlimRequest.from_value(envelope)
	return app.dispatch_response_value(req)
}

@[vphp.PhpExportMethod(name: 'dispatchEnvelopeWorker')]
pub fn (app &VSlimApp) dispatch_envelope_worker(envelope vphp.PhpValue) vphp.PhpValue {
	// The generated bridge owns the scope and copies the response to PHP before closing it.
	app.prepare_kernel() or { return vphp.PhpValue.null() }
	req := httpx.VSlimRequest.from_value(envelope)
	return app.dispatch_request_worker_value(req)
}

@[vphp.PhpExportMethod(name: 'dispatchEnvelopeMap')]
pub fn (app &VSlimApp) dispatch_envelope_map(envelope vphp.PhpValue) map[string]string {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel() or { return map[string]string{} }
	req := httpx.VSlimRequest.from_value(envelope)
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	return app.dispatch_kernel_envelope_map(req)
}

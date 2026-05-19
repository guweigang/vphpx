module main

import vphp

fn (app &VSlimApp) dispatch_request_facade(req &VSlimRequest) &VSlimResponse {
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	result := app.dispatch_kernel_request(req)
	unsafe {
		mut writable := &VSlimRequest(req)
		result.sync_request(mut writable)
	}
	if result.response_ref == unsafe { nil } {
		return (VSlimResponse{}).boxed_snapshot()
	}
	cli_debug_log('dispatch.facade result status=${result.response_ref.status} body_len=${result.response_ref.body.len}')
	return result.response_ref.boxed_snapshot_ref()
}

pub fn (app &VSlimApp) dispatch_raw(method string, raw_path string) &VSlimResponse {
	return app.dispatch_body_raw(method, raw_path, '')
}

pub fn (app &VSlimApp) dispatch_body_raw(method string, raw_path string, body string) &VSlimResponse {
	req := VSlimRequest.new(method, raw_path, body)
	return app.dispatch_request_raw(req)
}

pub fn (app &VSlimApp) dispatch_request_raw(req &VSlimRequest) &VSlimResponse {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel()
	return app.dispatch_request_facade(req)
}

fn (app &VSlimApp) dispatch_response_value(req &VSlimRequest) vphp.PhpValue {
	mut scope := vphp.PhpScope.request()
	app.prepare_kernel()
	response := app.dispatch_request_facade(req)
	cli_debug_log('dispatch.box before_leave status=${response.status} body_len=${response.body.len}')
	scope.close()
	cli_debug_log('dispatch.box after_leave status=${response.status} body_len=${response.body.len}')
	return response.build_response_value_ref()
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handle']
pub fn (app &VSlimApp) handle(request vphp.PhpObject) &VSlimPsr7Response {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel()
	return app.dispatch_psr15_request_object(request)
}

pub fn (app &VSlimApp) handle_object(request vphp.PhpObject) &VSlimPsr7Response {
	return app.handle(request)
}

pub fn (app &VSlimApp) dispatch_envelope_raw(envelope vphp.PhpValue) &VSlimResponse {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel()
	req := VSlimRequest.from_value(envelope)
	return app.dispatch_request_facade(req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_arg_name: 'raw_path=rawPath']
@[php_method]
pub fn (app &VSlimApp) dispatch(method string, raw_path string) vphp.PhpValue {
	req := VSlimRequest.new(method, raw_path, '')
	return app.dispatch_response_value(req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_arg_name: 'raw_path=rawPath']
@[php_method: 'dispatchBody']
pub fn (app &VSlimApp) dispatch_body(method string, raw_path string, body string) vphp.PhpValue {
	req := VSlimRequest.new(method, raw_path, body)
	return app.dispatch_response_value(req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_method: 'dispatchRequest']
pub fn (app &VSlimApp) dispatch_request(req &VSlimRequest) vphp.PhpValue {
	return app.dispatch_response_value(req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_method: 'dispatchEnvelope']
pub fn (app &VSlimApp) dispatch_envelope(envelope vphp.PhpValue) vphp.PhpValue {
	req := VSlimRequest.from_value(envelope)
	return app.dispatch_response_value(req)
}

@[php_method: 'dispatchEnvelopeWorker']
pub fn (app &VSlimApp) dispatch_envelope_worker(envelope vphp.PhpValue) vphp.PhpValue {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel()
	req := VSlimRequest.from_value(envelope)
	return app.dispatch_request_worker_value(req)
}

@[php_method: 'dispatchEnvelopeMap']
pub fn (app &VSlimApp) dispatch_envelope_map(envelope vphp.PhpValue) map[string]string {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app.prepare_kernel()
	req := VSlimRequest.from_value(envelope)
	prev_app := app.enter_runtime_dispatch()
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	return app.dispatch_kernel_envelope_map(req)
}

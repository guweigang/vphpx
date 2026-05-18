module main

import vphp

fn dispatch_request_facade(app &VSlimApp, req &VSlimRequest) &VSlimResponse {
	prev_app := enter_runtime_dispatch_app(app)
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	result := app_kernel_dispatch_request(app, req)
	unsafe {
		mut writable := &VSlimRequest(req)
		app_kernel_sync_dispatch_request(mut writable, result)
	}
	if result.response_ref == unsafe { nil } {
		return new_vslim_response_snapshot(VSlimResponse{})
	}
	cli_debug_log('dispatch.facade result status=${result.response_ref.status} body_len=${result.response_ref.body.len}')
	return new_vslim_response_snapshot_ref(result.response_ref)
}

pub fn (app &VSlimApp) dispatch_raw(method string, raw_path string) &VSlimResponse {
	return app.dispatch_body_raw(method, raw_path, '')
}

pub fn (app &VSlimApp) dispatch_body_raw(method string, raw_path string, body string) &VSlimResponse {
	req := new_vslim_request(method, raw_path, body)
	return app.dispatch_request_raw(req)
}

pub fn (app &VSlimApp) dispatch_request_raw(req &VSlimRequest) &VSlimResponse {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	return dispatch_request_facade(app, req)
}

fn dispatch_php_response_value(app &VSlimApp, req &VSlimRequest) vphp.PhpValue {
	mut scope := vphp.PhpScope.request()
	app_kernel_prepare(app)
	response := dispatch_request_facade(app, req)
	cli_debug_log('dispatch.box before_leave status=${response.status} body_len=${response.body.len}')
	scope.close()
	cli_debug_log('dispatch.box after_leave status=${response.status} body_len=${response.body.len}')
	return build_php_response_value_ref(response)
}

@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'handle']
pub fn (app &VSlimApp) handle(request vphp.PhpObject) &VSlimPsr7Response {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	return dispatch_app_psr15_request_object(app, request)
}

pub fn (app &VSlimApp) handle_object(request vphp.PhpObject) &VSlimPsr7Response {
	return app.handle(request)
}

pub fn (app &VSlimApp) dispatch_envelope_raw(envelope vphp.PhpValue) &VSlimResponse {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_value(envelope)
	return dispatch_request_facade(app, req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_arg_name: 'raw_path=rawPath']
@[php_method]
pub fn (app &VSlimApp) dispatch(method string, raw_path string) vphp.PhpValue {
	req := new_vslim_request(method, raw_path, '')
	return dispatch_php_response_value(app, req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_arg_name: 'raw_path=rawPath']
@[php_method: 'dispatchBody']
pub fn (app &VSlimApp) dispatch_body(method string, raw_path string, body string) vphp.PhpValue {
	req := new_vslim_request(method, raw_path, body)
	return dispatch_php_response_value(app, req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_method: 'dispatchRequest']
pub fn (app &VSlimApp) dispatch_request(req &VSlimRequest) vphp.PhpValue {
	return dispatch_php_response_value(app, req)
}

@[php_return_type: 'VSlim\\VHttpd\\Response']
@[php_method: 'dispatchEnvelope']
pub fn (app &VSlimApp) dispatch_envelope(envelope vphp.PhpValue) vphp.PhpValue {
	req := new_vslim_request_from_value(envelope)
	return dispatch_php_response_value(app, req)
}

@[php_method: 'dispatchEnvelopeWorker']
pub fn (app &VSlimApp) dispatch_envelope_worker(envelope vphp.PhpValue) vphp.PhpValue {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_value(envelope)
	return dispatch_app_request_worker_value(app, req)
}

@[php_method: 'dispatchEnvelopeMap']
pub fn (app &VSlimApp) dispatch_envelope_map(envelope vphp.PhpValue) map[string]string {
	mut scope := vphp.PhpScope.request()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_value(envelope)
	prev_app := enter_runtime_dispatch_app(app)
	defer {
		leave_runtime_dispatch_app(prev_app)
	}
	return app_kernel_dispatch_envelope_map(app, req)
}

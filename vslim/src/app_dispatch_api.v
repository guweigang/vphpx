module main

import vphp

fn dispatch_request_facade(app &VSlimApp, req &VSlimRequest) &VSlimResponse {
	result := app_kernel_dispatch_request(app, req)
	unsafe {
		mut writable := &VSlimRequest(req)
		app_kernel_sync_dispatch_request(mut writable, result)
	}
	return to_vslim_response(result.response)
}

@[php_method]
pub fn (app &VSlimApp) dispatch(method string, raw_path string) &VSlimResponse {
	return app.dispatch_body(method, raw_path, '')
}

@[php_method]
pub fn (app &VSlimApp) dispatch_body(method string, raw_path string, body string) &VSlimResponse {
	req := new_vslim_request(method, raw_path, body)
	return app.dispatch_request(req)
}

@[php_method]
pub fn (app &VSlimApp) dispatch_request(req &VSlimRequest) &VSlimResponse {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	return dispatch_request_facade(app, req)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'handle']
pub fn (app &VSlimApp) handle(request vphp.BorrowedValue) &VSlimPsr7Response {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	return dispatch_app_psr15_request(app, request.to_zval())
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope(envelope vphp.BorrowedValue) &VSlimResponse {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_zval(envelope.to_zval())
	return dispatch_request_facade(app, req)
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope_worker(envelope vphp.BorrowedValue) vphp.Value {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_zval(envelope.to_zval())
	return vphp.Value.from_zval(dispatch_app_request_worker(app, req))
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope_map(envelope vphp.BorrowedValue) map[string]string {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_zval(envelope.to_zval())
	return app_kernel_dispatch_envelope_map(app, req)
}

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
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	return dispatch_request_facade(app, req)
}

fn dispatch_php_response_box(app &VSlimApp, req &VSlimRequest) vphp.RequestOwnedZBox {
	mark := vphp.request_scope_enter()
	app_kernel_prepare(app)
	response := dispatch_request_facade(app, req)
	vphp.request_scope_leave(mark)
	return vphp.RequestOwnedZBox.adopt_zval(build_php_response_object_ref(response))
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_arg_type: 'request=Psr\\Http\\Message\\ServerRequestInterface']
@[php_method: 'handle']
pub fn (app &VSlimApp) handle(request vphp.RequestBorrowedZBox) &VSlimPsr7Response {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	return dispatch_app_psr15_request(app, request.to_zval())
}

pub fn (app &VSlimApp) dispatch_envelope_raw(envelope vphp.RequestBorrowedZBox) &VSlimResponse {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_zval(envelope.to_zval())
	return dispatch_request_facade(app, req)
}

@[php_return_type: 'VSlim\\Vhttpd\\Response']
@[php_method]
pub fn (app &VSlimApp) dispatch(method string, raw_path string) vphp.RequestOwnedZBox {
	req := new_vslim_request(method, raw_path, '')
	return dispatch_php_response_box(app, req)
}

@[php_return_type: 'VSlim\\Vhttpd\\Response']
@[php_method]
pub fn (app &VSlimApp) dispatch_body(method string, raw_path string, body string) vphp.RequestOwnedZBox {
	req := new_vslim_request(method, raw_path, body)
	return dispatch_php_response_box(app, req)
}

@[php_return_type: 'VSlim\\Vhttpd\\Response']
@[php_method]
pub fn (app &VSlimApp) dispatch_request(req &VSlimRequest) vphp.RequestOwnedZBox {
	return dispatch_php_response_box(app, req)
}

@[php_return_type: 'VSlim\\Vhttpd\\Response']
@[php_method]
pub fn (app &VSlimApp) dispatch_envelope(envelope vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	req := new_vslim_request_from_zval(envelope.to_zval())
	return dispatch_php_response_box(app, req)
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope_worker(envelope vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_zval(envelope.to_zval())
	return vphp.RequestOwnedZBox.adopt_zval(dispatch_app_request_worker(app, req))
}

@[php_method]
pub fn (app &VSlimApp) dispatch_envelope_map(envelope vphp.RequestBorrowedZBox) map[string]string {
	mut scope := vphp.request_scope()
	defer {
		scope.close()
	}
	app_kernel_prepare(app)
	req := new_vslim_request_from_zval(envelope.to_zval())
	return app_kernel_dispatch_envelope_map(app, req)
}

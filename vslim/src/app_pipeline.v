module main

import vphp

@[php_method]
pub fn (mut app VSlimApp) middleware(handler vphp.RequestBorrowedZBox) &VSlimApp {
	register_app_middleware_kind(mut app, handler.to_zval(), .standard)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) before(handler vphp.RequestBorrowedZBox) &VSlimApp {
	register_app_middleware_kind(mut app, handler.to_zval(), .before)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) after(handler vphp.RequestBorrowedZBox) &VSlimApp {
	register_app_middleware_kind(mut app, handler.to_zval(), .after)
	return app
}

@[php_method: 'setNotFoundHandler']
pub fn (mut app VSlimApp) set_not_found_handler(handler vphp.RequestBorrowedZBox) &VSlimApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'not_found handler must be callable',
			0)
		return app
	}
	app.not_found_handler = vphp.PersistentOwnedZBox.from_callable_zval(handler.to_zval())
	return app
}

pub fn (mut app VSlimApp) not_found(handler vphp.RequestBorrowedZBox) &VSlimApp {
	return app.set_not_found_handler(handler)
}

@[php_method: 'setErrorHandler']
pub fn (mut app VSlimApp) set_error_handler(handler vphp.RequestBorrowedZBox) &VSlimApp {
	if !handler.is_valid() || !handler.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'error handler must be callable',
			0)
		return app
	}
	app.error_handler = vphp.PersistentOwnedZBox.from_callable_zval(handler.to_zval())
	return app
}

@[php_method]
pub fn (mut app VSlimApp) error(handler vphp.RequestBorrowedZBox) &VSlimApp {
	return app.set_error_handler(handler)
}

@[php_method: 'setErrorResponseJson']
pub fn (mut app VSlimApp) set_error_response_json(enabled bool) &VSlimApp {
	app.error_response_json = enabled
	return app
}

@[php_method: 'errorResponseJsonEnabled']
pub fn (app &VSlimApp) error_response_json_enabled() bool {
	return app.error_response_json
}

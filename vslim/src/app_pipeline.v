module main

import vphp

@[php_method]
pub fn (mut app VSlimApp) middleware(handler vphp.PhpValue) &VSlimApp {
	app.register_middleware_kind(handler, .standard)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) before(handler vphp.PhpValue) &VSlimApp {
	app.register_middleware_kind(handler, .before)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) after(handler vphp.PhpValue) &VSlimApp {
	app.register_middleware_kind(handler, .after)
	return app
}

@[php_method: 'setNotFoundHandler']
pub fn (mut app VSlimApp) set_not_found_handler(handler vphp.PhpCallable) &VSlimApp {
	app.not_found_handler.release()
	app.not_found_handler = handler.retain()
	return app
}

pub fn (mut app VSlimApp) not_found(handler vphp.PhpCallable) &VSlimApp {
	return app.set_not_found_handler(handler)
}

@[php_method: 'setErrorHandler']
pub fn (mut app VSlimApp) set_error_handler(handler vphp.PhpCallable) &VSlimApp {
	app.error_handler.release()
	app.error_handler = handler.retain()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) error(handler vphp.PhpCallable) &VSlimApp {
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

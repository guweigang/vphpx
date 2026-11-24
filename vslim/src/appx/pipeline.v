module appx

import middlewarex
import vphp

@[vphp.PhpExportInterface(name: 'VSlim\\MiddlewareRegistrar')]
pub interface VMiddlewareRegistrar {
	middleware(handler vphp.PhpValue, options middlewarex.MiddlewareOptions) &VSlimApp
}

pub fn (mut app VSlimApp) middleware(handler vphp.PhpValue) &VSlimApp {
	return app.middleware_at_phase(handler, .standard)
}

@[vphp.PhpExportMethod(name: 'middleware')]
pub fn (mut app VSlimApp) export_middleware(handler vphp.PhpValue, options middlewarex.MiddlewareOptions) &VSlimApp {
	return app.middleware_at_phase(handler, options.phase)
}

pub fn (mut app VSlimApp) middleware_at_phase(handler vphp.PhpValue, phase middlewarex.MiddlewareRegistrationKind) &VSlimApp {
	app.register_middleware_kind(handler, phase)
	return app
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) before(handler vphp.PhpValue) &VSlimApp {
	return app.middleware_at_phase(handler, .before)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) after(handler vphp.PhpValue) &VSlimApp {
	return app.middleware_at_phase(handler, .after)
}

@[vphp.PhpExportMethod(name: 'setNotFoundHandler')]
pub fn (mut app VSlimApp) set_not_found_handler(handler vphp.PhpCallable) &VSlimApp {
	app.not_found_handler.release()
	app.not_found_handler = handler.retain()
	return app
}

pub fn (mut app VSlimApp) not_found(handler vphp.PhpCallable) &VSlimApp {
	return app.set_not_found_handler(handler)
}

@[vphp.PhpExportMethod(name: 'setErrorHandler')]
pub fn (mut app VSlimApp) set_error_handler(handler vphp.PhpCallable) &VSlimApp {
	app.error_handler.release()
	app.error_handler = handler.retain()
	return app
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) error(handler vphp.PhpCallable) &VSlimApp {
	return app.set_error_handler(handler)
}

@[vphp.PhpExportMethod(name: 'setErrorResponseJson')]
pub fn (mut app VSlimApp) set_error_response_json(enabled bool) &VSlimApp {
	app.error_response_json = enabled
	return app
}

@[vphp.PhpExportMethod(name: 'errorResponseJsonEnabled')]
pub fn (app &VSlimApp) error_response_json_enabled() bool {
	return app.error_response_json
}

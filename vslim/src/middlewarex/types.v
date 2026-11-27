module middlewarex

import httpx
import vphp

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Server\\RequestHandlerInterface')]
pub interface PsrRequestHandlerContract {}

pub type PsrRequestHandler = vphp.PhpInterface[PsrRequestHandlerContract]

@[vphp.PhpExportEnum(name: 'VSlim\\MiddlewarePhase')]
@[vphp.PhpUnitEnum]
pub enum MiddlewareRegistrationKind {
	standard
	before
	after
}

@[params]
pub struct MiddlewareOptions {
pub:
	phase MiddlewareRegistrationKind = .standard
}

pub fn registration_error(kind MiddlewareRegistrationKind) string {
	return match kind {
		.standard { 'middleware must be a PSR-15 middleware registration' }
		.before { 'before middleware must be a PSR-15 middleware registration' }
		.after { 'after middleware must be a PSR-15 middleware registration' }
	}
}

pub fn supports_registration(kind MiddlewareRegistrationKind, handler vphp.PhpValue) bool {
	return match kind {
		.standard { httpx.is_psr15_middleware_registration(handler) }
		.before, .after { httpx.is_psr15_middleware_registration(handler) }
	}
}

pub enum Psr15NextHandlerMode {
	middleware_chain
	fixed_response
	continue_marker
}

pub type Psr15NextDispatcher = fn (mut Psr15NextHandlerState, vphp.PhpObject) &httpx.VSlimPsr7Response

pub struct Psr15NextHandlerState {
pub mut:
	mode               Psr15NextHandlerMode     = .continue_marker
	chain_ref          &MiddlewareChain         = unsafe { nil }
	fixed_response_ref &httpx.VSlimPsr7Response = unsafe { nil }
	forwarded_request  vphp.PhpObject           = vphp.PhpObject.invalid()
	dispatcher         Psr15NextDispatcher      = unsafe { nil }
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\RequestHandlerInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr15\\NextHandler')]
@[heap]
pub struct VSlimPsr15NextHandler {
pub mut:
	state Psr15NextHandlerState
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\RequestHandlerInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr15\\ContinueHandler')]
@[heap]
pub struct VSlimPsr15ContinueHandler {
pub mut:
	state Psr15NextHandlerState
}

pub fn VSlimPsr15NextHandler.for_chain(chain &MiddlewareChain, dispatcher Psr15NextDispatcher) &VSlimPsr15NextHandler {
	return &VSlimPsr15NextHandler{
		state: Psr15NextHandlerState{
			mode:       .middleware_chain
			chain_ref:  chain
			dispatcher: dispatcher
		}
	}
}

pub fn VSlimPsr15NextHandler.fixed_response(res &httpx.VSlimPsr7Response) &VSlimPsr15NextHandler {
	return &VSlimPsr15NextHandler{
		state: Psr15NextHandlerState{
			mode:               .fixed_response
			fixed_response_ref: res
		}
	}
}

pub fn (handler &VSlimPsr15NextHandler) request_handler_object() vphp.PhpObject {
	mut value := vphp.bind_owned_object_value[VSlimPsr15NextHandler](handler)
	object := value.as_object() or {
		value.release()
		return vphp.PhpObject.invalid()
	}
	value.release()
	return object
}

pub fn fixed_response_request_handler_object(res &httpx.VSlimPsr7Response) vphp.PhpObject {
	return VSlimPsr15NextHandler.fixed_response(res).request_handler_object()
}

pub fn VSlimPsr15ContinueHandler.with_dispatcher(dispatcher Psr15NextDispatcher) &VSlimPsr15ContinueHandler {
	return &VSlimPsr15ContinueHandler{
		state: Psr15NextHandlerState{
			mode:       .continue_marker
			dispatcher: dispatcher
		}
	}
}

pub fn (handler &VSlimPsr15ContinueHandler) request_handler_object() vphp.PhpObject {
	mut value := vphp.bind_owned_object_value[VSlimPsr15ContinueHandler](handler)
	object := value.as_object() or {
		value.release()
		return vphp.PhpObject.invalid()
	}
	value.release()
	return object
}

pub fn (mut state Psr15NextHandlerState) dispatch_next(request vphp.PhpObject) &httpx.VSlimPsr7Response {
	if state.dispatcher != unsafe { nil } {
		return state.dispatcher(mut state, request)
	}
	return match state.mode {
		.fixed_response {
			if state.fixed_response_ref == unsafe { nil } {
				httpx.VSlimPsr7Response.text(500, 'Middleware fixed response is not available')
			} else {
				res := state.fixed_response_ref
				res.clone_with(res.get_protocol_version(), httpx.clone_header_values(res.headers),
					httpx.clone_header_names(res.header_names), res.body_ref,
					res.get_status_code(), res.get_reason_phrase())
			}
		}
		else {
			httpx.VSlimPsr7Response.text(500, 'Middleware next handler is not configured')
		}
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'handle')]
pub fn (handler &VSlimPsr15NextHandler) handle(request httpx.PsrServerRequest) &httpx.VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15NextHandler(handler)
		res := writable.state.dispatch_next(request.to_object())
		if res == nil {
			return httpx.VSlimPsr7Response.text(500, 'Middleware next handler returned null')
		}
		return res.clone_with(res.get_protocol_version(), httpx.clone_header_values(res.headers),
			httpx.clone_header_names(res.header_names), res.body_ref, res.get_status_code(),
			res.get_reason_phrase())
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'handle')]
pub fn (handler &VSlimPsr15ContinueHandler) handle(request httpx.PsrServerRequest) &httpx.VSlimPsr7Response {
	unsafe {
		mut writable := &VSlimPsr15ContinueHandler(handler)
		res := writable.state.dispatch_next(request.to_object())
		if res == nil {
			return httpx.VSlimPsr7Response.text(500, 'Middleware continue handler returned null')
		}
		return res.clone_with(res.get_protocol_version(), httpx.clone_header_values(res.headers),
			httpx.clone_header_names(res.header_names), res.body_ref, res.get_status_code(),
			res.get_reason_phrase())
	}
}

pub fn (mut handler VSlimPsr15ContinueHandler) cleanup() {
	handler.state.forwarded_request.release()
}

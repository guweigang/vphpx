module routex

import httpx
import vphp

pub type VSlimHandler = fn (httpx.VSlimRequest) httpx.VSlimResponse

pub type VSlimNext = fn (httpx.VSlimRequest) httpx.VSlimResponse

pub type VSlimMiddleware = fn (httpx.VSlimRequest, VSlimNext) httpx.VSlimResponse

pub enum VSlimRouteHandlerType {
	native
	php_callable
}

pub struct VSlimRoute {
pub mut:
	method                   string
	name                     string
	pattern                  string
	handler_type             VSlimRouteHandlerType
	v_handler                VSlimHandler  = unsafe { nil }
	handler_ref              vphp.PhpValue = vphp.PhpValue.invalid()
	resource_action          string
	resource_missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
}

pub struct VSlimRuntime {
mut:
	routes      []VSlimRoute
	middlewares []VSlimMiddleware
}

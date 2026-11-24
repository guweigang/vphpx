module middlewarex

import httpx
import vphp

pub type TerminalHandler = fn (voidptr, PipelineRequestContext, RawDispatchPlan) !vphp.PhpValue
pub type ErrorHandler = fn (voidptr, PipelineRequestContext, string) &httpx.VSlimPsr7Response
pub type MiddlewareExecutor = fn (voidptr, &MiddlewareChain, vphp.PhpValue, vphp.PhpValue) !vphp.PhpValue

@[heap]
pub struct MiddlewareChain {
pub:
	app_ctx     voidptr
	request_ctx PipelineRequestContext
	on_terminal TerminalHandler    = unsafe { nil }
	on_error    ErrorHandler       = unsafe { nil }
	on_execute  MiddlewareExecutor = unsafe { nil }
pub mut:
	middlewares       []vphp.PhpValue
	plan              RawDispatchPlan
	index             int
	forwarded_request vphp.PhpObject = vphp.PhpObject.invalid()
}

pub fn (chain &MiddlewareChain) build_psr15_next_handler_object(dispatcher Psr15NextDispatcher) vphp.PhpObject {
	return VSlimPsr15NextHandler.for_chain(chain, dispatcher).request_handler_object()
}

pub fn (mut chain MiddlewareChain) dispatch(payload vphp.PhpValue) !vphp.PhpValue {
	chain.forwarded_request.release()
	chain.forwarded_request = httpx.normalize_psr15_server_request(payload, chain.request_ctx.route_params)
	return chain.dispatch_current(payload)
}

pub fn (mut chain MiddlewareChain) dispatch_pre_normalized(payload vphp.PhpValue) !vphp.PhpValue {
	if normalized := payload.as_object() {
		chain.forwarded_request.release()
		chain.forwarded_request = normalized.owned()
	}
	return chain.dispatch_current(payload)
}

fn (mut chain MiddlewareChain) dispatch_current(payload vphp.PhpValue) !vphp.PhpValue {
	effective_ctx := chain.request_ctx.with_payload_value(payload)
	if chain.index >= chain.middlewares.len {
		return chain.on_terminal(chain.app_ctx, effective_ctx, chain.plan)!
	}
	mw := chain.middlewares[chain.index]
	chain.index++
	if !mw.is_valid() || mw.is_null() || mw.is_undef() {
		return error('Middleware is not valid')
	}
	response := chain.on_execute(chain.app_ctx, chain, mw, payload)!
	if !response.is_valid() || response.is_null() || response.is_undef() {
		return error('Middleware must return a response')
	}
	return response
}

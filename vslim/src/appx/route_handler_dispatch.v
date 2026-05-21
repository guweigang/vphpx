module appx

import httpx
import loggerx
import liveviewx
import middlewarex
import routex
import supportx
import vphp

fn (app &VSlimApp) resolve_middleware_target(handler vphp.PhpValue) !(vphp.PhpValue, string) {
	if !handler.is_valid() {
		return error('Middleware is not valid')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Middleware container is not configured')
		}
		return app.resolve_container_service(handler.to_string())!, ''
	}
	if handler.is_array() {
		if !app.has_container() {
			return error('Middleware container is not configured')
		}
		parts := handler.to_string_list()
		if parts.len == 0 || parts[0] == '' {
			return error('Invalid middleware container array handler')
		}
		service := app.resolve_container_service(parts[0])!
		method := if parts.len >= 2 { parts[1] } else { '' }
		return service, method
	}
	return handler, ''
}

fn (app &VSlimApp) resolve_phase_middleware_target(handler vphp.PhpValue) !vphp.PhpValue {
	target, explicit_method := app.resolve_middleware_target(handler)!
	if !middlewarex.is_phase_middleware_target(target, explicit_method) {
		return error('Phase middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
	}
	return target
}

fn (app &VSlimApp) resolve_route_target(handler vphp.PhpValue) !(vphp.PhpValue, string) {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() {
		if !app.has_container() {
			return error('Route handler container is not configured')
		}
		target_value := app.resolve_container_service(handler.to_string())!
		if !target_value.is_object() {
			return error('Route handler service "${handler.to_string()}" must be an object')
		}
		if target_value.is_instance_of('Psr\\Http\\Server\\RequestHandlerInterface') {
			return target_value, 'handle'
		}
		return error('Route handler service "${handler.to_string()}" must implement Psr\\Http\\Server\\RequestHandlerInterface')
	}
	if handler.is_array() {
		if !app.has_container() {
			return error('Route handler container is not configured')
		}
		parts := handler.to_string_list()
		if parts.len != 2 || parts[0] == '' || parts[1].trim_space() == '' {
			return error('Route handler array must be ["service", "method"]')
		}
		target_value := app.resolve_container_service(parts[0])!
		routex.validate_route_service_method(target_value, parts[0], parts[1])!
		return target_value, parts[1]
	}
	return handler, ''
}

fn (app &VSlimApp) bind_route_target_if_supported(target vphp.PhpValue) {
	target_obj := target.as_object() or { return }
	if target_obj.is_instance_of('Psr\\Http\\Server\\MiddlewareInterface') {
		// Cached middleware instances should be bound once at registration or
		// first construction, not rebound on every dispatch.
		return
	}
	mut app_value := app.self_value()
	defer {
		app_value.release()
	}
	supportx.bind_to_app(target, app_value)
}

fn (mut chain MiddlewareChain) dispatch_entry(handler vphp.PhpValue, payload vphp.PhpValue) !vphp.PhpValue {
	target, explicit_method := chain.app.resolve_middleware_target(handler) or {
		loggerx.cli_debug_log('middleware.target.resolve.error msg=${err.msg()} handler_valid=${handler.is_valid()} handler_kind=${handler.kind_name()}')
		return err
	}
	chain.app.bind_route_target_if_supported(target)
	method := httpx.psr15_middleware_target_method(target, explicit_method)
	if middlewarex.is_phase_middleware_target(target, explicit_method) {
		mut psr_payload := httpx.normalize_psr15_server_request(payload,
			chain.request_ctx.route_params)
		defer {
			psr_payload.release()
		}
		mut next_handler := (&chain).build_psr15_next_handler_object()
		if !next_handler.is_valid() {
			return error('Next handler object could not be created')
		}
		defer {
			next_handler.release()
		}
		mut result := middlewarex.dispatch_phase_process(target, psr_payload, next_handler)!
		defer {
			result.release()
		}
		normalized := httpx.VSlimPsr7Response.from_value(result)
		return httpx.vslim_response_to_value(normalized.to_vslim_response())
	}
	loggerx.cli_debug_log('middleware.target.invalid method=${method} target_valid=${target.is_valid()} target_kind=${target.kind_name()} target_class=${target.class_name()}')
	return error('Middleware must implement Psr\\Http\\Server\\MiddlewareInterface')
}

fn (app &VSlimApp) dispatch_route_handler(handler vphp.PhpValue, payload vphp.PhpValue, route_params map[string]string) !vphp.PhpValue {
	if !handler.is_valid() {
		return error('Invalid route handler')
	}
	if handler.is_string() || handler.is_array() {
		target, method := app.resolve_route_target(handler)!
		app.bind_route_target_if_supported(target)
		mut psr_payload := httpx.normalize_psr15_server_request(payload, route_params)
		defer {
			psr_payload.release()
		}
		mut route_args := []vphp.PhpArgInput{}
		route_args << psr_payload
		mut result := routex.call_route_target_method(target, method, route_args)
		return routex.route_handler_response(result)
	}
	if httpx.is_psr15_request_handler(handler) {
		mut psr_payload := httpx.normalize_psr15_server_request(payload, route_params)
		defer {
			psr_payload.release()
		}
		return routex.call_psr_request_handler(handler, psr_payload)!
	}
	mut psr_payload := httpx.normalize_psr15_server_request(payload, route_params)
	defer {
		psr_payload.release()
	}
	if callable := handler.as_callable() {
		mut result := callable.invoke(psr_payload)
		return routex.route_handler_response(result)
	}
	if handler_obj := handler.as_object() {
		if httpx.is_psr15_request_handler_like_object(handler_obj) {
			return error('Route handler object must implement Psr\\Http\\Server\\RequestHandlerInterface')
		}
		if liveviewx.is_live_route_handler_object(handler_obj) {
			effective_payload := if httpx.is_psr_server_request_payload(payload) {
				httpx.legacy_middleware_payload(payload, route_params)
			} else {
				payload.owned()
			}
			defer {
				effective_payload.release()
			}
			return liveviewx.dispatch_live_route_handler(handler_obj, effective_payload)!
		}
	}
	return error('Route handler is not callable')
}

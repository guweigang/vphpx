module main

import vphp

pub fn VSlimRuntime.new() VSlimRuntime {
	return VSlimRuntime{}
}

pub fn (mut app VSlimRuntime) use(mw VSlimMiddleware) {
	app.middlewares << mw
}

pub fn (mut app VSlimRuntime) get(pattern string, handler VSlimHandler) {
	app.routes << VSlimRoute{
		method: 'GET'
		pattern: pattern
		handler_type: .native
		v_handler: handler
		handler_ref: vphp.PhpValue.invalid()
	}
}

pub fn (mut app VSlimRuntime) post(pattern string, handler VSlimHandler) {
	app.routes << VSlimRoute{
		method: 'POST'
		pattern: pattern
		handler_type: .native
		v_handler: handler
		handler_ref: vphp.PhpValue.invalid()
	}
}

pub fn (mut app VSlimRuntime) put(pattern string, handler VSlimHandler) {
	app.routes << VSlimRoute{
		method: 'PUT'
		pattern: pattern
		handler_type: .native
		v_handler: handler
		handler_ref: vphp.PhpValue.invalid()
	}
}

pub fn (mut app VSlimRuntime) patch(pattern string, handler VSlimHandler) {
	app.routes << VSlimRoute{
		method: 'PATCH'
		pattern: pattern
		handler_type: .native
		v_handler: handler
		handler_ref: vphp.PhpValue.invalid()
	}
}

pub fn (mut app VSlimRuntime) delete(pattern string, handler VSlimHandler) {
	app.routes << VSlimRoute{
		method: 'DELETE'
		pattern: pattern
		handler_type: .native
		v_handler: handler
		handler_ref: vphp.PhpValue.invalid()
	}
}

pub fn (mut app VSlimRuntime) any(pattern string, handler VSlimHandler) {
	app.routes << VSlimRoute{
		method: '*'
		pattern: pattern
		handler_type: .native
		v_handler: handler
		handler_ref: vphp.PhpValue.invalid()
	}
}

pub fn (app VSlimRuntime) dispatch(req VSlimRequest) VSlimResponse {
	return app.run_middleware(0, req)
}

fn (app VSlimRuntime) run_middleware(index int, req VSlimRequest) VSlimResponse {
	if index >= app.middlewares.len {
		return app.dispatch_route(req)
	}
	mw := app.middlewares[index]
	next := fn [app, index] (r VSlimRequest) VSlimResponse {
		return app.run_middleware(index + 1, r)
	}
	return mw(req, next)
}

fn (app VSlimRuntime) dispatch_route(req VSlimRequest) VSlimResponse {
	method := req.method.to_upper()
	path := RoutePath.normalize(req.path_value())
	mut method_not_allowed := false

	for route in app.routes {
		ok, params := route.matches(path)
		if !ok {
			continue
		}
		if route.method != '*' && route.method != method {
			method_not_allowed = true
			continue
		}
		mut bound_snapshot := req.snapshot()
		mut bound := &bound_snapshot
		bound.params = snapshot_string_map(params)
		return route.v_handler(bound)
	}

	if method_not_allowed {
		return VSlimResponse.method_not_allowed()
	}
	return VSlimResponse.not_found()
}

fn (req VSlimRequest) with_trace_id(next VSlimNext) VSlimResponse {
	mut out := req
	if out.query['trace_id'] == '' {
		out.query['trace_id'] = 'trace-local-mvp'
	}
	return next(out)
}

fn (req VSlimRequest) auth_guard(next VSlimNext) VSlimResponse {
	if req.path_value() == '/private' {
		token := req.query['token'] or { '' }
		if token != 'ok' {
			return VSlimResponse.text(401, 'Unauthorized')
		}
	}
	return next(req)
}

fn (req VSlimRequest) health_response() VSlimResponse {
	_ = req
	return VSlimResponse.text(200, 'OK')
}

fn (req VSlimRequest) user_response() VSlimResponse {
	user_id := req.params['id'] or { 'unknown' }
	trace_id := req.query['trace_id'] or { '' }
	return VSlimResponse.json(200, '{"user":"${user_id}","trace":"${trace_id}"}')
}

fn (req VSlimRequest) private_response() VSlimResponse {
	_ = req
	return VSlimResponse.text(200, 'secret')
}

fn (req VSlimRequest) panic_response() VSlimResponse {
	_ = req
	return VSlimResponse.internal_error()
}

fn (req VSlimRequest) meta_response() VSlimResponse {
	trace_id := req.query['trace_id'] or { '' }
	return VSlimResponse.json(200, '{"runtime":"vslim","bridge":"vphp","server":"vhttpd","trace":"${trace_id}"}')
}

fn VSlimRuntime.demo() VSlimRuntime {
	mut app := VSlimRuntime.new()
	app.use(fn (req VSlimRequest, next VSlimNext) VSlimResponse {
		return req.with_trace_id(next)
	})
	app.use(fn (req VSlimRequest, next VSlimNext) VSlimResponse {
		return req.auth_guard(next)
	})
	app.get('/health', fn (req VSlimRequest) VSlimResponse {
		return req.health_response()
	})
	app.get('/users/:id', fn (req VSlimRequest) VSlimResponse {
		return req.user_response()
	})
	app.get('/private', fn (req VSlimRequest) VSlimResponse {
		return req.private_response()
	})
	app.get('/panic', fn (req VSlimRequest) VSlimResponse {
		return req.panic_response()
	})
	app.get('/meta', fn (req VSlimRequest) VSlimResponse {
		return req.meta_response()
	})
	return app
}

fn (req VSlimRequest) dispatch_demo() VSlimResponse {
	mut app := VSlimRuntime.demo()
	return app.dispatch(req)
}

fn (req VSlimRequest) dispatch_demo_with_params() (VSlimResponse, map[string]string) {
	mut app := VSlimRuntime.demo()
	method := req.method.to_upper()
	path := RoutePath.normalize(req.path_value())
	mut method_not_allowed := false
	for route in app.routes {
		ok, params := route.matches(path)
		if !ok {
			continue
		}
		if route.method != method {
			method_not_allowed = true
			continue
		}
		mut bound_snapshot := req.snapshot()
		mut bound := &bound_snapshot
		bound.params = snapshot_string_map(params)
		return app.run_middleware(0, bound), params
	}
	if method_not_allowed {
		return VSlimResponse.method_not_allowed(), map[string]string{}
	}
	return VSlimResponse.not_found(), map[string]string{}
}

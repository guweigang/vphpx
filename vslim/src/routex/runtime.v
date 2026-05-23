module routex

import httpx
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

pub fn (app VSlimRuntime) dispatch(req httpx.VSlimRequest) httpx.VSlimResponse {
	return app.run_middleware(0, req)
}

fn (app VSlimRuntime) run_middleware(index int, req httpx.VSlimRequest) httpx.VSlimResponse {
	if index >= app.middlewares.len {
		return app.dispatch_route(req)
	}
	mw := app.middlewares[index]
	next := fn [app, index] (r httpx.VSlimRequest) httpx.VSlimResponse {
		return app.run_middleware(index + 1, r)
	}
	return mw(req, next)
}

fn (app VSlimRuntime) dispatch_route(req httpx.VSlimRequest) httpx.VSlimResponse {
	method := req.method.to_upper()
	path := httpx.Path.normalize(req.path_value())
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
		bound.params = httpx.snapshot_string_map(params)
		return route.v_handler(bound)
	}

	if method_not_allowed {
		return httpx.VSlimResponse.method_not_allowed()
	}
	return httpx.VSlimResponse.not_found()
}

fn vslim_demo_with_trace_id(req httpx.VSlimRequest, next VSlimNext) httpx.VSlimResponse {
	mut out := req
	if out.query['trace_id'] == '' {
		out.query['trace_id'] = 'trace-local-mvp'
	}
	return next(out)
}

fn vslim_demo_auth_guard(req httpx.VSlimRequest, next VSlimNext) httpx.VSlimResponse {
	if req.path_value() == '/private' {
		token := req.query['token'] or { '' }
		if token != 'ok' {
			return httpx.VSlimResponse.text(401, 'Unauthorized')
		}
	}
	return next(req)
}

fn vslim_demo_health_response(req httpx.VSlimRequest) httpx.VSlimResponse {
	_ = req
	return httpx.VSlimResponse.text(200, 'OK')
}

fn vslim_demo_user_response(req httpx.VSlimRequest) httpx.VSlimResponse {
	user_id := req.params['id'] or { 'unknown' }
	trace_id := req.query['trace_id'] or { '' }
	return httpx.VSlimResponse.json(200, '{"user":"${user_id}","trace":"${trace_id}"}')
}

fn vslim_demo_private_response(req httpx.VSlimRequest) httpx.VSlimResponse {
	_ = req
	return httpx.VSlimResponse.text(200, 'secret')
}

fn vslim_demo_panic_response(req httpx.VSlimRequest) httpx.VSlimResponse {
	_ = req
	return httpx.VSlimResponse.internal_error()
}

fn vslim_demo_meta_response(req httpx.VSlimRequest) httpx.VSlimResponse {
	trace_id := req.query['trace_id'] or { '' }
	return httpx.VSlimResponse.json(200, '{"runtime":"vslim","bridge":"vphp","server":"vhttpd","trace":"${trace_id}"}')
}

fn VSlimRuntime.demo() VSlimRuntime {
	mut app := VSlimRuntime.new()
	app.use(fn (req httpx.VSlimRequest, next VSlimNext) httpx.VSlimResponse {
		return vslim_demo_with_trace_id(req, next)
	})
	app.use(fn (req httpx.VSlimRequest, next VSlimNext) httpx.VSlimResponse {
		return vslim_demo_auth_guard(req, next)
	})
	app.get('/health', fn (req httpx.VSlimRequest) httpx.VSlimResponse {
		return vslim_demo_health_response(req)
	})
	app.get('/users/:id', fn (req httpx.VSlimRequest) httpx.VSlimResponse {
		return vslim_demo_user_response(req)
	})
	app.get('/private', fn (req httpx.VSlimRequest) httpx.VSlimResponse {
		return vslim_demo_private_response(req)
	})
	app.get('/panic', fn (req httpx.VSlimRequest) httpx.VSlimResponse {
		return vslim_demo_panic_response(req)
	})
	app.get('/meta', fn (req httpx.VSlimRequest) httpx.VSlimResponse {
		return vslim_demo_meta_response(req)
	})
	return app
}

pub fn dispatch_demo(req httpx.VSlimRequest) httpx.VSlimResponse {
	mut app := VSlimRuntime.demo()
	return app.dispatch(req)
}

pub fn dispatch_demo_with_params(req httpx.VSlimRequest) (httpx.VSlimResponse, map[string]string) {
	mut app := VSlimRuntime.demo()
	method := req.method.to_upper()
	path := httpx.Path.normalize(req.path_value())
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
		bound.params = httpx.snapshot_string_map(params)
		return app.run_middleware(0, bound), params
	}
	if method_not_allowed {
		return httpx.VSlimResponse.method_not_allowed(), map[string]string{}
	}
	return httpx.VSlimResponse.not_found(), map[string]string{}
}

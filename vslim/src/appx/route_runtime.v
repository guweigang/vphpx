module appx

import routex
import vphp
import websocketx

@[vphp.PhpExportMethod(name: 'handleWebSocket')]
pub fn (mut app VSlimApp) handle_websocket(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	route_frame := websocketx.select_route_frame(mut app.websocket_conn_route, app.websocket_routes,
		frame)
	mut result := if route_frame.should_reject_open() {
		mut rejected := vphp.PhpBool.of(false)
		rejected.take_value()
	} else if route_frame.should_dispatch() {
		response := app.dispatch_websocket_route_handler(route_frame.index, route_frame.event,
			frame, conn)
		websocketx.finish_route_frame(mut app.websocket_conn_route, route_frame, response, conn)
		response
	} else {
		vphp.PhpValue.null()
	}
	return result.move_to_request_scope()
}

@[vphp.PhpExportMethod(name: 'routeCount')]
pub fn (app &VSlimApp) route_count() int {
	return app.routes.len
}

@[vphp.PhpExportMethod(name: 'routeNames')]
pub fn (app &VSlimApp) route_names() []string {
	return app.route_index.names()
}

@[vphp.PhpExportMethod(name: 'hasRouteName')]
pub fn (app &VSlimApp) has_route_name(name string) bool {
	return app.route_index.index_for_name(name) != none
}

@[vphp.PhpExportMethod(name: 'routeManifestLines')]
pub fn (app &VSlimApp) route_manifest_lines() []string {
	return routex.route_manifest_lines(app.routes)
}

@[vphp.PhpExportMethod(name: 'routeConflictKeys')]
pub fn (app &VSlimApp) route_conflict_keys() []string {
	return routex.route_conflict_keys(app.routes)
}

@[vphp.PhpExportMethod(name: 'routeManifest')]
pub fn (app &VSlimApp) route_manifest() []map[string]string {
	return routex.route_manifest(app.routes)
}

@[vphp.PhpExportMethod(name: 'routeConflicts')]
pub fn (app &VSlimApp) route_conflicts() []map[string]string {
	return routex.route_conflicts(app.routes)
}

@[vphp.PhpExportMethod(name: 'allowedMethodsFor')]
@[vphp.PhpArgName(v_name: 'raw_path', php_name: 'rawPath')]
pub fn (app &VSlimApp) allowed_methods_for(raw_path string) []string {
	return app.route_index.allowed_methods_for(app.routes, raw_path)
}

fn (mut app VSlimApp) add_route(method string, name string, pattern string, handler vphp.PhpValue) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.add_route_with_resource_meta(method, name, pattern, handler, '', vphp.PhpCallable.invalid())
}

fn (mut app VSlimApp) add_websocket_route(name string, pattern string, handler vphp.PhpValue) {
	if !websocketx.is_supported_handler_value(handler) {
		return
	}
	app.track_registration()
	if state := vphp.owned_object_php_state(app) {
		state.set_value(RegistrationValues.websockets.state_key(app.websocket_routes.len), handler)
		app.websocket_routes << routex.VSlimRoute.websocket(name, pattern, vphp.PhpValue.invalid())
		return
	}
	app.websocket_routes << routex.VSlimRoute.websocket(name, pattern, handler)
}

pub fn (mut app VSlimApp) init_php_state() {
	state := vphp.owned_object_php_state(app) or { return }
	if app.container_ref != unsafe { nil } {
		app.bind_container_state(state)
	}
	for index, mut route in app.routes {
		if route.handler_ref.is_valid() {
			state.set_value(RegistrationValues.routes.state_key(index), route.handler_ref)
			route.handler_ref.release()
		}
		if route.resource_missing_handler.is_valid() {
			state.set_callable(RegistrationValues.resource_missing.state_key(index),
				route.resource_missing_handler)
			route.resource_missing_handler.release()
		}
	}
	for index, mut route in app.websocket_routes {
		if route.handler_ref.is_valid() {
			state.set_value(RegistrationValues.websockets.state_key(index), route.handler_ref)
			route.handler_ref.release()
		}
	}
	move_registration_values(state, .before, mut app.before_middlewares)
	move_registration_values(state, .middleware, mut app.middlewares)
	move_registration_values(state, .after, mut app.after_middlewares)
	move_registration_values(state, .group_before, mut app.group_before_middle.handlers)
	move_registration_values(state, .group_middle, mut app.group_middle.handlers)
	move_registration_values(state, .group_after, mut app.group_after_middle.handlers)
}

fn (mut app VSlimApp) add_route_with_resource_meta(method string, name string, pattern string, handler vphp.PhpValue, resource_action string, resource_missing_handler vphp.PhpCallable) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.track_registration()
	app.route_index.add(pattern, name)
	if state := vphp.owned_object_php_state(app) {
		index := app.routes.len
		state.set_value(RegistrationValues.routes.state_key(index), handler)
		if resource_missing_handler.is_valid() {
			state.set_callable(RegistrationValues.resource_missing.state_key(index),
				resource_missing_handler)
		}
		app.routes << routex.VSlimRoute.with_resource_meta(method, name, pattern,
			vphp.PhpValue.invalid(), resource_action, vphp.PhpCallable.invalid())
		return
	}
	app.routes << routex.VSlimRoute.with_resource_meta(method, name, pattern, handler,
		resource_action, resource_missing_handler)
}

fn (app &VSlimApp) dispatch_websocket_route_handler(index int, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	mut handler_value := app.registration_value(.websockets, index, app.websocket_routes[index].handler_ref).owned()
	defer {
		handler_value.release()
	}
	if !handler_value.is_valid() {
		return vphp.PhpValue.null()
	}
	if websocketx.is_live_handler_value(handler_value) {
		unsafe {
			mut mutable_app := &VSlimApp(app)
			return mutable_app.dispatch_live_websocket_handler(handler_value, event, frame, conn)
		}
	}
	if handler_value.is_object() || handler_value.is_callable() {
		return websocketx.dispatch_handler_value(handler_value, event, frame, conn)
	}
	if handler_value.is_string() && app.has_container() {
		mut service := app.resolve_container_service(handler_value.to_string()) or {
			return vphp.PhpValue.null()
		}
		defer {
			service.release()
		}
		return websocketx.dispatch_service_handler(service, '', event, frame, conn)
	}
	if mut handler_array := handler_value.as_array() {
		defer {
			handler_array.release()
		}
		if !app.has_container() {
			return vphp.PhpValue.null()
		}
		parts := handler_array.to_string_list()
		if parts.len >= 1 && parts[0] != '' {
			mut service := app.resolve_container_service(parts[0]) or { return vphp.PhpValue.null() }
			defer {
				service.release()
			}
			method := if parts.len == 2 { parts[1] } else { '' }
			return websocketx.dispatch_service_handler(service, method, event, frame, conn)
		}
	}
	return vphp.PhpValue.null()
}

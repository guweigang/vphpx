module appx

import routex
import vphp
import websocketx

@[vphp.PhpExportMethod(name: 'handleWebSocket')]
pub fn (mut app VSlimApp) handle_websocket(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	route_frame := websocketx.select_route_frame(mut app.websocket_conn_route, app.websocket_routes,
		frame)
	if route_frame.should_reject_open() {
		mut rejected := vphp.PhpBool.of(false)
		return rejected.take_value()
	}
	if !route_frame.should_dispatch() {
		return vphp.PhpValue.null()
	}
	result := app.dispatch_websocket_route_handler(app.websocket_routes[route_frame.index],
		route_frame.event, frame, conn)
	websocketx.finish_route_frame(mut app.websocket_conn_route, route_frame)
	return result
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
	app.websocket_routes << routex.VSlimRoute.websocket(name, pattern, handler)
}

fn (mut app VSlimApp) add_route_with_resource_meta(method string, name string, pattern string, handler vphp.PhpValue, resource_action string, resource_missing_handler vphp.PhpCallable) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.track_registration()
	app.route_index.add(pattern, name)
	app.routes << routex.VSlimRoute.with_resource_meta(method, name, pattern, handler,
		resource_action, resource_missing_handler)
}

fn (app &VSlimApp) dispatch_websocket_route_handler(route routex.VSlimRoute, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	mut handler_value := route.handler_ref.owned()
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
		service := app.resolve_container_service(handler_value.to_string()) or {
			return vphp.PhpValue.null()
		}
		return websocketx.dispatch_service_handler(service, '', event, frame, conn)
	}
	if handler_array := handler_value.as_array() {
		if !app.has_container() {
			return vphp.PhpValue.null()
		}
		parts := handler_array.to_string_list()
		if parts.len >= 1 && parts[0] != '' {
			service := app.resolve_container_service(parts[0]) or { return vphp.PhpValue.null() }
			method := if parts.len == 2 { parts[1] } else { '' }
			return websocketx.dispatch_service_handler(service, method, event, frame, conn)
		}
	}
	return vphp.PhpValue.null()
}

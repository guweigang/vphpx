module main

import vphp

@[php_method: 'handleWebSocket']
pub fn (mut app VSlimApp) handle_websocket(frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	event := frame.string_at('event', '').trim_space().to_lower()
	conn_id := frame.string_at('id', '').trim_space()
	if event == '' || conn_id == '' {
		return vphp.PhpValue.null()
	}
	path := RoutePath.normalize(frame.string_at('path', '/'))
	if event == 'open' {
		idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.PhpBool.of(false).take_value()
		}
		app.websocket_conn_route[conn_id] = idx
		return app.dispatch_websocket_route_handler(app.websocket_routes[idx], event, frame, conn)
	}
	idx := app.websocket_conn_route[conn_id] or {
		fallback_idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.PhpValue.null()
		}
		app.websocket_conn_route[conn_id] = fallback_idx
		return app.dispatch_websocket_route_handler(app.websocket_routes[fallback_idx], event,
			frame, conn)
	}
	if idx < 0 || idx >= app.websocket_routes.len {
		app.websocket_conn_route.delete(conn_id)
		fallback_idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.PhpValue.null()
		}
		app.websocket_conn_route[conn_id] = fallback_idx
		result := app.dispatch_websocket_route_handler(app.websocket_routes[fallback_idx], event,
			frame, conn)
		if event == 'close' {
			app.websocket_conn_route.delete(conn_id)
		}
		return result
	}
	result := app.dispatch_websocket_route_handler(app.websocket_routes[idx], event, frame, conn)
	if event == 'close' {
		app.websocket_conn_route.delete(conn_id)
	}
	return result
}

@[php_method: 'routeCount']
pub fn (app &VSlimApp) route_count() int {
	return app.routes.len
}

@[php_method: 'routeNames']
pub fn (app &VSlimApp) route_names() []string {
	mut out := []string{}
	for route in app.routes {
		if route.name == '' {
			continue
		}
		if route.name !in out {
			out << route.name
		}
	}
	return out
}

@[php_method: 'hasRouteName']
pub fn (app &VSlimApp) has_route_name(name string) bool {
	for route in app.routes {
		if route.name == name {
			return true
		}
	}
	return false
}

@[php_method: 'routeManifestLines']
pub fn (app &VSlimApp) route_manifest_lines() []string {
	mut out := []string{cap: app.routes.len}
	for route in app.routes {
		mut line := '${route.method} ${route.pattern}'
		if route.name != '' {
			line += ' #${route.name}'
		}
		out << line
	}
	return out
}

@[php_method: 'routeConflictKeys']
pub fn (app &VSlimApp) route_conflict_keys() []string {
	mut grouped := map[string]int{}
	for route in app.routes {
		key := '${route.method} ${route.pattern}'
		grouped[key] = (grouped[key] or { 0 }) + 1
	}
	mut out := []string{}
	for key, count in grouped {
		if count > 1 {
			out << '${key} x${count}'
		}
	}
	out.sort()
	return out
}

@[php_method: 'routeManifest']
pub fn (app &VSlimApp) route_manifest() []map[string]string {
	mut out := []map[string]string{cap: app.routes.len}
	for route in app.routes {
		out << {
			'method':       route.method
			'name':         route.name
			'pattern':      route.pattern
			'handler_type': route.handler_type.str()
		}
	}
	return out
}

@[php_method: 'routeConflicts']
pub fn (app &VSlimApp) route_conflicts() []map[string]string {
	mut grouped := map[string][]VSlimRoute{}
	for route in app.routes {
		key := '${route.method} ${route.pattern}'
		mut existing := grouped[key] or { []VSlimRoute{} }
		existing << route
		grouped[key] = existing
	}
	mut out := []map[string]string{}
	for key, routes in grouped {
		if routes.len <= 1 {
			continue
		}
		parts := key.split_nth(' ', 2)
		mut names := []string{}
		for route in routes {
			if route.name != '' {
				names << route.name
			}
		}
		out << {
			'method':  parts[0]
			'pattern': if parts.len > 1 { parts[1] } else { '' }
			'count':   '${routes.len}'
			'names':   names.join(',')
		}
	}
	return out
}

@[php_method: 'allowedMethodsFor']
@[php_arg_name: 'raw_path=rawPath']
pub fn (app &VSlimApp) allowed_methods_for(raw_path string) []string {
	path := RoutePath.normalize(raw_path)
	mut allowed := []string{}
	for route in app.routes {
		ok, _ := route.matches(path)
		if !ok {
			continue
		}
		allowed = collect_allowed_methods(allowed, route.method)
	}
	if allowed.len > 0 && 'OPTIONS' !in allowed {
		allowed << 'OPTIONS'
	}
	return allowed
}

fn (mut app VSlimApp) add_route(method string, name string, pattern string, handler vphp.PhpValue) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.add_route_with_resource_meta(method, name, pattern, handler, '',
		vphp.PhpCallable.invalid())
}

fn (mut app VSlimApp) add_websocket_route(name string, pattern string, handler vphp.PhpValue) {
	if !value_subject(handler).is_supported_websocket_handler() {
		return
	}
	app.websocket_routes << VSlimRoute{
		method:       'WS'
		name:         name
		pattern:      pattern
		handler_type: .php_callable
		handler_ref:  handler.retain()
	}
}

fn (mut app VSlimApp) add_route_with_resource_meta(method string, name string, pattern string, handler vphp.PhpValue, resource_action string, resource_missing_handler vphp.PhpCallable) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.routes << VSlimRoute{
		method:                   method.to_upper()
		name:                     name
		pattern:                  pattern
		handler_type:             .php_callable
		handler_ref:              handler.retain()
		resource_action:          resource_action
		resource_missing_handler: resource_missing_handler.clone()
	}
}

fn (app &VSlimApp) websocket_route_index(path string) (int, bool) {
	for i, route in app.websocket_routes {
		ok, _ := route.matches(path)
		if ok {
			return i, true
		}
	}
	return -1, false
}

fn (app &VSlimApp) dispatch_websocket_route_handler(route VSlimRoute, event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	mut handler_value := route.handler_ref.owned()
	defer {
		handler_value.release()
	}
	if !handler_value.is_valid() {
		return vphp.PhpValue.null()
	}
	if obj := handler_value.as_object() {
		if handler_value.method_exists('mount') || handler_value.method_exists('render')
			|| handler_value.method_exists('liveMarker') {
			unsafe {
				mut mutable_app := &VSlimApp(app)
				return mutable_app.dispatch_live_websocket_handler(handler_value, event,
					frame, conn)
			}
		}
		if obj.method_exists('handleWebSocket') {
			return obj.call_method('handleWebSocket', frame, conn)
		}
		match event {
			'open' {
				if obj.method_exists('onOpen') {
					return obj.call_method('onOpen', conn, frame)
				}
			}
			'message' {
				if obj.method_exists('onMessage') {
					mut data_arg := vphp.PhpString.of(frame.string_at('data', ''))
					defer {
						data_arg.release()
					}
					return obj.call_method('onMessage', conn, data_arg, frame)
				}
			}
			'close' {
				if obj.method_exists('onClose') {
					mut code_arg := vphp.PhpInt.of(frame.int_at('code', 1000))
					mut reason_arg := vphp.PhpString.of(frame.string_at('reason', ''))
					defer {
						code_arg.release()
						reason_arg.release()
					}
					return obj.call_method('onClose', conn, code_arg, reason_arg, frame)
				}
			}
			else {}
		}
	}
	if callable := handler_value.as_callable() {
		match event {
			'open' {
				return callable.invoke(conn, frame)
			}
			'message' {
				mut data_arg := vphp.PhpString.of(frame.string_at('data', ''))
				defer {
					data_arg.release()
				}
				return callable.invoke(conn, data_arg, frame)
			}
			'close' {
				mut code_arg := vphp.PhpInt.of(frame.int_at('code', 1000))
				mut reason_arg := vphp.PhpString.of(frame.string_at('reason', ''))
				defer {
					code_arg.release()
					reason_arg.release()
				}
				return callable.invoke(conn, code_arg, reason_arg, frame)
			}
			else {
				return vphp.PhpValue.null()
			}
		}
	}
	if handler_value.is_string() && app.has_container() {
		service := app.resolve_container_service(handler_value.to_string()) or {
			return vphp.PhpValue.null()
		}
		return value_subject(service).dispatch_websocket_container_service(event, frame, conn)
	}
	if handler_array := handler_value.as_array() {
		if !app.has_container() {
			return vphp.PhpValue.null()
		}
		parts := handler_array.to_string_list()
		if parts.len >= 1 && parts[0] != '' {
			service := app.resolve_container_service(parts[0]) or { return vphp.PhpValue.null() }
			if parts.len == 2 && parts[1] != '' && service.is_object()
				&& service.method_exists(parts[1]) {
				mut frame_scope := vphp.PhpScope.frame()
				defer {
					frame_scope.release()
				}
				service_obj := service.as_object() or { return vphp.PhpValue.null() }
				return service_obj.call_method(parts[1], ...websocket_handler_args(mut frame_scope,
					event, frame, conn))
			}
			return value_subject(service).dispatch_websocket_container_service(event, frame,
				conn)
		}
	}
	return vphp.PhpValue.null()
}

fn (subject PhpValueSubject) dispatch_websocket_container_service(event string, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	service := subject.value
	if !service.is_valid() {
		return vphp.PhpValue.null()
	}
	if service.is_object() && (service.method_exists('mount') || service.method_exists('render')
		|| service.method_exists('liveMarker')) {
		return vphp.PhpValue.null()
	}
	if service.is_object() && service.method_exists('handleWebSocket') {
		service_obj := service.as_object() or { return vphp.PhpValue.null() }
		return service_obj.call_method('handleWebSocket', frame, conn)
	}
	match event {
		'open' {
			if service.is_object() && service.method_exists('onOpen') {
				service_obj := service.as_object() or { return vphp.PhpValue.null() }
				return service_obj.call_method('onOpen', conn, frame)
			}
		}
		'message' {
			if service.is_object() && service.method_exists('onMessage') {
				mut frame_scope := vphp.PhpScope.frame()
				defer {
					frame_scope.release()
				}
				service_obj := service.as_object() or { return vphp.PhpValue.null() }
				return service_obj.call_method('onMessage', ...websocket_handler_args(mut frame_scope,
					event, frame, conn))
			}
		}
		'close' {
			if service.is_object() && service.method_exists('onClose') {
				mut frame_scope := vphp.PhpScope.frame()
				defer {
					frame_scope.release()
				}
				service_obj := service.as_object() or { return vphp.PhpValue.null() }
				return service_obj.call_method('onClose', ...websocket_handler_args(mut frame_scope,
					event, frame, conn))
			}
		}
		else {}
	}

	if service.is_callable() {
		mut frame_scope := vphp.PhpScope.frame()
		defer {
			frame_scope.release()
		}
		callable := service.as_callable() or { return vphp.PhpValue.null() }
		return callable.invoke(...websocket_handler_args(mut frame_scope, event, frame, conn))
	}
	return vphp.PhpValue.null()
}

fn websocket_handler_args(mut frame_scope vphp.FrameScope, event string, frame vphp.PhpArray, conn vphp.PhpObject) []vphp.PhpArgInput {
	mut out := []vphp.PhpArgInput{}
	match event {
		'open' {
			out << conn
			out << frame
		}
		'message' {
			out << conn
			out << frame_scope.string(frame.string_at('data', ''))
			out << frame
		}
		'close' {
			out << conn
			out << frame_scope.int(frame.int_at('code', 1000))
			out << frame_scope.string(frame.string_at('reason', ''))
			out << frame
		}
		else {
			out << frame
			out << conn
		}
	}

	return out
}

fn collect_allowed_methods(existing []string, route_method string) []string {
	mut out := existing.clone()
	mut incoming := []string{}
	match route_method {
		'*' {
			incoming = ['GET', 'HEAD', 'POST', 'PUT', 'PATCH', 'DELETE']
		}
		'GET' {
			incoming = ['GET', 'HEAD']
		}
		else {
			incoming = [route_method]
		}
	}

	for method in incoming {
		if method !in out {
			out << method
		}
	}
	return out
}

fn (subject PhpValueSubject) normalized_methods() []string {
	methods := subject.value
	mut out := []string{}
	if methods.is_string() {
		raw := methods.to_string().replace('|', ',')
		for part in raw.split(',') {
			method := part.trim_space().to_upper()
			if method == '' {
				continue
			}
			if method == 'ANY' || method == '*' {
				return ['*']
			}
			if method !in out {
				out << method
			}
		}
		return out
	}
	if array := methods.as_array() {
		for part in array.to_string_list() {
			method := part.trim_space().to_upper()
			if method == '' {
				continue
			}
			if method == 'ANY' || method == '*' {
				return ['*']
			}
			if method !in out {
				out << method
			}
		}
	}
	return out
}

module main

import vphp

@[php_method: 'handleWebSocket']
pub fn (mut app VSlimApp) handle_websocket(frame vphp.RequestBorrowedZBox, conn vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	raw_frame := frame.to_zval()
	raw_conn := conn.to_zval()
	event := zval_string_key(raw_frame, 'event', '').trim_space().to_lower()
	conn_id := zval_string_key(raw_frame, 'id', '').trim_space()
	if event == '' || conn_id == '' {
		return vphp.RequestOwnedZBox.new_null()
	}
	path := RoutePath.normalize(zval_string_key(raw_frame, 'path', '/'))
	if event == 'open' {
		idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.RequestOwnedZBox.new_bool(false)
		}
		app.websocket_conn_route[conn_id] = idx
		return vphp.RequestOwnedZBox.adopt_zval(dispatch_websocket_route_handler(app,
			app.websocket_routes[idx], event, raw_frame, raw_conn))
	}
	idx := app.websocket_conn_route[conn_id] or {
		fallback_idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.RequestOwnedZBox.new_null()
		}
		app.websocket_conn_route[conn_id] = fallback_idx
		return vphp.RequestOwnedZBox.adopt_zval(dispatch_websocket_route_handler(app,
			app.websocket_routes[fallback_idx], event, raw_frame, raw_conn))
	}
	if idx < 0 || idx >= app.websocket_routes.len {
		app.websocket_conn_route.delete(conn_id)
		fallback_idx, matched := app.websocket_route_index(path)
		if !matched {
			return vphp.RequestOwnedZBox.new_null()
		}
		app.websocket_conn_route[conn_id] = fallback_idx
		result := dispatch_websocket_route_handler(app, app.websocket_routes[fallback_idx],
			event, raw_frame, raw_conn)
		if event == 'close' {
			app.websocket_conn_route.delete(conn_id)
		}
		return vphp.RequestOwnedZBox.adopt_zval(result)
	}
	result := dispatch_websocket_route_handler(app, app.websocket_routes[idx], event,
		raw_frame, raw_conn)
	if event == 'close' {
		app.websocket_conn_route.delete(conn_id)
	}
	return vphp.RequestOwnedZBox.adopt_zval(result)
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

fn (mut app VSlimApp) add_php_route(method string, name string, pattern string, handler vphp.ZVal) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.add_php_route_with_resource_meta(method, name, pattern, handler, '', vphp.PersistentOwnedZBox.new_null())
}

fn (mut app VSlimApp) add_php_websocket_route(name string, pattern string, handler vphp.ZVal) {
	if !is_supported_websocket_handler(vphp.RequestBorrowedZBox.from_zval(handler)) {
		return
	}
	app.websocket_routes << VSlimRoute{
		method:       'WS'
		name:         name
		pattern:      pattern
		handler_type: .php_callable
		php_handler:  vphp.PersistentOwnedZBox.from_callable_zval(handler)
	}
}

fn (mut app VSlimApp) add_php_route_with_resource_meta(method string, name string, pattern string, handler vphp.ZVal, resource_action string, resource_missing_handler vphp.PersistentOwnedZBox) {
	if !handler.is_valid() || handler.is_null() || handler.is_undef() {
		return
	}
	app.routes << VSlimRoute{
		method:                   method.to_upper()
		name:                     name
		pattern:                  pattern
		handler_type:             .php_callable
		php_handler:              vphp.PersistentOwnedZBox.from_callable_zval(handler)
		resource_action:          resource_action
		resource_missing_handler: resource_missing_handler
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

fn dispatch_websocket_route_handler(app &VSlimApp, route VSlimRoute, event string, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	mut handler_ref := route.php_handler.clone_request_owned()
	defer {
		handler_ref.release()
	}
	handler := handler_ref.borrowed()
	if !handler.is_valid() {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	if handler.is_object() {
		obj := handler.to_zval()
		if obj.method_exists('mount') || obj.method_exists('render')
			|| obj.method_exists('live_marker') {
			unsafe {
				mut mutable_app := &VSlimApp(app)
				return dispatch_live_websocket_handler(mut mutable_app, obj, event, frame,
					conn)
			}
		}
		if obj.method_exists('handle_websocket') {
			mut result := vphp.PhpObject.borrowed(obj).method_request_owned('handle_websocket',
				vphp.PhpValue.from_zval(frame), vphp.PhpValue.from_zval(conn))
			return result.take_zval()
		}
		match event {
			'open' {
				if obj.method_exists('on_open') {
					mut result := vphp.PhpObject.borrowed(obj).method_request_owned('on_open',
						vphp.PhpValue.from_zval(conn), vphp.PhpValue.from_zval(frame))
					return result.take_zval()
				}
			}
			'message' {
				if obj.method_exists('on_message') {
					mut result := vphp.PhpObject.borrowed(obj).method_request_owned('on_message',
						vphp.PhpValue.from_zval(conn), vphp.PhpString.of(zval_string_key(frame,
						'data', '')), vphp.PhpValue.from_zval(frame))
					return result.take_zval()
				}
			}
			'close' {
				if obj.method_exists('on_close') {
					mut result := vphp.PhpObject.borrowed(obj).method_request_owned('on_close',
						vphp.PhpValue.from_zval(conn), vphp.PhpInt.of(zval_int_key(frame,
						'code', 1000)), vphp.PhpString.of(zval_string_key(frame, 'reason',
						'')), vphp.PhpValue.from_zval(frame))
					return result.take_zval()
				}
			}
			else {}
		}
	}
	if handler.is_callable() {
		match event {
			'open' {
				mut result := vphp.PhpCallable.borrowed(handler.to_zval()).fn_request_owned(vphp.PhpValue.from_zval(conn),
					vphp.PhpValue.from_zval(frame))
				return result.take_zval()
			}
			'message' {
				mut result := vphp.PhpCallable.borrowed(handler.to_zval()).fn_request_owned(vphp.PhpValue.from_zval(conn),
					vphp.PhpString.of(zval_string_key(frame, 'data', '')), vphp.PhpValue.from_zval(frame))
				return result.take_zval()
			}
			'close' {
				mut result := vphp.PhpCallable.borrowed(handler.to_zval()).fn_request_owned(vphp.PhpValue.from_zval(conn),
					vphp.PhpInt.of(zval_int_key(frame, 'code', 1000)), vphp.PhpString.of(zval_string_key(frame,
					'reason', '')), vphp.PhpValue.from_zval(frame))
				return result.take_zval()
			}
			else {
				return vphp.RequestOwnedZBox.new_null().to_zval()
			}
		}
	}
	if handler.is_string() && app.has_container() {
		service := resolve_container_service(app, handler.to_string()) or {
			return vphp.RequestOwnedZBox.new_null().to_zval()
		}
		return dispatch_websocket_container_service(service, event, frame, conn)
	}
	if handler.is_array() && app.has_container() {
		parts := handler.to_string_list()
		if parts.len >= 1 && parts[0] != '' {
			service := resolve_container_service(app, parts[0]) or {
				return vphp.RequestOwnedZBox.new_null().to_zval()
			}
			if parts.len == 2 && parts[1] != '' && service.is_object()
				&& service.method_exists(parts[1]) {
				mut result := vphp.PhpObject.borrowed(service).method_request_owned_zval(parts[1],
					websocket_handler_args(event, frame, conn))
				return result.take_zval()
			}
			return dispatch_websocket_container_service(service, event, frame, conn)
		}
	}
	return vphp.RequestOwnedZBox.new_null().to_zval()
}

fn dispatch_websocket_container_service(service vphp.ZVal, event string, frame vphp.ZVal, conn vphp.ZVal) vphp.ZVal {
	if !service.is_valid() {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	if service.is_object() && (service.method_exists('mount') || service.method_exists('render')
		|| service.method_exists('live_marker')) {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	if service.is_object() && service.method_exists('handle_websocket') {
		mut result := vphp.PhpObject.borrowed(service).method_request_owned('handle_websocket',
			vphp.PhpValue.from_zval(frame), vphp.PhpValue.from_zval(conn))
		return result.take_zval()
	}
	match event {
		'open' {
			if service.is_object() && service.method_exists('on_open') {
				mut result := vphp.PhpObject.borrowed(service).method_request_owned('on_open',
					vphp.PhpValue.from_zval(conn), vphp.PhpValue.from_zval(frame))
				return result.take_zval()
			}
		}
		'message' {
			if service.is_object() && service.method_exists('on_message') {
				mut result := vphp.PhpObject.borrowed(service).method_request_owned_zval('on_message',
					websocket_handler_args(event, frame, conn))
				return result.take_zval()
			}
		}
		'close' {
			if service.is_object() && service.method_exists('on_close') {
				mut result := vphp.PhpObject.borrowed(service).method_request_owned_zval('on_close',
					websocket_handler_args(event, frame, conn))
				return result.take_zval()
			}
		}
		else {}
	}
	if service.is_callable() {
		mut result := vphp.PhpCallable.borrowed(service).fn_request_owned_zval(websocket_handler_args(event,
			frame, conn))
		return result.take_zval()
	}
	return vphp.RequestOwnedZBox.new_null().to_zval()
}

fn websocket_handler_args(event string, frame vphp.ZVal, conn vphp.ZVal) []vphp.ZVal {
	return match event {
		'open' {
			[conn, frame]
		}
		'message' {
			[
				conn,
				vphp.RequestOwnedZBox.new_string(zval_string_key(frame, 'data', '')).to_zval(),
				frame,
			]
		}
		'close' {
			[
				conn,
				vphp.RequestOwnedZBox.new_int(zval_int_key(frame, 'code', 1000)).to_zval(),
				vphp.RequestOwnedZBox.new_string(zval_string_key(frame, 'reason', '')).to_zval(),
				frame,
			]
		}
		else {
			[frame, conn]
		}
	}
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

fn normalize_methods(methods vphp.RequestBorrowedZBox) []string {
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
	if methods.is_array() {
		for part in methods.to_string_list() {
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

module appx

import routex
import vphp

@[php_method]
pub fn (app &VSlimApp) group(prefix string) &routex.RouteGroup {
	mut app_value := app.self_value()
	defer {
		app_value.release()
	}
	app_object := app_value.as_object() or { return routex.RouteGroup.empty() }
	return routex.RouteGroup.from_app_object(app_object, prefix)
}

@[php_method]
pub fn (mut app VSlimApp) get(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('GET', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) post(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('POST', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) put(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('PUT', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) head(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('HEAD', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) options(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('OPTIONS', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) patch(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('PATCH', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) delete(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('DELETE', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) any(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('*', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) live(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.bind_live_view(handler)
	app.add_route('GET', '', pattern, handler)
	return app
}

@[php_method: 'liveWs']
pub fn (mut app VSlimApp) live_ws(handler vphp.PhpValue, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	app.bind_live_view(handler)
	event := frame.string_at('event', '').trim_space().to_lower()
	if event == '' {
		return vphp.PhpValue.null()
	}
	return app.dispatch_live_websocket_handler(handler, event, frame, conn)
}

@[php_method]
pub fn (mut app VSlimApp) websocket(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.bind_live_view(handler)
	app.add_websocket_route('', pattern, handler)
	return app
}

@[php_method: 'websocketNamed']
pub fn (mut app VSlimApp) websocket_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_websocket_route(name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) map(methods vphp.PhpValue, pattern string, handler vphp.PhpValue) &VSlimApp {
	for method in routex.normalized_methods_from_value(methods) {
		app.add_route(method, '', pattern, handler)
	}
	return app
}

@[php_method: 'getNamed']
pub fn (mut app VSlimApp) get_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('GET', name, pattern, handler)
	return app
}

@[php_method: 'postNamed']
pub fn (mut app VSlimApp) post_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('POST', name, pattern, handler)
	return app
}

@[php_method: 'putNamed']
pub fn (mut app VSlimApp) put_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('PUT', name, pattern, handler)
	return app
}

@[php_method: 'headNamed']
pub fn (mut app VSlimApp) head_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('HEAD', name, pattern, handler)
	return app
}

@[php_method: 'optionsNamed']
pub fn (mut app VSlimApp) options_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('OPTIONS', name, pattern, handler)
	return app
}

@[php_method: 'patchNamed']
pub fn (mut app VSlimApp) patch_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('PATCH', name, pattern, handler)
	return app
}

@[php_method: 'deleteNamed']
pub fn (mut app VSlimApp) delete_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('DELETE', name, pattern, handler)
	return app
}

@[php_method: 'anyNamed']
pub fn (mut app VSlimApp) any_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_route('*', name, pattern, handler)
	return app
}

@[php_method: 'mapNamed']
pub fn (mut app VSlimApp) map_named(methods vphp.PhpValue, name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	for method in routex.normalized_methods_from_value(methods) {
		app.add_route(method, name, pattern, handler)
	}
	return app
}

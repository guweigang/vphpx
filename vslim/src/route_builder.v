module main

import vphp

@[php_method]
pub fn (app &VSlimApp) group(prefix string) &RouteGroup {
	mut group := &RouteGroup{}
	group.app = app
	group.prefix = RoutePath.normalize_group_prefix(prefix)
	return group
}

@[php_method]
pub fn (mut app VSlimApp) get(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('GET', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) post(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('POST', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) put(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('PUT', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) head(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('HEAD', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) options(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('OPTIONS', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) patch(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('PATCH', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) delete(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('DELETE', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) any(pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('*', '', pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) live(pattern string, handler vphp.PhpValue) &VSlimApp {
	bind_live_view_to_app(mut app, handler)
	app.add_php_route('GET', '', pattern, handler)
	return app
}

@[php_method: 'liveWs']
pub fn (mut app VSlimApp) live_ws(handler vphp.PhpValue, frame vphp.PhpArray, conn vphp.PhpObject) vphp.PhpValue {
	bind_live_view_to_app(mut app, handler)
	event := frame.string_at('event', '').trim_space().to_lower()
	if event == '' {
		return vphp.PhpValue.null()
	}
	return dispatch_live_websocket_handler(mut app, handler, event, frame, conn)
}

@[php_method]
pub fn (mut app VSlimApp) websocket(pattern string, handler vphp.PhpValue) &VSlimApp {
	bind_live_view_to_app(mut app, handler)
	app.add_php_websocket_route('', pattern, handler)
	return app
}

@[php_method: 'websocketNamed']
pub fn (mut app VSlimApp) websocket_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_websocket_route(name, pattern, handler)
	return app
}

@[php_method]
pub fn (mut app VSlimApp) map(methods vphp.PhpValue, pattern string, handler vphp.PhpValue) &VSlimApp {
	for method in normalize_methods(methods) {
		app.add_php_route(method, '', pattern, handler)
	}
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method]
pub fn (mut app VSlimApp) resource(resource_path string, controller string) &VSlimApp {
	register_resource_routes(mut app, resource_path, controller, true)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiResource']
pub fn (mut app VSlimApp) api_resource(resource_path string, controller string) &VSlimApp {
	register_resource_routes(mut app, resource_path, controller, false)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method]
pub fn (mut app VSlimApp) singleton(resource_path string, controller string) &VSlimApp {
	register_singleton_routes(mut app, resource_path, controller, true)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiSingleton']
pub fn (mut app VSlimApp) api_singleton(resource_path string, controller string) &VSlimApp {
	register_singleton_routes(mut app, resource_path, controller, false)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'resourceOpts']
pub fn (mut app VSlimApp) resource_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := parse_resource_options(options)
	register_resource_routes_with_options(mut app, resource_path, controller, true, opts)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiResourceOpts']
pub fn (mut app VSlimApp) api_resource_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := parse_resource_options(options)
	register_resource_routes_with_options(mut app, resource_path, controller, false, opts)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'singletonOpts']
pub fn (mut app VSlimApp) singleton_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := parse_resource_options(options)
	register_singleton_routes_with_options(mut app, resource_path, controller, true, opts)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiSingletonOpts']
pub fn (mut app VSlimApp) api_singleton_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := parse_resource_options(options)
	register_singleton_routes_with_options(mut app, resource_path, controller, false, opts)
	return app
}

@[php_method: 'getNamed']
pub fn (mut app VSlimApp) get_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('GET', name, pattern, handler)
	return app
}

@[php_method: 'postNamed']
pub fn (mut app VSlimApp) post_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('POST', name, pattern, handler)
	return app
}

@[php_method: 'putNamed']
pub fn (mut app VSlimApp) put_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('PUT', name, pattern, handler)
	return app
}

@[php_method: 'headNamed']
pub fn (mut app VSlimApp) head_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('HEAD', name, pattern, handler)
	return app
}

@[php_method: 'optionsNamed']
pub fn (mut app VSlimApp) options_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('OPTIONS', name, pattern, handler)
	return app
}

@[php_method: 'patchNamed']
pub fn (mut app VSlimApp) patch_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('PATCH', name, pattern, handler)
	return app
}

@[php_method: 'deleteNamed']
pub fn (mut app VSlimApp) delete_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('DELETE', name, pattern, handler)
	return app
}

@[php_method: 'anyNamed']
pub fn (mut app VSlimApp) any_named(name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	app.add_php_route('*', name, pattern, handler)
	return app
}

@[php_method: 'mapNamed']
pub fn (mut app VSlimApp) map_named(methods vphp.PhpValue, name string, pattern string, handler vphp.PhpValue) &VSlimApp {
	for method in normalize_methods(methods) {
		app.add_php_route(method, name, pattern, handler)
	}
	return app
}

@[php_method]
pub fn (group &RouteGroup) group(prefix string) &RouteGroup {
	mut nested := &RouteGroup{}
	nested.app = group.app
	nested.prefix = RoutePath.prefixed_pattern(group.prefix, prefix)
	return nested
}

@[php_method]
pub fn (group &RouteGroup) middleware(handler vphp.PhpValue) &RouteGroup {
	register_group_middleware_kind(group, handler, .standard)
	return group
}

@[php_method]
pub fn (group &RouteGroup) before(handler vphp.PhpValue) &RouteGroup {
	register_group_middleware_kind(group, handler, .before)
	return group
}

@[php_method]
pub fn (group &RouteGroup) after(handler vphp.PhpValue) &RouteGroup {
	register_group_middleware_kind(group, handler, .after)
	return group
}

@[php_method]
pub fn (group &RouteGroup) get(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('GET', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) post(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('POST', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) put(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PUT', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) head(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('HEAD', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) options(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('OPTIONS', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) patch(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PATCH', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) delete(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('DELETE', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) any(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('*', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) live(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		bind_live_view_to_app(mut app, handler)
		app.add_php_route('GET', '', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) websocket(pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		bind_live_view_to_app(mut app, handler)
		app.add_php_websocket_route('', group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method]
pub fn (group &RouteGroup) map(methods vphp.PhpValue, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		for method in normalize_methods(methods) {
			app.add_php_route(method, '', group.prefixed_pattern(pattern), handler)
		}
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method]
pub fn (group &RouteGroup) resource(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_resource_routes(mut app, group.prefixed_pattern(resource_path), controller, true)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiResource']
pub fn (group &RouteGroup) api_resource(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_resource_routes(mut app, group.prefixed_pattern(resource_path), controller, false)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method]
pub fn (group &RouteGroup) singleton(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_singleton_routes(mut app, group.prefixed_pattern(resource_path), controller, true)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiSingleton']
pub fn (group &RouteGroup) api_singleton(resource_path string, controller string) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		register_singleton_routes(mut app, group.prefixed_pattern(resource_path), controller, false)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'resourceOpts']
pub fn (group &RouteGroup) resource_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(options)
		register_resource_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, true, opts)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiResourceOpts']
pub fn (group &RouteGroup) api_resource_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(options)
		register_resource_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, false, opts)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'singletonOpts']
pub fn (group &RouteGroup) singleton_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(options)
		register_singleton_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, true, opts)
	}
	return group
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiSingletonOpts']
pub fn (group &RouteGroup) api_singleton_opts(resource_path string, controller string, options vphp.PhpArray) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		opts := parse_resource_options(options)
		register_singleton_routes_with_options(mut app, group.prefixed_pattern(resource_path),
			controller, false, opts)
	}
	return group
}

@[php_method: 'getNamed']
pub fn (group &RouteGroup) get_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('GET', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'postNamed']
pub fn (group &RouteGroup) post_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('POST', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'putNamed']
pub fn (group &RouteGroup) put_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PUT', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'headNamed']
pub fn (group &RouteGroup) head_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('HEAD', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'optionsNamed']
pub fn (group &RouteGroup) options_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('OPTIONS', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'patchNamed']
pub fn (group &RouteGroup) patch_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('PATCH', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'deleteNamed']
pub fn (group &RouteGroup) delete_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('DELETE', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'anyNamed']
pub fn (group &RouteGroup) any_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_route('*', name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'websocketNamed']
pub fn (group &RouteGroup) websocket_named(name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		app.add_php_websocket_route(name, group.prefixed_pattern(pattern), handler)
	}
	return group
}

@[php_method: 'mapNamed']
pub fn (group &RouteGroup) map_named(methods vphp.PhpValue, name string, pattern string, handler vphp.PhpValue) &RouteGroup {
	unsafe {
		mut app := &VSlimApp(group.app)
		for method in normalize_methods(methods) {
			app.add_php_route(method, name, group.prefixed_pattern(pattern), handler)
		}
	}
	return group
}

@[php_method: 'urlFor']
pub fn (app &VSlimApp) url_for(name string, params vphp.PhpValue) string {
	return app.url_for_query_value(name, params, vphp.PhpValue.null())
}

@[php_method: 'urlForQuery']
pub fn (app &VSlimApp) url_for_query(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	return app.url_for_query_value(name, params, query)
}

fn (app &VSlimApp) url_for_query_value(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	params_map := params.to_string_map()
	query_map := query.to_string_map()
	for route in app.routes {
		if route.name == name {
			raw := app.render_route_url(route.pattern, &params_map, &query_map) or { '' }
			return RoutePath.apply_base_path(app.base_path, raw)
		}
	}
	return ''
}

@[php_method: 'urlForAbs']
pub fn (app &VSlimApp) url_for_abs(name string, params vphp.PhpValue, scheme string, host string) string {
	return app.url_for_query_abs_value(name, params, vphp.PhpValue.null(), scheme, host)
}

@[php_method: 'urlForQueryAbs']
pub fn (app &VSlimApp) url_for_query_abs(name string, params vphp.PhpValue, query vphp.PhpValue, scheme string, host string) string {
	return app.url_for_query_abs_value(name, params, query, scheme, host)
}

fn (app &VSlimApp) url_for_query_abs_value(name string, params vphp.PhpValue, query vphp.PhpValue, scheme string, host string) string {
	path := app.url_for_query_value(name, params, query)
	if path == '' {
		return ''
	}
	return RoutePath.absolute_url(scheme, host, path)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'redirectTo']
pub fn (app &VSlimApp) redirect_to(name string, params vphp.PhpValue) &VSlimPsr7Response {
	return app.redirect_to_query_value(name, params, vphp.PhpValue.null())
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'redirectToQuery']
pub fn (app &VSlimApp) redirect_to_query(name string, params vphp.PhpValue, query vphp.PhpValue) &VSlimPsr7Response {
	return app.redirect_to_query_value(name, params, query)
}

fn (app &VSlimApp) redirect_to_query_value(name string, params vphp.PhpValue, query vphp.PhpValue) &VSlimPsr7Response {
	location := app.url_for_query_value(name, params, query)
	mut res := VSlimResponse{}
	res.construct(302, '', 'text/plain; charset=utf-8')
	return new_psr7_response_from_vslim_response(*res.redirect(location))
}

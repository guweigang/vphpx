module routex

import routingx
import vphp

pub fn VSlimRoute.from_callable_handler(method string, name string, pattern string, handler vphp.PhpValue) VSlimRoute {
	return VSlimRoute.with_resource_meta(method, name, pattern, handler, '',
		vphp.PhpCallable.invalid())
}

pub fn VSlimRoute.websocket(name string, pattern string, handler vphp.PhpValue) VSlimRoute {
	return VSlimRoute.from_callable_handler('WS', name, pattern, handler)
}

pub fn VSlimRoute.with_resource_meta(method string, name string, pattern string, handler vphp.PhpValue, resource_action string, resource_missing_handler vphp.PhpCallable) VSlimRoute {
	return VSlimRoute{
		method:                   method.to_upper()
		name:                     name
		pattern:                  pattern
		handler_type:             .php_callable
		handler_ref:              handler.retain()
		resource_action:          resource_action
		resource_missing_handler: resource_missing_handler.clone()
	}
}

pub fn (route VSlimRoute) normalized_pattern() string {
	return routingx.Path.normalize(route.pattern)
}

pub fn normalize_route_path(path string) string {
	return routingx.Path.normalize(path)
}

pub fn (route VSlimRoute) matches(path string) (bool, map[string]string) {
	return routingx.RoutePattern.matches(route.pattern, path)
}

pub fn (mut route VSlimRoute) release_owned_refs() {
	if route.handler_ref.is_valid() {
		mut handler := route.handler_ref
		handler.release()
	}
	if route.resource_missing_handler.is_valid() {
		mut handler := route.resource_missing_handler
		handler.release()
	}
}

pub fn render_route_url(pattern string, params &map[string]string, query &map[string]string) ?string {
	return routingx.RoutePattern.render_url(pattern, params, query)
}

pub fn encode_query_params(query &map[string]string) string {
	return routingx.Query.encode_map(query)
}

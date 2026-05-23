module routex

pub enum RouteDispatchMatchKind {
	unresolved
	matched
	options
	method_not_allowed
}

pub struct RouteDispatchMatch {
pub:
	kind            RouteDispatchMatchKind = .unresolved
	route           VSlimRoute
	route_params    map[string]string
	allowed_methods []string
}

pub fn resolve_dispatch_match(routes []VSlimRoute, method string, path string) RouteDispatchMatch {
	mut method_not_allowed := false
	mut allowed_methods := []string{}
	for route in routes {
		if route.handler_type != .php_callable {
			continue
		}
		ok, params := route.matches(path)
		if !ok {
			continue
		}
		allowed_methods = collect_allowed_methods(allowed_methods, route.method)
		if route.method != '*' && route.method != method && !(method == 'HEAD'
			&& route.method == 'GET') {
			method_not_allowed = true
			continue
		}
		return RouteDispatchMatch{
			kind:         .matched
			route:        route
			route_params: params
		}
	}
	if method == 'OPTIONS' && allowed_methods.len > 0 {
		return RouteDispatchMatch{
			kind:            .options
			allowed_methods: allowed_methods
		}
	}
	if method_not_allowed {
		return RouteDispatchMatch{
			kind:            .method_not_allowed
			allowed_methods: allowed_methods
		}
	}
	return RouteDispatchMatch{}
}

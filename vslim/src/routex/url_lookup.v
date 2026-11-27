module routex

pub fn url_for(routes []VSlimRoute, base_path string, name string, params map[string]string, query map[string]string) string {
	for route in routes {
		if route.name == name {
			return route.url(base_path, &params, &query)
		}
	}
	return ''
}

pub fn (route VSlimRoute) url(base_path string, params &map[string]string, query &map[string]string) string {
	raw := render_route_url(route.pattern, params, query) or { '' }
	return apply_base_path(base_path, raw)
}

pub fn (route VSlimRoute) url_abs(base_path string, params &map[string]string, query &map[string]string, scheme string, host string) string {
	return absolute_route_url(scheme, host, route.url(base_path, params, query))
}

pub fn url_for_abs(routes []VSlimRoute, base_path string, name string, params map[string]string, query map[string]string, scheme string, host string) string {
	return absolute_route_url(scheme, host, url_for(routes, base_path, name, params, query))
}

fn absolute_route_url(scheme string, host string, path string) string {
	if path == '' {
		return ''
	}
	return absolute_url(scheme, host, path)
}

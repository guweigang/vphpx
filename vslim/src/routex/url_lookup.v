module routex

pub fn url_for(routes []VSlimRoute, base_path string, name string, params map[string]string, query map[string]string) string {
	for route in routes {
		if route.name == name {
			raw := render_route_url(route.pattern, &params, &query) or { '' }
			return apply_base_path(base_path, raw)
		}
	}
	return ''
}

pub fn url_for_abs(routes []VSlimRoute, base_path string, name string, params map[string]string, query map[string]string, scheme string, host string) string {
	path := url_for(routes, base_path, name, params, query)
	if path == '' {
		return ''
	}
	return absolute_url(scheme, host, path)
}

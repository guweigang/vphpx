module routex

import httpx

pub fn route_names(routes []VSlimRoute) []string {
	mut out := []string{}
	for route in routes {
		if route.name == '' {
			continue
		}
		if route.name !in out {
			out << route.name
		}
	}
	return out
}

pub fn has_route_name(routes []VSlimRoute, name string) bool {
	for route in routes {
		if route.name == name {
			return true
		}
	}
	return false
}

pub fn route_index_for_path(routes []VSlimRoute, raw_path string) (int, bool) {
	path := httpx.Path.normalize(raw_path)
	for i, route in routes {
		ok, _ := route.matches(path)
		if ok {
			return i, true
		}
	}
	return -1, false
}

pub fn route_manifest_lines(routes []VSlimRoute) []string {
	mut out := []string{cap: routes.len}
	for route in routes {
		mut line := '${route.method} ${route.pattern}'
		if route.name != '' {
			line += ' #${route.name}'
		}
		out << line
	}
	return out
}

pub fn route_conflict_keys(routes []VSlimRoute) []string {
	mut grouped := map[string]int{}
	for route in routes {
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

pub fn route_manifest(routes []VSlimRoute) []map[string]string {
	mut out := []map[string]string{cap: routes.len}
	for route in routes {
		out << {
			'method':       route.method
			'name':         route.name
			'pattern':      route.pattern
			'handler_type': route.handler_type.str()
		}
	}
	return out
}

pub fn route_conflicts(routes []VSlimRoute) []map[string]string {
	mut grouped := map[string][]VSlimRoute{}
	for route in routes {
		key := '${route.method} ${route.pattern}'
		mut existing := grouped[key] or { []VSlimRoute{} }
		existing << route
		grouped[key] = existing
	}
	mut out := []map[string]string{}
	for key, grouped_routes in grouped {
		if grouped_routes.len <= 1 {
			continue
		}
		parts := key.split_nth(' ', 2)
		mut names := []string{}
		for route in grouped_routes {
			if route.name != '' {
				names << route.name
			}
		}
		out << {
			'method':  parts[0]
			'pattern': if parts.len > 1 { parts[1] } else { '' }
			'count':   '${grouped_routes.len}'
			'names':   names.join(',')
		}
	}
	return out
}

pub fn allowed_methods_for(routes []VSlimRoute, raw_path string) []string {
	path := httpx.Path.normalize(raw_path)
	mut allowed := []string{}
	for route in routes {
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

pub fn collect_allowed_methods(existing []string, route_method string) []string {
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

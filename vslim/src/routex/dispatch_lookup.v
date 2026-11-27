module routex

import httpx

pub enum RouteDispatchMatchKind {
	unresolved
	matched
	options
	method_not_allowed
}

pub struct RouteDispatchMatch {
pub:
	kind            RouteDispatchMatchKind = .unresolved
	index           int                    = -1
	route           VSlimRoute
	route_params    map[string]string
	allowed_methods []string
}

pub struct RouteIndex {
mut:
	patterns []CompiledRoutePattern
	by_path map[string][]int
	by_first_segment map[string][]int
	without_prefix []int
	by_name map[string]int
	named_order []string
}

struct CompiledRoutePattern {
	name string
	normalized string
	parts []string
	dynamic bool
	first_segment string
}

pub fn (mut index RouteIndex) add(pattern string, name string) {
	normalized := httpx.Path.normalize(pattern)
	key := normalized.trim('/')
	dynamic := key.starts_with(':') || key.contains('/:')
	parts := if dynamic { key.split('/') } else { []string{} }
	first_segment := if dynamic { parts[0] or { '' } } else { '' }
	position := index.patterns.len
	if name !in index.by_name {
		index.by_name[name] = position
		if name != '' {
			index.named_order << name
		}
	}
	if !dynamic {
		index.by_path[key] << position
	} else if first_segment.starts_with(':') {
		index.without_prefix << position
	} else {
		index.by_first_segment[first_segment] << position
	}
	index.patterns << CompiledRoutePattern{
		name: name
		normalized: normalized
		parts: parts
		dynamic: dynamic
		first_segment: first_segment
	}
}

pub fn (mut index RouteIndex) trim(length int) {
	for index.patterns.len > length {
		mut last := index.patterns.pop()
		if first := index.by_name[last.name] {
			if first == index.patterns.len {
				index.by_name.delete(last.name)
				if last.name != '' {
					index.named_order.pop()
				}
			}
		}
		if !last.dynamic {
			trim_route_bucket(mut index.by_path, last.normalized.trim('/'))
		} else if last.first_segment.starts_with(':') {
			index.without_prefix.pop()
		} else {
			trim_route_bucket(mut index.by_first_segment, last.first_segment)
		}
		$if nongc ? {
			unsafe {
				for part in last.parts {
					part.free()
				}
				last.parts.free()
				last.normalized.free()
			}
		}
	}
}

pub fn (mut index RouteIndex) release() {
	$if nongc ? {
		index.trim(0)
		unsafe {
			index.patterns.free()
			index.by_path.free()
			index.by_first_segment.free()
			index.without_prefix.free()
			index.by_name.free()
			index.named_order.free()
		}
	}
}

pub fn (index &RouteIndex) names() []string {
	return index.named_order.clone()
}

pub fn (index &RouteIndex) index_for_name(name string) ?int {
	position := index.by_name[name] or { return none }
	return position
}

fn trim_route_bucket(mut buckets map[string][]int, key string) {
	mut positions := buckets[key] or { return }
	if positions.len == 1 {
		buckets.delete(key)
		$if nongc ? {
			unsafe {
				positions.free()
			}
		}
	} else {
		positions.pop()
		buckets[key] = positions
	}
}

fn (pattern CompiledRoutePattern) matches(parts []string) bool {
	if pattern.parts.len != parts.len {
		return false
	}
	for position, part in pattern.parts {
		if !part.starts_with(':') && part != parts[position] {
			return false
		}
	}
	return true
}

fn (pattern CompiledRoutePattern) parameters(path string, parts []string) map[string]string {
	mut params := map[string]string{}
	if pattern.dynamic && pattern.normalized != path {
		for position, part in pattern.parts {
			if part.starts_with(':') {
				params[part[1..]] = parts[position]
			}
		}
	}
	return params
}

struct RoutePathCandidates {
	path string
	parts []string
	buckets [3][]int
mut:
	cursors [3]int
}

fn (index &RouteIndex) path_candidates(raw_path string) RoutePathCandidates {
	path := httpx.Path.normalize(raw_path)
	key := path.trim('/')
	first_segment := key.all_before('/')
	buckets := [index.by_path[key], index.by_first_segment[first_segment], index.without_prefix]!
	return RoutePathCandidates{
		path: path
		parts: if buckets[1].len != 0 || buckets[2].len != 0 { key.split('/') } else { []string{} }
		buckets: buckets
	}
}

fn (mut candidates RoutePathCandidates) next_match(index &RouteIndex) ?int {
	for {
		mut route_index := index.patterns.len
		mut bucket := -1
		// All buckets are in registration order. Merge them without reordering matches.
		for slot, positions in candidates.buckets {
			cursor := candidates.cursors[slot]
			if cursor < positions.len && positions[cursor] < route_index {
				bucket = slot
				route_index = positions[cursor]
			}
		}
		if bucket < 0 {
			return none
		}
		candidates.cursors[bucket]++
		pattern := index.patterns[route_index]
		if !pattern.dynamic || pattern.matches(candidates.parts) {
			return route_index
		}
	}
	return none
}

pub fn (index &RouteIndex) resolve(routes []VSlimRoute, method string, raw_path string) RouteDispatchMatch {
	mut candidates := index.path_candidates(raw_path)
	mut allowed_methods := []string{}
	for {
		route_index := candidates.next_match(index) or { break }
		route := routes[route_index]
		if route.handler_type != .php_callable {
			continue
		}
		if !accepts_dispatch_method(route.method, method) {
			append_allowed_methods(mut allowed_methods, route.method)
			continue
		}
		return RouteDispatchMatch{
			kind:         .matched
			index:        route_index
			route:        route
			route_params: index.patterns[route_index].parameters(candidates.path, candidates.parts)
		}
	}
	return dispatch_miss(method, allowed_methods)
}

pub fn (index &RouteIndex) allowed_methods_for(routes []VSlimRoute, raw_path string) []string {
	mut candidates := index.path_candidates(raw_path)
	mut allowed := []string{}
	for {
		route_index := candidates.next_match(index) or { break }
		append_allowed_methods(mut allowed, routes[route_index].method)
	}
	append_options(mut allowed)
	return allowed
}

pub fn resolve_dispatch_match(routes []VSlimRoute, method string, path string) RouteDispatchMatch {
	mut allowed_methods := []string{}
	for route_index, route in routes {
		if route.handler_type != .php_callable {
			continue
		}
		matches, params := route.matches(path)
		if !matches {
			continue
		}
		if accepts_dispatch_method(route.method, method) {
			return RouteDispatchMatch{ kind: .matched, index: route_index, route: route, route_params: params }
		}
		append_allowed_methods(mut allowed_methods, route.method)
	}
	return dispatch_miss(method, allowed_methods)
}

fn accepts_dispatch_method(route_method string, method string) bool {
	return route_method == '*' || route_method == method || (method == 'HEAD' && route_method == 'GET')
}

fn dispatch_miss(method string, allowed_methods []string) RouteDispatchMatch {
	if allowed_methods.len == 0 {
		return RouteDispatchMatch{}
	}
	return RouteDispatchMatch{
		kind: if method == 'OPTIONS' { RouteDispatchMatchKind.options } else { .method_not_allowed }
		allowed_methods: allowed_methods
	}
}

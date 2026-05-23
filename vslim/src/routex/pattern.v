module routex

import httpx

pub struct RoutePattern {}

pub fn RoutePattern.matches(pattern string, path string) (bool, map[string]string) {
	p := httpx.Path.normalize(pattern)
	u := httpx.Path.normalize(path)
	if p == u {
		return true, map[string]string{}
	}

	p_parts := p.trim('/').split('/')
	u_parts := u.trim('/').split('/')
	if p_parts.len != u_parts.len {
		return false, map[string]string{}
	}

	mut params := map[string]string{}
	for i in 0 .. p_parts.len {
		pp := p_parts[i]
		up := u_parts[i]
		if pp.starts_with(':') {
			params[pp.all_after(':')] = up
			continue
		}
		if pp != up {
			return false, map[string]string{}
		}
	}
	return true, params
}

pub fn RoutePattern.render_url(pattern string, params &map[string]string, query &map[string]string) ?string {
	p := httpx.Path.normalize(pattern)
	mut parts := []string{}
	for part in p.trim('/').split('/') {
		if part == '' {
			continue
		}
		if part.starts_with(':') {
			key := part.all_after(':')
			if key !in params {
				return none
			}
			unsafe {
				parts << params[key]
			}
			continue
		}
		parts << part
	}
	mut path := if parts.len == 0 { '/' } else { '/' + parts.join('/') }
	if query.len > 0 {
		path += '?' + httpx.Query.encode_map(query)
	}
	return path
}

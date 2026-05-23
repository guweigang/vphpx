module httpx

import net.urllib

pub struct Path {}

pub struct Query {}

pub struct Header {}

pub fn Path.normalize(path string) string {
	if path.len == 0 {
		return '/'
	}
	if path.starts_with('/') {
		return path.clone()
	}
	return '/${path}'
}

pub fn Path.normalize_group_prefix(prefix string) string {
	if prefix == '' || prefix == '/' {
		return ''
	}
	mut out := Path.normalize(prefix)
	if out.len > 1 && out.ends_with('/') {
		out = out[..out.len - 1]
	}
	return out
}

pub fn Path.prefixed_pattern(prefix string, pattern string) string {
	base := Path.normalize_group_prefix(prefix)
	mut tail := Path.normalize(pattern)
	if base == '' {
		return tail
	}
	if tail == '/' {
		return base
	}
	if tail.starts_with('/') {
		tail = tail[1..]
	}
	return '${base}/${tail}'
}

pub fn Path.normalize_base_path(base_path string) string {
	if base_path == '' || base_path == '/' {
		return ''
	}
	mut out := Path.normalize(base_path)
	if out.len > 1 && out.ends_with('/') {
		out = out[..out.len - 1]
	}
	return out
}

pub fn Path.apply_base_path(base_path string, path string) string {
	base := Path.normalize_base_path(base_path)
	if base == '' || path == '' {
		return path
	}
	if path == '/' {
		return base
	}
	if path.starts_with('/') {
		return base + path
	}
	return '${base}/${path}'
}

pub fn Path.absolute_url(scheme string, host string, path string) string {
	clean_scheme := if scheme == '' { 'http' } else { scheme }
	clean_host := host.trim_space()
	if clean_host == '' {
		return path
	}
	return '${clean_scheme}://${clean_host}${path}'
}

pub fn Path.normalize_target(raw_path string) (string, string) {
	path := Path.normalize(raw_path)
	if !path.contains('?') {
		return path.clone(), ''
	}
	base := Path.normalize(path.all_before('?'))
	query := path.all_after('?').clone()
	return base.clone(), query
}

pub fn Query.parse(query_str string) map[string]string {
	mut out := map[string]string{}
	if query_str == '' {
		return out
	}
	values := urllib.parse_query(query_str) or { return out }
	for key, entries in values.to_map() {
		if entries.len == 0 {
			out[key] = ''
			continue
		}
		out[key] = entries[0]
	}
	return out
}

pub fn Query.encode_map(query &map[string]string) string {
	mut keys := query.keys()
	keys.sort()
	mut parts := []string{}
	for key in keys {
		unsafe {
			parts << '${key}=${query[key]}'
		}
	}
	return parts.join('&')
}

pub fn Header.normalize_name(name string) string {
	return name.trim_space().to_lower()
}

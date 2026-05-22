module httpx

pub fn snapshot_string_map(input map[string]string) map[string]string {
	mut out := map[string]string{}
	for key, value in input {
		out[key.clone()] = value.clone()
	}
	return out
}

pub fn snapshot_string_list(input []string) []string {
	mut out := []string{}
	for value in input {
		out << value.clone()
	}
	return out
}

pub fn normalize_header_map(headers map[string]string) map[string]string {
	mut out := map[string]string{}
	for key, value in headers {
		out[normalize_header_name(key).clone()] = value.clone()
	}
	return out
}

pub fn normalize_header_name(name string) string {
	return Header.normalize_name(name)
}

pub fn build_set_cookie_header(name string, value string, path string, domain string, max_age int, secure bool, http_only bool, same_site string) string {
	mut parts := []string{}
	parts << '${name}=${value}'
	cookie_path := if path == '' { '/' } else { path }
	parts << 'Path=${cookie_path}'
	if domain != '' {
		parts << 'Domain=${domain}'
	}
	if max_age != 0 {
		if max_age > 0 {
			parts << 'Max-Age=${max_age}'
		} else {
			parts << 'Max-Age=0'
		}
	}
	if http_only {
		parts << 'HttpOnly'
	}
	if secure {
		parts << 'Secure'
	}
	match same_site.to_lower() {
		'lax' {
			parts << 'SameSite=Lax'
		}
		'strict' {
			parts << 'SameSite=Strict'
		}
		'none' {
			parts << 'SameSite=None'
		}
		'default' {
			parts << 'SameSite'
		}
		else {}
	}

	return parts.join('; ')
}

pub fn split_path_and_query(raw_path string) (string, map[string]string) {
	path, query_str := Path.normalize_target(raw_path)
	return path, Query.parse(query_str)
}

pub fn raw_query_string(raw_path string) string {
	_, query_string := Path.normalize_target(raw_path)
	return query_string
}

pub fn encode_query_map(query map[string]string) string {
	return Query.encode_map(&query)
}

pub fn multipart_boundary_from_content_type(content_type string) string {
	for part in content_type.split(';') {
		trimmed := part.trim_space()
		if !trimmed.starts_with('boundary=') {
			continue
		}
		mut boundary := trimmed.all_after('boundary=').trim_space()
		if boundary.len >= 2 && boundary.starts_with('"') && boundary.ends_with('"') {
			boundary = boundary[1..boundary.len - 1]
		}
		return boundary
	}
	return ''
}

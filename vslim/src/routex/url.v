module routex

import routing

pub fn normalize_base_path(base_path string) string {
	return routing.Path.normalize_base_path(base_path)
}

pub fn apply_base_path(base_path string, path string) string {
	return routing.Path.apply_base_path(base_path, path)
}

pub fn absolute_url(scheme string, host string, path string) string {
	return routing.Path.absolute_url(scheme, host, path)
}

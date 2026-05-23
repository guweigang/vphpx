module routex

import httpx

pub fn normalize_base_path(base_path string) string {
	return httpx.Path.normalize_base_path(base_path)
}

pub fn apply_base_path(base_path string, path string) string {
	return httpx.Path.apply_base_path(base_path, path)
}

pub fn absolute_url(scheme string, host string, path string) string {
	return httpx.Path.absolute_url(scheme, host, path)
}

module routex

import httpx

pub fn normalize_group_prefix(prefix string) string {
	return httpx.Path.normalize_group_prefix(prefix)
}

pub fn prefixed_group_pattern(prefix string, pattern string) string {
	return httpx.Path.prefixed_pattern(prefix, pattern)
}

module routex

import routingx

pub fn normalize_group_prefix(prefix string) string {
	return routingx.Path.normalize_group_prefix(prefix)
}

pub fn prefixed_group_pattern(prefix string, pattern string) string {
	return routingx.Path.prefixed_pattern(prefix, pattern)
}

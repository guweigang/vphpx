module routex

import routing

pub fn normalize_group_prefix(prefix string) string {
	return routing.Path.normalize_group_prefix(prefix)
}

pub fn prefixed_group_pattern(prefix string, pattern string) string {
	return routing.Path.prefixed_pattern(prefix, pattern)
}

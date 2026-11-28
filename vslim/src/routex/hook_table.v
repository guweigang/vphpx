module routex

import vphp

pub struct HookTable {
pub mut:
	prefixes []string
	handlers []vphp.PhpValue
}

pub fn (table HookTable) collect_matching(path string) []vphp.PhpValue {
	return table.collect_matching_with(path, fn (_ int, value vphp.PhpValue) vphp.PhpValue {
		return value.owned()
	})
}

pub fn (table HookTable) collect_matching_with(path string, snapshot fn (int, vphp.PhpValue) vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for i, prefix in table.prefixes {
		if path_has_prefix(path, prefix) && i < table.handlers.len {
			out << snapshot(i, table.handlers[i])
		}
	}
	return out
}

pub fn (table HookTable) has_matching(path string) bool {
	for i, prefix in table.prefixes {
		if i < table.handlers.len && path_has_prefix(path, prefix) {
			return true
		}
	}
	return false
}

pub fn (table HookTable) matches_at(index int, path string) bool {
	return index >= 0 && index < table.prefixes.len && index < table.handlers.len
		&& path_has_prefix(path, table.prefixes[index])
}

pub fn (mut table HookTable) release_owned_refs() {
	for mut handler in table.handlers {
		if handler.is_valid() {
			handler.release()
		}
	}
}

fn path_has_prefix(path string, prefix string) bool {
	if prefix == '' {
		return true
	}
	if path == prefix {
		return true
	}
	return path.starts_with(prefix + '/')
}

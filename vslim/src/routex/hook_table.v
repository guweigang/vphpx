module routex

import vphp

pub struct HookTable {
pub mut:
	prefixes []string
	handlers []vphp.PhpValue
}

pub fn (table HookTable) collect_matching(path string) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for i, prefix in table.prefixes {
		if path_has_prefix(path, prefix) && i < table.handlers.len {
			out << table.handlers[i].owned()
		}
	}
	return out
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

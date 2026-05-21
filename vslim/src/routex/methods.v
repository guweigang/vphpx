module routex

import vphp

pub fn normalized_methods_from_value(methods vphp.PhpValue) []string {
	if methods.is_string() {
		return normalized_methods_from_string(methods.to_string())
	}
	if array := methods.as_array() {
		return normalized_methods_from_list(array.to_string_list())
	}
	return []string{}
}

pub fn normalized_methods_from_string(raw string) []string {
	mut parts := []string{}
	for part in raw.replace('|', ',').split(',') {
		parts << part
	}
	return normalized_methods_from_list(parts)
}

pub fn normalized_methods_from_list(parts []string) []string {
	mut out := []string{}
	for part in parts {
		method := part.trim_space().to_upper()
		if method == '' {
			continue
		}
		if method == 'ANY' || method == '*' {
			return ['*']
		}
		if method !in out {
			out << method
		}
	}
	return out
}

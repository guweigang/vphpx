module liveviewx

import vphp

pub fn value_string(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	if value.is_string() {
		return value.to_string()
	}
	if value.is_bool() {
		return if value.to_bool() { '1' } else { '0' }
	}
	if value.is_long() {
		return value.to_i64().str()
	}
	if value.is_double() {
		return value.to_f64().str()
	}
	return value.to_string()
}

pub fn form_value_string(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	if !value.is_array() {
		return value_string(value)
	}
	arr := value.as_array() or { return '' }
	mut parts := []string{}
	for item in arr.value_items() {
		parts << value_string(item)
	}
	return parts.join(', ')
}

pub fn field_names(value vphp.PhpArray) []string {
	if !value.is_valid() {
		return []string{}
	}
	mut out := []string{}
	for item in value.value_items() {
		name := item.to_string().trim_space()
		if name != '' {
			out << name
		}
	}
	if out.len > 0 {
		return out
	}
	for key in value.assoc_keys() {
		name := key.trim_space()
		if name != '' {
			out << name
		}
	}
	return out
}

pub fn error_key(field string) string {
	name := field.trim_space()
	return if name == '' { '' } else { 'error_${name}' }
}

pub fn clone_entries(entries []map[string]string) []map[string]string {
	mut out := []map[string]string{cap: entries.len}
	for entry in entries {
		out << entry.clone()
	}
	return out
}

pub fn normalize_target(raw_path string) string {
	clean := raw_path.trim_space()
	return if clean == '' { '/' } else { clean }
}

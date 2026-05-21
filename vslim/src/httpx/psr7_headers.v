module httpx

import psrx
import vphp

pub fn clone_header_values(headers map[string][]string) map[string][]string {
	mut out := map[string][]string{}
	for key, values in headers {
		out[key.clone()] = clone_header_list(values)
	}
	return out
}

fn clone_header_list(values []string) []string {
	mut out := []string{}
	for value in values {
		out << value.clone()
	}
	return out
}

pub fn clone_header_names(header_names map[string]string) map[string]string {
	mut out := map[string]string{}
	for key, value in header_names {
		out[key.clone()] = value.clone()
	}
	return out
}

fn materialize_psr7_headers(headers map[string][]string, header_names map[string]string) map[string][]string {
	mut out := map[string][]string{}
	for key, values in headers {
		resolved_name := (header_names[key] or { key }).clone()
		out[resolved_name] = clone_header_list(values)
	}
	return out
}

struct Psr7HeaderState {
mut:
	headers      map[string][]string
	header_names map[string]string
}

fn (subject PhpValueSubject) psr7_header_state() (map[string][]string, map[string]string) {
	value := subject.value
	mut arr := value.as_array() or { return map[string][]string{}, map[string]string{} }
	defer {
		arr.release()
	}
	state := arr.fold_values[Psr7HeaderState](Psr7HeaderState{
		headers:      map[string][]string{}
		header_names: map[string]string{}
	}, fn (key vphp.PhpValue, child vphp.PhpValue, mut state Psr7HeaderState) {
		name := key.to_string()
		normalized := psrx.normalize_header_name(name)
		state.headers[normalized] = value_subject(child).header_values() or { []string{} }
		state.header_names[normalized] = name
	})
	return state.headers, state.header_names
}

pub fn psr7_header_state_from_value(value vphp.PhpValue) (map[string][]string, map[string]string) {
	return value_subject(value).psr7_header_state()
}

pub fn flatten_psr7_header_map(headers map[string][]string) map[string]string {
	mut out := map[string]string{}
	for key, values in headers {
		out[key] = values.join(', ')
	}
	return out
}

fn (subject PhpValueSubject) header_values() ?[]string {
	value := subject.value
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return []string{}
	}
	if value.is_array() {
		mut out := []string{}
		for entry in value.to_string_list() {
			if !psrx.is_valid_header_value(entry) {
				vphp.PhpException.raise_class('InvalidArgumentException',
					'header values must not contain CR or LF characters', 0)
				return none
			}
			out << entry.trim_space()
		}
		return out
	}
	entry := value.to_string()
	if !psrx.is_valid_header_value(entry) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'header values must not contain CR or LF characters', 0)
		return none
	}
	return [entry.trim_space()]
}

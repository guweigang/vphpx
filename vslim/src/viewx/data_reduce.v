module viewx

import os
import vphp

struct PhpValueSubject {
	value vphp.PhpValue
}

fn value_subject(value vphp.PhpValue) PhpValueSubject {
	return PhpValueSubject{
		value: value
	}
}

fn is_view_debug_enabled() bool {
	raw := os.getenv_opt('VSLIM_VIEW_DEBUG') or { '' }
	flag := raw.trim_space().to_lower()
	return flag in ['1', 'true', 'yes', 'on']
}

fn template_scalar_value(path string, scalars map[string]string) string {
	return template_scalar_value_with_lists(path, scalars, map[string][]string{})
}

fn template_scalar_value_with_lists(path string, scalars map[string]string, lists map[string][]string) string {
	key := path.trim_space()
	if key == '' {
		return ''
	}
	if key in scalars {
		return scalars[key]
	}
	alias := alias_template_key(key)
	if alias in scalars {
		return scalars[alias]
	}
	if lists.len > 0 {
		if item := template_indexed_list_item_value(key, lists) {
			return item
		}
	}
	return ''
}

fn template_list_values(path string, scalars map[string]string, lists map[string][]string) []string {
	key := path.trim_space()
	if key == '' {
		return []string{}
	}
	if key in lists {
		if items := lists[key] {
			return items.clone()
		}
	}
	alias := alias_template_key(key)
	if alias in lists {
		if items := lists[alias] {
			return items.clone()
		}
	}
	return parse_for_items(template_scalar_value_with_lists(key, scalars, lists))
}

fn template_indexed_list_item_value(path string, lists map[string][]string) ?string {
	key := path.trim_space()
	if key == '' || !key.ends_with(']') {
		return none
	}
	open_idx := key.last_index('[') or { return none }
	if open_idx <= 0 || open_idx >= key.len - 1 {
		return none
	}
	base := key[..open_idx].trim_space()
	idx_raw := key[open_idx + 1..key.len - 1].trim_space()
	if base == '' || !is_numeric_path_segment(idx_raw) {
		return none
	}
	items := template_list_values(base, map[string]string{}, lists)
	idx := idx_raw.int()
	if idx < 0 || idx >= items.len {
		return none
	}
	return items[idx]
}

fn template_object_value(path string, objects map[string]vphp.PhpValue) ?vphp.PhpValue {
	key := path.trim_space()
	if key == '' {
		return none
	}
	if key in objects {
		if obj := objects[key] {
			return obj.owned()
		}
	}
	alias := alias_template_key(key)
	if alias in objects {
		if obj := objects[alias] {
			return obj.owned()
		}
	}
	return none
}

fn populate_indexed_item_fields(loop_key string, idx string, scalars map[string]string, mut local map[string]string) {
	prefix_dot := '${loop_key}.${idx}.'
	prefix_bracket := '${loop_key}[${idx}].'
	for key, value in scalars {
		if key.starts_with(prefix_dot) {
			field := key[prefix_dot.len..]
			if field != '' {
				local['item.${field}'] = value
			}
			continue
		}
		if key.starts_with(prefix_bracket) {
			field := key[prefix_bracket.len..]
			if field != '' {
				local['item.${field}'] = value
			}
		}
	}
}

fn (subject PhpValueSubject) template_data() (map[string]string, map[string][]string, map[string]vphp.PhpValue) {
	data := subject.value
	mut scalars := map[string]string{}
	mut lists := map[string][]string{}
	mut objects := map[string]vphp.PhpValue{}
	if !data.is_valid() || (!data.is_array() && !data.is_object()) {
		return scalars, lists, objects
	}
	collect_template_values('', data, mut scalars, mut lists, mut objects, 0)
	return scalars, lists, objects
}

fn collect_template_values(prefix string, value vphp.PhpValue, mut scalars map[string]string, mut lists map[string][]string, mut objects map[string]vphp.PhpValue, depth int) {
	if depth > 8 || !value.is_valid() || value.is_null() || value.is_undef() {
		if prefix != '' && prefix !in scalars {
			scalars[prefix] = ''
		}
		return
	}
	if value.is_array() {
		arr := value.as_array() or { return }
		defer {
			arr.release()
		}
		if is_template_list(value) {
			if template_list_has_complex_items(value) {
				if prefix != '' {
					mut idx_items := []string{}
					for i in 0 .. arr.count() {
						idx_items << '${i}'
					}
					lists[prefix] = idx_items
				}
				for i in 0 .. arr.count() {
					child := arr.index_value(i)
					next_prefix := if prefix == '' { '${i}' } else { '${prefix}.${i}' }
					collect_template_values(next_prefix, child, mut scalars, mut lists, mut
						objects, depth + 1)
				}
			} else {
				items := value_subject(value).template_list_items()
				if prefix != '' {
					lists[prefix] = items
					alias := alias_template_key(prefix)
					if alias != '' && alias != prefix {
						lists[alias] = items
					}
					if prefix !in scalars {
						scalars[prefix] = items.join(',')
					}
					if alias != '' && alias != prefix && alias !in scalars {
						scalars[alias] = items.join(',')
					}
				}
			}
			return
		}
		for key_name in arr.assoc_keys() {
			child := arr.value_at(key_name)
			next_prefix := if prefix == '' { key_name } else { '${prefix}.${key_name}' }
			collect_template_values(next_prefix, child, mut scalars, mut lists, mut objects,
				depth + 1)
		}
		return
	}
	if value.is_object() {
		if prefix != '' {
			objects[prefix] = value.owned()
			alias := alias_template_key(prefix)
			if alias != '' && alias != prefix {
				objects[alias] = value.owned()
			}
		}
		mut props_value := vphp.PhpFunction.named('get_object_vars').invoke(value)
		defer {
			props_value.release()
		}
		if props := props_value.as_array() {
			defer {
				props.release()
			}
			for key_name in props.assoc_keys() {
				child := props.value_at(key_name)
				next_prefix := if prefix == '' { key_name } else { '${prefix}.${key_name}' }
				collect_template_values(next_prefix, child, mut scalars, mut lists, mut objects,
					depth + 1)
			}
		}
		return
	}
	if prefix != '' {
		scalars[prefix] = to_template_scalar(value)
		alias := alias_template_key(prefix)
		if alias != '' && alias != prefix {
			scalars[alias] = scalars[prefix]
		}
	}
}

fn alias_template_key(path string) string {
	if path == '' {
		return path
	}
	parts := path.split('.')
	mut out := []string{}
	for idx, part in parts {
		if part == '' {
			continue
		}
		is_num := is_numeric_path_segment(part)
		if is_num {
			if out.len == 0 {
				out << '[${part}]'
			} else {
				out[out.len - 1] = out[out.len - 1] + '[${part}]'
			}
			continue
		}
		if idx == 0 {
			out << part
		} else {
			out << '.${part}'
		}
	}
	return out.join('')
}

fn is_numeric_path_segment(part string) bool {
	if part.len == 0 {
		return false
	}
	for ch in part {
		if !ch.is_digit() {
			return false
		}
	}
	return true
}

fn is_template_list(value vphp.PhpValue) bool {
	arr := value.as_array() or { return false }
	defer {
		arr.release()
	}
	return arr.is_list()
}

fn (subject PhpValueSubject) template_list_items() []string {
	mut items := []string{}
	value := subject.value
	arr := value.as_array() or { return items }
	defer {
		arr.release()
	}
	for item in arr.value_items() {
		items << to_template_scalar(item)
	}
	return items
}

fn template_list_has_complex_items(value vphp.PhpValue) bool {
	arr := value.as_array() or { return false }
	defer {
		arr.release()
	}
	for item in arr.value_items() {
		if item.is_array() || item.is_object() {
			return true
		}
	}
	return false
}

fn to_template_scalar(value vphp.PhpValue) string {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return ''
	}
	if value.is_bool() {
		return if value.to_bool() { '1' } else { '0' }
	}
	return value.to_string()
}

fn parse_for_items(raw string) []string {
	mut out := []string{}
	if raw.trim_space() == '' {
		return out
	}
	for part in raw.split(',') {
		item := part.trim_space()
		if item != '' {
			out << item
		}
	}
	return out
}

fn is_truthy_template_value(raw string) bool {
	value := raw.trim_space().to_lower()
	if value == '' {
		return false
	}
	return value !in ['0', 'false', 'no', 'off', 'null']
}

pub fn escape_html_text(input string) string {
	mut out := input
	out = out.replace('&', '&amp;')
	out = out.replace('<', '&lt;')
	out = out.replace('>', '&gt;')
	out = out.replace('"', '&quot;')
	out = out.replace("'", '&#39;')
	return out
}

pub fn normalize_assets_prefix(prefix string) string {
	mut clean := prefix.trim_space()
	if clean == '' {
		return '/assets'
	}
	if !clean.starts_with('/') {
		clean = '/${clean}'
	}
	return clean.trim_right('/')
}

pub fn (mut view VSlimView) cleanup() {
	// helpers is a direct bridge-owned field, so generic_free_raw() will
	// release it after cleanup() returns.
	$if nongc ? {
		unsafe {
			view.base_path.free()
			view.assets_prefix.free()
		}
	}
}

module main

import math
import os
import vphp

fn reduce_template_values(items []string, reducer string, seed string) (string, string) {
	if items.len == 0 && seed.trim_space() == '' {
		return '', ''
	}
	mut reducer_expr := reducer.trim_space()
	if reducer_expr == '' {
		reducer_expr = 'acc+item'
	}
	if reducer_expr.to_lower() == 'avg' {
		mut sum := 0.0
		mut count := 0
		if seed.trim_space() != '' && is_numeric_template_value(seed.trim_space()) {
			sum = seed.trim_space().f64()
			count = 1
		}
		for item in items {
			raw := item.trim_space()
			if !is_numeric_template_value(raw) {
				continue
			}
			sum += raw.f64()
			count++
		}
		if count == 0 {
			return '', ''
		}
		return format_reduced_number(sum / f64(count)), ''
	}
	mut acc := 0.0
	if seed.trim_space() != '' && is_numeric_template_value(seed.trim_space()) {
		acc = seed.trim_space().f64()
	}
	mut seen := seed.trim_space() != ''
	mut last_err := ''
	for item in items {
		raw := item.trim_space()
		if !is_numeric_template_value(raw) {
			continue
		}
		value := raw.f64()
		if !seen && (reducer_expr.to_lower() == 'min' || reducer_expr.to_lower() == 'max') {
			acc = value
			seen = true
			continue
		}
		if !seen {
			acc = 0.0
			seen = true
		}
		if named := apply_named_reducer(reducer_expr, acc, value) {
			acc = named
		} else {
			acc = eval_reduce_expr(reducer_expr, acc, value) or {
				last_err = err.msg()
				acc
			}
		}
	}
	if !seen {
		return '', last_err
	}
	return format_reduced_number(acc), last_err
}

fn apply_named_reducer(name string, acc f64, item f64) ?f64 {
	match name.trim_space().to_lower() {
		'sum', 'add' { return acc + item }
		'count' { return acc + 1.0 }
		'min' { return if acc < item { acc } else { item } }
		'max' { return if acc > item { acc } else { item } }
		else { return none }
	}
}

struct ReduceExprParser {
	src string
mut:
	pos  int
	acc  f64
	item f64
}

fn eval_reduce_expr(expr string, acc f64, item f64) !f64 {
	mut p := ReduceExprParser{
		src:  expr
		acc:  acc
		item: item
	}
	value := p.parse_expr()!
	p.skip_ws()
	if p.pos < p.src.len {
		return error('unexpected token')
	}
	return value
}

fn (mut p ReduceExprParser) parse_expr() !f64 {
	mut left := p.parse_term()!
	for {
		p.skip_ws()
		if p.match_char(`+`) {
			left += p.parse_term()!
		} else if p.match_char(`-`) {
			left -= p.parse_term()!
		} else {
			break
		}
	}
	return left
}

fn (mut p ReduceExprParser) parse_term() !f64 {
	mut left := p.parse_factor()!
	for {
		p.skip_ws()
		if p.match_char(`*`) {
			left *= p.parse_factor()!
		} else if p.match_char(`/`) {
			right := p.parse_factor()!
			if math.abs(right) < 1e-12 {
				return error('division by zero')
			}
			left /= right
		} else {
			break
		}
	}
	return left
}

fn (mut p ReduceExprParser) parse_factor() !f64 {
	p.skip_ws()
	if p.match_char(`+`) {
		return p.parse_factor()!
	}
	if p.match_char(`-`) {
		return -p.parse_factor()!
	}
	if p.match_char(`(`) {
		value := p.parse_expr()!
		p.skip_ws()
		if !p.match_char(`)`) {
			return error('missing )')
		}
		return value
	}
	if ident := p.parse_ident() {
		match ident {
			'acc' { return p.acc }
			'item' { return p.item }
			else { return error('unknown identifier') }
		}
	}
	if num := p.parse_number() {
		return num
	}
	return error('invalid factor')
}

fn (mut p ReduceExprParser) parse_ident() ?string {
	p.skip_ws()
	if p.pos >= p.src.len {
		return none
	}
	first := p.src[p.pos]
	if !first.is_letter() && first != `_` {
		return none
	}
	start := p.pos
	for p.pos < p.src.len {
		ch := p.src[p.pos]
		if ch.is_letter() || ch.is_digit() || ch == `_` {
			p.pos++
			continue
		}
		break
	}
	if p.pos == start {
		return none
	}
	return p.src[start..p.pos]
}

fn (mut p ReduceExprParser) parse_number() ?f64 {
	p.skip_ws()
	start := p.pos
	mut seen_dot := false
	for p.pos < p.src.len {
		ch := p.src[p.pos]
		if ch.is_digit() {
			p.pos++
			continue
		}
		if ch == `.` && !seen_dot {
			seen_dot = true
			p.pos++
			continue
		}
		break
	}
	if p.pos == start {
		return none
	}
	raw := p.src[start..p.pos]
	return raw.f64()
}

fn (mut p ReduceExprParser) skip_ws() {
	for p.pos < p.src.len && p.src[p.pos].is_space() {
		p.pos++
	}
}

fn (mut p ReduceExprParser) match_char(ch u8) bool {
	if p.pos < p.src.len && p.src[p.pos] == ch {
		p.pos++
		return true
	}
	return false
}

fn format_reduced_number(value f64) string {
	as_int := i64(value)
	if math.abs(value - f64(as_int)) < 1e-9 {
		return '${as_int}'
	}
	return '${value}'
}

fn is_numeric_template_value(raw string) bool {
	if raw == '' {
		return false
	}
	mut seen_digit := false
	mut seen_dot := false
	for i, ch in raw {
		if (ch == `+` || ch == `-`) && i == 0 {
			continue
		}
		if ch == `.` {
			if seen_dot {
				return false
			}
			seen_dot = true
			continue
		}
		if !ch.is_digit() {
			return false
		}
		seen_digit = true
	}
	return seen_digit
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

fn template_object_value(path string, objects map[string]vphp.RequestOwnedZBox) ?vphp.RequestOwnedZBox {
	key := path.trim_space()
	if key == '' {
		return none
	}
	if key in objects {
		if obj := objects[key] {
			return obj.clone_request_owned()
		}
	}
	alias := alias_template_key(key)
	if alias in objects {
		if obj := objects[alias] {
			return obj.clone_request_owned()
		}
	}
	return none
}

fn template_object_children(value vphp.ZVal) map[string]vphp.ZVal {
	mut props_box := vphp.PhpFunction.named('get_object_vars').request_owned(vphp.PhpValue.from_zval(value))
	props := props_box.take_zval()
	if props.is_array() {
		mut out := map[string]vphp.ZVal{}
		for key in props.assoc_keys() {
			out[key] = props.get(key) or { continue }
		}
		if out.len > 0 {
			return out
		}
	}
	return value.fold[map[string]vphp.ZVal](map[string]vphp.ZVal{}, fn (key vphp.ZVal, val vphp.ZVal, mut acc map[string]vphp.ZVal) {
		key_name := key.to_string().trim_space()
		if key_name == '' {
			return
		}
		acc[key_name] = val
	})
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

fn extract_template_data(data vphp.ZVal) (map[string]string, map[string][]string, map[string]vphp.RequestOwnedZBox) {
	mut scalars := map[string]string{}
	mut lists := map[string][]string{}
	mut objects := map[string]vphp.RequestOwnedZBox{}
	if !data.is_valid() || (!data.is_array() && !data.is_object()) {
		return scalars, lists, objects
	}
	collect_template_values('', data, mut scalars, mut lists, mut objects, 0)
	return scalars, lists, objects
}

fn collect_template_values(prefix string, value vphp.ZVal, mut scalars map[string]string, mut lists map[string][]string, mut objects map[string]vphp.RequestOwnedZBox, depth int) {
	if depth > 8 || !value.is_valid() || value.is_null() || value.is_undef() {
		if prefix != '' && prefix !in scalars {
			scalars[prefix] = ''
		}
		return
	}
	if value.is_array() {
		if is_template_list(value) {
			if template_list_has_complex_items(value) {
				if prefix != '' {
					mut idx_items := []string{}
					for i in 0 .. value.array_count() {
						idx_items << '${i}'
					}
					lists[prefix] = idx_items
				}
				for i in 0 .. value.array_count() {
					child := value.array_get(i)
					next_prefix := if prefix == '' { '${i}' } else { '${prefix}.${i}' }
					collect_template_values(next_prefix, child, mut scalars, mut lists, mut
						objects, depth + 1)
				}
			} else {
				items := extract_template_list_items(value)
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
		children := value.fold[map[string]vphp.ZVal](map[string]vphp.ZVal{}, fn (key vphp.ZVal, val vphp.ZVal, mut acc map[string]vphp.ZVal) {
			key_name := key.to_string().trim_space()
			if key_name == '' {
				return
			}
			acc[key_name] = val
		})
		for key_name, child in children {
			next_prefix := if prefix == '' { key_name } else { '${prefix}.${key_name}' }
			collect_template_values(next_prefix, child, mut scalars, mut lists, mut objects,
				depth + 1)
		}
		return
	}
	if value.is_object() {
		if prefix != '' {
			objects[prefix] = vphp.RequestOwnedZBox.from_zval(value)
			alias := alias_template_key(prefix)
			if alias != '' && alias != prefix {
				objects[alias] = vphp.RequestOwnedZBox.from_zval(value)
			}
		}
		children := template_object_children(value)
		for key_name, child in children {
			next_prefix := if prefix == '' { key_name } else { '${prefix}.${key_name}' }
			collect_template_values(next_prefix, child, mut scalars, mut lists, mut objects,
				depth + 1)
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

fn is_template_list(value vphp.ZVal) bool {
	return value.is_list()
}

fn extract_template_list_items(value vphp.ZVal) []string {
	mut items := []string{}
	for i in 0 .. value.array_count() {
		items << to_template_scalar(value.array_get(i))
	}
	return items
}

fn template_list_has_complex_items(value vphp.ZVal) bool {
	for i in 0 .. value.array_count() {
		item := value.array_get(i)
		if item.is_array() || item.is_object() {
			return true
		}
	}
	return false
}

fn to_template_scalar(value vphp.ZVal) string {
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

fn escape_html_text(input string) string {
	mut out := input
	out = out.replace('&', '&amp;')
	out = out.replace('<', '&lt;')
	out = out.replace('>', '&gt;')
	out = out.replace('"', '&quot;')
	out = out.replace("'", '&#39;')
	return out
}

fn normalize_assets_prefix(prefix string) string {
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

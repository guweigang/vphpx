module main

import math
import vphp

fn (view &VSlimView) invoke_template_helper_values(name string, args []TemplateExprValue, scalars map[string]string, lists map[string][]string, template_path string, line int, col int) string {
	mut zargs := []vphp.ZVal{cap: args.len}
	for arg in args {
		zargs << template_expr_value_to_zval_with_context(arg, scalars, lists)
	}
	return view.invoke_template_helper_zargs(name, zargs, template_path, line, col)
}

fn parse_template_helper_arg_nodes(raw_args string, line int, col int) ([]TemplateExprNode, bool) {
	if raw_args.trim_space() == '' {
		return []TemplateExprNode{}, true
	}
	parts := split_template_expr_args(raw_args)
	if parts.len == 0 {
		return []TemplateExprNode{}, false
	}
	mut nodes := []TemplateExprNode{cap: parts.len}
	mut has_nodes := true
	for part in parts {
		if node := parse_template_helper_arg_node(part, line, col) {
			nodes << node
		} else {
			has_nodes = false
			break
		}
	}
	if !has_nodes {
		return []TemplateExprNode{}, false
	}
	return nodes, true
}

fn parse_template_helper_arg_node(raw string, line int, col int) !TemplateExprNode {
	return parse_template_expr_node(raw, line, col)
}

fn (view &VSlimView) invoke_template_helper_zargs(name string, zargs []vphp.ZVal, template_path string, line int, col int) string {
	key := name.trim_space()
	if key == '' {
		return debug_template_error('helper.invalid', template_path, name, line, col)
	}
	if key !in view.helpers {
		return debug_template_error('helper.missing', template_path, key, line, col)
	}
	handler := view.helpers[key] or { return debug_template_error('helper.missing', template_path, key, line, col) }
	if !handler.is_valid() || !handler.is_callable() {
		return debug_template_error('helper.invalid', template_path, key, line, col)
	}
	return handler.with_fn_result_zval(fn (result vphp.ZVal) string {
		return result.to_string()
	}, ...zargs)
}

fn new_template_list_zval(items []string) vphp.ZVal {
	mut out := vphp.RequestOwnedZBox.new_null().to_zval()
	out.array_init()
	for item in items {
		out.add_next_val(infer_template_scalar_zval(item))
	}
	return out
}

fn new_template_map_zval(path string, scalars map[string]string, lists map[string][]string) vphp.ZVal {
	key := alias_template_key(path.trim_space())
	return build_template_tree_zval(key, scalars, lists)
}

fn build_template_tree_zval(prefix string, scalars map[string]string, lists map[string][]string) vphp.ZVal {
	if prefix == '' {
		return new_template_assoc_zval(prefix, scalars, lists)
	}
	if template_has_list_key(prefix, lists) && !template_has_child_keys(prefix, scalars, lists) {
		return new_template_list_zval(template_list_values(prefix, scalars, lists))
	}
	if !template_has_child_keys(prefix, scalars, lists) {
		return infer_template_scalar_zval(template_scalar_value_with_lists(prefix, scalars, lists))
	}
	return new_template_assoc_zval(prefix, scalars, lists)
}

fn infer_template_scalar_zval(raw string) vphp.ZVal {
	trimmed := raw.trim_space()
	if typed := parse_template_scalar_literal_zval(trimmed) {
		return typed
	}
	return vphp.RequestOwnedZBox.new_string(raw).to_zval()
}

fn parse_template_scalar_literal_zval(raw string) ?vphp.ZVal {
	trimmed := raw.trim_space()
	if trimmed == '' {
		return none
	}
	lower := trimmed.to_lower()
	if lower == 'null' {
		return vphp.RequestOwnedZBox.new_null().to_zval()
	}
	if lower == 'true' {
		return vphp.RequestOwnedZBox.new_bool(true).to_zval()
	}
	if lower == 'false' {
		return vphp.RequestOwnedZBox.new_bool(false).to_zval()
	}
	if is_template_int_literal(trimmed) {
		return vphp.RequestOwnedZBox.new_int(trimmed.i64()).to_zval()
	}
	if is_template_float_literal(trimmed) {
		return vphp.RequestOwnedZBox.new_float(trimmed.f64()).to_zval()
	}
	return none
}

fn is_template_int_literal(raw string) bool {
	if !is_numeric_template_value(raw) || raw.contains('.') {
		return false
	}
	body := if raw.starts_with('+') || raw.starts_with('-') { raw[1..] } else { raw }
	if body.len > 1 && body.starts_with('0') {
		return false
	}
	return body != ''
}

fn is_template_float_literal(raw string) bool {
	if !is_numeric_template_value(raw) || !raw.contains('.') {
		return false
	}
	body := if raw.starts_with('+') || raw.starts_with('-') { raw[1..] } else { raw }
	if body.starts_with('.') || body.ends_with('.') {
		return false
	}
	if body.len > 1 && body.starts_with('0') && body[1] != `.` {
		return false
	}
	return true
}

fn new_template_assoc_zval(prefix string, scalars map[string]string, lists map[string][]string) vphp.ZVal {
	mut out := vphp.RequestOwnedZBox.new_null().to_zval()
	out.array_init()
	for child in template_child_keys(prefix, scalars, lists) {
		child_prefix := if prefix == '' { child } else { '${prefix}.${child}' }
		add_assoc_zval_template(out, child, build_template_tree_zval(child_prefix, scalars, lists))
	}
	return out
}

fn template_has_child_keys(prefix string, scalars map[string]string, lists map[string][]string) bool {
	return template_child_keys(prefix, scalars, lists).len > 0
}

fn template_child_keys(prefix string, scalars map[string]string, lists map[string][]string) []string {
	mut seen := map[string]bool{}
	mut out := []string{}
	base := if prefix == '' { '' } else { '${alias_template_key(prefix)}.' }
	for key in scalars.keys() {
		normalized := alias_template_key(key)
		if base != '' {
			if !normalized.starts_with(base) {
				continue
			}
			rest := normalized[base.len..]
			if rest == '' {
				continue
			}
			child := rest.all_before('.').trim_space()
			if child != '' && child !in seen {
				seen[child] = true
				out << child
			}
			continue
		}
		if !normalized.contains('.') {
			continue
		}
		child := normalized.all_before('.').trim_space()
		if child != '' && child !in seen {
			seen[child] = true
			out << child
		}
	}
	for key in lists.keys() {
		normalized := alias_template_key(key)
		if base != '' {
			if !normalized.starts_with(base) {
				continue
			}
			rest := normalized[base.len..]
			if rest == '' {
				continue
			}
			child := rest.all_before('.').trim_space()
			if child != '' && child !in seen {
				seen[child] = true
				out << child
			}
			continue
		}
		if !normalized.contains('.') {
			continue
		}
		child := normalized.all_before('.').trim_space()
		if child != '' && child !in seen {
			seen[child] = true
			out << child
		}
	}
	return out
}

fn add_assoc_zval_template(target vphp.ZVal, key string, child vphp.ZVal) {
	unsafe {
		C.vphp_array_add_assoc_zval(target.raw, &char(key.str), child.raw)
	}
}

fn split_template_top_level_segments(raw string, seps []u8) []string {
	if raw.trim_space() == '' {
		return []string{}
	}
	mut out := []string{}
	mut quote := u8(0)
	mut paren_depth := 0
	mut start := 0
	for i, ch in raw {
		if quote == 0 && (ch == `'` || ch == `"`) {
			quote = u8(ch)
			continue
		}
		if quote != 0 && ch == rune(quote) {
			quote = 0
			continue
		}
		if quote == 0 && ch == `(` {
			paren_depth++
			continue
		}
		if quote == 0 && ch == `)` && paren_depth > 0 {
			paren_depth--
			continue
		}
		if quote == 0 && paren_depth == 0 && u8(ch) in seps {
			out << raw[start..i].trim_space()
			start = i + 1
		}
	}
	out << raw[start..].trim_space()
	return out.filter(it != '')
}

fn copy_template_branch(source_path string, target_path string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, mut out_scalars map[string]string, mut out_lists map[string][]string, mut out_objects map[string]vphp.RequestOwnedZBox) {
	source_prefix := alias_template_key(source_path.trim_space())
	target_prefix := alias_template_key(target_path.trim_space())
	if source_prefix == '' || target_prefix == '' {
		return
	}
	mut copied := false
	source_base := '${source_prefix}.'
	for key, value in scalars {
		normalized := alias_template_key(key)
		if normalized == source_prefix {
			out_scalars[target_prefix] = value
			copied = true
			continue
		}
		if !normalized.starts_with(source_base) {
			continue
		}
		suffix := normalized[source_base.len..]
		if suffix == '' {
			continue
		}
		out_scalars['${target_prefix}.${suffix}'] = value
		copied = true
	}
	for key, value in lists {
		normalized := alias_template_key(key)
		if normalized == source_prefix {
			out_lists[target_prefix] = value.clone()
			out_scalars[target_prefix] = value.join(',')
			copied = true
			continue
		}
		if !normalized.starts_with(source_base) {
			continue
		}
		suffix := normalized[source_base.len..]
		if suffix == '' {
			continue
		}
		target_key := '${target_prefix}.${suffix}'
		out_lists[target_key] = value.clone()
		out_scalars[target_key] = value.join(',')
		copied = true
	}
	for key, value in objects {
		normalized := alias_template_key(key)
		if normalized == source_prefix {
			out_objects[target_prefix] = value.clone_request_owned()
			copied = true
			continue
		}
		if !normalized.starts_with(source_base) {
			continue
		}
		suffix := normalized[source_base.len..]
		if suffix == '' {
			continue
		}
		out_objects['${target_prefix}.${suffix}'] = value.clone_request_owned()
		copied = true
	}
	if copied {
		return
	}
	value := template_scalar_value_with_lists(source_prefix, scalars, lists)
	if value != '' {
		out_scalars[target_prefix] = value
		return
	}
	items := template_list_values(source_prefix, scalars, lists)
	if items.len > 0 {
		out_lists[target_prefix] = items.clone()
		out_scalars[target_prefix] = items.join(',')
	}
}

fn split_include_assignments(raw string) []string {
	return split_template_top_level_segments(raw, [u8(`|`), u8(`,`)])
}

fn clone_template_lists(src map[string][]string) map[string][]string {
	mut out := map[string][]string{}
	for key, value in src {
		out[key] = value.clone()
	}
	return out
}

fn clone_template_objects(src map[string]vphp.RequestOwnedZBox) map[string]vphp.RequestOwnedZBox {
	mut out := map[string]vphp.RequestOwnedZBox{}
	for key, value in src {
		out[key] = value.clone_request_owned()
	}
	return out
}

fn template_quoted_literal(raw string) ?string {
	trimmed := raw.trim_space()
	if trimmed.len < 2 {
		return none
	}
	first := trimmed[0]
	last := trimmed[trimmed.len - 1]
	if (first == `"` && last == `"`) || (first == `'` && last == `'`) {
		return trimmed[1..trimmed.len - 1]
	}
	return none
}


fn template_compare_equal_values(left string, right string) bool {
	left_trimmed := left.trim_space()
	right_trimmed := right.trim_space()
	if left_trimmed == '' || right_trimmed == '' {
		if is_template_null_literal(left_trimmed) && right_trimmed == '' {
			return true
		}
		if is_template_null_literal(right_trimmed) && left_trimmed == '' {
			return true
		}
		return left == right
	}
	if left_bool := parse_template_bool_literal(left_trimmed) {
		if right_bool := parse_template_bool_literal(right_trimmed) {
			return left_bool == right_bool
		}
	}
	if left_boolish := parse_template_boolish_value(left_trimmed) {
		if right_bool := parse_template_bool_literal(right_trimmed) {
			return left_boolish == right_bool
		}
	}
	if right_boolish := parse_template_boolish_value(right_trimmed) {
		if left_bool := parse_template_bool_literal(left_trimmed) {
			return right_boolish == left_bool
		}
	}
	if is_template_null_literal(left_trimmed) && is_template_null_literal(right_trimmed) {
		return true
	}
	if is_numeric_template_value(left_trimmed) && is_numeric_template_value(right_trimmed) {
		return math.abs(left_trimmed.f64() - right_trimmed.f64()) < 1e-9
	}
	return left == right
}

fn parse_template_bool_literal(raw string) ?bool {
	match raw.to_lower() {
		'true' { return true }
		'false' { return false }
		else { return none }
	}
}

fn parse_template_boolish_value(raw string) ?bool {
	match raw.to_lower() {
		'1', 'true' { return true }
		'0', 'false' { return false }
		else { return none }
	}
}

fn is_template_null_literal(raw string) bool {
	return raw.to_lower() == 'null'
}

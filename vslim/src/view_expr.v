module main

import os
import vphp

fn (view &VSlimView) resolve_template_path(template string) string {
	clean := template.trim_space()
	if clean == '' {
		return ''
	}
	if clean.starts_with('/') {
		return clean
	}
	if view.base_path == '' {
		return clean
	}
	return os.join_path(view.base_path, clean)
}

fn new_template_expr_scalar(value string) TemplateExprValue {
	return TemplateExprValue{
		kind: .scalar
		scalar: value
	}
}

fn new_template_expr_scalar_typed(value string, explicit_type string) TemplateExprValue {
	return TemplateExprValue{
		kind: .scalar
		scalar: value
		explicit_type: explicit_type
	}
}

fn new_template_expr_list(items []string) TemplateExprValue {
	return TemplateExprValue{
		kind: .list
		list: items.clone()
	}
}

fn new_template_expr_map(path string) TemplateExprValue {
	return TemplateExprValue{
		kind: .map
		map_path: path.trim_space()
	}
}

fn new_template_expr_object(value vphp.RequestOwnedZVal) TemplateExprValue {
	return TemplateExprValue{
		kind: .object
		object: value.clone_request_owned()
	}
}

fn template_expr_value_string(value TemplateExprValue) string {
	if value.kind == .object {
		return value.object.to_string()
	}
	if value.kind == .map {
		return value.map_path
	}
	if value.kind == .list {
		return value.list.join(',')
	}
	return value.scalar
}

fn template_expr_value_as_list(value TemplateExprValue) []string {
	if value.kind == .list {
		return value.list.clone()
	}
	if value.kind == .map {
		return []string{}
	}
	if value.kind == .object {
		return []string{}
	}
	raw := value.scalar.trim_space()
	if raw == '' {
		return []string{}
	}
	return parse_for_items(value.scalar)
}

fn template_expr_value_to_zval(value TemplateExprValue) vphp.ZVal {
	if value.kind == .map {
		return new_template_map_zval(value.map_path, map[string]string{}, map[string][]string{})
	}
	if value.kind == .list {
		return new_template_list_zval(value.list)
	}
	if value.kind == .object {
		return value.object.clone_request_owned().to_zval()
	}
	match value.explicit_type {
		'string' {
			return vphp.RequestOwnedZVal.new_string(value.scalar).to_zval()
		}
		'null' {
			return vphp.RequestOwnedZVal.new_null().to_zval()
		}
		'bool' {
			return vphp.RequestOwnedZVal.new_bool(parse_template_boolish_value(value.scalar) or { false }).to_zval()
		}
		'int' {
			return vphp.RequestOwnedZVal.new_int(value.scalar.trim_space().i64()).to_zval()
		}
		'float' {
			return vphp.RequestOwnedZVal.new_float(value.scalar.trim_space().f64()).to_zval()
		}
		else {
			return infer_template_scalar_zval(value.scalar)
		}
	}
}

fn template_expr_value_to_zval_with_context(value TemplateExprValue, scalars map[string]string, lists map[string][]string) vphp.ZVal {
	if value.kind == .map {
		return new_template_map_zval(value.map_path, scalars, lists)
	}
	return template_expr_value_to_zval(value)
}

fn (view &VSlimView) eval_template_expression(raw string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZVal, template_path string, line int, col int) TemplateExprValue {
	trimmed := raw.trim_space()
	if trimmed == '' {
		return new_template_expr_scalar('')
	}
	node := parse_template_expr_node(trimmed, line, col) or {
		return new_template_expr_scalar(debug_template_error('expr.pipe', template_path, raw, line, col))
	}
	return view.eval_template_expr_node(node, scalars, lists, objects, template_path, line, col)
}

fn (view &VSlimView) eval_template_expr_node(node TemplateExprNode, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZVal, template_path string, line int, col int) TemplateExprValue {
	match node.kind {
		.literal {
			return new_template_expr_scalar_typed(node.value, node.explicit_type)
		}
		.path {
			if template_has_list_key(node.name, lists) {
				return new_template_expr_list(template_list_values(node.name, scalars, lists))
			}
			if object := template_object_value(node.name, objects) {
				return new_template_expr_object(object)
			}
			return new_template_expr_scalar(template_scalar_value_with_lists(node.name, scalars, lists))
		}
		.cast {
			if node.args.len == 0 {
				return new_template_expr_scalar_typed('', node.explicit_type)
			}
			value := view.eval_template_expr_node(node.args[0], scalars, lists, objects, template_path, line, col)
			return template_expr_value_cast(value, node.explicit_type)
		}
		.map_path {
			return new_template_expr_map(node.name)
		}
		.call {
			mut args := []TemplateExprValue{cap: node.args.len}
			for arg in node.args {
				args << view.eval_template_expr_node(arg, scalars, lists, objects, template_path, line, col)
			}
			return view.eval_template_expr_callable(node.name, args, scalars, lists, objects, template_path, node.line, node.col)
		}
		.method_call {
			mut args := []TemplateExprValue{cap: node.args.len}
			for arg in node.args {
				args << view.eval_template_expr_node(arg, scalars, lists, objects, template_path, line, col)
			}
			raw := if node.raw != '' { node.raw } else { template_expr_node_string(node) }
			return view.invoke_template_expr_method(node.name, args, template_path, raw, node.line, node.col) or {
				new_template_expr_scalar(debug_template_error('method.missing', template_path, raw, node.line, node.col))
			}
		}
	}
}

fn (view &VSlimView) eval_template_expr_callable(name string, args []TemplateExprValue, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZVal, template_path string, line int, col int) TemplateExprValue {
	key := name.trim_space().to_lower()
	if key == '' {
		return new_template_expr_scalar('')
	}
	match key {
		'trim' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			return new_template_expr_scalar(template_expr_value_string(args[0]).trim_space())
		}
		'first' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			items := template_expr_value_as_list(args[0])
			if items.len == 0 {
				return new_template_expr_scalar('')
			}
			return new_template_expr_scalar(items[0])
		}
		'last' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			items := template_expr_value_as_list(args[0])
			if items.len == 0 {
				return new_template_expr_scalar('')
			}
			return new_template_expr_scalar(items[items.len - 1])
		}
		'join' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			items := template_expr_value_as_list(args[0])
			sep := if args.len >= 2 { template_expr_value_string(args[1]) } else { ',' }
			return new_template_expr_scalar(items.join(sep))
		}
		'asset' {
			if args.len == 0 {
				return new_template_expr_scalar(view.asset(''))
			}
			return new_template_expr_scalar(view.asset(template_expr_value_string(args[0])))
		}
		'default' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			value := template_expr_value_string(args[0])
			if value != '' {
				return new_template_expr_scalar(value)
			}
			if args.len >= 2 {
				return new_template_expr_scalar(template_expr_value_string(args[1]))
			}
			return new_template_expr_scalar('')
		}
		'empty' {
			if args.len == 0 {
				return new_template_expr_scalar_typed('true', 'bool')
			}
			return new_template_expr_scalar_typed(if template_expr_value_string(args[0]).trim_space() == '' { 'true' } else { 'false' }, 'bool')
		}
		'contains' {
			if args.len < 2 {
				return new_template_expr_scalar_typed('false', 'bool')
			}
			left := args[0]
			right := args[1]
			mut found := false
			if left.kind == .list {
				for item in left.list {
					if template_compare_equal_values(item, template_expr_value_string(right)) {
						found = true
						break
					}
				}
			} else {
				found = template_expr_value_string(left).contains(template_expr_value_string(right))
			}
			return new_template_expr_scalar_typed(if found { 'true' } else { 'false' }, 'bool')
		}
		'in' {
			if args.len < 2 {
				return new_template_expr_scalar_typed('false', 'bool')
			}
			value := template_expr_value_string(args[0])
			mut found := false
			items := template_expr_value_as_list(args[1])
			for item in items {
				if template_compare_equal_values(item, value) {
					found = true
					break
				}
			}
			return new_template_expr_scalar_typed(if found { 'true' } else { 'false' }, 'bool')
		}
		'reduce' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			items := template_expr_value_as_list(args[0])
			reducer := if args.len >= 2 {
				template_expr_value_string(args[1]).trim_space()
			} else {
				'acc+item'
			}
			seed := if args.len >= 3 { template_expr_value_string(args[2]) } else { '' }
			value, err_msg := reduce_template_values(items, reducer, seed)
			if err_msg != '' && is_view_debug_enabled() {
				return new_template_expr_scalar('[vslim.reduce.error reducer=${reducer} seed=${seed} reason=${err_msg}]')
			}
			return new_template_expr_scalar(value)
		}
		'upper' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			return new_template_expr_scalar(template_expr_value_string(args[0]).to_upper())
		}
		'lower' {
			if args.len == 0 {
				return new_template_expr_scalar('')
			}
			return new_template_expr_scalar(template_expr_value_string(args[0]).to_lower())
		}
		else {
			if method_value := view.invoke_template_expr_method(name, args, template_path, name, line, col) {
				return method_value
			}
			return new_template_expr_scalar(view.invoke_template_helper_values(name, args, scalars, lists, template_path, line, col))
		}
	}
}

struct TemplateExprCall {
	name string
	args []string
}

struct TemplateExprMethodCall {
	target string
	name   string
	args   []string
}

fn parse_template_expr_node(raw string, line int, col int) !TemplateExprNode {
	trimmed, node_col := trim_template_expr_with_col(raw, col)
	if trimmed == '' {
		return TemplateExprNode{
			kind:          .literal
			value:         ''
			explicit_type: 'string'
			raw:           ''
			line:          line
			col:           node_col
		}
	}
	pipe_parts := split_template_expr_pipes_with_pos(trimmed, node_col)
	if pipe_parts.len > 1 {
		mut current := parse_template_expr_node(pipe_parts[0].text, line, pipe_parts[0].col)!
		for segment in pipe_parts[1..] {
			name, arg_exprs := parse_template_expr_pipe_stage(segment.text)!
			mut args := []TemplateExprNode{cap: arg_exprs.len + 1}
			args << current
			arg_segments := split_template_expr_args_with_pos(extract_template_call_args(segment.text) or { '' }, segment.col)
			for i, arg_expr in arg_exprs {
				arg_col := if i < arg_segments.len { arg_segments[i].col } else { segment.col }
				args << parse_template_expr_node(arg_expr, line, arg_col)!
			}
			current = TemplateExprNode{
				kind: .call
				name: name
				args: args
				raw:  segment.text
				line: line
				col:  segment.col
			}
		}
		return current
	}
	if method_call := parse_template_expr_method_call(trimmed) {
		mut args := []TemplateExprNode{cap: method_call.args.len + 1}
		target_col := node_col
		args << parse_template_expr_node(method_call.target, line, target_col)!
		arg_segments := split_template_expr_args_with_pos(extract_template_call_args(trimmed) or { '' }, node_col + (trimmed.index('(') or { trimmed.len }))
		for i, arg_expr in method_call.args {
			arg_col := if i < arg_segments.len { arg_segments[i].col } else { node_col }
			args << parse_template_expr_node(arg_expr, line, arg_col)!
		}
		method_col := node_col + (trimmed.last_index('.') or { 0 }) + 1
		return TemplateExprNode{
			kind: .method_call
			name: method_call.name
			args: args
			raw:  trimmed
			line: line
			col:  method_col
		}
	}
	if call := parse_template_expr_call(trimmed) {
		lower_name := call.name.trim_space().to_lower()
		if call.args.len == 1 && lower_name in ['int', 'float', 'bool', 'string'] {
			return TemplateExprNode{
				kind:          .cast
				explicit_type: lower_name
				args:          [parse_template_expr_node(call.args[0], line, node_col + lower_name.len + 1)!]
				raw:           trimmed
				line:          line
				col:           node_col
			}
		}
		if call.args.len == 1 && lower_name == 'map' {
			return TemplateExprNode{
				kind: .map_path
				name: call.args[0].trim_space()
				raw:  trimmed
				line: line
				col:  node_col + 4
			}
		}
		if call.args.len == 1 && lower_name == 'list' {
			return parse_template_expr_node(call.args[0], line, node_col + 5)
		}
		mut args := []TemplateExprNode{cap: call.args.len}
		arg_segments := split_template_expr_args_with_pos(extract_template_call_args(trimmed) or { '' }, node_col + (trimmed.index('(') or { trimmed.len }))
		for i, arg_expr in call.args {
			arg_col := if i < arg_segments.len { arg_segments[i].col } else { node_col }
			args << parse_template_expr_node(arg_expr, line, arg_col)!
		}
		return TemplateExprNode{
			kind: .call
			name: call.name
			args: args
			raw:  trimmed
			line: line
			col:  node_col
		}
	}
	if literal := template_quoted_literal(trimmed) {
		return TemplateExprNode{
			kind:          .literal
			value:         literal
			explicit_type: 'string'
			raw:           trimmed
			line:          line
			col:           node_col
		}
	}
	lower := trimmed.to_lower()
	if lower == 'null' {
		return TemplateExprNode{
			kind:          .literal
			value:         'null'
			explicit_type: 'null'
			raw:           trimmed
			line:          line
			col:           node_col
		}
	}
	if lower == 'true' || lower == 'false' {
		return TemplateExprNode{
			kind:          .literal
			value:         lower
			explicit_type: 'bool'
			raw:           trimmed
			line:          line
			col:           node_col
		}
	}
	if is_template_int_literal(trimmed) {
		return TemplateExprNode{
			kind:          .literal
			value:         trimmed
			explicit_type: 'int'
			raw:           trimmed
			line:          line
			col:           node_col
		}
	}
	if is_template_float_literal(trimmed) {
		return TemplateExprNode{
			kind:          .literal
			value:         trimmed
			explicit_type: 'float'
			raw:           trimmed
			line:          line
			col:           node_col
		}
	}
	return TemplateExprNode{
		kind: .path
		name: trimmed
		raw:  trimmed
		line: line
		col:  node_col
	}
}

fn template_expr_node_string(node TemplateExprNode) string {
	match node.kind {
		.literal {
			if node.explicit_type == 'string' {
				return '"${node.value}"'
			}
			return node.value
		}
		.path {
			return node.name
		}
		.cast {
			if node.args.len == 0 {
				return '${node.explicit_type}:'
			}
			return '${node.explicit_type}:${template_expr_node_string(node.args[0])}'
		}
		.map_path {
			return 'map:${node.name}'
		}
		.call {
			mut parts := []string{cap: node.args.len}
			for arg in node.args {
				parts << template_expr_node_string(arg)
			}
			return '${node.name}(${parts.join(", ")})'
		}
		.method_call {
			if node.args.len == 0 {
				return '${node.name}()'
			}
			mut parts := []string{}
			for arg in node.args[1..] {
				parts << template_expr_node_string(arg)
			}
			return '${template_expr_node_string(node.args[0])}.${node.name}(${parts.join(", ")})'
		}
	}
}

fn (view &VSlimView) invoke_template_expr_method(name string, args []TemplateExprValue, template_path string, raw string, line int, col int) ?TemplateExprValue {
	if args.len == 0 || args[0].kind != .object {
		return none
	}
	method := name.trim_space()
	if method == '' || !args[0].object.method_exists(method) {
		return new_template_expr_scalar(debug_template_error('method.missing', template_path, raw, line, col))
	}
	mut zargs := []vphp.ZVal{cap: if args.len > 1 { args.len - 1 } else { 0 }}
	for arg in args[1..] {
		zargs << template_expr_value_to_zval(arg)
	}
	result := args[0].object.method_owned_request(method, zargs)
	if !result.is_valid() || result.is_undef() || result.is_null() {
		return new_template_expr_scalar_typed('null', 'null')
	}
	if result.is_array() && result.is_list() {
		return new_template_expr_list(result.to_string_list())
	}
	if result.is_object() {
		return new_template_expr_object(vphp.RequestOwnedZVal.from_zval(result))
	}
	return new_template_expr_scalar(result.to_string())
}

fn parse_template_expr_pipe_stage(raw string) !(string, []string) {
	trimmed := raw.trim_space()
	if trimmed == '' {
		return error('empty pipe stage')
	}
	if call := parse_template_expr_call(trimmed) {
		return call.name, call.args
	}
	if !is_template_identifier(trimmed) {
		return error('invalid pipe stage')
	}
	return trimmed, []string{}
}

fn parse_template_expr_method_call(raw string) ?TemplateExprMethodCall {
	trimmed := raw.trim_space()
	if trimmed == '' || !trimmed.ends_with(')') {
		return none
	}
	open_idx := find_template_call_open_paren(trimmed) or { return none }
	callee := trimmed[..open_idx].trim_space()
	if !callee.contains('.') {
		return none
	}
	last_dot := callee.last_index('.') or { return none }
	if last_dot <= 0 || last_dot >= callee.len - 1 {
		return none
	}
	target := callee[..last_dot].trim_space()
	method := callee[last_dot + 1..].trim_space()
	if target == '' || !is_template_identifier(method) {
		return none
	}
	args_raw := trimmed[open_idx + 1..trimmed.len - 1]
	return TemplateExprMethodCall{
		target: target
		name: method
		args: split_template_expr_args(args_raw)
	}
}

fn parse_template_expr_call(raw string) ?TemplateExprCall {
	trimmed := raw.trim_space()
	if trimmed == '' || !trimmed.ends_with(')') {
		return none
	}
	open_idx := find_template_call_open_paren(trimmed) or { return none }
	name := trimmed[..open_idx].trim_space()
	if !is_template_identifier(name) {
		return none
	}
	args_raw := trimmed[open_idx + 1..trimmed.len - 1]
	return TemplateExprCall{
		name: name
		args: split_template_expr_args(args_raw)
	}
}

fn extract_template_call_args(raw string) ?string {
	trimmed := raw.trim_space()
	if trimmed == '' || !trimmed.ends_with(')') {
		return none
	}
	open_idx := find_template_call_open_paren(trimmed) or { return none }
	return trimmed[open_idx + 1..trimmed.len - 1]
}

fn find_template_call_open_paren(raw string) ?int {
	mut quote := u8(0)
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
			return i
		}
	}
	return none
}

fn split_template_expr_pipes(raw string) []string {
	return split_template_top_level_segments(raw, [u8(`|`)])
}

fn split_template_expr_pipes_with_pos(raw string, base_col int) []TemplateExprSegment {
	return split_template_expr_segments_with_pos(raw, `|`, base_col)
}

fn split_template_expr_args(raw string) []string {
	return split_template_top_level_segments(raw, [u8(`,`)])
}

fn split_template_expr_args_with_pos(raw string, base_col int) []TemplateExprSegment {
	return split_template_expr_segments_with_pos(raw, `,`, base_col)
}

fn split_template_expr_segments_with_pos(raw string, sep u8, base_col int) []TemplateExprSegment {
	if raw.trim_space() == '' {
		return []TemplateExprSegment{}
	}
	mut out := []TemplateExprSegment{}
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
		if quote == 0 && paren_depth == 0 && ch == rune(sep) {
			segment_raw := raw[start..i]
			segment_text, segment_col := trim_template_expr_with_col(segment_raw, base_col + start)
			if segment_text != '' {
				out << TemplateExprSegment{
					text: segment_text
					col:  segment_col
				}
			}
			start = i + 1
		}
	}
	segment_raw := raw[start..]
	segment_text, segment_col := trim_template_expr_with_col(segment_raw, base_col + start)
	if segment_text != '' {
		out << TemplateExprSegment{
			text: segment_text
			col:  segment_col
		}
	}
	return out
}

fn trim_template_expr_with_col(raw string, col int) (string, int) {
	mut start := 0
	for start < raw.len && raw[start].is_space() {
		start++
	}
	mut end := raw.len
	for end > start && raw[end - 1].is_space() {
		end--
	}
	return raw[start..end], col + start
}

fn is_template_identifier(raw string) bool {
	trimmed := raw.trim_space()
	if trimmed == '' {
		return false
	}
	for i, ch in trimmed {
		if i == 0 {
			if !ch.is_letter() && ch != `_` {
				return false
			}
			continue
		}
		if !ch.is_letter() && !ch.is_digit() && ch != `_` {
			return false
		}
	}
	return true
}

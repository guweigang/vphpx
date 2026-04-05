module main

import math
import vphp

fn parse_template_condition_syntax(raw string, line int, col int) !TemplateConditionNode {
	trimmed, node_col := trim_template_expr_with_col(raw, col)
	if trimmed == '' {
		return error('empty condition')
	}
	if trimmed.starts_with('|') {
		return parse_template_condition_node(trimmed[1..])
	}
	if trimmed.starts_with('eq|') {
		left, right := split_condition_args(trimmed[3..])
		return TemplateConditionNode{
			kind: .compare
			op: '=='
			left: parse_template_expr_node(left, line, node_col + 3)!
			right: parse_template_expr_node(right, line, node_col + 3)!
		}
	}
	if trimmed.starts_with('ne|') {
		left, right := split_condition_args(trimmed[3..])
		return TemplateConditionNode{
			kind: .compare
			op: '!='
			left: parse_template_expr_node(left, line, node_col + 3)!
			right: parse_template_expr_node(right, line, node_col + 3)!
		}
	}
	if trimmed.starts_with('contains|') {
		left, right := split_condition_args(trimmed[9..])
		return TemplateConditionNode{
			kind: .expr
			expr: TemplateExprNode{
				kind: .call
				name: 'contains'
				args: [
					parse_template_expr_node(left, line, node_col + 9)!,
					parse_template_expr_node(right, line, node_col + 9)!,
				]
				raw:  trimmed
				line: line
				col:  node_col
			}
		}
	}
	if trimmed.starts_with('in|') {
		left, right := split_condition_args(trimmed[3..])
		return TemplateConditionNode{
			kind: .expr
			expr: TemplateExprNode{
				kind: .call
				name: 'in'
				args: [
					parse_template_expr_node(left, line, node_col + 3)!,
					parse_template_expr_node(right, line, node_col + 3)!,
				]
				raw:  trimmed
				line: line
				col:  node_col
			}
		}
	}
	if trimmed.starts_with('not_in|') {
		left, right := split_condition_args(trimmed[7..])
		return TemplateConditionNode{
			kind: .not
			children: [TemplateConditionNode{
				kind: .expr
				expr: TemplateExprNode{
					kind: .call
					name: 'in'
					args: [
						parse_template_expr_node(left, line, node_col + 7)!,
						parse_template_expr_node(right, line, node_col + 7)!,
					]
					raw:  trimmed
					line: line
					col:  node_col
				}
			}]
		}
	}
	if trimmed.starts_with('empty|') {
		return TemplateConditionNode{
			kind: .expr
			expr: TemplateExprNode{
				kind: .call
				name: 'empty'
				args: [parse_template_expr_node(trimmed[6..], line, node_col + 6)!]
				raw:  trimmed
				line: line
				col:  node_col
			}
		}
	}
	if trimmed.starts_with('not_empty|') {
		return TemplateConditionNode{
			kind: .not
			children: [TemplateConditionNode{
				kind: .expr
				expr: TemplateExprNode{
					kind: .call
					name: 'empty'
					args: [parse_template_expr_node(trimmed[10..], line, node_col + 10)!]
					raw:  trimmed
					line: line
					col:  node_col
				}
			}]
		}
	}
	return parse_template_condition_node(trimmed)
}

fn (view &VSlimView) eval_template_condition_node(node TemplateConditionNode, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, template_path string) bool {
	match node.kind {
		.expr {
			value := view.eval_template_expr_node(node.expr, scalars, lists, objects, template_path, 0, 0)
			return template_expr_value_truthy(value)
		}
		.not {
			if node.children.len == 0 {
				return false
			}
			return !view.eval_template_condition_node(node.children[0], scalars, lists, objects, template_path)
		}
		.and {
			for child in node.children {
				if !view.eval_template_condition_node(child, scalars, lists, objects, template_path) {
					return false
				}
			}
			return true
		}
		.or {
			for child in node.children {
				if view.eval_template_condition_node(child, scalars, lists, objects, template_path) {
					return true
				}
			}
			return false
		}
		.compare {
			left := view.eval_template_expr_node(node.left, scalars, lists, objects, template_path, 0, 0)
			right := view.eval_template_expr_node(node.right, scalars, lists, objects, template_path, 0, 0)
			return template_compare_expr_values(left, right, node.op)
		}
	}
}

fn parse_template_condition_node(raw string) !TemplateConditionNode {
	expr := strip_wrapping_template_condition_parens(raw.trim_space())
	if expr == '' {
		return error('empty condition')
	}
	if parts := split_template_expr_binary(expr, '||') {
		mut children := []TemplateConditionNode{cap: parts.len}
		for part in parts {
			children << parse_template_condition_node(part)!
		}
		return TemplateConditionNode{
			kind: .or
			children: children
		}
	}
	if parts := split_template_expr_binary(expr, '&&') {
		mut children := []TemplateConditionNode{cap: parts.len}
		for part in parts {
			children << parse_template_condition_node(part)!
		}
		return TemplateConditionNode{
			kind: .and
			children: children
		}
	}
	if expr.starts_with('!') {
		return TemplateConditionNode{
			kind: .not
			children: [parse_template_condition_node(expr[1..])!]
		}
	}
	for op in ['==', '!=', '>=', '<=', '>', '<'] {
		if pos := find_template_condition_operator(expr, op) {
			left_raw := expr[..pos].trim_space()
			right_raw := expr[pos + op.len..].trim_space()
			if left_raw == '' || right_raw == '' {
				return error('invalid compare expression')
			}
			return TemplateConditionNode{
				kind: .compare
				op: op
				left: parse_template_expr_node(left_raw, 0, 1)!
				right: parse_template_expr_node(right_raw, 0, 1)!
			}
		}
	}
	return TemplateConditionNode{
		kind: .expr
		expr: parse_template_expr_node(expr, 0, 1)!
	}
}

fn find_template_condition_operator(raw string, op string) ?int {
	mut quote := u8(0)
	mut paren_depth := 0
	for i := 0; i < raw.len - op.len + 1; i++ {
		ch := raw[i]
		if quote == 0 && (ch == `'` || ch == `"`) {
			quote = ch
			continue
		}
		if quote != 0 && ch == quote {
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
		if quote == 0 && paren_depth == 0 && raw[i..].starts_with(op) {
			return i
		}
	}
	return none
}

fn split_template_expr_binary(raw string, op string) ?[]string {
	mut parts := []string{}
	mut quote := u8(0)
	mut paren_depth := 0
	mut start := 0
	for i := 0; i < raw.len - op.len + 1; i++ {
		ch := raw[i]
		if quote == 0 && (ch == `'` || ch == `"`) {
			quote = ch
			continue
		}
		if quote != 0 && ch == quote {
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
		if quote == 0 && paren_depth == 0 && raw[i..].starts_with(op) {
			parts << raw[start..i].trim_space()
			start = i + op.len
			i += op.len - 1
		}
	}
	if parts.len == 0 {
		return none
	}
	parts << raw[start..].trim_space()
	return parts.filter(it != '')
}

fn strip_wrapping_template_condition_parens(raw string) string {
	mut current := raw.trim_space()
	for current.starts_with('(') && current.ends_with(')') {
		if matches_wrapping_template_condition_parens(current) {
			current = current[1..current.len - 1].trim_space()
		} else {
			break
		}
	}
	return current
}

fn matches_wrapping_template_condition_parens(raw string) bool {
	if raw.len < 2 || raw[0] != `(` || raw[raw.len - 1] != `)` {
		return false
	}
	mut quote := u8(0)
	mut paren_depth := 0
	for i := 0; i < raw.len; i++ {
		ch := raw[i]
		if quote == 0 && (ch == `'` || ch == `"`) {
			quote = ch
			continue
		}
		if quote != 0 && ch == quote {
			quote = 0
			continue
		}
		if quote == 0 && ch == `(` {
			paren_depth++
		} else if quote == 0 && ch == `)` {
			paren_depth--
			if paren_depth == 0 && i < raw.len - 1 {
				return false
			}
		}
	}
	return paren_depth == 0
}

fn template_expr_value_truthy(value TemplateExprValue) bool {
	match value.kind {
		.list {
			return value.list.len > 0
		}
		.map {
			return value.map_path != ''
		}
		.object {
			return value.object.is_valid() && !value.object.is_null() && !value.object.is_undef()
		}
		.scalar {
			match value.explicit_type {
				'null' {
					return false
				}
				'bool' {
					return parse_template_boolish_value(value.scalar) or { false }
				}
				'int', 'float' {
					return value.scalar.trim_space() !in ['', '0', '0.0']
				}
				else {
					return is_truthy_template_value(value.scalar)
				}
			}
		}
	}
}

fn template_compare_expr_values(left TemplateExprValue, right TemplateExprValue, op string) bool {
	if op == '==' {
		return template_compare_equal_values(template_expr_value_string(left), template_expr_value_string(right))
	}
	if op == '!=' {
		return !template_compare_equal_values(template_expr_value_string(left), template_expr_value_string(right))
	}
	left_raw := template_expr_value_string(left).trim_space()
	right_raw := template_expr_value_string(right).trim_space()
	if left_num := template_expr_value_number(left) {
		if right_num := template_expr_value_number(right) {
			return match op {
				'>' { left_num > right_num }
				'<' { left_num < right_num }
				'>=' { left_num >= right_num }
				'<=' { left_num <= right_num }
				else { false }
			}
		}
	}
	return match op {
		'>' { left_raw > right_raw }
		'<' { left_raw < right_raw }
		'>=' { left_raw >= right_raw }
		'<=' { left_raw <= right_raw }
		else { false }
	}
}

fn template_expr_value_number(value TemplateExprValue) ?f64 {
	if value.kind != .scalar {
		return none
	}
	trimmed := value.scalar.trim_space()
	if trimmed == '' {
		return none
	}
	if value.explicit_type == 'int' || value.explicit_type == 'float' || is_numeric_template_value(trimmed) {
		return trimmed.f64()
	}
	return none
}

fn template_expr_value_cast(value TemplateExprValue, explicit_type string) TemplateExprValue {
	match explicit_type {
		'int' {
			raw := template_expr_value_string(value).trim_space()
			if raw == '' {
				return new_template_expr_scalar_typed('0', 'int')
			}
			if boolish := parse_template_boolish_value(raw) {
				return new_template_expr_scalar_typed(if boolish { '1' } else { '0' }, 'int')
			}
			if is_numeric_template_value(raw) {
				return new_template_expr_scalar_typed('${raw.i64()}', 'int')
			}
			return new_template_expr_scalar_typed('0', 'int')
		}
		'float' {
			raw := template_expr_value_string(value).trim_space()
			if raw == '' {
				return new_template_expr_scalar_typed('0', 'float')
			}
			if boolish := parse_template_boolish_value(raw) {
				return new_template_expr_scalar_typed(if boolish { '1' } else { '0' }, 'float')
			}
			if is_numeric_template_value(raw) {
				return new_template_expr_scalar_typed('${raw.f64()}', 'float')
			}
			return new_template_expr_scalar_typed('0', 'float')
		}
		'bool' {
			raw := template_expr_value_string(value).trim_space()
			if raw == '' || is_template_null_literal(raw) {
				return new_template_expr_scalar_typed('false', 'bool')
			}
			if boolish := parse_template_boolish_value(raw) {
				return new_template_expr_scalar_typed(if boolish { 'true' } else { 'false' }, 'bool')
			}
			if is_numeric_template_value(raw) {
				return new_template_expr_scalar_typed(if math.abs(raw.f64()) > 1e-9 { 'true' } else { 'false' }, 'bool')
			}
			return new_template_expr_scalar_typed(if is_truthy_template_value(raw) { 'true' } else { 'false' }, 'bool')
		}
		'string' {
			raw := template_expr_value_string(value).trim_space()
			if raw == '' || is_template_null_literal(raw) {
				return new_template_expr_scalar_typed('', 'string')
			}
			if boolish := parse_template_boolish_value(raw) {
				return new_template_expr_scalar_typed(if boolish { '1' } else { '0' }, 'string')
			}
			return new_template_expr_scalar_typed(raw, 'string')
		}
		else {
			return value
		}
	}
}

fn template_has_list_key(path string, lists map[string][]string) bool {
	key := path.trim_space()
	if key == '' {
		return false
	}
	if key in lists {
		return true
	}
	return alias_template_key(key) in lists
}

fn split_condition_args(raw string) (string, string) {
	parts := split_template_expr_args(raw)
	if parts.len == 0 {
		return '', ''
	}
	left := parts[0].trim_space()
	right := if parts.len >= 2 { parts[1].trim_space() } else { '' }
	return left, right
}

fn debug_template_error(kind string, template_path string, token string, line int, col int) string {
	if !is_view_debug_enabled() {
		return ''
	}
	mut suffix := ''
	if line > 0 {
		suffix += ' line=${line}'
	}
	if col > 0 {
		suffix += ' col=${col}'
	}
	return '[vslim.${kind} template=${template_path} token=${token}${suffix}]'
}

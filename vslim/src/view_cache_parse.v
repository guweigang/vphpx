module main

import os
import vphp

__global (
	vslim_view_cache_inited         bool
	vslim_view_cache_default        bool
	vslim_template_source_cache_map map[string]string
	vslim_template_program_cache_map map[string]TemplateProgram
)


fn default_view_cache_enabled() bool {
	unsafe {
		if !vslim_view_cache_inited {
			mut raw := os.getenv('VSLIM_VIEW_CACHE').trim_space().to_lower()
			if raw.starts_with('toml.any(') && raw.ends_with(')') && raw.len > 10 {
				raw = raw[9..raw.len - 1].trim_space().trim('"\'').to_lower()
			}
			vslim_view_cache_default = raw in ['1', 'true', 'yes', 'on']
			vslim_view_cache_inited = true
		}
		return vslim_view_cache_default
	}
}

fn clear_template_source_cache() {
	unsafe {
		vslim_template_source_cache_map = map[string]string{}
		vslim_template_program_cache_map = map[string]TemplateProgram{}
	}
}

fn ensure_view_helper_map(mut helpers map[string]vphp.PersistentOwnedZBox) {
	if helpers.len == 0 {
		helpers = map[string]vphp.PersistentOwnedZBox{}
	}
}

fn clone_view_helper_map(src map[string]vphp.PersistentOwnedZBox) map[string]vphp.PersistentOwnedZBox {
	mut out := map[string]vphp.PersistentOwnedZBox{}
	for key, handler in src {
		out[key] = handler.clone_persistent_owned()
	}
	return out
}

fn release_view_helper(mut handler vphp.PersistentOwnedZBox) {
	if !handler.is_valid() {
		return
	}
	unsafe {
		mut owned := handler
		owned.release()
	}
}

fn (view &VSlimView) read_template_source(path string) !string {
	if path.trim_space() == '' {
		return error('empty template path')
	}
	if !view.cache_enabled() {
		return os.read_file(path)
	}
	unsafe {
		if path in vslim_template_source_cache_map {
			return vslim_template_source_cache_map[path]
		}
	}
	source := os.read_file(path)!
	unsafe {
		vslim_template_source_cache_map[path] = source
	}
	return source
}

fn (view &VSlimView) read_template_program(path string) !TemplateProgram {
	if path.trim_space() == '' {
		return error('empty template path')
	}
	if view.cache_enabled() {
		unsafe {
			if path in vslim_template_program_cache_map {
				return vslim_template_program_cache_map[path]
			}
		}
	}
	source := view.read_template_source(path)!
	program := compile_template_program(source)
	if view.cache_enabled() {
		unsafe {
			vslim_template_program_cache_map[path] = program
		}
	}
	return program
}

fn compile_template_program(source string) TemplateProgram {
	mut parser := TemplateParser{
		tokens: tokenize_template_source(source)
	}
	nodes, _ := parser.parse_until([])
	return TemplateProgram{
		nodes: nodes
	}
}

fn (mut parser TemplateParser) parse_until(stop_tokens []string) ([]TemplateNode, string) {
	mut nodes := []TemplateNode{}
	for parser.pos < parser.tokens.len {
		current := parser.tokens[parser.pos]
		parser.pos++
		if current.kind == .text {
			nodes << TemplateNode{
				kind:  .text
				value: current.value
				line:  current.line
				col:   current.col
			}
			continue
		}
		token_line, token_col := current.line, current.col
		token_raw := current.value
		token := token_raw.trim_space()
		if token in stop_tokens {
			return nodes, token
		}
		if token.starts_with('if:') {
			condition := token[3..].trim_space()
			true_children, stop := parser.parse_until(['else', '/if'])
			mut false_children := []TemplateNode{}
			if stop == 'else' {
				false_children, _ = parser.parse_until(['/if'])
			}
			mut cond_ast := TemplateConditionNode{}
			mut has_cond_ast := false
			if parsed := parse_template_condition_syntax(condition, token_line, token_col + 3) {
				cond_ast = parsed
				has_cond_ast = true
			}
			nodes << TemplateNode{
				kind:          .if_block
				name:          condition
				children:      true_children
				else_children: false_children
				cond_ast:      cond_ast
				has_cond_ast:  has_cond_ast
				line:          token_line
				col:           token_col
			}
			continue
		}
		if token.starts_with('for:') {
			loop_key := token[4..].trim_space()
			children, _ := parser.parse_until(['/for'])
			nodes << TemplateNode{
				kind:     .for_block
				name:     loop_key
				children: children
				line:     token_line
				col:      token_col
			}
			continue
		}
		if token.starts_with('fill:') {
			slot_name := token[5..].trim_space()
			children, _ := parser.parse_until(['/fill'])
			nodes << TemplateNode{
				kind:     .fill_block
				name:     slot_name
				children: children
				line:     token_line
				col:      token_col
			}
			continue
		}
		nodes << build_template_token_node(token_raw, token_line, token_col)
	}
	return nodes, ''
}

fn build_template_token_node(token_raw string, line int, col int) TemplateNode {
	token := token_raw.trim_space()
	left_trimmed := trim_left_template_space(token_raw)
	if token.starts_with('raw:') {
		return TemplateNode{
			kind: .raw_value
			name: token[4..].trim_space()
			line: line
			col:  col
		}
	}
	if token.starts_with('include:') {
		include_name, include_args := split_include_payload(token[8..])
		parsed_args, has_include_args := parse_template_include_args(include_args, line, col)
		return TemplateNode{
			kind:             .include_tpl
			name:             include_name
			value:            include_args
			include_args:     parsed_args
			has_include_args: has_include_args
			line:             line
			col:              col
		}
	}
	if token.starts_with('asset:') {
		return TemplateNode{
			kind: .asset
			name: token[6..].trim_space()
			line: line
			col:  col
		}
	}
	if token.starts_with('slot:') {
		slot_name, fallback := split_helper_payload(token[5..])
		return TemplateNode{
			kind:  .slot
			name:  slot_name
			value: fallback
			line:  line
			col:   col
		}
	}
	if left_trimmed.starts_with('call_raw:') {
		payload := left_trimmed['call_raw:'.len..]
		helper_name, helper_args := split_helper_payload(payload)
		arg_asts, has_arg_asts := parse_template_helper_arg_nodes(helper_args, line, col)
		return TemplateNode{
			kind:         .call_helper_raw
			name:         helper_name
			value:        helper_args
			arg_asts:     arg_asts
			has_arg_asts: has_arg_asts
			line:         line
			col:          col
		}
	}
	if left_trimmed.starts_with('call:') {
		payload := left_trimmed['call:'.len..]
		helper_name, helper_args := split_helper_payload(payload)
		arg_asts, has_arg_asts := parse_template_helper_arg_nodes(helper_args, line, col)
		return TemplateNode{
			kind:         .call_helper
			name:         helper_name
			value:        helper_args
			arg_asts:     arg_asts
			has_arg_asts: has_arg_asts
			line:         line
			col:          col
		}
	}
	if looks_like_template_expression(token) {
		mut expr_ast := TemplateExprNode{}
		mut has_expr_ast := false
		if parsed := parse_template_expr_node(token, line, col) {
			expr_ast = parsed
			has_expr_ast = true
		}
		return TemplateNode{
			kind:         .expression
			value:        token
			expr_ast:     expr_ast
			has_expr_ast: has_expr_ast
			line:         line
			col:          col
		}
	}
	return TemplateNode{
		kind: .value
		name: token
		line: line
		col:  col
	}
}

fn tokenize_template_source(source string) []TemplateToken {
	mut tokens := []TemplateToken{}
	mut pos := 0
	mut line := 1
	mut col := 1
	for pos < source.len {
		next_rel := source[pos..].index('{{') or {
			if pos < source.len {
				tokens << TemplateToken{
					kind:  .text
					value: source[pos..]
					line:  line
					col:   col
				}
			}
			break
		}
		start := pos + next_rel
		if start > pos {
			tokens << TemplateToken{
				kind:  .text
				value: source[pos..start]
				line:  line
				col:   col
			}
			line, col = advance_template_position(source[pos..start], line, col)
		}
		end_rel := source[start..].index('}}') or {
			tokens << TemplateToken{
				kind:  .text
				value: source[start..]
				line:  line
				col:   col
			}
			break
		}
		tag_line := line
		tag_col := col
		end := start + end_rel + 2
		token_raw := source[start + 2..end - 2]
		tokens << TemplateToken{
			kind:  .tag
			value: token_raw
			line:  tag_line
			col:   tag_col
		}
		line, col = advance_template_position(source[start..end], line, col)
		pos = end
	}
	return tokens
}

fn advance_template_position(segment string, line int, col int) (int, int) {
	mut next_line := line
	mut next_col := col
	for ch in segment {
		if ch == `\n` {
			next_line++
			next_col = 1
		} else {
			next_col++
		}
	}
	return next_line, next_col
}

fn trim_left_template_space(input string) string {
	mut start := 0
	for start < input.len && input[start].is_space() {
		start++
	}
	return input[start..]
}

fn split_helper_payload(payload string) (string, string) {
	trimmed := payload.trim_space()
	if !trimmed.contains('|') {
		return trimmed, ''
	}
	return trimmed.all_before('|').trim_space(), trimmed.all_after('|')
}

fn split_include_payload(payload string) (string, string) {
	parts := split_template_top_level_segments(payload, [u8(`|`)])
	if parts.len == 0 {
		return '', ''
	}
	template_name := parts[0].trim_space()
	if parts.len == 1 {
		return template_name, ''
	}
	return template_name, parts[1..].join('|')
}

fn parse_template_include_args(raw string, line int, col int) ([]TemplateIncludeArg, bool) {
	if raw.trim_space() == '' {
		return []TemplateIncludeArg{}, true
	}
	parts := split_include_assignments(raw)
	if parts.len == 0 {
		return []TemplateIncludeArg{}, false
	}
	mut out := []TemplateIncludeArg{cap: parts.len}
	for segment in parts {
		assign := segment.trim_space()
		if assign == '' || !assign.contains('=') {
			return []TemplateIncludeArg{}, false
		}
		key := assign.all_before('=').trim_space()
		value_expr := assign.all_after('=').trim_space()
		if key == '' {
			return []TemplateIncludeArg{}, false
		}
		expr := parse_template_expr_node(value_expr, line, col) or {
			return []TemplateIncludeArg{}, false
		}
		out << TemplateIncludeArg{
			name: key
			expr: expr
		}
	}
	return out, true
}

fn looks_like_template_expression(token string) bool {
	trimmed := token.trim_space()
	if trimmed == '' {
		return false
	}
	if parse_template_expr_method_call(trimmed) != none {
		return true
	}
	if parse_template_expr_call(trimmed) != none {
		return true
	}
	return split_template_expr_pipes(trimmed).len > 1
}

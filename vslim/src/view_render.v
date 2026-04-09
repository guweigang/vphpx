module main

import strings
import vphp

fn (view &VSlimView) render_template_path_with_slots(path string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, depth int, slots map[string]string) !string {
	if depth > 8 {
		return ''
	}
	program := view.read_template_program(path)!
	return view.render_nodes(program.nodes, scalars, lists, objects, depth, slots, path)
}

@[php_method]
pub fn (view &VSlimView) render_response(template string, data vphp.RequestBorrowedZBox) &VSlimResponse {
	body := view.render(template, data)
	return &VSlimResponse{
		status: 200
		body: body.clone()
		content_type: 'text/html; charset=utf-8'
		headers: {
			'content-type': 'text/html; charset=utf-8'
		}
	}
}

@[php_method]
pub fn (view &VSlimView) render_response_with_layout(template string, layout string, data vphp.RequestBorrowedZBox) &VSlimResponse {
	body := view.render_with_layout(template, layout, data)
	return &VSlimResponse{
		status: 200
		body: body.clone()
		content_type: 'text/html; charset=utf-8'
		headers: {
			'content-type': 'text/html; charset=utf-8'
		}
	}
}

fn (view &VSlimView) render_source(source string, scalars map[string]string, lists map[string][]string, depth int) string {
	program := compile_template_program(source)
	return view.render_nodes(program.nodes, scalars, lists, map[string]vphp.RequestOwnedZBox{}, depth, map[string]string{}, '<inline>')
}

fn (view &VSlimView) render_nodes(nodes []TemplateNode, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, depth int, slots map[string]string, template_path string) string {
	mut out := strings.new_builder(nodes.len * 16)
	for node in nodes {
		match node.kind {
			.text {
				out.write_string(node.value)
			}
			.value {
				out.write_string(escape_html_text(template_scalar_value_with_lists(node.name, scalars, lists)))
			}
			.expression {
				value := if node.has_expr_ast {
					view.eval_template_expr_node(node.expr_ast, scalars, lists, objects, template_path, node.line, node.col)
				} else {
					view.eval_template_expression(node.value, scalars, lists, objects, template_path, node.line, node.col)
				}
				out.write_string(escape_html_text(template_expr_value_string(value)))
			}
			.raw_value {
				out.write_string(template_scalar_value_with_lists(node.name, scalars, lists))
			}
			.include_tpl {
				partial := view.render_include_node(node, scalars, lists, objects, depth, slots, template_path)
				out.write_string(partial)
			}
			.asset {
				value := view.eval_template_expr_callable('asset', [
					new_template_expr_scalar(node.name),
				], scalars, lists, objects, template_path, node.line, node.col)
				out.write_string(template_expr_value_string(value))
			}
			.slot {
				if node.name in slots {
					out.write_string(slots[node.name])
				} else {
					out.write_string(node.value)
				}
			}
			.call_helper {
				mut args := []TemplateExprValue{cap: node.arg_asts.len}
				for arg in node.arg_asts {
					args << view.eval_template_expr_node(arg, scalars, lists, objects, template_path, node.line, node.col)
				}
				out.write_string(escape_html_text(view.invoke_template_helper_values(node.name, args, scalars, lists, template_path, node.line, node.col)))
			}
			.call_helper_raw {
				mut args := []TemplateExprValue{cap: node.arg_asts.len}
				for arg in node.arg_asts {
					args << view.eval_template_expr_node(arg, scalars, lists, objects, template_path, node.line, node.col)
				}
				out.write_string(view.invoke_template_helper_values(node.name, args, scalars, lists, template_path, node.line, node.col))
			}
			.if_block {
				truthy := view.eval_template_condition_node(node.cond_ast, scalars, lists, objects, template_path)
				if truthy {
					out.write_string(view.render_nodes(node.children, scalars, lists, objects, depth, slots, template_path))
				} else {
					out.write_string(view.render_nodes(node.else_children, scalars, lists, objects, depth, slots, template_path))
				}
			}
			.for_block {
				out.write_string(view.render_for_node(node, scalars, lists, objects, depth, slots, template_path))
			}
			.fill_block {
				out.write_string(view.render_nodes(node.children, scalars, lists, objects, depth, slots, template_path))
			}
		}
	}
	return out.str()
}

fn (view &VSlimView) render_template_content_and_slots(nodes []TemplateNode, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, depth int, template_path string) (string, map[string]string) {
	mut content_nodes := []TemplateNode{}
	mut slots := map[string]string{}
	for node in nodes {
		if node.kind != .fill_block {
			content_nodes << node
			continue
		}
		slot_name := node.name.trim_space()
		if slot_name == '' {
			continue
		}
		rendered := view.render_nodes(node.children, scalars, lists, objects, depth, slots, template_path)
		if slot_name in slots {
			slots[slot_name] += rendered
		} else {
			slots[slot_name] = rendered
		}
	}
	return view.render_nodes(content_nodes, scalars, lists, objects, depth, slots, template_path), slots
}

fn (view &VSlimView) render_include_node(node TemplateNode, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, depth int, slots map[string]string, template_path string) string {
	mut merged_scalars := scalars.clone()
	mut merged_lists := clone_template_lists(lists)
	mut merged_objects := clone_template_objects(objects)
	apply_include_arg_nodes(view, node.include_args, scalars, lists, objects, template_path, mut merged_scalars, mut merged_lists, mut merged_objects)
	return view.render_template_path_with_slots(view.resolve_template_path(node.name), merged_scalars, merged_lists, merged_objects, depth + 1, slots) or {
		debug_template_error('include.missing', template_path, node.name, node.line, node.col)
	}
}

fn apply_include_arg_nodes(view &VSlimView, args []TemplateIncludeArg, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, template_path string, mut out_scalars map[string]string, mut out_lists map[string][]string, mut out_objects map[string]vphp.RequestOwnedZBox) {
	for arg in args {
		key := arg.name.trim_space()
		if key == '' {
			continue
		}
		value := view.eval_template_expr_node(arg.expr, scalars, lists, objects, template_path, arg.expr.line, arg.expr.col)
		match value.kind {
			.list {
				out_lists[key] = value.list.clone()
				out_scalars[key] = value.list.join(',')
			}
			.map {
				copy_template_branch(value.map_path, key, scalars, lists, objects, mut out_scalars, mut out_lists, mut out_objects)
			}
			.object {
				out_objects[key] = value.object.clone_request_owned()
				out_scalars[key] = value.object.to_string()
			}
			.scalar {
				out_scalars[key] = template_expr_value_string(value)
			}
		}
	}
}

fn (view &VSlimView) render_for_node(node TemplateNode, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZBox, depth int, slots map[string]string, template_path string) string {
	mut out := strings.new_builder(64)
	items := if node.name in lists {
		unsafe { lists[node.name].clone() }
	} else {
		parse_for_items(template_scalar_value_with_lists(node.name, scalars, lists))
	}
	for idx, item in items {
		mut local_scalars := scalars.clone()
		local_scalars['index'] = '${idx}'
		local_scalars['item'] = item
		if item != '' && is_numeric_path_segment(item) {
			populate_indexed_item_fields(node.name, item, scalars, mut local_scalars)
		}
		out.write_string(view.render_nodes(node.children, local_scalars, lists, objects, depth, slots, template_path))
	}
	return out.str()
}

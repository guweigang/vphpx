import rt

fn render_block_core_widget_group(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var__sidebar_being_rendered := rt.new_null()
	// unsupported statement: Stmt_Global
	if var_wp_registered_sidebars.array_isset(var__sidebar_being_rendered) {
		mut var_before_title :=
			var_wp_registered_sidebars.array_get(var__sidebar_being_rendered).array_get('before_title')
		mut var_after_title :=
			var_wp_registered_sidebars.array_get(var__sidebar_being_rendered).array_get('after_title')
	} else {
		var_before_title = rt.new_string(rt.new_string('<h2 class="widget-title">'))
		var_after_title = rt.new_string(rt.new_string('</h2>'))
	}
	mut var_html := ''
	if !(!rt.is_true(var_attributes.array_get('title'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	{
		mut iter_1 := rt.get_property(var_block, 'inner_blocks').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	return var_html
}

fn register_block_core_widget_group() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/widget-group',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_widget_group' },
		])])
}

fn note_sidebar_being_rendered(var_index rt.PhpVal) {
	// unsupported statement: Stmt_Global
	mut var__sidebar_being_rendered := var_index
}

fn discard_sidebar_being_rendered() {
	mut var__sidebar_being_rendered := rt.new_null()
	// unsupported statement: Stmt_Global
	var__sidebar_being_rendered = rt.new_null()
}

pub fn init_wp_includes_blocks_widget_group_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_widget_group')])
	rt.call_function('add_action', [rt.new_string('dynamic_sidebar_before'),
		rt.new_string('note_sidebar_being_rendered')])
	rt.call_function('add_action', [rt.new_string('dynamic_sidebar_after'),
		rt.new_string('discard_sidebar_being_rendered')])
}

import rt



pub fn init_wp_content_plugins_woocommerce_templates_order_star_rating_php() {
	mut var_id_prefix := rt.new_null()
	mut var_selected := rt.new_null()
	mut var_labels := rt.new_null()
	mut var_label_id := rt.new_null()
	mut var_name := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_caption_id := rt.new_string((var_id_prefix).str() + '-caption')
	mut var_initial_caption := if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_selected, rt.new_int(0))) && var_labels.array_isset(var_selected))) { var_labels.array_get(var_selected) } else { rt.new_string('') }
	mut var_reversed := rt.call_function('array_reverse', [var_labels.dup(), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_label_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_caption_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_reversed.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_value := item_1.key
			// unsupported statement: Stmt_InlineHTML
			mut var_input_id := rt.new_string((var_id_prefix).str() + '-' + (var_value).str())
			mut var_checked := (rt.identical(var_value, var_selected)).to_bool()
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_input_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_name.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_label.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_bool(var_checked).dup()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_input_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('%1$d out of 5 stars: %2$s'), rt.new_string('woocommerce')]), // unsupported expression: Expr_Cast_Int, rt.call_function('esc_html', [var_label.dup()])])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_caption_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_initial_caption.dup()]))
	// unsupported statement: Stmt_InlineHTML
}

import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_order_notes_php() {
	mut var_notes := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_notes) {
		{
			mut iter_1 := var_notes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_note := item_1.val
				mut var_css_class := rt.create_array([rt.ArrayItem{ key: none, val: 'note' }])
				var_css_class.array_push(if rt.is_true(rt.get_property(var_note, 'customer_note')) { 'customer-note' } else { '' })
				var_css_class.array_push(if rt.is_true(rt.identical(rt.new_string('system'), rt.get_property(var_note, 'added_by'))) { 'system-note' } else { '' })
				var_css_class = rt.call_function('apply_filters', [rt.new_string('woocommerce_order_note_class'), rt.call_function('array_filter', [var_css_class.dup()]), var_note.dup()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('absint', [rt.get_property(var_note, 'id')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_css_class.dup()])]))
				// unsupported statement: Stmt_InlineHTML
				mut var_content := rt.call_function('wp_kses_post', [rt.get_property(var_note, 'content')])
				var_content = rt.call_function('wc_wptexturize_order_note', [var_content.dup()])
				rt.echo_val(rt.call_function('wpautop', [var_content.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.call_method(rt.get_property(var_note, 'date_created'), 'date', [rt.new_string('Y-m-d H:i:s')])]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s'), rt.new_string('woocommerce')]), rt.call_method(rt.get_property(var_note, 'date_created'), 'date_i18n', [rt.call_function('wc_date_format', []rt.PhpVal{})]), rt.call_method(rt.get_property(var_note, 'date_created'), 'date_i18n', [rt.call_function('wc_time_format', []rt.PhpVal{})])])]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [' ' + (rt.call_function('__', [rt.new_string('by %s'), rt.new_string('woocommerce')])).str(), rt.get_property(var_note, 'added_by')])]))
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Delete note'), rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
		}
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('There are no notes yet.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

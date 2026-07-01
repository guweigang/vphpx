import rt



pub fn init_wp_content_plugins_woocommerce_templates_loop_result_count_php() {
	mut var_orderedby := rt.new_null()
	mut var_total := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_current := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	print(if !rt.is_true(var_orderedby) || 1 == var_total.dup().to_i64() { '' } else { 'data-is-sorted-by="true"' })
	// unsupported statement: Stmt_InlineHTML
	if 1 == var_total.dup().to_i64() {
		rt.call_function('_e', [rt.new_string('Showing the single result'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_total, var_per_page)) || rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_per_page)))) {
		mut var_orderedby_placeholder := if !rt.is_true(var_orderedby) { '%2$s' } else { '<span class="screen-reader-text">%2$s</span>' }
		rt.call_function('printf', [(rt.call_function('_n', [rt.new_string('Showing all %1$d result'), rt.new_string('Showing all %1$d results'), var_total.dup(), rt.new_string('woocommerce')])).str() + var_orderedby_placeholder, var_total.dup(), rt.call_function('esc_html', [var_orderedby.dup()])])
	} else {
		mut var_first := rt.add(rt.sub(rt.mul(var_per_page, var_current), var_per_page), rt.new_int(1))
		mut var_last := rt.call_function('min', [var_total.dup(), rt.mul(var_per_page, var_current)])
		var_orderedby_placeholder = if !rt.is_true(var_orderedby) { '%4$s' } else { '<span class="screen-reader-text">%4$s</span>' }
		rt.call_function('printf', [(rt.call_function('_nx', [rt.new_string('Showing %1$d&ndash;%2$d of %3$d result'), rt.new_string('Showing %1$d&ndash;%2$d of %3$d results'), var_total.dup(), rt.new_string('with first and last result'), rt.new_string('woocommerce')])).str() + var_orderedby_placeholder, var_first.dup(), var_last.dup(), var_total.dup(), rt.call_function('esc_html', [var_orderedby.dup()])])
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}

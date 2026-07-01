import rt



pub fn init_wp_content_plugins_woocommerce_templates_global_breadcrumb_php() {
	mut var_breadcrumb := rt.new_null()
	mut var_wrap_before := rt.new_null()
	mut var_before := rt.new_null()
	mut var_after := rt.new_null()
	mut var_delimiter := rt.new_null()
	mut var_wrap_after := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if !(!rt.is_true(var_breadcrumb)) {
		rt.echo_val(var_wrap_before)
		{
			mut iter_1 := var_breadcrumb.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_crumb := item_1.val
				mut var_key := item_1.key
				rt.echo_val(var_before)
				if rt.is_true(rt.new_bool(!(!rt.is_true(var_crumb.array_get(1))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					print('<a href="' + (rt.call_function('esc_url', [var_crumb.array_get(1)])).str() + '">' + (rt.call_function('esc_html', [var_crumb.array_get(0)])).str() + '</a>')
				} else {
					rt.echo_val(rt.call_function('esc_html', [var_crumb.array_get(0)]))
				}
				rt.echo_val(var_after)
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.echo_val(var_delimiter)
				}
			}
		}
		rt.echo_val(var_wrap_after)
	}
}

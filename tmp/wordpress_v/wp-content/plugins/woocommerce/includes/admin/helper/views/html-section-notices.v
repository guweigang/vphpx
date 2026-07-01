import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_views_html_section_notices_php() {
	mut var_notices := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_notices.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_notice := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('sanitize_html_class', [var_notice.array_get('type')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wpautop', [var_notice.array_get('message')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
}

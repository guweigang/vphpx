import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_tabs_description_php() {
	mut var_post := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	mut var_heading := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_description_heading'), rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_heading) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_content', []rt.PhpVal{})
}

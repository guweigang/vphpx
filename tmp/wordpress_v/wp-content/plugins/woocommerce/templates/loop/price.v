import rt



pub fn init_wp_content_plugins_woocommerce_templates_loop_price_php() {
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(mut var_price_html := rt.call_method(var_product, 'get_price_html', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_price_html)
		// unsupported statement: Stmt_InlineHTML
	}
}

import rt



pub fn init_wp_content_plugins_woocommerce_templates_content_single_product_php() {
	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	rt.call_function('do_action', [rt.new_string('woocommerce_before_single_product')])
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		rt.echo_val(rt.call_function('get_the_password_form', []rt.PhpVal{}))
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_product_class', [rt.new_string(''), var_product.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_single_product_summary')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_single_product_summary')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_single_product_summary')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_single_product')])
}

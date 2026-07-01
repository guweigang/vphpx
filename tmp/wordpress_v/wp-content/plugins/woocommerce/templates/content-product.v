import rt



pub fn init_wp_content_plugins_woocommerce_templates_content_product_php() {
	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.dup(), Class_WC_Product.class()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_product_class', [rt.new_string(''), var_product.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_shop_loop_item')])
	rt.call_function('do_action', [rt.new_string('woocommerce_before_shop_loop_item_title')])
	rt.call_function('do_action', [rt.new_string('woocommerce_shop_loop_item_title')])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_shop_loop_item_title')])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_shop_loop_item')])
	// unsupported statement: Stmt_InlineHTML
}

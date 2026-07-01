import rt

pub fn init_wp_content_plugins_woocommerce_templates_content_product_cat_php() {
	mut var_category := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_product_cat_class', [rt.new_string(''),
		var_category.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_subcategory'),
		var_category.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_before_subcategory_title'),
		var_category.dup()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_shop_loop_subcategory_title'),
		var_category.dup(),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_subcategory_title'),
		var_category.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_subcategory'),
		var_category.dup()])
	// unsupported statement: Stmt_InlineHTML
}

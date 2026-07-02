import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_category := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_product_cat_class', [rt.new_string(''),
		var_category.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_subcategory'),
		var_category.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_before_subcategory_title'),
		var_category.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_shop_loop_subcategory_title'),
		var_category.clone(),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_subcategory_title'),
		var_category.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_subcategory'),
		var_category.clone()])
	// unsupported statement: Stmt_InlineHTML
}

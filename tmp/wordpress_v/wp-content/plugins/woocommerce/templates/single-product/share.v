import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_share_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_share')])
	// unsupported statement: Stmt_Nop
}

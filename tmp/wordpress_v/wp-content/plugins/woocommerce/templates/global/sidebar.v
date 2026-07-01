import rt

pub fn init_wp_content_plugins_woocommerce_templates_global_sidebar_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('get_sidebar', [rt.new_string('shop')])
	// unsupported statement: Stmt_Nop
}

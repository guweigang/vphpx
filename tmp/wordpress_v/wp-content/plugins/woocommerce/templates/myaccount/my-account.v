import rt



pub fn init_wp_content_plugins_woocommerce_templates_myaccount_my_account_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_account_navigation')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_account_content')])
	// unsupported statement: Stmt_InlineHTML
}

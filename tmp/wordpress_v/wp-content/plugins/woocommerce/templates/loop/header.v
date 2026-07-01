import rt

pub fn init_wp_content_plugins_woocommerce_templates_loop_header_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_show_page_title'),
		rt.new_bool(true),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_page_title', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_archive_description')])
	// unsupported statement: Stmt_InlineHTML
}

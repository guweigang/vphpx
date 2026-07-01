import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_stock_php() {
	mut var_class := rt.new_null()
	mut var_availability := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_availability.dup()]))
	// unsupported statement: Stmt_InlineHTML
}

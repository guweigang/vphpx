import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_marketplace_suggestions_views_container_php() {
	mut var_context := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_context.dup()]))
	// unsupported statement: Stmt_InlineHTML
}

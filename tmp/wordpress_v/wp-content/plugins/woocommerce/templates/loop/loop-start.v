import rt

pub fn init_wp_content_plugins_woocommerce_templates_loop_loop_start_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_get_loop_prop', [rt.new_string('columns')]),
	]))
	// unsupported statement: Stmt_InlineHTML
}

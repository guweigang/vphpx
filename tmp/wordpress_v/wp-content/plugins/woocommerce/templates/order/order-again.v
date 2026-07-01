import rt



pub fn init_wp_content_plugins_woocommerce_templates_order_order_again_php() {
	mut var_order_again_url := rt.new_null()
	mut var_wp_button_class := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_order_again_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_wp_button_class.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order again'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

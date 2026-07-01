import rt

pub fn init_wp_content_plugins_woocommerce_patterns_related_products_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Related products'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}

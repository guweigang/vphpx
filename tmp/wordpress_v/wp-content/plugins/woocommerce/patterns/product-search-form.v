import rt

pub fn init_wp_content_plugins_woocommerce_patterns_product_search_form_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search products…'),
		rt.new_string('placeholder for search field'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search'),
		rt.new_string('button label of product search block'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}

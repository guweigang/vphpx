import rt

pub fn init_wp_content_plugins_woocommerce_patterns_no_products_found_filters_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('No results found'),
		rt.new_string('Message explaining that there are no products found'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('You can try'),
		rt.new_string("Used in sentence: You can try clearing any filters or head to our store's home."),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('clearing any filters'),
		rt.new_string("Used in sentence: You can try clearing any filters or head to our store's home."),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('or head to our'),
		rt.new_string("Used in sentence: You can try clearing any filters or head to our store's home."),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string("store's home"),
		rt.new_string("Used in sentence: You can try clearing any filters or head to our store's home."),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}
